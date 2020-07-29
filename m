Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857DBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A81E207F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NPqIAKW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgG2VBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2VBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:01:08 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA09C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 14:01:08 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w2so15086390pgg.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 14:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r3+nIP5K10EGXnlaC/cqwtCDvvVytsxi4lBzhWC758s=;
        b=NPqIAKW0dtRBd55t7S5JASfi7g9Qq+lP1OQ2dWFq8ixWGO+AWw8PvU/BiXcokWwtiD
         MGxBu2srEBQwuCHG1ZyEtB+NpCIxsdDnxC3/CXSwOvy+xGCGVm0wgnnVSM5Bo/NvrQ+e
         bX5E/ILgo6brXqZqOgxPdDEsymwGUphFnB7L0f6nl7eyvsDwC0CHDEmcbUVBSkmKiogG
         B4NcgM4d6pCgkOB7BeYNbDySlgV1QpfhOL+YgeVOworCdaIO46WTdcvVEYtKrScSw0Fu
         FGOiu1Oyku3nf1zrFnmdin8V6e/hCpVdCjwVVGvbzB6UZV7v9cfXLFqdf+vnPVb/KkX0
         grlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r3+nIP5K10EGXnlaC/cqwtCDvvVytsxi4lBzhWC758s=;
        b=tu6gPUk3Sd6DsrC5dJo87NIH6zaoyMe0/hPU2loS6BcXklQXDn2KBVwCKmfL8H4uKr
         tHnR8WxpTrR1wfbRdFZaqpabDOW9+uIPgbCjwvyJQnSqMt9PNi853H4+xjlRh24ia5+I
         oeDmDwTrVOZRhGHkDPfd15vdOUKKwhmdIcsh/1VDdtc8X8PwcYfqtVA4vNlAX4downmf
         WP3bn4Tdh5iq1AO41acL1uFfGBzUJJApkY9596A0TVAkWf2DYQjRggYoQoTWBDXjl750
         gwbI3weoiMom2j/TcSc5Qc5SZ8su1uf5F1mLLdKFecnOWIizIBkGPZUOi32HqTPC6dfq
         SyeQ==
X-Gm-Message-State: AOAM5331bb2IDtVPsNWDZYzhBN6+xj0Ba4C4PK6heR1upD91SImjMtRT
        z2A7vUlElBL47XsGzawWd6NMO45aAMg=
X-Google-Smtp-Source: ABdhPJx7qhJ7u7WquA86mm1b5sQ2oV6GH/poPkjKxkBaEb6ET0/P0b8LDb75yivjqHqjp59pkDr/RQ==
X-Received: by 2002:a63:5a1a:: with SMTP id o26mr30504745pgb.420.1596056468110;
        Wed, 29 Jul 2020 14:01:08 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i1sm3448625pfo.212.2020.07.29.14.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 14:01:07 -0700 (PDT)
Date:   Wed, 29 Jul 2020 15:01:05 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, coresight@lists.linaro.org
Subject: Re: [RFC PATCH 03/14] coresight: tpiu: Use coresight device access
 abstraction
Message-ID: <20200729210105.GC3073178@xps15>
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
 <20200722172040.1299289-4-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722172040.1299289-4-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 06:20:29PM +0100, Suzuki K Poulose wrote:
> TPIU driver access the device before the coresight device
> is registered. In other words, before the drvdata->csdev
> is valid. Thus, we need to make sure that the csdev_access
> is valid for both the invocations. Switch to using the
> csdev_access directly instead of relying on availability
> of drvdata->csdev.

I'm not sure all of the above is needed and based on the wording I could easily
see this patch being selected for stable backport, which would be a mistak. 

The gist of this patch is that we are moving to the access abstraction and the
changelog should reflect that.

> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tpiu.c | 30 +++++++++-----------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index 7ef7649f48ad..84ff4bf5d3b8 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -60,49 +60,45 @@ struct tpiu_drvdata {
>  	struct coresight_device	*csdev;
>  };
>  
> -static void tpiu_enable_hw(struct tpiu_drvdata *drvdata)
> +static void tpiu_enable_hw(struct csdev_access *csa)
>  {
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(csa->base);
>  
>  	/* TODO: fill this up */
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(csa->base);
>  }
>  
>  static int tpiu_enable(struct coresight_device *csdev, u32 mode, void *__unused)
>  {
> -	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> -
> -	tpiu_enable_hw(drvdata);
> +	tpiu_enable_hw(&csdev->access);
>  	atomic_inc(csdev->refcnt);
>  	dev_dbg(&csdev->dev, "TPIU enabled\n");
>  	return 0;
>  }
>  
> -static void tpiu_disable_hw(struct tpiu_drvdata *drvdata)
> +static void tpiu_disable_hw(struct csdev_access *csa)
>  {
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(csa->base);
>  
>  	/* Clear formatter and stop on flush */
> -	writel_relaxed(FFCR_STOP_FI, drvdata->base + TPIU_FFCR);
> +	csdev_access_relaxed_write32(csa, FFCR_STOP_FI, TPIU_FFCR);
>  	/* Generate manual flush */
> -	writel_relaxed(FFCR_STOP_FI | FFCR_FON_MAN, drvdata->base + TPIU_FFCR);
> +	csdev_access_relaxed_write32(csa, FFCR_STOP_FI | FFCR_FON_MAN, TPIU_FFCR);
>  	/* Wait for flush to complete */
> -	coresight_timeout(drvdata->base, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
> +	coresight_timeout(csa->base, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
>  	/* Wait for formatter to stop */
> -	coresight_timeout(drvdata->base, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
> +	coresight_timeout(csa->base, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(csa->base);
>  }
>  
>  static int tpiu_disable(struct coresight_device *csdev)
>  {
> -	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> -
>  	if (atomic_dec_return(csdev->refcnt))
>  		return -EBUSY;
>  
> -	tpiu_disable_hw(drvdata);
> +	tpiu_disable_hw(&csdev->access);
>  
>  	dev_dbg(&csdev->dev, "TPIU disabled\n");
>  	return 0;
> @@ -152,7 +148,7 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>  	desc.access.base = base;

Any reason for introducing the above in patch 02?  I would have done that as
part of this patch...  Also part of this patch I would remove drvdata::base
since it is no longer needed.

I'm out of time for today - I will continue tomorrow.

Regards,
Mathieu

>  
>  	/* Disable tpiu to support older devices */
> -	tpiu_disable_hw(drvdata);
> +	tpiu_disable_hw(&desc.access);
>  
>  	pdata = coresight_get_platform_data(dev);
>  	if (IS_ERR(pdata))
> -- 
> 2.24.1
> 
