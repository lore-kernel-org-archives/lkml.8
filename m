Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17D9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87CCA20829
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgG2N1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 09:27:37 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:43788 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgG2N1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 09:27:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id E767AFB05;
        Wed, 29 Jul 2020 15:27:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3xIffyALAbLL; Wed, 29 Jul 2020 15:27:30 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 346BB45341; Wed, 29 Jul 2020 15:27:30 +0200 (CEST)
Date:   Wed, 29 Jul 2020 15:27:30 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, lukas@mntmn.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 5/5] dt-bindings: display: imx: add bindings for DCSS
Message-ID: <20200729132730.GA266947@bogon.m.sigxcpu.org>
References: <20200724090736.12228-1-laurentiu.palcu@oss.nxp.com>
 <20200724090736.12228-6-laurentiu.palcu@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724090736.12228-6-laurentiu.palcu@oss.nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, Jul 24, 2020 at 12:07:34PM +0300, Laurentiu Palcu wrote:
> From: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> 
> Add bindings for iMX8MQ Display Controller Subsystem.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/display/imx/nxp,imx8mq-dcss.yaml | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml b/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
> new file mode 100644
> index 000000000000..68e4635e4874
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 NXP
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/display/imx/nxp,imx8mq-dcss.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: iMX8MQ Display Controller Subsystem (DCSS)
> +
> +maintainers:
> +  - Laurentiu Palcu <laurentiu.palcu@nxp.com>
> +
> +description:
> +
> +  The DCSS (display controller sub system) is used to source up to three
> +  display buffers, compose them, and drive a display using HDMI 2.0a(with HDCP
> +  2.2) or MIPI-DSI. The DCSS is intended to support up to 4kp60 displays. HDR10
> +  image processing capabilities are included to provide a solution capable of
> +  driving next generation high dynamic range displays.
> +
> +properties:
> +  compatible:
> +    const: nxp,imx8mq-dcss
> +
> +  reg:
> +    items:
> +      - description: DCSS base address and size, up to IRQ steer start
> +      - description: DCSS BLKCTL base address and size
> +
> +  interrupts:
> +    items:
> +      - description: Context loader completion and error interrupt
> +      - description: DTG interrupt used to signal context loader trigger time
> +      - description: DTG interrupt for Vblank
> +
> +  interrupt-names:
> +    items:
> +      - const: ctxld
> +      - const: ctxld_kick
> +      - const: vblank
> +
> +  clocks:
> +    items:
> +      - description: Display APB clock for all peripheral PIO access interfaces
> +      - description: Display AXI clock needed by DPR, Scaler, RTRAM_CTRL
> +      - description: RTRAM clock
> +      - description: Pixel clock, can be driven either by HDMI phy clock or MIPI
> +      - description: DTRC clock, needed by video decompressor
> +
> +  clock-names:
> +    items:
> +      - const: apb
> +      - const: axi
> +      - const: rtrm
> +      - const: pix
> +      - const: dtrc
> +
> +  assigned-clocks:
> +    items:
> +      - description: Phandle and clock specifier of IMX8MQ_CLK_DISP_AXI_ROOT
> +      - description: Phandle and clock specifier of IMX8MQ_CLK_DISP_RTRM
> +      - description: Phandle and clock specifier of either IMX8MQ_VIDEO2_PLL1_REF_SEL or
> +                     IMX8MQ_VIDEO_PLL1_REF_SEL
> +
> +  assigned-clock-parents:
> +    items:
> +      - description: Phandle and clock specifier of IMX8MQ_SYS1_PLL_800M
> +      - description: Phandle and clock specifier of IMX8MQ_SYS1_PLL_800M
> +      - description: Phandle and clock specifier of IMX8MQ_CLK_27M
> +
> +  assigned-clock-rates:
> +    items:
> +      - description: Must be 800 MHz
> +      - description: Must be 400 MHz
> +
> +  port:
> +    type: object
> +    description:
> +      A port node pointing to the input port of a HDMI/DP or MIPI display bridge.
> +
> +additionalProperties: false
> +
> +examples:
> +  - |

it would be nice to

    #include <dt-bindings/clock/imx8mq-clock.h>

here...

> +    dcss: display-controller@32e00000 {
> +        compatible = "nxp,imx8mq-dcss";
> +        reg = <0x32e00000 0x2d000>, <0x32e2f000 0x1000>;
> +        interrupts = <6>, <8>, <9>;
> +        interrupt-names = "ctxld", "ctxld_kick", "vblank";
> +        interrupt-parent = <&irqsteer>;
> +        clocks = <&clk 248>, <&clk 247>, <&clk 249>,
> +                 <&clk 254>,<&clk 122>;
> +        clock-names = "apb", "axi", "rtrm", "pix", "dtrc";
> +        assigned-clocks = <&clk 107>, <&clk 109>, <&clk 266>;
> +        assigned-clock-parents = <&clk 78>, <&clk 78>, <&clk 3>;

so that clock names like IMX8MQ_CLK_DISP_AXI could be used to make this
even more useful.

Cheers,
 -- Guido

> +        assigned-clock-rates = <800000000>,
> +                               <400000000>;
> +        port {
> +            dcss_out: endpoint {
> +                remote-endpoint = <&hdmi_in>;
> +            };
> +        };
> +    };
> +
> -- 
> 2.23.0
> 
