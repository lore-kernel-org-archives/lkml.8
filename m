Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BCBC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A67052078E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgG0TLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:11:00 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:34164 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbgG0TK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:10:59 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id CF9E98046C;
        Mon, 27 Jul 2020 21:10:53 +0200 (CEST)
Date:   Mon, 27 Jul 2020 21:10:52 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: display: Document NewVision NV3052C DT
 node
Message-ID: <20200727191052.GA1011220@ravnborg.org>
References: <20200727164613.19744-1-paul@crapouillou.net>
 <20200727164613.19744-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727164613.19744-2-paul@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8 a=gEfo2CItAAAA:8 a=cFL5_wh2AAAA:8
        a=47UgJTjCgcInOTyXzTsA:9 a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22
        a=sptkURWiP4Gy88Gu7hUp:22 a=yWaY75k36LOQ25BSl4KT:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Mon, Jul 27, 2020 at 06:46:08PM +0200, Paul Cercueil wrote:
> Add documentation for the Device Tree node for LCD panels based on the
> NewVision NV3052C controller.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Very happy to see work on RG-350 :-)
Some feedback below.

	Sam

> ---
>  .../display/panel/newvision,nv3052c.yaml      | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/newvision,nv3052c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/newvision,nv3052c.yaml b/Documentation/devicetree/bindings/display/panel/newvision,nv3052c.yaml
> new file mode 100644
> index 000000000000..751a28800fc2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/newvision,nv3052c.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/newvision,nv3052c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NewVision NV3052C TFT LCD panel driver with SPI control bus
> +
> +maintainers:
> +  - Paul Cercueil <paul@crapouillou.net>
> +
> +description: |
> +  This is a driver for 320x240 TFT panels,
The binding describes the HW, not the driver. So please re-phrase this
part.

This datasheet: https://www.phoenixdisplay.com/wp-content/uploads/2019/05/NV3052C-Datasheet-V0.2.pdf
tells that the driver supports additional resoltions.
I guess the 320x240 resolution is limited to the leadtek panel.

> +  accepting a variety of input
> +  streams that get adapted and scaled to the panel. The panel output has
> +  960 TFT source driver pins and 240 TFT gate driver pins, VCOM, VCOML and
> +  VCOMH outputs.
> +
> +  The panel must obey the rules for a SPI slave device as specified in
> +  spi/spi-controller.yaml
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        - leadtek,ltk035c5444t-spi
> +
> +      - const: newvision,nv3052c
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios: true
> +  port: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
Do the panel need any power?
I had expected to see a power-supply node as mandatory.

> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      display@0 {
> +        compatible = "leadtek,ltk035c5444t-spi", "newvision,nv3052c";
> +        reg = <0>;
> +
> +        spi-max-frequency = <15000000>;
> +        spi-3wire;
> +        reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;


> +        backlight = <&backlight>;
> +        power-supply = <&vcc>;
These would fail later due to "unevaluatedProperties: false".
Add them above like
  backlight: true
  power-supply: true

as done for reset-gpios for example.

> +
> +        port {
> +          panel_input: endpoint {
> +              remote-endpoint = <&panel_output>;
> +          };
> +        };
> +      };
> +    };
Personally I prefer 4 space indent. But there is no fixed rule (yet)
what to use.

> +
> +...
> -- 
> 2.27.0
