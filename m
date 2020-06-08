Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD88C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEBE72076C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="16CZH6v6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgFHU6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgFHU6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:58:04 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946FFC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 13:58:04 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q8so18744875qkm.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 13:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gAhxsPhFzj8ko5Ff5RM8OuwLL2KNe1g6ry7IsPK4YPM=;
        b=16CZH6v6kmNHVqda0GleO/jK9emlQUk0HrH+pniwLB19gv2DmUZedX1TBvRssaAQi6
         FGLFcjSQVlbS8QQ2KtMP2HBxTZ7HnxctjxHPpdhwsW40BsmSTmMCHVfVeXtdWN4Bi6Ju
         s+mVt/z45r8Mr7kJ6O0XzcviuZmsZireLMRgl7efhjzxbZmm+hf8KRPbS+jgUqo9MVjn
         3Rg3QTG2S6ZhEVm+RMyhY+gsy5ErZOIcQxerJHb/KfJJtY+0M3R//ych0Dy5ctAu0GIc
         87PQeTQSEoRWGK8v6p/MG7KKuVW+ITxTJv7h828VKy28xF/sgTJebb9iesq6h7mzki59
         WG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gAhxsPhFzj8ko5Ff5RM8OuwLL2KNe1g6ry7IsPK4YPM=;
        b=V2tx0gLc+cZyhaLZzqe10QhGNs7BlwyKO6AtS+77PkEJfHi/aeZDjkLpqHRauMmkwu
         /UYB7njUJU57wki1BcmDvtUbr1iJ7pVohiFm+4GAP+74V/DUdnNYQRn0RMw/0sLWeXPr
         oRBuQYcW3JFUEPVft9qNHeriUoLMbOl5iI9WOONA8QFrAKHb2AyDspMYIuyvlBFlNqSj
         DloG8JV9cL+DrtvO9CM0JwzKxZuah7L/uoY5Ph/s3a+XPa6m6/tfokx7QEt0fbM2YpJ4
         VtEpw2Ae9wwVyz+9U4ZGzRJ/7aNqukBMZTukbV1oxkQLELIYgoh7JfkSsF/WAzkIc1zO
         MBpQ==
X-Gm-Message-State: AOAM5307TgcI5qFz2WM041BJ1vmJK0DXbZFH5V4Lt/h8TxNXEUf8btIr
        /dludQOoMGwxaye8aZluB2e+CgGRBEQ=
X-Google-Smtp-Source: ABdhPJxI8g/kaTI+YUdB4Xk1DMGdnAx4W0tVDym/m03YVgr8CP0pb9duFQuz7lWNGN7rE3IPJPeIXw==
X-Received: by 2002:a37:ac03:: with SMTP id e3mr24122797qkm.350.1591649883869;
        Mon, 08 Jun 2020 13:58:03 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id d193sm7950035qke.124.2020.06.08.13.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 13:58:03 -0700 (PDT)
Subject: Re: [PATCH 4/5] soundwire: qcom: avoid dependency on CONFIG_SLIMBUS
From:   Jonathan Marek <jonathan@marek.ca>
To:     alsa-devel@alsa-project.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
References: <20200608204347.19685-1-jonathan@marek.ca>
 <20200608204347.19685-5-jonathan@marek.ca>
Message-ID: <931e8e36-63b5-2a29-1b0c-ee7f8ffbea64@marek.ca>
Date:   Mon, 8 Jun 2020 16:58:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200608204347.19685-5-jonathan@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/20 4:43 PM, Jonathan Marek wrote:
> The driver may be used without slimbus, so don't depend on slimbus.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>   drivers/soundwire/Kconfig | 1 -
>   drivers/soundwire/qcom.c  | 5 +++++
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> index fa2b4ab92ed9..d121cf739090 100644
> --- a/drivers/soundwire/Kconfig
> +++ b/drivers/soundwire/Kconfig
> @@ -33,7 +33,6 @@ config SOUNDWIRE_INTEL
>   
>   config SOUNDWIRE_QCOM
>   	tristate "Qualcomm SoundWire Master driver"
> -	depends on SLIMBUS
>   	depends on SND_SOC
>   	help
>   	  SoundWire Qualcomm Master driver.
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 14334442615f..ac81c64768ea 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -769,13 +769,18 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>   	if (!ctrl)
>   		return -ENOMEM;
>   
> +#ifdef CONFIG_SLIMBUS
>   	if (dev->parent->bus == &slimbus_bus) {
> +#else
> +	if (false) {
> +#endif
>   		ctrl->reg_read = qcom_swrm_ahb_reg_read;
>   		ctrl->reg_write = qcom_swrm_ahb_reg_write;
>   		ctrl->regmap = dev_get_regmap(dev->parent, NULL);
>   		if (!ctrl->regmap)
>   			return -EINVAL;
>   	} else {
> +

Oops, ended up with a stray whitespace here, will fix for v2.

>   		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   
>   		ctrl->reg_read = qcom_swrm_cpu_reg_read;
> 
