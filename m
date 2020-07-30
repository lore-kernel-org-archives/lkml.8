Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB645C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7996F2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CgCiBsww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbgG3Tyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 15:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgG3Tyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 15:54:54 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1410FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 12:54:54 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w17so15128025ply.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 12:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yyzSKi/92J/XB13M5qENdVqPpRJq0F/iHV6KqaUjmAM=;
        b=CgCiBswwGChtugBf4Oy0DeP8+WA0b4efhYGfV2R70OfsSL2H84ioAS3UwRV8fZoogq
         sVOHML+Sj14dLSNU49VVcGUwwWKO6O6n7nGRCE6uM1tr5uH+09e1S35q4WdQjMEXZSGn
         7YaGFM1Yl7lqQmtgd5on0yJI21RiDmLt8qxD0KGjA72ExRwH6Pi2+024HpEG6BgV4tKF
         9heg7h9/NeGbMlpnM5JVe0tCcESnFKRjY5bS3c88yLgOwh/5ALvByZ79L8pZnRZL9qji
         LYAb+0HRpWzMG6t9Qx0aP/eOTrW5BZuNHPNRz51BKuxMKujBOKhMlnrBRIU2n7pV6ey6
         tqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yyzSKi/92J/XB13M5qENdVqPpRJq0F/iHV6KqaUjmAM=;
        b=YJH/5Iaw1Z8ZGREK5gI01XkZnFsiKXf7TroVlBGWc3Nwg5MCbi39EnvKxLhcYgtYR7
         5JiWTDC4uKhbolgHFeImf7WBN052k6PrcTmLz4/M+cVcEZhFs92L4VwvaRFg9gMi3ErY
         SgDKFZXZ5kDllia52a6iWZde9xlTKg9Xh/tYkhyBNsKNC8UhTUm3CGvlqqHK/yWtXOzo
         1wd/6VYbFraO12zR27KhgGBl9TfF/EePlydi42ouhpcjgZwg0TM95oGRMIep4nfj2xzY
         lWYbyxrmlXfYuc1HlpEaH0u0hM7/WILDaL2qie6JQSGwZ0+ggJ42yV3ngXB/nOwAZi1m
         FxFg==
X-Gm-Message-State: AOAM531sezu9uasNFgzI3ZsW34QiTaK9txsn8SyrktihkqsJFaPf0wlM
        CaMjczfw9N62kvN/S5u8SomRxbZXtc0=
X-Google-Smtp-Source: ABdhPJzUfBlWTNEkrUROuoHDwo9qh3PsVbdQGAG7ZS0B5fmBXswykoTSdJ94qBPvwtzwanTHfqYPZw==
X-Received: by 2002:a63:3681:: with SMTP id d123mr483442pga.317.1596138892977;
        Thu, 30 Jul 2020 12:54:52 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id n2sm6973812pgv.37.2020.07.30.12.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 12:54:52 -0700 (PDT)
Date:   Thu, 30 Jul 2020 13:54:50 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, coresight@lists.linaro.org
Subject: Re: [RFC PATCH 06/14] coresight: Convert claim and lock operations
 to use access wrappers
Message-ID: <20200730195450.GC3155687@xps15>
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
 <20200722172040.1299289-7-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722172040.1299289-7-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 06:20:32PM +0100, Suzuki K Poulose wrote:
