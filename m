Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E0EC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A159C20801
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589195030;
	bh=DgjQ4t5B+iWHHzTaX1d+gS0bC2w3AC2yiTIZkqa7eeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mI+punV05Y/hHg+yHuqwBxA7lZ2+RinHOFU6kE23r2LSmRAYFSA5P6ObCvRx33eJS
	 XVFTCu/gRwPoFg35fPi+an7wXCgGH3DG6wm0vnGXsAdV7ktC/gwsUJvDQLEFnEONxa
	 o589yDmxuksvLtpyX8sGu6ENQqa+B3p08pjsjJRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgEKLDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:03:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgEKLDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:03:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D888206F9;
        Mon, 11 May 2020 11:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589195028;
        bh=DgjQ4t5B+iWHHzTaX1d+gS0bC2w3AC2yiTIZkqa7eeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilMbR2RbeQu1sVlK/6nq9NvkernGroLe5nJnzglwmy/sJ4zbJghwgi4k9M7dGdIVy
         C+GW49ni9H21Y77QNl1v8EPAMCtc78nuk0c57nJpt5k7kZWydXbRhbfAy1OzyyH+lt
         T9ZReD/SOo1Nn2M+OnyIZCyZPazmZRm6kuouGbVw=
Date:   Mon, 11 May 2020 12:03:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Steve Lee <steves.lee.maxim@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, geert@linux-m68k.org,
        rf@opensource.wolfsonmicro.com, shumingf@realtek.com,
        srinivas.kandagatla@linaro.org, krzk@kernel.org, dmurphy@ti.com,
        jack.yu@realtek.com, nuno.sa@analog.com,
        steves.lee@maximintegrated.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, ryan.lee.maxim@gmail.com
Subject: Re: [PATCH 2/2] ASoC: max98390: Added Amplifier Driver
Message-ID: <20200511110346.GE8216@sirena.org.uk>
References: <20200509031919.9006-1-steves.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
In-Reply-To: <20200509031919.9006-1-steves.lee@maximintegrated.com>
X-Cookie: TANSTAAFL
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 09, 2020 at 12:19:19PM +0900, Steve Lee wrote:
> Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>

This looks mostly good, a few smallish things below though:

> +++ b/sound/soc/codecs/max98390.c
> @@ -0,0 +1,1039 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020, Maxim Integrated.
> + */

Please make the entire comment a C++ one so things look more
intentional.

> +	dev_info(component->dev, "Tdm mode : %d\n",
> +			max98390->tdm_mode);

This is a bit noisy, please make it at most a dev_dbg().

> +static const char * const max98390_analog_gain_text[] = {
> +	"Mute", "3dB", "6dB", "9dB", "12dB", "15dB", "18dB"};

Use TLV data with regulator Volume controls for volumes, don't make them
enums.

> +static const char * const max98390_boost_voltage_text[] = {
> +	"6.5V", "6.625V", "6.75V", "6.875V", "7V", "7.125V", "7.25V", "7.375V",
> +	"7.5V", "7.625V", "7.75V", "7.875V", "8V", "8.125V", "8.25V", "8.375V",
> +	"8.5V", "8.625V", "8.75V", "8.875V", "9V", "9.125V", "9.25V", "9.375V",
> +	"9.5V", "9.625V", "9.75V", "9.875V", "10V"
> +};

Is this really something that should be configured at runtime rather
than through DT?

> +static const char * const max98390_current_limit_text[] = {
> +	"0.00A", "0.50A", "1.00A", "1.05A", "1.10A", "1.15A", "1.20A", "1.25A",
> +	"1.30A", "1.35A", "1.40A", "1.45A", "1.50A", "1.55A", "1.60A", "1.65A",

This looks like it should be in DT too.

> +static int max98390_dsm_calib_get(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component =
> +		snd_soc_kcontrol_component(kcontrol);
> +
> +	dev_warn(component->dev, "Get dsm_calib_get not supported\n");
> +
> +	return 0;
> +}

Just don't implement the operation if you can't implement it.

> +	dev_info(component->dev,
> +		"max98390: param fw size %d\n",
> +		fw->size);

This should probably be a dev_dbg() too.

> +	/* Amp Setting */
> +	regmap_write(max98390->regmap, MAX98390_CLK_MON, 0x6f);
> +	regmap_write(max98390->regmap, MAX98390_PCM_RX_EN_A, 0x03);
> +	regmap_write(max98390->regmap, MAX98390_R203D_SPK_GAIN, 0x05);
> +	regmap_write(max98390->regmap, MAX98390_MEAS_EN, 0x03);
> +	regmap_write(max98390->regmap, MAX98390_PWR_GATE_CTL, 0x2d);
> +	regmap_write(max98390->regmap, MAX98390_ENV_TRACK_VOUT_HEADROOM, 0x0e);
> +	regmap_write(max98390->regmap, MAX98390_BOOST_BYPASS1, 0x46);
> +	regmap_write(max98390->regmap, MAX98390_FET_SCALING3, 0x03);

Are some of these things that might vary per system?  If so they
probably shouldn't be hard code but instead in DT.  Things like the
speaker gain jump out.

> +static int max98390_suspend(struct device *dev)
> +{
> +	struct max98390_priv *max98390 = dev_get_drvdata(dev);
> +
> +	dev_info(dev, "%s:Enter\n", __func__);

dev_dbg()

> +static int max98390_resume(struct device *dev)
> +{
> +	struct max98390_priv *max98390 = dev_get_drvdata(dev);
> +
> +	dev_info(dev, "%s:Enter\n", __func__);

dev_dbg()

> +	dev_info(&i2c->dev, "ASoC: MAX98390 i2c probe\n");

Just drop this.

> +	ret = device_property_read_u32(&i2c->dev, "maxim,temperature_calib",
> +				       &max98390->ambient_temp_value);

Normally for DT that'd be maxim,temperature-calib.

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl65MREACgkQJNaLcl1U
h9Agswf/W7wxYge4lX5Nh8L9Ijk9piGmVyMcg0PO7bOy0r7wGdBZN85THGa7q4XD
XvddrMrImLsI1/bur3AJ4R0Qxi6SM7VsWGtYvIM153KPDPJAeu4cAesjD2PhsHzL
tFWU11c9Ziq0chNU8t7Mx9i0gYMcxvEgDjMGQlY7+FMJqYlh2ivRq6gpYYtPMWVA
oGscpFnuOz8aJ8QBC/OrLyljDofbaoBzVcp0Jng5wo89azm0nKN9yTxCaBUr/oop
ET+J+wQ0eWbFVCBCukvT9zi3ODi0EoE+kQeO6Iuqo2QQCMye57CWMRb50F/ZSl7a
6YpOnVX+X/Fooyrx6G8hauaEjUS8Pg==
=sOxO
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--
