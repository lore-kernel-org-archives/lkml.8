Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEABC2BB86
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39E5214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Y1L9e7i/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgDJLXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:23:55 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:40362 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgDJLXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:23:55 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9976A329;
        Fri, 10 Apr 2020 13:23:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1586517832;
        bh=aeaAolB7sW6j82qCRABmz/gvzp/EpmroY6OY5hT5q4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y1L9e7i/nMOh9GfBiwd0G2puGhZPaeqAGgg7WvNPWoOzGW/uHGsYUhx2Wt0T6bMSz
         XuH6aDkMohnx/Fb4aLYqnKKSHh62+WDx7AKtJ7qM5mo/HGTylYJr0ghGyvAyB9ZVbU
         ANq/NIIG/t8DUx2+uDr75UQJUJZBieMU+BsEprys=
Date:   Fri, 10 Apr 2020 14:23:42 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v11 1/2] dt-bindings: display/bridge: Add binding for NWL
 mipi dsi host controller
Message-ID: <20200410112342.GB4751@pendragon.ideasonboard.com>
References: <cover.1586427783.git.agx@sigxcpu.org>
 <147ffc1e4dee3a623e5dca25d84565d386a34112.1586427783.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <147ffc1e4dee3a623e5dca25d84565d386a34112.1586427783.git.agx@sigxcpu.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

Thank you for the patch.

On Thu, Apr 09, 2020 at 12:42:01PM +0200, Guido Günther wrote:
> The Northwest Logic MIPI DSI IP core can be found in NXPs i.MX8 SoCs.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Tested-by: Robert Chiras <robert.chiras@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> ---
>  .../bindings/display/bridge/nwl-dsi.yaml      | 226 ++++++++++++++++++
>  1 file changed, 226 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> new file mode 100644
> index 000000000000..8aff2d68fc33
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> @@ -0,0 +1,226 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/nwl-dsi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Northwest Logic MIPI-DSI controller on i.MX SoCs
> +
> +maintainers:
> +  - Guido Gúnther <agx@sigxcpu.org>
> +  - Robert Chiras <robert.chiras@nxp.com>
> +
> +description: |
> +  NWL MIPI-DSI host controller found on i.MX8 platforms. This is a dsi bridge for
> +  the SOCs NWL MIPI-DSI host controller.
> +
> +properties:
> +  compatible:
> +    const: fsl,imx8mq-nwl-dsi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  clocks:
> +    items:
> +      - description: DSI core clock
> +      - description: RX_ESC clock (used in escape mode)
> +      - description: TX_ESC clock (used in escape mode)
> +      - description: PHY_REF clock
> +      - description: LCDIF clock
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: rx_esc
> +      - const: tx_esc
> +      - const: phy_ref
> +      - const: lcdif
> +
> +  mux-controls:
> +    description:
> +      mux controller node to use for operating the input mux
> +
> +  phys:
> +    maxItems: 1
> +    description:
> +      A phandle to the phy module representing the DPHY
> +
> +  phy-names:
> +    items:
> +      - const: dphy
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +      - description: dsi byte reset line
> +      - description: dsi dpi reset line
> +      - description: dsi esc reset line
> +      - description: dsi pclk reset line
> +
> +  reset-names:
> +    items:
> +      - const: byte
> +      - const: dpi
> +      - const: esc
> +      - const: pclk
> +
> +  ports:
> +    type: object
> +    description:
> +      A node containing DSI input & output port nodes with endpoint
> +      definitions as documented in
> +      Documentation/devicetree/bindings/graph.txt.
> +    properties:
> +      port@0:
> +        type: object
> +        description:
> +          Input port node to receive pixel data from the
> +          display controller. Exactly one endpoint must be
> +          specified.
> +        properties:
> +          '#address-cells':
> +            const: 1
> +
> +          '#size-cells':
> +            const: 0
> +
> +          endpoint@0:
> +            description: sub-node describing the input from LCDIF
> +            type: object
> +
> +          endpoint@1:
> +            description: sub-node describing the input from DCSS
> +            type: object

