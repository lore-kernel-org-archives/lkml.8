Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F372AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 10:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C82B5207BC
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 10:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="qXAQ32Ky";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zV2vMJA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgFAKtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 06:49:46 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:60777 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbgFAKtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 06:49:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 73BC0B18;
        Mon,  1 Jun 2020 06:49:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 01 Jun 2020 06:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=aG7fDfbT4McyryCzkaFMmjNQU0+
        CgMrudN7778MmqPs=; b=qXAQ32Kyc13dxduCkRXqP9ce2uXwrs40NqSPUksDq6k
        gxnlSRBH6Pn21FXettCkJb2wOSPPAVjNm6WaMLDmENMfNQ99isBPjvNAxMnNNVa5
        Udohvt5YVfjUR+1iWx3k9VAF3vpBWGWHDcxZKx8TKniljm/7dG314UyV+1H5dEpP
        VFId8qpLWQaT7+Mn/YIu9zSykPWb0n7HYFY+/RgKa4vP5h+D5nH9lQcC8d2Na7+l
        7LZPy0sVlyBHpejb83xt9CyxJyiWgY1L8+g56rzg9kqArL/w68g3MyOqrXlGt+IO
        ALaWT0Ptp78wrt0VEcxkd4310CXo8MqvYSwTHQi5B5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=aG7fDf
        bT4McyryCzkaFMmjNQU0+CgMrudN7778MmqPs=; b=zV2vMJA/js0GYttX6r1zRE
        gIvcRMz+hIQVCAR2lUx31L8+GNyoMI8RIG6DCkg5dOcELckGZ99RbjcZcZ4qZpxV
        7xKB06YjWo+6ygjIV/ptFf467V9js5vASOKvqaIC/2oYmNvyoZ/Cew1CswtyX2ZV
        x/yzcuQs0xFmL5Aio7EohAyzfwgzRAO5uIb0PFkbTs6t1wuuao5ELMW1Nhkhh4fV
        4KyIKPJbmDeX7p7QjjSe3FPUuZuqtIXrVaOdkZQeJeG57p7B5llHrjnf3UtqspOi
        ehRyB+TyfLFixr1GoAtLV3IOpTalRjRuI0Xps/q8ftJJIXIavlZDfyETFG9KVbZA
        ==
X-ME-Sender: <xms:RN3UXlSUaRe0mpnF4PKa46GI_S7aT7MMNcoOQNmGxfUcPVvmZj3Z_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefhedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvgestggv
    rhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeelkeeghefhuddtleejgfeljeffhe
    ffgfeijefhgfeufefhtdevteegheeiheegudenucfkphepledtrdekledrieekrdejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigih
    hmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:RN3UXuy7nbDUmvZB-0GkHCD8ztbl0ei9A-a6KO1D9EWKvVyUlnQG1w>
    <xmx:RN3UXq1j78bUphaEbt2yIWWnFXOrH6JTkg6X-Us8q1Aig9_n6Xl7_A>
    <xmx:RN3UXtBK2vUGyxFrAAwfj1TAdk9Jc1jdAZrWwbljzG9NkeF04FHE6Q>
    <xmx:Rd3UXhuB4VVR97kYbuQethhG5W0Bz55o4m0V1BdZSVPhH34EAFehSA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5F06830618C1;
        Mon,  1 Jun 2020 06:49:40 -0400 (EDT)
Date:   Mon, 1 Jun 2020 12:49:39 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     stulluk@gmail.com
Cc:     robh+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm: allwinner: a20: Add Drejo DS167 initial support
Message-ID: <20200601104939.ksvizszvchqfabnf@gilmour>
References: <20200531110538.30153-1-stulluk@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jw2e7ngd6l5xqz73"
Content-Disposition: inline
In-Reply-To: <20200531110538.30153-1-stulluk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jw2e7ngd6l5xqz73
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please make sure that all the proper recipients are in Cc. The
linux-arm-kernel ML especially is missing, get_maintainers will give you
the list.

Also, the prefix of your commit log is supposed to be

