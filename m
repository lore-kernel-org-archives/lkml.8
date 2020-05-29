Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B59C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B13020707
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgE2OGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgE2OF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:05:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F445C03E969;
        Fri, 29 May 2020 07:05:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 3E8312A45CA
Received: by earth.universe (Postfix, from userid 1000)
        id EFFA33C08C7; Fri, 29 May 2020 16:05:55 +0200 (CEST)
Date:   Fri, 29 May 2020 16:05:55 +0200
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
Message-ID: <20200529140555.ozlvz4egihkvo3aw@earth.universe>
References: <20200416145123.73039-1-sebastian.reichel@collabora.com>
 <20200424093226.GB2647@amd>
 <20200424124423.jo25ai5oifvalgpr@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4xpce4ocym4xo3vs"
Content-Disposition: inline
In-Reply-To: <20200424124423.jo25ai5oifvalgpr@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4xpce4ocym4xo3vs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

ping?

-- Sebastian

On Fri, Apr 24, 2020 at 02:44:23PM +0200, Sebastian Reichel wrote:
> Hi,
>=20
> On Fri, Apr 24, 2020 at 11:32:26AM +0200, Pavel Machek wrote:
> > On Thu 2020-04-16 16:51:23, Sebastian Reichel wrote:
> > > From: Ian Ray <ian.ray@ge.com>
> > >=20
> > > Use kernel LED interface for the alarm LEDs.
> >=20
> > Could we get these changes cced to LED maintainers?
>=20
> Sorry, you are not turning up via get_maintainer.pl and usually
> subsystem maintainers are not CC'd for every DT device instance.
> E.g. I do not want to be always CC'd for DT board file containing
> a battery/charger. I'm quite surprised you want to be CC'd for
> them, just looking at ARM DT files there are over 1000 instances
> of leds.
>=20
> > > +		alarm1 {
> > > +			label =3D "alarm:red";
> > > +			gpios =3D <&gpio7 3 GPIO_ACTIVE_HIGH>;
> > > +		};
> >=20
> > So... What is function of these leds, and can we get naming more
> > consistent with rest of the kernel?
>=20
> The device is a medical patient monitor and these are alarm LEDs
> informing about critical device or patient status. They are
> referenced by their color (those are discrete LEDs, not a
> multi-color one) basically everywhere. The only exception is
> "silenced", which means that audible alarm is surpressed. I
> don't think we have something comparable for any of those LEDs
> in the mainline tree.
>=20
> -- Sebastian

--4xpce4ocym4xo3vs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7RFrwACgkQ2O7X88g7
+pqyWA/+OhqVYXC7LKpDLzUQ9Fn41dekQwHZyxIw9VOLiU7mZFHAoKyIhUQHtyvd
J/FCTtlBipQ/wRTZvcsSHWwl6pXSO7w8uQ2MJD9Z+PCKAdB2HdLbTM8YKZFWAuMM
SxE0cKaioHfJrC584weNyABNideKrNuk933eChhIZA1MqF5VJE5r84oceNajCrLp
p+SsJaR+uDr7zRvVRRHTTLQjE9eSqO0SdPSc+my9fqwmDka+ZldGP70Dsg+zi733
852SRtkVnrcy9+j5bLPo6Cl9TB0ZS8+U/rFTmPcltV2UjVtADnQE9Es0AHRrUXv1
pcfvKHEFrj+CImoMIABanxYpgam0Arp2hUWKgryYw9SyGaJSQSOvYScy73i/NvU5
FU9yanHaDLQ984zpkpHfwYPyPe3a9CT4WlM49xdMXvXoXehN9lWX81Rz+hl4z9o4
ZssN/DDRtNcSliQWgLbtQeZFXxOfKnPmBSNWxBGrPzwQppk0QrcT+telWxD7ZPbd
8i7ueX/dPFSNuy09x3wYrxfJbvrVqHS6EPbrl4N0T0EPRKK/AnjOtl/dL5XT6viV
5zoXvJ6IVWNwTrmvgERv9oy2eonj5CxYm9AdsDTRbSRcfs6JfANVQXJrB/joHutH
cFWV17FeOL2naQpcPL8JfeQU92ddf9ed0TTd0352W0ivmGZCpvE=
=Xr9A
-----END PGP SIGNATURE-----

--4xpce4ocym4xo3vs--
