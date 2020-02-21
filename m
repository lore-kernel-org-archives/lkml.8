Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280DFC35655
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3051206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582290010;
	bh=wthlmQuSDesDNf0pY3CqpQQSDqKog1orGLVznIKggrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SbgHGZrCA2aTpfhTz0oIlfNbee9n6Ie34Oo/1z52VB7KO9L1Df5buZw2UNqnsZCls
	 sxdw0Nx2OcP/pmwYlrGp5MJ7L8pA2JNkzpK9b9sUitEE6R18NSWsTD5e0zsRgHllVV
	 50uCDVArY9XRFR8LTDPeLQ4d3/F6DxFmJH5jgAnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgBUNAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:00:09 -0500
Received: from foss.arm.com ([217.140.110.172]:38760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbgBUNAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:00:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A32E430E;
        Fri, 21 Feb 2020 05:00:07 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 049DA3F703;
        Fri, 21 Feb 2020 05:00:07 -0800 (PST)
Date:   Fri, 21 Feb 2020 13:00:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, digetx@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        sharadg@nvidia.com, mkumard@nvidia.com, viswanathl@nvidia.com,
        rlokhande@nvidia.com, dramesh@nvidia.com, atalambedu@nvidia.com
Subject: Re: [PATCH v3 03/10] ASoC: tegra: add Tegra210 based DMIC driver
Message-ID: <20200221130005.GD5546@sirena.org.uk>
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-4-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Content-Disposition: inline
In-Reply-To: <1582180492-25297-4-git-send-email-spujar@nvidia.com>
X-Cookie: Dead? No excuse for laying off work.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 12:04:45PM +0530, Sameer Pujar wrote:

> +++ b/sound/soc/tegra/tegra210_dmic.c
> @@ -0,0 +1,515 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * tegra210_dmic.c - Tegra210 DMIC driver
> + *
> + * Copyright (c) 2020 NVIDIA CORPORATION.  All rights reserved.

Please make the entire comment a C++ one so things look more
intentional.

> +	/* Below enables all filters - DCR, LP and SC */
> +	{ TEGRA210_DMIC_DBG_CTRL, 0xe },

So this isn't the hardware default?

> +	srate = params_rate(params);
> +	if (dmic->srate_override)
> +		srate = dmic->srate_override;

How does this work for userspace?  If we just ignore the sample rate we
were asked for I'd expect that the application would get upset.

> +	if (strstr(kcontrol->id.name, "Boost Gain"))
> +		dmic->boost_gain = value;

Volume controls should end in "Volume".

> +	else if (strstr(kcontrol->id.name, "Audio Channels"))
> +		dmic->audio_ch_override = value;

This is something that would usually come from hw_params?

> +	else if (strstr(kcontrol->id.name, "LR Polarity Select"))
> +		dmic->lrsel = value;

This and some of the others look like they're describing details of how
the board is wired up so I'd not expect them to be runtime selectable?

> +	SND_SOC_DAPM_MIC("Dummy Input", NULL),

This is just the microphone that happens to be attached, isn't it?  If
so that's a weird name.

> +static const char * const tegra210_dmic_mono_conv_text[] = {
> +	"ZERO", "COPY",
> +};

It'd be more idiomatic for ALSA to write these as Zero and Copy.

> +	SOC_ENUM_EXT("Channel Select", tegra210_dmic_ch_enum,
> +		     tegra210_dmic_get_control, tegra210_dmic_put_control),
> +	SOC_ENUM_EXT("Mono To Stereo",
> +		     tegra210_dmic_mono_conv_enum, tegra210_dmic_get_control,
> +		     tegra210_dmic_put_control),
> +	SOC_ENUM_EXT("Stereo To Mono",
> +		     tegra210_dmic_stereo_conv_enum, tegra210_dmic_get_control,
> +		     tegra210_dmic_put_control),

I'd expect these to be in DAPM.

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5P1FQACgkQJNaLcl1U
h9BA2Af/VZiFzp4MoCq6aYyxTqN++XhNykseNkA914Q2unjc80Do1s4RvyBiVMMC
wBE6BBamgXepZrzc9ZWbWkzZfVELsrMSoQd7vM/fhpf9tGek5CWS6vpJH2RvB4v+
O9C3WID4h/y+P9Hhk1wfqW76BDWm/iU3qlSc+TOwsV1pX3DG99lXX91VDg7J5llP
nA0V3PRaJzrhMeIYpNv2O8ZeG6mCYgsUJ3KzgDcqYn25Ry+BlV92ABRPq4jQrere
feW4lb8CKHMkTxj88Y7AmSRbYrqFoztdu9ce9APLVRVnDU9BcvediwEroMXKvGoQ
78AyFutp7288RxEv5Bwa85y4EMQaxQ==
=oc1c
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--
