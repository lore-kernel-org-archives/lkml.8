Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7C4C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1293020848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="g8A6MORX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgH1DSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 23:18:44 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:63370 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727926AbgH1DSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 23:18:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598584721; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=UEO42VyviJpjklF+4LH20P/EHkLAMmboe9AHBs+ZwH8=; b=g8A6MORXr2UxoL0Ft/LnzK7FRiPJ60hzMPY9eOdFQG77KDLEOwW3kY9vC0bSzOKNQR8ix+Cf
 JxWgkwzmd7dVRGexNOp6zmYO0yRYZJcc4aWJh7hb6F5HTiYMdlCYtcK+G8dyBTjjQQOSGQZb
 8HvuFnT4tufdZWM9QOLvfwxdhr0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f4877847ea9bd29096d2472 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 28 Aug 2020 03:18:28
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CE7C4C433A0; Fri, 28 Aug 2020 03:18:27 +0000 (UTC)
Received: from codeaurora.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0411DC433CB;
        Fri, 28 Aug 2020 03:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0411DC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingweiz@codeaurora.org
Date:   Fri, 28 Aug 2020 11:18:18 +0800
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
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
Message-ID: <20200828031818.GA24177@codeaurora.org>
References: <20200818111057.19755-1-tingwei@codeaurora.org>
 <20200818111057.19755-3-tingwei@codeaurora.org>
 <20200827181253.GA22307@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827181253.GA22307@xps15>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 02:12:53AM +0800, Mathieu Poirier wrote:
> Hi Tingwei,
> 
> On Tue, Aug 18, 2020 at 07:10:57PM +0800, Tingwei Zhang wrote:
> > Deadlock as below is triggered by one CPU holds drvdata->spinlock
> > and calls cti_enable_hw(). Smp_call_function_single() is called
> > in cti_enable_hw() and tries to let another CPU write CTI registers.
> > That CPU is trying to get drvdata->spinlock in cti_cpu_pm_notify()
> > and doesn't response to IPI from smp_call_function_single().
> > 
> > [  988.335937] CPU: 6 PID: 10258 Comm: sh Tainted: G        W    L
> > 5.8.0-rc6-mainline-16783-gc38daa79b26b-dirty #1
> > [  988.346364] Hardware name: Thundercomm Dragonboard 845c (DT)
> > [  988.352073] pstate: 20400005 (nzCv daif +PAN -UAO BTYPE=--)
> > [  988.357689] pc : smp_call_function_single+0x158/0x1b8
> > [  988.362782] lr : smp_call_function_single+0x124/0x1b8
> > ...
> > [  988.451638] Call trace:
> > [  988.454119]  smp_call_function_single+0x158/0x1b8
> > [  988.458866]  cti_enable+0xb4/0xf8 [coresight_cti]
> > [  988.463618]  coresight_control_assoc_ectdev+0x6c/0x128 [coresight]
> > [  988.469855]  coresight_enable+0x1f0/0x364 [coresight]
> > [  988.474957]  enable_source_store+0x5c/0x9c [coresight]
> > [  988.480140]  dev_attr_store+0x14/0x28
> > [  988.483839]  sysfs_kf_write+0x38/0x4c
> > [  988.487532]  kernfs_fop_write+0x1c0/0x2b0
> > [  988.491585]  vfs_write+0xfc/0x300
> > [  988.494931]  ksys_write+0x78/0xe0
> > [  988.498283]  __arm64_sys_write+0x18/0x20
> > [  988.502240]  el0_svc_common+0x98/0x160
> > [  988.506024]  do_el0_svc+0x78/0x80
> > [  988.509377]  el0_sync_handler+0xd4/0x270
> > [  988.513337]  el0_sync+0x164/0x180
> > 
> 
> Was this the full log or you did cut some of it?
> 

I cut some CPU registers' value since it's too long and not relevant.
The Call trace is full.

