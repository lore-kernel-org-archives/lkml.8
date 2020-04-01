Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B732C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 03:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A8820772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 03:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tlGtzEA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbgDADoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 23:44:19 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:34882 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731611AbgDADoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 23:44:18 -0400
Received: by mail-il1-f194.google.com with SMTP id 7so21690291ill.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 20:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s7yCmS5K0oztAnIXmBq3PEcJj21ASIC7ccrZJ2uAxs8=;
        b=tlGtzEA+EJvsQHQUXRdA089vCiFQGOd53UfNseILR3D2hfdCZzRpjZSS/OdAjPsrT3
         JzQpyfe7dMS+7vOD9yRTEzreMcXHQNSYD2myqxZ3I9q2xgUikNE3No814tE+sG0bHJQn
         je+xI3La8eB0+Ef744JmJeeuS1s4yt+LWRJslvtJHnNzYb4HnVNN93Y9/aDguTcA4NMO
         18qN4vBrwcanZKXhz3WRTwPEI8a9mdccO6d/CgiqLV9cHBzxogBrV2RjewkxfIJzmcDS
         xyjRrg5Umvv/9NZlU5S5mRXvUnVS9AB8mb0sXjyvg0U6IrA4M6OVJ9Z5H6w+IwcO+na1
         ifJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7yCmS5K0oztAnIXmBq3PEcJj21ASIC7ccrZJ2uAxs8=;
        b=X/tMtk1kpJUbLRjw7rXVZ2BMttzggUDpjGcpjpgnrKIo9/OwVp4OOJx6pBemXb0Dd6
         r+yHl5kw5ffKRO/QOWILcBXB+Yh7ATDTtbxkYGplf3rgIEOMnEUDg31w2at4h3oQqlq8
         CImutdImsyQe+wvO1G0/M0pn7tHA4Cn0fcYkUXlwIXYnanV4Mb0nG4XqhumMzrFSrBg9
         d8bfR+120wC/RDUPhGounU8S5YP6ebKb4zZz7tkkk4EoBzfvirq3MsKIlr/8xPrXQe9z
         pxZ/3hMXNPVrXy/i7CG3ifiBU8xARisgYWfh0RuNj7zqbAQQKNGR+bpnzrgZeZhafo+P
         HbLw==
X-Gm-Message-State: ANhLgQ3p2CTTRYXuVCemgela5rPjYKmTG5aT0VLVkD99QDVVFooTdLn8
        Tm+FjXN5r8Os0wLC51hcwcrGnWn/CMg4G8Qblgk=
X-Google-Smtp-Source: ADFU+vvJADofIKbFzEYjRw9rRmCVMqqTBGOgO4jod4tRkIrOnZu+4PpfDF/CW/kYIq9v4h8L0I59kSs3dJma0htDrtk=
X-Received: by 2002:a92:aa0e:: with SMTP id j14mr20199108ili.52.1585712657613;
 Tue, 31 Mar 2020 20:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200327074308.GY11705@shao2-debian> <20200327175350.rw5gex6cwum3ohnu@linutronix.de>
 <CAJhGHyDmw5Fwq5mgb1h=7GBegQKP2HQnPTxcRps-0PvGbC2PWg@mail.gmail.com>
In-Reply-To: <CAJhGHyDmw5Fwq5mgb1h=7GBegQKP2HQnPTxcRps-0PvGbC2PWg@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 1 Apr 2020 11:44:06 +0800
Message-ID: <CAJhGHyBS9Z=x-X2Bxzbic2sfqj=STqr+K8Tgu1UfYMQDm6MtBg@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Don't double assign worker->sleeping
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@lists.01.org>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 11:22 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> Hello
>
> If I don't miss all the issues you have listed, it is a good and straightforward
> fix, but I have concern that cmpxchg_local() might have performance impact
> on some non-x86 arch.
>
> The two issues as you have listed:
> 1) WARN_ON_ONCE() on valid condition when interrupted(async-page-faulted)
> 2) wq_worker_running() can be interrupted(async-page-faulted in virtual machine)
> and nr_running would be decreased twice.

would be *increased* twice

I just saw the V2 patch, this issue is not listed, but need to be fixed too.

>
> For fixing issue one, we can just remove WARN_ON_ONCE() as this patch.
> For fixing issue two, ->sleeping in wq_worker_running() can be checked&modified
> under irq-disabled.  (we can't use preempt-disabled context here)
>
> thanks,
> Lai
>
> On Sat, Mar 28, 2020 at 1:53 AM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > The kernel test robot triggered a warning with the following race:
> >    task-ctx                              interrupt-ctx
> >  worker
> >   -> process_one_work()
> >     -> work_item()
> >       -> schedule();
> >          -> sched_submit_work()
> >            -> wq_worker_sleeping()
> >              -> ->sleeping = 1
> >                atomic_dec_and_test(nr_running)
> >          __schedule();                *interrupt*
> >                                        async_page_fault()
> >                                        -> local_irq_enable();
> >                                        -> schedule();
> >                                           -> sched_submit_work()
> >                                             -> wq_worker_sleeping()
> >                                                -> if (WARN_ON(->sleeping)) return
> >                                           -> __schedule()
> >                                             ->  sched_update_worker()
> >                                               -> wq_worker_running()
> >                                                  -> atomic_inc(nr_running);
> >                                                  -> ->sleeping = 0;
> >
> >       ->  sched_update_worker()
> >         -> wq_worker_running()
> >           if (!->sleeping) return
> >
> > In this context the warning is pointless everything is fine.
> >
> > However, if the interrupt occurs in wq_worker_sleeping() between reading and
> > setting `sleeping' i.e.
> >
> > |        if (WARN_ON_ONCE(worker->sleeping))
> > |                return;
> >  *interrupt*
> > |        worker->sleeping = 1;
> >
> > then pool->nr_running will be decremented twice in wq_worker_sleeping()
> > but it will be incremented only once in wq_worker_running().
> >
> > Replace the assignment of `sleeping' with a cmpxchg_local() to ensure
> > that there is no double assignment of the variable. The variable is only
> > accessed from the local CPU. Remove the WARN statement because this
> > condition can be valid.
> >
> > An alternative would be to move `->sleeping' to `->flags' as a new bit
> > but this would require to acquire the pool->lock in wq_worker_running().
> >
> > Fixes: 6d25be5782e48 ("sched/core, workqueues: Distangle worker accounting from rq lock")
> > Link: https://lkml.kernel.org/r/20200327074308.GY11705@shao2-debian
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  kernel/workqueue.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 4e01c448b4b48..dc477a2a3ce30 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -846,11 +846,10 @@ void wq_worker_running(struct task_struct *task)
> >  {
> >         struct worker *worker = kthread_data(task);
> >
> > -       if (!worker->sleeping)
> > +       if (cmpxchg_local(&worker->sleeping, 1, 0) == 0)
> >                 return;
> >         if (!(worker->flags & WORKER_NOT_RUNNING))
> >                 atomic_inc(&worker->pool->nr_running);
> > -       worker->sleeping = 0;
> >  }
> >
> >  /**
> > @@ -875,10 +874,9 @@ void wq_worker_sleeping(struct task_struct *task)
> >
> >         pool = worker->pool;
> >
> > -       if (WARN_ON_ONCE(worker->sleeping))
> > +       if (cmpxchg_local(&worker->sleeping, 0, 1) == 1)
> >                 return;
> >
> > -       worker->sleeping = 1;
> >         spin_lock_irq(&pool->lock);
> >
> >         /*
> > --
> > 2.26.0
> >
