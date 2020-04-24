Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCB3C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D363920728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgDXMob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgDXMo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:44:29 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC16AC09B045;
        Fri, 24 Apr 2020 05:44:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 277442A2C16
Received: by earth.universe (Postfix, from userid 1000)
        id 7724E3C08C7; Fri, 24 Apr 2020 14:44:23 +0200 (CEST)
Date:   Fri, 24 Apr 2020 14:44:23 +0200
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
Message-ID: <20200424124423.jo25ai5oifvalgpr@earth.universe>
References: <20200416145123.73039-1-sebastian.reichel@collabora.com>
 <20200424093226.GB2647@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7nkxbfnqehgw6jzh"
Content-Disposition: inline
In-Reply-To: <20200424093226.GB2647@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7nkxbfnqehgw6jzh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 24, 2020 at 11:32:26AM +0200, Pavel Machek wrote:
> On Thu 2020-04-16 16:51:23, Sebastian Reichel wrote:
> > From: Ian Ray <ian.ray@ge.com>
> >=20
> > Use kernel LED interface for the alarm LEDs.
>=20
> Could we get these changes cced to LED maintainers?

Sorry, you are not turning up via get_maintainer.pl and usually
subsystem maintainers are not CC'd for every DT device instance.
E.g. I do not want to be always CC'd for DT board file containing
a battery/charger. I'm quite surprised you want to be CC'd for
them, just looking at ARM DT files there are over 1000 instances
of leds.

> > +		alarm1 {
> > +			label =3D "alarm:red";
> > +			gpios =3D <&gpio7 3 GPIO_ACTIVE_HIGH>;
> > +		};
>=20
> So... What is function of these leds, and can we get naming more
> consistent with rest of the kernel?

The device is a medical patient monitor and these are alarm LEDs
informing about critical device or patient status. They are
referenced by their color (those are discrete LEDs, not a
multi-color one) basically everywhere. The only exception is
"silenced", which means that audible alarm is surpressed. I
don't think we have something comparable for any of those LEDs
in the mainline tree.

-- Sebastian

--7nkxbfnqehgw6jzh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6i3yAACgkQ2O7X88g7
+pryFQ/+LLmFpwKTRHZWtfoNa5Ki7MK+Xdk9+ZihxLOvlDA1RDD4mliuR3DYnWUi
G/ahfBFFXavkGkbLH1EOXUiG4I0vgpKhL8noAprz6mH+YHt5qJ2d9rT8VlzPnfjx
cpy1jHcQI/o/KLhf2E5vcGLrekYbsRKAz1zRNBvULVopDTftliJnntUrB4epZUNH
5c7/R8RaqNuJ4s2YUW8KG0w9Pbe2SuWMBlAYdQQ+15m3TCgmt4MQssKsBVlCemSz
fpnCHqi+e6oeaL5EFyhfad2ndFppNcIvc+fc7VP/cHUIb/C8Szsj+Bj8O2BAME0K
zwTdeeJ/wv8F5b2CunIi+lbZj3vo1+NraBTlYmrOwp8i9B6lcl25NoWez1XLsld2
XLCe+WwfU1UOVRoCBKm5khL7Ssd0hm5aDpc5R20Fxi7tqRi/BynYg96vkskHRzXq
cYTbSj/DwAknw3EeAshJzpwycl5Q+3h3aTIcpJ/JYRnB6GIzV5/KbZSDR3AYGXHT
oyGtFdcA6MYOluOEk0tU2cRb32lH62//vmNSHSHrIIE3hHp+/6rfGvXSEnqV3i82
w92tnIFXr7R4KYKyOmarSQpFxJ+UV+51hF2kOe6UbokEuYCHd4SuASXMCrpmjqrf
oIJULpENjHtbA8utSZMhIkmovy2lwXQ8h+X4/Cii14a2loJNyyU=
=8oog
-----END PGP SIGNATURE-----

--7nkxbfnqehgw6jzh--
