Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A05EC5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 01:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F09E20735
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 01:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VISn/IkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgDVBCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 21:02:15 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:52462 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgDVBCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 21:02:13 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E5A14528;
        Wed, 22 Apr 2020 03:02:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1587517330;
        bh=XX1giKYlvomjM0GrDvg49D+NLBn+obzSaYWrEoYpKv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VISn/IkG67pK7f4Oijn/HIb4sYL6Z5hqfOhpeD1LFSbJXo7m/xFeZZTAa88znlDmj
         33E9LqAWLvRaBZny4+fSmmRZBLtguKd4kfw8CnkGoEkF6Dm2jzBPz+BSFnZfw3Ll8t
         gIS9Iwda8sl+/DRFHOuz7QRe5KoNsuCgJvBCdlJQ=
Date:   Wed, 22 Apr 2020 04:01:55 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>, kernel@collabora.com,
        linux-stm32@st-md-mailman.stormreply.com, linux-imx@nxp.com,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Fabio Estevam <festevam@gmail.com>,
        Adrian Pop <pop.adrian61@gmail.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Sjoerd Simons <sjoerd.simons@collabora.com>,
        Martyn Welch <martyn.welch@collabora.com>
Subject: Re: [PATCH v7 5/8] dt-bindings: display: add i.MX6 MIPI DSI host
 controller doc
Message-ID: <20200422010155.GL5983@pendragon.ideasonboard.com>
References: <20200421161610.1501827-1-adrian.ratiu@collabora.com>
 <20200421161610.1501827-6-adrian.ratiu@collabora.com>
 <20200422005832.GK5983@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422005832.GK5983@pendragon.ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Wed, Apr 22, 2020 at 03:58:33AM +0300, Laurent Pinchart wrote:
> On Tue, Apr 21, 2020 at 07:16:07PM +0300, Adrian Ratiu wrote:
> > This provides an example DT binding for the MIPI DSI host controller
> > present on the i.MX6 SoC based on Synopsis DesignWare v1.01 IP.
> > 
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: devicetree@vger.kernel.org
> > Tested-by: Adrian Pop <pop.adrian61@gmail.com>
> > Tested-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.com>
> > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> > Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> > ---
> > Changes since v6:
> >   - Added ref to the newly created snps,dw-mipi-dsi.yaml (Laurent)
> >   - Moved *-cells properties outside patternProperties (Laurent)
> >   - Removed the panel port documentation (Laurent)
> >   - Wrapped lines at 80 chars, typo fixes, sort includes (Laurent)
> > 
> > Changes since v5:
> >   - Fixed missing reg warning (Fabio)
> >   - Updated dt-schema and fixed warnings (Rob)
> > 
> > Changes since v4:
> >   - Fixed yaml binding to pass `make dt_binding_check dtbs_check`
> >   and addressed received binding feedback (Rob)
> > 
> > Changes since v3:
> >   - Added commit message (Neil)
> >   - Converted to yaml format (Neil)
> >   - Minor dt node + driver fixes (Rob)
> >   - Added small panel example to the host controller binding
> > 
> > Changes since v2:
> >   - Fixed commit tags (Emil)
> > ---
> >  .../display/imx/fsl,mipi-dsi-imx6.yaml        | 135 ++++++++++++++++++
> >  1 file changed, 135 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml b/Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml
> > new file mode 100644
> > index 0000000000000..b73e3ae33a852
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml
> > @@ -0,0 +1,135 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/imx/fsl,mipi-dsi-imx6.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale i.MX6 DW MIPI DSI Host Controller
> > +
> > +maintainers:
> > +  - Adrian Ratiu <adrian.ratiu@collabora.com>
> > +
> > +description: |
> > +  The i.MX6 DSI host controller is a Synopsys DesignWare MIPI DSI v1.01
> > +  IP block with a companion PHY IP.

I forgot to mention, if there's a companion PHY, shouldn't it be
referenced from the DT bindings ?

> > +
> > +  These DT bindings follow the Synopsys DW MIPI DSI bindings defined in
> > +  Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt with
> > +  the following device-specific properties.
> > +
> > +allOf:
> > +  - $ref: ../bridge/snps,dw-mipi-dsi.yaml#
> > +
> > +properties:
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +  compatible:
> > +    items:
> > +      - const: fsl,imx6q-mipi-dsi
> > +      - const: snps,dw-mipi-dsi
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Module Clock
> > +      - description: DSI bus clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: ref
> > +      - const: pclk
> > +
> > +  fsl,gpr:
> > +    description:
> > +      Phandle to the iomuxc-gpr region containing the multiplexer ctrl register.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +
> > +  ports:
> > +    type: object
> > +    description: |
> > +      A node containing DSI input & output port nodes with endpoint
> > +      definitions as documented in
> > +      Documentation/devicetree/bindings/media/video-interfaces.txt
> > +      Documentation/devicetree/bindings/graph.txt
> > +    properties:
> > +      port@0:
> > +        type: object
> > +        description:
> > +          DSI input port node, connected to the ltdc rgb output port.
> > +
> > +      port@1:
> > +        type: object
> > +        description:
> > +          RGB output port node, connected to a panel or a bridge input port.
> 
> Isn't it the other way around, doesn't the bridge take RGB input and
> output DSI ? And to be precise, it's not about RGB, but about the input
> being parallel interface (DSI will also carry RGB).
> 
> I would add
> 
>     required:
>       - port@0
>       - port@1
> 
> > +
> > +additionalProperties: false
> > +
> > +patternProperties:
> > +  "^panel@[0-3]$":
> > +    type: object
> > +
> > +required:
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - ports
> > +
> > +examples:
> > +  - |+
> > +    #include <dt-bindings/clock/imx6qdl-clock.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    dsi: dsi@21e0000 {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        compatible = "fsl,imx6q-mipi-dsi", "snps,dw-mipi-dsi";
> > +        reg = <0x021e0000 0x4000>;
> > +        interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
> > +        fsl,gpr = <&gpr>;
> > +        clocks = <&clks IMX6QDL_CLK_MIPI_CORE_CFG>,
> > +                 <&clks IMX6QDL_CLK_MIPI_IPG>;
> > +        clock-names = "ref", "pclk";
> > +
> > +        ports {
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> 
> port@0 is missing.
> 
> > +            port@1 {
> > +                reg = <1>;
> > +                dsi_out: endpoint {
> > +                    remote-endpoint = <&panel_in>;
> > +                };
> > +            };
> > +        };
> > +
> > +        panel@0 {
> > +            compatible = "sharp,ls032b3sx01";
> > +            reg = <0>;
> > +            reset-gpios = <&gpio6 8 GPIO_ACTIVE_LOW>;
> > +            ports {
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +                port@0 {
> > +                    reg = <0>;
> > +                    panel_in: endpoint {
> > +                        remote-endpoint = <&dsi_out>;
> > +                    };
> > +                };
> > +            };
> > +        };
> > +    };
> > +
> > +...

-- 
Regards,

Laurent Pinchart
