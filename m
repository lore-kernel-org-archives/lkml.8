Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43865C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C5120848
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgCKL2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:28:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:48230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgCKL2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:28:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 42AABAE24;
        Wed, 11 Mar 2020 11:28:45 +0000 (UTC)
Message-ID: <12f35cc38b87dfe27f0786c931d4434b0fecb3d8.camel@suse.de>
Subject: Re: [PATCH] ARM: bcm2835-rpi-zero-w: Add missing pinctrl name
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     nick.hudson@gmx.co.uk, Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nick Hudson <skrll@netbsd.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 11 Mar 2020 12:28:43 +0100
In-Reply-To: <20200310182537.8156-1-nick.hudson@gmx.co.uk>
References: <20200310182537.8156-1-nick.hudson@gmx.co.uk>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5XYMFQfPZcQJnMqMwH/W"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5XYMFQfPZcQJnMqMwH/W
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-03-10 at 18:25 +0000, nick.hudson@gmx.co.uk wrote:
> From: Nick Hudson <nick.hudson@gmx.co.uk>
>=20
> Define the sdhci pinctrl state as "default" so it gets applied
> correctly and to match all other RPis.
>=20
> Fixes: 2c7c040c73e9 ("ARM: dts: bcm2835: Add Raspberry Pi Zero W")
>=20
> Signed-off-by: Nick Hudson <skrll@netbsd.org>

I think this one has everything right. As a nitpick, there is no need to ad=
d a
space between the Fixes tag and the Signed-off-by tag, but it's OK as is.

Florian, can we channel this as a fix for v5.6 or are we too late?

Regards,
Nicolas


--=-5XYMFQfPZcQJnMqMwH/W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5oy2sACgkQlfZmHno8
x/6zggf/TMWB4vC2ad+enJM26vcFwsWBjfnnu675ZQMUoxo03ZyHApwW5pwl0BPY
bsyhflSjAqRZmaqSuRu7wfzhKN/uTcEHJfKbthahbEp5eR6O4aDi6uRrouXQN08u
nJ06fiHRpkyB8hnostXRGxHdowLlQgMQqP5z1mW/W/nxVDEZ9ouL7pt/vjXa7ltz
WCAzF62p16K7ty9Yl5OeeNyiCPHnxGLXF0bABpuqtft4MIlorRoxpX6ac1Z2BHtm
AgZbxb9uLowDMVfns4VVz7WxW+A8BfZ9Jnqxu8SmVxeSLF3JrinS/MFCAXbvN9TZ
T2mfB6/jx9pOLEO7Wa/WauZhDc0Yqg==
=dKS0
-----END PGP SIGNATURE-----

--=-5XYMFQfPZcQJnMqMwH/W--

