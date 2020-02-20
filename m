Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1AEC34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EEB24672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lZ5xeet0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgBTGxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:53:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44406 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgBTGxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=N6Y4X8NSWL8athov5DaRus71oPlYgxNzXlT3x3CYpJw=; b=lZ5xeet0RLigxecSB9KYyHQpRQ
        5UlTfYal8IDX5QJGKxMfR+c9RZ+d0CB5vBOIzNZa5NLW5qPiV0yMpG+Egghh8dyYIWNh2OSWxMMsX
        HN91aols/73muEKc+7pnu5jiiMZK8J56eLbD/KSn9aEnffJPdYu7pwQc9SH9pWeiHHDf4En0wni0u
        37V1DqHhA/w+0hPEnm+p7/njclbSIo82PUWVuZNzTo8/4XNIzXHPNyNU8Kl9rHRC4I0vMkWx4s8Kl
        LksWxdriWllBuJxtZfNg1J4iEZjwOFLBa7CO1BYx+kiXx5jy4oMU2jmD/EHQ/OlcwXquXI8T/FKdl
        1QLtyjfw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4fic-0006wI-Nl; Thu, 20 Feb 2020 06:53:54 +0000
Subject: Re: [PATCH v3 06/10] ASoC: tegra: add Tegra186 based DSPK driver
To:     Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     broonie@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, digetx@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        sharadg@nvidia.com, mkumard@nvidia.com, viswanathl@nvidia.com,
        rlokhande@nvidia.com, dramesh@nvidia.com, atalambedu@nvidia.com
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-7-git-send-email-spujar@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6f8d0b45-025e-e03f-7478-c4c08bf61cbb@infradead.org>
Date:   Wed, 19 Feb 2020 22:53:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582180492-25297-7-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/20 10:34 PM, Sameer Pujar wrote:
> diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
> index 0c07f63..fb77df3 100644
> --- a/sound/soc/tegra/Kconfig
> +++ b/sound/soc/tegra/Kconfig
> @@ -93,6 +93,19 @@ config SND_SOC_TEGRA210_I2S
>            compatible devices.
>            Say Y or M if you want to add support for Tegra210 I2S module.
>  
> +config SND_SOC_TEGRA186_DSPK
> +        tristate "Tegra186 DSPK module"
> +        depends on SND_SOC_TEGRA
> +        help
> +          Config to enable the Digital Speaker Controller (DSPK) which
> +          converts the multi-bit Pulse Code Modulation (PCM) audio input to
> +          oversampled 1-bit Pulse Desnity Modulation (PDM) output. From the

                                     Density

> +          signal flow perspective DSPK can be viewed as a PDM transmitter
> +          that up-samples the input to the desired sampling rate by
> +          interpolation and then converts the oversampled PCM input to
> +          the desired 1-bit output via Delta Sigma Modulation (DSM).
> +          Say Y or M if you want to add support for Tegra186 DSPK module.

Please fix indentation according to coding style.
Thanks.

> +
>  config SND_SOC_TEGRA_RT5640
>  	tristate "SoC Audio support for Tegra boards using an RT5640 codec"
>  	depends on SND_SOC_TEGRA && I2C && GPIOLIB


-- 
~Randy

