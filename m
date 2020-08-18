Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B0CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 812502075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="HBK6tJJm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iyeW5BON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgHYNoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:44:20 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:57653 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726580AbgHYNll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:41:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id BF02FC3B;
        Tue, 25 Aug 2020 09:35:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 25 Aug 2020 09:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=wnFngmVxQe9ellAXLU5CQNGZLaT
        U205LKAOzn3wlRqU=; b=HBK6tJJms/969m5VWNmWqcVVYMLeyty5RDjESPuZYhD
        SGqcE9pCrYcmja+5EpLc4wgIVOzC7aB7gU/ExidvY5JXTXKeGb17VYt3HwNl1iq2
        GiIi6/wtFKjvECLBobvovK8iIQPEWbbaz8pEfYCBT3Q9QUALbEEuQqNWhyYIWyFK
        QsFJZ4qqE/unHRFbPPDOwfM1gYIn2uQyg4etN3j+WuQ/nLZlMg3T+zVl3KXaSzP6
        gfR7aknu/67jQ9zyM8JeuTn7wrLOz5gwF+jXREi8yqvzwPn8MOs1ABRuEnDLCtKz
        0eQx0DWRlVMa9X+CVNHdd9SCvi00uC1ktWwr5yWLHtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=wnFngm
        VxQe9ellAXLU5CQNGZLaTU205LKAOzn3wlRqU=; b=iyeW5BON3G1yMIUwb1DJM1
        em61RHNn1c3w3plXRzoT1uaA/jHHy748vB7B2c4CdhKe108WQZLn2tiHL/uYakjM
        lYxnHrzy8/QgTOgJWP+c9aa6vyyVTYvPM5buRhXNn8uzTO6I7znAKUXrOAo8cN3d
        FrmkmAMJCFAgI8pTHTO+tOk/H/MCwfMN6u87/iY4YMdhbSiyLGG65xbICtcNnZXD
        vU3PxPu9jNdzeYImER0lcyZVIOvLQqfVaI2AQqYx/baDxhgPI7t8oXW++T994/so
        CSPwEBqQ6jZ3CHg77rkCgg+sn/xMuJ+PAo+y0XqwG16yUNVJAEtkkgOQBqVvev3w
        ==
X-ME-Sender: <xms:pBNFXxgeeWF0pBjAzCFgUYAdBerZ7OVz2TyfjXZLbWlTK5OVaT7O1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvgestggv
    rhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeettdeigedttddvuddvheduieefue
    dugfefieelkeetvdektdfhheehhfetvdehjeenucffohhmrghinhephigrmhhlrdhimhen
    ucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:pBNFX2B8sSeTlHDuy7xUSPGWOnM5969nfLRIvIkg5FpowhqDijqwTw>
    <xmx:pBNFXxGNMDzIqRCYJAzJlF5cx7cPx8RO8RhFBzQgKUDIGDuj8X9rxA>
    <xmx:pBNFX2TC-E1tC63w4W1hH0o8IDtM5phiRv7DE3TiHEj2wdnbxxd4uQ>
    <xmx:pBNFXy9aa_mGl2V3wCvQamrjXfg-jXDKuCAOOVEEP8aKRjCsRVrsig>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E2C143060067;
        Tue, 25 Aug 2020 09:35:31 -0400 (EDT)
