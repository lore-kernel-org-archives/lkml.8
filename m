Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61005C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26182207DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XRwcRRk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgH0TRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgH0TR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:17:29 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD8DC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 12:17:28 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t185so4236478pfd.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 12:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MZnMLLxrSfp8fEhUROz1p+oMco6agcplAct9ldeRkcQ=;
        b=XRwcRRk0B2YUy1eV4DK/hYZrDLOUrNQDEmJanHg703TdZtRnwAsX7vl/XRxPrzvzp9
         dX5hvS3iNOcPOCV//7C984XvMJF8lzbvE8IwCgG6FFFoVNmcjshl/gRlq33cdPYJ+HDC
         Vo55lFX412x+IiIOfOmTd51c1V3fh6HDDSoD574i0Gij0V5EOtvbIVI2t5cCBRNARZAN
         aks8CQ1AHOYIus1JUkSyz5y3j+LXPxxYMJgAeXb1Rux+R7DF1mYShc8YND0REJPJNjUf
         DxChokOtFWcRvgnXVd7oSqmO2dq0ZKpTdJ5DS1GXy3DA9nXu2MepMoEK11h3ouJmLIes
         o3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MZnMLLxrSfp8fEhUROz1p+oMco6agcplAct9ldeRkcQ=;
        b=IjlKoHnolnMcAR3brrE8wYPg4XNM44UIY18p9bCLSblpYEy+WkW00ND8+SJpB0Gdb4
         HI1bnOMyCQifOhGr1dBU/rhOshyW3/gIls7Kh7Y9Ur0AI7bG+u28kRXWo1CorYihyHbn
         D7xtvGRcsVrr7AbqwqDQDYRd5N2AQnCOleyrOTqoFLWX8g5Nac4IEcCugperBBlyrweg
         6+3MoMmZnAH5NtPe83AR6+FbVNvySXLPAlyMHbWo66hddfzxyzWkgS92e/R2tTqY92tL
         mTdnzZiWg5Lbw2XrN+RVYPTDYlQfzpDMcZLZ6gMBg4Jkd/WXk7xX3BWEdmWSa08JGnVD
         rG6g==
X-Gm-Message-State: AOAM533Nb5WsTDqVE6MOMjC9DDM1uvS0vu+utmfhVKXd/sb/zztadwE0
        rnlV3hWMxIsYkecQOZ7HmalAuQ==
X-Google-Smtp-Source: ABdhPJxcHxfs2QqIjlexvmRMTdkDKdJ61ryzzX9s6hNc9e2JkHVHF2KoTh+tvql7sNm1kzSu7hvCSg==
X-Received: by 2002:aa7:9347:: with SMTP id 7mr11127420pfn.71.1598555847634;
        Thu, 27 Aug 2020 12:17:27 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l21sm3077549pgb.35.2020.08.27.12.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 12:17:27 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:17:25 -0600
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
Subject: Re: [PATCH] coresight: cti: write regsiters directly in
 cti_enable_hw()
Message-ID: <20200827191725.GB22307@xps15>
References: <20200818111057.19755-1-tingwei@codeaurora.org>
 <20200818111057.19755-3-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818111057.19755-3-tingwei@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 07:10:57PM +0800, Tingwei Zhang wrote:
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
>  drivers/hwtracing/coresight/coresight-cti.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
> index 3ccc703dc940..869569eb8c7f 100644
> --- a/drivers/hwtracing/coresight/coresight-cti.c
> +++ b/drivers/hwtracing/coresight/coresight-cti.c
> @@ -86,13 +86,6 @@ void cti_write_all_hw_regs(struct cti_drvdata *drvdata)
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
> @@ -112,15 +105,7 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
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

I forgot...  Looking at the code in cti_enable_hw() the claim tags are not
released in the event that smp_call_function_single() fails.  Please address
that as part of refactoring the function. 

Thanks,
Mathieu

>  
>  	config->hw_enabled = true;
>  	atomic_inc(&drvdata->config.enable_req_count);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
