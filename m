Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96492C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D19E24650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMNaCUJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgBUFoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 00:44:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36810 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgBUFoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 00:44:14 -0500
Received: by mail-lf1-f65.google.com with SMTP id f24so588263lfh.3;
        Thu, 20 Feb 2020 21:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2UgAnj6jZp1qG1YLmVU+s8neLldQ2RYmNJhZiIaSc/0=;
        b=eMNaCUJEGRDUtZkbDe8gOuqJY4E/7nOx7YQNd/AXSD9oN1/VBQk4tkoCZl+ogomTUr
         7wAsVSWMAtiUG+nYc0I49wT/MdT77hECH6riPK5hWQ/oVhMIdUUyZXfdZqhz1Kbf/mMA
         V07lLX5i4aHYK32v9caq6E/oILqdGvuIvzDtJP0T1LPMGn1rtkiubshymLKZAlmDwBWd
         oXffxa8Q17ZlYFjBUT7WnEuZQtWKATSeMWN+XjUQcAv/6vg2ToWCA5DDJtEp26cjRNtn
         uhtZi5EcBOwkMWHChUJPAQUbad/7znFyx2tum31Y9tEVmYRT4oSn4Tp2Mr4yTOvQ7ww7
         tbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2UgAnj6jZp1qG1YLmVU+s8neLldQ2RYmNJhZiIaSc/0=;
        b=gbBg7jt6YX1vZr5qqcuAK2fQcy8/APgP9cIriDET6Z7sSINxxZKwrHTb2WEGtg1/lb
         fWhaUU05+aP8Tk4BkPGMg6oMY2szN+tWqFAWmhTJNgbmdBBAOAT/derIioJoKofuIYYr
         HfQPXek/YNdqF3dubiSW3YDNbsPgsG71vcMmPpTo1Djt2QR05m3jyS79ja+EUZXwD5e9
         FeygUE/RHXh78yF0xlCQyn0wDxjZ8io5svqU+DT1KfeVZIocSzlBfxhPjAG1zPKI4dOF
         3fOUX+kOxQnbZrhw2QvVRUkg9yaldWnYIlVyIoggNmQf9y09CCQ79Guvxt5Gx2wlnQsP
         q65g==
X-Gm-Message-State: APjAAAXJvvxpCejmdf0rtv8heC6Fecio62ROIADZXP4SXEjFhnYu0SqH
        swy9+SiozaWtX209x92qhkI=
X-Google-Smtp-Source: APXvYqzgn8/o821KnPadYfAQcIxUDrXlnyZSa/bLptkr5D3/jPIQ303Yf3UYNNBuGJs94SgI0ruKEw==
X-Received: by 2002:ac2:54b5:: with SMTP id w21mr18980569lfk.175.1582263852420;
        Thu, 20 Feb 2020 21:44:12 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id d20sm878742ljg.95.2020.02.20.21.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 21:44:11 -0800 (PST)
Subject: Re: [PATCH v3 10/10] arm64: defconfig: enable AHUB components for
 Tegra210 and later
To:     Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     broonie@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-11-git-send-email-spujar@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2276bbe3-b01f-33b3-b28a-2b579678a745@gmail.com>
Date:   Fri, 21 Feb 2020 08:44:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1582180492-25297-11-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.02.2020 09:34, Sameer Pujar пишет:
> This patch enables following configs:
>  +CONFIG_TEGRA_ACONNECT=m
>  +CONFIG_SND_SOC_TEGRA=m
>  +CONFIG_SND_SOC_TEGRA210_AHUB=m
>  +CONFIG_SND_SOC_TEGRA210_DMIC=m
>  +CONFIG_SND_SOC_TEGRA210_I2S=m
>  +CONFIG_SND_SOC_TEGRA186_DSPK=m
>  +CONFIG_SND_SOC_TEGRA210_ADMAIF=m

There is no needed to duplicate contents of the patch in the commit's
description, otherwise:

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

> This patch helps to register AHUB and its clients (I2S, DMIC, DSPK, ADMAIF)
> with ASoC core. Since AHUB is child of ACONNECT, config TEGRA_ACONNECT is
> enabled as well.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  arch/arm64/configs/defconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index c8801be..784ca4f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -207,6 +207,7 @@ CONFIG_FW_LOADER_USER_HELPER=y
>  CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
>  CONFIG_HISILICON_LPC=y
>  CONFIG_SIMPLE_PM_BUS=y
> +CONFIG_TEGRA_ACONNECT=m
>  CONFIG_MTD=y
>  CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_RAW_NAND=y
> @@ -590,6 +591,12 @@ CONFIG_SND_SOC_RK3399_GRU_SOUND=m
>  CONFIG_SND_SOC_SAMSUNG=y
>  CONFIG_SND_SOC_RCAR=m
>  CONFIG_SND_SUN4I_SPDIF=m
> +CONFIG_SND_SOC_TEGRA=m
> +CONFIG_SND_SOC_TEGRA210_AHUB=m
> +CONFIG_SND_SOC_TEGRA210_DMIC=m
> +CONFIG_SND_SOC_TEGRA210_I2S=m
> +CONFIG_SND_SOC_TEGRA186_DSPK=m
> +CONFIG_SND_SOC_TEGRA210_ADMAIF=m
>  CONFIG_SND_SOC_AK4613=m
>  CONFIG_SND_SOC_ES7134=m
>  CONFIG_SND_SOC_ES7241=m
> 

