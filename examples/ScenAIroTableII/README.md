# ScenAIroTableII

An ODME example project for automated scenario generation from a runway detection
domain model. This example is included with a fully generated scenario set so
the Scenario Manager workflow can be tested directly from the repository.

## Included content

- The base domain model and `InitScenario`
- `5,400` generated `AutoScenario_*` folders
- Serialized variables, constraints, behaviours, and graph files for every scenario
- The local `odd/ScenAIroTableII.ser` artifact produced for this project

## What this example demonstrates

- specialization-based pruning into PES/scenario models
- constrained Latin Hypercube sampling for scenario variables
- Scenario Manager open, delete, refresh, and export flows
- scenario XML regeneration from stored variable samples

## Opening the example

Copy the example project to a writable working directory before editing it:

```bash
cp -r examples/ScenAIroTableII .
# Launch ODME -> File -> Open -> select ScenAIroTableII
```

## Rebuilding exports

After opening the project in ODME, use:

- `Scenario Manager -> Automatic Scenario Generation` to regenerate scenarios
- `Scenario Manager -> Refresh Scenario List` to rebuild the consolidated exports

That refresh creates:

- `ScenarioExports/xml/` with one readable XML file per scenario
- `ScenarioExports/scenario-summary.csv` with selected entities and sampled values

## Notes

- This example is intentionally large because it includes the generated scenario set.
- If you want a smaller working set, use `Delete Generated` in Scenario Manager and regenerate with fewer samples.
