Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9EAC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98EAC20733
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589276453;
	bh=p0H+1A9ZtxK8/3CANSemNUB3JdiDXVfouvOzKgQzVM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bL/N+m3OMYVnRDsMvtDJ9PDG6ga66HOq+71ldqLczy06I3cA1D+w9Zm+v1hy325DD
	 D9U+YCLNft1ILxPgD+onLOG9EbzUlGhTiO+OH3iNBvNN1UkZpiSuNxIh6HaVjtDi2n
	 q4/1buxCw/VUE4+6tsHytGx5H9rSxJm5wn07CBb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgELJkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:40:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgELJkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:40:52 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82F2F206A3;
        Tue, 12 May 2020 09:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589276452;
        bh=p0H+1A9ZtxK8/3CANSemNUB3JdiDXVfouvOzKgQzVM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EmQaEgm7TTpSUNS3aPcHTk4HrhcAl4HH5Zz4oYgZujO3r1uTQ8jmPdubQCsJkmuGU
         lDqndTVtS3aejmhVBwfoQfy1nVoAwgP0wkO/5s1ritqdJ0Xqo+hexhrzhsSkRTh/3+
         qNBYVMld6gTLO3vcvEuaSugnnb7rP1+Pe1XtJcKI=
Date:   Tue, 12 May 2020 10:40:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yongbo Zhang <giraffesnn123@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chen Li <licheng0822@thundersoft.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH v2] SoC: rsnd: add interrupt support for SSI BUSIF buffer
Message-ID: <20200512094049.GA5110@sirena.org.uk>
References: <20200511160731.GA3618@sirena.org.uk>
 <20200512093003.28332-1-giraffesnn123@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20200512093003.28332-1-giraffesnn123@gmail.com>
X-Cookie: The only perfect science is hind-sight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2020 at 05:30:03PM +0800, Yongbo Zhang wrote:

> Acked-by: Mark Brown <broonie@kernel.org>

I didn't send an Acked-by...

> Changes since v1:
> - Fix build errors for sound/soc/sh/rcar/ssi.c
>=20
> Changes since v0 (thanks for the feedback Morimoto):
> - Replace the value of a register variable
> ---

As covered in submitting-patches.rst the inter-version changelog should
come after the --- so they get automatically dropped by the tools when
the patches are applied.

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl66byAACgkQJNaLcl1U
h9BJbgf+LkSOsLJXqaPOOA4t0WY7+ZFUXwq3yyiBXkB0RwzQJW6ncVLUwgCPce5E
Dpr80WMMGZNFbJ8OywdMDqNucSc0Ivqan0lUrueq95EBHouOA0f4Ll4ehbovwg6J
rfaY8bR+jJPGKX0XD8G8gnxvwDb5JxcjawIxJZfHFZIMzgTRmY5l/8OUIL3oAJBS
ov+YTx5WKj6ngCzHx8cs0Sj/xn09uX+a41Qy/w5D4bTSJA0UwypN0nmH+hCseB8e
GoT8N/Pl0l5t/WPyuAem5cy+GdH3t6CPZVHjvIHoTrSePrnE5Bwy2P9K1Rje2mKK
VnLYgSxlm4HclknEmSHNbkXe//PE5w==
=fVhb
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
