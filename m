Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4032AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183E820706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDQ6U3X0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbgFWRZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733191AbgFWRZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:25:36 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0EBC061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 10:25:35 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i12so1756105pju.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 10:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cXLrIYCmsRYrUlW+MZ901zfNrzDQAzij3wzyORGTwhE=;
        b=fDQ6U3X06ji/FJIFe6lJokBcNOZRlBEfjWGafMQm6Qbi9gxTJ5H1vc2I2GWd16eIkJ
         RmEtQX9k8DEbANaUGqUT9v0Xmk9mqyYouzc/Y+foF9ugv4Sfmoi44X2C70UozewzySGy
         aDXmjfIOJb+dIX9AcgqXxB2lVNHh+stJefoNfC35qLluth4GKRsyDxrGXURu8m5M09BD
         mnsbUB3b20hiFZYeGy0PXeZWR1rhCvXSokyZqqVyYKuRwkwLAWkqu4InhbCBkAlPm9OL
         Vj8eXq9sgpOAIdYDB64TrFafmGBM0XbonbjOZWpMF+/qFEyh9e9u4bfPqqKJTs7Z2M2O
         XQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cXLrIYCmsRYrUlW+MZ901zfNrzDQAzij3wzyORGTwhE=;
        b=uAFLAnzNuM4bvN6H87l9I3qEsLmcQ9bUvrnkv3XjUcUFFEJY+XEJAmnmyzplu8Kx1D
         YFC22vwwBkz73jn/POCr+F4PsjfYJtMPDL3pHeKe9ipMCVubSYzmihZjvU8SVzgLZH7k
         WgHFQniTug/uMbEqoYBzhN6dTnmN/Mi+7zPPuR+zzjkoUrZOGwViCypoTSujXUs7KDmD
         /r0vnIxFHxwYn2vDXnM19KKh1hmL0B9Eu58iJeB29BfcGflEi+AluLw8YNpuYnhIFdOQ
         5tAXsmIFmIHFcsghaM6IK1AKbUn8IKz4Jf0Ko/3kBrQevhEv1PqkH8LRnktWeAxxcoYF
         1uYg==
X-Gm-Message-State: AOAM533T71Eurh8IGPOnxz5RH3sx0vvVmUTDB/K2XwOTFXhfPp0PEiTu
        xnERZsUZc9MPbNLGKcELp7oTzA==
X-Google-Smtp-Source: ABdhPJyXHN3Drl4LyciWoUA6XuU1ansdINyyc/nZRCLR43vV3CFcV4oAbuwbzz8KZgEd5VucBropBw==
X-Received: by 2002:a17:90a:7504:: with SMTP id q4mr22739919pjk.44.1592933135144;
        Tue, 23 Jun 2020 10:25:35 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 3sm7935671pfv.156.2020.06.23.10.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 10:25:34 -0700 (PDT)
Date:   Tue, 23 Jun 2020 11:25:32 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCHv3] coresight: tmc: Add shutdown callback for TMC ETR
Message-ID: <20200623172532.GA1843779@xps15>
References: <20200616045623.27549-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616045623.27549-1-saiprakash.ranjan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 10:26:23AM +0530, Sai Prakash Ranjan wrote:
> Implement a shutdown callback to ensure ETR hardware is
> properly shutdown in reboot/shutdown path. This is required
> for ETR which has SMMU address translation enabled like on
> SC7180 SoC and few others. If the hardware is still accessing
> memory after SMMU translation is disabled as part of SMMU
> shutdown callback in system reboot or shutdown path, then
> IOVAs(I/O virtual address) which it was using will go on the
> bus as the physical addresses which might result in unknown
> crashes (NoC/interconnect errors). So we make sure from this
> shutdown callback that the ETR is shutdown before SMMU translation
> is disabled and device_link in SMMU driver will take care of
> ordering of shutdown callbacks such that SMMU shutdown callback
> is not called before any of its consumer shutdown callbacks.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

I have applied your patch.

Thanks,
Mathieu

> 
> Changes since v2:
>  * Remove ETF/ETB disable as suggested by Mathieu and Mike since they are
>    not really affected.
>  * Remove coresight and misc device unregister since it is not required
>    for shutdown callback unlike remove callback and userspace is long gone
>    by this time.
> 
> Changes since v1:
>  * Use mode flag and drop enable flag as Mike suggested.
>  * Use spinlock before tmc hw disable as Mike suggested.
> 
> ---
>  .../hwtracing/coresight/coresight-tmc-etr.c   |  2 +-
>  drivers/hwtracing/coresight/coresight-tmc.c   | 23 +++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-tmc.h   |  1 +
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 625882bc8b08..b29c2db94d96 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1110,7 +1110,7 @@ static void __tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
>  
>  }
>  
> -static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
> +void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
>  {
>  	__tmc_etr_disable_hw(drvdata);
>  	/* Disable CATU device if this ETR is connected to one */
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 39fba1d16e6e..b13ce0daa572 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -538,6 +538,28 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  	return ret;
>  }
>  
> +static void tmc_shutdown(struct amba_device *adev)
> +{
> +	unsigned long flags;
> +	struct tmc_drvdata *drvdata = amba_get_drvdata(adev);
> +
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +
> +	if (drvdata->mode == CS_MODE_DISABLED)
> +		goto out;
> +
> +	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
> +		tmc_etr_disable_hw(drvdata);
> +
> +	/*
> +	 * We do not care about coresight unregister here unlike remove
> +	 * callback which is required for making coresight modular since
> +	 * the system is going down after this.
> +	 */
> +out:
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +}
> +
>  static const struct amba_id tmc_ids[] = {
>  	CS_AMBA_ID(0x000bb961),
>  	/* Coresight SoC 600 TMC-ETR/ETS */
> @@ -556,6 +578,7 @@ static struct amba_driver tmc_driver = {
>  		.suppress_bind_attrs = true,
>  	},
>  	.probe		= tmc_probe,
> +	.shutdown	= tmc_shutdown,
>  	.id_table	= tmc_ids,
>  };
>  builtin_amba_driver(tmc_driver);
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 71de978575f3..6e8d2dc33d17 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -268,6 +268,7 @@ ssize_t tmc_etb_get_sysfs_trace(struct tmc_drvdata *drvdata,
>  /* ETR functions */
>  int tmc_read_prepare_etr(struct tmc_drvdata *drvdata);
>  int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata);
> +void tmc_etr_disable_hw(struct tmc_drvdata *drvdata);
>  extern const struct coresight_ops tmc_etr_cs_ops;
>  ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
>  				loff_t pos, size_t len, char **bufpp);
> 
> base-commit: 059e38815950dbec65beafe03757bce9436e89a4
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
