Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11EBC433E3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAB420722
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nbQzoPKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgGFQLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbgGFQLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:11:00 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B69C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 09:11:00 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e18so18594596pgn.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 09:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kxpgn+GnVhnInuZTEY3U3K5Tk71jPK8wC7nu0ga4/fw=;
        b=nbQzoPKjqjnIrUMrKu30HI3Eg6a1eMk6dbCMfw3HJK42SAQc8CthBadwHpAxjtlmGk
         8d5mSe0Ao+f2/bee7mjRqi80i6P9/+hXYCVq54kbbEYcdoK5ErXfsACQPK+XAXCtZuod
         JCZZbAF6fmr+o2n6HILhJNTP1XA+2Uf7BFvy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kxpgn+GnVhnInuZTEY3U3K5Tk71jPK8wC7nu0ga4/fw=;
        b=X1xJp3/Otkoef+0GhjONCn/Ivln6+iGUZypoO9a3e3aByTDg1G18VK5CoJ79wVWbqU
         pcHKbkZeSJHcqbH86fiwJu9WkIdi48nTFzPfJKvr157BYq8b9GQcRW4SBoWrgcZ1+YTZ
         +URsvHAMAX4gNEnapHa7erXEHBwufvKG/ArhHuzi4y1P5zSD1/JtzGm0i7gxh60yFFnR
         /9YZPpH9gbE4r3GncHrqIw9IE+XiV+bVdppYjeGNi9nLCvnozH4QkIFPaeq1l+hIRQws
         9QoIgyMTEzaBdFEdSKnu3Q5S7/Skcz90Yv/XMvHu9dAQEm3tPj/M1ucYRT4Me4uICu1Z
         Ve+g==
X-Gm-Message-State: AOAM532QM2NDQOWiNKgenUNFsH8DImQic7SMj/NBAGdVZIFyOHO+GQ30
        M9XnbYQK4iLAQrlF6b0rn7Wpcg==
X-Google-Smtp-Source: ABdhPJyVjLtzWbo0ncj4kmd2UIN+BR2sv4gkUn6dDJQBKy2XGcmw+t0N4jFQ6LQD+nxLoORhXh6e8Q==
X-Received: by 2002:a62:8688:: with SMTP id x130mr45549675pfd.280.1594051859580;
        Mon, 06 Jul 2020 09:10:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id o42sm20120289pje.10.2020.07.06.09.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 09:10:58 -0700 (PDT)
Date:   Mon, 6 Jul 2020 09:10:57 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     robdclark@gmail.com, sean@poorly.run, agross@kernel.org,
        bjorn.andersson@linaro.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] drm/msm: dsi: Use OPP API to set clk/perf state
Message-ID: <20200706161057.GG3191083@google.com>
References: <1593688151-22616-1-git-send-email-rnayak@codeaurora.org>
 <1593688151-22616-3-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1593688151-22616-3-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 04:39:09PM +0530, Rajendra Nayak wrote:
> On SDM845 and SC7180 DSI needs to express a performance state
> requirement on a power domain depending on the clock rates.
> Use OPP table from DT to register with OPP framework and use
> dev_pm_opp_set_rate() to set the clk/perf state.
> 
> dev_pm_opp_set_rate() is designed to be equivalent to clk_set_rate()
> for devices without an OPP table, hence the change works fine
> on devices/platforms which only need to set a clock rate.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 11ae5b8..09e16b8 100644
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
> @@ -512,9 +516,10 @@ int dsi_link_clk_set_rate_6g(struct msm_dsi_host *msm_host)
>  	DBG("Set clk rates: pclk=%d, byteclk=%d",
>  		msm_host->mode->clock, msm_host->byte_clk_rate);
>  
> -	ret = clk_set_rate(msm_host->byte_clk, msm_host->byte_clk_rate);
> +	ret = dev_pm_opp_set_rate(&msm_host->pdev->dev,
> +				  msm_host->byte_clk_rate);
>  	if (ret) {
> -		pr_err("%s: Failed to set rate byte clk, %d\n", __func__, ret);
> +		pr_err("%s: dev_pm_opp_set_rate failed %d\n", __func__, ret);
>  		return ret;
>  	}
>  
> @@ -658,6 +663,8 @@ int dsi_link_clk_enable_v2(struct msm_dsi_host *msm_host)
>  
>  void dsi_link_clk_disable_6g(struct msm_dsi_host *msm_host)
>  {
> +	/* Drop the performance state vote */
> +	dev_pm_opp_set_rate(&msm_host->pdev->dev, 0);
>  	clk_disable_unprepare(msm_host->esc_clk);
>  	clk_disable_unprepare(msm_host->pixel_clk);
>  	if (msm_host->byte_intf_clk)
> @@ -1879,6 +1886,18 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
>  		goto fail;
>  	}
>  
> +	msm_host->opp_table = dev_pm_opp_set_clkname(&pdev->dev, "byte");
> +	if (IS_ERR(msm_host->opp_table))
> +		return PTR_ERR(msm_host->opp_table);
> +	/* OPP table is optional */
> +	ret = dev_pm_opp_of_add_table(&pdev->dev);
> +	if (!ret) {
> +		msm_host->has_opp_table = true;
> +	} else if (ret != -ENODEV) {
> +		dev_err(&pdev->dev, "invalid OPP table in device tree\n");

  		dev_pm_opp_put_clkname(msm_host->opp_table);

> +		return ret;
> +	}

With the missing _put_clkname() fixed:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
