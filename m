Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329D7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0487720781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593114499;
	bh=uzH/zbvI7mXH91HII5T3EmFm3Z0LLYSHseycel1azkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sgbOlrhhpZ7FamxBMGJjqhej9mj4MrAkEHTOqUmq2ctnOOqudrdmUpzZmCIKX0XqA
	 rTvW2vvpGrnpjr8lGeQ+gNZ4EIm1NXZXA3MX6frYriJvu2jpfSlaH94w6kmF2abD7+
	 GUyMJmCEskaMYxCpaB/qn9IghEluNPycUaqsUyn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406851AbgFYTsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406825AbgFYTsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:48:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 757242076E;
        Thu, 25 Jun 2020 19:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593114496;
        bh=uzH/zbvI7mXH91HII5T3EmFm3Z0LLYSHseycel1azkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iD4Hif8UykoWrmc1EdrDF9JXBecktg/a8sO0VYEJmPd2LXIj0XY/dze61qPH649GF
         7X1m6KE3Uu8oF7MN6FH8rqcQZA5ACUuJV0hDZYpgqtmUZRPdjLP5pSVdpblCm7ujYz
         ZuFIrR12QqAyvU2rsoXyAVOKQYlHBvbij7zDUFZs=
Date:   Thu, 25 Jun 2020 20:48:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND 00/10] Fix a bunch of W=1 warnings in Regulator
Message-ID: <20200625194813.GI5686@sirena.org.uk>
References: <20200625191708.4014533-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3eH4Qcq5fItR5cpy"
Content-Disposition: inline
In-Reply-To: <20200625191708.4014533-1-lee.jones@linaro.org>
X-Cookie: One organism, one vote.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3eH4Qcq5fItR5cpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 08:16:58PM +0100, Lee Jones wrote:
> Attempting to clean-up W=3D1 kernel builds, which are currently
> overwhelmingly riddled with niggly little warnings.
>=20
> Resent to include patch contributors/maintainers/MLs.

Is this an actual resend or did you fix the issues I raised?

--3eH4Qcq5fItR5cpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl70/3wACgkQJNaLcl1U
h9AA4Qf+KkOjTqUd8djWH7IWvhkMrk3YuldRQSTZQH6EdodjbGpnBoew2b5RjjQf
z/u850ebf7xhod4GhdA/FBR5BtXH2v9xGZBmcVqtS+S1ljCf1yyrzo5XvAElh822
cqjXH2q3xJOLqsibexEiAeseC/xHNLPRj/VZlYzISDL0TOGijkLIAVc7VcAT7UT1
uqmDY+IH+qu/Y1pY5AUWueGZHWYCKCkUduBDifGogGP4mOeJgfn171QYnfuXqJ2b
lF/QxrfVnHICJu9tN3EBFiNPhu8rQSBzX4AyCoLFro2ZRQBAX2mxQClzSyv+j3E6
Lc4jlQ5ZzPOGPU+1HK/WKcPqADp5xw==
=//fX
-----END PGP SIGNATURE-----

--3eH4Qcq5fItR5cpy--
