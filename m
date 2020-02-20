Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B54C761A1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81842465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NWIQAfgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgBTGzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:55:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgBTGzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=w/FCWhEq53cMrrGLxY1ndQsJq77PgtJX7MNJzE4p3/w=; b=NWIQAfgMR9X8cjViPjDr/dAhSz
        qhxOc6hiDBERt8z4uhbFOfPxvP7mZqG713mrnh6fFIaIyd35vSiQtY1xi7EifWh82xVHguLosKrg5
        ASiiwK9b6jDqD/BIBuGWORQyM+n4qQQU8PeE/oFfWApw3c253cSG6QrFhOLsdc85Rak+1LR0ejxH2
        rcTbfrbngCKsII4eB4nE9q213VNx6CoyxRmU950fkvNDFcsZpLIp4bkOjKj5fKBmvWhEfkJnF4wyb
        rCDrt4/AcQzM+8K3vdDIly8az9ofADZ9oXp4qq65NHZs3hGhH+DOBjTUo53sZ3+qzBaKHkDNL9xX6
        blId2gsA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4fk3-0008Dc-5F; Thu, 20 Feb 2020 06:55:23 +0000
Subject: Re: [PATCH v3 07/10] ASoC: tegra: add Tegra210 based ADMAIF driver
To:     Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     broonie@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, digetx@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        sharadg@nvidia.com, mkumard@nvidia.com, viswanathl@nvidia.com,
        rlokhande@nvidia.com, dramesh@nvidia.com, atalambedu@nvidia.com
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-8-git-send-email-spujar@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c1871939-ebf9-150e-1786-96a7f6bd6522@infradead.org>
Date:   Wed, 19 Feb 2020 22:55:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582180492-25297-8-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/20 10:34 PM, Sameer Pujar wrote:
> diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
> index fb77df3..c0a5f0b 100644
> --- a/sound/soc/tegra/Kconfig
> +++ b/sound/soc/tegra/Kconfig
> @@ -106,6 +106,18 @@ config SND_SOC_TEGRA186_DSPK
>            the desired 1-bit output via Delta Sigma Modulation (DSM).
>            Say Y or M if you want to add support for Tegra186 DSPK module.
>  
> +config SND_SOC_TEGRA210_ADMAIF
> +        tristate "Tegra210 ADMAIF module"
> +        depends on SND_SOC_TEGRA
> +        help
> +          Config to enable ADMAIF which is the interface between ADMA and
> +          Audio Hub (AHUB). Each ADMA channel that sends/receives data to/
> +          from AHUB must interface through an ADMAIF channel. ADMA channel
> +          sending data to AHUB pairs with an ADMAIF Tx channel, where as
> +          ADMA channel receiving data from AHUB pairs with an ADMAIF Rx
> +          channel. Buffer size is confiigurable for each ADMAIIF channel.

                                     configurable

> +          Say Y or M if you want to add support for Tegra210 ADMAIF module.

Please fix indentation according to coding style.

> +
>  config SND_SOC_TEGRA_RT5640
>  	tristate "SoC Audio support for Tegra boards using an RT5640 codec"
>  	depends on SND_SOC_TEGRA && I2C && GPIOLIB


-- 
~Randy

