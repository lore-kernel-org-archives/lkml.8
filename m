Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAF6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C4F206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="QD+yMqR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgEUJvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:51:46 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:11839 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728834AbgEUJvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:51:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590054705; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=VUInLX2WLl7cD+RkohFnAqEctPK4dVI0lt7ZdhVDzps=; b=QD+yMqR+ZGtfyNsRHAP6N/Gi24IMFdc6NX4C/yxF6sJaUWWiJJRlbhB17ITNdqVP2pW6djir
 49Ud6Bva0UGum5ntJgdLVh04/to+oePHi5YvhK8a7D4HeX5rr4fJb3OR3sujkjyAK1ikvbkD
 GJsNcLbkrNL+DO0tZrXgHNEPmpc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec64f24.7f2addeafa08-smtp-out-n01;
 Thu, 21 May 2020 09:51:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 52DFBC433CA; Thu, 21 May 2020 09:51:32 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2E77C433C6;
        Thu, 21 May 2020 09:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2E77C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Thu, 21 May 2020 15:21:25 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Liang Chen <cl@rock-chips.com>
Subject: Re: [PATCH] kthread: Use TASK_IDLE state for newly created kernel
 threads
Message-ID: <20200521095125.GD31725@codeaurora.org>
References: <1589975710-9283-1-git-send-email-pkondeti@codeaurora.org>
 <20200520181858.GA343493@kroah.com>
 <20200521013544.GC31725@codeaurora.org>
 <20200521055639.GA2337399@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521055639.GA2337399@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 07:56:39AM +0200, Greg Kroah-Hartman wrote:
> On Thu, May 21, 2020 at 07:05:44AM +0530, Pavan Kondeti wrote:
> > On Wed, May 20, 2020 at 08:18:58PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, May 20, 2020 at 05:25:09PM +0530, Pavankumar Kondeti wrote:
> > > > When kernel threads are created for later use, they will be in
> > > > TASK_UNINTERRUPTIBLE state until they are woken up. This results
> > > > in increased loadavg and false hung task reports. To fix this,
> > > > use TASK_IDLE state instead of TASK_UNINTERRUPTIBLE when
> > > > a kernel thread schedules out for the first time.
> > > > 
> > > > Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
> > > > ---
> > > >  kernel/kthread.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > > > index bfbfa48..b74ed8e 100644
> > > > --- a/kernel/kthread.c
> > > > +++ b/kernel/kthread.c
> > > > @@ -250,7 +250,7 @@ static int kthread(void *_create)
> > > >  	current->vfork_done = &self->exited;
> > > >  
> > > >  	/* OK, tell user we're spawned, wait for stop or wakeup */
> > > > -	__set_current_state(TASK_UNINTERRUPTIBLE);
> > > > +	__set_current_state(TASK_IDLE);
> > > >  	create->result = current;
> > > >  	/*
> > > >  	 * Thread is going to call schedule(), do not preempt it,
> > > > @@ -428,7 +428,7 @@ static void __kthread_bind(struct task_struct *p, unsigned int cpu, long state)
> > > >  
> > > >  void kthread_bind_mask(struct task_struct *p, const struct cpumask *mask)
> > > >  {
> > > > -	__kthread_bind_mask(p, mask, TASK_UNINTERRUPTIBLE);
> > > > +	__kthread_bind_mask(p, mask, TASK_IDLE);
> > > >  }
> > > >  
> > > >  /**
> > > > @@ -442,7 +442,7 @@ void kthread_bind_mask(struct task_struct *p, const struct cpumask *mask)
> > > >   */
> > > >  void kthread_bind(struct task_struct *p, unsigned int cpu)
> > > >  {
> > > > -	__kthread_bind(p, cpu, TASK_UNINTERRUPTIBLE);
> > > > +	__kthread_bind(p, cpu, TASK_IDLE);
> > > >  }
> > > >  EXPORT_SYMBOL(kthread_bind);
> > > 
> > > It's as if people never read mailing lists:
> > > 	https://lore.kernel.org/r/DM6PR11MB3531D3B164357B2DC476102DDFC90@DM6PR11MB3531.namprd11.prod.outlook.com
> > > 
> > > Given that this is an identical resend of the previous patch, why are
> > > you doing so, and what has changed since that original rejection?
> > > 
> > I did not know that it is attempted before. Thanks for pointing to the
> > previous discussion. 
> > 
> > We have seen hung task reports from customers and it is due to a downstream
> > change which create bunch of kernel threads for later use.
> 
> Do you have a pointer to that specific change?
> 
Here it is
https://source.codeaurora.org/quic/la/kernel/msm-4.19/commit/drivers/staging/android/ion/ion_system_heap.c?h=LA.UM.8.12.r1-11300-sm8250.0&id=0734b477f1e77cb9f91f5e5c0d7742d3113f2cd3

> > From Peter's reply, I understood that one must wake up the kthread
> > after creation and put it in INTERRUPTIBLE sleep. I will pass on the
> > message.
> 
> Just go fix that code, it sounds like it's in your tree already :)
> 
Yes, we will fix it.

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
