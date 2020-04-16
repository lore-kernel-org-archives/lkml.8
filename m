Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71073C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AEAA20787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="R04ilmaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440796AbgDPISt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441162AbgDPISG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:18:06 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E90FC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:18:06 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y17so20069608iow.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJ2LUILsJ3R0q0Ya/yvx7n5CSIpCG4/WGn57fah4I8I=;
        b=R04ilmawBVL2HX6GlK5ZHdJdqXZzO3/ONugH/YmvooKTFfxIa0kaka8qBVvbnW/w6c
         bAtTj+b0YMV+N5pfbkup/S7uiHuItXXCi3b1Pyrsd2hd8jzh01uKjZbQ3fggInlF4XQJ
         GFG6CvjLgFqxs59mfm8NBO/7qC66g1/mIlvMgdE6WzzauXlARHrV2i24xZ5PBf5+5Zkn
         UqybPtNf7Lfxos1FNWj27kLik2zoa7exFUT18Q0eZ5g0FqT3jBO7dEJtwY5KyMK+XEZ/
         IibqAMU5eiv6aYC2sgZPf2KrxzcHTaDeygDUIpqK3509BXsHFKqD6Xubjix/xa2SICKC
         CPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJ2LUILsJ3R0q0Ya/yvx7n5CSIpCG4/WGn57fah4I8I=;
        b=G0iktqZZdFp3tZWj8VKJBE+YLCutLf84mOuXw8PEhHsXMojqBn8iYgrZqRhqaUN572
         Qbo7JvkmfMlPZk+j2Xiz6bruhPX3+S2l/m96H7CVG69MPvfkgJqKyNr6LtQHFYuaKqzd
         r1G3QxWafG4/IJC6cmouDylkJzP6LlTkADgqFWkX1hqBJ6Z3XU9qLAfNccmE6LKalNkP
         VbofCndih7YZaJsrq+U0vBe8H/qqAvCWfs2XhxCUTcHUtFk9MXpK0HCLBEYtij0YfG2W
         rOAv55ZRBcPV7nF6ZP5mvCoh9EwAJnFMRT6mXPo18W0wQ9vXD2s7FP8uU6h1bLBM9Utf
         Fs6g==
X-Gm-Message-State: AGi0PubilumWKOGqJGaeNLwOWMtRFKlAcUgQ/bcLn+Imcsk5QKEdafNS
        Vty2XuH9gJmwHNr1dDHaYfcXMPd9gZ/ao1g/6J404Q==
X-Google-Smtp-Source: APiQypIPS7uq8CFWDWIPpDQzGvpH+3HFhopIjdzX0Gh/kHjCK7XU5Ru6gbde3dHfaRMbK2vc/I798kmAE+jBdiX+Ce0=
X-Received: by 2002:a02:7647:: with SMTP id z68mr29835081jab.90.1587025085500;
 Thu, 16 Apr 2020 01:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200416065310.37539-1-songmuchun@bytedance.com> <20200416072723.GK20730@hirez.programming.kicks-ass.net>
In-Reply-To: <20200416072723.GK20730@hirez.programming.kicks-ass.net>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 16 Apr 2020 16:17:29 +0800
Message-ID: <CAMZfGtX4qV3Ca4C=25NFUOZ0toRe6FridyhKkS9zkcjodw+Pow@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] sched/cpuacct: Use __this_cpu_add()
 instead of this_cpu_ptr()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, rostedt@goodmis.org,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 3:27 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Apr 16, 2020 at 02:53:10PM +0800, Muchun Song wrote:
> > There seems to be no difference between the two, but on some
> > architectures(e.g. x86_64), there will be optimizations for
> > __this_cpu_add(). We can disassemble the code for you to see
> > the difference between them on x86_64.
> >
> >   1) this_cpu_ptr(ca->cpuusage)->usages[index] += cputime;
> >
> >      ffffffff810d7227: add %gs:0x7ef37fa9(%rip),%rax # f1d8 <this_cpu_off>
> >      ffffffff810d722f: add %rsi,(%rax)               # %rsi is @cputime
> >
> > This result in two add instructions emitted by the compiler.
> >
> >   2) __this_cpu_add(ca->cpuusage->usages[index], cputime);
> >
> >      ffffffff810d7227: add %rsi,%gs:(%rax)           # %rsi is @cputime
> >
> > This result in only one add instruction emitted by the compiler.
> >
> > So we have enough reasons to use the __this_cpu_add().
>
> The patch is OK, but I can't take it with such complete nonsense for a
> Changelog.
>
> The reason this_cpu_add() and __this_cpu_add() exist and are different
> is for different calling context. this_cpu_*() is always safe and
> correct, but as you notice, not always optimal. __this_cpu_*() relies on
> the caller already having preemption (and or IRQs disabled) to allow for
> better code-gen.
>
> Now, the below call-sites have rq->lock taken, and this means preemption
> (and IRQs) are indeed disabled, so it is safe to use __this_cpu_*().

Thanks Peter. I will update the changelog.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  kernel/sched/cpuacct.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
> > index 9fbb103834345..6448b0438ffb2 100644
> > --- a/kernel/sched/cpuacct.c
> > +++ b/kernel/sched/cpuacct.c
> > @@ -347,7 +347,7 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
> >       rcu_read_lock();
> >
> >       for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
> > -             this_cpu_ptr(ca->cpuusage)->usages[index] += cputime;
> > +             __this_cpu_add(ca->cpuusage->usages[index], cputime);
> >
> >       rcu_read_unlock();
> >  }
> > @@ -363,7 +363,7 @@ void cpuacct_account_field(struct task_struct *tsk, int index, u64 val)
> >
> >       rcu_read_lock();
> >       for (ca = task_ca(tsk); ca != &root_cpuacct; ca = parent_ca(ca))
> > -             this_cpu_ptr(ca->cpustat)->cpustat[index] += val;
> > +             __this_cpu_add(ca->cpustat->cpustat[index], val);
> >       rcu_read_unlock();
> >  }
> >
> > --
> > 2.11.0
> >



-- 
Yours,
Muchun
