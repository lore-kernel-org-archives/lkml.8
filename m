Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD1CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5B2F2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="kGffVCRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgHaR0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgHaR0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:26:35 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF70C061573;
        Mon, 31 Aug 2020 10:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Fa0TE/spR8TRl2qaszsHnN5nwhWH0fFgL63n1neXNqA=; b=kGffVCRzzcp71qqEjjF/3413k3
        b1yC+PMg1abpwWX97m247qEQ4Kx/U4KGGezhgx0gE0OS/qH2NEgm4Mhg/hjVo4Err+kFg7bUQ1v4t
        vcQ3yRCeZg8uBX2i+ALpj2WU3490kwskNEb2NMoPF1tJ7pIxf1sGFtlRSBzhoMeOrVhY=;
Received: from p5dcc3c5d.dip0.t-ipconnect.de ([93.204.60.93] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kCnZT-0008BJ-5j; Mon, 31 Aug 2020 19:26:19 +0200
Date:   Mon, 31 Aug 2020 19:26:17 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, marcel.ziswiler@toradex.com,
        sebastien.szymanski@armadeus.com, michael@walle.cc,
        rjones@gateworks.com, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH v2 2/2] ARM: dts: imx: add devicetree for Tolino Shine 2
 HD
Message-ID: <20200831192617.3af13f1b@aktux>
In-Reply-To: <20200827183323.GE103070@latitude>
References: <20200826204251.5082-1-andreas@kemnade.info>
        <20200826204251.5082-3-andreas@kemnade.info>
        <20200827183323.GE103070@latitude>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 27 Aug 2020 20:33:23 +0200
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:

> On Wed, Aug 26, 2020 at 10:42:51PM +0200, Andreas Kemnade wrote:
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
> > --- =20
> [...]
> > +		fl {
> > +			label =3D "Frontlight";
> > +			gpios =3D <&gpio3 26 GPIO_ACTIVE_LOW>;
> > +			linux,code =3D <KEY_BRIGHTNESS_CYCLE>;
> > +		}; =20
>=20
> Another option might be KEY_BRIGHTNESS_TOGGLE/KEY_DISPLAYTOGGLE, but
> it's not a perfect match, either. (And perhaps a worse match due to the
> connotation of turning the display off.)
>=20
I have also thought about these, but came to the same conclusion as you,
the connotation of turning the display off does not feel right.

>=20
> Reviewed-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>=20
> Thanks

Regards,
Andreas