> > This change write CTI registers directly in cti_enable_hw().
> > Config->hw_powered has been checked to be true with spinlock holded.
> > CTI is powered and can be programmed until spinlock is released.
> > 
> 
> From your explanation above it seems that cti_enable_hw() was called from,
> say
> CPUy, to enable the CTI associated to CPUx.  CTIx's drvdata->spinlock was
> taken
> and smp_call_function_single() called right after.  That woke up CPUx and
> cti_cpu_pm_notify() was executed on CPUx in interrupt context, trying to
> take
> CTIx's drvdata->spinlock.  That hung CPUx and the kernel got angry.  Is my
> assessment correct?
> 

Most of them is correct. The only difference is CPUx is power on when
cti_enable_hw() is called.  Otherwise it will goto cti_state_unchanged:
and won't call cti_enable_hw_smp_call(). cti_cpu_pm_notify() is called
when CPUx tries to suspend instead of resume.

> If so I don't think the fix suggested in this patch will work.  The same
> condition will happen whenever cti_enable_hw() is called on a CPU to
> enable a
> CTI that belongs to another CPU and that cti_cpu_pm_notify() is called on
> latter
> CPU at the same time.
> 

I'm not sure I understand this correctly.  Let me clarify it a little bit.
It's a deadlock since cti_enable_hw() holds the spinlock and calls
cti_enable_hw_smp_call() from CPUx to enable CTI associated to CPUy. It
waits for cti_enable_hw_smp_call() to return. IPI is sent to CPUy while
CPUy is in cti_cpu_pm_notify() and waits for spinlock. In this patch,
I remove cti_enable_hw_smp_call() and write CTI CPU directly on CPUx.
It won't wait for CPUy and release spinlock after program registers of
CTI. After cti_enable_hw() releases spinlock, cti_cpu_pm_notify() will
continue to run. Since spinlock is held and config->hw_powered is true,
we don't need to worry about CPUy power down when we program CTI on CPUx.

> I think a better solution is to grab the lock in cti_enable_hw() and check
> the
> value of ->ctidev.cpu.  If not a global CPU, i.e >= 0, then release the
> lock and
> call smp_call_function_single().  In cti_enable_hw_smp_call() take the
> lock
> again and move forward from there. 
> 

After cti_enable_hw() releases the lock, it's possible that CPU is offline
by user, cti_enable_hw_smp_call() will fail in this case.



> I have applied the other two patches in this set so no need to send them
> again.
>
Thanks,
Tingwei 
> Thanks,
> Mathieu
> 
> > Fixes: 6a0953ce7de9 ("coresight: cti: Add CPU idle pm notifer to CTI
> devices")
> > Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> > ---
> >  drivers/hwtracing/coresight/coresight-cti.c | 17 +----------------
> >  1 file changed, 1 insertion(+), 16 deletions(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-cti.c
> b/drivers/hwtracing/coresight/coresight-cti.c
> > index 3ccc703dc940..869569eb8c7f 100644
> > --- a/drivers/hwtracing/coresight/coresight-cti.c
> > +++ b/drivers/hwtracing/coresight/coresight-cti.c
> > @@ -86,13 +86,6 @@ void cti_write_all_hw_regs(struct cti_drvdata
> *drvdata)
> >  	CS_LOCK(drvdata->base);
> >  }
> >  
> > -static void cti_enable_hw_smp_call(void *info)
> > -{
> > -	struct cti_drvdata *drvdata = info;
> > -
> > -	cti_write_all_hw_regs(drvdata);
> > -}
> > -
> >  /* write regs to hardware and enable */
> >  static int cti_enable_hw(struct cti_drvdata *drvdata)
> >  {
> > @@ -112,15 +105,7 @@ static int cti_enable_hw(struct cti_drvdata
> *drvdata)
> >  	if (rc)
> >  		goto cti_err_not_enabled;
> >  
> > -	if (drvdata->ctidev.cpu >= 0) {
> > -		rc = smp_call_function_single(drvdata->ctidev.cpu,
> > -					      cti_enable_hw_smp_call,
> > -					      drvdata, 1);
> > -		if (rc)
> > -			goto cti_err_not_enabled;
> > -	} else {
> > -		cti_write_all_hw_regs(drvdata);
> > -	}
> > +	cti_write_all_hw_regs(drvdata);
> >  
> >  	config->hw_enabled = true;
> >  	atomic_inc(&drvdata->config.enable_req_count);
> > -- 
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum,
> > a Linux Foundation Collaborative Project
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
