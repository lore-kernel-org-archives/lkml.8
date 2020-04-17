Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97960C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AFED20771
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="rq9vdWmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgDQDIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 23:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgDQDIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 23:08:06 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828DCC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 20:08:06 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id b18so787301ilf.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 20:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ebTsKAwkrX51VNWdMLRx1zZug0MiTHZ+b3yQsKbwoRc=;
        b=rq9vdWmJk2u3qMtsyyfuQzbbpeXrzZmBdZgklhUivM+t1qjrHgyeR2zBJ33I9qRY2d
         V1dqA0m4yiMWdljeONwkdqswo8pNOl6nmRu1K0WXgSthyrzw6WXpUxR+snGhWTTLF2FL
         OuNLoIU7nIi7olnbrSMZY+08iCdiU/UX2ISFFsJ5BX3zmMPeNpjqlMZ0p0Kegq9pGngW
         0vKrLyuFDG0Tl4x3HFozHqCsWgVnMEnxDVPlyR7yJKIwc2nOC8q7o73TNhC/BbC+C4N5
         zhyxI7jsN+9Ju0aAhO4eBrI2SfF2n0tRu1ki2PcQV4JDrcZGEiiZxYrQFDyB0Dn9vHh7
         gNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebTsKAwkrX51VNWdMLRx1zZug0MiTHZ+b3yQsKbwoRc=;
        b=WGZRVTxtFEQ2+x3gCzxCXJsvXqaTaRp9Dhu6/c5m5hsIDExrpTe3OtBZ0vDyci/xuN
         LdYZvDN/x5tyf5kBKFzv/1S/UUknP85qfBmCQlyvKTcqHrQQvp6H9Cw/L6ycJo3C43/x
         0Z+2YQRmgUk8LlsApwKpWif98M1aVbppQ6P/DvaRsSFjThbFtvp08HjRQCMRS1+adKQf
         A8dAqilxRE5Np/iPfXehZyr+mT9DgI6k3MMXFP+qNifjvt43KzLeXn9vu7ivT/Hv82fG
         lGB8Vj8t7Y2VjMFOr4AU1fATzjsQZZjNimGF5etifnl1o0GVHdoNm4boEmZMCXcWgEW/
         Jf4g==
X-Gm-Message-State: AGi0PuZdlQtNlSKbMYEPvEcIrENmSxtQpYwbdcfOc/fhgIM05NDlhaKf
        HmNEW+7pP+WOOtFIhS7a9m4Gv01JWh++aSRYclRx+g==
X-Google-Smtp-Source: APiQypIevhTzuycK4mJxqTSE0pgj8L3/2ibOqHV+TbEy1vK87sM+9zwDMcxbCKUZ4sxDzATmvVRy5LXZKtgwIklPhJM=
X-Received: by 2002:a92:5f17:: with SMTP id t23mr1041397ilb.2.1587092885703;
 Thu, 16 Apr 2020 20:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200416141833.50663-1-songmuchun@bytedance.com> <20200416113502.53b33a1c@gandalf.local.home>
In-Reply-To: <20200416113502.53b33a1c@gandalf.local.home>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 17 Apr 2020 11:07:29 +0800
Message-ID: <CAMZfGtVxbfEi03wn_s8PSM1UiH8R-TnNSFBbx0WNyJCTma5R7A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] sched/cpuacct: Fix charge
 cpuacct.usage_sys incorrently.
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Benjamin Segall <bsegall@google.com>,
        mgorman@suse.de, mingo@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 11:35 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
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
> >       struct cpuacct *ca;
> >       int index = CPUACCT_STAT_SYSTEM;
> > -     struct pt_regs *regs = task_pt_regs(tsk);
> > +     struct pt_regs *regs = get_irq_regs();
>
> But get_irq_regs() is only available from interrupt context. This will be
> NULL most the time, whereas the original way will have regs existing for
> the task.
>
> >
> >       if (regs && user_mode(regs))
> >               index = CPUACCT_STAT_USER;
>
> To show this, I applied your patch then did the following:
>
>  # echo 'p:cpuacct cpuacct_charge+0x36 regs=%ax' > /sys/kernel/tracing/kprobe_events
>
> Where I found that the test of 'regs' is %rax at offset 0x36.
>
>  # trace-cmd start -p function -l cpuacct_charge -e kprobes
>  # trace-cmd show
> # tracer: function
> #
> # entries-in-buffer/entries-written: 70664/70664   #P:8
> #
> #                              _-----=> irqs-off
> #                             / _----=> need-resched
> #                            | / _---=> hardirq/softirq
> #                            || / _--=> preempt-depth
> #                            ||| /     delay
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>            <...>-1720  [002] d..2   306.430302: cpuacct_charge <-update_curr
>            <...>-1720  [002] d..3   306.430306: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
>            <...>-1720  [002] dN.2   306.430321: cpuacct_charge <-update_curr
>            <...>-1720  [002] dN.3   306.430322: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
>            <...>-1720  [002] d..2   306.430355: cpuacct_charge <-update_curr
>            <...>-1720  [002] d..3   306.430357: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
>             bash-1652  [006] d.h2   306.430799: cpuacct_charge <-update_curr
>             bash-1652  [006] d.h3   306.430802: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0xffffaf34012abdd8
>            <...>-199   [005] d.h2   306.430806: cpuacct_charge <-update_curr
>            <...>-199   [005] d.h3   306.430809: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0xffffaf3400347c38
>            <...>-16    [001] d..2   306.430873: cpuacct_charge <-update_curr
>            <...>-16    [001] d..3   306.430875: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
>            <...>-199   [005] d..2   306.430936: cpuacct_charge <-update_curr
>            <...>-199   [005] d..3   306.430937: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
>             bash-1652  [006] d..2   306.430944: cpuacct_charge <-update_curr
>             bash-1652  [006] d..3   306.430946: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
>             sshd-1649  [000] d..2   306.430990: cpuacct_charge <-update_curr
>             sshd-1649  [000] d..3   306.430992: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
>      rcu_preempt-10    [006] d..2   306.432844: cpuacct_charge <-update_curr
>      rcu_preempt-10    [006] d..3   306.432846: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
>      rcu_preempt-10    [006] d..2   306.436848: cpuacct_charge <-update_curr
>      rcu_preempt-10    [006] d..3   306.436850: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
>      rcu_preempt-10    [006] d..2   306.440868: cpuacct_charge <-update_curr
>      rcu_preempt-10    [006] d..3   306.440871: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
>      rcu_preempt-10    [006] d..2   306.444867: cpuacct_charge <-update_curr
>      rcu_preempt-10    [006] d..3   306.444870: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
>      kworker/2:1-127   [002] d..2   306.446925: cpuacct_charge <-update_curr
>      kworker/2:1-127   [002] d..3   306.446928: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
>      rcu_preempt-10    [006] d..2   306.448868: cpuacct_charge <-update_curr
>      rcu_preempt-10    [006] d..3   306.448870: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
>      rcu_preempt-10    [006] d..2   306.452869: cpuacct_charge <-update_curr
>      rcu_preempt-10    [006] d..3   306.452872: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
>
> The only times regs has content is from the the interrupt handler (seen as
> the 'h' in the status portion of the trace.
>
> -- Steve

Thanks for your test. You are right.

-- 
Yours,
Muchun
