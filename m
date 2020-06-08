Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8649CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 636AC2076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591617453;
	bh=nAtsiXTcR+OAIznew/hWTw3IpqmB5O6uM3hw6iSU2Fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kM1iL6qrCnBlA12QhQEeukd2WKqQnq6tWhzXCpqRscuoMBK3uQy0zmuXY8N1T9M1h
	 K2BuCuAdTWmnKl77pE0mCIWg//eYU+RVRzM9GBdfCG04RxnzqCpaiPgAgEAXEoN2w1
	 USVw8U2gexS3IhY75MPKhAuIi7H90VcjZ9pp02gs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgFHL5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 07:57:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729549AbgFHL5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 07:57:31 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E2632072F;
        Mon,  8 Jun 2020 11:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591617450;
        bh=nAtsiXTcR+OAIznew/hWTw3IpqmB5O6uM3hw6iSU2Fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TsEbl3mitixyjIOjM1w4hUKYXomkdL5t+OU2sRkL262ye+9PR8XJjj0hkwTzmqgn+
         Vr54CwuaIDyBn0Dpkgi88bsn/Wuo22C1848vdbbCcvzqaf4q4xDP/eAarZWeOnzyZ9
         L8VOzwy/UDGDFapO3M6kRTPBLJDvOphztk1rlTZ0=
Date:   Mon, 8 Jun 2020 12:57:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     jbrunet@baylibre.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, khilman@baylibre.com, alsa-devel@alsa-project.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH] soc/meson: add missing free_irq() in error path
Message-ID: <20200608115728.GF4593@sirena.org.uk>
References: <20200606153103.GA17905@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TeJTyD9hb8KJN2Jy"
Content-Disposition: inline
In-Reply-To: <20200606153103.GA17905@amd>
X-Cookie: I'm rated PG-34!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TeJTyD9hb8KJN2Jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 06, 2020 at 05:31:03PM +0200, Pavel Machek wrote:
> free_irq() is missing in case of error, fix that.
>=20
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
>=20
> diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c

In addition to the subject line issue your Signed-off-by does not match
the From: in the e-mail and there's no From: in the body, please
resubmit with these issues fixed.

--TeJTyD9hb8KJN2Jy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7eJ6cACgkQJNaLcl1U
h9D/cQf+L7dper1ZvO7kYwre40pI8oRGB48niTj/ZkjOhATMnrDe60Nd5z4m792w
YoAXr9IELC+RF9XqtLINNvFb90CrXIkpG947Gmz7HRAG/6RHgomLQDhpx0nvu3b3
9CNRkiAx/cFTyI06laUaxVbUMVfqTZ1t6TQl5/Zj6ZBGqTkpRfF/D+z837DdhcAU
DR3pZxR+d3K79tFmzhMbp1LoCCXnTYHW8jUMxZNe6X2sumd/WkinCAZZV/JyS+k1
WTwS8Zumd/FdDu6p2ukRbQmo9jPw1t/vBCUm3l2il9Rlm0NgqkPigCZi3xNWUEBc
rdhd4zkQxoQqUzquhAnsdDcXwm3zwA==
=TJnD
-----END PGP SIGNATURE-----

--TeJTyD9hb8KJN2Jy--
