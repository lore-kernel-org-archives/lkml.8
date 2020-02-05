Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31203C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09226217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grh0SIQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgBERCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:02:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34950 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgBERCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:02:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id w12so3665625wrt.2;
        Wed, 05 Feb 2020 09:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pQL4z7TXHWq/sFcG+ZfVL1ooPqEtHyGn+vIefYNyNNg=;
        b=grh0SIQXYGMQHg5hvBkzqFu3DuYjrp9vBhwvlMljGOgbkfCumw1DJ4TTUAW0lDoQMc
         31RrLv1Z+srJRkH1JK2xMnRPyQ/k/SsvtZcHVvfGidxPVqDK9sutFb1WD5kNE37EebMS
         nsYPQCqM80h4/pezolZowWVLRFp4ENtOGUKuPOnQY8QOavgnMuicRSRtepla4OoW1jpc
         vxfYY6DP1aTEtau0Z33Hskp7Pk8Gw4gCV7lOwvDsF4/dPkNPx5ttEEnayeFlgVs7p9Jp
         OnkPT3r3B2neLR4xU2iEDDhr0N4vUeEZFLPE21TfuaRWBSXpWelP0D3uqoo7KRq75mQJ
         5ELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pQL4z7TXHWq/sFcG+ZfVL1ooPqEtHyGn+vIefYNyNNg=;
        b=dIe74j1gu8WzTyxf1Jxbz/2kWId20oYBTSdStJ7RPWShaJDREtHiijTLpsgzilIvSN
         dlK5zb8WtYdOqQ1wPqQCthj7V4Vr2TMaD73VQvUsPYqt9SmkdlbWPNo97xPVs073VK7M
         rzYyhRs2zqdXrOuU3Ip9q8+tL3E+dIqj3/9J8oH9mwq+G2u8u+RASXJ7ZdKopmJEZJ+I
         FtyQE6Jn11XPHG3DU4zwXvBDrTkXBv82+IZBpckvpgUS/V2wR6rz2G8RIs33TKBP9ZLZ
         ohlTQEo1V3k8C1lkzt/TyavHP1mSbsfFkP5XZqnZBa80mjLbOR6oHxdLi2/ZNRHmRa4U
         1kxg==
X-Gm-Message-State: APjAAAUdGITiGOMn6g8Wah2AqT8026IOFNH4QY9fyy7DiMYMxVYJO0lK
        kLQLXO/hdutD6jzAgPvXkvc=
X-Google-Smtp-Source: APXvYqynoyH2re39DhTeCk3EnXaqiL1bV3eoElmPeYE4VGss09frGcB2BvFdA4617Bo1yQU8QnyiDQ==
X-Received: by 2002:adf:c3d0:: with SMTP id d16mr27959062wrg.376.1580922150291;
        Wed, 05 Feb 2020 09:02:30 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id 5sm531917wrc.75.2020.02.05.09.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 09:02:29 -0800 (PST)
Subject: Re: [PATCH v2 2/9] ASoC: tegra: add support for CIF programming
To:     Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     broonie@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-3-git-send-email-spujar@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7239e858-16b7-609f-c4e3-8135bee8450b@gmail.com>
Date:   Wed, 5 Feb 2020 20:02:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1580380422-3431-3-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.01.2020 13:33, Sameer Pujar пишет:
...
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include "tegra_cif.h"
> +
> +void tegra_set_cif(struct regmap *regmap, unsigned int reg,
> +		   struct tegra_cif_conf *conf)
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
> +EXPORT_SYMBOL_GPL(tegra_set_cif);

Are you going to add more stuff into this source file later on?

If not, then it's too much to have a separate driver module just for a
single tiny function, you should move it into the header file (make it
inline).
