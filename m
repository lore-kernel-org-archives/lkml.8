Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2949DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E07020870
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgGDMrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 08:47:33 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:47330 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbgGDMrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 08:47:33 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1CB421C0BD2; Sat,  4 Jul 2020 14:47:30 +0200 (CEST)
Date:   Sat, 4 Jul 2020 14:47:29 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>, marek.behun@nic.cz
Cc:     jacek.anaszewski@gmail.com, robh@kernel.org,
        devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v29 00/16] Multicolor Framework v29
Message-ID: <20200704124729.GA20088@amd>
References: <20200622185919.2131-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20200622185919.2131-1-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the multi color LED framework.   This framework presents clustered
> colored LEDs into an array and allows the user space to adjust the bright=
ness
> of the cluster using a single file write.  The individual colored LEDs
> intensities are controlled via a single file that is an array of LEDs
>=20
> Change to the LEDs Kconfig to fix dependencies on the LP55XX_COMMON.
> Added update to the u8500_defconfig

Marek, would you be willing to look over this series?

Dan, can we please get it in the order

1) fixes first

2) changes needed for multicolor but not depending on dt acks

3) dt changes

4) rest?

This is the order it should have been in the first place, and I'd like
to get fixes applied, and perhaps some of the preparation.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8AemEACgkQMOfwapXb+vJi7QCfVYP9mm0rSbADPAMpSR7iNQuB
m7EAoIZ8qicijekwMOwNxn4PaQNXXuku
=2+fx
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
