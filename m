Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB05FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5AA720786
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L7oT52IN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbgFSJCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgFSJCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:02:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F81C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:02:35 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h5so8927809wrc.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bHC3389Agiw1YGQvJXvHdNrdxAHDGZlLAi2j1YUz3Ag=;
        b=L7oT52INJmfuzrCEKMR1hBDeG0jedYNR2VO9PizxWA+nkG0/ydzobyDwjG3/unZRjx
         ZfiNugZi8GzJa0PQYXr3IuQipPBcQqxZxsphTT6XJ9mOA2EuMBUWpxdCfQx5GlQyIZce
         1eMuxvFrjtEysokvv14hovdv2zQSA/LfUNQkJMx9mGwk3HUW3Iscr9BEntSUMG3VtLuW
         1LrG6X7Hi9kOzQG704YUjZsSdBK6VB8x4HQBGeaWBwmgJERCvvJhnrnosBnU+VLNP1T3
         sUnKQ6iXW7k80THjcn64s9s+rHmnN2CR97Qw7PfXMlnFHQ3nfvZ1I/lRX61qA2cebtgP
         AT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bHC3389Agiw1YGQvJXvHdNrdxAHDGZlLAi2j1YUz3Ag=;
        b=EkaQ8hjRFQniOxVXBgA9svX4WDqAXrcfI1+cS1gYbnAA8jontG1tCqGKY58y5kJ1pe
         npugUHxtvHv1AfUGHKVRLw+oMQPAKzGRzH5oT/DFL79Lcwe0n5ebxhwuBED9+7Pw0b6R
         DQuNc10aGpqtiXf+Dovd56Od1Pu2h/uv1OI48o7a4gPgzPYqkSMPlHlKzSxPWWojvHmu
         /9ogKxgECO85Nm8uPgtOkACulXHy8nix6KMGLwTCB68D+8BtbyvrXqzcU1yiS66bvqw6
         pKUOpVMDxw2nNUmgP8MBkl8ZgTBQ8tgotnB33m7MQKwPMbdoOYcidy6Ia6RnW/qWFcV5
         ho9w==
X-Gm-Message-State: AOAM530R9QDVpohODg9GWBxo3tzzh6NVAyb8PXhPKEV49LKq7HFuKYIl
        mkvUwJHpgTYPvKjMEWZ//pWTOFY8T38=
X-Google-Smtp-Source: ABdhPJzvao0Uhczcik/HaAS9ovCKJDBpVDhnTG4tb5POQnrBuPZa8heBN5Bmo8ETEZIOrhFpT1Ht3w==
X-Received: by 2002:a5d:6283:: with SMTP id k3mr2855792wru.422.1592557354487;
        Fri, 19 Jun 2020 02:02:34 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id v7sm6586948wrp.45.2020.06.19.02.02.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 02:02:33 -0700 (PDT)
Subject: Re: [PATCH v3] ASoC: qcom: Kconfig: Tweak dependencies on
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
References: <20200619031407.116140-1-john.stultz@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <803a1a44-0454-8b75-bcac-f06ef5bd89ec@linaro.org>
Date:   Fri, 19 Jun 2020 10:02:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200619031407.116140-1-john.stultz@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/06/2020 04:14, John Stultz wrote:
> CROS_EC isn't strictly required for audio to work
> on other SDM845 platforms (like the Dragonboard 845c).
> 
> So lets remove the dependency and select the related
> CROS_EC options via imply.
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

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


> v2: Switch to using imply as suggested by Srinivas
> ---
>   sound/soc/qcom/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index f51b28d1b94d..0ea4cde9f4f0 100644
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
> +	imply SND_SOC_CROS_EC_CODEC
>   	help
>   	  To add support for audio on Qualcomm Technologies Inc.
>   	  SDM845 SoC-based systems.
> 
