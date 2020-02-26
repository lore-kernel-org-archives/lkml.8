Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DF6C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CE62467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgBZOBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:01:01 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:41120 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgBZOBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:01:01 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 504DA1C0411; Wed, 26 Feb 2020 15:00:59 +0100 (CET)
Date:   Wed, 26 Feb 2020 15:00:58 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v5] leds: add SGI IP30 led support
Message-ID: <20200226140058.GH4080@duo.ucw.cz>
References: <20200224111733.10320-1-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k+G3HLlWI7eRTl+h"
Content-Disposition: inline
In-Reply-To: <20200224111733.10320-1-tbogendoerfer@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+G3HLlWI7eRTl+h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch implemenets a driver to support the front panel LEDs of
> SGI Octane (IP30) workstations.

Thanks, applied.

> +	switch (num) {
> +	case IP30_LED_SYSTEM:
> +		data->cdev.name =3D "white:system";
> +		break;
> +	case IP30_LED_FAULT:
> +		data->cdev.name =3D "red:fault";
> +		break;

If the white LED normally serves as power indicator for the system, we
might want to specify that. Does it?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--k+G3HLlWI7eRTl+h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXlZ6GgAKCRAw5/Bqldv6
8v/LAJ4hR/MEqzunqTFAkP8Fz6lw9X/8LwCfRv9n9m0PTvRwyMfZOMaoo3gjna0=
=a70w
-----END PGP SIGNATURE-----

--k+G3HLlWI7eRTl+h--
