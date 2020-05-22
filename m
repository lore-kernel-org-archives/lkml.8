Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7363C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E5620738
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KP75l1Pa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbgEVRk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 13:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbgEVRk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:40:57 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8385FC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 10:40:56 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x18so3551222pll.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 10:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K1qb1unhc2s9XSfdtBUxNy0aFKrFE7wsMogkq1M18kI=;
        b=KP75l1PaePWJAlHSZYnJ8024KaeFLaMEdOzGnfBp3ozRJs5IwTafKqsOv0KoaFbOsY
         4LwdlhTuf0kcn2Tp2SjL1dOarUqoNjCqZjafdkPD4r8s4daZQnKPU3kMNW8r/QNGUnKR
         23GKpxoU+O/ovuaYDfl0YjMd/keXJnWTSPQn7QfwvZsH3nBvCLbAQUpUbvYL5NvNlY21
         /27bpWlmDfP6QwL6LHWD/4ofP/QBJSG5JXYf/P3hInf75YK2AO2LOLuc/uvhZkQ4/8i9
         4f1SvwFjAWe5t653vBUCU5lZS9N+ZuuieobLtZC1Mpns3DxMkEwSkAu/ELif40Sz4JRV
         TgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K1qb1unhc2s9XSfdtBUxNy0aFKrFE7wsMogkq1M18kI=;
        b=aWwPONZo4o1c/a9X96NC8+2W692/8+9t1ecZL5itT/dzYk4oGhYycIXeyPEhtcKpE/
         yYM0Z5krTm/lQ8JXSfDlaRRaHgC2TWGQsO8p7xerTvuoVBKipuB9Evo6C/Bj6BqDyqp3
         vDijxR/UYHOSFX/Sp3ewaBaF0q/E5i65upoPGXSHLZAGbAg7reObURpxAajHJAwDwRU/
         HoPhwswQd8/fHMDs3+qF/qebFXIa4soHi0+qAUTGmo3qNGF1rM3/MnVDroYf8q5e0blV
         B1ZEJiyNj7JR5NHYSXpbJV51EQxe3GZM62bCfB7SQ3L8GDbXakVKHTB7SvxJUyHFZYQZ
         GKhw==
X-Gm-Message-State: AOAM530tMbn5Tsy2omiqZvZpkcpwubViVB5JoUFGN71+/GC4HV3Ca1WD
        xcc+tdyuxKBPBmghq2cgLXSaYg==
X-Google-Smtp-Source: ABdhPJwIa0OphspnB9zTn4uxM3uhhbswk/7aHe4rb0vcNtPGjkfKRWxokQYWWzNc2ycsBtPgW9YDjw==
X-Received: by 2002:a17:902:a98c:: with SMTP id bh12mr14643228plb.253.1590169255924;
        Fri, 22 May 2020 10:40:55 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id s1sm2186928pjp.27.2020.05.22.10.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 10:40:55 -0700 (PDT)
Date:   Fri, 22 May 2020 11:40:52 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        coresight@lists.linaro.org
Subject: Re: [PATCHv2 3/4] coresight: replicator: Reset replicator if context
 is lost
Message-ID: <20200522174052.GA3379@xps15>
References: <cover.1589894597.git.saiprakash.ranjan@codeaurora.org>
 <c2e02d0c92b081c05b91d07ec17e648c40af3897.1589894597.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2e02d0c92b081c05b91d07ec17e648c40af3897.1589894597.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

On Tue, May 19, 2020 at 07:06:02PM +0530, Sai Prakash Ranjan wrote:
> On some QCOM SoCs, replicators in Always-On domain loses its
> context as soon as the clock is disabled. Currently as a part
> of pm_runtime workqueue, clock is disabled after the replicator
> is initialized by amba_pm_runtime_suspend assuming that context
> is not lost which is not true for replicators with such
> limitations. So add a new property "qcom,replicator-loses-context"
> to identify such replicators and reset them.
> 
> Suggested-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
> 
> Added Mike's suggested by for parts other than the DT property.
> Perhaps I should add Co-developed-by Mike since the full skeletal
> was given by Mike. I can add that if required on the next version.

 I will let Mike decide what he wants to do - I'm fine either way.

> 
> ---
>  .../coresight/coresight-replicator.c          | 53 +++++++++++++------
>  1 file changed, 36 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index c619b456f55a..ba66160c8140 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -38,6 +38,7 @@ struct replicator_drvdata {
>  	struct clk		*atclk;
>  	struct coresight_device	*csdev;
>  	spinlock_t		spinlock;
> +	bool			check_idfilter_val;

Please add documentation for the new field, the same way other fields are
documented.

>  };
>  
>  static void dynamic_replicator_reset(struct replicator_drvdata *drvdata)
> @@ -66,29 +67,43 @@ static int dynamic_replicator_enable(struct replicator_drvdata *drvdata,
>  				     int inport, int outport)
>  {
>  	int rc = 0;
> -	u32 reg;
> -
> -	switch (outport) {
> -	case 0:
> -		reg = REPLICATOR_IDFILTER0;
> -		break;
> -	case 1:
> -		reg = REPLICATOR_IDFILTER1;
> -		break;
> -	default:
> -		WARN_ON(1);
> -		return -EINVAL;
> -	}
> +	u32 id0val, id1val;
>  
>  	CS_UNLOCK(drvdata->base);
>  
> -	if ((readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0) == 0xff) &&
> -	    (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0xff))
> +	id0val = readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0);
> +	id1val = readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1);
> +
> +	/*
> +	 * Some replicator designs lose context when AMBA clocks are removed,
> +	 * so have a check for this.
> +	 */
> +	if (drvdata->check_idfilter_val && id0val == 0x0 && id1val == 0x0)
> +		id0val = id1val = 0xff;
> +
> +	if (id0val == 0xff && id1val == 0xff)
>  		rc = coresight_claim_device_unlocked(drvdata->base);
>  
> +	if (!rc) {
> +		switch (outport) {
> +		case 0:
> +			id0val = 0x0;
> +			break;
> +		case 1:
> +			id1val = 0x0;
> +			break;
> +		default:
> +			WARN_ON(1);
> +			rc = -EINVAL;
> +		}
> +	}
> +
>  	/* Ensure that the outport is enabled. */
> -	if (!rc)
> -		writel_relaxed(0x00, drvdata->base + reg);
> +	if (!rc) {
> +		writel_relaxed(id0val, drvdata->base + REPLICATOR_IDFILTER0);
> +		writel_relaxed(id1val, drvdata->base + REPLICATOR_IDFILTER1);
> +	}
> +
>  	CS_LOCK(drvdata->base);
>  
>  	return rc;
> @@ -239,6 +254,10 @@ static int replicator_probe(struct device *dev, struct resource *res)
>  		desc.groups = replicator_groups;
>  	}
>  
> +	if (fwnode_property_present(dev_fwnode(dev),
> +				    "qcom,replicator-loses-context"))
> +		drvdata->check_idfilter_val = true;
> +

The header <linux/property.h> needs to be added for function
fwnode_property_present().

What is the clock situation with other QC components like funnels?  Have they
also been designed the same way?  If so the binding should probably be
"qcom,component-loses-context", otherwise what you have suggested will work just
fine.  My goal here is to avoid having "qcom,replicator-loses-context" and
"qcom,funnel-loses-context".  

Lastly, I have applied patch 1 and 2 of this set to my tree so no need to resend
them again with the next revision.

Thanks,
Mathieu

>  	dev_set_drvdata(dev, drvdata);
>  
>  	pdata = coresight_get_platform_data(dev);
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
