Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E31C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 314FA206A5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UhActaLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgICQxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgICQxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:53:10 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAFEC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 09:53:09 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z19so627074pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 09:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TJTN3gCTPESSmVwrCp1an72OL6SfiXHnSvIgbEJXywg=;
        b=UhActaLSXfkpPUb4loXWQjaBZDSK2Ys69CEY3lUo0aBtsQyYgn1tcvXJcjU6Ki+9C3
         vHJAzx12Bro9yogsHodJYon12IoYwNBwkAJusy4FIaRwW2rBXwR6tEQlyGCdgWGpu8mq
         XVuTxO8pre37jUyWTOtAuDN71tpt7URdPbT7nIbA28qxPgCG02w4cKrpnwK1IuEYBjtE
         KDRiEvgAvmErptdaXy9HReTw3/UHL8ckX4dYl2/TAwQedhGgORqSOYkabZbWMOYuASZs
         m8KxVeeTyQHoKZVlUpDOhVto1cWe8ouPYlGi+UuhP4F7eJQ3ZFQby03R9QdZuU7HNGeD
         BzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TJTN3gCTPESSmVwrCp1an72OL6SfiXHnSvIgbEJXywg=;
        b=koyoS8/0jWNME+4dKQkhw8IB3Al/3DxrWJoiLmyqaKLDP7h0KG9pFCN7TBxbb0kqJP
         XY+XnRpKP6x2fImrfvYyUiULz6/XYbZId8Gj9NWLAWhOeoIs0VRYm5x6Qr5uS1AXRkSr
         GDVFEHgm8u+3NGh5jyKX3aKaM+0xOnf7TYO7FdZJm75uElt50+YRinRzkEuaX1ZjBtvt
         0CVyaAweysIK8KRGg2D4Rou1oA9RpcGhs581WcHzUJXaFwnenXPAFvA5xbTA5OrLzFYh
         LHwbxdU9uenyOpWcfavqWLc3vKFs3nmaGcosOLDeZqntpviAl/O3UZl38vWgF0dvlsUP
         V5DA==
X-Gm-Message-State: AOAM5311KU+XJZphxaFYtuCgRYzfTOGIAexjdnkHHxtK/1kUL5whyvRH
        klvg5XmDG2uyrnbl/WtSr29nQA==
X-Google-Smtp-Source: ABdhPJzA6a8gUPSmXGxBrNaiiIC4ahPMLQsU2l7och6+cQ/9FOUfhFg4T3S48b0zftln9QNclIbBCg==
X-Received: by 2002:a63:ca0c:: with SMTP id n12mr728634pgi.209.1599151989327;
        Thu, 03 Sep 2020 09:53:09 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l1sm3350340pgo.11.2020.09.03.09.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 09:53:08 -0700 (PDT)
Date:   Thu, 3 Sep 2020 10:53:06 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Leach <mike.leach@linaro.org>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] coresight: cti: write regsiters directly in
 cti_enable_hw()
