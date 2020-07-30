Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4AEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38AE20809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OSeU1K2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbgG3SAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 14:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3SAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 14:00:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EF2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:00:40 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w19so1872472plq.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YAbIFdBDABY/iXuY15hqoTWQkh5jDcA9cKphlTXpDXY=;
        b=OSeU1K2dfFPDKWOoMiuL8J8qgmGnmMfm6C28NeV15zxkyshGg9Pn2+mYhFVK8fwBpA
         F0Zho5yBnVJBSOSQJSFH7X+q3RnhJ3VWm8kN1F5TRGN0EW7AUd7gl7+3eY0YWVYopR7M
         DYRXQGDLmfyr+qyTU8P3BOKf9vrGwlwjqrSuvpKrDfEOtoOFgI4oqizRFEDrv33Lo0KR
         KdnhwqtFz4ATwU/EKNM2QRV13vvi8hIQ8b6KGR7DOn3F1OaBxPuYdwJbbsWv9BLcaZGk
         WgwYomkRlk/Mh70u49DNhgLSSnWKTIz08ASRfDKbVR6ggvsPQp1r3wKGeMvteYgjVEL7
         mVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YAbIFdBDABY/iXuY15hqoTWQkh5jDcA9cKphlTXpDXY=;
        b=hpJq4SRixXpb+MVRSuXBbfRdhuEg+icvCOHFmWAjIwRxN0h5DQcb7b8Gdu1PRxbh5r
         lDRyELUMJ2WDjx+AiRhGWVKAfcSLHki1fbXrxuyHDHLETiKeXJ3aplN2l9CKyN5CzjaI
         l9P9QheFg9G0wvlDVUrvosTU383MsrJE/wKQ1Ih9vWmLP/+DUNIiEDgCegmmJFAtlU7s
         FOjDdu6h2ijMmNYTw+QqennijWi32FZEAK3yIqo+5HXnqUyQStiU+3U65cCcdTW7rpaV
         6pd1Bsq928PdG4NR4XrdYC861KBjcIE6YVGCtV8RI0mQXxAFrqZgVqfdu3EeYeqlTMV6
         BKqw==
X-Gm-Message-State: AOAM531585wyXaljEyrDmjxLcBI094n3p6ZBoIfi5iIxM0jBHuJQ+W7R
        6bK+0BoX7rFJIzQxXnxSXFzOEA==
X-Google-Smtp-Source: ABdhPJz6Oh6ceXjr+WqAskWacr79G2Qt+NEOQixqHlwv4Dg7MtX5BxU8v8XnKT6IexMsvSSkL+5FqA==
X-Received: by 2002:a17:90a:ff92:: with SMTP id hf18mr268933pjb.107.1596132040054;
        Thu, 30 Jul 2020 11:00:40 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r7sm5088400pfl.186.2020.07.30.11.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 11:00:39 -0700 (PDT)
Date:   Thu, 30 Jul 2020 12:00:37 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, coresight@lists.linaro.org
Subject: Re: [RFC PATCH 05/14] coresight: Convert coresight_timeout to use
 access abstraction
Message-ID: <20200730180037.GB3155687@xps15>
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
 <20200722172040.1299289-6-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722172040.1299289-6-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 06:20:31PM +0100, Suzuki K Poulose wrote:
