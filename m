Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDAEC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 15:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA40206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 15:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbgCKPG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 11:06:28 -0400
Received: from regular1.263xmail.com ([211.150.70.195]:58740 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbgCKPG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:06:28 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Mar 2020 11:06:04 EDT
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id A0C77BB0;
        Wed, 11 Mar 2020 22:56:53 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.2.106] (unknown [112.49.214.205])
        by smtp.263.net (postfix) whith ESMTP id P30134T140169747363584S1583938607895180_;
        Wed, 11 Mar 2020 22:56:54 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <d997085203b868c662318d0858d02951>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 112.49.214.205
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v2] dt-bindings: display: convert rockchip vop bindings to
 yaml
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200311130515.10663-1-jbx6244@gmail.com>
From:   "sandy.huang" <hjc@rock-chips.com>
Message-ID: <28eb8ff1-b180-ebf7-a74c-966c6c7df2db@rock-chips.com>
Date:   Wed, 11 Mar 2020 22:56:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311130515.10663-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi johan,

ÔÚ 2020/3/11 21:05, Johan Jonker Ð´µÀ:
> Current dts files with 'vop' nodes are manually verified.
> In order to automate this process rockchip-vop.txt
> has to be converted to yaml.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> Changes v2:
>    No new properties
> ---
>   .../bindings/display/rockchip/rockchip-vop.txt     |  74 ------------
>   .../bindings/display/rockchip/rockchip-vop.yaml    | 126 +++++++++++++++++++++
>   2 files changed, 126 insertions(+), 74 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
>   create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
> deleted file mode 100644
> index 8b3a5f514..000000000
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
> +++ /dev/null
> @@ -1,74 +0,0 @@
> -device-tree bindings for rockchip soc display controller (vop)
> -
> -VOP (Visual Output Processor) is the Display Controller for the Rockchip

Can you change (Visual Out Processor) to (Video Out Processor) by the 
way, we have change this at the latest TRM document. thanks.

