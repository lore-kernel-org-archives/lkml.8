Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5284C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828C02067D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBSLMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 06:12:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:53278 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgBSLMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:12:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 444DAB071;
        Wed, 19 Feb 2020 11:12:51 +0000 (UTC)
Message-ID: <ef452bde229efda053385e8dc198e79bb693d1a1.camel@suse.de>
Subject: Re: [PATCH v2] ARM: bcm2835_defconfig: add support for Raspberry Pi4
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>
Date:   Wed, 19 Feb 2020 12:12:49 +0100
In-Reply-To: <20200217155506.5245-1-m.szyprowski@samsung.com>
References: <CGME20200217155513eucas1p2f97cb31428fd50181a4fe16682322d8f@eucas1p2.samsung.com>
         <20200217155506.5245-1-m.szyprowski@samsung.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-imMygzlNXScDnCG/heyJ"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-imMygzlNXScDnCG/heyJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-02-17 at 16:55 +0100, Marek Szyprowski wrote:
> Add drivers needed to boot Raspberry Pi4 board.
>=20
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

Patch applied.

Thanks!
Nicolas


--=-imMygzlNXScDnCG/heyJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5NGDEACgkQlfZmHno8
x/4KYAf+NasWXeQRrxVGMq5QF8EPKm/U5EThi3qXZ9TTT3JG8Ueadngkf6KUYWuw
JzOSjsMOqvjd+Ra/1wdtohm0MOhzxl5LziVfINeM0Q1w9dTPF5L/dl1eKYQnonhG
116dcdSGLTz8crnHkXy1CvSCG4+iYcgM/PoQxRjqczNaV/8mUyPmdk3HShRLCJMp
pw7HuUwdsr8RzXwNo7kqo32MDXYbSl5LMyMvis0eIHjeo7bX976nrjZGpiqoPjeW
pUo6BHRkNLPIUFuMhYrkL+BBdSN2b32BrkBxXbv/D0TD4Uo2cxeaYR+TnB2JyRE/
zfQC4alNMfy8Jn9Bw8ogEHolUm7Auw==
=Gfgz
-----END PGP SIGNATURE-----

--=-imMygzlNXScDnCG/heyJ--

