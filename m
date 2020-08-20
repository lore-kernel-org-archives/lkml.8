Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1536C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 619C020885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s3ZMNOxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgHTVXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 17:23:44 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55486 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgHTVXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 17:23:41 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07KLNYF0059130;
        Thu, 20 Aug 2020 16:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1597958614;
        bh=Oq2grRWFHQ/nwrs9YgMjvF/tRfnyle4hAikLzUN4/20=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=s3ZMNOxtAr4b8P/KIlFt1A17LI3vyte2nqqcx1Mgj2kb6uV21EPZ99mGkofxn+HfR
         2kpK3WYOKLFsFSHoncI3LRSzm2OI87yg0cSWm7++MiGjwUgAqOU/SUQ/OyemtX327A
         Dhlp15TNrtYBzdMj6CK/VDYSXnWYZuPYMOofjpIM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07KLNYNf130052;
        Thu, 20 Aug 2020 16:23:34 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 20
 Aug 2020 16:23:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 20 Aug 2020 16:23:34 -0500
Received: from [10.250.32.29] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07KLNX6n052890;
        Thu, 20 Aug 2020 16:23:33 -0500
Subject: Re: [PATCH v3 1/4] dt-bindings: remoteproc: Add bindings for R5F
 subsystem on TI K3 SoCs
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200722235554.7511-1-s-anna@ti.com>
 <20200722235554.7511-2-s-anna@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <1c628d36-4f7b-6d3c-93b2-b9a7ca2f5ed8@ti.com>