Message-ID: <20200903165306.GA312784@xps15>
References: <20200901063309.13739-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901063309.13739-1-tingwei@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 02:33:09PM +0800, Tingwei Zhang wrote:
> Deadlock as below is triggered by one CPU holds drvdata->spinlock
> and calls cti_enable_hw(). Smp_call_function_single() is called
> in cti_enable_hw() and tries to let another CPU write CTI registers.
> That CPU is trying to get drvdata->spinlock in cti_cpu_pm_notify()
> and doesn't response to IPI from smp_call_function_single().
> 
> [  988.335937] CPU: 6 PID: 10258 Comm: sh Tainted: G        W    L
> 5.8.0-rc6-mainline-16783-gc38daa79b26b-dirty #1
> [  988.346364] Hardware name: Thundercomm Dragonboard 845c (DT)
> [  988.352073] pstate: 20400005 (nzCv daif +PAN -UAO BTYPE=--)
> [  988.357689] pc : smp_call_function_single+0x158/0x1b8
> [  988.362782] lr : smp_call_function_single+0x124/0x1b8
> ...
> [  988.451638] Call trace:
> [  988.454119]  smp_call_function_single+0x158/0x1b8
> [  988.458866]  cti_enable+0xb4/0xf8 [coresight_cti]
> [  988.463618]  coresight_control_assoc_ectdev+0x6c/0x128 [coresight]
> [  988.469855]  coresight_enable+0x1f0/0x364 [coresight]
> [  988.474957]  enable_source_store+0x5c/0x9c [coresight]
> [  988.480140]  dev_attr_store+0x14/0x28
> [  988.483839]  sysfs_kf_write+0x38/0x4c
> [  988.487532]  kernfs_fop_write+0x1c0/0x2b0
> [  988.491585]  vfs_write+0xfc/0x300
> [  988.494931]  ksys_write+0x78/0xe0
> [  988.498283]  __arm64_sys_write+0x18/0x20
> [  988.502240]  el0_svc_common+0x98/0x160
> [  988.506024]  do_el0_svc+0x78/0x80
> [  988.509377]  el0_sync_handler+0xd4/0x270
> [  988.513337]  el0_sync+0x164/0x180
> 
> This change write CTI registers directly in cti_enable_hw().
> Config->hw_powered has been checked to be true with spinlock holded.
> CTI is powered and can be programmed until spinlock is released.
> 
> Fixes: 6a0953ce7de9 ("coresight: cti: Add CPU idle pm notifer to CTI devices")
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> ---
>  drivers/hwtracing/coresight/coresight-cti.c | 24 +++++----------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
> index c4e9cc7034ab..d04181c12a7f 100644
> --- a/drivers/hwtracing/coresight/coresight-cti.c
> +++ b/drivers/hwtracing/coresight/coresight-cti.c
> @@ -86,22 +86,16 @@ void cti_write_all_hw_regs(struct cti_drvdata *drvdata)
>  	CS_LOCK(drvdata->base);
>  }
>  
> -static void cti_enable_hw_smp_call(void *info)
> -{
> -	struct cti_drvdata *drvdata = info;
> -
> -	cti_write_all_hw_regs(drvdata);
> -}
> -
>  /* write regs to hardware and enable */
>  static int cti_enable_hw(struct cti_drvdata *drvdata)
>  {
>  	struct cti_config *config = &drvdata->config;
>  	struct device *dev = &drvdata->csdev->dev;
>  	int rc = 0;
> +	unsigned long flags;

I have moved this line before "int rc = 0;" and applied your patch.

Thanks,
Mathieu


>  
>  	pm_runtime_get_sync(dev->parent);
> -	spin_lock(&drvdata->spinlock);
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
>  
>  	/* no need to do anything if enabled or unpowered*/
>  	if (config->hw_enabled || !config->hw_powered)
> @@ -112,19 +106,11 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
>  	if (rc)
>  		goto cti_err_not_enabled;
>  
> -	if (drvdata->ctidev.cpu >= 0) {
> -		rc = smp_call_function_single(drvdata->ctidev.cpu,
> -					      cti_enable_hw_smp_call,
> -					      drvdata, 1);
> -		if (rc)
> -			goto cti_err_not_enabled;
> -	} else {
> -		cti_write_all_hw_regs(drvdata);
> -	}
> +	cti_write_all_hw_regs(drvdata);
>  
>  	config->hw_enabled = true;
>  	atomic_inc(&drvdata->config.enable_req_count);
> -	spin_unlock(&drvdata->spinlock);
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  	return rc;
>  
>  cti_state_unchanged:
> @@ -132,7 +118,7 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
>  
>  	/* cannot enable due to error */
>  cti_err_not_enabled:
> -	spin_unlock(&drvdata->spinlock);
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  	pm_runtime_put(dev->parent);
>  	return rc;
>  }
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
