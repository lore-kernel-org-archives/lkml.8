Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9502FC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6702620724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dmdrL9J8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgCMMP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:15:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40376 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgCMMP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:15:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id z12so851447wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 05:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Us+slyMydZd/eqziQ4Za2MmMvMvI/Alts84+tTbnLIk=;
        b=dmdrL9J8Py6pjzSo9zxb1Yfa1SYLqBuFeXStUEe356hzKeaAzHXVcOgPyuyyrEefAl
         lRQUAClgr46+cGoe9EiUoCs9iFeVJEJJMexF8D13T9wf6eAyiCk4qCsQ07DW561IuBYO
         hnPfwa5/OCPwap5maFvMYyxIkukrBuOIgBYqdi1yNzTqopWHa2q/1oQm8iZLJG0lGt+n
         6sqAlipnm0nYh/0p3RgYOw4QKViq2p6lOKel6B3y71wEAXvZ41vPjaUWivg2ZVoznsSK
         FU6fgQkETfifKTe817Ea4sPB/g74dG66ohFKeJ3bFRb2KRKwWH2opOCdQnWdzpfY79C6
         9s7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Us+slyMydZd/eqziQ4Za2MmMvMvI/Alts84+tTbnLIk=;
        b=odWxOE1X06IyDtYCxw+KhOUyy6t08erB21kBUHPBl306Lq9K37sCQXjqTqnLd2JAnF
         a57OI1mG0HcfDzmdCv8s9YudftZBQ0OjmM1RX1S6tv6uT0HewdnVyefvc++oo35NxOJF
         owd++kxSgBNt3/ZFs6sNp97PWHfcUZo0Gw3/S/7NKCPAUW+cuITVqq1nokmw7NWieWV7
         SUCU//+59A38xzzXMSaOClTnzvVVjqmf6vXXRCxQqEBvtgBF/wYLUmz8zf1+LZmFLBe6
         DT4sgK669mDvMM/q22xPZfwmi2NTBaw6kEY2pv8auUAPiExTjBuB69E36UFgTSzaUIZ4
         NUJw==
X-Gm-Message-State: ANhLgQ1vOjwYJuaQjgK9lQ1/sv8XIZ0Gz6H12QWKq6iiLj6VWTfRFSZa
        3zb9k4r9L5gH0CenUTPACIgfB/Xjvxw=
X-Google-Smtp-Source: ADFU+vveUbU45uEhQYSZ4Gbmvwbf1schWKEpmcGYLn3cvPLdTqdNnZeTOPyZ6EBJ9iwM90TrudsIvQ==
X-Received: by 2002:a1c:208a:: with SMTP id g132mr10174291wmg.44.1584101721737;
        Fri, 13 Mar 2020 05:15:21 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id a184sm17302709wmf.29.2020.03.13.05.15.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 05:15:20 -0700 (PDT)
Subject: Re: [RESEND PATCH v2 3/9] ASoC: qcom: q6asm: pass codec profile to
 q6asm_open_write
To:     Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20200313101627.1561365-1-vkoul@kernel.org>
 <20200313101627.1561365-4-vkoul@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <15823832-0639-f868-9338-091bceaba6bd@linaro.org>
Date:   Fri, 13 Mar 2020 12:15:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200313101627.1561365-4-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/03/2020 10:16, Vinod Koul wrote:
> Codec profile is required to be passed for WMA codecs so that we know
> the codec profile present and tell DSP accordingly, so update this API
> to pass the codec profile as argument
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

LGTM,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/qdsp6/q6asm-dai.c | 4 ++--
>   sound/soc/qcom/qdsp6/q6asm.c     | 2 +-
>   sound/soc/qcom/qdsp6/q6asm.h     | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
> index c0d422d0ab94..8f245d03b6f5 100644
> --- a/sound/soc/qcom/qdsp6/q6asm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
> @@ -250,7 +250,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
>   
>   	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>   		ret = q6asm_open_write(prtd->audio_client, FORMAT_LINEAR_PCM,
> -				       prtd->bits_per_sample);
> +				       0, prtd->bits_per_sample);
>   	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
>   		ret = q6asm_open_read(prtd->audio_client, FORMAT_LINEAR_PCM,
>   				       prtd->bits_per_sample);
> @@ -652,7 +652,7 @@ static int q6asm_dai_compr_set_params(struct snd_compr_stream *stream,
>   	prtd->bits_per_sample = 16;
>   	if (dir == SND_COMPRESS_PLAYBACK) {
>   		ret = q6asm_open_write(prtd->audio_client, params->codec.id,
> -					prtd->bits_per_sample);
> +				params->codec.profile, prtd->bits_per_sample);
>   
>   		if (ret < 0) {
>   			dev_err(dev, "q6asm_open_write failed\n");
> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
> index 36e0eab13a98..64eb7b6ba305 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.c
> +++ b/sound/soc/qcom/qdsp6/q6asm.c
> @@ -858,7 +858,7 @@ static int q6asm_ac_send_cmd_sync(struct audio_client *ac, struct apr_pkt *pkt)
>    * Return: Will be an negative value on error or zero on success
>    */
>   int q6asm_open_write(struct audio_client *ac, uint32_t format,
> -		     uint16_t bits_per_sample)
> +		     u32 codec_profile, uint16_t bits_per_sample)
>   {
>   	struct asm_stream_cmd_open_write_v3 *open;
>   	struct apr_pkt *pkt;
> diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
> index 6764f55f7078..1cff7f68b95d 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.h
> +++ b/sound/soc/qcom/qdsp6/q6asm.h
> @@ -55,7 +55,7 @@ void q6asm_audio_client_free(struct audio_client *ac);
>   int q6asm_write_async(struct audio_client *ac, uint32_t len, uint32_t msw_ts,
>   		       uint32_t lsw_ts, uint32_t flags);
>   int q6asm_open_write(struct audio_client *ac, uint32_t format,
> -		     uint16_t bits_per_sample);
> +		     u32 codec_profile, uint16_t bits_per_sample);
>   
>   int q6asm_open_read(struct audio_client *ac, uint32_t format,
>   		     uint16_t bits_per_sample);
> 
