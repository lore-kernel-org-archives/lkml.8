Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA110C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9282D20781
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wy3cweAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbgGAQ13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732166AbgGAQ12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:27:28 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0C2C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 09:27:28 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j19so5099379pgm.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 09:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wQaCz8+UfsafcwRt4VL8N/qWARYzLvQoOyGJgNCrxQI=;
        b=Wy3cweAjK4tvj6mIeOVbVrJjUOaGgRxJ6UPiv9+Se3RA7mLci7cvfmTFwRjxuu983H
         0KvWKlCLHrBYHAzUPOL184XNbTz+I3z1Md/IlwUIZ3UeXct7U0VRXXyeHyBsIKgMzXtd
         sRfojAeQpY0uadNtq/c9rWNJZbooeqNEAcvr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wQaCz8+UfsafcwRt4VL8N/qWARYzLvQoOyGJgNCrxQI=;
        b=YCRTELMMCfXck/H7Bk9OK1bCadg0uKrGN+z7AoDjYCoi1kzmwBWmiwoL8Xj1mCdyny
         o30xKAtYZwQFKv9BNFwJB8gdCzbOhz+qOZn5riuNMq9GYChxSuxbJkKB5EZiKlahNXma
         kxRpogSBy+esmcUWx4L2aW2HvOMdTwnKgs2yoANPr9d2VyowTE8rZuCZoEDwV7thO5O6
         i5Q88jDxk6no5RD94Ci+Jm87kAD58wzwWXPkQMn3iMDz6TsO5D5VIcpi+h59FmBmqpZk
         Pkg5BHj+T2Jt0kS7MrN09p4hrUMcAqF72GOUU7mxTuZ/gxzBaPUFf0AVU0tvjjv8803J
         4vkg==
X-Gm-Message-State: AOAM533KYJBV409l9/5FOY9W9REFPvpkPAq3EVifOxlxKwRCtWA2XOGs
        s1f3DP/Lzv675tUGEiRTzFjsGA==
X-Google-Smtp-Source: ABdhPJy0vP6rFgxJXypkuu0P2L9thUTIA4J7HCFrWcLpeIClul/fDj97U02GLCWP4TkVeCw22Q499g==
X-Received: by 2002:a05:6a00:1511:: with SMTP id q17mr25176779pfu.16.1593620848077;
        Wed, 01 Jul 2020 09:27:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id z1sm6186018pgk.89.2020.07.01.09.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 09:27:27 -0700 (PDT)
Date:   Wed, 1 Jul 2020 09:27:26 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     robdclark@gmail.com, sean@poorly.run, agross@kernel.org,
        bjorn.andersson@linaro.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] drm/msm: dsi: Use OPP API to set clk/perf state
Message-ID: <20200701162726.GO39073@google.com>
References: <1593518176-24450-1-git-send-email-rnayak@codeaurora.org>
 <1593518176-24450-3-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1593518176-24450-3-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 05:26:14PM +0530, Rajendra Nayak wrote:
> On SDM845 DSI needs to express a perforamnce state

nit: performance