Date:   Tue, 18 Aug 2020 11:39:52 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     stulluk@gmail.com
Cc:     robh+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
Subject: Re: arm: dts: allwinner: a20: Add Drejo DS167 initial support
Message-ID: <20200818093952.77ilfvgw2nzcwrme@gilmour.lan>
References: <20200802202924.5166-1-stulluk@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fesncdsf7l56tltx"
Content-Disposition: inline
In-Reply-To: <20200802202924.5166-1-stulluk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fesncdsf7l56tltx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 02, 2020 at 11:29:24PM +0300, stulluk@gmail.com wrote:
> From: Sertac TULLUK <stulluk@gmail.com>
>=20
> Drejo DS167 is an Allwinner A20 based IoT device, which support=20
>=20
> - Allwinner A20 Cortex-A7
> - Mali-400MP2 GPU
> - AXP209 PMIC
> - 1GB DDR3 RAM
> - 8GB eMMC
> - 10/100M Ethernet
> - SATA
> - HDMI
> - 10.1inch and 7.0inch LVDS LCD and Touch screens
> - CSI: OV5640 sensor
> - USB OTG
> - 2x USB2.0
> - builtin KNX Transceiver
> - 3x Dry Contact Input
> - 3x Relay output
> - IR
> - UART3
> - SPI1
> - RTC Battery
> - 8x GPIO
> - Analogue + Digital Microphone
> - PAM8620 speaker Amplifier
> - 12V DC power supply
> - 3.7V Battery Operable
>=20
> Signed-off-by: Sertac TULLUK <stulluk@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   2 +
>  .../boot/dts/sun7i-a20-drejo-ds167-emmc.dts   |  69 ++++
>  arch/arm/boot/dts/sun7i-a20-drejo-ds167.dts   | 361 ++++++++++++++++++
>  3 files changed, 432 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-drejo-ds167-emmc.dts
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-drejo-ds167.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 3823090d0..574305522 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1115,6 +1115,8 @@ dtb-$(CONFIG_MACH_SUN7I) +=3D \
>  	sun7i-a20-olinuxino-lime2-emmc.dtb \
>  	sun7i-a20-olinuxino-micro.dtb \
>  	sun7i-a20-olinuxino-micro-emmc.dtb \
> +	sun7i-a20-drejo-ds167.dtb \
> +	sun7i-a20-drejo-ds167-emmc.dtb \

Why do you need an emmc variant here?

>  	sun7i-a20-orangepi.dtb \
>  	sun7i-a20-orangepi-mini.dtb \
>  	sun7i-a20-pcduino3.dtb \
> diff --git a/arch/arm/boot/dts/sun7i-a20-drejo-ds167-emmc.dts b/arch/arm/=
boot/dts/sun7i-a20-drejo-ds167-emmc.dts
> new file mode 100644
> index 000000000..b6147eb01
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-drejo-ds167-emmc.dts
> @@ -0,0 +1,69 @@
> +/*
> + * Copyright 2020 Sertac TULLUK
> + *
> + * Sertac TULLUK <stulluk@gmail.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */

You should use an SPDX tag here instead

