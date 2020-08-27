Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD45C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE1622B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jN9Jy05o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgH0SM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgH0SM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:12:56 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899DAC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:12:56 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p37so3940882pgl.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fuSolVX8LC0jNf2qxLZlltK9x50zFghAwQwSG3ActBE=;
        b=jN9Jy05oArX3fILCpW2YF5bax0+prmwFcTaiTGl3kfL6GLn0ogGB5uN/as6dxdux2R
         eTM8MVBzJsrtp2jpT3HPVXETSxCTXN5BwlZ3IZ0I1/7f3u0BRuIz3piQxIXgVmUtFddt
         SNXBbJS5KUpPY2LyxzGTgNtlVdmaZgjdyOXuXZcvj1q927cUKSkis1lsyJ91E4q3KmQJ
         pd6LW8kx9SU9c5hA6Cbpydo2m51wg/+n2/vduAXNy3w6VKVcGB0rae7ECka+TL/G03CD
         cPRvoSmjese8NEvcaYViHzgZTBnIY+yPrVnTvTIL0YM9wCEsjnTlonwQv4hYkrWxdP1R
         6RoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fuSolVX8LC0jNf2qxLZlltK9x50zFghAwQwSG3ActBE=;
        b=X3Ia7e9emPaAsBMbbcIkDthjsXMnW2N3ItcInCfG7CwkEcHylFwe88wplAYWENjvZl
         msa6R2E0jn7R8QwMtaQttZE6JXOn3inq7gEkbqjjgZaN89++Ueau0wzNHisroLAXXrmF
         QcQnUuvbv/V3dcZ+3H7q7LIfnE2rWjhMjaROuajGaKklsJp4lSd8cGSLdX2trbJRRn/2
         36MkvhtnAMDRqsymV+AhHuqBxmCYXzrfCfnoXOcs+sMzuDE4FIwh78nTS/M8pBNaMrW8
         RS0g3Xh8qQCgcKpYYJn0ASi4v37TE1Bg/3yKHZVi0ZABb8VwzkszEx0fqTIbFBFpX9FF
         /bnw==
X-Gm-Message-State: AOAM533zFcwrjUQqlNSmqwUF+BSPYV0sMDdfEMbzfDqHD43Wz710ZhRC
        fUA0N4L5rjfYF0m3cKB/VeNpHw==
X-Google-Smtp-Source: ABdhPJyK3jeEl5e2q3GRKnl/94jGpsxoReBVWtVdwZ5LhZzKVkT3aB6f6DazSXG/QVS8TwHN0xY2uw==
X-Received: by 2002:a17:902:aa4c:: with SMTP id c12mr10625344plr.37.1598551976043;
        Thu, 27 Aug 2020 11:12:56 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j1sm2587382pgp.93.2020.08.27.11.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 11:12:55 -0700 (PDT)
Date:   Thu, 27 Aug 2020 12:12:53 -0600
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
Message-ID: <20200827181253.GA22307@xps15>
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

Hi Tingwei,

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

Was this the full log or you did cut some of it?

> This change write CTI registers directly in cti_enable_hw().
> Config->hw_powered has been checked to be true with spinlock holded.
> CTI is powered and can be programmed until spinlock is released.
> 

From your explanation above it seems that cti_enable_hw() was called from, say
CPUy, to enable the CTI associated to CPUx.  CTIx's drvdata->spinlock was taken
and smp_call_function_single() called right after.  That woke up CPUx and
cti_cpu_pm_notify() was executed on CPUx in interrupt context, trying to take
CTIx's drvdata->spinlock.  That hung CPUx and the kernel got angry.  Is my
assessment correct?

If so I don't think the fix suggested in this patch will work.  The same
condition will happen whenever cti_enable_hw() is called on a CPU to enable a
CTI that belongs to another CPU and that cti_cpu_pm_notify() is called on latter
CPU at the same time.

I think a better solution is to grab the lock in cti_enable_hw() and check the
value of ->ctidev.cpu.  If not a global CPU, i.e >= 0, then release the lock and
call smp_call_function_single().  In cti_enable_hw_smp_call() take the lock
again and move forward from there. 

I have applied the other two patches in this set so no need to send them again.

Thanks,
Mathieu

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
>  
>  	config->hw_enabled = true;
>  	atomic_inc(&drvdata->config.enable_req_count);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
