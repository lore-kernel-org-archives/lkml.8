Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A978C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778C4207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgE2QCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 12:02:08 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:60866 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgE2QCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:02:07 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8DE541C0387; Fri, 29 May 2020 18:02:04 +0200 (CEST)
Date:   Fri, 29 May 2020 18:02:04 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Ian Ray <ian.ray@ge.com>, Samu Nuutamo <samu.nuutamo@vincit.fi>
Subject: Re: [PATCH] ARM: dts: imx53: ppd: alarm LEDs use kernel LED interface
Message-ID: <20200529160204.GA6025@duo.ucw.cz>
References: <20200416145123.73039-1-sebastian.reichel@collabora.com>
 <20200424093226.GB2647@amd>
 <20200424124423.jo25ai5oifvalgpr@earth.universe>
 <20200529140555.ozlvz4egihkvo3aw@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <20200529140555.ozlvz4egihkvo3aw@earth.universe>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> ping?

Well, I thought that we maybe do not need standard LEDs on medical hardware.

> On Fri, Apr 24, 2020 at 02:44:23PM +0200, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Fri, Apr 24, 2020 at 11:32:26AM +0200, Pavel Machek wrote:
> > > On Thu 2020-04-16 16:51:23, Sebastian Reichel wrote:
> > > > From: Ian Ray <ian.ray@ge.com>
> > > >=20
> > > > Use kernel LED interface for the alarm LEDs.
> > >=20
> > > Could we get these changes cced to LED maintainers?
> >=20
> > Sorry, you are not turning up via get_maintainer.pl and usually
> > subsystem maintainers are not CC'd for every DT device instance.
> > E.g. I do not want to be always CC'd for DT board file containing
> > a battery/charger. I'm quite surprised you want to be CC'd for
> > them, just looking at ARM DT files there are over 1000 instances
> > of leds.

Well, we have mess in the naming; I'd like to clear it up.

> > > > +		alarm1 {
> > > > +			label =3D "alarm:red";
> > > > +			gpios =3D <&gpio7 3 GPIO_ACTIVE_HIGH>;
> > > > +		};
> > >=20
> > > So... What is function of these leds, and can we get naming more
> > > consistent with rest of the kernel?
> >=20
> > The device is a medical patient monitor and these are alarm LEDs
> > informing about critical device or patient status. They are
> > referenced by their color (those are discrete LEDs, not a
> > multi-color one) basically everywhere. The only exception is
> > "silenced", which means that audible alarm is surpressed. I
> > don't think we have something comparable for any of those LEDs
> > in the mainline tree.

Actually, we have "platform:*:mute" LEDs, that could be used for
"silenced".

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXtEx/AAKCRAw5/Bqldv6
8u3cAJ90olDmciQ5HbbrqdCR2x7BrFEjagCfWyVisYcRvYin9VpyCCli4Ur0vlk=
=aqzb
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
