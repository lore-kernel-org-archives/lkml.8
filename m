Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E04CC3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D8720730
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="TIuyYxSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgBDHFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 02:05:52 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:34716 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgBDHFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 02:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qREbqhm7ULziMy9zDyURDK85/2zDbmCojI4hTfvPAOo=; b=TIuyYxSAtIdaRwy4y7p7dkvkU
        Z7u48LVB5YZRZWIu2vCLEVF7xIO47x0WDxLpIRggzpPQbDYuR5PJ1bxH37CpA3CMqkHzpbMAURr6O
        uEoCcmf+ekKGklGG31pu5iEHR3U6rpMa7nEDKuweAoCm5tofIa7IRYgp5dFE+HxHgxNJk=;
Received: from [2a02:790:ff:1019:e2ce:c3ff:fe93:fc31] (helo=localhost)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iysHG-0000Tc-4R; Tue, 04 Feb 2020 08:05:44 +0100
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iysHD-0004AJ-SH; Tue, 04 Feb 2020 08:05:39 +0100
Date:   Tue, 4 Feb 2020 08:05:06 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>,
        shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: imx6sll: Add the Kobo Aura H2O Edition 2
Message-ID: <20200204080359.0b1d7d04@kemnade.info>
In-Reply-To: <20190909175927.4980-1-GNUtoo@cyberdimension.org>
References: <20190909175927.4980-1-GNUtoo@cyberdimension.org>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yaz5RPuxDf=_xN1EfzP.iMv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yaz5RPuxDf=_xN1EfzP.iMv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

hmm, you do not have any arm folks on the recipient list.
So nobody of them will review... There is always a cooperation
between devicetree maintainers and maintainers from the hardware
you are describing.
get_maintainer.pl should give you something. I have expanded the list
of recipients.

On Mon,  9 Sep 2019 19:59:27 +0200
Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org> wrote:

> This work is based on the devicetree that can be found
> in the source code published by the device vendor[1],
> and on testing on the hardware as not all the parts
> described in the vendor's imx6sll-e60qm2.dts are populated
> on the PCB.
>=20
> [1]: https://github.com/kobolabs/Kobo-Reader/blob/master/hw/imx6sll-aurah=
2o2-aura/kernel.tar.bz2
>=20
> Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
> ---
>  arch/arm/boot/dts/Makefile               |   1 +
>  arch/arm/boot/dts/imx6sll-aura-h2o-2.dts | 258 +++++++++++++++++++++++
>  2 files changed, 259 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6sll-aura-h2o-2.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 9159fa2cea90..67a568a66e49 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -551,6 +551,7 @@ dtb-$(CONFIG_SOC_IMX6SL) +=3D \
>  	imx6sl-evk.dtb \
>  	imx6sl-warp.dtb
>  dtb-$(CONFIG_SOC_IMX6SLL) +=3D \
> +	imx6sll-aura-h2o-2 \

.dtb?=20
Needs to be rebased anyways.

>  	imx6sll-evk.dtb
>  dtb-$(CONFIG_SOC_IMX6SX) +=3D \
>  	imx6sx-nitrogen6sx.dtb \
> diff --git a/arch/arm/boot/dts/imx6sll-aura-h2o-2.dts b/arch/arm/boot/dts=
/imx6sll-aura-h2o-2.dts
> new file mode 100644
> index 000000000000..5989866bb043
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6sll-aura-h2o-2.dts
> @@ -0,0 +1,258 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Copyright (C) 2019 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
> + */
> +
Maybe some description of the board here, like marking of PCBs,
so others can recognize devices sold with other brand names but
the same pcb if there exist  any such.
According to
https://ia801006.us.archive.org/6/items/kobo_aura_H2O_edition_2_pcb_01.jpeg=
/kobo_aura_H2O_edition_2_pcb_01.jpeg

there is Start of serials: 60QM2 (you have seen this somewhere else)
some mark on the PCB: 37NB-E60QM0

> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include "imx6sll.dtsi"
> +
> +/ {
> +	model =3D "Kobo Aura H2O Edition 2";
> +	compatible =3D "kobo,aura-h2o-2", "fsl,imx6sll";
> +
do we have a imx6sl-variant here?
like Kobo Clara HD (with imx6sll, in v5.5) vs. Tolino Shine 3 (imx6sl, acce=
pted for w5.6-rc1)?
These things are pin-compatible.
Just wild gessing, Maybe Tonlino Forma something? There seems to be no supp=
ort
in the tolino sources for imx6sll at all, so chances are high that these de=
vices
all have imx6sl.
Then we should do a split of pinmux vs. other stuff in a .dtsi. to prepare =
for
that.

> +	memory@80000000 {
> +		device_type =3D "memory";
> +		reg =3D <0x80000000 0x20000000>;
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_led>;
> +
> +		user {
> +			label =3D "GLED";
should get a better name, so it can be better understood what it is for.
Is it a LED on the power button? The older Kobo aura in=20
imx50-kobo-aura.dts has
kobo_aura:orange:on
e60k02.dtsi (used by the Kobo Clara HD and the Tolino Shine 3) has
e60k02:white:on

> +			gpios =3D <&gpio4 22 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger =3D "timer";
> +		};
> +	};
> +};
> +
> +&cpu0 {
> +	arm-supply =3D <&reg_dcdc3>;
> +	soc-supply =3D <&reg_dcdc1>;
> +};
> +
> +&gpc {
> +	fsl,ldo-bypass =3D <1>;
> +};
> +
maybe you should add the other busses and comment what devices
are on it, so if someone starts working on these chips, it is easier to
find
allies and testers.

> +&i2c3 {
> +	clock-frequency =3D <100000>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_i2c3>;
> +	status =3D "okay";
> +
> +	ricoh_rc5t619@32 {
rather name it by function:
	pmic@32

> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_ricoh_rc5t619>;
> +		compatible =3D "ricoh,rc5t619";
> +		reg =3D <0x32>;
> +		system-power-controller;
> +
> +		regulators {
> +			reg_dcdc1: DCDC1 {
> +				regulator-min-microvolt =3D <300000>;
> +				regulator-max-microvolt =3D <1875000>;
> +				regulator-boot-on;
> +				regulator-always-on;
Please add a newline between properties and child nodes.
Same for the other regulators.

> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt =3D <900000>;
> +				};
> +			};
> +
> +			DCDC2 {
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt =3D <3300000>;
> +				};
> +			};
> +
> +			reg_dcdc3: DCDC3 {
> +				regulator-min-microvolt =3D <300000>;
> +				regulator-max-microvolt =3D <1875000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt =3D <1140000>;
> +				};
> +			};
> +
> +			DCDC4 {
> +				regulator-min-microvolt =3D <1200000>;
> +				regulator-max-microvolt =3D <1200000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt =3D <1140000>;
> +				};
> +			};
> +
> +			DCDC5 {
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt =3D <1700000>;
> +				};
> +			};
> +
> +			LDO1 {
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			LDO2 {
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt =3D <3000000>;
> +				};
> +			};
> +
> +			LDO3 {
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			LDO4 {
> +				regulator-boot-on;
> +			};
> +
> +			LDO5 {
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			LDO6 {
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			LDO7 {
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			LDO8 {
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			LDO9 {
> +				regulator-boot-on;
> +			};
> +
> +			LDO10 {
> +				regulator-boot-on;
> +			};
> +
> +			LDORTC1 {
> +				regulator-boot-on;
> +			};
> +
> +			LDORTC2 {
> +				regulator-boot-on;
Sure about this one? Maybe check the corresponding bit in uboot.
Well, should not be that problematic because there is a bug fixed which
turns it off. I guess just dropping this one is helpful.
> +			};
> +		};
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl-names =3D "default";
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins =3D <
> +			MX6SLL_PAD_REF_CLK_24M__I2C3_SCL	0x4001f8b1
> +			MX6SLL_PAD_REF_CLK_32K__I2C3_SDA	0x4001f8b1
> +		>;
> +	};
> +
> +	pinctrl_led: ledgrp {
> +		fsl,pins =3D <
> +			MX6SLL_PAD_GPIO4_IO22__GPIO4_IO22	0x17059
> +		>;
> +	};
> +
> +	pinctrl_ricoh_rc5t619: ricoh_rc5t619_grp {
Hyphens are used in node names (not in the labels).

> +		fsl,pins =3D <
> +			 /* chg */
> +			MX6SLL_PAD_GPIO4_IO20__GPIO4_IO20	0x1b8b1
> +			/* irq */
> +			MX6SLL_PAD_GPIO4_IO19__GPIO4_IO19	0x1b8b1
> +			/* bat_low_int */
> +			MX6SLL_PAD_KEY_COL2__GPIO3_IO28	0x1b8b1
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins =3D <
> +			MX6SLL_PAD_UART1_TXD__UART1_DCE_TX	0x1b0b1
> +			MX6SLL_PAD_UART1_RXD__UART1_DCE_RX	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins =3D <
> +			MX6SLL_PAD_SD1_CMD__SD1_CMD		0x17059
> +			MX6SLL_PAD_SD1_CLK__SD1_CLK		0x17059
> +			MX6SLL_PAD_SD1_DATA0__SD1_DATA0	0x17059
> +			MX6SLL_PAD_SD1_DATA1__SD1_DATA1	0x17059
> +			MX6SLL_PAD_SD1_DATA2__SD1_DATA2	0x17059
> +			MX6SLL_PAD_SD1_DATA3__SD1_DATA3	0x17059
> +			MX6SLL_PAD_SD1_DATA4__SD1_DATA4	0x17059
> +			MX6SLL_PAD_SD1_DATA5__SD1_DATA5	0x17059
> +			MX6SLL_PAD_SD1_DATA6__SD1_DATA6	0x17059
> +			MX6SLL_PAD_SD1_DATA7__SD1_DATA7	0x17059
> +		>;
> +	};
> +
> +	pinctrl_usbotg1: usbotg1grp {
> +		fsl,pins =3D <
> +			MX6SLL_PAD_EPDC_PWR_COM__USB_OTG1_ID	0x17059
> +		>;
> +	};
> +};
> +
> +&snvs_poweroff {
> +	status =3D "disabled";
> +};
> +
already disabled in imx6sll.dtsi

> +&snvs_pwrkey {
> +	status =3D "disabled";
> +};
> +
ditto.

Maybe you should disable snvs_rtc. Since you have the system-power-controll=
er
flag for the pmic, I guess the RTC in the SoC cannot work,=20

> +&uart1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_uart1>;
> +	status =3D "okay";
> +};
> +
> +
> +&usdhc1 {
What is that. An eMMC?
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_usdhc1>;
> +	bus-width =3D <8>;
> +	no-1-8-v;
> +	non-removable;
grr, hacking unfriendly. Am I right that it does not even have a sd card
slot which is externally accessible?
In my Kobo Clara HD there is a 128GB uSD now...=20
> +	status =3D "okay";
> +};
> +
> +&usbotg1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_usbotg1>;
> +	disable-over-current;
> +	status =3D "okay";
> +};
> --=20
> 2.23.0

