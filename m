Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6C2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 280D52076C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="hWxt+jlZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgHZGYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 02:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgHZGYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 02:24:43 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9A6C061574;
        Tue, 25 Aug 2020 23:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I82j6H9k82ao43czQe8LTe540Te4tbOROzYysGGKyDQ=; b=hWxt+jlZbe0ByW+y6QJjZJodVY
        2FLGMuMy2S6R0No77t44A8cSZoE3btVzprEDmbn0UpXcOT7YCndSBqfPMMGiXn4dw8N6hXgERfybY
        f4XTefvESCA+N/TD5JlJe7Bw4AmjCrCNJXfRSjdbnWNngn5yYv/5BLYwD+mxg8/06ZVo=;
Received: from p200300ccff0d72001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0d:7200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kAorB-0002Cy-9i; Wed, 26 Aug 2020 08:24:25 +0200
Date:   Wed, 26 Aug 2020 08:24:23 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, marcel.ziswiler@toradex.com,
        sebastien.szymanski@armadeus.com, rjones@gateworks.com,
        leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH RFC 2/2] ARM: dts: imx: add devicetree for Tolino Shine
 2 HD
Message-ID: <20200826082423.6e756fbb@aktux>
In-Reply-To: <20200816125247.GA103070@latitude>
References: <20200815193336.21598-1-andreas@kemnade.info>
        <20200815193336.21598-3-andreas@kemnade.info>
        <20200816125247.GA103070@latitude>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Aug 2020 14:54:41 +0200
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:

> On Sat, Aug 15, 2020 at 09:33:36PM +0200, Andreas Kemnade wrote:
> > This adds a devicetree for the Tolino Shine 2 HD Ebook reader. It is ba=
sed
> > on boards marked with "37NB-E60QF0+4A2". It is equipped with an i.MX6SL
> > SoC.
> >=20
> > Expected to work:
> > - Buttons
> > - Wifi
> > - Touchscreen
> > - LED
> > - uSD
> > - USB
> > - RTC
> >=20
> > Not working due to missing drivers:
> > - Backlight (requires NTXEC driver)
> > - EPD
> >=20
> > Not working due to unknown reasons:
> > - deep sleep (echo standby >/sys/power/state works),
> >   wakeup fails when imx_gpc_pre_suspend(true) was called.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > Reason for RFC: The suspend trouble might be caused by bad devicetree.
> > But as the devicetree is already useful I decided to submit it. =20
> [...]
> > +++ b/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
> > @@ -0,0 +1,582 @@
> > +// SPDX-License-Identifier: (GPL-2.0) =20
>=20
> I don't think the parentheses are required when you don't have a logical
> operator (OR) in the SPDX expression.
>=20
> > +&i2c1 {
> > +	pinctrl-names =3D "default","sleep";
> > +	pinctrl-0 =3D <&pinctrl_i2c1>;
> > +	pinctrl-1 =3D <&pinctrl_i2c1_sleep>;
> > +	status =3D "okay";
> > +
> > +	/* TODO: embedded controller at 0x43 (driver missing) */ =20
>=20
> Sorry for the delay, BTW. I'm still (slowly) working on v2.
>=20
> > +	ricoh619: pmic@32 {
> > +		compatible =3D "ricoh,rc5t619";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&pinctrl_ricoh_gpio>;
> > +		reg =3D <0x32>;
> > +		interrupt-parent =3D <&gpio5>;
> > +		interrupts =3D <11 IRQ_TYPE_EDGE_FALLING>;
> > +		system-power-controller;
> > +
> > +		regulators { =20
>=20
> How did you derive the regulator voltages?
>=20
Several sources:
- deriving from the existing device trees,
- looking for board specific variances in
board-mx6sl_ntx.c of the Tolino kernel,=20
- looking for comments in the file.

I compared a register dump of the PMIC from both the vendor kernel
and my devicetree and found no significant differences.


> > +	pinctrl_hog: hoggrp {
> > +		fsl,pins =3D <
> > +			MX6SL_PAD_LCD_DAT0__GPIO2_IO20	0x79
> > +			MX6SL_PAD_LCD_DAT1__GPIO2_IO21	0x79
> > +			MX6SL_PAD_LCD_DAT2__GPIO2_IO22	0x79
> > +			MX6SL_PAD_LCD_DAT3__GPIO2_IO23	0x79
> > +			MX6SL_PAD_LCD_DAT4__GPIO2_IO24	0x79
> > +			MX6SL_PAD_LCD_DAT5__GPIO2_IO25	0x79
> > +			MX6SL_PAD_LCD_DAT6__GPIO2_IO26	0x79
> > +			MX6SL_PAD_LCD_DAT7__GPIO2_IO27	0x79
> > +			MX6SL_PAD_LCD_DAT8__GPIO2_IO28	0x79
> > +			MX6SL_PAD_LCD_DAT9__GPIO2_IO29	0x79
> > +			MX6SL_PAD_LCD_DAT10__GPIO2_IO30	0x79
> > +			MX6SL_PAD_LCD_DAT11__GPIO2_IO31	0x79
> > +			MX6SL_PAD_LCD_DAT12__GPIO3_IO00	0x79
> > +			MX6SL_PAD_LCD_DAT13__GPIO3_IO01	0x79
> > +			MX6SL_PAD_LCD_DAT14__GPIO3_IO02	0x79
> > +			MX6SL_PAD_LCD_DAT15__GPIO3_IO03	0x79
> > +			MX6SL_PAD_LCD_DAT16__GPIO3_IO04	0x79
> > +			MX6SL_PAD_LCD_DAT17__GPIO3_IO05	0x79
> > +			MX6SL_PAD_LCD_DAT18__GPIO3_IO06	0x79
> > +			MX6SL_PAD_LCD_DAT19__GPIO3_IO07	0x79
> > +			MX6SL_PAD_LCD_DAT20__GPIO3_IO08	0x79
> > +			MX6SL_PAD_LCD_DAT21__GPIO3_IO09	0x79
> > +			MX6SL_PAD_LCD_DAT22__GPIO3_IO10	0x79
> > +			MX6SL_PAD_LCD_DAT23__GPIO3_IO11	0x79
> > +			MX6SL_PAD_LCD_CLK__GPIO2_IO15		0x79
> > +			MX6SL_PAD_LCD_ENABLE__GPIO2_IO16	0x79
> > +			MX6SL_PAD_LCD_HSYNC__GPIO2_IO17	0x79
> > +			MX6SL_PAD_LCD_VSYNC__GPIO2_IO18	0x79
> > +			MX6SL_PAD_LCD_RESET__GPIO2_IO19	0x79
> > +			MX6SL_PAD_KEY_COL3__GPIO3_IO30		0x79
> > +			MX6SL_PAD_KEY_ROW7__GPIO4_IO07		0x79
> > +			MX6SL_PAD_ECSPI2_MOSI__GPIO4_IO13	0x79
> > +			MX6SL_PAD_KEY_COL5__GPIO4_IO02		0x79
> > +			MX6SL_PAD_KEY_ROW6__GPIO4_IO05		0x79
> > +		>;
> > +	}; =20
>=20
> Why are there so many hogged pins? Will some of them receive a proper
> configuration once the EPDC driver is implemented?
>=20
I copied them over and found no hints in the
Tolino kernel that it is a bad idea.

Regards,
Andreas
