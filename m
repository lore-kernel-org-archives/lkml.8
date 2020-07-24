Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5F0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4883B20767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MFQ4I9EY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgGXLVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgGXLVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:21:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CBAC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:21:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r2so2882275wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Yxn5p63f6xRMyNZIKI09U0WQN+ewDSvHCk0EiFeJonw=;
        b=MFQ4I9EYPiUXBME2soPRf0FHybbqt0G73mLbezrYwDF9EkrdbgGj7Ql/TdkrH9A5TN
         byMUVKgWirUxLFsx1EcGnDXrkwzQNypVsr3FEzd13RDYGLi8diuVor5dgnmpyTpWGbvF
         snI1FdnNtl6hG7U1/7BVJVWMZPhEYyEgbqPF3CaKAFZOuCfvNCwcGJ7YtxZssa2rhHWP
         FnWOmXg6UN1Pv/iKqpDA//ISLi0FlQ1XlCGiTNwRP49bHMfwcGp3VmLJlThQoP3HzLai
         b9YKINrFfJgSu8X3G7H/4s1yy5zioHh1m3xO1z8lxVUHE7vwI/SXy1MJ0EdjsIWyio1n
         SPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yxn5p63f6xRMyNZIKI09U0WQN+ewDSvHCk0EiFeJonw=;
        b=nF/96HGtk3OWaet0obZvC9BxDyh3IZrdi5skaqRLsGV3yFdk6InNdH8uNrtHzmHt0n
         pVo1DbSDJ13n8WLEy6czGqX4t+2i6gvOXd0rcv1XeugsTufs9xoiMf0w09oCF46eCK9V
         M8vaOpqa68lCpDOWTwxXOTKPN74PIC7cP8dUErxR/2EvoEwottu5wXL3UfR67Oz0vSKF
         RiBkq1yFbPh2kEXArkPIJ7FluqkqWztrDhdxILh4MM4E0/iHy5f8SvXNnktpjNwoUQMd
         HURVrIKoZNP25QZTnj2JWzunr9b8bYEFRGPiS5h4m1AY96MTayADbBTAFzZl7tAL2XLc
         zJGQ==
X-Gm-Message-State: AOAM5327wENH/jiKVLyxsdLv7XFi17o6RhOrHjg86zF3iHgxCnYUlQd6
        iazoeqluXdgEvVW8QrpHSetQiGfjM3U=
X-Google-Smtp-Source: ABdhPJwk3yJH2k2se0co2uZc0PH6TC0Af1M7TgEssnr7ir+wGzTPfXA1pcbKzdW/TothLmRlWDKafA==
X-Received: by 2002:a5d:424f:: with SMTP id s15mr8736978wrr.342.1595589707519;
        Fri, 24 Jul 2020 04:21:47 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id a10sm14965705wmd.3.2020.07.24.04.21.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2020 04:21:46 -0700 (PDT)
Subject: Re: [PATCH v4 04/12] ASoC: qcom: lpass-platform: fix memory leak
To:     Rohit kumar <rohitkr@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1595413915-17867-1-git-send-email-rohitkr@codeaurora.org>
 <1595413915-17867-5-git-send-email-rohitkr@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1b8f969a-8f88-2928-0b29-9325451d9613@linaro.org>
Date:   Fri, 24 Jul 2020 12:21:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1595413915-17867-5-git-send-email-rohitkr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/07/2020 11:31, Rohit kumar wrote:
> lpass_pcm_data is never freed. Free it in close
> ops to avoid memory leak.
> 
> Fixes: 022d00ee0b55 ("ASoC: lpass-platform: Fix broken pcm data usage")
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>


Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/lpass-platform.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
> index fb9acfd..b195f3d 100644
> --- a/sound/soc/qcom/lpass-platform.c
> +++ b/sound/soc/qcom/lpass-platform.c
> @@ -61,7 +61,7 @@ static int lpass_platform_pcmops_open(struct snd_soc_component *component,
>   	int ret, dma_ch, dir = substream->stream;
>   	struct lpass_pcm_data *data;
>   
> -	data = devm_kzalloc(soc_runtime->dev, sizeof(*data), GFP_KERNEL);
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>   	if (!data)
>   		return -ENOMEM;
>   
> @@ -118,6 +118,7 @@ static int lpass_platform_pcmops_close(struct snd_soc_component *component,
>   	if (v->free_dma_channel)
>   		v->free_dma_channel(drvdata, data->dma_ch);
>   
> +	kfree(data);
>   	return 0;
>   }
>   
> 