ARM: dts: sunxi: ...

On Sun, May 31, 2020 at 02:05:38PM +0300, stulluk@gmail.com wrote:
> From: Sertac TULLUK <stulluk@gmail.com>
>=20
> Drejo DS167 is an Allwinner A20 based IoT device,
> which support
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
> - built-in KNX Transceiver
> - 3x Dry Contact Input
> - 3x Relay output
> - IR RX/TX
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
>  .../boot/dts/sun7i-a20-drejo-ds167-emmc.dts   |  69 +++++
>  arch/arm/boot/dts/sun7i-a20-drejo-ds167.dts   | 288 ++++++++++++++++++
>  3 files changed, 359 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-drejo-ds167-emmc.dts
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-drejo-ds167.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 3823090d07e7..d81e685dee38 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1097,6 +1097,8 @@ dtb-$(CONFIG_MACH_SUN7I) +=3D \
>  	sun7i-a20-bananapro.dtb \
>  	sun7i-a20-cubieboard2.dtb \
>  	sun7i-a20-cubietruck.dtb \
> +	sun7i-a20-drejo-ds167.dtb \
> +        sun7i-a20-drejo-ds167-emmc.dtb \

You indented with spaces here, instead of a tab.

>  	sun7i-a20-hummingbird.dtb \
>  	sun7i-a20-itead-ibox.dtb \
>  	sun7i-a20-i12-tvbox.dtb \
> diff --git a/arch/arm/boot/dts/sun7i-a20-drejo-ds167-emmc.dts b/arch/arm/=
boot/dts/sun7i-a20-drejo-ds167-emmc.dts
> new file mode 100644
> index 000000000000..b6147eb013b0
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

You should use an SPDX tag here

> +#include "sun7i-a20-drejo-ds167.dts"

Is there any reason not to have the emmc into the main DTS?

> +/ {
> +	model =3D "drejo DS167-eMMC";

Drejo should have an uppercase?

> +	compatible =3D "drejo,sun7i-a20-drejo-ds167-emmc", "allwinner,sun7i-a20=
";

This compatible should be documented.

Also, this can be something like drejo,ds167 (the vendor should be
documented too )

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
> index 000000000000..79db92f88251
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-drejo-ds167.dts
> @@ -0,0 +1,288 @@
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

You don't need a pinctrl node for the GPIOs

> +
> +		red {
> +			label =3D "ds167-status";

This isn't the proper red name, it should be something like
ds167:red:status

> +			gpios =3D <&pio 8 9 GPIO_ACTIVE_LOW>;  /* PI9 STATUS LED NEAR A20 SER=
TAC */
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
> +&i2c2 {
> +	status =3D "okay";
> +};
> +
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
> +
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
> +
> +&uart0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart0_pb_pins>;
> +	status =3D "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart3_pg_pins>;
> +	status =3D "okay";
> +};
> +
> +&usb_otg {
> +	dr_mode =3D "otg";
> +	status =3D "okay";
> +};
> +
> +&usb_power_supply {
> +	status =3D "okay";
> +};
> +
> +&usbphy {
> +	usb0_id_det-gpios =3D <&pio 7 4 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* =
PH4 */
> +	usb0_vbus_det-gpios =3D <&pio 7 5 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>;=
 /* PH5 */
> +	usb0_vbus-supply =3D <&reg_usb0_vbus>;
> +	usb1_vbus-supply =3D <&reg_usb1_vbus>;
> +	usb2_vbus-supply =3D <&reg_usb2_vbus>;
> +	status =3D "okay";
> +};

Looks good otherwise, thanks!
Maxime

--jw2e7ngd6l5xqz73
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXtTdQwAKCRDj7w1vZxhR
xdKiAP92RfMs2+TpxutWSrG7zm63J5ROVyTIxu5gcVHuA4rq4QEAri2u+Ha+pj9a
q/roVW/xlSjfZO76RwjV0FaY0oSqQw8=
=vPgB
-----END PGP SIGNATURE-----

--jw2e7ngd6l5xqz73--
