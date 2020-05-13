Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9CEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6994E20690
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589383968;
	bh=C/N9FIfCZHMh9EGxSyQqk1iZZmo+/7mzHg2e3Ia0L1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X6ncOcSYm2BP9I7W0E/TE4gXILp+1LpJ4eUPjuRR5U8a+ymoImoZE2WdWmLU30AbU
	 Rn6F/ZqETZFO1s6VLls3V3OhLV0Xjsg5cn3BmduKNcIG5bSigD7fHvuaNWwyHQqlhk
	 M3o4/mpUq4stqVfcu/SChZzuDe61K/BVHzVK1Dv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389193AbgEMPcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:32:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729546AbgEMPcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:32:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45EF520671;
        Wed, 13 May 2020 15:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589383966;
        bh=C/N9FIfCZHMh9EGxSyQqk1iZZmo+/7mzHg2e3Ia0L1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n+9kSdXRBx0dDZtEKjZGv+Ow0KyRX21TIcUGnkTr1KCuxteg0DhsOusf2FJrjyKp1
         YyHEYc/jYpi7s3nxCpF3LuZpjY8K1BilGi2VUQlNmoaNN3/QQbdvsyAOEwtZy1oruu
         fc0to2v+l7mTA4oAkS2STP57F8VP99saKHxtXRQc=
Date:   Wed, 13 May 2020 16:32:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tlv320adcx140: Add controls for PDM clk and edge
Message-ID: <20200513153243.GO4803@sirena.org.uk>
References: <20200513144746.14337-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gqEssfNGWsEa4HfM"
Content-Disposition: inline
In-Reply-To: <20200513144746.14337-1-dmurphy@ti.com>
X-Cookie: Long life is in store for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gqEssfNGWsEa4HfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2020 at 09:47:46AM -0500, Dan Murphy wrote:

> +static const char * const pdmclk_text[] = {
> +	"2.8224 MHz", "1.4112 MHz", "705.6 kHz", "5.6448 MHz"
> +};
> +
> +static SOC_ENUM_SINGLE_DECL(pdmclk_select_enum, ADCX140_PDMCLK_CFG, 0,
> +			    pdmclk_text);
> +
> +static const struct snd_kcontrol_new pdmclk_div_controls[] = {
> +	SOC_DAPM_ENUM("PDM Clk Divider Select", pdmclk_select_enum),
> +};
> +
> +static const char * const pdm_edge_text[] = {
> +	"Negative", "Positive"
> +};

Are these (especially the clock and polarity) things that are going to
vary at runtime?  I'd have expected these to come from the hardware
rather than being something that could usefully change.

--gqEssfNGWsEa4HfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl68ExsACgkQJNaLcl1U
h9AYXwf8CDQMAxRVDvKQhd4vXEmLmaggMSdkYS9R7GwjxYhFwSWmXTNjDbM2lgot
uBF+G/YhxOy96eCpN+DenbicG+no7Vu/JmzeyrlPGVH7Oks9mdENb63rvnLjnyLg
GWM3GCrqbCwEN2IWbuQvytenhGLwliYh8tFSSoEk/y7nhc0n8uVHK+ifBnBk3sBs
8Hs4KO+LIP+Q2DOjSJmTmbbNrZY8X5nIYtMdvbLPNSYSjAsutzCFlMi151V514sP
f0Ui1rhafy5ekQkFRZRCrPjs6Zg4MtMmYN245ROgnuD/UuPi6g1ZSnzohkXB9A3g
JP04uB7C/9qlvOJkktKcLRWEhifElA==
=Ts3k
-----END PGP SIGNATURE-----

--gqEssfNGWsEa4HfM--
