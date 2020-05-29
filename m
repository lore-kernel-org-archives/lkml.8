Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206D7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CCC42073B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgE2SDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgE2SDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:03:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C09C03E969;
        Fri, 29 May 2020 11:03:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id AF4272A2A0F
Received: by earth.universe (Postfix, from userid 1000)
        id 8F1203C08C7; Fri, 29 May 2020 20:03:06 +0200 (CEST)
Date:   Fri, 29 May 2020 20:03:06 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Ian Ray <ian.ray@ge.com>, Samu Nuutamo <samu.nuutamo@vincit.fi>
Subject: Re: [PATCH] ARM: dts: imx53: ppd: alarm LEDs use kernel LED interface
Message-ID: <20200529180306.pjevb6qdv7jvmxtu@earth.universe>
References: <20200416145123.73039-1-sebastian.reichel@collabora.com>
 <20200424093226.GB2647@amd>
 <20200424124423.jo25ai5oifvalgpr@earth.universe>
 <20200529140555.ozlvz4egihkvo3aw@earth.universe>
 <20200529160204.GA6025@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h2ss5j6tgypqoj24"
Content-Disposition: inline
In-Reply-To: <20200529160204.GA6025@duo.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h2ss5j6tgypqoj24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 29, 2020 at 06:02:04PM +0200, Pavel Machek wrote:
> > ping?
>=20
> Well, I thought that we maybe do not need standard LEDs on medical hardwa=
re.

The discussion died and the patch was not applied :) In general
IDK how worthwhile it is to use standard LED names for them. I
suppose the number of people planning to create something like
OpenWRT for medical devices is not so big.

> > On Fri, Apr 24, 2020 at 02:44:23PM +0200, Sebastian Reichel wrote:
> > > On Fri, Apr 24, 2020 at 11:32:26AM +0200, Pavel Machek wrote:
> > > > On Thu 2020-04-16 16:51:23, Sebastian Reichel wrote:
> > > > > From: Ian Ray <ian.ray@ge.com>
> > > > >=20
> > > > > Use kernel LED interface for the alarm LEDs.
> > > >=20
> > > > Could we get these changes cced to LED maintainers?
> > >=20
> > > Sorry, you are not turning up via get_maintainer.pl and usually
> > > subsystem maintainers are not CC'd for every DT device instance.
> > > E.g. I do not want to be always CC'd for DT board file containing
> > > a battery/charger. I'm quite surprised you want to be CC'd for
> > > them, just looking at ARM DT files there are over 1000 instances
> > > of leds.
>=20
> Well, we have mess in the naming; I'd like to clear it up.

I understand.

> > > > > +		alarm1 {
> > > > > +			label =3D "alarm:red";
> > > > > +			gpios =3D <&gpio7 3 GPIO_ACTIVE_HIGH>;
> > > > > +		};
> > > >=20
> > > > So... What is function of these leds, and can we get naming more
> > > > consistent with rest of the kernel?
> > >=20
> > > The device is a medical patient monitor and these are alarm LEDs
> > > informing about critical device or patient status. They are
> > > referenced by their color (those are discrete LEDs, not a
> > > multi-color one) basically everywhere. The only exception is
> > > "silenced", which means that audible alarm is surpressed. I
> > > don't think we have something comparable for any of those LEDs
> > > in the mainline tree.
>=20
> Actually, we have "platform:*:mute" LEDs, that could be used for
> "silenced".

I see you point, but wonder if mute is the right choice. The LED
signals a silenced alarm, which IMHO is not the same:

* The alarm silencing is temporary and system unsilences after
  1-2 minutes.
* LED is usually blinking instead of solid like a laptop mute LED
  (so that operator is aware of silenced alarm)
* Device usually cannot be put into silenced mode before the alarm
  appears
* Some medical devices still generate perodic beeps

AFAIK this is named alarm silencing by basically everyone for
medical devices. So I think naming this platfrom:*:mute would
increase the mess.

-- Sebastian

--h2ss5j6tgypqoj24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7RTlEACgkQ2O7X88g7
+podiQ//SOBAxTHVyDbrl923oJkmWIEN2pA8TSYHYWX6I2AmWlUOr08HrKX9I3H4
fndIlKH5OICbE+U71ZUC+zngfbDSpjdLarYZKNJKiMgsOPQRqlkWxdV9Ct7UL+YG
IkOnCoJkJXV4T6EVcyLcik8ZqrIcj3s6xe4JQxx9x3jrfp0netDT1nhFDkopUs5h
+S+d4PSRnyDasUoSb1ITmcX9NOrD1tIYixxncjqSWDQb0mLDEwenUJJD3nFVRv9l
mpsg1zTauKTMg4jNPeoazgRGcvAnf1ZkLtgl+fXQKYGhPNYTlamZEPg3Vd7Twb+z
XvH56MCLBqBIPEHRNuf6UU+DDLTHsXmEOLkGq8ZQ5VFRqGZuiQ7HWB+NKUqoJV6x
hE3waB2LC9I6aYvvBZjjnR8PFRJUR4PHrqh214wIfV5GwEbXnfWYpuKbb/flHfLY
4qMXkaG8tQ8PmP4A8roYRo2EWO/+xL1EuRxEEXPB3bMoCDcPbNHC3lyp6FKhxwtf
EJRsXnQ0UIfe2hcY1WsugEOu6UkBL4uQGjMb1omfDq27h+Ov9B8zmCnls35L6LmZ
qvwUMRM/JN5cu+/DY9KBoCr9+su6hXYB7fEGK6ULs5mPuASD+eDD34TGMhmgL+73
wZ2PcBaUmVfAhhLcnHBHs570WzfuGnG7I35xtn6UspheYhUw2sA=
=+Wux
-----END PGP SIGNATURE-----

--h2ss5j6tgypqoj24--
