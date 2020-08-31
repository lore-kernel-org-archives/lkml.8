Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E588C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4500020866
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aO2bKKoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgHaU20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 16:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHaU2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 16:28:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0D3C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 13:28:23 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t11so3720697plr.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 13:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9En7x7JbZRrFESeVDk5vSGd+ic8zT9Gf1pQCbXHtUaE=;
        b=aO2bKKoRdI8m8EmbE0GjDrN4DieV/ymql4UqNNnRHdMcTeHj+sCz+mYW1PvIzNTbRp
         V8RFdHOWpCs2exX6IqftbDXL8Ip9/eli9Kpsjm7nMxtyteEkhcN5TkW+xo8QucR7iQhy
         RvSPkYp1RGEuBA2omvagLxvae1D6sNURG3AiY6PlkeN5dydSd41seEbSE0e9DzvPkrTK
         EJjDG1eyfoDjTfi8MBmcHVouWV8AYPxr/GfVg3KnKOYPCsgzgz955XUGKDAv08C/mlSk
         SrBlYWItQ/pMkz+kgTXIgddf+kqTFc3VM0DkilQozqIxnkTNsw/XA0i0pW+LCBDvr1m5
         dfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9En7x7JbZRrFESeVDk5vSGd+ic8zT9Gf1pQCbXHtUaE=;
        b=WzELAYB/70aMpa/441n+6a83vzVclUvjKMNrqtyGcULS17j7PmfekooR+ShsOW61W8
         jdaEkf8eWGtDFUOLKC0WvMovTZ9K5HwLlDz0w1aDGFoQGjhb2NaZ33CjlsrjnHS7fnHI
         NfRtNx+VWvNJuZcbp21xgWoJ+93HhK2lsw1ElLo72A/gRyowxVRUyG13do7SUB2r4CZy
         TbKNKf3NINZDB8odCVU/zb6jIMyqR5Vh1BYRCnZZ3cihpbNQN4EzuOu3SoqCZx8bT16G
         9SUOJ7Ay/P3dVaq+u0ejIxPDvBx8VP7yY2gc3NMbN9pHqikQu4305uctLkvOevdFa6n1
         Vbtw==
X-Gm-Message-State: AOAM533afg+zQLU+LOeKXTBImDw0cxAPj4IO9V8i8n5fk7Ir8tklBiJK
        fyUOmCfoLJ5muJXTn+IeL7+yGcku5mxezg==
X-Google-Smtp-Source: ABdhPJyCpw632CLHeiKtO04/yGZUSihFuhbn6xAlVY396s3HrOpEjxZ7ZhpE6M8p3GSMKn2in2cSyg==
X-Received: by 2002:a17:902:bd43:: with SMTP id b3mr2261776plx.276.1598905702642;
        Mon, 31 Aug 2020 13:28:22 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id e66sm8402735pfa.130.2020.08.31.13.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 13:28:21 -0700 (PDT)
Date:   Mon, 31 Aug 2020 14:28:19 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tingwei Zhang <tingweiz@codeaurora.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH] coresight: cti: write regsiters directly in
 cti_enable_hw()
Message-ID: <20200831202819.GB119959@xps15>
References: <20200818111057.19755-1-tingwei@codeaurora.org>
 <20200818111057.19755-3-tingwei@codeaurora.org>
 <20200827181253.GA22307@xps15>
 <20200828031818.GA24177@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828031818.GA24177@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 11:18:18AM +0800, Tingwei Zhang wrote:
