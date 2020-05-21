Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EC4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FFAF20756
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590062606;
	bh=LpB02I5eBFUMwM9seaNk4TqXui3r3ylDezMHPo1rCfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UX7/wdUepAG3ORWILt8O1PiEhYSSUJays5/PIy96+FCK2VKdkM8YszOr33MZ0WkVg
	 LKfhvQ/ewOGA1EwBQJgxRYNJkMEBRAQv8bC25JV3I0H9M1rgKUzeqxwdhxzceQwUpV
	 3MmfqNqJiUtC/SwlkqUKyJ+sQwHDRnEg43Ms6BoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgEUMDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 08:03:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbgEUMDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 08:03:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63AB32078B;
        Thu, 21 May 2020 12:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590062604;
        bh=LpB02I5eBFUMwM9seaNk4TqXui3r3ylDezMHPo1rCfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qNnEc0kho/7Iw6ReNSlHYUFIrUWSNjmPHvo/jqD7RFQ6lBXsowh1kPCgr7APuHFe5
         XdU+OQS63BCUUqy2HbkvO2mp+8ZWUr5FyWbLKRGjAAS98VRfiiKbvOMVIZxcqm2AuT
         8vYO5fwEUmjVxVfCCcePw9q0bt5V4Z4RAmJdnLcQ=
Date:   Thu, 21 May 2020 14:03:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Liang Chen <cl@rock-chips.com>
Subject: Re: [PATCH] kthread: Use TASK_IDLE state for newly created kernel
 threads
Message-ID: <20200521120322.GA3126694@kroah.com>
References: <1589975710-9283-1-git-send-email-pkondeti@codeaurora.org>
 <20200520181858.GA343493@kroah.com>
 <20200521013544.GC31725@codeaurora.org>
 <20200521055639.GA2337399@kroah.com>
 <20200521095125.GD31725@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521095125.GD31725@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 03:21:25PM +0530, Pavan Kondeti wrote:
> On Thu, May 21, 2020 at 07:56:39AM +0200, Greg Kroah-Hartman wrote:
> > On Thu, May 21, 2020 at 07:05:44AM +0530, Pavan Kondeti wrote:
> > > On Wed, May 20, 2020 at 08:18:58PM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, May 20, 2020 at 05:25:09PM +0530, Pavankumar Kondeti wrote:
> > > > > When kernel threads are created for later use, they will be in
> > > > > TASK_UNINTERRUPTIBLE state until they are woken up. This results
> > > > > in increased loadavg and false hung task reports. To fix this,
> > > > > use TASK_IDLE state instead of TASK_UNINTERRUPTIBLE when
> > > > > a kernel thread schedules out for the first time.
> > > > > 
> > > > > Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
> > > > > ---
> > > > >  kernel/kthread.c | 6 +++---
> > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > > > > index bfbfa48..b74ed8e 100644
> > > > > --- a/kernel/kthread.c
> > > > > +++ b/kernel/kthread.c
> > > > > @@ -250,7 +250,7 @@ static int kthread(void *_create)
> > > > >  	current->vfork_done = &self->exited;
> > > > >  
> > > > >  	/* OK, tell user we're spawned, wait for stop or wakeup */
> > > > > -	__set_current_state(TASK_UNINTERRUPTIBLE);
> > > > > +	__set_current_state(TASK_IDLE);
> > > > >  	create->result = current;
> > > > >  	/*
> > > > >  	 * Thread is going to call schedule(), do not preempt it,
> > > > > @@ -428,7 +428,7 @@ static void __kthread_bind(struct task_struct *p, unsigned int cpu, long state)
> > > > >  
> > > > >  void kthread_bind_mask(struct task_struct *p, const struct cpumask *mask)
> > > > >  {
> > > > > -	__kthread_bind_mask(p, mask, TASK_UNINTERRUPTIBLE);
> > > > > +	__kthread_bind_mask(p, mask, TASK_IDLE);
> > > > >  }
> > > > >  
> > > > >  /**
> > > > > @@ -442,7 +442,7 @@ void kthread_bind_mask(struct task_struct *p, const struct cpumask *mask)
> > > > >   */
> > > > >  void kthread_bind(struct task_struct *p, unsigned int cpu)
> > > > >  {
> > > > > -	__kthread_bind(p, cpu, TASK_UNINTERRUPTIBLE);
> > > > > +	__kthread_bind(p, cpu, TASK_IDLE);
> > > > >  }
> > > > >  EXPORT_SYMBOL(kthread_bind);
> > > > 
> > > > It's as if people never read mailing lists:
> > > > 	https://lore.kernel.org/r/DM6PR11MB3531D3B164357B2DC476102DDFC90@DM6PR11MB3531.namprd11.prod.outlook.com
> > > > 
> > > > Given that this is an identical resend of the previous patch, why are
> > > > you doing so, and what has changed since that original rejection?
> > > > 
> > > I did not know that it is attempted before. Thanks for pointing to the
> > > previous discussion. 
> > > 
> > > We have seen hung task reports from customers and it is due to a downstream
> > > change which create bunch of kernel threads for later use.
> > 
> > Do you have a pointer to that specific change?
> > 
> Here it is
> https://source.codeaurora.org/quic/la/kernel/msm-4.19/commit/drivers/staging/android/ion/ion_system_heap.c?h=LA.UM.8.12.r1-11300-sm8250.0&id=0734b477f1e77cb9f91f5e5c0d7742d3113f2cd3

Ick, ion system heaps :(

Anyway, why not just use a workqueue for this, why a full kernel thread?
What does that help with?  It also might fix those crazy hacks you have
in there for "cpu affinity" as all of that would be taken care of for
you automatically with a workqueue, right?

good luck!

greg k-h
