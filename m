Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C06C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5353220784
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y7ina6p4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440586AbgDPH42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439745AbgDPH4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:56:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447D8C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:56:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h9so3647963wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w/Twrrdf4aERctgvRFlbz6BP8MBD5X/Um5Xg9eTKcW8=;
        b=Y7ina6p4jnvrCKgO7lBVPAbioKnXqyuPb3pQ10H3Ixj+9N0m4LLg+Tm/fVFS59rqw1
         54EOJp051uGi2tgLjCH63h+y789rWnGVP14odkxHivl8CwVW8vnzJDff55u0snS+rTY4
         26p4yEbDBSaXjMxKfAZ2vMRjkOxNw/JNRUUJ0zgOfHvTgrqLt+jXSIHtTOeej9Kc0fgw
         oM/xfp3zTfich3szdVe5k0+Z8fm4AuY0pQu2mskVsvq9x8AyFaFOeO66Bu6qH8zHemWO
         J6IDMhVc2rZjTCaS73ZsSeYve3O4kVqGa/4rAMXEiYCb1GnGimCL0VVWeMlsb8nc178l
         hjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w/Twrrdf4aERctgvRFlbz6BP8MBD5X/Um5Xg9eTKcW8=;
        b=EaocQsOy1u3NaHkjGe0nbr2q9pYvDphh4rFKjIiTdW0P/Q7KLJf8xlHClQIaOyP89t
         YDvA9ENTS9dVeJbU31GuU44GJLgTqpvBosfeXubikfNAJ8nUWoxPQ+M+dEpf7agDzkYt
         DczjsozhmlFMklI8HDBW1INjzOPKUBc8ogbwnCuITwsDXzfrfbTMC2pOb1gdnLQnZTnx
         XmlEcfbcm+yuEqRLqOw7vScWyrvEruDws6fX4KAXB4oFnF+ziZbMjfPi3tapceOcieiJ
         yJ8myFORjgvZwkx80mHvF74OAKNJBsWa1qKclewGmPj5syoDH8P8XRm18SUeObSxOjlL
         0BJA==
X-Gm-Message-State: AGi0PuYcXWngtu3igweGATtnELpp4FSf4BHRcVp5LBAb3N8k2yKdMzrA
        i73TKp1GVZEGqQO6+wllpfAr9w==
X-Google-Smtp-Source: APiQypIndcDNGYipdeHfDJwCf7g8gYyRPAsL3CbpsAhYIuPXR/ssSsok1DLHdVgKoNzj+vRBsfocKQ==
X-Received: by 2002:a5d:44c6:: with SMTP id z6mr26438709wrr.192.1587023776920;
        Thu, 16 Apr 2020 00:56:16 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id s6sm2598117wmh.17.2020.04.16.00.56.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 00:56:16 -0700 (PDT)
Subject: Re: [PATCH 11/11] ASoC: qcom: lpass-platform: Replace card->dev with
 component->dev
To:     Ajit Pandey <ajitp@codeaurora.org>, alsa-devel@alsa-project.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        plai@codeaurora.org, bgoswami@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.com
References: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
 <1586592171-31644-12-git-send-email-ajitp@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <08277130-ed31-837e-a8b1-9e71fb1b6989@linaro.org>
Date:   Thu, 16 Apr 2020 08:56:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1586592171-31644-12-git-send-email-ajitp@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/04/2020 09:02, Ajit Pandey wrote:
> We are allocating dma memory for component->dev but trying to mmap
> such memory for substream->pcm->card->dev. Replace device argument
> in mmap with component->dev to fix this.
> 
> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>

Probably a fixes tag here,

Fixes: c5c8635a0471("ASoC: qcom: Add LPASS platform driver")

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/lpass-platform.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
> index 821599e..9ab2dd5 100644
> --- a/sound/soc/qcom/lpass-platform.c
> +++ b/sound/soc/qcom/lpass-platform.c
> @@ -401,9 +401,8 @@ static int lpass_platform_pcmops_mmap(struct snd_soc_component *component,
>   {
>   	struct snd_pcm_runtime *runtime = substream->runtime;
>   
> -	return dma_mmap_coherent(substream->pcm->card->dev, vma,
> -			runtime->dma_area, runtime->dma_addr,
> -			runtime->dma_bytes);
> +	return dma_mmap_coherent(component->dev, vma, runtime->dma_area,
> +				 runtime->dma_addr, runtime->dma_bytes);
>   }
>   
>   static irqreturn_t lpass_dma_interrupt_handler(
> 
