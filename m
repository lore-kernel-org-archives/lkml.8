Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6638C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9515A21531
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgGDMWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 08:22:25 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:44918 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgGDMWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 08:22:24 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2ACD31C0BD2; Sat,  4 Jul 2020 14:22:23 +0200 (CEST)
Date:   Sat, 4 Jul 2020 14:22:22 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     =?utf-8?B?5a2Z5LiW6b6Z?= sunshilong <sunshilong369@gmail.com>
Cc:     Kernelnewbies@kernelnewbies.org, linux-kernel@vger.kernel.org
Subject: Re: Are there some potentially serious problems that I should be
 aware of if I totally disable the CONFIG_ACPI option on the X86_64 platform?
Message-ID: <20200704122222.GB15530@amd>
References: <CAAvDm6bGBbN=EiJxO9Fq9HqLz6F=hSQqjKms_G6qPHzbZ6G3zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <CAAvDm6bGBbN=EiJxO9Fq9HqLz6F=hSQqjKms_G6qPHzbZ6G3zg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Are there some potentially serious problems that I should be aware of
> if I totally disable the CONFIG_ACPI option on the X86_64 platform?
>=20
> Would it do harm to the hardware?
>=20
> Thank you for your attention to this matter.

These machines are still mostly IBM-PC compatible, so it is likely to
somehow work. You'll likely get worse power and thermal
management. Try it.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8AdH4ACgkQMOfwapXb+vIHTwCfQ9c9KX3/EY85Gm9wwa7Aeroq
ZeYAnjmKW+l83cm4l1HFOWZTiiC/wwOU
=/TjJ
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
