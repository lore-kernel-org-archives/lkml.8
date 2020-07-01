Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9CDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188152082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="H/T1TXu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbgGAQcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:32:31 -0400
Received: from vps.xff.cz ([195.181.215.36]:52930 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731770AbgGAQca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593621147; bh=yQdyiwJG0A0w25TNt5S9+Tyx+rihJlmHrZ5Ch0iuRzo=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=H/T1TXu+32OpzHlT61UjI0935+8p6dAuEkqfx9vm7iFtVjPE4z/J+Zf3Eva+u61dD
         lhphd6NgFd7dBXdwVuKBgneRowDJ2HWBkotWxkYXj6hEcv5K3Tm/bm1tAPiTooX6et
         O7zdc3SpFdseCm+TyAwBulGGQ+w+KxdHGPvEHjFc=
Date:   Wed, 1 Jul 2020 18:32:27 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Guido =?utf-8?Q?G=C3=BCnther?= <guido.gunther@puri.sm>
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
Message-ID: <20200701163227.on7wo6fo5majket6@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Guido =?utf-8?Q?G=C3=BCnther?= <guido.gunther@puri.sm>,
        linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
References: <20200701103126.1512615-1-megous@megous.com>
 <20200701103126.1512615-3-megous@megous.com>
 <20200701155857.GB174356@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701155857.GB174356@bogon.m.sigxcpu.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guido,

On Wed, Jul 01, 2020 at 05:58:57PM +0200, Guido Günther wrote:
> Hi Ondrej,
> On Wed, Jul 01, 2020 at 12:31:15PM +0200, Ondrej Jirman wrote:
> > Convert Rocktech MIPI DSI panel driver from txt to yaml bindings.
> > 
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > ---
> >  .../display/panel/rocktech,jh057n00900.txt    | 23 -------
> >  .../display/panel/rocktech,jh057n00900.yaml   | 66 +++++++++++++++++++
> >  2 files changed, 66 insertions(+), 23 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> 
> Thanks for the conversion! Shouldn't we switch to `sitronix-st7703.yaml`
> as well in this patch?

Names of yaml files should be according to one of the compatibles.

And thank you for your review of the patches.

regards,
	o.

> Cheers,
>  -- Guido
> 
> > 
> > diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
> > deleted file mode 100644
> > index a372c5d84695..000000000000
> > --- a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
> > +++ /dev/null
> > @@ -1,23 +0,0 @@
> > -Rocktech jh057n00900 5.5" 720x1440 TFT LCD panel
> > -
> > -Required properties:
> > -- compatible: should be "rocktech,jh057n00900"
> > -- reg: DSI virtual channel of the peripheral
> > -- reset-gpios: panel reset gpio
> > -- backlight: phandle of the backlight device attached to the panel
> > -- vcc-supply: phandle of the regulator that provides the vcc supply voltage.
> > -- iovcc-supply: phandle of the regulator that provides the iovcc supply
> > -  voltage.
> > -
> > -Example:
> > -
> > -	&mipi_dsi {
> > -		panel@0 {
> > -			compatible = "rocktech,jh057n00900";
> > -			reg = <0>;
> > -			backlight = <&backlight>;
> > -			reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
> > -			vcc-supply = <&reg_2v8_p>;
> > -			iovcc-supply = <&reg_1v8_p>;
> > -		};
> > -	};
> > diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> > new file mode 100644
> > index 000000000000..928ba42e7f8d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> > @@ -0,0 +1,66 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/panel/rocktech,jh057n00900.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rocktech JH057N00900 5.5" 720x1440 TFT LCD panel
> > +
> > +maintainers:
> > +  - Ondrej Jirman <megi@xff.cz>
> > +
> > +description: |
> > +             Rocktech JH057N00900 is a 720x1440 TFT LCD panel
> > +             connected using a MIPI-DSI video interface.
> > +
> > +allOf:
> > +  - $ref: panel-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: rocktech,jh057n00900
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: DSI virtual channel
> > +
> > +  vcc-supply:
> > +    description: Panel power supply
> > +
> > +  iovcc-supply:
> > +    description: I/O voltage supply
> > +
> > +  reset-gpios:
> > +    description: GPIO used for the reset pin
> > +    maxItems: 1
> > +
> > +  backlight:
> > +    description: Backlight used by the panel
> > +    $ref: "/schemas/types.yaml#/definitions/phandle"
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vcc-supply
> > +  - iovcc-supply
> > +  - reset-gpios
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    dsi {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +      panel@0 {
> > +        compatible = "rocktech,jh057n00900";
> > +        reg = <0>;
> > +        vcc-supply = <&reg_2v8_p>;
> > +        iovcc-supply = <&reg_1v8_p>;
> > +        reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
> > +        backlight = <&backlight>;
> > +      };
> > +    };
> > +...
> > -- 
> > 2.27.0
> > 
