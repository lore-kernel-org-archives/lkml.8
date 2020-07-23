Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B57DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 367812080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgGWVoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 17:44:14 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:41800 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgGWVoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 17:44:13 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CF01B1C0BD5; Thu, 23 Jul 2020 23:44:10 +0200 (CEST)
Date:   Thu, 23 Jul 2020 23:44:10 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC leds + net-next v2 1/1] net: phy: marvell: add
 support for PHY LEDs via LED class
Message-ID: <20200723214410.jf4vwj3vnymzqngw@duo.ucw.cz>
References: <20200723181319.15988-1-marek.behun@nic.cz>
 <20200723181319.15988-2-marek.behun@nic.cz>
 <20200723213531.GK1553578@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fkrsjbmmzh66h3mu"
Content-Disposition: inline
In-Reply-To: <20200723213531.GK1553578@lunn.ch>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fkrsjbmmzh66h3mu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > +{
> > +	struct phy_device *phydev =3D to_phy_device(cdev->dev->parent);
> > +	struct marvell_phy_led *led =3D to_marvell_phy_led(cdev);
> > +	u8 val;
> > +
> > +	/* don't do anything if HW control is enabled */
> > +	if (check_trigger && cdev->trigger =3D=3D &marvell_hw_led_trigger)
> > +		return 0;
>=20
> I thought the brightness file disappeared when a trigger takes
> over. So is this possible?

No.

When trigger is set, brightness controls "maximum" brightness LED can
have (and can turn trigger off by setting brightness to 0). Interface
is ... not quite nice.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fkrsjbmmzh66h3mu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXxoEqgAKCRAw5/Bqldv6
8hefAJ9ac5IueIkjdIjwb5RWM/zSWJpK2ACgmDEAOcfipS2uJLurnNQ+/XjYO2o=
=+YWF
-----END PGP SIGNATURE-----

--fkrsjbmmzh66h3mu--
