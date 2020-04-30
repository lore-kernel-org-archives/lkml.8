Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475E7C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E962063A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588254982;
	bh=CtV13aq5EHUV1ZS63QEGO/ZcyB2FMYXMcfBQyRvAbo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NIh8tkPJk6K81xhtQPcnEETZ41E82FmTPSsWT6PflEvoyB0ktIrFmVCsK1RK/ljH2
	 GsHp0yyXpXn+bC1srIaxvn6jcjeJWzi9woVs9RDotAEX/eIW8oMEHwMiK8p6eGJsYX
	 p2a4NA3Z8e1JQmFNcV+m0oTe1pwXEx+Nq/F9wCz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgD3N4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:56:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729202AbgD3N4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:56:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7821E2072A;
        Thu, 30 Apr 2020 13:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254972;
        bh=CtV13aq5EHUV1ZS63QEGO/ZcyB2FMYXMcfBQyRvAbo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zgED640dEidKBx4f+5IYcttqkLLgMNsPupj8XSvfZrstPPLUzJXejf6/XpjMx1Z0O
         csJYRNoXMxf+3Vgf4ZOVgj1ukvOFOyk6NwEKmYgBbExJWm2MCAwOJKR0Ms+nhM9I2h
         YMM3VPC8n/9CDRCU7aUQSlJVoq1Vv8HuRH1iLURk=
Date:   Thu, 30 Apr 2020 14:56:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH AUTOSEL 5.6 45/79] ASoC: meson: axg-card: fix
 codec-to-codec link setup
Message-ID: <20200430135610.GD4633@sirena.org.uk>
References: <20200430135043.19851-1-sashal@kernel.org>
 <20200430135043.19851-45-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
Content-Disposition: inline
In-Reply-To: <20200430135043.19851-45-sashal@kernel.org>
X-Cookie: Sign here without admitting guilt.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 30, 2020 at 09:50:09AM -0400, Sasha Levin wrote:

> Since the addition of commit 9b5db059366a ("ASoC: soc-pcm: dpcm: Only allow
> playback/capture if supported"), meson-axg cards which have codec-to-codec
> links fail to init and Oops:

This clearly describes the issue as only being present after the above
commit which is not in v5.6.

--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6q2PkACgkQJNaLcl1U
h9DApAf/a8MgVHko2gpdxkUsvbUQwdEzB7YRiWynwvKJ/ud0k+E08H894+NR3LF5
FBgvDURotlT45pncz5G3Rynkgvbr9IluKuJLSfVXhCzrGXHiFXxxDQZncs18Lr+f
/nmdtOzXoRLBHZiYY60a/Wzsw+b3VhM01JmFnvodnIQoEojGAkr09lEIQQhvpr3I
jJjRWp3KzVzU9z0dYXW2m4fqPeDAmvKM6G5USTnXdgx8QlRfWKs5I8EgSLFwG+gR
1pqi95AFL8hQZevt81Jl5qHQuI/Xyn2Wz0lWlGfZG3BaSDJYe6peJSiSfxdpmpV7
Nv7JtglVXZvI6Y33OxL56LJJaPVAng==
=G+K6
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--
