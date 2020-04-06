Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A8BC2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1767206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OnJvbwcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDFT7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:59:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41878 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgDFT7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:59:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id d24so258617pll.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 12:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E7QY7pXlGy+jqNVfN8zs1x8pk4wyzR53SWCmw/IulpQ=;
        b=OnJvbwcmp/xdIUf2kjtQ+rv+mzamnbM+Jg9l129jfvPj1SXcCdryIYNWBb+2mgC2zg
         aanzBShBRW3Nlst543fY0W6MJ8BfYKCv1Fg/gwhgoorDyZYYKDlYvqEBBpbF9maSkasu
         EdUz6deR/NRwQAgGrMhVpqzYPIkKnjxhonifpDOSwQkEI47Yb1Gs0aFdeAlL9F+cBKZM
         Q/NBxCWGTXlfCyj/cv1oz2ih5jer/tRfNoqQ64BA6F0MmlMsHrFdUcNmFB38YSVklY5r
         SofhUmvOtLogaqxE41uXwowy2+aGN6GdBLDx7DC1RZP1Sgac0jH2F0googU2pmjC7cw3
         xt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E7QY7pXlGy+jqNVfN8zs1x8pk4wyzR53SWCmw/IulpQ=;
        b=T+rK4qw1THfRPoZoTq3KiQyNp9/AYlsIo6NlWoOsYhJogDfNUs0XA43Q+khMeCGv4O
         knYSfK1VHLmsZZCghegdfRa0jJjhNqEzJAdwzDMgZnocX6/ftUslfZiwliH62MlwW9ab
         xkI7HLbyT6BCjx3eVbCwnRWrXcqRWX38acMWAPXVyJDbWYH2sK2mAHoIxN5w3BQI+p7P
         JP1sGaRQMAfFujuOi7pln7GZLK0mwoQ9LM0N2VBVrRMbtGeGAvCjT9PZpugVqm9mXH3G
         9JX/9l1N5K7XCUASfy8wSi9bopnDYCRpaD8R8H2g0/xKTTEt7b9msny2FJW1OlLl81wh
         lTag==
X-Gm-Message-State: AGi0PuZV9Almq9n31vq+Af5rh3m/PYjDVFvdYz2TwtjrU2p5giAwLBdX
        ZRs7M+DGF+29JO5PxIX2eGFlHQ==
X-Google-Smtp-Source: APiQypL7cFU1hSU7+qLXSpXGz3Q+V+lYL3g+H9DsPNQWRZEMG+qUMJm1RQhpmZXQ8v3vWqRD6JZkVg==
X-Received: by 2002:a17:902:a706:: with SMTP id w6mr22444142plq.79.1586203158400;
        Mon, 06 Apr 2020 12:59:18 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i4sm12091324pfq.82.2020.04.06.12.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 12:59:17 -0700 (PDT)
Date:   Mon, 6 Apr 2020 13:59:15 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] dt-bindings: remoteproc: Add bindings for R5F
 subsystem on TI K3 SoCs
Message-ID: <20200406195915.GB11572@xps15>
References: <20200324201819.23095-1-s-anna@ti.com>
 <20200324201819.23095-4-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324201819.23095-4-s-anna@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 03:18:15PM -0500, Suman Anna wrote:
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
> Hi Rob,
> 
> The dt_bindings_check seems to throw couple of warnings around the
> usage of ranges because the tooling is adding the #address-cells
> and #size-cells of 1 by default, whereas our actual code uses 2.
> No issues are found with dtbs_check.
> 
> regards
> Suman
> 
>  .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  | 338 ++++++++++++++++++
>  1 file changed, 338 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> new file mode 100644
> index 000000000000..bbfc1e6ae884
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> @@ -0,0 +1,338 @@
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
> +# Required properties:
> +# --------------------
> +# The following are the mandatory properties:
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
> +      specifier containing the R5FSS device id value. This property is
> +      as per the binding,
> +      Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
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
> +  lockstep-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    description: |
> +      Configuration Mode for the Dual R5F cores within the R5F
> +      cluster. Should be either a value of 1 (LockStep mode) or
> +      0 (Split mode), default is LockStep mode if omitted.

Should I deduce lockstep means SMP and split mode two processors running in UP
mode?

