Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F9DC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 12:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88EFF207FB
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 12:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gCcwTyQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgHPMzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 08:55:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:49983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbgHPMzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 08:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597582482;
        bh=Ia4FWP2nK5MD+2PSWX4oQICJvy6/O83E4cXk0AAg0/Y=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=gCcwTyQCDwd1/w8Pt1jq1lrJd2IjnzlZVZKfXZRpsa5S+5Km+u8P8CqhdBUdoFZJc
         A9oFxpru3QEN5TRJxrWu71GDc11ttkOe1Qur5hfYFPT5Az7xbsm/NLaEIYnXy39bGN
         dnSbRVIw7AKzhlTXstMN/4JxQC+k5Z07jRwdRP7c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Ycr-1k5MVd2GSJ-0034nf; Sun, 16
 Aug 2020 14:54:42 +0200
Date:   Sun, 16 Aug 2020 14:54:41 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, marcel.ziswiler@toradex.com,
        sebastien.szymanski@armadeus.com, rjones@gateworks.com,
        leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        j.neuschaefer@gmx.net, letux-kernel@openphoenux.org
Subject: Re: [PATCH RFC 2/2] ARM: dts: imx: add devicetree for Tolino Shine 2
 HD
Message-ID: <20200816125247.GA103070@latitude>
References: <20200815193336.21598-1-andreas@kemnade.info>
 <20200815193336.21598-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <20200815193336.21598-3-andreas@kemnade.info>
X-Provags-ID: V03:K1:1RTQxrK+hy36BCZaHxUP0jZ+1j5TNtLnJOdYLY48Gz48YMrBHPY
 PKcq0EtT12y6EOReemwcoHAE4ji8lLFnIj+WXyiXcN+vbww4r+tp/kDjuj8D/jR/rx1/8Nj
 yC6nXFPMD0bk9+FWO8pedMb7hlQtpOGvbDw5BvlLRRaQI9Ib/nfMpIUltGncPvnHI6uX7cV
 F1iOZlL6vSHye95vzG/vw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xnuX2zYEO6Q=:xHQWSUPObfA6uuyfBZmDZf
 2GRIGOJiKEhKICQlqYIp+5gRJqLNolQtZQoQzgcc4GsuyTmhzvPc6uneQKNoZcC0P7h7zMj6R
 D6yySqhKWK0Z+od2cqUZa2bJmkjQO0kfIFYoq9UUYHv1WW/Wfcx7qPA24hH9Kc8+iw4iLLHDj
 cJ86xcsvAxxSUyx5kAINTOG79W8q5+LvrXSbaw8KgP4pZraVrxqDTPOZWM3wsPNI8buKIe7i8
 mUAV9BSf1M6GNZB1X36Kee8O5xk2KuZ66SMbApAEY8VyPHoQmbaTlubQle2pTlnoGG11Rm5Ti
 t/P5e/SKlhw89l/Gu9pLhWFUTqq/sZ6sZRU9Q8XLPZCa1MeuRapdtUqY+F2uH34MZxCAZAVHJ
 kwxI7JtK5yjfszptFoSUvsyitOy7A1STZ9YqSCrqq6tt/2bNC2jAG+vaZRh4wMM1xLEgJzBxe
 aA7GbcdBpCHd/liH2PdNqHnAygnISKVNWXkmMzQZ/QYLRxtAHTM60X1m5CVyjRyVJ7+gP02VG
 uZMVPmEnl6GJkLKgOiWFWkCbQLIaac3JMA3U0n5XNfxoBq2I9ogI4XYEPFDDrCSKfQ2owN5bs
 ZislQc5KnDi56u6goBslQFw3v9kFATSa5aHDlxvFgdbSeUe3bSyqogXMxxY04g5gyFv75zkVs
 li4Fye4mLxoR6ogFcY60b8nNOrfq2dxDdeiammzz8NBrP3fmpkMISyIt+eeI9+Q6LaxjM6+Ky
 Sb7Y523GfCyXiOAWjltzU/AW/+t2gaVf1pHp+GhvxIlJg1PD6r1PTGl09GM11mLC9EJfzFsxX
 9zZ5noNmMkNkPmwEJVmZuprPlNsGeJBkUqOFo735m40S3COaYEMM/J7D4gf9juEK7oi/3Hp/2
 9E3vGX0NOxzsipVEKW+lByv1J6XaZX933WzwK6Ve3GrHIGrrtiOq8xEM2N1vFq4K6f5v2qVvp
 3jQYYkUHKX5GVE/sYYB6In+WLc3JjPKU3CefTZX+l4b1sXcSuUxVjV9hn2pkCtPjJwj1a8meA
 /29gLSp9nvpg9ia+y1IGo4Sysq5pI3vqN+8Pdz/CzCQND7OX0718IY9wgBV1BhJTRTKpei3LT
 3EMjBYAMia/crBuRyl+kNLjHqB8o3WYxstQ14LZYUv+a9U1JqQC96nKhkBUu2pbx5giIZioVE
 rwA/I43g+g9RlqfuYWNL5JQEeFByKrOupzSylHXWCglXLcwPvgVvzQ6nY7rDQnid22WBmAcy9
 WKF4R4yWVS+wu5YQllt94iRCuPPJOV05bvYq/jA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2020 at 09:33:36PM +0200, Andreas Kemnade wrote:
