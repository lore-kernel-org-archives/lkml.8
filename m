Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B996BC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 03:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3CD20678
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 03:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN6sShuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbgDADXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 23:23:05 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35694 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbgDADXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 23:23:04 -0400
Received: by mail-io1-f65.google.com with SMTP id o3so18551941ioh.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 20:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tKHXS6/Mnrp6srBbnR262gLigKf8aMPoVYaaS/hPS9s=;
        b=eN6sShuN0c7Oei1hyyHoiDdZJ5O6nb+kKREnHlHZ6WM+V+tPSLzKBnBo8ahtmpvqH8
         2vEsbSgkslrKFZsOoZoqORstlEu3nMfbJL5q6icPCKeetVzyzxA+OCYqsn5SpB+7/iTK
         671amErct+hOBEzjM6LXsMuFWOx6SGXXtuwD7iAxtQazgkzySGyqoUmA3RPXvBSNQKrL
         7T+fUALYIE2kcSpzJAM/Tu3r/4pBfr8Dpz73muo/mrNyxS1qysN++hWEigA77a8rwkp2
         eVtJIReJoMqh+r1PXWJCDlJ0bDNg7XW7AKd3giWORc3GRU++I++rUwceVhRZYuxt0Wzx
         t/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKHXS6/Mnrp6srBbnR262gLigKf8aMPoVYaaS/hPS9s=;
        b=Wl1D6oHTLvjJk8N+1oCylX8gThrbnBK4AdmTsxb5+tDxqMki5Yi01Ofd+n7iUzo8yE
         FDrNaiG3mh2LJoYLbLqi5t2MMxQJNS2TgfSM6FTd96v4mjMNdBp4TfEhXmejUxEhTWa9
         6trXWqmv12XCN1WI4O+G0q+0hLzuuQftaXp9dHNqNJcrwCTi0H4cZKk4+rAZxG9/mq3D
         rp1uOmuJdnfa2c4GOY5yjVg0J6vrTIOCVKdglJ1lFjsQY8Y6KFLprI0x+4za5+9wC/XY
         FqSPjDq6nyx8IDDEFHgkR480dQ3Yi/Y2pcvl4w0pFGvfkE3lkTmIJzTwGLimWgz3bQvN
         jfhA==
X-Gm-Message-State: ANhLgQ1FR93pmGtSd4ehk/ZNZ89TKcP5wyaxgiGuVgVk/ilGr/TrrhmJ
        3BYyMqids06V1t8wG8/tYgX4EQT0u3VGcGfxMpc=
X-Google-Smtp-Source: ADFU+vu8eodPaphbTQkMDs3RZKUEfdF6DyNHOUHKskCPC86X60H32507rzCiT+ZZ5Y980apNclGYcroc7xZHLKpXD84=
X-Received: by 2002:a05:6638:20d:: with SMTP id e13mr18318129jaq.56.1585711383185;
 Tue, 31 Mar 2020 20:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200327074308.GY11705@shao2-debian> <20200327175350.rw5gex6cwum3ohnu@linutronix.de>
In-Reply-To: <20200327175350.rw5gex6cwum3ohnu@linutronix.de>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 1 Apr 2020 11:22:51 +0800
Message-ID: <CAJhGHyDmw5Fwq5mgb1h=7GBegQKP2HQnPTxcRps-0PvGbC2PWg@mail.gmail.com>
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

Hello

If I don't miss all the issues you have listed, it is a good and straightforward
fix, but I have concern that cmpxchg_local() might have performance impact
on some non-x86 arch.

The two issues as you have listed:
1) WARN_ON_ONCE() on valid condition when interrupted(async-page-faulted)
2) wq_worker_running() can be interrupted(async-page-faulted in virtual machine)
and nr_running would be decreased twice.

For fixing issue one, we can just remove WARN_ON_ONCE() as this patch.
For fixing issue two, ->sleeping in wq_worker_running() can be checked&modified
under irq-disabled.  (we can't use preempt-disabled context here)

thanks,
Lai

On Sat, Mar 28, 2020 at 1:53 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> The kernel test robot triggered a warning with the following race:
>    task-ctx                              interrupt-ctx
>  worker
>   -> process_one_work()
>     -> work_item()
>       -> schedule();
>          -> sched_submit_work()
>            -> wq_worker_sleeping()
>              -> ->sleeping = 1
>                atomic_dec_and_test(nr_running)
>          __schedule();                *interrupt*
>                                        async_page_fault()
>                                        -> local_irq_enable();
>                                        -> schedule();
>                                           -> sched_submit_work()
>                                             -> wq_worker_sleeping()
>                                                -> if (WARN_ON(->sleeping)) return
>                                           -> __schedule()
>                                             ->  sched_update_worker()
>                                               -> wq_worker_running()
>                                                  -> atomic_inc(nr_running);
>                                                  -> ->sleeping = 0;
>
>       ->  sched_update_worker()
>         -> wq_worker_running()
>           if (!->sleeping) return
>
> In this context the warning is pointless everything is fine.
>
> However, if the interrupt occurs in wq_worker_sleeping() between reading and
> setting `sleeping' i.e.
>
> |        if (WARN_ON_ONCE(worker->sleeping))
> |                return;
>  *interrupt*
> |        worker->sleeping = 1;
>
> then pool->nr_running will be decremented twice in wq_worker_sleeping()
> but it will be incremented only once in wq_worker_running().
>
> Replace the assignment of `sleeping' with a cmpxchg_local() to ensure
> that there is no double assignment of the variable. The variable is only
> accessed from the local CPU. Remove the WARN statement because this
> condition can be valid.
>
> An alternative would be to move `->sleeping' to `->flags' as a new bit
> but this would require to acquire the pool->lock in wq_worker_running().
>
> Fixes: 6d25be5782e48 ("sched/core, workqueues: Distangle worker accounting from rq lock")
> Link: https://lkml.kernel.org/r/20200327074308.GY11705@shao2-debian
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/workqueue.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 4e01c448b4b48..dc477a2a3ce30 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -846,11 +846,10 @@ void wq_worker_running(struct task_struct *task)
>  {
>         struct worker *worker = kthread_data(task);
>
> -       if (!worker->sleeping)
> +       if (cmpxchg_local(&worker->sleeping, 1, 0) == 0)
>                 return;
>         if (!(worker->flags & WORKER_NOT_RUNNING))
>                 atomic_inc(&worker->pool->nr_running);
> -       worker->sleeping = 0;
>  }
>
>  /**
> @@ -875,10 +874,9 @@ void wq_worker_sleeping(struct task_struct *task)
>
>         pool = worker->pool;
>
> -       if (WARN_ON_ONCE(worker->sleeping))
> +       if (cmpxchg_local(&worker->sleeping, 0, 1) == 1)
>                 return;
>
> -       worker->sleeping = 1;
>         spin_lock_irq(&pool->lock);
>
>         /*
> --
> 2.26.0
>
