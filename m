Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B096CC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A63A20715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mJ2x+0R0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgBJRNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:13:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39668 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbgBJRNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:13:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so8753759wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 09:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DSU+tE7/gI2emqC2rIzadepHX0f2kKadx71NAW+DB9c=;
        b=mJ2x+0R0KG/zW9mIk2M541OD92fCUzci3ZA329+8cFqWKkKoiYinhkyd1Jrxr6rS6o
         XzAdYkfUKOg8fLKFIuQLVAtDlVky8uxBVPPeEZVK1N4BX2ybShGvTRvZtumVm6OHfrIq
         XOyc0/kGBjxkdPEt41xI+CVY3WQM0UQtYwmrQNC4kp/zAVMslhWKnjTJJnInArcQwtls
         fY1X5FX7K14iEp44Q/RVA8efFh5NjzSaBfQwNJHRMeMzB57wlDqxplKrCv/I8BdpZTyG
         XZlOO4zgEJC4kThvpMC/eudPXsSHKe0GwibyEQECmv0IJxekTVidJ9XRo8VGQxZmcClm
         /FZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DSU+tE7/gI2emqC2rIzadepHX0f2kKadx71NAW+DB9c=;
        b=NqPDcdDyeRsYoCXb9lr389uHpsv5Y9RK+ok2g227zWI525bkn0oPqy3TTALSFxTCbR
         AiEhLt6NMBUlN+4iIt6tDqNJ+hblazJY+OXArUKvfmkzYylEGPviln7TtQqJctUcuF+k
         JQFSUgDTpta8hgiGdERThw+vYynsjmJAGaQs7pRVVu1sug0XxQBx5Tza0NdfHlU32DNP
         eYppehfkKrKDbX8v/96p8/EU1qs+f9FVXETGPFv7c1nRwZGGFMDoTzS1s5eGrIsAxBHm
         KzRQaE4JZoATC14AJL/uDUtozL4wTQtafHpdO4q0SH1EuhQmcSM0U3n2uxJ7jsyTg6Kd
         wBFw==
X-Gm-Message-State: APjAAAXcKdJ8BdE8xSbzjYKvPd5dbbJdiSF//Zff2oHFzA28QyN2EiPM
        jVC++FJ53MfYLTCN5pZHUSD5cWf7keY=
X-Google-Smtp-Source: APXvYqygfM/XPvD44FZpBV06QPyRiPM1bpOlyzUpNUVyAgaDXnrZJoL6ryy34a3DovTGrMav5A6R7w==
X-Received: by 2002:adf:dfc8:: with SMTP id q8mr3005070wrn.135.1581354814017;
        Mon, 10 Feb 2020 09:13:34 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id d22sm1344739wmd.39.2020.02.10.09.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 09:13:33 -0800 (PST)
Subject: Re: [PATCH v2 3/8] ASoC: qdsp6: q6afe-dai: add support to pcm port
 dais
To:     Adam Serbinski <adam@serbinski.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200207205013.12274-1-adam@serbinski.com>
 <20200209154748.3015-1-adam@serbinski.com>
 <20200209154748.3015-4-adam@serbinski.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d0437f6d-84c8-e1cd-b6f5-c1009e00245d@linaro.org>
Date:   Mon, 10 Feb 2020 17:13:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200209154748.3015-4-adam@serbinski.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few minor comments

On 09/02/2020 15:47, Adam Serbinski wrote:
> This patch adds support of AFE DAI for PCM port.
> 
> Signed-off-by: Adam Serbinski <adam@serbinski.com>
> CC: Andy Gross <agross@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Liam Girdwood <lgirdwood@gmail.com>
> CC: Patrick Lai <plai@codeaurora.org>
> CC: Banajit Goswami <bgoswami@codeaurora.org>
> CC: Jaroslav Kysela <perex@perex.cz>
> CC: Takashi Iwai <tiwai@suse.com>
> CC: alsa-devel@alsa-project.org
> CC: linux-arm-msm@vger.kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>   sound/soc/qcom/qdsp6/q6afe-dai.c | 198 ++++++++++++++++++++++++++++++-
>   1 file changed, 197 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
> index c1a7624eaf17..23b29591ef47 100644
> --- a/sound/soc/qcom/qdsp6/q6afe-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6afe-dai.c

