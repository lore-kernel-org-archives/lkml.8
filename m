Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF2DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9B7020EDD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbgE0N2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:28:34 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:45518 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbgE0N2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:28:34 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 70D8D1C0300; Wed, 27 May 2020 15:28:32 +0200 (CEST)
Date:   Wed, 27 May 2020 15:28:31 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Russell Currey <ruscur@russell.cc>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 49/81] powerpc: Remove STRICT_KERNEL_RWX
 incompatibility with RELOCATABLE
Message-ID: <20200527132831.GA11424@amd>
References: <20200526183923.108515292@linuxfoundation.org>
 <20200526183932.664564063@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20200526183932.664564063@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2020-05-26 20:53:24, Greg Kroah-Hartman wrote:
> From: Russell Currey <ruscur@russell.cc>
>=20
> [ Upstream commit c55d7b5e64265fdca45c85b639013e770bde2d0e ]
>=20
> I have tested this with the Radix MMU and everything seems to work, and
> the previous patch for Hash seems to fix everything too.
> STRICT_KERNEL_RWX should still be disabled by default for now.
>=20
> Please test STRICT_KERNEL_RWX + RELOCATABLE!

I don't believe this is suitable for -stable. Yes, it is needed for
the next patch, but doing the merge is right solution this time.

Best regards,
									Pavel


> +++ b/arch/powerpc/Kconfig
> @@ -139,7 +139,7 @@ config PPC
>  	select ARCH_HAS_MEMBARRIER_CALLBACKS
>  	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE
>  	select ARCH_HAS_SG_CHAIN
> -	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !RELO=
CATABLE && !HIBERNATION)
> +	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !HIBE=
RNATION)
>  	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_HAS_UACCESS_FLUSHCACHE	if PPC64
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7Oav8ACgkQMOfwapXb+vKjXACfQVK1uiZM4nePNJR7Fc6mnHem
EwMAn1KWNPbnwVNVzoT/C5KdynRt0uPi
=BB0R
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