> +#include "sun7i-a20-drejo-ds167.dts"
> +
> +/ {
> +	model =3D "drejo DS167-eMMC";

What is the casing of the vendor name? You use an uppercase in the
commit title, but a lowercase letter here

> +	compatible =3D "drejo,sun7i-a20-drejo-ds167-emmc", "allwinner,sun7i-a20=
";

The vendor prefix must be documented in vendor-prefixes.yaml, and
similarly the board compatible must be documented in arm/sunxi.yaml.

I'm not really sure why you'd need a compatible so complicated. If the
DS167 ships only with an A20, then you can simply use drejo,ds167-emmc.
Also, adding the base board compatible would make sense here.

> +
> +	mmc2_pwrseq: pwrseq {
> +		compatible =3D "mmc-pwrseq-emmc";
> +		reset-gpios =3D <&pio 2 24 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&mmc2 {
> +	vmmc-supply =3D <&reg_vcc3v3>;
> +	bus-width =3D <4>;
> +	non-removable;
> +	mmc-pwrseq =3D <&mmc2_pwrseq>;
> +	status =3D "okay";
> +
> +	emmc: emmc@0 {
> +		reg =3D <0>;
> +		compatible =3D "mmc-card";
> +		broken-hpi;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/sun7i-a20-drejo-ds167.dts b/arch/arm/boot/=
dts/sun7i-a20-drejo-ds167.dts
> new file mode 100644
> index 000000000..1103a6082
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-drejo-ds167.dts
> @@ -0,0 +1,361 @@
> +/*
> + * Copyright 2020 Sertac TULLUK
> + *
> + * Sertac TULLUK <stulluk@gmail.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/dts-v1/;
> +#include "sun7i-a20.dtsi"
> +#include "sunxi-common-regulators.dtsi"

If you have the PMIC regulators support, then you don't really need that
DTSI.

> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	model =3D "drejo DS167";
> +	compatible =3D "drejo,sun7i-a20-drejo-ds167", "allwinner,sun7i-a20";
> +
> +	aliases {
> +		serial0 =3D &uart0;
> +		serial1 =3D &uart3;
> +
> +		spi0 =3D &spi1;
> +		spi1 =3D &spi2;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +        backlight: backlight {

The indentation is off here.

> +                compatible =3D "pwm-backlight";
> +
> +                brightness-levels =3D <0 1 2 4 8 16 32 64 128 255>;
> +                default-brightness-level =3D <9>;
> +        };

You're missing the pwm attached to the backlight.

> +
> +        panel {
> +                compatible =3D "drejo,ds167-10inch-panel", "panel-lvds";
> +                backlight =3D <&backlight>;
> +
> +                width-mm =3D <220>;
> +                height-mm =3D <132>;
> +                data-mapping =3D "vesa-24";
> +
> +                panel-timing {
> +                        /* 1280x800 @60Hz */
> +                        clock-frequency =3D <69000000>;
> +                        hactive =3D <1280>;
> +                        vactive =3D <800>;
> +                        hsync-len =3D <1>; /* hs */
> +                        hfront-porch =3D <118>; /* ri */
> +                        hback-porch =3D <19>; /* le */
> +                        vfront-porch =3D <6>; /* lo */
> +                        vback-porch =3D <9>; /* up */
> +                        vsync-len =3D <1>; /* vs */

The clock frequency doesn't match the timing you've set (it's supposed
to be 69425280 Hz).

Those comments are also fairly redundant with the name of the
properties.

> +                };
> +
> +                port {
> +                        panel_input: endpoint {
> +                                remote-endpoint =3D <&tcon0_out_lcd>;
> +                        };
> +                };
> +        };
> +=09
> +
> +	hdmi-connector {
> +		compatible =3D "hdmi-connector";
> +		type =3D "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint =3D <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&led_pins_ds167>;

You don't need the pinctrl properties here.

> +
> +		red {
> +			label =3D "ds167-status";

That's not the proper format for leds labels, see
Documentation/leds/leds-class.rst

> +			gpios =3D <&pio 8 9 GPIO_ACTIVE_LOW>;  /* PI9 STATUS LED NEAR A20 */
> +			default-state =3D "on";
> +		};
> +	};
> +};
> +
> +&ahci {
> +	target-supply =3D <&reg_ahci_5v>;
> +	status =3D "okay";
> +};
> +
> +&codec {
> +	status =3D "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply =3D <&reg_dcdc2>;
> +};
> +
> +&de {
> +	status =3D "okay";
> +};
> +
> +&ehci0 {
> +	status =3D "okay";
> +};
> +
> +&ehci1 {
> +	status =3D "okay";
> +};
> +
> +&gmac {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&gmac_mii_pins>, <&gmac_txerr>;
> +	phy-handle =3D <&phy1>;
> +	phy-mode =3D "mii";
> +	status =3D "okay";
> +};
> +
> +&mali {
> +	status =3D "okay";
> +};

The mali is always enabled

> +&hdmi {
> +	status =3D "okay";
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint =3D <&hdmi_con_in>;
> +	};
> +};
> +
> +&i2c0 {
> +	status =3D "okay";
> +
> +	axp209: pmic@34 {
> +		reg =3D <0x34>;
> +		interrupt-parent =3D <&nmi_intc>;
> +		interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&i2c1 {
> +	status =3D "okay";
> +};

What is connected to i2c1?

> +
> +

There's an extra new line here

> +&i2c2 {
> +	status =3D "okay";
> +
> +   	clock-frequency =3D <400000>;
> +        polytouch: edt-ft5x06@38 {

I'm not sure why you need a label, and the node name should be the class
of the device, not its model, so touchscreen

> +              compatible =3D "edt,edt-ft5406", "edt,edt-ft5x06";
> +              reg =3D <0x38>;
> +	      interrupt-parent =3D <&pio>;
> +	      interrupts =3D <7 21 IRQ_TYPE_EDGE_FALLING>; /* PH21 */
> +	      wake-gpios =3D <&pio 1 13 GPIO_ACTIVE_HIGH>; /* PB13 */
> +              touchscreen-size-x =3D <1200>;
> +              touchscreen-size-y =3D <800>;
> +       };

The indentation is off here too

> +};
> +
> +&i2c3 {
> +	status =3D "okay";
> +};

What is connected to i2c3?

> +
> +

Extra new line

> +&lradc {
> +	vref-supply =3D <&reg_vcc3v0>;
> +	status =3D "okay";
> +};
> +
> +&gmac_mdio {
> +	phy1: ethernet-phy@1 {
> +		reg =3D <1>;
> +	};
> +};
> +
> +&mmc0 {
> +	vmmc-supply =3D <&reg_vcc3v3>;

I guess it's a regulator supplied by the PMIC too?

> +	bus-width =3D <4>;
> +	cd-gpios =3D <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
> +	status =3D "okay";
> +};
> +
> +&ohci0 {
> +	status =3D "okay";
> +};
> +
> +&ohci1 {
> +	status =3D "okay";
> +};
> +
> +&otg_sram {
> +	status =3D "okay";
> +};
> +
> +&pio {
> +	gmac_txerr: gmac-txerr-pin {
> +		pins =3D "PA17";
> +		function =3D "gmac";
> +	};

This should be in the DTSI

> +	led_pins_ds167: led-pins { =20
> +		pins =3D "PI9";   /* Status led, on schematic, this is LED_EN */
> +		function =3D "gpio_out";
> +		drive-strength =3D <20>;
> +	};
> +};
> +
> +&pwm {
> +      pinctrl-names =3D "default";
> +      pinctrl-0 =3D <&pwm0_pin>, <&pwm1_pin>;
> +      status =3D "okay";
> +};
> +
> +#include "axp209.dtsi"
> +
> +&ac_power_supply {
> +	status =3D "okay";
> +};
> +
> +&battery_power_supply {
> +	status =3D "okay";
> +};
> +
> +&reg_dcdc2 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <1000000>;
> +	regulator-max-microvolt =3D <1400000>;
> +	regulator-name =3D "vdd-cpu";
> +};
> +
> +&reg_dcdc3 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <1000000>;
> +	regulator-max-microvolt =3D <1400000>;
> +	regulator-name =3D "vdd-int-dll";
> +};
> +
> +&reg_ldo2 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <3000000>;
> +	regulator-max-microvolt =3D <3000000>;
> +	regulator-name =3D "avcc";
> +};
> +
> +&reg_ahci_5v {
> +	status =3D "okay";
> +};
> +
> +&reg_usb0_vbus {
> +	status =3D "okay";
> +};
> +
> +&reg_usb1_vbus {
> +	status =3D "okay";
> +};
> +
> +&reg_usb2_vbus {
> +	status =3D "okay";
> +};
> +
> +&spi1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&spi1_pi_pins>,
> +		    <&spi1_cs0_pi_pin>;
> +	status =3D "okay";
> +};
> +
> +&spi2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&spi2_pc_pins>,
> +		    <&spi2_cs0_pc_pin>;
> +	status =3D "okay";
> +};

What is connected to the two SPI busses?

> +&tcon0 {
> +        pinctrl-names =3D "default";
> +        pinctrl-0 =3D <&lcd_lvds0_pins>;
> +};
> +
> +&tcon0_out {
> +        tcon0_out_lcd: endpoint {
> +                remote-endpoint =3D <&panel_input>;
> +        };
> +};
> +
> +

Extra new line here

Maxime

--fesncdsf7l56tltx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXzuh6AAKCRDj7w1vZxhR
xY9LAQDNrLAdnbnNJFQdXd229JtQYCiff89NdQ00HvEqcXJfSAD9HCNPUUd/mop9
h+Cac+RCHfqNvgOq366iHoimMkcNDwI=
=xW3f
-----END PGP SIGNATURE-----

--fesncdsf7l56tltx--
