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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03732C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D65A620767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p6tgPHcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgGXLV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgGXLV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:21:59 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B7BC0619E5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:21:58 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 184so7943160wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QBcl5FK4EZqrtCnW5IQ5WndIaO7X61MMG438KlSxZ48=;
        b=p6tgPHcxw7s+eIybTuztyk5Zh+ndlxFsb6LnTlTsA4B+g8xpvXitbOzuaGmCgfqRZb
         giCezrtJy0QaopoXfIqaUbZHRnE5iVWB1cbawyhaA1ftF7mxE0rwYy54CkTF6S+TAbj9
         wsgoL474l8C+LiDYwSs3Xgm/H+Rcn5CwIrD4E/2UOexcF95TC2wuxTFtgOPRIhrHiZaB
         r2XvYlXNVFEuBXRInp4w/L4ZqgdCGK/k9GeraiDofbJx0KiZJOiz8wE1mUyIPccyoTEI
         eQxP/4c8TCL7l6vYkJkPI5RlS/Lkz/dSezmCs60Qr+Fg8exa7O1URKW7Gh89H61GSWkm
         ExhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QBcl5FK4EZqrtCnW5IQ5WndIaO7X61MMG438KlSxZ48=;
        b=PvgWKElp1o3W6UnQNcZ9rnuZWN3l8Wj1o6Qr54vCwvie0L4k8CkbelW60b+XoRrGOZ
         T7iWwZaYTsQG49HW+JOukpzysVGWVV5LmshhN34Gz5ZEAxuO1+ejGjq2ebtiuYRqBh/h
         DLq26YTKY67pc+BccOpnNyk/iulIw2MiZBof4ULSdEBUhCxyrj8N9PWd95+PN2OrNEgJ
         NQIH+BtpoD0CsC3guN+m7/0w5hCfENQYp7b/yXJQDqWGu2ic8X2VC6GwpbPrdXr5k6mP
         3ckLEG4Lx0/bvYt7xMGHjGrA0cNkq3otUSYd+2AXbP8lrpVwCNp0+djV62oaH3ijExC7
         V4kA==
X-Gm-Message-State: AOAM532NXg3KXTnYBi2AC3T3sLy+x1fLlrS476ZnU9OYjj3igNDA5lEW
        st6crv7fQpuy5W0buWEgOokTpZVyNZ8=
X-Google-Smtp-Source: ABdhPJyIZOVHqR8IywjbnF4AfvsOTpXs4INYnuhL6MUOJ25g639wiz/73ibH9ilrBLAIG2rjP2oPBA==
X-Received: by 2002:a1c:4406:: with SMTP id r6mr8235833wma.161.1595589716944;
        Fri, 24 Jul 2020 04:21:56 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id p14sm1020718wrx.90.2020.07.24.04.21.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2020 04:21:56 -0700 (PDT)
Subject: Re: [PATCH v4 06/12] ASoC: qcom: lpass-cpu: fix concurrency issue
To:     Rohit kumar <rohitkr@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1595413915-17867-1-git-send-email-rohitkr@codeaurora.org>
 <1595413915-17867-7-git-send-email-rohitkr@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <eb3854ac-6480-f6ce-4325-bd00dd18be40@linaro.org>
Date:   Fri, 24 Jul 2020 12:21:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1595413915-17867-7-git-send-email-rohitkr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/07/2020 11:31, Rohit kumar wrote:
> i2sctl register value is set to 0 during hw_free(). This
> impacts any ongoing concurrent session on the same i2s
> port. As trigger() stop already resets enable bit to 0,
> there is no need of explicit hw_free. Removing it to
> fix the issue.
> 
> Fixes: 80beab8e1d86 ("ASoC: qcom: Add LPASS CPU DAI driver")
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/lpass-cpu.c | 16 ----------------
>   1 file changed, 16 deletions(-)
> 
> diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
> index 6b86f16..5d84f63 100644
> --- a/sound/soc/qcom/lpass-cpu.c
> +++ b/sound/soc/qcom/lpass-cpu.c
> @@ -266,21 +266,6 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
>   	return 0;
>   }
>   
> -static int lpass_cpu_daiops_hw_free(struct snd_pcm_substream *substream,
> -		struct snd_soc_dai *dai)
> -{
> -	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
> -	int ret;
> -
> -	ret = regmap_write(drvdata->lpaif_map,
> -			   LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
> -			   0);
> -	if (ret)
> -		dev_err(dai->dev, "error writing to i2sctl reg: %d\n", ret);
> -
> -	return ret;
> -}
> -
>   static int lpass_cpu_daiops_prepare(struct snd_pcm_substream *substream,
>   		struct snd_soc_dai *dai)
>   {
> @@ -350,7 +335,6 @@ const struct snd_soc_dai_ops asoc_qcom_lpass_cpu_dai_ops = {
>   	.startup	= lpass_cpu_daiops_startup,
>   	.shutdown	= lpass_cpu_daiops_shutdown,
>   	.hw_params	= lpass_cpu_daiops_hw_params,
> -	.hw_free	= lpass_cpu_daiops_hw_free,
>   	.prepare	= lpass_cpu_daiops_prepare,
>   	.trigger	= lpass_cpu_daiops_trigger,
>   };
> 
