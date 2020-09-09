Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240D2C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E262228A
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599664980;
	bh=tM5snS//h/e7EQ06jlx7lfN6U8tLMdLL8+JPpa90vnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UrN3k3HmIVRs9LbEY4u5Skt/A+iOxY8vHkROZs+1QGgVdXNG4UNm90qud5Jf6PJ3V
	 PbMl9wTixF36dXj05St5R/sD7S8sCMQvhMQibGvZza+Tm+Pjfs5oz1r8DGShZRgGoH
	 YM+M/3GKa/ZY0j+CxMaS48Jhwx8hHGMhxpDK+634=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgIIPWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:22:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgIIL2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 07:28:31 -0400
Received: from localhost (unknown [122.179.21.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C456521D7E;
        Wed,  9 Sep 2020 11:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599650835;
        bh=tM5snS//h/e7EQ06jlx7lfN6U8tLMdLL8+JPpa90vnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MfvK1PCU8BLI1AE1/u7ohhZn/IMHaar4w1qShyo0aWQTqwSBcMFoFXdirCMRKlEP+
         /JXuTCxLgkj7o/Mk6YvUMORmqXwtAE1xCEjrkXYgAUx/HiRHYVavEwZ1saCuIOk6DU
         DgZ+7gMRrei821PqE8fc73P0MOgUFiMNc8Ivae0g=
Date:   Wed, 9 Sep 2020 16:57:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, chuanhua.lei@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        malliamireddy009@gmail.com, peter.ujfalusi@ti.com
Subject: Re: [PATCH v6 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
Message-ID: <20200909112708.GN77521@vkoul-mobl>
References: <cover.1599605765.git.mallikarjunax.reddy@linux.intel.com>
 <ff2de5b0e4cd414420d48377c7c97c45d71f6197.1599605765.git.mallikarjunax.reddy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff2de5b0e4cd414420d48377c7c97c45d71f6197.1599605765.git.mallikarjunax.reddy@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amireddy,

On 09-09-20, 07:07, Amireddy Mallikarjuna reddy wrote:
> Add DT bindings YAML schema for DMA controller driver
> of Lightning Mountain(LGM) SoC.
> 
> Signed-off-by: Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
> ---
> v1:
> - Initial version.
> 
> v2:
> - Fix bot errors.
> 
> v3:
> - No change.
> 
> v4:
> - Address Thomas langer comments
>   - use node name pattern as dma-controller as in common binding.
>   - Remove "_" (underscore) in instance name.
>   - Remove "port-" and "chan-" in attribute name for both 'dma-ports' & 'dma-channels' child nodes.
> 
> v5:
> - Moved some of the attributes in 'dma-ports' & 'dma-channels' child nodes to dma client/consumer side as cells in 'dmas' properties.
> 
> v6:
> - Add additionalProperties: false
> - completely removed 'dma-ports' and 'dma-channels' child nodes.
> - Moved channel dt properties to client side dmas.
> - Use standard dma-channels and dma-channel-mask properties.
> - Documented reset-names
> - Add description for dma-cells
> ---
>  .../devicetree/bindings/dma/intel,ldma.yaml        | 154 +++++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/intel,ldma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
> new file mode 100644
> index 000000000000..4a2a12b829eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/intel,ldma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lightning Mountain centralized low speed DMA and high speed DMA controllers.
> +
> +maintainers:
> +  - chuanhua.lei@intel.com
> +  - mallikarjunax.reddy@intel.com
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> + $nodename:
> +   pattern: "^dma-controller(@.*)?$"
> +
> + compatible:
> +  enum:
> +   - intel,lgm-cdma
> +   - intel,lgm-dma2tx
> +   - intel,lgm-dma1rx
> +   - intel,lgm-dma1tx
> +   - intel,lgm-dma0tx
> +   - intel,lgm-dma3
> +   - intel,lgm-toe-dma30
> +   - intel,lgm-toe-dma31

Should this not say oneOf?

> +
> + reg:
> +  maxItems: 1
> +
> + "#dma-cells":
> +  const: 11

wow that is a big one

> +  description:
> +    The first & second cell is channel and port id's respectievly.

What does port id mean?

Can you please describe each parameter

> +    Third & fourth cells is Per channel data & descriptor endianness configuration respectievly according to SoC requirement.

What does per channel data refer? Isnt this all little endian?

> +    Fifth cell is Per channel byte offset(0~128)

Offset of?

> +    Sixth cell is per channel Write non-posted type for DMA RX last data beat of every descriptor.

Am not sure what this means?

> +    Seventh cell is per channel packet drop enabled or disabled.

Same here

> +    Eighth and nighth cells, The first is header mode size, the second is checksum enable or disable.
> +       If enabled, header mode size is ignored. If disabled, header mode size must be provided.
> +    Last two cells is Per channel dma hardware descriptor configuration.
> +       The first parameter is descriptor physical address and the second parameter hardware descriptor number

Do you really use all these parameters, or most of them are filled with
defaults?

> +
> + dma-channels:
> +  minimum: 1
> +  maximum: 16
> +
> + dma-channel-mask:
> +  $ref: /schemas/types.yaml#/definitions/uint32-array

This is already defined in
Documentation/devicetree/bindings/dma/dma-common.yaml, no need to define
this here

> +  items:
> +    minItems: 1
> +    # Should be enough

> +
> + clocks:
> +  maxItems: 1
> +
> + resets:
> +  maxItems: 1
> +
> + reset-names:
> +  items:
> +    - const: ctrl
> +
> + interrupts:
> +  maxItems: 1
> +
> + intel,dma-poll-cnt:
> +   $ref: /schemas/types.yaml#definitions/uint32
> +   description:
> +     DMA descriptor polling counter. It may need fine tune according
> +     to the system application scenario.

What does this mean? How will system application fine tune?

> +
> + intel,dma-byte-en:
> +   type: boolean
> +   description:
> +     DMA byte enable is only valid for DMA write(RX).
> +     Byte enable(1) means DMA write will be based on the number of dwords
> +     instead of the whole burst.

You already have this in #dma-cells, so why here. If here then why in
dma-cells

> +
> + intel,dma-drb:
> +    type: boolean
> +    description:
> +      DMA descriptor read back to make sure data and desc synchronization.

I think this is also in #dma-cells?

> +
> + intel,dma-burst:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description:
> +       Specifiy the DMA burst size(in dwords), the valid value will be 8, 16, 32.
> +       Default is 16 for data path dma, 32 is for memcopy DMA.

Burst should come from client, why is this here?

> +
> + intel,dma-polling-cnt:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description:
> +       DMA descriptor polling counter. It may need fine tune according to
> +       the system application scenario.

What does this counter do?

> +
> + intel,dma-desc-in-sram:
> +    type: boolean
> +    description:
> +       DMA descritpors in SRAM or not. Some old controllers descriptors
> +       can be in DRAM or SRAM. The new ones are all in SRAM.

What does this do?

> +
> + intel,dma-orrc:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description:
> +       DMA outstanding read counter. The maximum value is 16, and it may
> +       need fine tune according to the system application scenarios.

What does this do?

> +
> + intel,dma-dburst-wr:
> +    type: boolean
> +    description:
> +       Enable RX dynamic burst write. It only applies to RX DMA and memcopy DMA.

What does this do?

> +
> +required:
> + - compatible
> + - reg
> + - '#dma-cells'
> +
> +additionalProperties: false
> +
> +examples:
> + - |
> +   dma0: dma-controller@e0e00000 {
> +     compatible = "intel,lgm-cdma";
> +     reg = <0xe0e00000 0x1000>;
> +     #dma-cells = <11>;
> +     dma-channels = <16>;
> +     dma-channel-mask = <0xFFFF>;
> +     interrupt-parent = <&ioapic1>;
> +     interrupts = <82 1>;
> +     resets = <&rcu0 0x30 0>;
> +     reset-names = "ctrl";
> +     clocks = <&cgu0 80>;
> +     intel,dma-poll-cnt = <4>;
> +     intel,dma-byte-en;
> +     intel,dma-drb;
> +   };
> + - |
> +   dma3: dma-controller@ec800000 {
> +     compatible = "intel,lgm-dma3";
> +     reg = <0xec800000 0x1000>;
> +     clocks = <&cgu0 71>;
> +     resets = <&rcu0 0x10 9>;
> +     #dma-cells = <11>;
> +     intel,dma-burst = <32>;
> +     intel,dma-polling-cnt = <16>;
> +     intel,dma-desc-in-sram;
> +     intel,dma-orrc = <16>;
> +     intel,dma-byte-en;
> +     intel,dma-dburst-wr;
> +   };
> -- 
> 2.11.0

-- 
~Vinod