> This adds a devicetree for the Tolino Shine 2 HD Ebook reader. It is based
> on boards marked with "37NB-E60QF0+4A2". It is equipped with an i.MX6SL
> SoC.
>=20
> Expected to work:
> - Buttons
> - Wifi
> - Touchscreen
> - LED
> - uSD
> - USB
> - RTC
>=20
> Not working due to missing drivers:
> - Backlight (requires NTXEC driver)
> - EPD
>=20
> Not working due to unknown reasons:
> - deep sleep (echo standby >/sys/power/state works),
>   wakeup fails when imx_gpc_pre_suspend(true) was called.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Reason for RFC: The suspend trouble might be caused by bad devicetree.
> But as the devicetree is already useful I decided to submit it.
[...]
> +++ b/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
> @@ -0,0 +1,582 @@
> +// SPDX-License-Identifier: (GPL-2.0)

I don't think the parentheses are required when you don't have a logical
operator (OR) in the SPDX expression.

> +&i2c1 {
> +	pinctrl-names =3D "default","sleep";
> +	pinctrl-0 =3D <&pinctrl_i2c1>;
> +	pinctrl-1 =3D <&pinctrl_i2c1_sleep>;
> +	status =3D "okay";
> +
> +	/* TODO: embedded controller at 0x43 (driver missing) */

Sorry for the delay, BTW. I'm still (slowly) working on v2.

> +	ricoh619: pmic@32 {
> +		compatible =3D "ricoh,rc5t619";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_ricoh_gpio>;
> +		reg =3D <0x32>;
> +		interrupt-parent =3D <&gpio5>;
> +		interrupts =3D <11 IRQ_TYPE_EDGE_FALLING>;
> +		system-power-controller;
> +
> +		regulators {

How did you derive the regulator voltages?

> +	pinctrl_hog: hoggrp {
> +		fsl,pins =3D <
> +			MX6SL_PAD_LCD_DAT0__GPIO2_IO20	0x79
> +			MX6SL_PAD_LCD_DAT1__GPIO2_IO21	0x79
> +			MX6SL_PAD_LCD_DAT2__GPIO2_IO22	0x79
> +			MX6SL_PAD_LCD_DAT3__GPIO2_IO23	0x79
> +			MX6SL_PAD_LCD_DAT4__GPIO2_IO24	0x79
> +			MX6SL_PAD_LCD_DAT5__GPIO2_IO25	0x79
> +			MX6SL_PAD_LCD_DAT6__GPIO2_IO26	0x79
> +			MX6SL_PAD_LCD_DAT7__GPIO2_IO27	0x79
> +			MX6SL_PAD_LCD_DAT8__GPIO2_IO28	0x79
> +			MX6SL_PAD_LCD_DAT9__GPIO2_IO29	0x79
> +			MX6SL_PAD_LCD_DAT10__GPIO2_IO30	0x79
> +			MX6SL_PAD_LCD_DAT11__GPIO2_IO31	0x79
> +			MX6SL_PAD_LCD_DAT12__GPIO3_IO00	0x79
> +			MX6SL_PAD_LCD_DAT13__GPIO3_IO01	0x79
> +			MX6SL_PAD_LCD_DAT14__GPIO3_IO02	0x79
> +			MX6SL_PAD_LCD_DAT15__GPIO3_IO03	0x79
> +			MX6SL_PAD_LCD_DAT16__GPIO3_IO04	0x79
> +			MX6SL_PAD_LCD_DAT17__GPIO3_IO05	0x79
> +			MX6SL_PAD_LCD_DAT18__GPIO3_IO06	0x79
> +			MX6SL_PAD_LCD_DAT19__GPIO3_IO07	0x79
> +			MX6SL_PAD_LCD_DAT20__GPIO3_IO08	0x79
> +			MX6SL_PAD_LCD_DAT21__GPIO3_IO09	0x79
> +			MX6SL_PAD_LCD_DAT22__GPIO3_IO10	0x79
> +			MX6SL_PAD_LCD_DAT23__GPIO3_IO11	0x79
> +			MX6SL_PAD_LCD_CLK__GPIO2_IO15		0x79
> +			MX6SL_PAD_LCD_ENABLE__GPIO2_IO16	0x79
> +			MX6SL_PAD_LCD_HSYNC__GPIO2_IO17	0x79
> +			MX6SL_PAD_LCD_VSYNC__GPIO2_IO18	0x79
> +			MX6SL_PAD_LCD_RESET__GPIO2_IO19	0x79
> +			MX6SL_PAD_KEY_COL3__GPIO3_IO30		0x79
> +			MX6SL_PAD_KEY_ROW7__GPIO4_IO07		0x79
> +			MX6SL_PAD_ECSPI2_MOSI__GPIO4_IO13	0x79
> +			MX6SL_PAD_KEY_COL5__GPIO4_IO02		0x79
> +			MX6SL_PAD_KEY_ROW6__GPIO4_IO05		0x79
> +		>;
> +	};

Why are there so many hogged pins? Will some of them receive a proper
configuration once the EPDC driver is implemented?

> +&snvs_rtc {
> +	/* we are using the RTC in the PMIC, not disabled in imx6sl.dtsi */
> +	status =3D "disabled";

This comment sounds a bit ambiguous (and this potentially confusing). Perha=
ps:

+	/* we are using the RTC in the PMIC, but this one is not disabled in imx6=
sl.dtsi */

Or even just:

+	/* we are using the RTC in the PMIC */

> +&usdhc2 {
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 =3D <&pinctrl_usdhc2>;
> +	pinctrl-1 =3D <&pinctrl_usdhc2_100mhz>;
> +	pinctrl-2 =3D <&pinctrl_usdhc2_200mhz>;
> +	pinctrl-3 =3D <&pinctrl_usdhc2_sleep>;
> +	non-removable;
> +	status =3D "okay";
> +};

IMHO, please add a comment saying what this MMC controller is connected
to (internal storage?).

> +
> +&usdhc3 {
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 =3D <&pinctrl_usdhc3>;
> +	pinctrl-1 =3D <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 =3D <&pinctrl_usdhc3_200mhz>;
> +	pinctrl-3 =3D <&pinctrl_usdhc3_sleep>;
> +	vmmc-supply =3D <&reg_wifi>;
> +	mmc-pwrseq =3D <&wifi_pwrseq>;
> +	cap-power-off-card;
> +	non-removable;
> +	status =3D "okay";
> +
> +	/* CyberTan WC121 SDIO WiFi */
> +};

The HWCONFIG block from my Shine2HD reports RTL8189 as the Wifi chip
(value 8 at offset 4), and kernel logs from the vendor kernel appear to
agree that it's a realtek chip, at least (lines prefixed RTL871X).

=46rom my experience with the CyberTan WC121, it has a Broadcom fullmac
chip inside. Now I wonder where this discrepancy or variability comes
=66rom.

I guess the SDIO setup can deal with different chips (like Broadcom vs.
Realtek) as long as the board has been designed to always use the same
reset/power/etc. lines. I don't see any branching based on the 'Wifi'
HWCONFIG entry in the vendor kernel, so I guess that's the case.

In any case, it might be nice to also note the chip used inside the WLAN
package (e.g. BCM43362), to make it easier for interested users to
choose the right drivers.



Kind regards,
Jonathan Neusch=C3=A4fer

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl85LJEACgkQCDBEmo7z
X9uWBA/+J9BFqZGeJiMiLVaVemfQQm435xVZPl+LrogqmM/KvNHcn3WDyWDaH4yr
NLEQvNPdoXH1OGt0DHwrSPFpQCXyebKtcmWMybSKqYGKtJIsBxUAZThugqoWAcmI
ifsaWMV3rvFsrdc1KPooYxyqTo2Mg6i6Xt5QFRvpYzgtnyhdfkKk0ihkdn7nwSf1
DiXaFahOkddSp/0PevI1A8ftjDpTgBTvGl/uex1+VILgyAfWJiskZqX7QxlsSZk7
urJwlNQUF1tcmKsPa9enSQqETrajVgqhVo5qy7dSpIhYKv/SRGSftFbII0nP54mr
ERtwyZkCf3RIO+D/DWyubT282B4q7QqQRlkrcMXNoIDiXB1fCWAkO2fG9DEYH36R
Xpv5wAntbyx332SYwJ4/P2l/6DpywwEfKeBStu1IK1rDYexS1y0uan1hbX0HwNZs
JQUKeN7llxo8NuCoGI/S6ktfpxTNaz2KjGGmU0DFa1LGZIUXhpoDu0QPkQSidKtM
+wVng4mI9WuzR9xyHoHK9x8Zmii7G0lfosfiloJzq2b4hOc/wmtWoV5MKsNOaT36
Q1KREnWsAUDXAdNmck8oI78RntpWwcO4YRGyiNYwCeszg6f742Ly7BDXFrBhIRMS
k4s0kpPw4OfYljeRH/cQZZttTF4A1U3/USOHe6Jq0dR8L0NHkgI=
=RA6Q
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
