# ODME First-Time User Manual

This manual is for users who want to run **Operation Domain Modeling Environment (ODME)** for the first time and understand the main workflow before they start editing models.

## 1. What ODME Is

ODME is a desktop application for building and working with operation domain models and scenarios.

The application is centered around:

1. **Domain Modelling**
   Build and validate a domain model.
2. **Scenario Modelling**
   Create scenario-specific versions of the model by pruning and editing values.
3. **Supporting tools**
   Behaviour synchronization, scenario management, execution helpers, ODD management, and Cameo import.

Some supporting tools are marked in the codebase and README as **work in progress**. The core workflow is still centered on Domain Modelling and Scenario Modelling.

## 2. Ways to Run ODME

Choose one of the following.

### Option A: Run the packaged Windows executable

If you already have the packaged Windows app image:

1. Open [dist/ODME](./dist/ODME).
2. Double-click `ODME.exe`.

Important:

- Keep the whole `ODME` folder together.
- Do not move only `ODME.exe` by itself.
- Run it from a writable location such as `Downloads`, `Desktop`, or `Documents`.

### Option B: Run the packaged app on macOS or Linux

If a native package was built on the target OS:

- macOS app image: open `dist/ODME.app`
- macOS installer: open the generated `.dmg`
- Linux app image: run `dist/ODME/bin/ODME`
- Linux installer: install the generated `.deb` or `.rpm`

Packaging scripts are in [launcher](./launcher).

### Option C: Run the jar directly

If you have Java installed:

```powershell
java -jar .\target\SESEditor-1.0-SNAPSHOT.jar
```

### Option D: Build and run from source

From the project root:

```powershell
mvn package
java -jar .\target\SESEditor-1.0-SNAPSHOT.jar
```

## 3. What Happens on First Launch

When ODME starts:

1. It creates a default project folder named `Main` if it does not already exist.
2. It opens the main editor window.
3. The application starts in **Domain Modelling** mode.

By default, project files are created relative to the folder from which the application is launched.

## 4. Main Window Layout

The ODME main window is divided into several work areas.

### Project Explorer

Shows the currently open project and its files or modules.

### Model Structure

Shows the model as a tree. This is synchronized with the graph canvas.

### Graph Canvas

The central drawing area where you create and manipulate the domain or scenario graph.

### Right-side Data Panels

These panels show data for the currently selected node:

- Variables
- Behaviours
- Distributions
- Inter-Entity Constraints
- Intra-Entity Constraints

### Bottom Console

Shows validation output, logging, and feedback from some workflows.

### XML / Schema / Ontology Viewer

The bottom-right tab area shows generated XML, schema, or ontology output depending on the current mode and selected tab.

### Status Bar

Shows the current mode and includes the mode-switch button.

## 5. Recommended First-Time Workflow

For most users, the safest order is:

1. Start in **Domain Modelling**
2. Create a new project
3. Build the domain model
4. Add variables and constraints
5. Save and validate
6. Switch to **Scenario Modelling**
7. Create or open scenarios
8. Prune the model and set scenario-specific values
9. Save or generate scenarios
10. Use the supporting tools only after the base model is stable

## 6. Creating or Opening a Project

### Create a new project

Use:

`Domain Modelling > New Project`

You will be asked for:

- Project name
- Root name
- Project location

The default root is `Thing`.

### Open an existing project

Use:

`Domain Modelling > Open`

Choose the project directory.

### Import an existing template

Use:

`Domain Modelling > Import Template`

This imports an XML-based project template created in a supported format.

### Import from Cameo

Use:

`Domain Modelling > Import From Cameo`

The importer expects these CSV files:

- `DomainRelations.csv`
- `OperationLinking.csv`
- `InstanceRelations.csv`
- `Enums.csv`

It then creates a project from those inputs.

## 7. Domain Modelling Mode

This is the main authoring mode and the best starting point for new users.

### What it is for

Use Domain Modelling to create the full structural model before you derive scenarios from it.

### What you can do here

- Create a new project
- Open an existing project
- Add nodes to the graph
- Edit the model tree
- Add variables
- Add distributions
- Add behaviours
- Add inter-entity and intra-entity constraints
- Save the model
- Validate the model
- Export the model or save it as a reusable template
- Import a model from Cameo

### Toolbar actions in Domain Modelling

The main toolbar contains:

- Selector
- Add Entity
- Add Aspect
- Add Specialization
- Add Multi-Aspect
- Delete Node
- Save Graph
- Undo
- Redo
- Zoom In
- Zoom Out
- Validation

### Best practice in this mode

1. Create the full structure first.
2. Then add variables, constraints, and behaviours.
3. Validate regularly.
4. Save before switching modes.

## 8. Scenario Modelling Mode

Switch to this mode using the button in the status bar.

### What it is for

Scenario Modelling is used to derive executable or scenario-specific structures from the domain model.

### What changes when you switch

- The mode changes from domain authoring to scenario work.
- Some toolbar actions for adding new structural nodes are hidden.
- The tab view changes to focus on generated XML.
- Scenario-specific files and folders are created.
- The graph styling changes to reflect pruning-related state.

### What you can do here

- Open or create scenarios
- Prune the model
- Edit node values for the current scenario
- Save scenario state
- Generate scenario files

