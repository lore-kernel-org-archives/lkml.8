Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B62C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6811720714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584992492;
	bh=CrE65C1TRdjfFULKVF5LdT3dnJlWpv3LoEItHijvno8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tJ6s2jjk+uGi2bxtdU3XGmE92DF6Vf+IniwWPyG8BL9lStH1zupVzg5wYyifJCFKI
	 Wetl2gmBYY8AXUr/CpIpxyvHa3ugPNmqf+SbWveQAwlGIALDz8Iv+FM5CQjbnioP7R
	 g/xMqXoDX8C9zHVDQD1k4sAwMZDpAdf6o9Z9Upc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgCWTlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:41:31 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:35397 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgCWTlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:41:31 -0400
Received: by mail-il1-f194.google.com with SMTP id 7so1101778ill.2;
        Mon, 23 Mar 2020 12:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wZqIgGpvp/4WvbCX5pHBFK/yoCSdaoYyZWmUWDi0I6w=;
        b=hPpZj0T6bKmfVj3rUOSothTo0JzP2D4l4rYhCBXZj8terTiB1j0AC6xtb30exOFNOR
         8yaVeFIkJdcXrhEfO/vObQLPaskZbPJNhB1qvKBIMZf1c1TsQKcG7BuDi299mNygVWOB
         OLKDwBDzZkLt9+t0GW+M07Tk2OmMnqE4EccZFdGKOvfgJ14GjKu7GMBmQ5jcuuzodIQt
         6UhRphFSFE1LrOQZ75zq9Z6s4ntdMEu5S+d087q15ucsNmXESx/6TJgL311cB75NSKmM
         Une15jd2q2r5CIOIEmSTACXG5Btx5waWccvJgkptDZZGtgZlTmS0Dmsfbv+lPADaLVUI
         tuag==
X-Gm-Message-State: ANhLgQ2lJerMXUwmIkXya43bBYUzBh2yMPCP5mELcgzrTbeQDGXMdYoT
        oqOonWOeUdglALerkXR5A7cBdqM=
X-Google-Smtp-Source: ADFU+vvGYTk0BRk7h8eRIHfK7+xZWKAn2MCIiE63wBii1saw9W0SBjLLJ/OUebYGdQPaJwZK8SFAlw==
X-Received: by 2002:a92:41c7:: with SMTP id o190mr22269984ila.11.1584992489760;
        Mon, 23 Mar 2020 12:41:29 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m14sm795371ilr.16.2020.03.23.12.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:41:29 -0700 (PDT)
Received: (nullmailer pid 15741 invoked by uid 1000);
        Mon, 23 Mar 2020 19:41:28 -0000
Date:   Mon, 23 Mar 2020 13:41:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, hjc@rock-chips.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: display: rockchip: convert rockchip vop
 bindings to yaml
Message-ID: <20200323194128.GD8470@bogus>
References: <20200306170353.11393-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306170353.11393-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 06:03:53PM +0100, Johan Jonker wrote:
> Current dts files with 'vop' nodes are manually verified.
> In order to automate this process rockchip-vop.txt
> has to be converted to yaml. Also included are new
> properties needed for the latest Rockchip Socs.
> 
> Added properties:
>   assigned-clocks
>   assigned-clock-rates
>   power-domains
>   rockchip,grf
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../bindings/display/rockchip/rockchip-vop.txt     |  74 -----------
>  .../bindings/display/rockchip/rockchip-vop.yaml    | 141 +++++++++++++++++++++
>  2 files changed, 141 insertions(+), 74 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml


> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml
> new file mode 100644
> index 000000000..93ccd32aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml
> @@ -0,0 +1,141 @@
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

Use an 'enum' instead of oneOf+const.

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

maxItems and the description disagree.

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

Just maxItems is enough.

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
> +  assigned-clocks:
> +    maxItems: 2
> +
> +  assigned-clock-rates:
> +    maxItems: 2
> +
> +  iommus:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  rockchip,grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      The phandle of the syscon node for
> +      the general register file (GRF).
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
> -- 
> 2.11.0
> 