> Convert the CoreSight CLAIM set/clear, LOCK/UNLOCK operations to
> use the coresight device access abstraction.
> 
> Mostly a mechanical change.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-catu.c  | 14 ++--
>  .../hwtracing/coresight/coresight-cpu-debug.c | 26 ++++++--
>  .../hwtracing/coresight/coresight-cti-sysfs.c |  4 +-
>  drivers/hwtracing/coresight/coresight-cti.c   | 30 +++++----
>  drivers/hwtracing/coresight/coresight-etb10.c | 20 +++---
>  .../coresight/coresight-etm3x-sysfs.c         |  8 +--
>  drivers/hwtracing/coresight/coresight-etm3x.c | 44 ++++++++-----
>  drivers/hwtracing/coresight/coresight-etm4x.c | 44 ++++++++-----
>  .../hwtracing/coresight/coresight-funnel.c    | 18 ++---
>  drivers/hwtracing/coresight/coresight-priv.h  |  9 +--
>  .../coresight/coresight-replicator.c          | 27 +++++---
>  drivers/hwtracing/coresight/coresight-stm.c   | 46 ++++++++-----
>  .../hwtracing/coresight/coresight-tmc-etf.c   | 36 ++++++----
>  .../hwtracing/coresight/coresight-tmc-etr.c   | 19 +++---
>  drivers/hwtracing/coresight/coresight-tpiu.c  |  9 +--
>  drivers/hwtracing/coresight/coresight.c       | 66 +++++++++++--------
>  include/linux/coresight.h                     | 16 ++---
>  17 files changed, 266 insertions(+), 170 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index 30f037d4549d..2918d0a4fe2e 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -411,6 +411,7 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
>  	u32 control, mode;
>  	struct etr_buf *etr_buf = data;
>  	struct device *dev = &drvdata->csdev->dev;
> +	struct coresight_device *csdev = drvdata->csdev;
>  
>  	if (catu_wait_for_ready(drvdata))
>  		dev_warn(dev, "Timeout while waiting for READY\n");
> @@ -421,7 +422,7 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
>  		return -EBUSY;
>  	}
>  
> -	rc = coresight_claim_device_unlocked(drvdata->base);
> +	rc = coresight_claim_device_unlocked(csdev);
>  	if (rc)
>  		return rc;
>  
> @@ -455,9 +456,9 @@ static int catu_enable(struct coresight_device *csdev, void *data)
>  	int rc;
>  	struct catu_drvdata *catu_drvdata = csdev_to_catu_drvdata(csdev);
>  
> -	CS_UNLOCK(catu_drvdata->base);
> +	CS_UNLOCK(&csdev->access);
>  	rc = catu_enable_hw(catu_drvdata, data);
> -	CS_LOCK(catu_drvdata->base);
> +	CS_LOCK(&csdev->access);
>  	return rc;
>  }
>  
> @@ -465,9 +466,10 @@ static int catu_disable_hw(struct catu_drvdata *drvdata)
>  {
>  	int rc = 0;
>  	struct device *dev = &drvdata->csdev->dev;
> +	struct coresight_device *csdev = drvdata->csdev;
>  
>  	catu_write_control(drvdata, 0);
> -	coresight_disclaim_device_unlocked(drvdata->base);
> +	coresight_disclaim_device_unlocked(csdev);
>  	if (catu_wait_for_ready(drvdata)) {
>  		dev_info(dev, "Timeout while waiting for READY\n");
>  		rc = -EAGAIN;
> @@ -482,9 +484,9 @@ static int catu_disable(struct coresight_device *csdev, void *__unused)
>  	int rc;
>  	struct catu_drvdata *catu_drvdata = csdev_to_catu_drvdata(csdev);
>  
> -	CS_UNLOCK(catu_drvdata->base);
> +	CS_UNLOCK(&csdev->access);
>  	rc = catu_disable_hw(catu_drvdata);
> -	CS_LOCK(catu_drvdata->base);
> +	CS_LOCK(&csdev->access);
>  	return rc;
>  }
>  
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> index 96544b348c27..efbf98c1056b 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -108,6 +108,24 @@ static bool debug_enable;
>  module_param_named(enable, debug_enable, bool, 0600);
>  MODULE_PARM_DESC(enable, "Control to enable coresight CPU debug functionality");
>  
> +static inline void debug_lock(struct debug_drvdata *drvdata)
> +{
> +	struct csdev_acces dummy = {
> +		.base	= drvdata->base,
> +	};
> +
> +	CS_LOCK(&dummy);
> +}
> +
> +static void debug_unlock(struct debug_drvdata *drvdata)
> +{
> +	struct csdev_acces dummy = {
> +		.base	= drvdata->base,
> +	};
> +
> +	CS_UNLOCK(&dummy);
> +}
> +
>  static void debug_os_unlock(struct debug_drvdata *drvdata)
>  {
>  	/* Unlocks the debug registers */
> @@ -191,7 +209,7 @@ static void debug_read_regs(struct debug_drvdata *drvdata)
>  {
>  	u32 save_edprcr;
>  
> -	CS_UNLOCK(drvdata->base);
> +	debug_unlock(drvdata);
>  
>  	/* Unlock os lock */
>  	debug_os_unlock(drvdata);
> @@ -238,7 +256,7 @@ static void debug_read_regs(struct debug_drvdata *drvdata)
>  	/* Restore EDPRCR register */
>  	writel_relaxed(save_edprcr, drvdata->base + EDPRCR);
>  
> -	CS_LOCK(drvdata->base);
> +	debug_lock(drvdata);
>  }
>  
>  #ifdef CONFIG_64BIT
> @@ -326,13 +344,13 @@ static void debug_init_arch_data(void *info)
>  	u32 mode, pcsr_offset;
>  	u32 eddevid, eddevid1;
>  
> -	CS_UNLOCK(drvdata->base);
> +	debug_unlock(drvdata);
>  
>  	/* Read device info */
>  	eddevid  = readl_relaxed(drvdata->base + EDDEVID);
>  	eddevid1 = readl_relaxed(drvdata->base + EDDEVID1);
>  
> -	CS_LOCK(drvdata->base);
> +	debug_lock(drvdata);
>  
>  	/* Parse implementation feature */
>  	mode = eddevid & EDDEVID_PCSAMPLE_MODE;
> diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> index 392757f3a019..5897ede39222 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> @@ -223,11 +223,11 @@ static ssize_t cti_reg32_show(struct device *dev, char *buf,
>  
>  	spin_lock(&drvdata->spinlock);
>  	if ((reg_offset >= 0) && cti_active(config)) {
> -		CS_UNLOCK(drvdata->base);
> +		CS_UNLOCK(&drvdata->csdev->access);
>  		val = readl_relaxed(drvdata->base + reg_offset);
>  		if (pcached_val)
>  			*pcached_val = val;
> -		CS_LOCK(drvdata->base);
> +		CS_LOCK(&drvdata->csdev->access);
>  	} else if (pcached_val) {
>  		val = *pcached_val;
>  	}
> diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
> index c810ea3ba155..bdc75aa7d71c 100644
> --- a/drivers/hwtracing/coresight/coresight-cti.c
> +++ b/drivers/hwtracing/coresight/coresight-cti.c
> @@ -60,10 +60,11 @@ DEFINE_CORESIGHT_DEVLIST(cti_sys_devs, "cti_sys");
>  /* write set of regs to hardware - call with spinlock claimed */
>  void cti_write_all_hw_regs(struct cti_drvdata *drvdata)
>  {
> +	struct coresight_device *csdev = drvdata->csdev;
>  	struct cti_config *config = &drvdata->config;
>  	int i;
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&csdev->access);
>  
>  	/* disable CTI before writing registers */
>  	writel_relaxed(0, drvdata->base + CTICONTROL);
> @@ -83,7 +84,7 @@ void cti_write_all_hw_regs(struct cti_drvdata *drvdata)
>  	/* re-enable CTI */
>  	writel_relaxed(1, drvdata->base + CTICONTROL);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  }
>  
>  static void cti_enable_hw_smp_call(void *info)
> @@ -108,7 +109,7 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
>  		goto cti_state_unchanged;
>  
>  	/* claim the device */
> -	rc = coresight_claim_device(drvdata->base);
> +	rc = coresight_claim_device(drvdata->csdev);
>  	if (rc)
>  		goto cti_err_not_enabled;
>  
> @@ -152,7 +153,7 @@ static void cti_cpuhp_enable_hw(struct cti_drvdata *drvdata)
>  		goto cti_hp_not_enabled;
>  
>  	/* try to claim the device */
> -	if (coresight_claim_device(drvdata->base))
> +	if (coresight_claim_device(drvdata->csdev))
>  		goto cti_hp_not_enabled;
>  
>  	cti_write_all_hw_regs(drvdata);
> @@ -171,6 +172,7 @@ static int cti_disable_hw(struct cti_drvdata *drvdata)
>  {
>  	struct cti_config *config = &drvdata->config;
>  	struct device *dev = &drvdata->csdev->dev;
> +	struct coresight_device *csdev = drvdata->csdev;
>  
>  	spin_lock(&drvdata->spinlock);
>  
> @@ -182,14 +184,14 @@ static int cti_disable_hw(struct cti_drvdata *drvdata)
>  	if (!config->hw_enabled || !config->hw_powered)
>  		goto cti_not_disabled;
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&csdev->access);
>  
>  	/* disable CTI */
>  	writel_relaxed(0, drvdata->base + CTICONTROL);
>  	config->hw_enabled = false;
>  
> -	coresight_disclaim_device_unlocked(drvdata->base);
> -	CS_LOCK(drvdata->base);
> +	coresight_disclaim_device_unlocked(csdev);
> +	CS_LOCK(&csdev->access);
>  	spin_unlock(&drvdata->spinlock);
>  	pm_runtime_put(dev);
>  	return 0;
> @@ -202,9 +204,9 @@ static int cti_disable_hw(struct cti_drvdata *drvdata)
>  
>  void cti_write_single_reg(struct cti_drvdata *drvdata, int offset, u32 value)
>  {
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&drvdata->csdev->access);
>  	writel_relaxed(value, drvdata->base + offset);
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&drvdata->csdev->access);
>  }
>  
>  void cti_write_intack(struct device *dev, u32 ackval)
> @@ -662,6 +664,7 @@ static int cti_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
>  			     void *v)
>  {
>  	struct cti_drvdata *drvdata;
> +	struct coresight_device *csdev;
>  	unsigned int cpu = smp_processor_id();
>  	int notify_res = NOTIFY_OK;
>  
> @@ -669,6 +672,7 @@ static int cti_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
>  		return NOTIFY_OK;
>  
>  	drvdata = cti_cpu_drvdata[cpu];
> +	csdev = drvdata->csdev;
>  
>  	if (WARN_ON_ONCE(drvdata->ctidev.cpu != cpu))
>  		return NOTIFY_BAD;
> @@ -680,13 +684,13 @@ static int cti_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
>  		/* CTI regs all static - we have a copy & nothing to save */
>  		drvdata->config.hw_powered = false;
>  		if (drvdata->config.hw_enabled)
> -			coresight_disclaim_device(drvdata->base);
> +			coresight_disclaim_device(csdev);
>  		break;
>  
>  	case CPU_PM_ENTER_FAILED:
>  		drvdata->config.hw_powered = true;
>  		if (drvdata->config.hw_enabled) {
> -			if (coresight_claim_device(drvdata->base))
> +			if (coresight_claim_device(csdev))
>  				drvdata->config.hw_enabled = false;
>  		}
>  		break;
> @@ -699,7 +703,7 @@ static int cti_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
>  		/* check enable reference count to enable HW */
>  		if (atomic_read(&drvdata->config.enable_req_count)) {
>  			/* check we can claim the device as we re-power */
> -			if (coresight_claim_device(drvdata->base))
> +			if (coresight_claim_device(csdev))
>  				goto cti_notify_exit;
>  
>  			drvdata->config.hw_enabled = true;
> @@ -742,7 +746,7 @@ static int cti_dying_cpu(unsigned int cpu)
>  
>  	spin_lock(&drvdata->spinlock);
>  	drvdata->config.hw_powered = false;
> -	coresight_disclaim_device(drvdata->base);
> +	coresight_disclaim_device(drvdata->csdev);
>  	spin_unlock(&drvdata->spinlock);
>  	return 0;
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 507f63c51be5..e375b3ee0bb5 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -107,7 +107,7 @@ static void __etb_enable_hw(struct etb_drvdata *drvdata)
>  	int i;
>  	u32 depth;
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&drvdata->csdev->access);
>  
>  	depth = drvdata->buffer_depth;
>  	/* reset write RAM pointer address */
> @@ -127,12 +127,12 @@ static void __etb_enable_hw(struct etb_drvdata *drvdata)
>  	/* ETB trace capture enable */
>  	writel_relaxed(ETB_CTL_CAPT_EN, drvdata->base + ETB_CTL_REG);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&drvdata->csdev->access);
>  }
>  
>  static int etb_enable_hw(struct etb_drvdata *drvdata)
>  {
> -	int rc = coresight_claim_device(drvdata->base);
> +	int rc = coresight_claim_device(drvdata->csdev);
>  
>  	if (rc)
>  		return rc;
> @@ -253,7 +253,7 @@ static void __etb_disable_hw(struct etb_drvdata *drvdata)
>  	struct device *dev = &drvdata->csdev->dev;
>  	struct coresight_device *csdev = drvdata->csdev;
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&csdev->access);
>  
>  	ffcr = readl_relaxed(drvdata->base + ETB_FFCR);
>  	/* stop formatter when a stop has completed */
> @@ -276,7 +276,7 @@ static void __etb_disable_hw(struct etb_drvdata *drvdata)
>  			"timeout while waiting for Formatter to Stop\n");
>  	}
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  }
>  
>  static void etb_dump_hw(struct etb_drvdata *drvdata)
> @@ -289,7 +289,7 @@ static void etb_dump_hw(struct etb_drvdata *drvdata)
>  	u32 frame_off, frame_endoff;
>  	struct device *dev = &drvdata->csdev->dev;
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&drvdata->csdev->access);
>  
>  	read_ptr = readl_relaxed(drvdata->base + ETB_RAM_READ_POINTER);
>  	write_ptr = readl_relaxed(drvdata->base + ETB_RAM_WRITE_POINTER);
> @@ -337,14 +337,14 @@ static void etb_dump_hw(struct etb_drvdata *drvdata)
>  
>  	writel_relaxed(read_ptr, drvdata->base + ETB_RAM_READ_POINTER);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&drvdata->csdev->access);
>  }
>  
>  static void etb_disable_hw(struct etb_drvdata *drvdata)
>  {
>  	__etb_disable_hw(drvdata);
>  	etb_dump_hw(drvdata);
> -	coresight_disclaim_device(drvdata->base);
> +	coresight_disclaim_device(drvdata->csdev);
>  }
>  
>  static int etb_disable(struct coresight_device *csdev)
> @@ -448,7 +448,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
>  		goto out;
>  
>  	__etb_disable_hw(drvdata);
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&drvdata->csdev->access);
>  
>  	/* unit is in words, not bytes */
>  	read_ptr = readl_relaxed(drvdata->base + ETB_RAM_READ_POINTER);
> @@ -563,7 +563,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
>  		handle->head += to_read;
>  
>  	__etb_enable_hw(drvdata);
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&drvdata->csdev->access);
>  out:
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index e8c7649f123e..362f5da90523 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -50,11 +50,11 @@ static ssize_t etmsr_show(struct device *dev,
>  
>  	pm_runtime_get_sync(dev->parent);
>  	spin_lock_irqsave(&drvdata->spinlock, flags);
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&drvdata->csdev->access);
>  
>  	val = etm_readl(drvdata, ETMSR);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&drvdata->csdev->access);
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  	pm_runtime_put(dev->parent);
>  
> @@ -948,9 +948,9 @@ static ssize_t seq_curr_state_show(struct device *dev,
>  	pm_runtime_get_sync(dev->parent);
>  	spin_lock_irqsave(&drvdata->spinlock, flags);
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&drvdata->csdev->access);
>  	val = (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&drvdata->csdev->access);
>  
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  	pm_runtime_put(dev->parent);
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index 7ddcb7fcb2d6..d6df7bc97531 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -360,10 +360,11 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
>  	int i, rc;
>  	u32 etmcr;
>  	struct etm_config *config = &drvdata->config;
> +	struct coresight_device *csdev = drvdata->csdev;
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&csdev->access);
>  
> -	rc = coresight_claim_device_unlocked(drvdata->base);
> +	rc = coresight_claim_device_unlocked(csdev);
>  	if (rc)
>  		goto done;
>  
> @@ -423,9 +424,9 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
>  	etm_clr_prog(drvdata);
>  
>  done:
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  
> -	dev_dbg(&drvdata->csdev->dev, "cpu: %d enable smp call done: %d\n",
> +	dev_dbg(&csdev->dev, "cpu: %d enable smp call done: %d\n",
>  		drvdata->cpu, rc);
>  	return rc;
>  }
> @@ -468,9 +469,9 @@ int etm_get_trace_id(struct etm_drvdata *drvdata)
>  
>  	spin_lock_irqsave(&drvdata->spinlock, flags);
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&drvdata->csdev->access);
>  	trace_id = (etm_readl(drvdata, ETMTRACEIDR) & ETM_TRACEID_MASK);
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&drvdata->csdev->access);
>  
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  	pm_runtime_put(etm_dev);
> @@ -568,8 +569,9 @@ static void etm_disable_hw(void *info)
>  	int i;
>  	struct etm_drvdata *drvdata = info;
>  	struct etm_config *config = &drvdata->config;
> +	struct coresight_device *csdev = drvdata->csdev;
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&csdev->access);
>  	etm_set_prog(drvdata);
>  
>  	/* Read back sequencer and counters for post trace analysis */
> @@ -579,22 +581,23 @@ static void etm_disable_hw(void *info)
>  		config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
>  
>  	etm_set_pwrdwn(drvdata);
> -	coresight_disclaim_device_unlocked(drvdata->base);
> +	coresight_disclaim_device_unlocked(csdev);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  
> -	dev_dbg(&drvdata->csdev->dev,
> +	dev_dbg(&csdev->dev,
>  		"cpu: %d disable smp call done\n", drvdata->cpu);
>  }
>  
>  static void etm_disable_perf(struct coresight_device *csdev)
>  {
>  	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct coresight_device *csdev;
>  
>  	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
>  		return;
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&csdev->access);
>  
>  	/* Setting the prog bit disables tracing immediately */
>  	etm_set_prog(drvdata);
> @@ -604,9 +607,9 @@ static void etm_disable_perf(struct coresight_device *csdev)
>  	 * power down the tracer.
>  	 */
>  	etm_set_pwrdwn(drvdata);
> -	coresight_disclaim_device_unlocked(drvdata->base);
> +	coresight_disclaim_device_unlocked(csdev);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  }
>  
>  static void etm_disable_sysfs(struct coresight_device *csdev)
> @@ -732,16 +735,25 @@ static bool etm_arch_supported(u8 arch)
>  	return true;
>  }
>  
> +/*
> + * This function is called even before the csdev is registered.
> + * Thus we cant rely on drvdata->csdev to be valid.
> + */
>  static void etm_init_arch_data(void *info)
>  {
>  	u32 etmidr;
>  	u32 etmccr;
> -	struct etm_drvdata *drvdata = info;
> +	int cpu;
> +	struct etm_drvdata *drvdata;
> +	struct csdev_access *csa = info;
> +
> +	cpu = smp_processor_id();
> +	drvdata = etmdrvdata[cpu];
>  
>  	/* Make sure all registers are accessible */
>  	etm_os_unlock(drvdata);
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&csa);
>  
>  	/* First dummy read */
>  	(void)etm_readl(drvdata, ETMPDSR);
> @@ -774,7 +786,7 @@ static void etm_init_arch_data(void *info)
>  
>  	etm_set_pwrdwn(drvdata);
>  	etm_clr_pwrup(drvdata);
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(csa);
>  }
>  
>  static void etm_init_trace_id(struct etm_drvdata *drvdata)
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index d78d79940fc9..ce32d4ebc8b9 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -108,14 +108,15 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  {
>  	int i, rc;
>  	struct etmv4_config *config = &drvdata->config;
> -	struct device *etm_dev = &drvdata->csdev->dev;
>  	struct coresight_device *csdev = drvdata->csdev;
> +	struct device *etm_dev = &csdev->dev;
> +	struct csdev_access *csa = &csdev->access;
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(csa);
>  
>  	etm4_os_unlock(drvdata);
>  
> -	rc = coresight_claim_device_unlocked(drvdata->base);
> +	rc = coresight_claim_device_unlocked(csdev);
>  	if (rc)
>  		goto done;
>  
> @@ -222,7 +223,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  	isb();
>  
>  done:
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(csa);
>  
>  	dev_dbg(etm_dev, "cpu: %d enable smp call done: %d\n",
>  		drvdata->cpu, rc);
> @@ -478,7 +479,7 @@ static void etm4_disable_hw(void *info)
>  	struct coresight_device *csdev = drvdata->csdev;
>  	int i;
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&csdev->access);
>  
>  	if (!drvdata->skip_power_up) {
>  		/* power can be removed from the trace unit now */
> @@ -519,11 +520,11 @@ static void etm4_disable_hw(void *info)
>  			readl_relaxed(drvdata->base + TRCCNTVRn(i));
>  	}
>  
> -	coresight_disclaim_device_unlocked(drvdata->base);
> +	coresight_disclaim_device_unlocked(csdev);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  
> -	dev_dbg(&drvdata->csdev->dev,
> +	dev_dbg(etm_dev,

Why is this change needed?

>  		"cpu: %d disable smp call done\n", drvdata->cpu);
>  }
>  
> @@ -616,8 +617,12 @@ static const struct coresight_ops etm4_cs_ops = {
>  	.source_ops	= &etm4_source_ops,
>  };
>  
> -
> -static void etm4_init_arch_data(void *__unused)
> +/*
> + * This is called before coresight device is registered. Thus
> + * we must know the access method. drvdata is already available
> + * from per-cpu area.
> + */
> +static void etm4_init_arch_data(void *info)
>  {
>  	u32 etmidr0;
>  	u32 etmidr1;
> @@ -625,6 +630,7 @@ static void etm4_init_arch_data(void *__unused)
>  	u32 etmidr3;
>  	u32 etmidr4;
>  	u32 etmidr5;
> +	struct csdev_access *csa = info;
>  	struct etmv4_drvdata *drvdata;
>  	int i, cpu;
>  
> @@ -637,7 +643,7 @@ static void etm4_init_arch_data(void *__unused)
>  	/* Make sure all registers are accessible */
>  	etm4_os_unlock(drvdata);
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(csa);
>  
>  	/* find all capabilities of the tracing unit */
>  	etmidr0 = readl_relaxed(drvdata->base + TRCIDR0);
> @@ -791,7 +797,7 @@ static void etm4_init_arch_data(void *__unused)
>  	drvdata->nrseqstate = BMVAL(etmidr5, 25, 27);
>  	/* NUMCNTR, bits[30:28] number of counters available for tracing */
>  	drvdata->nr_cntr = BMVAL(etmidr5, 28, 30);
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(csa);
>  }
>  
>  static void etm4_set_default_config(struct etmv4_config *config)
> @@ -1146,11 +1152,13 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
>  	struct etmv4_save_state *state;
>  	struct coresight_device *csdev = drvdata->csdev;
>  	struct device *etm_dev;
> +	struct csdev_access *csa;
>  
>  	if (WARN_ON(!csdev))
>  		return -ENODEV;
>  
>  	etm_dev = &csdev->dev;
> +	csa = &csdev->access;
>  
>  	/*
>  	 * As recommended by 3.4.1 ("The procedure when powering down the PE")
> @@ -1159,7 +1167,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
>  	dsb(sy);
>  	isb();
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(csa);
>  
>  	/* Lock the OS lock to disable trace and external debugger access */
>  	etm4_os_lock(drvdata);
> @@ -1268,7 +1276,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
>  			drvdata->base + TRCPDCR);
>  
>  out:
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(csa);
>  	return ret;
>  }
>  
> @@ -1277,11 +1285,13 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
>  	int i;
>  	struct etmv4_save_state *state = drvdata->save_state;
>  	struct coresight_device *csdev = drvdata->csdev;
> +	struct csdev_access *csa;
>  
>  	if (WARN_ON(!csdev))
>  		return;
>  
> -	CS_UNLOCK(drvdata->base);
> +	csa = &csdev->access;
> +	CS_UNLOCK(csa);
>  
>  	writel_relaxed(state->trcclaimset, drvdata->base + TRCCLAIMSET);
>  
> @@ -1373,7 +1383,7 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
>  
>  	/* Unlock the OS lock to re-enable trace and external debug access */
>  	etm4_os_unlock(drvdata);
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(csa);
>  }
>  
>  static int etm4_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
> @@ -1526,7 +1536,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  	etmdrvdata[drvdata->cpu] = drvdata;
>  
>  	if (smp_call_function_single(drvdata->cpu,
> -				etm4_init_arch_data,  NULL, 1))
> +				etm4_init_arch_data,  &desc.access, 1))
>  		dev_err(dev, "ETM arch init failed\n");
>  
>  	ret = etm4_pm_setup_cpuslocked();
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 67fc3e3b77d8..d61ffbfe0a5c 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -52,13 +52,14 @@ static int dynamic_funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
>  {
>  	u32 functl;
>  	int rc = 0;
> +	struct coresight_device *csdev = drvdata->csdev;
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&csdev->access);
>  
>  	functl = readl_relaxed(drvdata->base + FUNNEL_FUNCTL);
>  	/* Claim the device only when we enable the first slave */
>  	if (!(functl & FUNNEL_ENSx_MASK)) {
> -		rc = coresight_claim_device_unlocked(drvdata->base);
> +		rc = coresight_claim_device_unlocked(csdev);
>  		if (rc)
>  			goto done;
>  	}
> @@ -69,7 +70,7 @@ static int dynamic_funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
>  	writel_relaxed(functl, drvdata->base + FUNNEL_FUNCTL);
>  	writel_relaxed(drvdata->priority, drvdata->base + FUNNEL_PRICTL);
>  done:
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  	return rc;
>  }
>  
> @@ -101,8 +102,9 @@ static void dynamic_funnel_disable_hw(struct funnel_drvdata *drvdata,
>  				      int inport)
>  {
>  	u32 functl;
> +	struct coresight_device *csdev = drvdata->csdev;

Sometimes a csdev variable is declared, sometimes not as in get_funnel_ctrl_hw()
below and this makes it hard to review all these changes.  Please select a
heuristic and keep with it.  I prefer this version but not dead set on it.  

Also please split in two, on for CS_LOCK/UNLOCK() and another one for the claim
tag functions.

>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&csdev->access);
>  
>  	functl = readl_relaxed(drvdata->base + FUNNEL_FUNCTL);
>  	functl &= ~(1 << inport);
> @@ -110,9 +112,9 @@ static void dynamic_funnel_disable_hw(struct funnel_drvdata *drvdata,
>  
>  	/* Disclaim the device if none of the slaves are now active */
>  	if (!(functl & FUNNEL_ENSx_MASK))
> -		coresight_disclaim_device_unlocked(drvdata->base);
> +		coresight_disclaim_device_unlocked(csdev);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  }
>  
>  static void funnel_disable(struct coresight_device *csdev, int inport,
> @@ -173,9 +175,9 @@ static u32 get_funnel_ctrl_hw(struct funnel_drvdata *drvdata)
>  {
>  	u32 functl;
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&drvdata->csdev->access);
>  	functl = readl_relaxed(drvdata->base + FUNNEL_FUNCTL);
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&drvdata->csdev->access);
>  
>  	return functl;
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index f2dc625ea585..a87ce11a0ea6 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -108,19 +108,20 @@ static inline void coresight_insert_barrier_packet(void *buf)
>  }
>  
>  
> -static inline void CS_LOCK(void __iomem *addr)
> +static inline void CS_LOCK(struct csdev_access *csa)
>  {
>  	do {
>  		/* Wait for things to settle */
>  		mb();
> -		writel_relaxed(0x0, addr + CORESIGHT_LAR);
> +		csdev_access_relaxed_write32(csa, 0x0, CORESIGHT_LAR);
>  	} while (0);
>  }
>  
> -static inline void CS_UNLOCK(void __iomem *addr)
> +static inline void CS_UNLOCK(struct csdev_access *csa)
>  {
>  	do {
> -		writel_relaxed(CORESIGHT_UNLOCK, addr + CORESIGHT_LAR);
> +		csdev_access_relaxed_write32(csa, CORESIGHT_UNLOCK,
> +					  CORESIGHT_LAR);
>  		/* Make sure everyone has seen this */
>  		mb();
>  	} while (0);
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 65704ada20a5..4c04d819b1a6 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -45,15 +45,20 @@ struct replicator_drvdata {
>  
>  static void dynamic_replicator_reset(struct replicator_drvdata *drvdata)
>  {
> -	CS_UNLOCK(drvdata->base);
> +	struct coresight_device *csdev = drvdata->csdev;
>  
> -	if (!coresight_claim_device_unlocked(drvdata->base)) {
> +	if (WARN_ON(!csdev))
> +		return;
> +
> +	CS_UNLOCK(&csdev->access);
> +
> +	if (!coresight_claim_device_unlocked(csdev)) {
>  		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
>  		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
> -		coresight_disclaim_device_unlocked(drvdata->base);
> +		coresight_disclaim_device_unlocked(csdev);
>  	}
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  }
>  
>  /*
> @@ -70,8 +75,9 @@ static int dynamic_replicator_enable(struct replicator_drvdata *drvdata,
>  {
>  	int rc = 0;
>  	u32 id0val, id1val;
> +	struct coresight_device *csdev = drvdata->csdev;
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&csdev->access);
>  
>  	id0val = readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0);
>  	id1val = readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1);
> @@ -84,7 +90,7 @@ static int dynamic_replicator_enable(struct replicator_drvdata *drvdata,
>  		id0val = id1val = 0xff;
>  
>  	if (id0val == 0xff && id1val == 0xff)
> -		rc = coresight_claim_device_unlocked(drvdata->base);
> +		rc = coresight_claim_device_unlocked(csdev);
>  
>  	if (!rc) {
>  		switch (outport) {
> @@ -106,7 +112,7 @@ static int dynamic_replicator_enable(struct replicator_drvdata *drvdata,
>  		writel_relaxed(id1val, drvdata->base + REPLICATOR_IDFILTER1);
>  	}
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  
>  	return rc;
>  }
> @@ -140,6 +146,7 @@ static void dynamic_replicator_disable(struct replicator_drvdata *drvdata,
>  				       int inport, int outport)
>  {
>  	u32 reg;
> +	struct coresight_device *csdev = drvdata->csdev;
>  
>  	switch (outport) {
>  	case 0:
> @@ -153,15 +160,15 @@ static void dynamic_replicator_disable(struct replicator_drvdata *drvdata,
>  		return;
>  	}
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&csdev->access);
>  
>  	/* disable the flow of ATB data through port */
>  	writel_relaxed(0xff, drvdata->base + reg);
>  
>  	if ((readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0) == 0xff) &&
>  	    (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0xff))
> -		coresight_disclaim_device_unlocked(drvdata->base);
> -	CS_LOCK(drvdata->base);
> +		coresight_disclaim_device_unlocked(csdev);
> +	CS_LOCK(&csdev->access);
>  }
>  
>  static void replicator_disable(struct coresight_device *csdev, int inport,
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index b704000c96b8..112221dd6dd3 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -148,7 +148,9 @@ struct stm_drvdata {
>  
>  static void stm_hwevent_enable_hw(struct stm_drvdata *drvdata)
>  {
> -	CS_UNLOCK(drvdata->base);
> +	struct coresight_device *csdev = drvdata->csdev;
> +
> +	CS_UNLOCK(&csdev->access);
>  
>  	writel_relaxed(drvdata->stmhebsr, drvdata->base + STMHEBSR);
>  	writel_relaxed(drvdata->stmheter, drvdata->base + STMHETER);
> @@ -157,29 +159,33 @@ static void stm_hwevent_enable_hw(struct stm_drvdata *drvdata)
>  		       0x04,	/* Error detection on event tracing */
>  		       drvdata->base + STMHEMCR);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  }
>  
>  static void stm_port_enable_hw(struct stm_drvdata *drvdata)
>  {
> -	CS_UNLOCK(drvdata->base);
> +	struct coresight_device *csdev = drvdata->csdev;
> +
> +	CS_UNLOCK(&csdev->access);
>  	/* ATB trigger enable on direct writes to TRIG locations */
>  	writel_relaxed(0x10,
>  		       drvdata->base + STMSPTRIGCSR);
>  	writel_relaxed(drvdata->stmspscr, drvdata->base + STMSPSCR);
>  	writel_relaxed(drvdata->stmsper, drvdata->base + STMSPER);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  }
>  
>  static void stm_enable_hw(struct stm_drvdata *drvdata)
>  {
> +	struct coresight_device *csdev = drvdata->csdev;
> +
>  	if (drvdata->stmheer)
>  		stm_hwevent_enable_hw(drvdata);
>  
>  	stm_port_enable_hw(drvdata);
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&csdev->access);
>  
>  	/* 4096 byte between synchronisation packets */
>  	writel_relaxed(0xFFF, drvdata->base + STMSYNCR);
> @@ -188,7 +194,7 @@ static void stm_enable_hw(struct stm_drvdata *drvdata)
>  			0x01),			 /* global STM enable */
>  			drvdata->base + STMTCSR);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  }
>  
>  static int stm_enable(struct coresight_device *csdev,
> @@ -218,36 +224,41 @@ static int stm_enable(struct coresight_device *csdev,
>  
>  static void stm_hwevent_disable_hw(struct stm_drvdata *drvdata)
>  {
> -	CS_UNLOCK(drvdata->base);
> +	struct coresight_device *csdev = drvdata->csdev;
> +
> +	CS_UNLOCK(&csdev->access);
>  
>  	writel_relaxed(0x0, drvdata->base + STMHEMCR);
>  	writel_relaxed(0x0, drvdata->base + STMHEER);
>  	writel_relaxed(0x0, drvdata->base + STMHETER);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  }
>  
>  static void stm_port_disable_hw(struct stm_drvdata *drvdata)
>  {
> -	CS_UNLOCK(drvdata->base);
> +	struct coresight_device *csdev = drvdata->csdev;
> +
> +	CS_UNLOCK(&csdev->access);
>  
>  	writel_relaxed(0x0, drvdata->base + STMSPER);
>  	writel_relaxed(0x0, drvdata->base + STMSPTRIGCSR);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  }
>  
>  static void stm_disable_hw(struct stm_drvdata *drvdata)
>  {
>  	u32 val;
> +	struct coresight_device *csdev = drvdata->csdev;
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&csdev->access);
>  
>  	val = readl_relaxed(drvdata->base + STMTCSR);
>  	val &= ~0x1; /* clear global STM enable [0] */
>  	writel_relaxed(val, drvdata->base + STMTCSR);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  
>  	stm_port_disable_hw(drvdata);
>  	if (drvdata->stmheer)
> @@ -534,6 +545,8 @@ static ssize_t port_select_store(struct device *dev,
>  				 const char *buf, size_t size)
>  {
>  	struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	struct coresight_device *csdev = drvdata->csdev;
> +
>  	unsigned long val, stmsper;
>  	int ret = 0;
>  
> @@ -545,13 +558,13 @@ static ssize_t port_select_store(struct device *dev,
>  	drvdata->stmspscr = val;
>  
>  	if (local_read(&drvdata->mode)) {
> -		CS_UNLOCK(drvdata->base);
> +		CS_UNLOCK(&csdev->access);
>  		/* Process as per ARM's TRM recommendation */
>  		stmsper = readl_relaxed(drvdata->base + STMSPER);
>  		writel_relaxed(0x0, drvdata->base + STMSPER);
>  		writel_relaxed(drvdata->stmspscr, drvdata->base + STMSPSCR);
>  		writel_relaxed(stmsper, drvdata->base + STMSPER);
> -		CS_LOCK(drvdata->base);
> +		CS_LOCK(&csdev->access);
>  	}
>  	spin_unlock(&drvdata->spinlock);
>  
> @@ -581,6 +594,7 @@ static ssize_t port_enable_store(struct device *dev,
>  				 const char *buf, size_t size)
>  {
>  	struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	struct coresight_device *csdev = drvdata->csdev;
>  	unsigned long val;
>  	int ret = 0;
>  
> @@ -592,9 +606,9 @@ static ssize_t port_enable_store(struct device *dev,
>  	drvdata->stmsper = val;
>  
>  	if (local_read(&drvdata->mode)) {
> -		CS_UNLOCK(drvdata->base);
> +		CS_UNLOCK(&csdev->access);
>  		writel_relaxed(drvdata->stmsper, drvdata->base + STMSPER);
> -		CS_LOCK(drvdata->base);
> +		CS_LOCK(&csdev->access);
>  	}
>  	spin_unlock(&drvdata->spinlock);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 6375504ba8b0..00c82a6f5f4a 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -18,7 +18,9 @@ static int tmc_set_etf_buffer(struct coresight_device *csdev,
>  
>  static void __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>  {
> -	CS_UNLOCK(drvdata->base);
> +	struct coresight_device *csdev = drvdata->csdev;
> +
> +	CS_UNLOCK(&csdev->access);
>  
>  	/* Wait for TMCSReady bit to be set */
>  	tmc_wait_for_tmcready(drvdata);
> @@ -32,12 +34,12 @@ static void __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>  	writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
>  	tmc_enable_hw(drvdata);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  }
>  
>  static int tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>  {
> -	int rc = coresight_claim_device(drvdata->base);
> +	int rc = coresight_claim_device(drvdata->csdev);
>  
>  	if (rc)
>  		return rc;
> @@ -71,7 +73,9 @@ static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
>  
>  static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>  {
> -	CS_UNLOCK(drvdata->base);
> +	struct coresight_device *csdev = drvdata->csdev;
> +
> +	CS_UNLOCK(&csdev->access);
>  
>  	tmc_flush_and_stop(drvdata);
>  	/*
> @@ -82,18 +86,20 @@ static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>  		tmc_etb_dump_hw(drvdata);
>  	tmc_disable_hw(drvdata);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  }
>  
>  static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>  {
>  	__tmc_etb_disable_hw(drvdata);
> -	coresight_disclaim_device(drvdata->base);
> +	coresight_disclaim_device(drvdata->csdev);
>  }
>  
>  static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
>  {
> -	CS_UNLOCK(drvdata->base);
> +	struct coresight_device *csdev = drvdata->csdev;
> +
> +	CS_UNLOCK(&csdev->access);
>  
>  	/* Wait for TMCSReady bit to be set */
>  	tmc_wait_for_tmcready(drvdata);
> @@ -104,12 +110,12 @@ static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
>  	writel_relaxed(0x0, drvdata->base + TMC_BUFWM);
>  	tmc_enable_hw(drvdata);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  }
>  
>  static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
>  {
> -	int rc = coresight_claim_device(drvdata->base);
> +	int rc = coresight_claim_device(drvdata->csdev);
>  
>  	if (rc)
>  		return rc;
> @@ -120,12 +126,14 @@ static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
>  
>  static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
>  {
> -	CS_UNLOCK(drvdata->base);
> +	struct coresight_device *csdev = drvdata->csdev;
> +
> +	CS_UNLOCK(&csdev->access);
>  
>  	tmc_flush_and_stop(drvdata);
>  	tmc_disable_hw(drvdata);
> -	coresight_disclaim_device_unlocked(drvdata->base);
> -	CS_LOCK(drvdata->base);
> +	coresight_disclaim_device_unlocked(csdev);
> +	CS_LOCK(&csdev->access);
>  }
>  
>  /*
> @@ -464,7 +472,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
>  	if (atomic_read(csdev->refcnt) != 1)
>  		goto out;
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&csdev->access);
>  
>  	tmc_flush_and_stop(drvdata);
>  
> @@ -549,7 +557,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
>  	if (buf->snapshot)
>  		handle->head += to_read;
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  out:
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index b29c2db94d96..a9ce3be44e2c 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -952,8 +952,9 @@ static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>  {
>  	u32 axictl, sts;
>  	struct etr_buf *etr_buf = drvdata->etr_buf;
> +	struct coresight_device *csdev = drvdata->csdev;
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&csdev->access);
>  
>  	/* Wait for TMCSReady bit to be set */
>  	tmc_wait_for_tmcready(drvdata);
> @@ -995,7 +996,7 @@ static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>  	writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
>  	tmc_enable_hw(drvdata);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  }
>  
>  static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
> @@ -1021,7 +1022,7 @@ static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
>  	rc = tmc_etr_enable_catu(drvdata, etr_buf);
>  	if (rc)
>  		return rc;
> -	rc = coresight_claim_device(drvdata->base);
> +	rc = coresight_claim_device(drvdata->csdev);
>  	if (!rc) {
>  		drvdata->etr_buf = etr_buf;
>  		__tmc_etr_enable_hw(drvdata);
> @@ -1094,7 +1095,9 @@ static void tmc_etr_sync_sysfs_buf(struct tmc_drvdata *drvdata)
>  
>  static void __tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
>  {
> -	CS_UNLOCK(drvdata->base);
> +	struct coresight_device *csdev = drvdata->csdev;
> +
> +	CS_UNLOCK(&csdev->access);
>  
>  	tmc_flush_and_stop(drvdata);
>  	/*
> @@ -1106,7 +1109,7 @@ static void __tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
>  
>  	tmc_disable_hw(drvdata);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  
>  }
>  
> @@ -1115,7 +1118,7 @@ void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
>  	__tmc_etr_disable_hw(drvdata);
>  	/* Disable CATU device if this ETR is connected to one */
>  	tmc_etr_disable_catu(drvdata);
> -	coresight_disclaim_device(drvdata->base);
> +	coresight_disclaim_device(drvdata->csdev);
>  	/* Reset the ETR buf used by hardware */
>  	drvdata->etr_buf = NULL;
>  }
> @@ -1497,12 +1500,12 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
>  		goto out;
>  	}
>  
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(&csdev->access);
>  
>  	tmc_flush_and_stop(drvdata);
>  	tmc_sync_etr_buf(drvdata);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(&csdev->access);
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
>  	lost = etr_buf->full;
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index 282d80e97265..8586c015d37a 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -62,11 +62,11 @@ struct tpiu_drvdata {
>  
>  static void tpiu_enable_hw(struct csdev_access *csa)
>  {
> -	CS_UNLOCK(csa->base);
> +	CS_UNLOCK(csa);
>  
>  	/* TODO: fill this up */
>  
> -	CS_LOCK(csa->base);
> +	CS_LOCK(csa);
>  }
>  
>  static int tpiu_enable(struct coresight_device *csdev, u32 mode, void *__unused)
> @@ -79,7 +79,8 @@ static int tpiu_enable(struct coresight_device *csdev, u32 mode, void *__unused)
>  
>  static void tpiu_disable_hw(struct csdev_access *csa)
>  {
> -	CS_UNLOCK(csa->base);
> +
> +	CS_UNLOCK(csa);
>  
>  	/* Clear formatter and stop on flush */
>  	csdev_access_relaxed_write32(csa, FFCR_STOP_FI, TPIU_FFCR);
> @@ -90,7 +91,7 @@ static void tpiu_disable_hw(struct csdev_access *csa)
>  	/* Wait for formatter to stop */
>  	coresight_timeout(csa, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
>  
> -	CS_LOCK(csa->base);
> +	CS_LOCK(csa);
>  }
>  
>  static int tpiu_disable(struct coresight_device *csdev)
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 21e7615fcbc8..c1b4355d2211 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -130,30 +130,32 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
>  	return -ENODEV;
>  }
>  
> -static inline u32 coresight_read_claim_tags(void __iomem *base)
> +static inline u32 coresight_read_claim_tags(struct coresight_device *csdev)
>  {
> -	return readl_relaxed(base + CORESIGHT_CLAIMCLR);
> +	return coresight_relaxed_read32(csdev, CORESIGHT_CLAIMCLR);
>  }
>  
> -static inline bool coresight_is_claimed_self_hosted(void __iomem *base)
> +static inline bool coresight_is_claimed_self_hosted(struct coresight_device *csdev)
>  {
> -	return coresight_read_claim_tags(base) == CORESIGHT_CLAIM_SELF_HOSTED;
> +	return coresight_read_claim_tags(csdev) == CORESIGHT_CLAIM_SELF_HOSTED;
>  }
>  
> -static inline bool coresight_is_claimed_any(void __iomem *base)
> +static inline bool coresight_is_claimed_any(struct coresight_device *csdev)
>  {
> -	return coresight_read_claim_tags(base) != 0;
> +	return coresight_read_claim_tags(csdev) != 0;
>  }
>  
> -static inline void coresight_set_claim_tags(void __iomem *base)
> +static inline void coresight_set_claim_tags(struct coresight_device *csdev)
>  {
> -	writel_relaxed(CORESIGHT_CLAIM_SELF_HOSTED, base + CORESIGHT_CLAIMSET);
> +	coresight_relaxed_write32(csdev, CORESIGHT_CLAIM_SELF_HOSTED,
> +				  CORESIGHT_CLAIMSET);
>  	isb();
>  }
>  
> -static inline void coresight_clear_claim_tags(void __iomem *base)
> +static inline void coresight_clear_claim_tags(struct coresight_device *csdev)
>  {
> -	writel_relaxed(CORESIGHT_CLAIM_SELF_HOSTED, base + CORESIGHT_CLAIMCLR);
> +	coresight_relaxed_write32(csdev, CORESIGHT_CLAIM_SELF_HOSTED,
> +				  CORESIGHT_CLAIMCLR);
>  	isb();
>  }
>  
> @@ -167,26 +169,32 @@ static inline void coresight_clear_claim_tags(void __iomem *base)
>   * Called with CS_UNLOCKed for the component.
>   * Returns : 0 on success
>   */
> -int coresight_claim_device_unlocked(void __iomem *base)
> +int coresight_claim_device_unlocked(struct coresight_device *csdev)
>  {
> -	if (coresight_is_claimed_any(base))
> +	if (WARN_ON(!csdev))
> +		return -EINVAL;
> +
> +	if (coresight_is_claimed_any(csdev))
>  		return -EBUSY;
>  
> -	coresight_set_claim_tags(base);
> -	if (coresight_is_claimed_self_hosted(base))
> +	coresight_set_claim_tags(csdev);
> +	if (coresight_is_claimed_self_hosted(csdev))
>  		return 0;
>  	/* There was a race setting the tags, clean up and fail */
> -	coresight_clear_claim_tags(base);
> +	coresight_clear_claim_tags(csdev);
>  	return -EBUSY;
>  }
>  
> -int coresight_claim_device(void __iomem *base)
> +int coresight_claim_device(struct coresight_device *csdev)
>  {
>  	int rc;
>  
> -	CS_UNLOCK(base);
> -	rc = coresight_claim_device_unlocked(base);
> -	CS_LOCK(base);
> +	if (WARN_ON(!csdev))
> +		return -EINVAL;
> +
> +	CS_UNLOCK(&csdev->access);
> +	rc = coresight_claim_device_unlocked(csdev);
> +	CS_LOCK(&csdev->access);
>  
>  	return rc;
>  }
> @@ -195,11 +203,14 @@ int coresight_claim_device(void __iomem *base)
>   * coresight_disclaim_device_unlocked : Clear the claim tags for the device.
>   * Called with CS_UNLOCKed for the component.
>   */
> -void coresight_disclaim_device_unlocked(void __iomem *base)
> +void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
>  {
>  
> -	if (coresight_is_claimed_self_hosted(base))
> -		coresight_clear_claim_tags(base);
> +	if (WARN_ON(!csdev))
> +		return;
> +
> +	if (coresight_is_claimed_self_hosted(csdev))
> +		coresight_clear_claim_tags(csdev);
>  	else
>  		/*
>  		 * The external agent may have not honoured our claim
> @@ -209,11 +220,14 @@ void coresight_disclaim_device_unlocked(void __iomem *base)
>  		WARN_ON_ONCE(1);
>  }
>  
> -void coresight_disclaim_device(void __iomem *base)
> +void coresight_disclaim_device(struct coresight_device *csdev)
>  {
> -	CS_UNLOCK(base);
> -	coresight_disclaim_device_unlocked(base);
> -	CS_LOCK(base);
> +	if (WARN_ON(!csdev))
> +		return;
> +
> +	CS_UNLOCK(&csdev->access);
> +	coresight_disclaim_device_unlocked(csdev);
> +	CS_LOCK(&csdev->access);
>  }
>  
>  /* enable or disable an associated CTI device of the supplied CS device */
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 2989306f6041..c0cccdc8f9be 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -438,11 +438,11 @@ extern int coresight_timeout(struct csdev_access *csa,
>  			     int position,
>  			     int value);
>  
> -extern int coresight_claim_device(void __iomem *base);
> -extern int coresight_claim_device_unlocked(void __iomem *base);
> +extern int coresight_claim_device(struct coresight_device *csdev);
> +extern int coresight_claim_device_unlocked(struct coresight_device *csdev);
>  
> -extern void coresight_disclaim_device(void __iomem *base);
> -extern void coresight_disclaim_device_unlocked(void __iomem *base);
> +extern void coresight_disclaim_device(struct coresight_device *csdev);
> +extern void coresight_disclaim_device_unlocked(struct coresight_device *csdev);
>  extern char *coresight_alloc_device_name(struct coresight_dev_list *devs,
>  					 struct device *dev);
>  
> @@ -471,18 +471,18 @@ static inline int coresight_timeout(struct csdev_access *csa,
>  	return 1;
>  }
>  
> -static inline int coresight_claim_device_unlocked(void __iomem *base)
> +static inline int coresight_claim_device_unlocked(struct coresight_device *csdev)
>  {
>  	return -EINVAL;
>  }
>  
> -static inline int coresight_claim_device(void __iomem *base)
> +static inline int coresight_claim_device(struct coresight_device *csdev)
>  {
>  	return -EINVAL;
>  }
>  
> -static inline void coresight_disclaim_device(void __iomem *base) {}
> -static inline void coresight_disclaim_device_unlocked(void __iomem *base) {}
> +static inline void coresight_disclaim_device(struct coresight_device *csdev) {}
> +static inline void coresight_disclaim_device_unlocked(struct coresight_device *csdev) {}
>  
>  static inline bool coresight_loses_context_with_cpu(struct device *dev)
>  {
> -- 
> 2.24.1
> 
