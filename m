Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028FBC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7DB822CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596658103;
	bh=DoGeIX/K/WQD2EoWJAPc85XT/sRceZfwp6Sz/3mnlng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1nn/1nGFiOAdo47yYFMtIPHQXQhhMA1pO2cHwZ8iur+3wIsjjz9aTeQsF4wma/Sxw
	 AbeHfubi4O9fpR78wt2uea5ZytnXc8fiOb1w0amC+M8HZgKEcWGYn2+EzHmj43nXY8
	 dkCwGZknm+us0AiNisncv/Jg0qHUM5y3cloTLlJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgHEUIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:08:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgHEQce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:32:34 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63E2B22CAF;
        Wed,  5 Aug 2020 11:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596625395;
        bh=DoGeIX/K/WQD2EoWJAPc85XT/sRceZfwp6Sz/3mnlng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Du6bqzA3op+rhWbEOcffwkqeDbF9QjzE4OhhZHo/OCE/EET8cOJ1FLk/RF1WI8ZrI
         RvgjJkSCpYJkk2FCpPSdwPcQoEU30xWNzoShioOeQHzGh2GPaylKH7ZTf/1OH1wfwQ
         m8gFsJJ6VUuhj2TjSGtd2j98uhiOK8bghTctsaLs=
Date:   Wed, 5 Aug 2020 12:02:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alain Volmat <alain.volmat@st.com>
Cc:     amelie.delaunay@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com
Subject: Re: [PATCH 15/18] spi: stm32: fix stm32_spi_prepare_mbr in case of
 odd clk_rate
Message-ID: <20200805110253.GI5556@sirena.org.uk>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
 <1596610933-32599-16-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2nTeH+t2PBomgucg"
Content-Disposition: inline
In-Reply-To: <1596610933-32599-16-git-send-email-alain.volmat@st.com>
X-Cookie: Fast, cheap, good: pick two.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2nTeH+t2PBomgucg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2020 at 09:02:10AM +0200, Alain Volmat wrote:
> From: Amelie Delaunay <amelie.delaunay@st.com>
>=20
> Fix spi->clk_rate when it is odd to the nearest lowest even value because
> minimum SPI divider is 2.

This is a fix too.

--2nTeH+t2PBomgucg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8qkdwACgkQJNaLcl1U
h9AVmwf/Wo06/OERR2lAw0RzRYSOlfhuvCH5xOIV/kCFaXFkYkWrIVh3Rs95o++S
fAWl6VIdj7+20v+gOTalGTMtGp2ok8CJ30YDU0D0gPgQ+w09fZCY+TFF6W6hn2mQ
UbQ7pXIEDnzm0dF8yX2kqKYF8TYFFPp7HHG/fuSDbNmdKKUc+koTISwehYUlIfpX
Q7gmZIIQiOecel4hdaQk9aN1owlGoAVUJf5JiO3n/xw5UOpVtYTgkwlL/xYCg07N
2fmaMI9Hyfn0ZySzWe5e0FtM58vnIhLg11B7iKmyT8eem/Up+ombyZmXpFAPL78j
dmT4X0Rh2clIu/4tRNY6mLp7QBcYFg==
=cEJW
-----END PGP SIGNATURE-----

--2nTeH+t2PBomgucg--
