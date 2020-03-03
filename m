Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E706C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C60220675
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583241678;
	bh=XB238MXEfH8xpKZt76KZ0NzhaYG/4J/KJ091QcUfRwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aGL4N8H8Pl6JYIKS5/wYehxS2KoZjkS3ClKWMF5SOtrxOzNtGe4bb5qUjoTptDfne
	 I0h8geXikpeFoT2sAe+wnI/T6Y9xNP9dYi7jwCYzA+6HPXN9LuE2Z3+DrYkEA52bzO
	 FsCby17G/p+Vs4AJNd2Fb+s0BVfQJnIrOBKCRQpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgCCNVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:21:17 -0500
Received: from foss.arm.com ([217.140.110.172]:46920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbgCCNVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:21:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B1D8FEC;
        Tue,  3 Mar 2020 05:21:16 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E33803F534;
        Tue,  3 Mar 2020 05:21:15 -0800 (PST)
Date:   Tue, 3 Mar 2020 13:21:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/3] ALSA: pcm: Add a standalone version of
 snd_pcm_limit_hw_rates
Message-ID: <20200303132114.GF3866@sirena.org.uk>
References: <20200223034533.1035-1-samuel@sholland.org>
 <20200223034533.1035-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7mxbaLlpDEyR1+x6"
Content-Disposition: inline
In-Reply-To: <20200223034533.1035-2-samuel@sholland.org>
X-Cookie: Drilling for oil is boring.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7mxbaLlpDEyR1+x6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 22, 2020 at 09:45:31PM -0600, Samuel Holland wrote:
> It can be useful to derive min/max rates of a snd_pcm_hardware without
> having a snd_pcm_runtime, such as before constructing an ASoC DAI link.

Takashi, are you OK with me taking this patch?

--7mxbaLlpDEyR1+x6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5eWckACgkQJNaLcl1U
h9Ducwf/YF/9IryVmRNLlQXZGWZvKAI5ANfSxt6KxrXJelsiOzPqfIIwJARt5zer
SIOmcAciTHMHaIcr577bM0h9o0GocGU0Ugr9xJimGbIkHkkV8vVP5FvEG5BzDmzq
+HXwIbriuIB/ya21VXYghWnFqlLtWnaqAPm+pjGJRdwNglphNYgz+YOO/Rg7VMhp
5LmuTTeNsEW3ZkOzsVUHE5/Dzv5k4KOGd0IXd6mnNZ/elE03NgVTNinYZTYVFF2c
wjylTL3Lj2LAq5glbu2Jkm5DIEY/9LsB3PlYwiHVwcl/cgSfU5b+pz6oE/r2ezmT
COhEOZGW3psRcCnqHaxjrsTwfYhNEg==
=terh
-----END PGP SIGNATURE-----

--7mxbaLlpDEyR1+x6--
