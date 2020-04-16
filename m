Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C74C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B3BA214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636563AbgDPQBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506593AbgDPQBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:01:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49624214AF;
        Thu, 16 Apr 2020 16:01:34 +0000 (UTC)
Date:   Thu, 16 Apr 2020 12:01:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/cpuacct: Fix charge cpuacct.usage_sys
 incorrently.
Message-ID: <20200416120132.7c2df52a@gandalf.local.home>
In-Reply-To: <20200416113502.53b33a1c@gandalf.local.home>
References: <20200416141833.50663-1-songmuchun@bytedance.com>
        <20200416113502.53b33a1c@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 11:35:02 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 16 Apr 2020 22:18:33 +0800
> Muchun Song <songmuchun@bytedance.com> wrote:
> 
> > The user_mode(task_pt_regs(tsk)) always return true for
> > user thread, and false for kernel thread. So it means that
> > the cpuacct.usage_sys is the time that kernel thread uses
> > not the time that thread uses in the kernel mode. We can
> > use get_irq_regs() instead of task_pt_regs() to fix it.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  kernel/sched/cpuacct.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
> > index 6448b0438ffb2..edfc62554648e 100644
> > --- a/kernel/sched/cpuacct.c
> > +++ b/kernel/sched/cpuacct.c
> > @@ -5,6 +5,7 @@
> >   * Based on the work by Paul Menage (menage@google.com) and Balbir Singh
> >   * (balbir@in.ibm.com).
> >   */
> > +#include <asm/irq_regs.h>
> >  #include "sched.h"
> >  
> >  /* Time spent by the tasks of the CPU accounting group executing in ... */
> > @@ -339,7 +340,7 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
> >  {
> >  	struct cpuacct *ca;
> >  	int index = CPUACCT_STAT_SYSTEM;
> > -	struct pt_regs *regs = task_pt_regs(tsk);
> > +	struct pt_regs *regs = get_irq_regs();  
> 
> But get_irq_regs() is only available from interrupt context. This will be
> NULL most the time, whereas the original way will have regs existing for
> the task.

Perhaps you want:

	regs = get_irqs_regs();
	if (!regs)
		regs = task_pt_regs(tsk);

?

-- Steve

> 
> >  
> >  	if (regs && user_mode(regs))
> >  		index = CPUACCT_STAT_USER;  
> 