> +
> +# R5F Processor Child Nodes:
> +# ==========================
> +
> +patternProperties:
> +  "^r5f@[a-f0-9]+$":
> +    type: object
> +    description: |
> +        The R5F Sub-System device node should define two R5F child nodes, each
> +        node representing a TI instantiation of the Arm Cortex R5F core. There
> +        are some specific integration differences for the IP like the usage of
> +        a Region Address Translator (RAT) for translating the larger SoC bus
> +        addresses into a 32-bit address space for the processor.
> +
> +# Required properties:
> +# --------------------
> +# The following are the mandatory properties:
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - ti,am654-r5f
> +          - ti,j721e-r5f
> +
> +      reg:
> +        description: |
> +          Should contain an entry for each value in 'reg-names'.
> +          Each entry should have the memory region's start address
> +          and the size of the region, the representation matching
> +          the parent node's '#address-cells' and '#size-cells' values.
> +        maxItems: 2
> +
> +      reg-names:
> +        description: |
> +          Should contain strings with the names of the specific internal
> +          internal memory regions, and should be defined in this order

There is two "internal" in a row.

> +        maxItems: 2
> +        items:
> +          - const: atcm
> +          - const: btcm
> +
> +      ti,sci:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description:
> +          Should be a phandle to the TI-SCI System Controller node
> +
> +      ti,sci-dev-id:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          Should contain the TI-SCI device id corresponding to the R5F core.
> +          Please refer to the corresponding System Controller documentation
> +          for valid values for the R5F cores.
> +
> +      ti,sci-proc-ids:
> +        description: Should contain a single tuple of <proc_id host_id>.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +          - maxItems: 1
> +            items:
> +              items:
> +                - description: TI-SCI processor id for the R5F core device
> +                - description: TI-SCI host id to which processor control
> +                               ownership should be transferred to
> +
> +      resets:
> +        description: |
> +          Should contain the phandle to the reset controller node
> +          managing the resets for this device, and a reset
> +          specifier. Please refer to the following reset bindings
> +          for the reset argument specifier,
> +          Documentation/devicetree/bindings/reset/ti,sci-reset.txt
> +            for AM65x and J721E SoCs
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
> +          with the sub-mailbox node used in the firmware image. The specifier
> +          format is as per the bindings,
> +          Documentation/devicetree/bindings/mailbox/omap-mailbox.txt

In the example below node "mcu_r5f1" has a "mboxes" property despite being in lockstep mode.  I
haven't delved in the code yet, perharps I'll find an answer in there.

> +
> +      memory-region:
> +        minItems: 2
> +        description: |
> +          phandle to the reserved memory nodes to be associated with the remoteproc
> +          device. There should be atleast two reserved memory nodes defined - the

s/atleast/at least

> +          first one would be used for dynamic DMA allocations like vrings and vring
> +          buffers, and the remaining ones used for the firmware image sections. The
> +          reserved memory nodes should be carveout nodes, and should be defined as
> +          per the bindings in
> +          Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> +
> +# Optional properties:
> +# --------------------
> +# The following properties are optional properties for each of the R5F cores:
> +
> +      atcm-enable:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]
> +        description: |
> +          R5F core configuration mode dictating if ATCM should be enabled. R5F
> +          view of ATCM dictated by loczrama property. Should be either a value
> +          of 1 (enabled) or 0 (disabled), default is disabled if omitted.

What is ATCM and why would one want to enable the feature?

> +
> +      btcm-enable:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]
> +        description: |
> +          R5F core configuration mode dictating if BTCM should be enabled. R5F
> +          view of BTCM dictated by loczrama property. Should be either a value
> +          of 1 (enabled) or 0 (disabled), default is enabled if omitted.

Same here, there is no way to tell what BTCM is.

> +
> +      loczrama:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]
> +        description: |
> +          R5F core configuration mode dictating which TCM should appear at
> +          address 0 (from core's view). Should be either a value of 1 (ATCM
> +          at 0x0) or 0 (BTCM at 0x0), default value is 1 if omitted.

loczrama: Location Zero Ram Address?  Can both core show up at the address 0x0?
In the example below both cores have the same setting for atcm, btcm and
loczrama.

> +
> +      sram:
> +        $ref: /schemas/types.yaml#/definitions/phandle-array
> +        minItems: 1
> +        description: |
> +          pHandles to one or more reserved on-chip SRAM region. The regions
> +          should be defined as child nodes of the respective SRAM node, and
> +          should be defined as per the generic bindings in,
> +          Documentation/devicetree/bindings/sram/sram.yaml

Is the behaviour the same whether operating in locksetup mode and split mode? 

