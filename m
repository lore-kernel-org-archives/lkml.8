Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DA9C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E498206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582291293;
	bh=7jBCZFzRAMGvkjduzvrnNgKG2uWZV8YyKE222d9XAbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Gxsa1Y1Ys3tgcI5weIYVWSE2by+g4P89Desoc/IkEGIHXSPDFMilHd3Rqm5Fr6zNo
	 87hajyG8sG2s/K/f5vOM4USOcn6MlZ5FdgsYDDfai2i4Nduk7cas+XgvyRRyrylljo
	 3z0GNsxRQGYYFLAIdBfK5VjSG5/dp8+xcO7KKGr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgBUNVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:21:32 -0500
Received: from foss.arm.com ([217.140.110.172]:39206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbgBUNVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:21:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CD1630E;
        Fri, 21 Feb 2020 05:21:30 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D526C3F703;
        Fri, 21 Feb 2020 05:21:29 -0800 (PST)
Date:   Fri, 21 Feb 2020 13:21:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, digetx@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        sharadg@nvidia.com, mkumard@nvidia.com, viswanathl@nvidia.com,
        rlokhande@nvidia.com, dramesh@nvidia.com, atalambedu@nvidia.com
Subject: Re: [PATCH v3 04/10] ASoC: tegra: add Tegra210 based I2S driver
Message-ID: <20200221132128.GE5546@sirena.org.uk>
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-5-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
Content-Disposition: inline
In-Reply-To: <1582180492-25297-5-git-send-email-spujar@nvidia.com>
X-Cookie: Dead? No excuse for laying off work.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 12:04:46PM +0530, Sameer Pujar wrote:

> @@ -0,0 +1,938 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * tegra210_i2s.c - Tegra210 I2S driver
> + *

All C++ please.

> +static void tegra210_i2s_set_data_offset(struct tegra210_i2s *i2s,
> +					 unsigned int data_offset)
> +{
> +	unsigned int mask = I2S_CTRL_DATA_OFFSET_MASK;
> +	unsigned int shift = I2S_DATA_SHIFT;
> +	unsigned int reg;
> +
> +	reg = TEGRA210_I2S_TX_CTRL;
> +	regmap_update_bits(i2s->regmap, reg, mask, data_offset << shift);
> +
> +	reg = TEGRA210_I2S_RX_CTRL;
> +	regmap_update_bits(i2s->regmap, reg, mask, data_offset << shift);

The way this is written is *weird*, especially the use of reg - it'd
probably be clearer to just use the values directly rather than have
these intermediate temporary values.

> +static int tegra210_i2s_get_control(struct snd_kcontrol *kcontrol,
> +				    struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *compnt = snd_soc_kcontrol_component(kcontrol);
> +	struct tegra210_i2s *i2s = snd_soc_component_get_drvdata(compnt);
> +	long *uctl_val = &ucontrol->value.integer.value[0];
> +
> +	if (strstr(kcontrol->id.name, "Loopback"))
> +		*uctl_val = i2s->loopback;
> +	else if (strstr(kcontrol->id.name, "Sample Rate"))
> +		*uctl_val = i2s->srate_override;
> +	else if (strstr(kcontrol->id.name, "FSYNC Width"))
> +		*uctl_val = i2s->fsync_width;
> +	else if (strstr(kcontrol->id.name, "Playback Audio Bit Format"))
> +		*uctl_val = i2s->audio_fmt_override[I2S_RX_PATH];
> +	else if (strstr(kcontrol->id.name, "Capture Audio Bit Format"))
> +		*uctl_val = i2s->audio_fmt_override[I2S_TX_PATH];

Same issue as the DMIC driver, these really shouldn't be exposed to
userspace as regular controls.

> +	/*
> +	 * For playback I2S RX-CIF and for capture TX-CIF is used.
> +	 * With reference to AHUB, for I2S, SNDRV_PCM_STREAM_CAPTURE stream is
> +	 * actually for playback.
> +	 */
> +	path = (substream->stream == SNDRV_PCM_STREAM_CAPTURE) ?
> +	       I2S_RX_PATH : I2S_TX_PATH;

Please write normal conditional statements, it makes things easier to
read.

--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5P2VcACgkQJNaLcl1U
h9D/awf/U2ZCR7nNWNrI95I8xTMDKuA/JDQe0xYLuDIfs3GKQSPQMpUDhki+WZMN
DqFveacFKjMaU6kxGpoFWONkDSLzRjWguMjv0+SwXJPDbwYmJFsfOFNPc8AjXIDc
YsgXv6n/zHWQGC9w7tU3/Goy7n87FGWsBIKsBAQF2K4ZhubTgA9zggVBKLArj7J1
WpidsKFtr0DqBk/BKpQfERYQIQqND2xScFnTkrp80A55wu0rzNW2wP4XXWcOkPbS
jYoVHY81EV3ExQzN3T7FbOO6PWfXZMPwUw+UwfODLvFCbpmQJSkiMiv5x4qXJDrS
wxx80JuxpcjWr6qKYltb4t/R/+AgZg==
=0K47
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--