> -series of SoCs which transfers the image data from a video memory
> -buffer to an external LCD interface.
> -
> -Required properties:
> -- compatible: value should be one of the following
> -		"rockchip,rk3036-vop";
> -		"rockchip,rk3126-vop";
> -		"rockchip,px30-vop-lit";
> -		"rockchip,px30-vop-big";
> -		"rockchip,rk3066-vop";
> -		"rockchip,rk3188-vop";
> -		"rockchip,rk3288-vop";
> -		"rockchip,rk3368-vop";
> -		"rockchip,rk3366-vop";
> -		"rockchip,rk3399-vop-big";
> -		"rockchip,rk3399-vop-lit";
> -		"rockchip,rk3228-vop";
> -		"rockchip,rk3328-vop";
> -
> -- reg: Must contain one entry corresponding to the base address and length
> -	of the register space. Can optionally contain a second entry
> -	corresponding to the CRTC gamma LUT address.
> -
> -- interrupts: should contain a list of all VOP IP block interrupts in the
> -		 order: VSYNC, LCD_SYSTEM. The interrupt specifier
> -		 format depends on the interrupt controller used.
> -
> -- clocks: must include clock specifiers corresponding to entries in the
> -		clock-names property.
> -
> -- clock-names: Must contain
> -		aclk_vop: for ddr buffer transfer.
> -		hclk_vop: for ahb bus to R/W the phy regs.
> -		dclk_vop: pixel clock.
> -
> -- resets: Must contain an entry for each entry in reset-names.
> -  See ../reset/reset.txt for details.
> -- reset-names: Must include the following entries:
> -  - axi
> -  - ahb
> -  - dclk
> -
> -- iommus: required a iommu node
> -
> -- port: A port node with endpoint definitions as defined in
> -  Documentation/devicetree/bindings/media/video-interfaces.txt.
> -
> -Example:
> -SoC specific DT entry:
> -	vopb: vopb@ff930000 {
> -		compatible = "rockchip,rk3288-vop";
> -		reg = <0x0 0xff930000 0x0 0x19c>, <0x0 0xff931000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru ACLK_VOP0>, <&cru DCLK_VOP0>, <&cru HCLK_VOP0>;
> -		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
> -		resets = <&cru SRST_LCDC1_AXI>, <&cru SRST_LCDC1_AHB>, <&cru SRST_LCDC1_DCLK>;
> -		reset-names = "axi", "ahb", "dclk";
> -		iommus = <&vopb_mmu>;
> -		vopb_out: port {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			vopb_out_edp: endpoint@0 {
> -				reg = <0>;
> -				remote-endpoint=<&edp_in_vopb>;
> -			};
> -			vopb_out_hdmi: endpoint@1 {
> -				reg = <1>;
> -				remote-endpoint=<&hdmi_in_vopb>;
> -			};
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml
> new file mode 100644
> index 000000000..cb88849f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml
> @@ -0,0 +1,126 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/rockchip/rockchip-vop.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip soc display controller (VOP)
> +
> +description:
> +  VOP (Visual Output Processor) is the Display Controller for the Rockchip
> +  series of SoCs which transfers the image data from a video memory
> +  buffer to an external LCD interface.
> +
> +maintainers:
> +  - Sandy Huang <hjc@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: rockchip,px30-vop-big
> +      - const: rockchip,px30-vop-lit
> +      - const: rockchip,rk3036-vop
> +      - const: rockchip,rk3066-vop
> +      - const: rockchip,rk3126-vop
> +      - const: rockchip,rk3188-vop
> +      - const: rockchip,rk3228-vop
> +      - const: rockchip,rk3288-vop
> +      - const: rockchip,rk3328-vop
> +      - const: rockchip,rk3366-vop
> +      - const: rockchip,rk3368-vop
> +      - const: rockchip,rk3399-vop-big
> +      - const: rockchip,rk3399-vop-lit
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description:
> +          Must contain one entry corresponding to the base address and length
> +          of the register space.
> +      - description:
> +          Can optionally contain a second entry corresponding to
> +          the CRTC gamma LUT address.
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Should contain a list of all VOP IP block interrupts in the
> +      order VSYNC, LCD_SYSTEM. The interrupt specifier
> +      format depends on the interrupt controller used.
> +
> +  clocks:
> +    items:
> +      - description: Clock for ddr buffer transfer.
> +      - description: Pixel clock.
> +      - description: Clock for the ahb bus to R/W the phy regs.
> +
> +  clock-names:
> +    items:
> +      - const: aclk_vop
> +      - const: dclk_vop
> +      - const: hclk_vop
> +
> +  resets:
> +    minItems: 3
> +    maxItems: 3
> +
> +  reset-names:
> +    items:
> +      - const: axi
> +      - const: ahb
> +      - const: dclk
> +
> +  port:
> +    type: object
> +    description:
> +      A port node with endpoint definitions as defined in
> +      Documentation/devicetree/bindings/media/video-interfaces.txt.
> +
> +  iommus:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3288-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    vopb: vopb@ff930000 {
> +      compatible = "rockchip,rk3288-vop";
> +      reg = <0x0 0xff930000 0x0 0x19c>,
> +            <0x0 0xff931000 0x0 0x1000>;
> +      interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&cru ACLK_VOP0>,
> +               <&cru DCLK_VOP0>,
> +               <&cru HCLK_VOP0>;
> +      clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
> +      resets = <&cru SRST_LCDC1_AXI>,
> +               <&cru SRST_LCDC1_AHB>,
> +               <&cru SRST_LCDC1_DCLK>;
> +      reset-names = "axi", "ahb", "dclk";
> +      iommus = <&vopb_mmu>;
> +      vopb_out: port {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        vopb_out_edp: endpoint@0 {
> +          reg = <0>;
> +          remote-endpoint=<&edp_in_vopb>;
> +        };
> +        vopb_out_hdmi: endpoint@1 {
> +          reg = <1>;
> +          remote-endpoint=<&hdmi_in_vopb>;
> +        };
> +      };
> +    };


