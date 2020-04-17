Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452F2C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19D4C217D8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="vDW6RTZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgDQDMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 23:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgDQDMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 23:12:12 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FF2C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 20:12:11 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y17so764851iow.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 20:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QOBLAztIOrx0HrNgkcdvlSt8I6nUQHvs+Fw3EKO4wCw=;
        b=vDW6RTZfPMRUlRlYV7HyGNqJSap3TCkQFviovV05imkFOLVFscmMB0vEPSONy/wTlz
         ii6YjtiL4xhbY+EgmSpgYfBQ8kGWettp4wdqI3askC7pIPKQbA10K/QjnjRZu1kIgA0Y
         l5P9HDMP8x+3TJlOP70yB1QAiWX9frd/BxXV2YlIvqj11zDMvtlDjg5bx4ORu+4n8lLi
         JGKd7NQhGMSAmxeIDBT8y38wPChGss4iKIF4XSWOHPcL20EHzCqrz7WRhiVUSPNn3MrZ
         LtpAnzRhiZvh7yeiR9C/lAWWkcDxyY5CWwNEhNWADSXI5a5zw0LNdywRNlfR/8NEqdH3
         rcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOBLAztIOrx0HrNgkcdvlSt8I6nUQHvs+Fw3EKO4wCw=;
        b=TfNsdJV+raE/tpZ4V4Gw9wbp3wYaq0t+Y2mT0A2C86WTomLNmJWJrPjFrFYaVLFf7u
         uRqH56xnEPnMBPzneqJYB+J10kavnUz/992ZtHeGx9tHjtIQrZGAnI533+AmnQPZ3LzT
         jjJ0cig9cDIWAiVc0H7PA3njIWbv2eFY0DC7BuZZ6OhCmvZpP7IbiMvcEgueLzFUaAJe
         ebqHyW8LG7BtESpKT19dlk/Swmaav1CR+fIMcGY0Gr4jD8L9xSnHvF8wqhreghCheO/F
         HYOTkuaKa/PS8dwtePMKnEIw1ww3MXBSaivybG87GbTPF2LFZGKMyHxgZ0QM6goID/Wl
         QnJw==
X-Gm-Message-State: AGi0PuanbRStKQD1x64XUxz7v++OXeiwCP1IFECwZdPQPEoK/ZTE7I2c
        lP6oGYQ4No4oeSgCLfL97qpI3IKAUwBvCbIOpXLgpQ==
X-Google-Smtp-Source: APiQypKMEBVkOccHZtZXbygHi/mx/Sf+qUjBravYrVyyPd47Z4DY6vYFP/7nj6MDVfqEW7k3vcPxUHl+RGY6Hf+x+7M=
X-Received: by 2002:a02:cca3:: with SMTP id t3mr1407989jap.3.1587093130192;
 Thu, 16 Apr 2020 20:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200416141833.50663-1-songmuchun@bytedance.com>
 <20200416113502.53b33a1c@gandalf.local.home> <20200416120132.7c2df52a@gandalf.local.home>
In-Reply-To: <20200416120132.7c2df52a@gandalf.local.home>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 17 Apr 2020 11:11:34 +0800
Message-ID: <CAMZfGtVWMUTP4AYch_dAPWRNazmJ7wkMODgqcqS8rhCZPLf+Jg@mail.gmail.com>
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

On Fri, Apr 17, 2020 at 12:01 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 16 Apr 2020 11:35:02 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Thu, 16 Apr 2020 22:18:33 +0800
> > Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > > The user_mode(task_pt_regs(tsk)) always return true for
> > > user thread, and false for kernel thread. So it means that
> > > the cpuacct.usage_sys is the time that kernel thread uses
> > > not the time that thread uses in the kernel mode. We can
> > > use get_irq_regs() instead of task_pt_regs() to fix it.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  kernel/sched/cpuacct.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
> > > index 6448b0438ffb2..edfc62554648e 100644
> > > --- a/kernel/sched/cpuacct.c
> > > +++ b/kernel/sched/cpuacct.c
> > > @@ -5,6 +5,7 @@
> > >   * Based on the work by Paul Menage (menage@google.com) and Balbir Singh
> > >   * (balbir@in.ibm.com).
> > >   */
> > > +#include <asm/irq_regs.h>
> > >  #include "sched.h"
> > >
> > >  /* Time spent by the tasks of the CPU accounting group executing in ... */
> > > @@ -339,7 +340,7 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
> > >  {
> > >     struct cpuacct *ca;
> > >     int index = CPUACCT_STAT_SYSTEM;
> > > -   struct pt_regs *regs = task_pt_regs(tsk);
> > > +   struct pt_regs *regs = get_irq_regs();
> >
> > But get_irq_regs() is only available from interrupt context. This will be
> > NULL most the time, whereas the original way will have regs existing for
> > the task.
>
> Perhaps you want:
>
>         regs = get_irqs_regs();
>         if (!regs)
>                 regs = task_pt_regs(tsk);
>
> ?

Yeah, If regs is NULL, we can get it fall back to task_pt_regs.
Does Anyone else have suggestions?

>
> -- Steve
>
> >
> > >
> > >     if (regs && user_mode(regs))
> > >             index = CPUACCT_STAT_USER;
> >

-- 
Yours,
Muchun
