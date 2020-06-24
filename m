Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86099C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B55E2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="puGj3lyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389773AbgFXVIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:08:25 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56132 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388453AbgFXVIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:08:24 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OL88Ht114055;
        Wed, 24 Jun 2020 16:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593032888;
        bh=0hfApv4knRyVKaIA3g3GtdG0GI6yY99sLLLIR8z/lh0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=puGj3lycI5nVlwfgXdUpm46TYi7Y/XBjGl7vIDnIWb6icFLiqN3WNgdfEdFWDcmMf
         MM4oFCn5JjPH7VRDaj63a2x4n0zJcOu4O7oTiQoBKQn7/3Rir0+FPcxdigD1oswWUw
         aLCKtbqIk1ebxola3Vj66BIKS/V0VLKe/+G2Ai6g=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05OL88tA028275
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 16:08:08 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 16:08:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 16:08:08 -0500
Received: from [10.250.70.56] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OL87ic117344;
        Wed, 24 Jun 2020 16:08:08 -0500
Subject: Re: [PATCH v3 4/6] dt-bindings: remoteproc: Add bindings for C66x
 DSPs on TI K3 SoCs
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200612224914.7634-1-s-anna@ti.com>
 <20200612224914.7634-5-s-anna@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <50a1abf6-ecb0-b130-67be-20364965a514@ti.com>
Date:   Wed, 24 Jun 2020 16:08:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200612224914.7634-5-s-anna@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 6/12/20 5:49 PM, Suman Anna wrote:
> Some Texas Instruments K3 family of SoCs have one of more Digital Signal
> Processor (DSP) subsystems that are comprised of either a TMS320C66x
> CorePac and/or a next-generation TMS320C71x CorePac processor subsystem.
> Add the device tree bindings document for the C66x DSP devices on these
> SoCs. The added example illustrates the DT nodes for the first C66x DSP
> device present on the K3 J721E family of SoCs.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> v3:
>   - Refactored the common ti-sci properties "ti,sci", "ti,sci-dev-id" and
>     "ti,sci-proc-ids" into a separate binding ti,k3-sci-proc.yaml.
>   - Dropped the general description and maxItems against reg and reg-names
>   - Added items list under reg
>   - Removed the other binding references from the description for resets
>     and mboxes
>   - Revised the memory-region description and listed the mandatory items
>   - Updated example to drop reserved-memory nodes, unused node labels

Thanks for acking the corresponding C71x binding update [1] that is on 
top of this patch.

Can you provide your Ack for this updated patch and the refactored 
ti,k3-sci-proc.yaml binding if you don't have any comments?

regards
Suman

[1] https://patchwork.kernel.org/comment/23421509/


> v2: https://patchwork.kernel.org/patch/11561781/
> 
>   .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 139 ++++++++++++++++++
>   1 file changed, 139 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> new file mode 100644
> index 000000000000..f03e88c42a6e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> @@ -0,0 +1,139 @@
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
> +allOf:
> +  - $ref: "ti,k3-sci-proc.yaml#"
> +
> +properties:
> +  compatible:
> +    const: ti,j721e-c66-dsp
> +    description:
> +      Use "ti,j721e-c66-dsp" for C66x DSPs on K3 J721E SoCs
> +
> +  reg:
> +    items:
> +      - description: Address and Size of the L2 SRAM internal memory region
> +      - description: Address and Size of the L1 PRAM internal memory region
> +      - description: Address and Size of the L1 DRAM internal memory region
> +
> +  reg-names:
> +    items:
> +      - const: l2sram
> +      - const: l1pram
> +      - const: l1dram
> +
> +  resets:
> +    description: |
> +      Should contain the phandle to the reset controller node managing the
> +      local resets for this device, and a reset specifier.
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
> +      with the sub-mailbox node used in the firmware image.
> +    maxItems: 1
> +
> +  memory-region:
> +    minItems: 2
> +    maxItems: 8
> +    description: |
> +      phandle to the reserved memory nodes to be associated with the remoteproc
> +      device. There should be at least two reserved memory nodes defined. The
> +      reserved memory nodes should be carveout nodes, and should be defined as
> +      per the bindings in
> +      Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> +    items:
> +      - description: region used for dynamic DMA allocations like vrings and
> +                     vring buffers
> +      - description: region reserved for firmware image sections
> +    additionalItems: true
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
> + - resets
> + - firmware-name
> + - mboxes
> + - memory-region
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    / {
> +        model = "Texas Instruments K3 J721E SoC";
> +        compatible = "ti,j721e";
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        bus@100000 {
> +            compatible = "simple-bus";
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
> +                     <0x4d 0x80800000 0x4d 0x80800000 0x00 0x00800000>, /* C66_0 */
> +                     <0x4d 0x81800000 0x4d 0x81800000 0x00 0x00800000>; /* C66_1 */
> +
> +            /* J721E C66_0 DSP node */
> +            dsp@4d80800000 {
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
> 

