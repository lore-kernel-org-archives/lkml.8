Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675A4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43AD42075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aDCiK9iv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgG2RLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 13:11:00 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33990 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbgG2RK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 13:10:59 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DE22429E;
        Wed, 29 Jul 2020 19:10:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1596042657;
        bh=riwybW52EjlFX38PbzROSyTfxzjJON7hQACGRPsGFqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aDCiK9ivoRvkZNPZgMRw4Oi/wfssbYvl0JQ9tXWoU+XCfzqRw12iwFb831vGoOPXP
         QVSMzw38dLJLUgqnX2bwFpXgUYFMcKyvFnOCH32VvlumEQvHNDIMd1PbOMWjRBqY29
         qMQialmS1i97H78AOWJdP75VZSsyhyl5nTrTCFAk=
Date:   Wed, 29 Jul 2020 20:10:47 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        devicetree@vger.kernel.org, od@zcrc.me,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/6] dt-bindings: display: Document NewVision NV3052C DT
 node
Message-ID: <20200729171047.GA18755@pendragon.ideasonboard.com>
References: <20200727164613.19744-1-paul@crapouillou.net>
 <20200727164613.19744-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200727164613.19744-2-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thank you for the patch.

On Mon, Jul 27, 2020 at 06:46:08PM +0200, Paul Cercueil wrote:
> Add documentation for the Device Tree node for LCD panels based on the
> NewVision NV3052C controller.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
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

s/driver/driver IC/ (or driver chip, or controller, or any other similar
term) to avoid confusion with device drivers.

Do I understand that the NV3052C also supports control through DSI ?
Shouldn't this appear in the DT bindings ? Do I assume correctly that
the panel will be controlled either through SPI or through DSI, but not
through both ?

> +
> +maintainers:
> +  - Paul Cercueil <paul@crapouillou.net>
> +
> +description: |
> +  This is a driver for 320x240 TFT panels, accepting a variety of input
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

According to its datasheet, that panel is 640x480 :-)

I think you need a bit of documentation to explain that two compatible
strings are needed, one matching the panel type, and a second one
matching the chip.

> +
> +      - const: newvision,nv3052c
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios: true
> +  port: true

The NV3052C requires multiple power supplies, I think this needs to be
taken into account here.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
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
> +
> +        port {
> +          panel_input: endpoint {
> +              remote-endpoint = <&panel_output>;
> +          };
> +        };
> +      };
> +    };
> +
> +...

-- 
Regards,

Laurent Pinchart
