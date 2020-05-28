Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CE1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C60F208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590705159;
	bh=hiIVcOB9zDMhtlOg+537fpD+ryBzyvkqlEjVqF+GA1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gY/NogCS9gtrJPKs/8SlCFZ38Uy4yL+S6A34p7JJd0Q1kGXQP+slCc+vazNvl15rA
	 KMQ8IzUp4TQSJY8fC5pnXoAkS2IVXs3+m/ppQcZv0X7ySNnZDFUMdUXHT+tTYZqxXs
	 mpUAJ9UHbjXjQ+k618f91hwLl7xFCIKcXwZKqJBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437181AbgE1Wci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:32:38 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46066 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436952AbgE1Wcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:32:32 -0400
Received: by mail-io1-f65.google.com with SMTP id y5so219088iob.12;
        Thu, 28 May 2020 15:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2iWkmtIIPdkQ7s2OlH5ICkwWkQE9JDegAoIkBuC4Mh8=;
        b=Pt5qzLEk8u4Vj0eMPinhlr2fre6hqfndBnnQE8TuN1RhaC7YHBcotVmU59Y7rklB+L
         wCvILnTlwERbB15GziQMWNsoytZKo9WPmRPjwbjEvAlQgxYEGqhQIeGNbb2MVNs7I4kT
         iRsEr1udJF202Y9PAWZjPTVdGA3psMScd56PWK4wgZADYVE/TqSig0w3ZhlWLAyYD484
         NMFj5VHXu3c0Q0oeDXcxsUaKZguww8ehoWaQE0wKiMPmFS6VfedEz5EGK/zkBuFrqJGV
         TmotOR0WhWTDyURWD/J24tY4VOPyWclPBwBsETRrPCAjlQnUbQ7S1I11yNZPtSHf673T
         R8lQ==
X-Gm-Message-State: AOAM531PBuiWcSv4Tv4JIGOlIGIq3nPpCPvr+VsASzp1EYLfi9FMXyPc
        TQgUWXDiSKBgOWWTm4xnug==
X-Google-Smtp-Source: ABdhPJwgO1mB4nZ0UFl0QlAt68U8U2JNLntupIY0/f1e3wwkTyNZyAnbKB9gbovv/3kUpAWC6z7GTw==
X-Received: by 2002:a5e:de03:: with SMTP id e3mr4247972iok.0.1590705150063;
        Thu, 28 May 2020 15:32:30 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id 4sm3980244ilc.34.2020.05.28.15.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 15:32:29 -0700 (PDT)
Received: (nullmailer pid 801318 invoked by uid 1000);
        Thu, 28 May 2020 22:32:28 -0000
Date:   Thu, 28 May 2020 16:32:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: remoteproc: Add bindings for C66x
 DSPs on TI K3 SoCs
Message-ID: <20200528223228.GA785633@bogus>
References: <20200521001006.2725-1-s-anna@ti.com>
 <20200521001006.2725-3-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521001006.2725-3-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 07:10:04PM -0500, Suman Anna wrote:
> Some Texas Instruments K3 family of SoCs have one of more Digital Signal
> Processor (DSP) subsystems that are comprised of either a TMS320C66x
> CorePac and/or a next-generation TMS320C71x CorePac processor subsystem.
> Add the device tree bindings document for the C66x DSP devices on these
> SoCs. The added example illustrates the DT nodes for the first C66x DSP
> device present on the K3 J721E family of SoCs.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> v2:
>  - Updated the example to include the root-node to fix the bot errors from v1

Pretty sure that was not why you had errors.

>  - Added maxItems to resets, mboxes, memory-region, sram properties
>  - Changed the ti,sci-proc-ids $ref to uint-array from uint-matrix
>  - Addressed the minor review comments from Mathieu
> v1: https://patchwork.kernel.org/patch/11458571/
> 
>  .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 190 ++++++++++++++++++
>  1 file changed, 190 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> new file mode 100644
> index 000000000000..cdf649655838
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> @@ -0,0 +1,190 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI K3 DSP devices
> +
> +maintainers:
> +  - Suman Anna <s-anna@ti.com>
> +
> +description: |
> +  The TI K3 family of SoCs usually have one or more TI DSP Core sub-systems
> +  that are used to offload some of the processor-intensive tasks or algorithms,
> +  for achieving various system level goals.
> +
> +  These processor sub-systems usually contain additional sub-modules like
> +  L1 and/or L2 caches/SRAMs, an Interrupt Controller, an external memory
> +  controller, a dedicated local power/sleep controller etc. The DSP processor
> +  cores in the K3 SoCs are usually either a TMS320C66x CorePac processor or a
> +  TMS320C71x CorePac processor.
> +
> +  Each DSP Core sub-system is represented as a single DT node. Each node has a
> +  number of required or optional properties that enable the OS running on the
> +  host processor (Arm CorePac) to perform the device management of the remote
> +  processor and to communicate with the remote processor.
> +
> +properties:
> +  compatible:
> +    const: ti,j721e-c66-dsp
> +    description:
> +      Use "ti,j721e-c66-dsp" for C66x DSPs on K3 J721E SoCs

What else are you going to use? There's only one compatible string. Drop 
description.

> +
> +  reg:
> +    description: |
> +      Should contain an entry for each value in 'reg-names'.
> +      Each entry should have the memory region's start address
> +      and the size of the region, the representation matching
> +      the parent node's '#address-cells' and '#size-cells' values.

