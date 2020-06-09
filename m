Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E98C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E16F207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cvo97F31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbgFIJww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 05:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgFIJwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 05:52:51 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44DFC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 02:52:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r15so2419704wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 02:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gYYo/WlElneMeWBB8UHZIKhrIY/hMj30GM+8GeLsDwY=;
        b=Cvo97F31BblpJKGnrH8wOAnOYwgXCbZcqTLbN7s+1z3ImAIxF2dcrT65rOumoqx4p+
         6KMbuQbzAHwNc4IUtCdWLGNIbOJAphFeYAm+XDoUQtK+GIA3iNYZV2cBMoRAWJXc9ZaK
         MFkBmAoPKaPShKwNzB+joHpNujEeCRh1FGJAVdpUgwlfzTrv7eoV5gVkxMbBTFv6MRcD
         1eBMAI1WEwGAfnOczR9b+rwxjLecZgroxhEd/RxKBS/yD958wJ1WZBonJ0cwNT2WQ2oH
         4t2vZMKd/60Uj2c82NyXlvZNmkbOwKbtd+Wmsk6KynZzG6ljZFWQR1eYJ1oAYZomh41I
         /rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gYYo/WlElneMeWBB8UHZIKhrIY/hMj30GM+8GeLsDwY=;
        b=GFk4L95jBe8mQYk9beQtMbhzcIXnHnarEKq5IehueenYcB+YDVnyVh4rw5SQxDOgE3
         rnfFS0+wHdEF6xY67TdHXMd1ZcLvDJJo9PImObmUuwyPM6Kid0ogylBIITRvIhzTHX96
         GnNB7eL2ghSG9v2DrN49pmESRMw1sGBU7nM4k9xXRohpSi689FxjnIMu4drerHGrcYuT
         5omDDmhtjqQ/2sp9YtHazQVb0+ZqlJQg/jHI9fdxo+5MONE+LswomkpizGbNL+HBkigD
         AqW4qD5IHagyruxqtlwJ9ka+pJI5Sh5+6+LYXbmivVJLrYYl6tXCNedVQf8ihXPCiR2O
         HY+A==
X-Gm-Message-State: AOAM533ekJNRMr8IbmAxZef61mgHjpRHmr3XkK2aQ8lIndgSRrAL9KhT
        cZcq1qhCkRyFGZSwlWV4FkCHow==
X-Google-Smtp-Source: ABdhPJyy9cb6qWZPWEOh5nUzAGMVdRs60ufD+FnSfzck2902IUU+s1FQjoSxQLRK29F2An8hWu/8qw==
X-Received: by 2002:a1c:2082:: with SMTP id g124mr3252885wmg.21.1591696369288;
        Tue, 09 Jun 2020 02:52:49 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id h27sm3206966wrb.18.2020.06.09.02.52.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 02:52:48 -0700 (PDT)
Subject: Re: [PATCH 4/5] soundwire: qcom: avoid dependency on CONFIG_SLIMBUS
To:     Jonathan Marek <jonathan@marek.ca>, alsa-devel@alsa-project.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
References: <20200608204347.19685-1-jonathan@marek.ca>
 <20200608204347.19685-5-jonathan@marek.ca>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f3eabdb9-da43-9502-352a-1696babc114d@linaro.org>
Date:   Tue, 9 Jun 2020 10:52:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200608204347.19685-5-jonathan@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/06/2020 21:43, Jonathan Marek wrote:
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

Why not move this to imply SLIMBUS this will give more flexibility!


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

May be you can do bit more cleanup here, which could endup like:


ctrl->regmap = dev_get_regmap(dev->parent, NULL);
if (!ctrl->regmap) {
	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (res) {
		ctrl->mmio = devm_ioremap_resource(dev, res);
		if (IS_ERR(ctrl->mmio)) {
			dev_err(dev, "No valid mem resource found\n");
			return PTR_ERR(ctrl->mmio);
		}

		ctrl->reg_read = qcom_swrm_cpu_reg_read;
		ctrl->reg_write = qcom_swrm_cpu_reg_write;
	} else {
		dev_err(dev, "No valid slim resource found\n");
		return -EINVAL;
	}
} else {
	ctrl->reg_read = qcom_swrm_ahb_reg_read;
	ctrl->reg_write = qcom_swrm_ahb_reg_write;
}



thanks,
srini
>   		ctrl->reg_read = qcom_swrm_ahb_reg_read;
>   		ctrl->reg_write = qcom_swrm_ahb_reg_write;
>   		ctrl->regmap = dev_get_regmap(dev->parent, NULL);
>   		if (!ctrl->regmap)
>   			return -EINVAL;
>   	} else {
> +
>   		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   
>   		ctrl->reg_read = qcom_swrm_cpu_reg_read;
> 