> On Fri, Aug 28, 2020 at 02:12:53AM +0800, Mathieu Poirier wrote:
> > Hi Tingwei,
> > 
> > On Tue, Aug 18, 2020 at 07:10:57PM +0800, Tingwei Zhang wrote:
> > > Deadlock as below is triggered by one CPU holds drvdata->spinlock
> > > and calls cti_enable_hw(). Smp_call_function_single() is called
> > > in cti_enable_hw() and tries to let another CPU write CTI registers.
> > > That CPU is trying to get drvdata->spinlock in cti_cpu_pm_notify()
> > > and doesn't response to IPI from smp_call_function_single().
> > > 
> > > [  988.335937] CPU: 6 PID: 10258 Comm: sh Tainted: G        W    L
> > > 5.8.0-rc6-mainline-16783-gc38daa79b26b-dirty #1
> > > [  988.346364] Hardware name: Thundercomm Dragonboard 845c (DT)
> > > [  988.352073] pstate: 20400005 (nzCv daif +PAN -UAO BTYPE=--)
> > > [  988.357689] pc : smp_call_function_single+0x158/0x1b8
> > > [  988.362782] lr : smp_call_function_single+0x124/0x1b8
> > > ...
> > > [  988.451638] Call trace:
> > > [  988.454119]  smp_call_function_single+0x158/0x1b8
> > > [  988.458866]  cti_enable+0xb4/0xf8 [coresight_cti]
> > > [  988.463618]  coresight_control_assoc_ectdev+0x6c/0x128 [coresight]
> > > [  988.469855]  coresight_enable+0x1f0/0x364 [coresight]
> > > [  988.474957]  enable_source_store+0x5c/0x9c [coresight]
> > > [  988.480140]  dev_attr_store+0x14/0x28
> > > [  988.483839]  sysfs_kf_write+0x38/0x4c
> > > [  988.487532]  kernfs_fop_write+0x1c0/0x2b0
> > > [  988.491585]  vfs_write+0xfc/0x300
> > > [  988.494931]  ksys_write+0x78/0xe0
> > > [  988.498283]  __arm64_sys_write+0x18/0x20
> > > [  988.502240]  el0_svc_common+0x98/0x160
> > > [  988.506024]  do_el0_svc+0x78/0x80
> > > [  988.509377]  el0_sync_handler+0xd4/0x270
> > > [  988.513337]  el0_sync+0x164/0x180
> > > 
> > 
> > Was this the full log or you did cut some of it?
> > 
> 
> I cut some CPU registers' value since it's too long and not relevant.
> The Call trace is full.
> 
> > > This change write CTI registers directly in cti_enable_hw().
> > > Config->hw_powered has been checked to be true with spinlock holded.
> > > CTI is powered and can be programmed until spinlock is released.
> > > 
> > 
> > From your explanation above it seems that cti_enable_hw() was called from,
> > say
> > CPUy, to enable the CTI associated to CPUx.  CTIx's drvdata->spinlock was
> > taken
> > and smp_call_function_single() called right after.  That woke up CPUx and
> > cti_cpu_pm_notify() was executed on CPUx in interrupt context, trying to
> > take
> > CTIx's drvdata->spinlock.  That hung CPUx and the kernel got angry.  Is my
> > assessment correct?
> > 
> 
> Most of them is correct. The only difference is CPUx is power on when
> cti_enable_hw() is called.  Otherwise it will goto cti_state_unchanged:
> and won't call cti_enable_hw_smp_call(). cti_cpu_pm_notify() is called
> when CPUx tries to suspend instead of resume.
> 
> > If so I don't think the fix suggested in this patch will work.  The same
> > condition will happen whenever cti_enable_hw() is called on a CPU to
> > enable a
> > CTI that belongs to another CPU and that cti_cpu_pm_notify() is called on
> > latter
> > CPU at the same time.
> > 
> 
> I'm not sure I understand this correctly.  Let me clarify it a little bit.
> It's a deadlock since cti_enable_hw() holds the spinlock and calls
> cti_enable_hw_smp_call() from CPUx to enable CTI associated to CPUy. It
> waits for cti_enable_hw_smp_call() to return. IPI is sent to CPUy while
> CPUy is in cti_cpu_pm_notify() and waits for spinlock. In this patch,
> I remove cti_enable_hw_smp_call() and write CTI CPU directly on CPUx.
> It won't wait for CPUy and release spinlock after program registers of
> CTI. After cti_enable_hw() releases spinlock, cti_cpu_pm_notify() will
> continue to run. Since spinlock is held and config->hw_powered is true,
> we don't need to worry about CPUy power down when we program CTI on CPUx.
> 
> > I think a better solution is to grab the lock in cti_enable_hw() and check
> > the
> > value of ->ctidev.cpu.  If not a global CPU, i.e >= 0, then release the
> > lock and
> > call smp_call_function_single().  In cti_enable_hw_smp_call() take the
> > lock
> > again and move forward from there. 
> > 
> 
> After cti_enable_hw() releases the lock, it's possible that CPU is offline
> by user, cti_enable_hw_smp_call() will fail in this case.
> 
>

I took another look at your solution and you are correct, CPUy won't lock but
rather spin waiting for cti_enable_hw() to finish on CPUx.  To make sure CPUx is
not interrupted while executing cti_enable_hw() I suggest to use
spin_lock_irq().

Thanks,
Mathieu
 
> 
> > I have applied the other two patches in this set so no need to send them
> > again.
> >
> Thanks,
> Tingwei 
> > Thanks,
> > Mathieu
> > 
> > > Fixes: 6a0953ce7de9 ("coresight: cti: Add CPU idle pm notifer to CTI
> > devices")
> > > Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> > > ---
> > >  drivers/hwtracing/coresight/coresight-cti.c | 17 +----------------
> > >  1 file changed, 1 insertion(+), 16 deletions(-)
> > > 
> > > diff --git a/drivers/hwtracing/coresight/coresight-cti.c
> > b/drivers/hwtracing/coresight/coresight-cti.c
> > > index 3ccc703dc940..869569eb8c7f 100644
> > > --- a/drivers/hwtracing/coresight/coresight-cti.c
> > > +++ b/drivers/hwtracing/coresight/coresight-cti.c
> > > @@ -86,13 +86,6 @@ void cti_write_all_hw_regs(struct cti_drvdata
> > *drvdata)
> > >  	CS_LOCK(drvdata->base);
> > >  }
> > >  
> > > -static void cti_enable_hw_smp_call(void *info)
> > > -{
> > > -	struct cti_drvdata *drvdata = info;
> > > -
> > > -	cti_write_all_hw_regs(drvdata);
> > > -}
> > > -
> > >  /* write regs to hardware and enable */
> > >  static int cti_enable_hw(struct cti_drvdata *drvdata)
> > >  {
> > > @@ -112,15 +105,7 @@ static int cti_enable_hw(struct cti_drvdata
> > *drvdata)
> > >  	if (rc)
> > >  		goto cti_err_not_enabled;
> > >  
> > > -	if (drvdata->ctidev.cpu >= 0) {
> > > -		rc = smp_call_function_single(drvdata->ctidev.cpu,
> > > -					      cti_enable_hw_smp_call,
> > > -					      drvdata, 1);
> > > -		if (rc)
> > > -			goto cti_err_not_enabled;
> > > -	} else {
> > > -		cti_write_all_hw_regs(drvdata);
> > > -	}
> > > +	cti_write_all_hw_regs(drvdata);
> > >  
> > >  	config->hw_enabled = true;
> > >  	atomic_inc(&drvdata->config.enable_req_count);
> > > -- 
> > > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> > Forum,
> > > a Linux Foundation Collaborative Project
> > > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
