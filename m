Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6902C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEB2520739
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b1kHUj6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFPIZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgFPIZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:25:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DC4C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:25:55 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r7so19807298wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=07xCk+5jY+yVjJJU7xq7mzkwYJS7vzdNmZHffvaVIG8=;
        b=b1kHUj6wycATLgHP2T0yk5ebuvDbaMh0SHv3EO3P7pDMzuuXYJW6HMZWVpdQwLm/Z8
         N0+Yhsobpl7IGNJo9+dWe4cEtOoZZCT4nYLv0qGZy0ySdTxrPx5OgavRJKJDt971Lo9q
         3s4UDyoO68dySXB/GkSTL3MHwb+qU5Lg33s/SWZJr6+oTvfYvSLL/+x1RpNttp92KZmx
         6P624mEVTjnrfy+JPMnh7G3eK7RrpJDCsati3oVWCROJZWv3LcHjB4ztn0h1+Fn5rm15
         jPgq9oBlOUjehpGuIJK49SgqFnYEMq6+OQR9MXDHtvLI4XlA1botlXrUcJFMSoPBH5Se
         PZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=07xCk+5jY+yVjJJU7xq7mzkwYJS7vzdNmZHffvaVIG8=;
        b=GgvoIdabueWUYALKtdAm8AC39mkVxkQsNvNtxhtAHu5EnCS7Suzl6Kzv1w6QzEWm3B
         fw4d4tY91yw0mdRf8wiRxideGFCyvd4ewDSLrD5JjRV9D9p2KzsVQSY3UY53bdCD5yts
         4ilYz9K6P90X4JUJ/5UxzK/7EhbLJuamQ8hGVTZUKiGl69LM+LQKhYEeu+mRp5S7Nz8M
         6ehbXlgxqcKV8HbTu3/lSqbmoDmUuhHzTUsXJ6SgcKpuB3uF19gzLmEXkRLqb7IW73fg
         ZTC4PhhskZHmmqhTU9GRjhSFLPBiCQTW+ASMSKsAFTCSxEmBzSsUPCTWOwWIXYoXnZHj
         ZEng==
X-Gm-Message-State: AOAM533SkUwFfmhjbjvh/eKBZQnnkrPkKiJDvLmBQF4GWnMNuDcYc0we
        i33aw2JbRnw5BI2VD/bDKmphuiEg6Q4=
X-Google-Smtp-Source: ABdhPJytHRSw6ChmgjBP9/wCUUzXDWwYWr9dZzrImrRXHR2ZbA+g8UxpOzP42Rf7/PPunUINB/NuTA==
X-Received: by 2002:adf:8b55:: with SMTP id v21mr1850235wra.187.1592295953987;
        Tue, 16 Jun 2020 01:25:53 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id q5sm27940039wrm.62.2020.06.16.01.25.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 01:25:53 -0700 (PDT)
Subject: Re: [RESENDx2][PATCH] sound: qcom: Kconfig: Tweak dependencies on
 SND_SOC_SDM845
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Rohit kumar <rohitkr@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
References: <20200616063417.110263-1-john.stultz@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <8f7f563b-fae7-e25e-33f2-18c608c338e6@linaro.org>
Date:   Tue, 16 Jun 2020 09:25:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200616063417.110263-1-john.stultz@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/06/2020 07:34, John Stultz wrote:
> CROS_EC isn't strictly required for audio to work
> on other SDM845 platforms (like the Dragonboard 845c).
> 
> So lets remove the dependency and select the related
> CROS_EC options if CROS_EC is already enabled.

Sorry John, totally missed this one out!

> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Rohit kumar <rohitkr@codeaurora.org>
> Cc: Patrick Lai <plai@codeaurora.org>
> Cc: Banajit Goswami <bgoswami@codeaurora.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>   sound/soc/qcom/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index f51b28d1b94d..0434f2c7d746 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -99,12 +99,12 @@ config SND_SOC_MSM8996
>   
>   config SND_SOC_SDM845
>   	tristate "SoC Machine driver for SDM845 boards"
> -	depends on QCOM_APR && CROS_EC && I2C && SOUNDWIRE
> +	depends on QCOM_APR && I2C && SOUNDWIRE
>   	select SND_SOC_QDSP6
>   	select SND_SOC_QCOM_COMMON
>   	select SND_SOC_RT5663
>   	select SND_SOC_MAX98927
> -	select SND_SOC_CROS_EC_CODEC
> +	select SND_SOC_CROS_EC_CODEC if CROS_EC

Isn't "imply SND_SOC_CROS_EC_CODEC" better option here?

--srini

>   	help
>   	  To add support for audio on Qualcomm Technologies Inc.
>   	  SDM845 SoC-based systems.
> 