Regards,
Andreas

--Sig_/yaz5RPuxDf=_xN1EfzP.iMv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl45F6IACgkQl4jFM1s/
ye9IWg/+PWgw+pFzT9wPuXUjiRgciijp59HChVEZCOtnuc5LSujpBU6Dx2olTa3v
DIIz2nxdL93z8+k1b9wFbifz3zXK0XdgU/lRqJbAwg2ME4GEpX+s3dCdE7kseDxM
1NoKL4RiAZjqKQOhDgG/KO6mByCy8COQzInH1W86XljyLUiYBZb+UCT/Htrbrnof
r0KxErJiGDs91HsxVciGVnl9LDgQLdgTwy+FTlOS1b8MU5aI41VtrYIbTWYBrdOW
BeSI+OMAoXXr0pZgO8lQjO4pAORHnnDrjasHxBvl2K41zbJeuhWxe3VzIcaXz88w
oF+LnjcGG+8f2gtkGN0CLx8iZWLg5KzyNNU8ab/GFvRTJqFzsRCfbSrVfbpTsGYu
kGfBHDVk8ANiLtLtD1UOqY3Ef56sy5KPsxMbhtAKJDxu4AAQgQeZPUHy+1HxDv69
Ozxy0Rg/l2BsluMlHK5Zw/vdz5yEzdp9JDBCMjCxLSVzUeDQZ3x2fONvL70ZP9xW
pgwnUPIXhtlgGCMGIcKMyW3qafG+CeiNG4qF1WYq2r+KrO83qgig8IgUFhO5E79N
PXPpFLJgMymjnRcDt2SpDxPvy5+wTDXGw1YE/jG9f36h1zY6RjSTEff3I/0PK51M
GI9wE2SaQlXbdaLF9mITc6jxh/HE+JNzyPvNEXz41hPZLMeDev8=
=cGH6
-----END PGP SIGNATURE-----

--Sig_/yaz5RPuxDf=_xN1EfzP.iMv--