Thanks,
Mathieu

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
> +    additionalProperties: false
> +
> +required:
> + - compatible
> + - power-domains
> + - "#address-cells"
> + - "#size-cells"
> + - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    //Example: AM654 SoC
> +    /* R5F DDR Carveout reserved memory nodes */
> +    reserved-memory {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        ranges;
> +
> +        mcu_r5fss0_core1_dma_memory_region: r5f-dma-memory@9b000000 {
> +            compatible = "shared-dma-pool";
> +            reg = <0x00 0x9b000000 0x00 0x100000>;
> +            no-map;
> +        };
> +
> +        mcu_r5fss0_core1_memory_region: r5f-memory@9b100000 {
> +            compatible = "shared-dma-pool";
> +            reg = <0x00 0x9b100000 0x00 0xf00000>;
> +            no-map;
> +        };
> +
> +        mcu_r5fss0_core0_dma_memory_region: r5f-dma-memory@9c000000 {
> +            compatible = "shared-dma-pool";
> +            reg = <0x00 0x9c000000 0x00 0x100000>;
> +            no-map;
> +        };
> +
> +        mcu_r5fss0_core0_memory_region: r5f-memory@9c100000 {
> +            compatible = "shared-dma-pool";
> +            reg = <0x00 0x9c100000 0x00 0x700000>;
> +            no-map;
> +        };
> +    };
> +
> +    cbass_main: interconnect@100000 {
> +        compatible = "simple-bus";
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        ranges = <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>,
> +                 <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>,
> +                 <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00080000>;
> +
> +        cbass_mcu: interconnect@28380000 {
> +            compatible = "simple-bus";
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges = <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>, /* MCU R5F Core0 */
> +                     <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>, /* MCU R5F Core1 */
> +                     <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00080000>; /* MCU SRAM */
> +
> +            /* MCU domain SRAM node */
> +            mcu_ram: mcu-ram@41c00000 {
> +                compatible = "mmio-sram";
> +                reg = <0x00 0x41c00000 0x00 0x80000>;
> +                ranges = <0x0 0x00 0x41c00000 0x80000>;
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +
> +                mcu_r5fss0_core0_sram: r5f-sram@0 {
> +                    reg = <0x0 0x40000>;
> +                };
> +            };
> +
> +            /* AM65x MCU R5FSS node */
> +            mcu_r5fss0: r5fss@41000000 {
> +                compatible = "ti,am654-r5fss";
> +                power-domains = <&k3_pds 129>;
> +                lockstep-mode = <1>;
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +                ranges = <0x41000000 0x00 0x41000000 0x20000>,
> +                         <0x41400000 0x00 0x41400000 0x20000>;
> +
> +                mcu_r5f0: r5f@41000000 {
> +                    compatible = "ti,am654-r5f";
> +                    reg = <0x41000000 0x00008000>,
> +                          <0x41010000 0x00008000>;
> +                    reg-names = "atcm", "btcm";
> +                    ti,sci = <&dmsc>;
> +                    ti,sci-dev-id = <159>;
> +                    ti,sci-proc-ids = <0x01 0xFF>;
> +                    resets = <&k3_reset 159 1>;
> +                    firmware-name = "am65x-mcu-r5f0_0-fw";
> +                    atcm-enable = <1>;
> +                    btcm-enable = <1>;
> +                    loczrama = <1>;
> +                    mboxes = <&mailbox0 &mbox_mcu_r5fss0_core0>;
> +                    memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
> +                                    <&mcu_r5fss0_core0_memory_region>;
> +                    sram = <&mcu_r5fss0_core0_sram>;
> +                };
> +
> +                mcu_r5f1: r5f@41400000 {
> +                    compatible = "ti,am654-r5f";
> +                    reg = <0x41400000 0x00008000>,
> +                          <0x41410000 0x00008000>;
> +                    reg-names = "atcm", "btcm";
> +                    ti,sci = <&dmsc>;
> +                    ti,sci-dev-id = <245>;
> +                    ti,sci-proc-ids = <0x02 0xFF>;
> +                    resets = <&k3_reset 245 1>;
> +                    firmware-name = "am65x-mcu-r5f0_1-fw";
> +                    atcm-enable = <1>;
> +                    btcm-enable = <1>;
> +                    loczrama = <1>;
> +                    mboxes = <&mailbox1 &mbox_mcu_r5fss0_core1>;
> +               };
> +           };
> +        };
> +    };
> -- 
> 2.23.0
> 
