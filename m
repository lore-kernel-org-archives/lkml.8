Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44DCC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 09:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A804B20714
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 09:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgH3JWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 05:22:18 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:52972 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgH3JWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 05:22:18 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B3D8C1C0B81; Sun, 30 Aug 2020 11:22:13 +0200 (CEST)
Date:   Sun, 30 Aug 2020 11:22:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        netdev@vger.kernel.org, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, Dan Murphy <dmurphy@ti.com>,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC leds + net-next v4 0/2] Add support for LEDs on
 Marvell PHYs
Message-ID: <20200830092212.GA6861@duo.ucw.cz>
References: <20200728150530.28827-1-marek.behun@nic.cz>
 <20200807090653.ihnt2arywqtpdzjg@duo.ucw.cz>
 <20200807132920.GB2028541@lunn.ch>
 <20200829224351.GA29564@duo.ucw.cz>
 <20200829233641.GC2966560@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20200829233641.GC2966560@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > The phydev name is not particularly nice:
> > >=20
> > > !mdio-mux!mdio@1!switch@0!mdio:00
=2E..
> > > 400d0000.ethernet-1:00
> > > 400d0000.ethernet-1:01
> > > fixed-0:00
> >=20
> > Not nice, I see. In particular, it contains ":"... which would be a
> > problem.
> >=20
> > > The interface name are:
> > >=20
> > > 1: lo:
> > > 2: eth0:
> > > 3: eth1:
=2E..
> > > 13: optical3@eth1:
> > > 14: optical4@eth1:
> >=20
> > OTOH... renaming LEDs when interface is renamed... sounds like a
> > disaster, too.
>=20
> I don't think it is. The stack has all the needed support. There is a
> notification before the rename, and another notification after the
> rename. Things like bonding, combing two interfaces into one and load
> balancing, etc. hook these notifiers. There is plenty of examples to
> follow. What i don't know about is the lifetime of files under
> /sys/class/led, does the destroying of an LED block while one of the
> files is open?.

Well, there may be no problems on the networking side, but I'd prefer
not to make LED side more complex. Files could be open, and userland
could have assumptions about LEDs not changing names...

> > > You could make a good guess at matching to two together, but it is
> > > error prone. Phys are low level things which the user is not really
> > > involved in. They interact with interface names. ethtool, ip, etc, all
> > > use interface names. In fact, i don't know of any tool which uses
> > > phydev names.
> >=20
> > So... proposal:
> >=20
> > Users should not be dealing with sysfs interface directly, anyway. We
> > should have a tool for that. It can live in kernel/tools somewhere, I
> > guess.
>=20
> We already have one, ethtool(1).=20

Well... ethtool is for networking, we'll want to have a ledtool, too :-).

> > Would we name leds phy0:... (with simple incrementing number), and
> > expose either interface name or phydev name as a attribute?
> >=20
> > So user could do
> >=20
> > cat /sys/class/leds/phy14:green:foobar/netdev
> > lan5@eth1:
>=20
> Which is the wrong way around. ethtool will be passed the interface
> name and an PHY descriptor of some sort, and it has to go search
> through all the LEDs to find the one with this attribute. I would be
> much more likely to add a sysfs link from
> /sys/class/net/lan5/phy:left:green to
> /sys/class/leds/phy14:left:green.

Okay, that might be even better, as it provides links in the more
useful direction.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX0tvxAAKCRAw5/Bqldv6
8gIVAJ9SudFhekKjKm3bC/uDVNilGxzJygCfZrfUDL9p+GGWmvf90udFglMRUcg=
=fgw1
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