### Scenario menu actions

Use:

- `Scenario Modelling > Save Scenario`
- `Generate Scenario > From CSV`
- `Generate Scenario > Direct From Domain Model`

### Scenario list

Use the `Scenarios` button in the toolbar or:

`Scenario Manager > Scenarios List`

This opens the scenario list window where you can:

- View dynamic scenarios
- Open a scenario
- Delete a scenario
- View generated scenario folders
- Run structural coverage actions

## 9. Validation and Export

### Validation

Use the toolbar `Validation` button.

What it does:

1. Saves the current model state
2. Rebuilds the XML and XSD outputs
3. Validates the generated XML
4. Writes details to the console
5. Refreshes the XML viewer

For longer validations, ODME now shows a progress dialog instead of freezing the interface.

### Save as Template

Use:

`Domain Modelling > Save as Template`

This validates the current model and writes the export XML to a file you choose.

### Save as PNG

Use:

`File > Save as PNG`

This exports the graph canvas to `graph.png`.

## 10. Sample and Scenario Generation

ODME supports two related workflows.

### Generate scenarios from CSV

Use:

`Scenario Modelling > Generate Scenario > From CSV`

Provide:

- A scenario name
- A CSV file

ODME will generate scenario XML files from the CSV rows.

### Generate scenarios directly from the domain model

Use:

`Scenario Modelling > Generate Scenario > Direct From Domain Model`

Provide:

- A scenario name
- The number of samples

ODME then:

1. Saves and updates the current model
2. Produces temporary YAML and CSV data
3. Generates samples
4. Creates scenario files from those samples

### Generate samples only

Use:

`Scenario Manager > Generate Samples`

Provide:

- A YAML file
- Number of samples
- Output CSV path

## 11. Behaviour Modelling

Use:

`Behavior Modelling > Sync Behaviour`

### What it is for

This area is intended to support editing or synchronizing behaviour definitions for entities.

### Status

This is currently a **work in progress**. Treat it as an advanced feature and verify results carefully.

## 12. Operation Design Domain (ODD)

Use:

- `Operation Design Domain > Generate OD`
- `Operation Design Domain > ODD Manager`

### What it is for

ODD tools let you derive an Operational Domain representation from the current model and manage saved ODDs.

### Generate OD

Use this to generate and edit the current ODD derived from the active model.

### ODD Manager

Use this to:

- Open saved ODDs
- Edit ODD table data
- Export ODD content
- Delete saved ODDs

### Status

This area is marked as **work in progress** in the project documentation.

## 13. Scenario Manager

Use:

- `Scenario Manager > Scenarios List`
- `Scenario Manager > Execution`
- `Scenario Manager > Feedback Loop`
- `Scenario Manager > Generate Samples`

### What it is for

Scenario Manager is the umbrella area for working with generated scenarios and related downstream tasks.

### Execution window

The Execution window supports:

- Loading XML
- Loading YAML
- Translating XML to Python-oriented output
- Translating YAML
- Editing Python scripts
- Running scripts
- Saving scripts

This is intended to bridge modelling outputs and execution workflows.

### Feedback Loop

The menu entry exists, but the README indicates this broader area is still evolving.

### Status

Scenario Manager features should be treated as partially mature. Validate generated outputs before relying on them in production workflows.

## 14. Help Menu

Use:

- `Help > Manual`
- `Help > About`

`Manual` opens the packaged user manual resource.

`About` opens application information.

## 15. A Good First Practice Session

If you are learning ODME for the first time, use this short exercise:

1. Launch ODME.
2. Create a new project.
3. Add a few nodes in Domain Modelling.
4. Select nodes and inspect the Variables and Constraints panels.
5. Save the graph.
6. Run Validation.
7. Switch to Scenario Modelling.
8. Open the scenario list.
9. Create or generate a scenario.
10. Inspect the generated XML tab and console output.

This gives you a complete end-to-end introduction without using the more advanced tools first.

## 16. Troubleshooting

### The program does not start

Check:

- Java 17 is available if you are running the jar directly
- You are launching from the project root or a writable packaged app folder
- The full packaged folder is intact if you are using a native app image

### The application opens but cannot save files

ODME writes project data relative to the working location. Move the application to a writable folder and try again.

### Validation or generation takes time

Longer tasks now run with progress dialogs. Wait for the operation to complete before closing the dialog.

### A supporting mode behaves unexpectedly

Treat these areas as work in progress:

- Behaviour Modelling
- Operation Design Domain
- Scenario Manager
- Import From Cameo
- Scripting / execution helper flows

## 17. File Locations You Should Know

Common locations in this repository:

- Main README: [README.md](./README.md)
- Developer guide: [DEVELOPER_GUIDE.md](./DEVELOPER_GUIDE.md)
- Packaging scripts: [launcher](./launcher)
- Build output: [target](./target)
- Packaged app output: [dist](./dist)

## 18. Summary

If you are new to ODME, keep the first sessions simple:

1. Start in Domain Modelling
2. Build and validate the structure
3. Switch to Scenario Modelling only after the model is stable
4. Use advanced tools later

That sequence matches the way the application is structured and is the lowest-risk way to learn it.
