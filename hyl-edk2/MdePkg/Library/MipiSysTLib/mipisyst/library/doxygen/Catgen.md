\page mipi_syst_catgen_page Automated Catalog Generation

[TOC]

Catalog Example {#mipi_syst_catgen_sample}
==============================================================================
The distribution includes an example application that uses catalog
messages generated by the  [MIPI_SYST_CATPRINTF](@ref PrintfApi),
[MIPI_SYST_CATALOG64](@ref CatAPI64) or  [MIPI_SYST_CATALOG32](@ref CatAPI32)
families of instrumentation API calls. The example also includes the necessary
configuration to support the automated decode collateral generation tool. This
tool scans the source code and extracts the catalog decode information into
collateral needed by SyS-T decoders.

The example is stored under `examples/client` in the source code distribution.

Decode Collateral Creation Tool {#mipi_syst_catgen_tool}
==============================================================================
The project includes a PERL based collateral generator that automates the
creation and updating of SyS-T decode collateral in XML format. This
generator parses the catalog instrumentation points by scanning the
client source code. The tool can be embedded into a software build process to
keep software builds and decode collateral updated at the same time. The tool
is stored in the ```collateral/generator``` directory of the project with the
name ```syst_cgen.pl```.

Dependencies {#mipi_syst_catgen_deps}
------------------------------------------------------------------------------
The generator is written in PERL and requires a PERL installation with the
following optional modules installed.
 * String::Escape
 * Xml::Simple

Refer to the documentation for your PERL installation on module installation.
On Linux, the following commands can be used:

```
$ perl -MCPAN -e 'install XML::Simple'
$ perl -MCPAN -e 'install String::Escape'
```

Collateral Generation Process {#mipi_syst_catgen_process}
------------------------------------------------------------------------------
The collateral generator takes a SyS-T collateral template and
a configuration file as input. The configuration file defines the locations
and file extensions of the source files to be scanned and how the catalog
message calls
inside the source code are named. The tool can then detect the catalog
calls, and extract the format strings, source locations, and
catalog IDs to update the collateral template file. The result is a
new collateral file that matches the actual state of the source code.

Catalog Generation Example {#mipi_syst_catgen_example_generation}
------------------------------------------------------------------------------
The client application in ```example/client``` uses various catalog calls.
It  provides a configuration file for ```syst_cgen.pl``` to detect
the SyS-T catalog message calls, and a collateral template file that is
updated by the generator. It is executed in the following way:

```
$ perl ../../collateral/generator/syst_cgen.pl -config collateral_config.xml
syst_cgen.pl: Parsing: ./othersource.c
syst_cgen.pl: Add ./othersource.c with file id 1 to file catalog
syst_cgen.pl: Parsing finished: ./othersource.c, found 127 call(s)
syst_cgen.pl: Parsing: ./systclient.c
syst_cgen.pl: Add ./systclient.c with file id 2 to file catalog
syst_cgen.pl: Parsing finished: ./systclient.c, found 4 call(s)
syst_cgen.pl: Generating XML structure
syst_cgen.pl: Loaded template collateral file template.xml
syst_cgen.pl: Generating XML structure finished
syst_cgen.pl: Writing XML file: generated_catalog.xml
syst_cgen.pl: Writing XML file finished
```
Catalog Generator Configuration Example {#mipi_syst_catgen_example_config}
------------------------------------------------------------------------------
The following XML file shows the example configuration file from the client
example. The file lists the SyS-T catalog instrumentation call patterns and
can be reused for other clients. Only the options at the beginning may require
adaptations.

```{.xml}
<CatalogGenerator>
    <CatalogConfigs>
        <CatalogConfig option="catalog" value="generated_catalog.xml" />
        <CatalogConfig option="template" value="template.xml" />
        <CatalogConfig option="indentation" value="4" />
        <CatalogConfig option="nolocation"  value="false"/>
        <CatalogConfig option="src" value="." />
    </CatalogConfigs>
    <SrcFilePatterns>
        <SrcFilePattern Pattern="*.{cpp,c,h}" />
    </SrcFilePatterns>
    <CatalogCalls>
        <Catalog32>
            <CatalogCall Name="MIPI_SYST_HASH" Algorithm="hash65599" IdParamIdx="2" StringParamIdx="1" />

            <CatalogCall Name="MIPI_SYST_CATPRINTF32" IdParamIdx="3" StringParamIdx="4"    />
            <CatalogCall Name="MIPI_SYST_CATPRINTF32_0" IdParamIdx="3" StringParamIdx="4"  />
            <CatalogCall Name="MIPI_SYST_CATPRINTF32_1" IdParamIdx="3" StringParamIdx="4"  />
            <CatalogCall Name="MIPI_SYST_CATPRINTF32_2" IdParamIdx="3" StringParamIdx="4"  />
            <CatalogCall Name="MIPI_SYST_CATPRINTF32_3" IdParamIdx="3" StringParamIdx="4"  />
            <CatalogCall Name="MIPI_SYST_CATPRINTF32_4" IdParamIdx="3" StringParamIdx="4"  />
            <CatalogCall Name="MIPI_SYST_CATPRINTF32_5" IdParamIdx="3" StringParamIdx="4"  />
            <CatalogCall Name="MIPI_SYST_CATPRINTF32_6" IdParamIdx="3" StringParamIdx="4"  />
        </Catalog32>

        <Catalog64>
            <CatalogCall Name="MIPI_SYST_CATPRINTF64" IdParamIdx="3" StringParamIdx="4" />
            <CatalogCall Name="MIPI_SYST_CATPRINTF64_0" IdParamIdx="3" StringParamIdx="4"  />
            <CatalogCall Name="MIPI_SYST_CATPRINTF64_1" IdParamIdx="3" StringParamIdx="4"  />
            <CatalogCall Name="MIPI_SYST_CATPRINTF64_2" IdParamIdx="3" StringParamIdx="4"  />
            <CatalogCall Name="MIPI_SYST_CATPRINTF64_3" IdParamIdx="3" StringParamIdx="4"  />
            <CatalogCall Name="MIPI_SYST_CATPRINTF64_4" IdParamIdx="3" StringParamIdx="4"  />
            <CatalogCall Name="MIPI_SYST_CATPRINTF64_5" IdParamIdx="3" StringParamIdx="4"  />
            <CatalogCall Name="MIPI_SYST_CATPRINTF64_6" IdParamIdx="3" StringParamIdx="4"  />
        </Catalog64>
    </CatalogCalls>
</CatalogGenerator>
```

Catalog Generator Template File {#mipi_syst_catgen_example_template}
------------------------------------------------------------------------------
The following XML file shows the template collateral file that is updated by
the generator tool with the source code information. Note the empty XML
elements called ``<syst:SourceFiles/>``, ``<syst:Catalog32/>``, and
``<syst:Catalog64/>``. The generator replaces these empty elements with the
collected information. The remaining contents are kept unchanged.
```{.xml}
<?xml version="1.0" encoding="utf-8"?>
<syst:Collateral xmlns:syst="http://www.mipi.org/1.0/sys-t"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.mipi.org/1.0/sys-t
                        https://www.mipi.org/schema/sys-t/sys-t_1-0.xsd">

  <!--
  A SyS-T collateral file starts with one syst:Collateral element
  and contains at least one syst:Client child node.
 -->
  <syst:Client Name="example">

    <!--
    List of message GUIDs for this client:
    A GUID is a 128bit numeric UUID following RFC 4122.
    Clients that are identified by transport layer properties
    can use pseudo GUID values to identify their messages. A
    pseudo GUID is defined as a GUID with bit 71 set to zero.
    The following encoding might be used for clients identified
    by MIPI System Trace Protocol (STP) master/channel pairs:

     {00000000-<MasterID>-<ChannelID>-<Origin>00-000000000000}

    A Mask attribute can be added to define which bits of the GUID are
    used for comparison. Without a mask, all bits need to match.
    The example below makes the catalog valid for all channels from the
    STP master value 0x644, or messages with the "494E..." GUID in their
    payload.
    -->
    <syst:Guids>
      <syst:Guid ID=  "{00000000-0644-0000-0000-000000000000}"
                 Mask="{00000000-FFFF-0000-8000-000000000000}"><![CDATA[kernel]]></syst:Guid>
      <syst:Guid ID="{494E5443-6F64-43D1-93F0-F3D49D92670C}"><![CDATA[user]]></syst:Guid>
    </syst:Guids>

    <!--
    Define for which client build versions this collateral is valid.
    Builds are expressed as values up to 64 bits in size, and can include a
    mask that defines which bits need to match with a client build version
    message.
    -->
    <syst:Builds>
      <syst:Build ID="0x00010000" Mask="0xFFFF0000" ><![CDATA[SW Build 1.x]]></syst:Build>
      <syst:Build ID="0x00020000" Mask="0xFFFF0000" ><![CDATA[SW Build 2.x]]></syst:Build>
    </syst:Builds>

     <!--
     Settings to guide decoding tools what to do in cases
     where several options are possible. The example below tells
     a decoder to interprete SyS-T message timstamps only as an
     informal field, but not the message creation time.
     -->
    <syst:Options>
      <syst:Option Name="syst:timestamp">displayAsField</syst:Option>
    </syst:Options>

    <!--
    Provide ID to name mapping for Origin header field values.
    -->
    <syst:Modules>
      <syst:Module ID="0x1"><![CDATA[kernel]]></syst:Module>
      <syst:Module ID="0x2"><![CDATA[user]]></syst:Module>
  </syst:Modules>

    <!--
    Define the mapping of the numeric File-ID to source files.
    This table is optional and only needed if source references are used
    by the Catalog32 or Catalog64 elements.
    -->
    <syst:SourceFiles>
      <syst:File ID="0x00000001"><![CDATA[example/src/main.c]]></syst:File>
      <syst:File ID="0x00000002"><![CDATA[example/h/example.h]]></syst:File>
    </syst:SourceFiles>

    <!--
    Define the mapping of catalog message ID to human-readable strings.
    This table is optional and only needed if catalog messages are used.
    A message can have optional "File" and "Line" attributes to specify the
    source position of the instrumentation call. A decoder uses the
    information from these attributes if the message payload doesn't provide
    explicit location information.
    -->
    <syst:Catalog32>
      <syst:Format ID="0x00000001" File="0x00000001" Line="23"><![CDATA[This is example %d.%d]]></syst:Format>
      <syst:Format ID="0x00000002" File="0x00000002" Line="72"><![CDATA[task switch %x->%x]]></syst:Format>
    </syst:Catalog32>

    <syst:Catalog64>
      <syst:Format ID="0x0000000000000001"><![CDATA[error %d]]></syst:Format>
    </syst:Catalog64>

    <!--
    Define short message mapping from 28-Bit ID to user visible string.
    -->
    <syst:Short32>
      <syst:Format ID="0x0000000" Mask="0xFFFFFF0"><![CDATA[Fatal Error code]]></syst:Format>
      <syst:Format ID="0x0000013"><![CDATA[state ready]]></syst:Format>
      <syst:Format ID="0x000001A"><![CDATA[state halt]]></syst:Format>
    </syst:Short32>

    <!--
    Define short message mapping from 60-Bit ID to user visible string.
    -->
    <syst:Short64>
      <syst:Format ID="0x123456700000000" Mask="0xFFFFFFF00000000"><![CDATA[warning state]]></syst:Format>

    </syst:Short64>

    <!--
    Specify raw message protocol id assignment
    -->
    <syst:Write>
      <syst:Protocol ID="0x01"><![CDATA[console]]></syst:Protocol>
      <syst:Protocol ID="0x02"><![CDATA[console]]></syst:Protocol>
      <syst:Protocol ID="0x03"><![CDATA[ftrace]]></syst:Protocol>
      <syst:Protocol ID="0x20" Mask="0x30"><![CDATA[reserved]]></syst:Protocol>
    </syst:Write>

</syst:Client>

</syst:Collateral>
```