Date:   Thu, 20 Aug 2020 16:23:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722235554.7511-2-s-anna@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/20 6:55 PM, Suman Anna wrote:
> The Texas Instruments K3 family of SoCs have one or more dual-core
> Arm Cortex R5F processor subsystems/clusters (R5FSS). The clusters
> can be split between multiple voltage domains as well. Add the device
> tree bindings document for these R5F subsystem devices. These R5F
> processors do not have an MMU, and so require fixed memory carveout
> regions matching the firmware image addresses. The nodes require more
> than one memory region, with the first memory region used for DMA
> allocations at runtime. The remaining memory regions are reserved
> and are used for the loading and running of the R5F remote processors.
> The R5F processors can also optionally use any internal on-chip SRAM
> memories either for executing code or using it as fast-access data.
> 
> The added example illustrates the DT nodes for the single R5FSS device
> present on K3 AM65x family of SoCs.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> v3:
>  - Replaced ti,k3-sci-proc.yaml references with the new ti,k3-sci-common.yaml
>  - Updated required list to include the three ti,sci properties
> v2: https://patchwork.kernel.org/patch/11632997/
> v1: https://patchwork.kernel.org/patch/11456381/
> 
>  .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  | 281 ++++++++++++++++++
>  1 file changed, 281 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> new file mode 100644
> index 000000000000..2f4fb4a1a2cb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> @@ -0,0 +1,281 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/ti,k3-r5f-rproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI K3 R5F processor subsystems
> +
> +maintainers:
> +  - Suman Anna <s-anna@ti.com>
> +
> +description: |
> +  The TI K3 family of SoCs usually have one or more dual-core Arm Cortex R5F
> +  processor subsystems/clusters (R5FSS). The dual core cluster can be used
> +  either in a LockStep mode providing safety/fault tolerance features or in a
> +  Split mode providing two individual compute cores for doubling the compute
> +  capacity. These are used together with other processors present on the SoC
> +  to achieve various system level goals.
> +
> +  Each Dual-Core R5F sub-system is represented as a single DTS node
> +  representing the cluster, with a pair of child DT nodes representing
> +  the individual R5F cores. Each node has a number of required or optional
> +  properties that enable the OS running on the host processor to perform
> +  the device management of the remote processor and to communicate with the
> +  remote processor.
> +
> +properties:
> +  $nodename:
> +    pattern: "^r5fss(@.*)?"
> +
> +  compatible:
> +    enum:
> +      - ti,am654-r5fss
> +      - ti,j721e-r5fss
> +
> +  power-domains:
> +    description: |
> +      Should contain a phandle to a PM domain provider node and an args
> +      specifier containing the R5FSS device id value.
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges:
> +    description: |
> +      Standard ranges definition providing address translations for
> +      local R5F TCM address spaces to bus addresses.
> +
> +# Optional properties:
> +# --------------------
> +
> +  ti,cluster-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    description: |
> +      Configuration Mode for the Dual R5F cores within the R5F cluster.
> +      Should be either a value of 1 (LockStep mode) or 0 (Split mode),
> +      default is LockStep mode if omitted.
> +
> +# R5F Processor Child Nodes:
> +# ==========================
> +
> +patternProperties:
> +  "^r5f@[a-f0-9]+$":
> +    type: object
> +    description: |
> +      The R5F Sub-System device node should define two R5F child nodes, each
> +      node representing a TI instantiation of the Arm Cortex R5F core. There
> +      are some specific integration differences for the IP like the usage of
> +      a Region Address Translator (RAT) for translating the larger SoC bus
> +      addresses into a 32-bit address space for the processor.
> +
> +      Each R5F core has an associated 64 KB of Tightly-Coupled Memory (TCM)
> +      internal memories split between two banks - TCMA and TCMB (further
> +      interleaved into two banks TCMB0 and TCMB1). These memories (also called
> +      ATCM and BTCM) provide read/write performance on par with the core's L1
> +      caches. Each of the TCMs can be enabled or disabled independently and
> +      either of them can be configured to appear at that R5F's address 0x0.
> +
> +      The cores do not use an MMU, but has a Region Address Translater
> +      (RAT) module that is accessible only from the R5Fs for providing
> +      translations between 32-bit CPU addresses into larger system bus
> +      addresses. Cache and memory access settings are provided through a
> +      Memory Protection Unit (MPU), programmable only from the R5Fs.
> +
> +    allOf:
> +      - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - ti,am654-r5f
> +          - ti,j721e-r5f
> +
> +      reg:
> +        items:
> +          - description: Address and Size of the ATCM internal memory region
> +          - description: Address and Size of the BTCM internal memory region
> +
> +      reg-names:
> +        items:
> +          - const: atcm
> +          - const: btcm
> +
> +      resets:
> +        description: |
> +          Should contain the phandle to the reset controller node managing the
> +          local resets for this device, and a reset specifier.
> +        maxItems: 1
> +
> +      firmware-name:
> +        description: |
> +          Should contain the name of the default firmware image
> +          file located on the firmware search path
> +
> +# The following properties are mandatory for R5F Core0 in both LockStep and Split
> +# modes, and are mandatory for R5F Core1 _only_ in Split mode. They are unused for
> +# R5F Core1 in LockStep mode:
> +
> +      mboxes:
> +        description: |
> +          OMAP Mailbox specifier denoting the sub-mailbox, to be used for
> +          communication with the remote processor. This property should match
> +          with the sub-mailbox node used in the firmware image.
> +        maxItems: 1
> +
> +      memory-region:
> +        description: |
> +          phandle to the reserved memory nodes to be associated with the
> +          remoteproc device. There should be at least two reserved memory nodes
> +          defined. The reserved memory nodes should be carveout nodes, and
> +          should be defined with a "no-map" property as per the bindings in
> +          Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> +        minItems: 2
> +        maxItems: 8
> +        items:
> +          - description: region used for dynamic DMA allocations like vrings and
> +                         vring buffers
> +          - description: region reserved for firmware image sections
> +        additionalItems: true
> +
> +
> +# Optional properties:
> +# --------------------
> +# The following properties are optional properties for each of the R5F cores:
> +
> +      ti,atcm-enable:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]
> +        description: |
> +          R5F core configuration mode dictating if ATCM should be enabled. The
> +          R5F address of ATCM is dictated by ti,loczrama property. Should be
> +          either a value of 1 (enabled) or 0 (disabled), default is disabled
> +          if omitted. Recommended to enable it for maximizing TCMs.
> +
> +      ti,btcm-enable:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]
> +        description: |
> +          R5F core configuration mode dictating if BTCM should be enabled. The
> +          R5F address of BTCM is dictated by ti,loczrama property. Should be
> +          either a value of 1 (enabled) or 0 (disabled), default is enabled if
> +          omitted.
> +
> +      ti,loczrama:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]
> +        description: |
> +          R5F core configuration mode dictating which TCM should appear at
> +          address 0 (from core's view). Should be either a value of 1 (ATCM
> +          at 0x0) or 0 (BTCM at 0x0), default value is 1 if omitted.
> +
> +      sram:
> +        $ref: /schemas/types.yaml#/definitions/phandle-array
> +        minItems: 1
> +        maxItems: 4
> +        description: |
> +          phandles to one or more reserved on-chip SRAM regions. The regions
> +          should be defined as child nodes of the respective SRAM node, and
> +          should be defined as per the generic bindings in,
> +          Documentation/devicetree/bindings/sram/sram.yaml
> +
> +    required:
> +     - compatible
> +     - reg
> +     - reg-names
> +     - ti,sci
> +     - ti,sci-dev-id
> +     - ti,sci-proc-ids
> +     - resets
> +     - firmware-name
> +
> +    unevaluatedProperties: false
> +
> +required:
> + - compatible
> + - power-domains
> + - "#address-cells"
> + - "#size-cells"
> + - ranges