> requirement on a power domain depending on the clock rates.
> Use OPP table from DT to register with OPP framework and use
> dev_pm_opp_set_rate() to set the clk/perf state.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi.h      |  2 ++
>  drivers/gpu/drm/msm/dsi/dsi_cfg.c  |  4 +--
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 58 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
> index 4de771d..ba7583c 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi.h
> @@ -180,10 +180,12 @@ int msm_dsi_runtime_suspend(struct device *dev);
>  int msm_dsi_runtime_resume(struct device *dev);
>  int dsi_link_clk_set_rate_6g(struct msm_dsi_host *msm_host);
>  int dsi_link_clk_set_rate_v2(struct msm_dsi_host *msm_host);
> +int dsi_link_clk_set_rate_6g_v2(struct msm_dsi_host *msm_host);
>  int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host);
>  int dsi_link_clk_enable_v2(struct msm_dsi_host *msm_host);
>  void dsi_link_clk_disable_6g(struct msm_dsi_host *msm_host);
>  void dsi_link_clk_disable_v2(struct msm_dsi_host *msm_host);
> +void dsi_link_clk_disable_6g_v2(struct msm_dsi_host *msm_host);
>  int dsi_tx_buf_alloc_6g(struct msm_dsi_host *msm_host, int size);
>  int dsi_tx_buf_alloc_v2(struct msm_dsi_host *msm_host, int size);
>  void *dsi_tx_buf_get_6g(struct msm_dsi_host *msm_host);
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> index 813d69d..773c4fe 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> @@ -210,9 +210,9 @@ static const struct msm_dsi_host_cfg_ops msm_dsi_6g_host_ops = {
>  };
>  
>  static const struct msm_dsi_host_cfg_ops msm_dsi_6g_v2_host_ops = {
> -	.link_clk_set_rate = dsi_link_clk_set_rate_6g,
> +	.link_clk_set_rate = dsi_link_clk_set_rate_6g_v2,
>  	.link_clk_enable = dsi_link_clk_enable_6g,
> -	.link_clk_disable = dsi_link_clk_disable_6g,
> +	.link_clk_disable = dsi_link_clk_disable_6g_v2,
>  	.clk_init_ver = dsi_clk_init_6g_v2,
>  	.tx_buf_alloc = dsi_tx_buf_alloc_6g,
>  	.tx_buf_get = dsi_tx_buf_get_6g,
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 11ae5b8..890531c 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -14,6 +14,7 @@
>  #include <linux/of_graph.h>
>  #include <linux/of_irq.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/pm_opp.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spinlock.h>
> @@ -111,6 +112,9 @@ struct msm_dsi_host {
>  	struct clk *pixel_clk_src;
>  	struct clk *byte_intf_clk;
>  
> +	struct opp_table *opp_table;
> +	bool has_opp_table;
> +
>  	u32 byte_clk_rate;
>  	u32 pixel_clk_rate;
>  	u32 esc_clk_rate;
> @@ -537,6 +541,38 @@ int dsi_link_clk_set_rate_6g(struct msm_dsi_host *msm_host)
>  	return 0;
>  }
>  
> +int dsi_link_clk_set_rate_6g_v2(struct msm_dsi_host *msm_host)
> +{
> +	int ret;
> +	struct device *dev = &msm_host->pdev->dev;
> +
> +	DBG("Set clk rates: pclk=%d, byteclk=%d",
> +		msm_host->mode->clock, msm_host->byte_clk_rate);
> +
> +	ret = dev_pm_opp_set_rate(dev, msm_host->byte_clk_rate);
> +	if (ret) {
> +		pr_err("%s: dev_pm_opp_set_rate failed %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	ret = clk_set_rate(msm_host->pixel_clk, msm_host->pixel_clk_rate);
> +	if (ret) {
> +		pr_err("%s: Failed to set rate pixel clk, %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	if (msm_host->byte_intf_clk) {
> +		ret = clk_set_rate(msm_host->byte_intf_clk,
> +				   msm_host->byte_clk_rate / 2);
> +		if (ret) {
> +			pr_err("%s: Failed to set rate byte intf clk, %d\n",
> +			       __func__, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}

xThis function is essentially the same as dsi_link_clk_set_rate_6g(),
except for the use of dev_pm_opp_set_rate() instead of clk_set_rate().

IIUC dev_pm_opp_set_rate() just calls clk_set_rate() if the device has
no OPP table. If that's correct you could just call dev_pm_opp_set_rate()
in dsi_link_clk_set_rate_6g().

	/*
    	* For IO devices which require an OPP on some platforms/SoCs
    	* while just needing to scale the clock on some others
    	* we look for empty OPP tables with just a clock handle and
    	* scale only the clk. This makes dev_pm_opp_set_rate()
	* equivalent to a clk_set_rate()
	*/
	if (!_get_opp_count(opp_table)) {
		ret = _generic_set_opp_clk_only(dev, clk, freq);
		goto put_opp_table;
	}

https://elixir.bootlin.com/linux/v5.7.6/source/drivers/opp/core.c#L855

>  int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host)
>  {
> @@ -665,6 +701,13 @@ void dsi_link_clk_disable_6g(struct msm_dsi_host *msm_host)
>  	clk_disable_unprepare(msm_host->byte_clk);
>  }
>  
> +void dsi_link_clk_disable_6g_v2(struct msm_dsi_host *msm_host)
> +{
> +	/* Drop the performance state vote */
> +	dev_pm_opp_set_rate(&msm_host->pdev->dev, 0);

Couldn't you just do this in dsi_link_clk_disable_6g() ?

> +	dsi_link_clk_disable_6g(msm_host);
> +}
> +
