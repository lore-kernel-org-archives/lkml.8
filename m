Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFFCC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13BE020656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587986527;
	bh=0jmC6ymb22IxBunv3XGNmRuVyT/qlxFM1kkb/eWadrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wOjbud0ZUs0FY/PPl/X5pQuUw78JPY4kfpVK/KOiXqFylLqoqi7RuTEhm3Pg1J1eo
	 4nXEnLj9jx7NjchSgOfmxn7/vZm9TSDiRziWO8vuw0jj8EbwkNQs8Ue+PMbMiL6TIo
	 Q2hKcm+1C2nB7V7sHYpNrgWZ7tEswrdeGrf2dqA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgD0LWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 07:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgD0LWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:22:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A319B205C9;
        Mon, 27 Apr 2020 11:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587986525;
        bh=0jmC6ymb22IxBunv3XGNmRuVyT/qlxFM1kkb/eWadrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oMCK4UYlbGod1a1y5XvygMeHe8P1YvmunwSWbIIZ552DSBYHSFnaTtzvitje4yc5D
         UzTJgJwuPOO6O26FCKCXDrZ5nLtvogMTIbATLS/45lkyOxvE8oz98oRZNmjLdx9+Y8
         prTJZl+Z5mrHc6TlOUvyi31ZKDG5NOWMKWlkKNSY=
Date:   Mon, 27 Apr 2020 12:22:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: wm8994: Silence warnings during deferred probe
Message-ID: <20200427112202.GB4272@sirena.org.uk>
References: <20200427074832.22134-1-m.szyprowski@samsung.com>
 <CGME20200427074843eucas1p1a3a265df0c7f14b0aaec25eb65daf606@eucas1p1.samsung.com>
 <20200427074832.22134-5-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <20200427074832.22134-5-m.szyprowski@samsung.com>
X-Cookie: Secrecy is the beginning of tyranny.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 27, 2020 at 09:48:32AM +0200, Marek Szyprowski wrote:
> Don't confuse user with meaningless warning about the failure in getting
> clocks in case of deferred probe.

>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "Failed to get clocks: %d\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Failed to get clocks: %d\n", ret);

This completely eliminates the diagnostics which means that if the clock
isn't there the user is a bit stuck trying to work out what's missing.
There should still be a diagnostic.

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6mwFkACgkQJNaLcl1U
h9CnKgf+L0DHzyP9uJrX9mcCSOEFMqGDbUbVooabgQKACLN2NqFor9WHedKckCIh
fDOp+RpDynCvnBX7erSNkPM8Hkpo8VemUi+ULRs+Bj2qP1h6t+069tYs+AZ8f9VJ
dAWfnctdgI8rYKrfwFa7zPToZbEYNX+3tZHwBMwnpW12+maRF788h2uas/h6Ae2s
9o0nObKwrSLLvvnqvFXGPeX6UZ4kXayfQ8RojLR+y+QtkcLZTZeB2WGuowRS62wD
yccW4mzrZojzcC3aSuuCosv3h9wEMbMb+g1PIF4cCUGz14oywcWiVBDiEi7uMSWp
oyQQZ6ObUxSdmIvqgirYU5GA67W+wA==
=MSap
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