> Convert the generic routines to use the new access abstraction layer
> gradually, starting with coresigth_timeout.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-catu.c  |  2 +-
>  drivers/hwtracing/coresight/coresight-etb10.c |  5 +++--
>  drivers/hwtracing/coresight/coresight-etm4x.c | 12 +++++++-----
>  drivers/hwtracing/coresight/coresight-stm.c   |  2 +-
>  drivers/hwtracing/coresight/coresight-tmc.c   |  9 ++++++---
>  drivers/hwtracing/coresight/coresight-tpiu.c  |  4 ++--
>  drivers/hwtracing/coresight/coresight.c       | 15 +++++++++------
>  include/linux/coresight.h                     | 17 +++++++++++++----
>  8 files changed, 42 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index 6299ff7b8a14..30f037d4549d 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -401,7 +401,7 @@ static const struct attribute_group *catu_groups[] = {
>  
>  static inline int catu_wait_for_ready(struct catu_drvdata *drvdata)
>  {
> -	return coresight_timeout(drvdata->base,
> +	return coresight_timeout(&drvdata->csdev->access,
>  				 CATU_STATUS, CATU_STATUS_READY, 1);
>  }
>  
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 0f2735e15119..507f63c51be5 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -251,6 +251,7 @@ static void __etb_disable_hw(struct etb_drvdata *drvdata)
>  {
>  	u32 ffcr;
>  	struct device *dev = &drvdata->csdev->dev;
> +	struct coresight_device *csdev = drvdata->csdev;
>  
>  	CS_UNLOCK(drvdata->base);
>  
> @@ -262,7 +263,7 @@ static void __etb_disable_hw(struct etb_drvdata *drvdata)
>  	ffcr |= ETB_FFCR_FON_MAN;
>  	writel_relaxed(ffcr, drvdata->base + ETB_FFCR);
>  
> -	if (coresight_timeout(drvdata->base, ETB_FFCR, ETB_FFCR_BIT, 0)) {
> +	if (coresight_timeout(&csdev->access, ETB_FFCR, ETB_FFCR_BIT, 0)) {
>  		dev_err(dev,
>  		"timeout while waiting for completion of Manual Flush\n");
>  	}
> @@ -270,7 +271,7 @@ static void __etb_disable_hw(struct etb_drvdata *drvdata)
>  	/* disable trace capture */
>  	writel_relaxed(0x0, drvdata->base + ETB_CTL_REG);
>  
> -	if (coresight_timeout(drvdata->base, ETB_FFSR, ETB_FFSR_BIT, 1)) {
> +	if (coresight_timeout(&csdev->access, ETB_FFSR, ETB_FFSR_BIT, 1)) {
>  		dev_err(dev,
>  			"timeout while waiting for Formatter to Stop\n");
>  	}
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 67deb4a4e618..d78d79940fc9 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -109,6 +109,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  	int i, rc;
>  	struct etmv4_config *config = &drvdata->config;
>  	struct device *etm_dev = &drvdata->csdev->dev;
> +	struct coresight_device *csdev = drvdata->csdev;
>  
>  	CS_UNLOCK(drvdata->base);
>  
> @@ -122,7 +123,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  	writel_relaxed(0, drvdata->base + TRCPRGCTLR);
>  
>  	/* wait for TRCSTATR.IDLE to go up */
> -	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 1))
> +	if (coresight_timeout(&csdev->access, TRCSTATR, TRCSTATR_IDLE_BIT, 1))
>  		dev_err(etm_dev,
>  			"timeout while waiting for Idle Trace Status\n");
>  
> @@ -209,7 +210,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  	writel_relaxed(1, drvdata->base + TRCPRGCTLR);
>  
>  	/* wait for TRCSTATR.IDLE to go back down to '0' */
> -	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 0))
> +	if (coresight_timeout(&csdev->access, TRCSTATR, TRCSTATR_IDLE_BIT, 0))
>  		dev_err(etm_dev,
>  			"timeout while waiting for Idle Trace Status\n");
>  
> @@ -474,6 +475,7 @@ static void etm4_disable_hw(void *info)
>  	struct etmv4_drvdata *drvdata = info;
>  	struct etmv4_config *config = &drvdata->config;
>  	struct device *etm_dev = &drvdata->csdev->dev;
> +	struct coresight_device *csdev = drvdata->csdev;
>  	int i;
>  
>  	CS_UNLOCK(drvdata->base);
> @@ -500,7 +502,7 @@ static void etm4_disable_hw(void *info)
>  	writel_relaxed(control, drvdata->base + TRCPRGCTLR);
>  
>  	/* wait for TRCSTATR.PMSTABLE to go to '1' */
> -	if (coresight_timeout(drvdata->base, TRCSTATR,
> +	if (coresight_timeout(&csdev->access, TRCSTATR,
>  			      TRCSTATR_PMSTABLE_BIT, 1))
>  		dev_err(etm_dev,
>  			"timeout while waiting for PM stable Trace Status\n");
> @@ -1163,7 +1165,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
>  	etm4_os_lock(drvdata);
>  
>  	/* wait for TRCSTATR.PMSTABLE to go up */
> -	if (coresight_timeout(drvdata->base, TRCSTATR,
> +	if (coresight_timeout(&csdev->access, TRCSTATR,
>  			      TRCSTATR_PMSTABLE_BIT, 1)) {
>  		dev_err(etm_dev,
>  			"timeout while waiting for PM Stable Status\n");
> @@ -1247,7 +1249,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
>  	state->trcpdcr = readl(drvdata->base + TRCPDCR);
>  
>  	/* wait for TRCSTATR.IDLE to go up */
> -	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 1)) {
> +	if (coresight_timeout(&csdev->access, TRCSTATR, TRCSTATR_IDLE_BIT, 1)) {
>  		dev_err(etm_dev,
>  			"timeout while waiting for Idle Trace Status\n");
>  		etm4_os_unlock(drvdata);
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index c8509cc78512..b704000c96b8 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -270,7 +270,7 @@ static void stm_disable(struct coresight_device *csdev,
>  		spin_unlock(&drvdata->spinlock);
>  
>  		/* Wait until the engine has completely stopped */
> -		coresight_timeout(drvdata->base, STMTCSR, STMTCSR_BUSY_BIT, 0);
> +		coresight_timeout(&csdev->access, STMTCSR, STMTCSR_BUSY_BIT, 0);
>  
>  		pm_runtime_put(csdev->dev.parent);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index b49795ad6861..6036eb73dce8 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -33,16 +33,19 @@ DEFINE_CORESIGHT_DEVLIST(etr_devs, "tmc_etr");
>  
>  void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
>  {
> +	struct coresight_device *csdev = drvdata->csdev;
> +
>  	/* Ensure formatter, unformatter and hardware fifo are empty */
> -	if (coresight_timeout(drvdata->base,
> +	if (coresight_timeout(&csdev->access,
>  			      TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
> -		dev_err(&drvdata->csdev->dev,
> +		dev_err(&csdev->dev,
>  			"timeout while waiting for TMC to be Ready\n");
>  	}
>  }
>  
>  void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
>  {
> +	struct coresight_device *csdev = drvdata->csdev;
>  	u32 ffcr;
>  
>  	ffcr = readl_relaxed(drvdata->base + TMC_FFCR);
> @@ -51,7 +54,7 @@ void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
>  	ffcr |= BIT(TMC_FFCR_FLUSHMAN_BIT);
>  	writel_relaxed(ffcr, drvdata->base + TMC_FFCR);
>  	/* Ensure flush completes */
> -	if (coresight_timeout(drvdata->base,
> +	if (coresight_timeout(&csdev->access,
>  			      TMC_FFCR, TMC_FFCR_FLUSHMAN_BIT, 0)) {
>  		dev_err(&drvdata->csdev->dev,
>  		"timeout while waiting for completion of Manual Flush\n");
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index 84ff4bf5d3b8..282d80e97265 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -86,9 +86,9 @@ static void tpiu_disable_hw(struct csdev_access *csa)
>  	/* Generate manual flush */
>  	csdev_access_relaxed_write32(csa, FFCR_STOP_FI | FFCR_FON_MAN, TPIU_FFCR);
>  	/* Wait for flush to complete */
> -	coresight_timeout(csa->base, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
> +	coresight_timeout(csa, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
>  	/* Wait for formatter to stop */
> -	coresight_timeout(csa->base, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
> +	coresight_timeout(csa, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
>  
>  	CS_LOCK(csa->base);
>  }
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 38e9c03ab754..21e7615fcbc8 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -1338,23 +1338,26 @@ static void coresight_remove_conns(struct coresight_device *csdev)
>  }
>  
>  /**
> - * coresight_timeout - loop until a bit has changed to a specific state.
> - * @addr: base address of the area of interest.
> - * @offset: address of a register, starting from @addr.
> + * coresight_timeout - loop until a bit has changed to a specific register
> + *			state.
> + * @csa: coresight device access for the device
> + * @offset: Offset of the register from the base of the device.
>   * @position: the position of the bit of interest.
>   * @value: the value the bit should have.
>   *
>   * Return: 0 as soon as the bit has taken the desired state or -EAGAIN if
>   * TIMEOUT_US has elapsed, which ever happens first.
>   */
> -
> -int coresight_timeout(void __iomem *addr, u32 offset, int position, int value)
> +int coresight_timeout(struct csdev_access *csa,
> +		      u32 offset,
> +		      int position,
> +		      int value)
>  {
>  	int i;
>  	u32 val;
>  
>  	for (i = TIMEOUT_US; i > 0; i--) {
> -		val = __raw_readl(addr + offset);
> +		val = csdev_access_read32(csa, offset);

Here we are moving to a memory barrier access, which is probably not a bad
thing.

>  		/* waiting on the bit to go from 0 to 1 */
>  		if (value) {
>  			if (val & BIT(position))
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 81ac708689f8..2989306f6041 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -433,8 +433,10 @@ coresight_register(struct coresight_desc *desc);
>  extern void coresight_unregister(struct coresight_device *csdev);
>  extern int coresight_enable(struct coresight_device *csdev);
>  extern void coresight_disable(struct coresight_device *csdev);
> -extern int coresight_timeout(void __iomem *addr, u32 offset,
> -			     int position, int value);
> +extern int coresight_timeout(struct csdev_access *csa,
> +			     u32 offset,
> +			     int position,
> +			     int value);
>  
>  extern int coresight_claim_device(void __iomem *base);
>  extern int coresight_claim_device_unlocked(void __iomem *base);
> @@ -460,8 +462,15 @@ static inline void coresight_unregister(struct coresight_device *csdev) {}
>  static inline int
>  coresight_enable(struct coresight_device *csdev) { return -ENOSYS; }
>  static inline void coresight_disable(struct coresight_device *csdev) {}
> -static inline int coresight_timeout(void __iomem *addr, u32 offset,
> -				     int position, int value) { return 1; }
> +
> +static inline int coresight_timeout(struct csdev_access *csa,
> +				    u32 offset,
> +				    int position,
> +				    int value)
> +{
> +	return 1;
> +}

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> +
>  static inline int coresight_claim_device_unlocked(void __iomem *base)
>  {
>  	return -EINVAL;
> -- 
> 2.24.1
> 