Don't need generic descriptions. That's every 'reg'.

What you can do is an 'items' list describing what each region is.

> +    minItems: 3
> +    maxItems: 3
> +
> +  reg-names:
> +    description: |
> +      Should contain strings with the names of the specific internal
> +      memory regions, and should be defined in this order

Again, drop.

> +    maxItems: 3
> +    items:
> +      - const: l2sram
> +      - const: l1pram
> +      - const: l1dram
> +
> +  ti,sci:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Should be a phandle to the TI-SCI System Controller node
> +
> +  ti,sci-dev-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Should contain the TI-SCI device id corresponding to the DSP core.
> +      Please refer to the corresponding System Controller documentation
> +      for valid values for the DSP cores.
> +
> +  ti,sci-proc-ids:
> +    description: Should contain a single tuple of <proc_id host_id>.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - maxItems: 1
> +        items:
> +          items:
> +            - description: TI-SCI processor id for the DSP core device
> +            - description: TI-SCI host id to which processor control
> +                           ownership should be transferred to

I assume these properties appear in multiple TI nodes? We don't need 
them defined multiple times. Create a schema for them that you can 
include here.

> +
> +  resets:
> +    description: |
> +      Should contain the phandle to the reset controller node
> +      managing the local resets for this device, and a reset
> +      specifier. Please refer to the following reset bindings
> +      for the reset argument specifier,
> +      Documentation/devicetree/bindings/reset/ti,sci-reset.txt

Drop.

> +    maxItems: 1
> +
> +  firmware-name:
> +    description: |
> +      Should contain the name of the default firmware image
> +      file located on the firmware search path
> +
> +  mboxes:
> +    description: |
> +      OMAP Mailbox specifier denoting the sub-mailbox, to be used for
> +      communication with the remote processor. This property should match
> +      with the sub-mailbox node used in the firmware image. The specifier
> +      format is as per the bindings,
> +      Documentation/devicetree/bindings/mailbox/omap-mailbox.txt

Drop. What mailbox provider is used is outside the scope of this 
binding.

> +    maxItems: 1
> +
> +  memory-region:
> +    minItems: 2
> +    maxItems: 8
> +    description: |
> +      phandle to the reserved memory nodes to be associated with the remoteproc
> +      device. There should be at least two reserved memory nodes defined - the
> +      first one would be used for dynamic DMA allocations like vrings and vring
> +      buffers, and the remaining ones used for the firmware image sections. The
> +      reserved memory nodes should be carveout nodes, and should be defined as
> +      per the bindings in
> +      Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt

items:
  - description: dynamic DMA allocations like vrings and vring buffers
  - description: firmware image section ???
  - description: firmware image section ???

> +
> +# Optional properties:
> +# --------------------
> +
> +  sram:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    minItems: 1
> +    maxItems: 4
> +    description: |
> +      phandles to one or more reserved on-chip SRAM regions. The regions
> +      should be defined as child nodes of the respective SRAM node, and
> +      should be defined as per the generic bindings in,
> +      Documentation/devicetree/bindings/sram/sram.yaml
> +
> +required:
> + - compatible
> + - reg
> + - reg-names
> + - ti,sci
> + - ti,sci-dev-id
> + - ti,sci-proc-ids
> + - resets
> + - firmware-name
> + - mboxes
> + - memory-region
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    / {
> +        model = "Texas Instruments K3 J721E SoC";
> +        compatible = "ti,j721e";
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        /* DSP Carveout reserved memory nodes */
> +        reserved-memory {
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges;
> +
> +            c66_0_dma_memory_region: c66-dma-memory@a6000000 {
> +                compatible = "shared-dma-pool";
> +                reg = <0x00 0xa6000000 0x00 0x100000>;
> +                no-map;
> +            };
> +
> +            c66_0_memory_region: c66-memory@a6100000 {
> +                compatible = "shared-dma-pool";
> +                reg = <0x00 0xa6100000 0x00 0xf00000>;
> +                no-map;
> +            };
> +        };

Drop all of this. Outside the scope of this binding. And will likely 
start failing validation as schemas become more complete.

> +
> +        cbass_main: bus@100000 {

Drop unused labels.

> +            compatible = "simple-bus";
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
> +                     <0x4d 0x80800000 0x4d 0x80800000 0x00 0x00800000>, /* C66_0 */
> +                     <0x4d 0x81800000 0x4d 0x81800000 0x00 0x00800000>; /* C66_1 */
> +
> +            /* J721E C66_0 DSP node */
> +            c66_0: dsp@4d80800000 {
> +                compatible = "ti,j721e-c66-dsp";
> +                reg = <0x4d 0x80800000 0x00 0x00048000>,
> +                      <0x4d 0x80e00000 0x00 0x00008000>,
> +                      <0x4d 0x80f00000 0x00 0x00008000>;
> +                reg-names = "l2sram", "l1pram", "l1dram";
> +                ti,sci = <&dmsc>;
> +                ti,sci-dev-id = <142>;
> +                ti,sci-proc-ids = <0x03 0xFF>;
> +                resets = <&k3_reset 142 1>;
> +                firmware-name = "j7-c66_0-fw";
> +                memory-region = <&c66_0_dma_memory_region>,
> +                                <&c66_0_memory_region>;
> +                mboxes = <&mailbox0_cluster3 &mbox_c66_0>;
> +            };
> +        };
> +    };
> -- 
> 2.26.0
> 
