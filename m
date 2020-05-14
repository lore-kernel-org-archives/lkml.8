Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA520C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2ED520657
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZCGuNU5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgENSBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726035AbgENSBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:01:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D753C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 11:01:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x2so1648562pfx.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 11:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q+94btJD+GoatLukAXyT7lRAf/KVqdd70Ky4ApajaB4=;
        b=ZCGuNU5TwJwkF/qOaWwTaMbEfGJUVNBlxVt5Ffyrj97GNOAlY9WmxRf3FiwXWz/5sX
         HXTA1sKMNwSSo4SpXSTN2I8xxS4aFwuT/4DputdVW84PpQGDLp2xcwi2X7gdANMgTKzc
         QDDAxNhr5zHAwaIglP9S0WS20paeaPCr8GzyrP9kVF+8l8o0Dqx/M12H9XGx6Lhv9oz9
         CoUOCIdZxNEYNPiRzkv1xq+jzMEx/1rAuiXQy+lysVmeQsW0Xsp4aW/tjqCdHrSe0g6B
         oxMlwgBff+N2GXlYIlIMg5L/YnJfJ28Lc8kSwpl2idhREd6V32rO9I4Z8InED5gVbdWN
         zJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q+94btJD+GoatLukAXyT7lRAf/KVqdd70Ky4ApajaB4=;
        b=lUKTT/hC9cRaa3hZbxvEBeKtyjaPZXYlf2zodazBFo7qZbLfT3hPyHKuZCKirnVvPs
         fk4l53OwxJa5ix2rTaxwG1+RHF8mjm4yzQtG8gVLm+Okcmg1gJPbPPVXb/vk5xSJpnTy
         MjMKANhNoBYRvYLmrrJD0nLMHuZ7/zsx2gZEv3UsguouEHxSaynH1zAy4PUXTSncFUOh
         MIb2TtWd3qRWg2NmL5C3XFqJE6x4fhL32xj0DOFhe0C9/6HmfdeSucD0EMF+XQPj/Qmq
         xKOP/wBsGNxlpBN34TOH6sKgwKGNCfulqfmFN29RzVNnvLIJUFmJlT6Q6sV6jpQOq0SW
         P5GA==
X-Gm-Message-State: AOAM531s7ScMffGc7n5ZqIhrxnsoq9unekMftSw1NPdywjYO2jvWZ+z7
        LSUV0MIQyQnCq392jzMvO8xWsA==
X-Google-Smtp-Source: ABdhPJwVCSQFVIIffQCmw/NdSgP4/xj9cRLTxkvj99YAZ4LRBiKMEoP+sm/an/Cbf/dUrk1FT5FGcA==
X-Received: by 2002:a63:e550:: with SMTP id z16mr4858799pgj.92.1589479258195;
        Thu, 14 May 2020 11:00:58 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id y2sm2884597pfq.16.2020.05.14.11.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 11:00:57 -0700 (PDT)
Date:   Thu, 14 May 2020 12:00:55 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        coresight@lists.linaro.org
Subject: Re: [PATCH] coresight: etm4x: Add support to disable trace unit
 power up
Message-ID: <20200514180055.GA29384@xps15>
References: <20200514105915.27516-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514105915.27516-1-saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Sai,

On Thu, May 14, 2020 at 04:29:15PM +0530, Sai Prakash Ranjan wrote:
> From: Tingwei Zhang <tingwei@codeaurora.org>
> 
> On some Qualcomm Technologies Inc. SoCs like SC7180, there
> exists a hardware errata where the APSS (Application Processor
> SubSystem)/CPU watchdog counter is stopped when ETM register
> TRCPDCR.PU=1.

Fun stuff...

> Since the ETMs share the same power domain as
> that of respective CPU cores, they are powered on when the
> CPU core is powered on. So we can disable powering up of the
> trace unit after checking for this errata via new property
> called "qcom,tupwr-disable".
> 
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> Co-developed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Co-developed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>

> ---
>  .../devicetree/bindings/arm/coresight.txt     |  6 ++++
>  drivers/hwtracing/coresight/coresight-etm4x.c | 29 ++++++++++++-------

Please split in two patches.

>  2 files changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index 846f6daae71b..d2030128fe46 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -108,6 +108,12 @@ its hardware characteristcs.
>  	* arm,cp14: must be present if the system accesses ETM/PTM management
>  	  registers via co-processor 14.
>  
> +	* qcom,tupwr-disable: boolean. Indicates that trace unit power up can
> +	  be disabled on Qualcomm Technologies Inc. systems where ETMs are in
> +	  the same power domain as their CPU cores. This property is required
> +	  to identify such systems with hardware errata where the CPU watchdog
> +	  counter is stopped when TRCPDCR.PU=1.
> +

I think something like "qcom,skip-power-up" would be clearer. 

Also, a better choice of words is that TRCPDCR.PU does not have to be set on
Qualcomm...

>  * Optional property for TMC:
>  
>  	* arm,buffer-size: size of contiguous buffer space for TMC ETR
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index fb0f5f4f3a91..6886b44f6947 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -104,6 +104,11 @@ struct etm4_enable_arg {
>  	int rc;
>  };
>  
> +static inline bool etm4_can_disable_tupwr(struct device *dev)
> +{
> +	return fwnode_property_present(dev_fwnode(dev), "qcom,tupwr-disable");
> +}
> +

Please call fwnode_property_present() at initialisation time to set a new
drvdata::skip_power_up variable.  From there just switch on that in
etm4_enable/disable_hw().  

Thanks,
Mathieu

>  static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  {
>  	int i, rc;
> @@ -196,12 +201,14 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  	writel_relaxed(config->vmid_mask0, drvdata->base + TRCVMIDCCTLR0);
>  	writel_relaxed(config->vmid_mask1, drvdata->base + TRCVMIDCCTLR1);
>  
> -	/*
> -	 * Request to keep the trace unit powered and also
> -	 * emulation of powerdown
> -	 */
> -	writel_relaxed(readl_relaxed(drvdata->base + TRCPDCR) | TRCPDCR_PU,
> -		       drvdata->base + TRCPDCR);
> +	if (!etm4_can_disable_tupwr(etm_dev)) {
> +		/*
> +		 * Request to keep the trace unit powered and also
> +		 * emulation of powerdown
> +		 */
> +		writel_relaxed(readl_relaxed(drvdata->base + TRCPDCR) | TRCPDCR_PU,
> +			       drvdata->base + TRCPDCR);
> +	}
>  
>  	/* Enable the trace unit */
>  	writel_relaxed(1, drvdata->base + TRCPRGCTLR);
> @@ -476,10 +483,12 @@ static void etm4_disable_hw(void *info)
>  
>  	CS_UNLOCK(drvdata->base);
>  
> -	/* power can be removed from the trace unit now */
> -	control = readl_relaxed(drvdata->base + TRCPDCR);
> -	control &= ~TRCPDCR_PU;
> -	writel_relaxed(control, drvdata->base + TRCPDCR);
> +	if (!etm4_can_disable_tupwr(etm_dev)) {
> +		/* power can be removed from the trace unit now */
> +		control = readl_relaxed(drvdata->base + TRCPDCR);
> +		control &= ~TRCPDCR_PU;
> +		writel_relaxed(control, drvdata->base + TRCPDCR);
> +	}
>  
>  	control = readl_relaxed(drvdata->base + TRCPRGCTLR);
>  
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
