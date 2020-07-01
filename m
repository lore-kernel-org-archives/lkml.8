Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4606BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33929206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbgGAP7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:59:03 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:34168 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbgGAP7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:59:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id E4648FB04;
        Wed,  1 Jul 2020 17:58:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HarL-GLC7aLb; Wed,  1 Jul 2020 17:58:58 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 08F4640972; Wed,  1 Jul 2020 17:58:58 +0200 (CEST)
Date:   Wed, 1 Jul 2020 17:58:57 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Subject: Re: [PATCH v6 02/13] dt-bindings: panel: Convert
 rocktech,jh057n00900 to yaml
Message-ID: <20200701155857.GB174356@bogon.m.sigxcpu.org>
References: <20200701103126.1512615-1-megous@megous.com>
 <20200701103126.1512615-3-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701103126.1512615-3-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondrej,
On Wed, Jul 01, 2020 at 12:31:15PM +0200, Ondrej Jirman wrote:
> Convert Rocktech MIPI DSI panel driver from txt to yaml bindings.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  .../display/panel/rocktech,jh057n00900.txt    | 23 -------
>  .../display/panel/rocktech,jh057n00900.yaml   | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
>  create mode 100644
> Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml

Thanks for the conversion! Shouldn't we switch to `sitronix-st7703.yaml`
as well in this patch?
Cheers,
 -- Guido

> 
> diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
> deleted file mode 100644
> index a372c5d84695..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -Rocktech jh057n00900 5.5" 720x1440 TFT LCD panel
> -
> -Required properties:
> -- compatible: should be "rocktech,jh057n00900"
> -- reg: DSI virtual channel of the peripheral
> -- reset-gpios: panel reset gpio
> -- backlight: phandle of the backlight device attached to the panel
> -- vcc-supply: phandle of the regulator that provides the vcc supply voltage.
> -- iovcc-supply: phandle of the regulator that provides the iovcc supply
> -  voltage.
> -
> -Example:
> -
> -	&mipi_dsi {
> -		panel@0 {
> -			compatible = "rocktech,jh057n00900";
> -			reg = <0>;
> -			backlight = <&backlight>;
> -			reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
> -			vcc-supply = <&reg_2v8_p>;
> -			iovcc-supply = <&reg_1v8_p>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> new file mode 100644
> index 000000000000..928ba42e7f8d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/rocktech,jh057n00900.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rocktech JH057N00900 5.5" 720x1440 TFT LCD panel
> +
> +maintainers:
> +  - Ondrej Jirman <megi@xff.cz>
> +
> +description: |
> +             Rocktech JH057N00900 is a 720x1440 TFT LCD panel
> +             connected using a MIPI-DSI video interface.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: rocktech,jh057n00900
> +
> +  reg:
> +    maxItems: 1
> +    description: DSI virtual channel
> +
> +  vcc-supply:
> +    description: Panel power supply
> +
> +  iovcc-supply:
> +    description: I/O voltage supply
> +
> +  reset-gpios:
> +    description: GPIO used for the reset pin
> +    maxItems: 1
> +
> +  backlight:
> +    description: Backlight used by the panel
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +
> +required:
> +  - compatible
> +  - reg
> +  - vcc-supply
> +  - iovcc-supply
> +  - reset-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      panel@0 {
> +        compatible = "rocktech,jh057n00900";
> +        reg = <0>;
> +        vcc-supply = <&reg_2v8_p>;
> +        iovcc-supply = <&reg_1v8_p>;
> +        reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
> +        backlight = <&backlight>;
> +      };
> +    };
> +...
> -- 
> 2.27.0
> 
