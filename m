Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278D2C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4992072A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583757191;
	bh=VLSxHv8anoy7mlzYMdzndVwqFAu/E3RgobpgCmTpea0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AY6kkF6hPKkmwZOgaOMqw3PKStln2KtwwUXWir4JlO71kBd81DaGk8w744sabvxhV
	 AdfWovT7uDinPSLbphmvG8xdnFOEJlH660LeK0sfaWfpDZznEC8vln9MsZX3EVRlQF
	 T0XJvoSq1+U0jf8gWFjopk2ftl3TeZRaWhQj3eNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgCIMdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 08:33:10 -0400
Received: from foss.arm.com ([217.140.110.172]:51710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgCIMdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:33:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F3AB30E;
        Mon,  9 Mar 2020 05:33:09 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 972473F6CF;
        Mon,  9 Mar 2020 05:33:08 -0700 (PDT)
Date:   Mon, 9 Mar 2020 12:33:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kevin Li <kevin-ke.li@broadcom.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Jaroslav Kysela <perex@perex.cz>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stephen Boyd <swboyd@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: brcm:  Add DSL/PON SoC audio driver
Message-ID: <20200309123307.GE4101@sirena.org.uk>
References: <20200306222705.13309-1-kevin-ke.li@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
Content-Disposition: inline
In-Reply-To: <20200306222705.13309-1-kevin-ke.li@broadcom.com>
X-Cookie: Above all things, reverence yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 06, 2020 at 02:27:04PM -0800, Kevin Li wrote:
> This patch adds Broadcom DSL/PON SoC audio driver
> with Whistler I2S block. The SoC supported by this
> patch are BCM63158B0,BCM63178 and BCM47622/6755.

Please number patches within a series when you send it -
submitting-patches.rst should cover this.

> +++ b/sound/soc/bcm/bcm63xx-i2s-whistler.c
> @@ -0,0 +1,328 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * linux/sound/bcm/bcm63xx-i2s-whistler.c
> + * BCM63xx whistler i2s driver

Please make the entire comment a C++ one so things look more
intentional.

> +static int bcm63xx_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
> +{
> +	return 0;
> +}

Remove empty functions, if the framework prevents removing the function
entirely that's a sign that you need to do something.

> +static int bcm63xx_i2s_startup(struct snd_pcm_substream *substream,
> +			       struct snd_soc_dai *dai)
> +{
> +	unsigned int slaveMode;

Please use the kernel coding style.

> +	struct bcm_i2s_priv *i2s_priv = snd_soc_dai_get_drvdata(dai);
> +	struct regmap *regmap_i2s = i2s_priv->regmap_i2s;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		regmap_update_bits(regmap_i2s, I2S_TX_CFG,
> +				   I2S_TX_OUT_R | I2S_TX_DATA_ALIGNMENT |
> +				   I2S_TX_DATA_ENABLE | I2S_TX_CLOCK_ENABLE,
> +				   I2S_TX_OUT_R | I2S_TX_DATA_ALIGNMENT |
> +				   I2S_TX_DATA_ENABLE | I2S_TX_CLOCK_ENABLE);
> +		regmap_write(regmap_i2s, I2S_TX_IRQ_CTL, 0);
> +		regmap_write(regmap_i2s, I2S_TX_IRQ_IFF_THLD, 0);
> +		regmap_write(regmap_i2s, I2S_TX_IRQ_OFF_THLD, 1);
> +
> +		regmap_read(regmap_i2s, I2S_RX_CFG_2, &slaveMode);
> +		if (slaveMode & I2S_RX_SLAVE_MODE_MASK)
> +			regmap_update_bits(regmap_i2s, I2S_TX_CFG_2,
> +					   I2S_TX_SLAVE_MODE_MASK,
> +					   I2S_TX_MASTER_MODE);
> +		else
> +			regmap_update_bits(regmap_i2s, I2S_TX_CFG_2,
> +					   I2S_TX_SLAVE_MODE_MASK,
> +					   I2S_TX_SLAVE_MODE);

Setting master or slave mode should be done with a set_fmt() operation
but your set_fmt() operation was empty.  How would this be configured?

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5mN4IACgkQJNaLcl1U
h9CHFQf+MmfeIV26USY3oRJZbEj/rIkPnEVV5ZaGZbjZh+03KnAh8C+1n+hNYPGH
NGZTWQ3N5t2hDecM/JWR8bgmyrjW5HM0N4ICJBfNMVhJmwI49xJszkJrjQaDB9Gt
ep2UXzYoDAWUV+mvs5jqIC6PtmyXVXdtoULsgCy9jRNuHyqqBu+anpawMyw8MaOo
q3mLQiAG2mxopXXwV/OxeeXtfutAN8LDCVvLAfQr4ElkJuEUQDGS1YN7Q2g1Fbpi
nODU5PmoACBdMrzDxnbHXDAD1IjKDNuCiMaCqavsHgmuh9jXb0LG9wh747l07BL+
02ZAt8hazsrXGztdvVNOtyWo7v3wFw==
=6Y1J
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--
