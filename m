Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E99C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1150C2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593016164;
	bh=TfdmMZFoMamba9hAZ73wEPB7qlys4If0NBVI+1NG/UU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K5xH7sT6rdTX00JCbiDBkHCOeEnKDjimzMw4J/eiDt3pqehLa4pZDRwVJb7SmlRct
	 2xs1RrYix2mx7dI1f1NMDAjckKCXPo4Jr0Tqkesl6Y7HlKhCs37jbFExaylICvZCj2
	 +NPeaIG1VHn2+9a/kzIJ5aNa5bKMGy7/S9is5fQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404959AbgFXQ3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:29:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404911AbgFXQ3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:29:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71AEF20836;
        Wed, 24 Jun 2020 16:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593016160;
        bh=TfdmMZFoMamba9hAZ73wEPB7qlys4If0NBVI+1NG/UU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VpzJJgus9+zyY0l2n1ruLm646dBuDmHvNsXlWYco19nCDNYZBoo/Y2FIsJ8yxZ0yw
         e/kpOYqkVyEmfUOIJ1FREsJxtHZtkYjlj24ce5uRir7ho2s0bU2nB2GHb4jqgFyk0z
         zZ04nY8eZz1feeBtXSteZCyt2CnBll2ZaTigowIs=
Date:   Wed, 24 Jun 2020 17:29:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/7] ASoC: tas2562: Fix format issue for extra space
 before a comma
Message-ID: <20200624162917.GK5472@sirena.org.uk>
References: <20200624161459.19248-1-dmurphy@ti.com>
 <20200624161459.19248-4-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tKtFalx5NIx0HZ72"
Content-Disposition: inline
In-Reply-To: <20200624161459.19248-4-dmurphy@ti.com>
X-Cookie: So this is it.  We're going to die.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKtFalx5NIx0HZ72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2020 at 11:14:55AM -0500, Dan Murphy wrote:
> Fix the issue found that there is an extra space before a comma in the
> volume control.
>=20
> Fixes: bf726b1c86f2c ("ASoC: tas2562: Add support for digital volume cont=
rol")
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  arch/arm/boot/compressed/fdt.h             |   66 +
>  arch/arm/boot/compressed/libfdt.h          | 2072 ++++++++++++++++++++
>  arch/arm/boot/compressed/libfdt_internal.h |  173 ++
>  sound/soc/codecs/tas2562.c                 |    2 +-

I'm guessing those libfdt changes weren't supposed to be here?

--tKtFalx5NIx0HZ72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7zf10ACgkQJNaLcl1U
h9An2Qf6AzD1t9C2zhCAOdLfYVN/RaS8w3Mi6hZd+l5rIvL+gYEHsaqTQDYsy8mv
aeAZNN3FPKsxBnXLssuA63iBaQIhE3M8SI1V3OFPBK1MZEGAQVAe4KYMseQVLEdk
6hj4jLd4u7hGvRfx4boqmYZmVKoCOGUlawS7CcdyS1tFq9LEi3yLSEqdH76eNVcm
mMd4zhO731rZl5kIWeOVGEDxfsVKDfn3BLFQUcTa6BwvW6xd9LKQi9xgjDPql3Qp
GomCINoovcB4wglAXd7EoiNTErfgcW1m5gUCKPF4oxeWURzEKozYFON6csZcWh9+
lsKqk6ykjHMXZfC2OngiLTPe4zE3Rg==
=jWX5
-----END PGP SIGNATURE-----

--tKtFalx5NIx0HZ72--