...

> +static int q6afe_tdm_set_sysclk(struct snd_soc_dai *dai,
> +		int clk_id, unsigned int freq, int dir)
> +{

Why are we adding exactly duplicate function of q6afe_mi2s_set_sysclk here?

> +	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
> +	struct q6afe_port *port = dai_data->port[dai->id];
> +
> +	switch (clk_id) {
> +	case LPAIF_DIG_CLK:
> +		return q6afe_port_set_sysclk(port, clk_id, 0, 5, freq, dir);
> +	case LPAIF_BIT_CLK:
> +	case LPAIF_OSR_CLK:
> +		return q6afe_port_set_sysclk(port, clk_id,
> +					     Q6AFE_LPASS_CLK_SRC_INTERNAL,
> +					     Q6AFE_LPASS_CLK_ROOT_DEFAULT,
> +					     freq, dir);
>   	case Q6AFE_LPASS_CLK_ID_PRI_TDM_IBIT ... Q6AFE_LPASS_CLK_ID_QUIN_TDM_EBIT:
>   		return q6afe_port_set_sysclk(port, clk_id,
>   					     Q6AFE_LPASS_CLK_ATTRIBUTE_INVERT_COUPLE_NO,
> @@ -468,6 +520,11 @@ static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
>   	{"Tertiary MI2S Playback", NULL, "TERT_MI2S_RX"},
>   	{"Quaternary MI2S Playback", NULL, "QUAT_MI2S_RX"},
>   
> +	{"Primary PCM Playback", NULL, "PRI_PCM_RX"},
> +	{"Secondary PCM Playback", NULL, "SEC_PCM_RX"},
> +	{"Tertiary PCM Playback", NULL, "TERT_PCM_RX"},
> +	{"Quaternary PCM Playback", NULL, "QUAT_PCM_RX"},
> +
>   	{"Primary TDM0 Playback", NULL, "PRIMARY_TDM_RX_0"},
>   	{"Primary TDM1 Playback", NULL, "PRIMARY_TDM_RX_1"},
>   	{"Primary TDM2 Playback", NULL, "PRIMARY_TDM_RX_2"},
> @@ -562,6 +619,11 @@ static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
>   	{"PRI_MI2S_TX", NULL, "Primary MI2S Capture"},
>   	{"SEC_MI2S_TX", NULL, "Secondary MI2S Capture"},
>   	{"QUAT_MI2S_TX", NULL, "Quaternary MI2S Capture"},
> +
> +	{"PRI_PCM_TX", NULL, "Primary PCM Capture"},
> +	{"SEC_PCM_TX", NULL, "Secondary PCM Capture"},
> +	{"TERT_PCM_TX", NULL, "Tertiary PCM Capture"},
> +	{"QUAT_PCM_TX", NULL, "Quaternary PCM Capture"},
>   };
>   

...

>   
> +	SND_SOC_DAPM_AIF_IN("QUAT_PCM_RX", NULL,
> +			    0, 0, 0, 0),

This can be in single line, same for below


> +	SND_SOC_DAPM_AIF_OUT("QUAT_PCM_TX", NULL,
> +			     0, 0, 0, 0),
> +	SND_SOC_DAPM_AIF_IN("TERT_PCM_RX", NULL,
> +			    0, 0, 0, 0),
> +	SND_SOC_DAPM_AIF_OUT("TERT_PCM_TX", NULL,
> +			     0, 0, 0, 0),
> +	SND_SOC_DAPM_AIF_IN("SEC_PCM_RX", NULL,
> +			    0, 0, 0, 0),
> +	SND_SOC_DAPM_AIF_OUT("SEC_PCM_TX", NULL,
> +			     0, 0, 0, 0),
> +	SND_SOC_DAPM_AIF_IN("PRI_PCM_RX", NULL,
> +			    0, 0, 0, 0),
> +	SND_SOC_DAPM_AIF_OUT("PRI_PCM_TX", NULL,
> +			     0, 0, 0, 0),
> +
