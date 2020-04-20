Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C236CC54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D099206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xtWDgbT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgDTHmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbgDTHmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 03:42:31 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F7EC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 00:42:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g13so8798287wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 00:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ewZfJT+hF2YM+qJSsl0O1dzlck6lSvjtReN5vcsfFY0=;
        b=xtWDgbT5GWxuvhGTx8BXdhFEVtB6kLkQbuxwBIgpsVTZNJVTiItdv2FJ9BRiNFrSKe
         UPFy6IMwoD4koU4RHkaD8BZ72RBFBxB5c73ulmRDWdgUL13lep2Lv0CS7TqRDuwFdiGj
         Qo5GkMSwdAuvF39w3yBjlIMJQaDLUyDjpGHkliiaF0Pho+PHkjV5I2YOZ4CEVYvGBSRh
         J/XaAB92ylbxoxj3xY3K3DSqtzv503w9HdbxThphdUa5NOikiLXCCInuLRb3lk4Li4Th
         6SbKKg9VHOTkLoerNXOz9WpFkvXeJeSCfP3vQjENWjMppiZzI1xx2FuJ0RCNlPwQ6qPU
         KNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ewZfJT+hF2YM+qJSsl0O1dzlck6lSvjtReN5vcsfFY0=;
        b=YH+yt4C5ibIjpem6nBD24rz2jzGWDqnYpizLK51WRKLjaAaFrh1tTaMi+EloB0uGnk
         3jt/KqFn40uilEQospRBqh/OqAqNjqs/38uQGkBsUO4G4HWBuo3UuxSBw+av5QmAh/+a
         t+1w2vChlRTBPbEqh34devsSVGfiECWsXlJ02FoC1w5n4gwRmOTVg3Pn+cLo6NfGA2F4
         WJ3Vz7xpqYgA0DPDpwumIP3+ZpNlLD0zmgqG9K35UWjrLFefBj49ruR9JSY/ImXynNyy
         TB0Q3N3ru4Czh+OOTtZO+YefbpzxLRRJH4EG82S/h2Jb1aB7yMTF4C5hvLX3ztPPhqUG
         44Hg==
X-Gm-Message-State: AGi0PuaKMl0daCV9r85QjE/+OLfLHoI/ksNwChqUiwm84y17B0FHBiLJ
        fD4Ke6qL5pAoipOSiqDBZKJ/0A==
X-Google-Smtp-Source: APiQypLK9dr1rlKUtLsy8YI0+R+kaRLY7vo8ZLe3s7d0bIGnDCUnRm13tWGx8hctWsBYmLqlydc0KQ==
X-Received: by 2002:a5d:634d:: with SMTP id b13mr16923695wrw.353.1587368549727;
        Mon, 20 Apr 2020 00:42:29 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id f63sm205720wma.47.2020.04.20.00.42.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 00:42:29 -0700 (PDT)
Subject: Re: [RFC 3/5] soundwire: qcom: fix error handling in probe
To:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, slawomir.blauciak@intel.com,
        mengdong.lin@intel.com
References: <20200416205524.2043-1-yung-chuan.liao@linux.intel.com>
 <20200416205524.2043-4-yung-chuan.liao@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6be6b739-2f5e-e2ba-2ca0-56108f667ffe@linaro.org>
Date:   Mon, 20 Apr 2020 08:42:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200416205524.2043-4-yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/04/2020 21:55, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Make sure all error cases are properly handled and all resources freed.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
Thanks for the patch,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

>   drivers/soundwire/qcom.c | 26 +++++++++++++++++---------
>   1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index d6c9ad231873..e08a17c13f92 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -765,12 +765,16 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>   	}
>   
>   	ctrl->irq = of_irq_get(dev->of_node, 0);
> -	if (ctrl->irq < 0)
> -		return ctrl->irq;
> +	if (ctrl->irq < 0) {
> +		ret = ctrl->irq;
> +		goto err_init;
> +	}
>   
>   	ctrl->hclk = devm_clk_get(dev, "iface");
> -	if (IS_ERR(ctrl->hclk))
> -		return PTR_ERR(ctrl->hclk);
> +	if (IS_ERR(ctrl->hclk)) {
> +		ret = PTR_ERR(ctrl->hclk);
> +		goto err_init;
> +	}
>   
>   	clk_prepare_enable(ctrl->hclk);
>   
> @@ -787,7 +791,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>   
>   	ret = qcom_swrm_get_port_config(ctrl);
>   	if (ret)
> -		return ret;
> +		goto err_clk;
>   
>   	params = &ctrl->bus.params;
>   	params->max_dr_freq = DEFAULT_CLK_FREQ;
> @@ -814,28 +818,32 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>   					"soundwire", ctrl);
>   	if (ret) {
>   		dev_err(dev, "Failed to request soundwire irq\n");
> -		goto err;
> +		goto err_clk;
>   	}
>   
>   	ret = sdw_add_bus_master(&ctrl->bus);
>   	if (ret) {
>   		dev_err(dev, "Failed to register Soundwire controller (%d)\n",
>   			ret);
> -		goto err;
> +		goto err_clk;
>   	}
>   
>   	qcom_swrm_init(ctrl);
>   	ret = qcom_swrm_register_dais(ctrl);
>   	if (ret)
> -		goto err;
> +		goto err_master_add;
>   
>   	dev_info(dev, "Qualcomm Soundwire controller v%x.%x.%x Registered\n",
>   		 (ctrl->version >> 24) & 0xff, (ctrl->version >> 16) & 0xff,
>   		 ctrl->version & 0xffff);
>   
>   	return 0;
> -err:
> +
> +err_master_add:
> +	sdw_delete_bus_master(&ctrl->bus);
> +err_clk:
>   	clk_disable_unprepare(ctrl->hclk);
> +err_init:
>   	return ret;
>   }
>   
> 