I will update the indentation (add an extra space) as recently fixed by Rob on
various bindings in 5.9-rc1 for the next version. Currently waiting on the
response from the v2 discussion before I refresh this series.

regards
Suman

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    / {
> +        model = "Texas Instruments K3 AM654 SoC";
> +        compatible = "ti,am654";
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        bus@100000 {
> +            compatible = "simple-bus";
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
> +                     <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>,
> +                     <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>,
> +                     <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00080000>;
> +
> +            bus@28380000 {
> +                compatible = "simple-bus";
> +                #address-cells = <2>;
> +                #size-cells = <2>;
> +                ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>, /* MCU NAVSS */
> +                         <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>, /* MCU R5F Core0 */
> +                         <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>, /* MCU R5F Core1 */
> +                         <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00080000>; /* MCU SRAM */
> +
> +                /* AM65x MCU R5FSS node */
> +                mcu_r5fss0: r5fss@41000000 {
> +                    compatible = "ti,am654-r5fss";
> +                    power-domains = <&k3_pds 129>;
> +                    ti,cluster-mode = <1>;
> +                    #address-cells = <1>;
> +                    #size-cells = <1>;
> +                    ranges = <0x41000000 0x00 0x41000000 0x20000>,
> +                             <0x41400000 0x00 0x41400000 0x20000>;
> +
> +                    mcu_r5f0: r5f@41000000 {
> +                        compatible = "ti,am654-r5f";
> +                        reg = <0x41000000 0x00008000>,
> +                              <0x41010000 0x00008000>;
> +                        reg-names = "atcm", "btcm";
> +                        ti,sci = <&dmsc>;
> +                        ti,sci-dev-id = <159>;
> +                        ti,sci-proc-ids = <0x01 0xFF>;
> +                        resets = <&k3_reset 159 1>;
> +                        firmware-name = "am65x-mcu-r5f0_0-fw";
> +                        ti,atcm-enable = <1>;
> +                        ti,btcm-enable = <1>;
> +                        ti,loczrama = <1>;
> +                        mboxes = <&mailbox0 &mbox_mcu_r5fss0_core0>;
> +                        memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
> +                                        <&mcu_r5fss0_core0_memory_region>;
> +                        sram = <&mcu_r5fss0_core0_sram>;
> +                    };
> +
> +                    mcu_r5f1: r5f@41400000 {
> +                        compatible = "ti,am654-r5f";
> +                        reg = <0x41400000 0x00008000>,
> +                              <0x41410000 0x00008000>;
> +                        reg-names = "atcm", "btcm";
> +                        ti,sci = <&dmsc>;
> +                        ti,sci-dev-id = <245>;
> +                        ti,sci-proc-ids = <0x02 0xFF>;
> +                        resets = <&k3_reset 245 1>;
> +                        firmware-name = "am65x-mcu-r5f0_1-fw";
> +                        ti,atcm-enable = <1>;
> +                        ti,btcm-enable = <1>;
> +                        ti,loczrama = <1>;
> +                        mboxes = <&mailbox1 &mbox_mcu_r5fss0_core1>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> 

