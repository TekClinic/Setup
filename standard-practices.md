# Standard Practices

This document outlines standard practices to follow when building university-level open-source projects.
These (simplified) practices are based on experience in CNCF/RedHat open-source projects and are intended
to help students maintain high-quality projects that are easy to use and contribute to.

## Table of Contents
- [1. Project Structure/Architecture](#1-project-structure)
- [2. Documentation](#2-documentation)
- [3. Code Quality](#3-code-quality)
- [4. Git Practices](#4-git-practices)
---

## 1. Project Structure/Architecture

Projects should follow a standard structure/architecture that best serves the project's purpose.
There should practically never be a need to reinvent the wheel when it comes to project structure.

An example that is implemented in the TekClinic project is the API-Gateway-Microservice architecture:
The external world interacts with the API Gateway, which then routes requests to the appropriate Microservice.
A single API Gateway endpoint may invoke multiple Microservices to fulfill a request, and microservices may communicate with each other directly.

- API Gateway: the main entry point for all requests
- Frontend: the client-side application such as web or mobile
- Auth: the authentication service, typically served by Keycloak in this course
- Microservices: 
  - Each project domain is self-contained in its Microservice
  - Microservices are standalone and independent of each other
  - Typically communicate in gRPC or REST. In our course, gRPC is preferred
  - Each Microservice has its own database (in practice, they may have isolated schemas in a shared database)

In the above architecture, each module is maintained in its own repository. This allows for better separation of concerns
and makes it easier to manage the project. On the other hand, it leads to duplicated workflows and higher maintenance costs.
To minimize friction and conflicts between students, it is recommended to use the distributed repos approach.

---
## 2. Documentation

Documentation is crucial for the success of any project. It helps everyone in the stack of a project's lifecycle:
- Developers: understand the project's architecture, design, and implementation
- Users: understand how to use the project
- Contributors: understand how to contribute to the project

Documentation is implemented in several forms, all serving one or more of the above purposes:
### Repository Level
1. README.md: the main entry point for the project. It should contain:
   - Project description: a general overview of the project
   - Installation instructions: how to set up the project (or specific module that the repo contains)
   - Usage instructions (out of scope for this course)
   - Contribution guidelines (out of scope for this course)
   - License

1. docs/: a directory containing additional documentation. It may include:
   - Architecture diagrams: granular description of the project's architecture,
     possibly split to several modules per feature/layer. This is extremely helpful
     for understanding what the code implements, especially for code reviewers
   - Design documents: detailed descriptions of the project's design, including:
     - Data models
     - API specifications
     - Sequence diagrams
     - Class diagrams
     - etc
   - API documentation: detailed descriptions of the project's API, including:
     - API endpoints
     - Request/response schemas
     - Authentication/authorization requirements
     - etc
   - User guides

### Code Level
1. Code entity (classes/functions) documentation: each class and function should be documented with:
   - Description: what the class/function does (optional if trivial)
   - Parameters: what each parameter is (optional if trivial)
   - Return value: what the function returns
   - Assumptions: what assumptions the function makes, if any
   - Exceptions: what exceptions the function may raise
  
   Example from [KubeStellar](https://github.com/kubestellar/kubestellar):
      ```go 
    // A BindingPolicyResolver holds a collection of bindingpolicy resolutions.
    // The collection is indexed by bindingPolicyKey strings, which are the names of
    // the bindingpolicy objects. The resolution for a given key can be updated,
    // exported and compared to the binding representation.
    // All functions in this interface are thread-safe, and nothing mutates any
    // method-parameter during a call to one of them.
    type BindingPolicyResolver interface {
    // GenerateBinding returns the binding for the given
    // bindingpolicy key.
    //
    // If no resolution is associated with the given key, nil is returned.
    GenerateBinding(bindingPolicyKey string) *v1alpha1.BindingSpec
    
    // EnsureObjectData ensures that an object's identifier is
    // in the resolution for the given bindingpolicy key, and is associated
    // with the given resource-version, create-only bit and statuscollectors
    // set.
    // The given set is expected not to be mutated during and after this call
    // by the caller.
    //
    // The returned bool indicates whether the bindingpolicy resolution was
    // changed. If no resolution is associated with the given key, an error is
    // returned.
    EnsureObjectData(bindingPolicyKey string, objIdentifier util.ObjectIdentifier,
    objUID, resourceVersion string, createOnly bool, statusCollectors sets.Set[string]) (bool, error)
    ...
    }
    ```
    This example may be a bit too detailed for a student project, but it shows the level of detail that can be provided.

1. Comments: code should be self-explanatory, but oftentimes it's not. For the common cases, 
   comments should be added to explain the code's purpose, especially if it's not obvious/trivial.
   This usually is the case for any code with more than one logical block.
   
   Example:
    ```go
    // when an object is updated, we iterate over all bindingpolicies and update
    // resolutions that are affected by the update. Every changed resolution leads
    // to queueing its relevant binding for syncing.
    func (c *Controller) updateResolutions(ctx context.Context, objIdentifier util.ObjectIdentifier) error {
    bindingPolicies, err := c.listBindingPolicies()
    if err != nil {
    return err
    }
    
        logger := klog.FromContext(ctx)
    
        obj, err := c.getObjectFromIdentifier(objIdentifier)
        if errors.IsNotFound(err) {
            logger.V(3).Info("Removing non-existent object from resolutions", "object", objIdentifier, "numPolicies", len(bindingPolicies))
            // object is deleted, delete from all resolutions it exists in (and enqueue Binding references for the latter)
            return c.removeObjectFromBindingPolicies(ctx, objIdentifier, bindingPolicies)
        } else if err != nil {
            return fmt.Errorf("failed to get runtime.Object from object identifier (%v): %w", objIdentifier, err)
        }
    
        objMR := obj.(mrObject)
        objBeingDeleted := isBeingDeleted(obj)
    
        for _, bindingPolicy := range bindingPolicies {
            if !c.bindingPolicyResolver.ResolutionExists(bindingPolicy.GetName()) {
                continue // resolution does not exist, skip
            }
    
            matchedAny, createOnly, matchedStatusCollectorsSet := c.testObject(ctx, bindingPolicy.GetName(), objIdentifier, objMR.GetLabels(), bindingPolicy.Spec.Downsync)
            if !matchedAny {
                // if previously selected, remove
                if resolutionUpdated := c.bindingPolicyResolver.RemoveObjectIdentifier(bindingPolicy.GetName(),
                    objIdentifier); resolutionUpdated {
                    // enqueue binding to be synced since object was removed from its bindingpolicy's resolution
                    logger.V(4).Info("Enqueuing Binding for syncing due to the removal of an "+
                        "object from its resolution", "binding", bindingPolicy.GetName(),
                        "objectIdentifier", objIdentifier)
                    c.enqueueBinding(bindingPolicy.GetName())
                } else {
                    logger.V(5).Info("Not enqueuing Binding for syncing, because its resolution continues "+
                        "to not include workload object", "binding", bindingPolicy.GetName(),
                        "objectIdentifier", objIdentifier)
                }
                continue
            }
            logger.V(5).Info("BindingPolicy matched workload object", "policy", bindingPolicy.Name, "objIdentifier", objIdentifier)
    
            // obj is selected by bindingpolicy, update the bindingpolicy resolver
            resolutionUpdated, err := c.bindingPolicyResolver.EnsureObjectData(bindingPolicy.GetName(),
                objIdentifier, string(objMR.GetUID()), objMR.GetResourceVersion(), createOnly, matchedStatusCollectorsSet)
            if err != nil {
                if errorIsBindingPolicyResolutionNotFound(err) {
                    // this case can occur if a bindingpolicy resolution was deleted AFTER
                    // the BindingPolicyResolver::ResolutionExists call and BEFORE getting to the NoteObject function,
                    // which occurs if a bindingpolicy was deleted in this time-window.
                    logger.V(4).Info("skipped EnsureObjectIdentifierWithVersion for object because "+
                        "bindingpolicy was deleted", "objectIdentifier", objIdentifier,
                        "bindingpolicy", bindingPolicy.GetName())
                    continue
                }
    
                return fmt.Errorf("failed to update resolution for bindingpolicy %s for object (identifier: %v): %v",
                    bindingPolicy.GetName(), objIdentifier, err)
            }
    
            if resolutionUpdated {
                // enqueue binding to be synced since an object was added to its bindingpolicy's resolution
                logger.V(5).Info("Enqueued Binding for syncing due to a noting of an "+
                    "object in its resolution", "binding", bindingPolicy.GetName(),
                    "objectIdentifier", objIdentifier, "objBeingDeleted", objBeingDeleted,
                    "resourceVersion", objMR.GetResourceVersion())
                c.enqueueBinding(bindingPolicy.GetName())
            } else {
                logger.V(5).Info("Not enqueuing Binding, due to no change in resolution",
                    "binding", bindingPolicy.GetName(),
                    "objectIdentifier", objIdentifier, "objBeingDeleted", objBeingDeleted,
                    "resourceVersion", objMR.GetResourceVersion())
    
            }
        }
    
        return nil
    }
    ```
    This example packs a lot of information in a complex function. This example also showcases logging,
    and logging levels, as well as error reporting.

### API Level
Following the code-level documentation, API Gateway implementations should have API documentation.
This documentation should be in the form of OpenAPI (Swagger) specifications, which can be generated from code.


### Summary
Overall, **repository documentation** should help project maintainers and contributors understand the project's architecture,
design, and implementation. **Code-level documentation** should help developers understand the code's purpose and behavior,
without necessarily having to read the code itself. **API documentation** should help users understand how to interact with the project.

---

## 3. Code Quality
Code quality is a broad term that encompasses many aspects of code, including:
- Readability: how easy it is to read and understand the code
- Maintainability: how easy it is to maintain the code
- Testability: how easy it is to test the code
- Performance: how efficient the code is
- Security: how secure the code is

Writing high-quality code is mostly a product of experience, therefore it is understandable that students may not
write perfect code. However, there are some practices that can help students write better code:
1. **Code Reviews**: all code should be reviewed by at least one other person. This helps catch bugs, improve code quality,
   and share knowledge
2. **Unit Tests**: all code should be tested. This helps catch bugs early, ensures that the code works as expected,
   and makes it easier to refactor the code
3. **Linting**: all code should be lint. This one is extremely important! You should look up a linter for your language
   and configure it to run on your code. Linters help catch common mistakes, enforce coding standards, and improve code quality
4. **Code Formatting**: all code should be formatted. This is less important than linting, but it helps make the code
   more readable and consistent
5. **Documentation**: Covered in the previous section, but it's worth mentioning again. Code should be documented
   to help developers understand the code's purpose and behavior

---

## 4. Git Practices
Git is a powerful tool for version control, but it can be confusing and difficult to use. Here are some best practices
to follow when using Git:

### General Practices
1. **Forking**: fork the repository before making changes. Working in a fork helps isolate changes and makes it easier
   to contribute back to the main repository
1. **Pull Requests**: create pull requests to merge code into the main branch. This helps ensure that code is reviewed
   before it is merged
1. **Branch Protection**: protect the main branch from direct pushes. This helps prevent accidental changes to the main branch
   and ensures that all changes go through a reviewed pull request process
1. **Commits**: make small, atomic commits. Each commit should represent a single logical change. This makes it easier
   to review and revert changes
1. **Commit Messages**: write descriptive commit messages. Each commit message should explain what the commit does
   and why it does it. This helps other developers understand the code's history
1. **Rebasing**: rebase your changes before merging. This helps keep the commit history clean and linear. **This should be
   the way to go for resolving conflicts as well**

### Branching Model
1. **Main Branch**: the main branch should always be in a working state. It should pass all tests and linting checks
  Any code in the main branch should have up-to-date documentation (in-code and in repo)
2. **Feature Branches**: create feature branches for new features or bug fixes. These branches should be short-lived
   and focused on a single change. They should be merged back into the main branch once the change is complete
3. **Release Branches**: create release branches for each release. These branches should be used to prepare the release
   and should be merged back into the main branch once the release is complete

### Project Management
1. **Issues**: use issues to track bugs, features, and tasks. Issues should be descriptive and actionable. They should
   be linked to pull requests and commits
2. **Projects**: use projects to track the progress of features and releases. Projects should be used to organize issues
   and pull requests
3. **Milestones/Sprints**: use milestones to group issues and pull requests together. In the scope of this course,
   milestones can be used to group issues and pull requests for each sprint that addresses a short-term goal

