Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3B8C11D0B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7971207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="c7akADfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgBTObC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:31:02 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2267 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgBTObC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:31:02 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4e98040000>; Thu, 20 Feb 2020 06:30:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 20 Feb 2020 06:31:01 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 20 Feb 2020 06:31:01 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Feb
 2020 14:30:58 +0000
Subject: Re: [PATCH v3 02/10] ASoC: tegra: add support for CIF programming
To:     Sameer Pujar <spujar@nvidia.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <digetx@gmail.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-3-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f930e81b-3635-3b4d-8613-6e8b43e2efaf@nvidia.com>
Date:   Thu, 20 Feb 2020 14:30:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582180492-25297-3-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582209028; bh=/2DIXcjbQPQs9k+oNntAmjdAP0LqWcaxt6oAb3yKVVk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=c7akADfrtIbqKyxxIT6045B97kZk7vUa4mFTeI19vX9+I/5R8lOOI91uL4ev5n0dk
         ZLm2KMp0hnhWmRFXqgwCgwoAAwXYl2xZEHPihPlKE+AjKNkzW2m2KT5jcqTF8KRBtl
         jfA1SJujzjrXXhTWYfbOqiEAKvr25vNuZ8H+cnfX3LquqTZ8AI2gLFMEdZJ7u4/e+g
         byP9CfMfcKizZIVtLKre325LUS7atFHQllm6Fp3oaBqeIZ9zgLaBauasM6X1mk3vVK
         PTbsQAzT9rbvd77Y579X7bGSKyzHHsGu4N59yU7pGSoERI4GXttSPt3qnNYl0Unz57
         zy3InnDcDDFOA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/02/2020 06:34, Sameer Pujar wrote:
> Audio Client Interface (CIF) is a proprietary interface employed to route
> audio samples through Audio Hub (AHUB) components by inter connecting the
> various modules.
> 
> This patch exports an inline function tegra_set_cif() which can be used,
> for now, to program CIF on Tegra210 and later Tegra generations. Later it
> can be extended to include helpers for legacy chips as well.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  sound/soc/tegra/tegra_cif.h | 63 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 sound/soc/tegra/tegra_cif.h
> 
> diff --git a/sound/soc/tegra/tegra_cif.h b/sound/soc/tegra/tegra_cif.h
> new file mode 100644
> index 0000000..ecc0850
> --- /dev/null
> +++ b/sound/soc/tegra/tegra_cif.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * tegra_cif.h - TEGRA Audio CIF Programming
> + *
> + * Copyright (c) 2020 NVIDIA CORPORATION.  All rights reserved.
> + *
> + */
> +
> +#ifndef __TEGRA_CIF_H__
> +#define __TEGRA_CIF_H__
> +
> +#define TEGRA_ACIF_CTRL_FIFO_TH_SHIFT		24
> +#define TEGRA_ACIF_CTRL_AUDIO_CH_SHIFT		20
> +#define TEGRA_ACIF_CTRL_CLIENT_CH_SHIFT		16
> +#define TEGRA_ACIF_CTRL_AUDIO_BITS_SHIFT	12
> +#define TEGRA_ACIF_CTRL_CLIENT_BITS_SHIFT	8
> +#define TEGRA_ACIF_CTRL_EXPAND_SHIFT		6
> +#define TEGRA_ACIF_CTRL_STEREO_CONV_SHIFT	4
> +#define TEGRA_ACIF_CTRL_REPLICATE_SHIFT		3
> +#define TEGRA_ACIF_CTRL_TRUNCATE_SHIFT		1
> +#define TEGRA_ACIF_CTRL_MONO_CONV_SHIFT		0
> +
> +/* AUDIO/CLIENT_BITS values */
> +#define TEGRA_ACIF_BITS_8			1
> +#define TEGRA_ACIF_BITS_16			3
> +#define TEGRA_ACIF_BITS_24			5
> +#define TEGRA_ACIF_BITS_32			7
> +
> +#define TEGRA_ACIF_UPDATE_MASK			0x3ffffffb
> +
> +struct tegra_cif_conf {
> +	unsigned int threshold;
> +	unsigned int audio_ch;
> +	unsigned int client_ch;
> +	unsigned int audio_bits;
> +	unsigned int client_bits;
> +	unsigned int expand;
> +	unsigned int stereo_conv;
> +	unsigned int replicate;
> +	unsigned int truncate;
> +	unsigned int mono_conv;
> +};
> +
> +static inline void tegra_set_cif(struct regmap *regmap, unsigned int reg,
> +				 struct tegra_cif_conf *conf)
> +{
> +	unsigned int value;
> +
> +	value = (conf->threshold << TEGRA_ACIF_CTRL_FIFO_TH_SHIFT) |
> +		((conf->audio_ch - 1) << TEGRA_ACIF_CTRL_AUDIO_CH_SHIFT) |
> +		((conf->client_ch - 1) << TEGRA_ACIF_CTRL_CLIENT_CH_SHIFT) |
> +		(conf->audio_bits << TEGRA_ACIF_CTRL_AUDIO_BITS_SHIFT) |
> +		(conf->client_bits << TEGRA_ACIF_CTRL_CLIENT_BITS_SHIFT) |
> +		(conf->expand << TEGRA_ACIF_CTRL_EXPAND_SHIFT) |
> +		(conf->stereo_conv << TEGRA_ACIF_CTRL_STEREO_CONV_SHIFT) |
> +		(conf->replicate << TEGRA_ACIF_CTRL_REPLICATE_SHIFT) |
> +		(conf->truncate << TEGRA_ACIF_CTRL_TRUNCATE_SHIFT) |
> +		(conf->mono_conv << TEGRA_ACIF_CTRL_MONO_CONV_SHIFT);
> +
> +	regmap_update_bits(regmap, reg, TEGRA_ACIF_UPDATE_MASK, value);
> +}
> +
> +#endif

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers!
Jon

-- 
nvpublic