This models the two inputs to the IP core, that are connected to a mux
internally, controlled through mux-controls, right ? Why is a single
endpoint supported then, if there are two connections at the hardware
level, and why is this using endpoints instead of ports as there are
really two input ports ?

Apart from that the bindings look ok to me.

> +
> +          reg:
> +            const: 0
> +
> +        required:
> +          - '#address-cells'
> +          - '#size-cells'
> +          - reg
> +
> +        oneOf:
> +          - required:
> +              - endpoint@0
> +          - required:
> +              - endpoint@1
> +
> +        additionalProperties: false
> +
> +      port@1:
> +        type: object
> +        description:
> +          DSI output port node to the panel or the next bridge
> +          in the chain
> +
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +    required:
> +      - '#address-cells'
> +      - '#size-cells'
> +      - port@0
> +      - port@1
> +
> +    additionalProperties: false
> +
> +patternProperties:
> +  "^panel@[0-9]+$":
> +    type: object
> +
> +required:
> +  - '#address-cells'
> +  - '#size-cells'
> +  - clock-names
> +  - clocks
> +  - compatible
> +  - interrupts
> +  - mux-controls
> +  - phy-names
> +  - phys
> +  - ports
> +  - reg
> +  - reset-names
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> + - |
> +
> +   #include <dt-bindings/clock/imx8mq-clock.h>
> +   #include <dt-bindings/interrupt-controller/arm-gic.h>
> +   #include <dt-bindings/reset/imx8mq-reset.h>
> +
> +   mipi_dsi: mipi_dsi@30a00000 {
> +              #address-cells = <1>;
> +              #size-cells = <0>;
> +              compatible = "fsl,imx8mq-nwl-dsi";
> +              reg = <0x30A00000 0x300>;
> +              clocks = <&clk IMX8MQ_CLK_DSI_CORE>,
> +                       <&clk IMX8MQ_CLK_DSI_AHB>,
> +                       <&clk IMX8MQ_CLK_DSI_IPG_DIV>,
> +                       <&clk IMX8MQ_CLK_DSI_PHY_REF>,
> +                       <&clk IMX8MQ_CLK_LCDIF_PIXEL>;
> +              clock-names = "core", "rx_esc", "tx_esc", "phy_ref", "lcdif";
> +              interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +              mux-controls = <&mux 0>;
> +              power-domains = <&pgc_mipi>;
> +              resets = <&src IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N>,
> +                       <&src IMX8MQ_RESET_MIPI_DSI_DPI_RESET_N>,
> +                       <&src IMX8MQ_RESET_MIPI_DSI_ESC_RESET_N>,
> +                       <&src IMX8MQ_RESET_MIPI_DSI_PCLK_RESET_N>;
> +              reset-names = "byte", "dpi", "esc", "pclk";
> +              phys = <&dphy>;
> +              phy-names = "dphy";
> +
> +              panel@0 {
> +                      #address-cells = <1>;
> +                      #size-cells = <0>;
> +                      compatible = "rocktech,jh057n00900";
> +                      reg = <0>;
> +                      port@0 {
> +                           reg = <0>;
> +                           panel_in: endpoint {
> +                                     remote-endpoint = <&mipi_dsi_out>;
> +                           };
> +                      };
> +              };
> +
> +              ports {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
> +                    port@0 {
> +                           #size-cells = <0>;
> +                           #address-cells = <1>;
> +                           reg = <0>;
> +                           mipi_dsi_in: endpoint@0 {
> +                                        reg = <0>;
> +                                        remote-endpoint = <&lcdif_mipi_dsi>;
> +                           };
> +                    };
> +                    port@1 {
> +                           reg = <1>;
> +                           mipi_dsi_out: endpoint {
> +                                         remote-endpoint = <&panel_in>;
> +                           };
> +                    };
> +              };
> +      };

-- 
Regards,

Laurent Pinchart
