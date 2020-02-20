Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED84C34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FE324654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F+HrHOjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgBTGvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:51:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44312 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgBTGvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=jelPZvcI0SMKCQvboR9PRb2B3llQjVk2Qq23LoJ8biY=; b=F+HrHOjUCIxHpOXQo/A4PnzUNO
        ck95dBhA9n6qID7EQYBVJReKljWkMg+TsLGoM6xFCRPFNmAOwyel7zCcHuZx739mXMTmDRtNJPBgk
        vJ8OObp516GIva4SkX1KV5lVIEYS2hlxgr+INQ+lSPdMD9441IRf5mdONNXoH7uIiqtwzlPu4QBwJ
        aE7Ftz8pTG8uYXB3cPFgh5k3oliRzbsNaMV7YlaeYY9F53nqhhLmNSpYKs8+xr2o1tFtQCVmXOK17
        nEIqFyr0esho84GI3lPb9QrCB50x835DJLpGwsaUDPm/GKcicSWTwyiXY3idRAa5ud6Gpmgn6yNRh
        k58dl0RA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4ffz-0006pl-Ul; Thu, 20 Feb 2020 06:51:11 +0000
Subject: Re: [PATCH v3 05/10] ASoC: tegra: add Tegra210 based AHUB driver
To:     Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     broonie@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, digetx@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        sharadg@nvidia.com, mkumard@nvidia.com, viswanathl@nvidia.com,
        rlokhande@nvidia.com, dramesh@nvidia.com, atalambedu@nvidia.com
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-6-git-send-email-spujar@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2d655f98-33ed-1dcf-f346-e1f1b267f0cd@infradead.org>
Date:   Wed, 19 Feb 2020 22:51:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582180492-25297-6-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/20 10:34 PM, Sameer Pujar wrote:
> diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
> index 157fa7a..0c07f63 100644
> --- a/sound/soc/tegra/Kconfig
> +++ b/sound/soc/tegra/Kconfig
> @@ -62,6 +62,16 @@ config SND_SOC_TEGRA30_I2S
>  	  Tegra30 I2S interface. You will also need to select the individual
>  	  machine drivers to support below.
>  
> +config SND_SOC_TEGRA210_AHUB
> +        tristate "Tegra210 AHUB module"
> +        depends on SND_SOC_TEGRA
> +        help
> +	  Config to enable Audio Hub (AHUB) module, which comprises of a
> +	  switch called Audio Crossbar (AXBAR) used to configure or modify
> +	  the audio routing path between various HW accelerators present in
> +	  AHUB.
> +          Say Y or M if you want to add support for Tegra210 AHUB module.
> +
>  config SND_SOC_TEGRA210_DMIC
>          tristate "Tegra210 DMIC module"
>          depends on SND_SOC_TEGRA

Please fix above according to Documentation/process/coding-style.rst:

10) Kconfig configuration files
-------------------------------

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.


-- 
~Randy

