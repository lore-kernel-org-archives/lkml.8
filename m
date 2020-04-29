Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C512C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7FA20737
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aR5Y4LyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgD2AOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 20:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgD2AO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 20:14:29 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EE6C03C1AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 17:14:27 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o185so151134pgo.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 17:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oC/IMb1bwlh++DNsn95OmE+lN7/Y/nWugcyzuo4SIAg=;
        b=aR5Y4LyPGc8UiBcFN/PZabrK1ONJRW4oCptDc6usBkRxgOiwdEh6jJPe06PEezB7xF
         1JEaBFYsI5TqkmmLhG0zEfw8U4RwoUWVuWxAtCxENKblbxSmrEWz+gt1aTiZf5DYmSJz
         ZL8zMU37c52VJOjeTZ5Du5al4KIwIjH69fvM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oC/IMb1bwlh++DNsn95OmE+lN7/Y/nWugcyzuo4SIAg=;
        b=oquCWw0ezr30m3lxX+nCIgHcnrPsUnzPzpAUvuWzqdNzMYCu7Vzs3CoRN9sg/rhRS5
         cBHylvSoAjWb2ZxirJowO+ePYok4tyDJTJkCNDsSZFAWouLzPdiksdxz+VZ8BnhUy0UD
         uVrSv0VwxY3uYiY0u7r97IVewpqvdLISQKlwCVfw3MLLMNscwnhROS2OnXlaYEBTQF/B
         HGWuFO/4+l5mGiqRnmIKmvE+01prQ39YKwA/3/hNYQbuAQZUFGVqkKWe+C/yAtVuodmY
         osCaFXD8C3bU+Oxb3iT6MHzyM3xzltE/Rr/FDHBBoR8uCmrPpvMPYiHLoENtDYD1JLSt
         thXg==
X-Gm-Message-State: AGi0Puba5wnvhRjmM4rllcUQuZGYuft+dMUbis85zUXMPn099OdhYq0y
        jPcEfgDoZtwE7gFowxFXHq2U9g==
X-Google-Smtp-Source: APiQypJHKJy2ukrbhxQ/y3XX3d14OKXcxX2RpQRBZJE5lsbOpasWeFsM73FsM/5API9o7CXMOgm9CQ==
X-Received: by 2002:a63:ea08:: with SMTP id c8mr29667218pgi.420.1588119267303;
        Tue, 28 Apr 2020 17:14:27 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id h11sm16010252pfo.120.2020.04.28.17.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 17:14:26 -0700 (PDT)
Date:   Tue, 28 Apr 2020 17:14:25 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 05/17] drm/msm/dpu: Use OPP API to set clk/perf state
Message-ID: <20200429001425.GL4525@google.com>
References: <1588080785-6812-1-git-send-email-rnayak@codeaurora.org>
 <1588080785-6812-6-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1588080785-6812-6-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 07:02:53PM +0530, Rajendra Nayak wrote:
> On some qualcomm platforms DPU needs to express a perforamnce state
> requirement on a power domain depennding on the clock rates.
> Use OPP table from DT to register with OPP framework and use
> dev_pm_opp_set_rate() to set the clk/perf state.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c |  3 ++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       | 25 ++++++++++++++++++++++++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h       |  4 ++++
>  3 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> index 11f2beb..fe5717df 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> @@ -7,6 +7,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/errno.h>
>  #include <linux/mutex.h>
> +#include <linux/pm_opp.h>
>  #include <linux/sort.h>
>  #include <linux/clk.h>
>  #include <linux/bitmap.h>
> @@ -239,7 +240,7 @@ static int _dpu_core_perf_set_core_clk_rate(struct dpu_kms *kms, u64 rate)
>  		rate = core_clk->max_rate;
>  
>  	core_clk->rate = rate;
> -	return msm_dss_clk_set_rate(core_clk, 1);
> +	return dev_pm_opp_set_rate(&kms->pdev->dev, core_clk->rate);
>  }
>  
>  static u64 _dpu_core_perf_get_core_clk_rate(struct dpu_kms *kms)
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index ce19f1d..2f53bbf 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -10,6 +10,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/dma-buf.h>
>  #include <linux/of_irq.h>
> +#include <linux/pm_opp.h>
>  
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_file.h>
> @@ -1033,11 +1034,23 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
>  	if (!dpu_kms)
>  		return -ENOMEM;
>  
> +	dpu_kms->opp_table = dev_pm_opp_set_clkname(dev, "core");
> +	if (IS_ERR(dpu_kms->opp_table))
> +		return PTR_ERR(dpu_kms->opp_table);
> +	/* OPP table is optional */
> +	ret = dev_pm_opp_of_add_table(dev);
> +	if (!ret) {
> +		dpu_kms->has_opp_table = true;
> +	} else if (ret != -ENODEV) {
> +		dev_err(dev, "Invalid OPP table in Device tree\n");

nit: s/Device/device/ ?

uber-nit: s/Invalid/invalid/

  most log messages in this file start with a lower case letter, except
  for acronyms/register names

please also change it in the other drivers unless you disagree.

> +		return ret;
> +	}
> +
>  	mp = &dpu_kms->mp;
>  	ret = msm_dss_parse_clock(pdev, mp);
>  	if (ret) {
>  		DPU_ERROR("failed to parse clocks, ret=%d\n", ret);
> -		return ret;
> +		goto err;
>  	}
>  
>  	platform_set_drvdata(pdev, dpu_kms);
> @@ -1051,6 +1064,11 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
>  
>  	priv->kms = &dpu_kms->base;
>  	return ret;
> +err:
> +	if (dpu_kms->has_opp_table)
> +		dev_pm_opp_of_remove_table(dev);
> +	dev_pm_opp_put_clkname(dpu_kms->opp_table);
> +	return ret;
>  }
>  
>  static void dpu_unbind(struct device *dev, struct device *master, void *data)
> @@ -1059,6 +1077,9 @@ static void dpu_unbind(struct device *dev, struct device *master, void *data)
>  	struct dpu_kms *dpu_kms = platform_get_drvdata(pdev);
>  	struct dss_module_power *mp = &dpu_kms->mp;
>  
> +	if (dpu_kms->has_opp_table)
> +		dev_pm_opp_of_remove_table(dev);
> +	dev_pm_opp_put_clkname(dpu_kms->opp_table);
>  	msm_dss_put_clk(mp->clk_config, mp->num_clk);
>  	devm_kfree(&pdev->dev, mp->clk_config);
>  	mp->num_clk = 0;
> @@ -1090,6 +1111,8 @@ static int __maybe_unused dpu_runtime_suspend(struct device *dev)
>  	struct dpu_kms *dpu_kms = platform_get_drvdata(pdev);
>  	struct dss_module_power *mp = &dpu_kms->mp;
>  
> +	/* Drop the performance state vote */
> +	dev_pm_opp_set_rate(dev, 0);
>  	rc = msm_dss_enable_clk(mp->clk_config, mp->num_clk, false);
>  	if (rc)
>  		DPU_ERROR("clock disable failed rc:%d\n", rc);
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> index 211f5de9..2a52e4e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> @@ -128,6 +128,10 @@ struct dpu_kms {
>  
>  	struct platform_device *pdev;
>  	bool rpm_enabled;
> +
> +	struct opp_table *opp_table;
> +	bool has_opp_table;
> +
>  	struct dss_module_power mp;
>  
>  	/* reference count bandwidth requests, so we know when we can

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
