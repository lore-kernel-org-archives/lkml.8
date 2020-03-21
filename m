Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63518C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 02:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2998820757
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 02:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT38GO/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgCUCrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 22:47:43 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:43923 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgCUCrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 22:47:42 -0400
Received: by mail-il1-f194.google.com with SMTP id d14so7750659ilq.10;
        Fri, 20 Mar 2020 19:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P2k0WSrU2ZJXZjVaGAcVV0ERjfzvv5YtgF8yXRGmqTM=;
        b=OT38GO/5P1zn2/sHIO+sZHLa0OI9KwhNQJKtcFbgKeTiKVu1TACH1x0bwqJ0rTKWBP
         aiVFYdMWvdh/QkFdX4ER8vhDBqqaAN1pHCSlJLYNYVciWRqBXtaFJx2F9MvOnCU33LvK
         MFuh4VR4T1TtPf/G1gtn/URn5G+vhj2FTNSyGv3PyAZOQSqTgAQbXH0Cj/01y3mIwMUg
         jqljry4A0ObdRybqV3tkFHJR/I8MkmR/2mrnMaUOfXAOv/lJ8cPJaytYgBneJ2JiXvSX
         ZNmUSHd0QuNqurIuQR6smKp75/x15MiCj5SZ3h9Tmggl7RclS84ugc1THsDK4Bkxek34
         ehXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P2k0WSrU2ZJXZjVaGAcVV0ERjfzvv5YtgF8yXRGmqTM=;
        b=TXXb4yVbvr1PhEOUFmQRIgSHDPFCtnUEhO1Il2s65vYHXkLgwfhKFbd1qd85UAwKMi
         sznp1zGF56dehMvbeLBHb6FymwjtomG3kNsHkr48FedtWhmnMpVLsrO4dVfks2UhAeGu
         5buuPWHouI5L62MEc1ocSm5jkrXS/ojjOj4mYB/G9FluAiBTJjsswPB5RqkhYg8Gcf7b
         247U3QGASaF3V9Fa9pkGHuLDBzPDZSBQTIg/LglrqRWReFYQVIreR09qNiKpvYTqTqoq
         +Jq/qPj2ucjXiP+tGzxFbPzYremxGHdEQvw8DsmS2htN3IW4t1XB2cLSYXGlTuDOsqEY
         VdRA==
X-Gm-Message-State: ANhLgQ255a+F/LHFnW0kF3RjajNs+qC9vRiB7onvLqoseSjc+CTWeKiV
        6ZsrQS5SAaHkqBOaFXSIaqiGTchhlPzL00jaME649Io8ENM=
X-Google-Smtp-Source: ADFU+vuY0R1Q1Q1paA1QkcLiRlZza0f3IQihlav68tUfmh6Giyw+2YLUV5DOd1UF0abU/7hpcGn0Xy2Ckzq2kPsQiTE=
X-Received: by 2002:a92:bb9d:: with SMTP id x29mr11774869ilk.137.1584758861451;
 Fri, 20 Mar 2020 19:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <1584408485-1921-1-git-send-email-laoar.shao@gmail.com> <158470908459.28353.7390210153247885071.tip-bot2@tip-bot2>
In-Reply-To: <158470908459.28353.7390210153247885071.tip-bot2@tip-bot2>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 21 Mar 2020 10:47:05 +0800
Message-ID: <CALOAHbDGvbZ6x6pDcPah3_3YV9mwMtuFWbLhi0hTQmRro73jqg@mail.gmail.com>
Subject: Re: [tip: sched/core] psi: Move PF_MEMSTALL out of task->flags
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 8:58 PM tip-bot2 for Yafang Shao
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the sched/core branch of tip:
>
> Commit-ID:     1066d1b6974e095d5a6c472ad9180a957b496cd6
> Gitweb:        https://git.kernel.org/tip/1066d1b6974e095d5a6c472ad9180a957b496cd6
> Author:        Yafang Shao <laoar.shao@gmail.com>
> AuthorDate:    Mon, 16 Mar 2020 21:28:05 -04:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Fri, 20 Mar 2020 13:06:19 +01:00
>
> psi: Move PF_MEMSTALL out of task->flags
>
> The task->flags is a 32-bits flag, in which 31 bits have already been
> consumed. So it is hardly to introduce other new per process flag.
> Currently there're still enough spaces in the bit-field section of
> task_struct, so we can define the memstall state as a single bit in
> task_struct instead.
> This patch also removes an out-of-date comment pointed by Matthew.
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Link: https://lkml.kernel.org/r/1584408485-1921-1-git-send-email-laoar.shao@gmail.com
> ---
>  include/linux/sched.h |  6 ++++--
>  kernel/sched/psi.c    | 12 ++++++------
>  kernel/sched/stats.h  | 10 +++++-----
>  3 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 2e9199b..09bddd9 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -785,9 +785,12 @@ struct task_struct {
>         unsigned                        frozen:1;
>  #endif
>  #ifdef CONFIG_BLK_CGROUP
> -       /* to be used once the psi infrastructure lands upstream. */
>         unsigned                        use_memdelay:1;
>  #endif
> +#ifdef CONFIG_PSI
> +       /* Stalled due to lack of memory */
> +       unsigned                        in_memstall:1;
> +#endif
>
>         unsigned long                   atomic_flags; /* Flags requiring atomic access. */
>
> @@ -1480,7 +1483,6 @@ extern struct pid *cad_pid;
>  #define PF_KTHREAD             0x00200000      /* I am a kernel thread */
>  #define PF_RANDOMIZE           0x00400000      /* Randomize virtual address space */
>  #define PF_SWAPWRITE           0x00800000      /* Allowed to write to swap */
> -#define PF_MEMSTALL            0x01000000      /* Stalled due to lack of memory */
>  #define PF_UMH                 0x02000000      /* I'm an Usermodehelper process */
>  #define PF_NO_SETAFFINITY      0x04000000      /* Userland is not allowed to meddle with cpus_mask */
>  #define PF_MCE_EARLY           0x08000000      /* Early kill for mce process policy */
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 955a124..8f45cdb 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -865,17 +865,17 @@ void psi_memstall_enter(unsigned long *flags)
>         if (static_branch_likely(&psi_disabled))
>                 return;
>
> -       *flags = current->flags & PF_MEMSTALL;
> +       *flags = current->in_memstall;
>         if (*flags)
>                 return;
>         /*
> -        * PF_MEMSTALL setting & accounting needs to be atomic wrt
> +        * in_memstall setting & accounting needs to be atomic wrt
>          * changes to the task's scheduling state, otherwise we can
>          * race with CPU migration.
>          */
>         rq = this_rq_lock_irq(&rf);
>
> -       current->flags |= PF_MEMSTALL;
> +       current->in_memstall = 1;
>         psi_task_change(current, 0, TSK_MEMSTALL);
>
>         rq_unlock_irq(rq, &rf);
> @@ -898,13 +898,13 @@ void psi_memstall_leave(unsigned long *flags)
>         if (*flags)
>                 return;
>         /*
> -        * PF_MEMSTALL clearing & accounting needs to be atomic wrt
> +        * in_memstall clearing & accounting needs to be atomic wrt
>          * changes to the task's scheduling state, otherwise we could
>          * race with CPU migration.
>          */
>         rq = this_rq_lock_irq(&rf);
>
> -       current->flags &= ~PF_MEMSTALL;
> +       current->in_memstall = 0;
>         psi_task_change(current, TSK_MEMSTALL, 0);
>
>         rq_unlock_irq(rq, &rf);
> @@ -970,7 +970,7 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
>         } else if (task->in_iowait)
>                 task_flags = TSK_IOWAIT;
>
> -       if (task->flags & PF_MEMSTALL)
> +       if (task->in_memstall)
>                 task_flags |= TSK_MEMSTALL;
>
>         if (task_flags)
> diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
> index 1339f5b..33d0daf 100644
> --- a/kernel/sched/stats.h
> +++ b/kernel/sched/stats.h
> @@ -70,7 +70,7 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
>                 return;
>
>         if (!wakeup || p->sched_psi_wake_requeue) {
> -               if (p->flags & PF_MEMSTALL)
> +               if (p->in_memstall)
>                         set |= TSK_MEMSTALL;
>                 if (p->sched_psi_wake_requeue)
>                         p->sched_psi_wake_requeue = 0;
> @@ -90,7 +90,7 @@ static inline void psi_dequeue(struct task_struct *p, bool sleep)
>                 return;
>
>         if (!sleep) {
> -               if (p->flags & PF_MEMSTALL)
> +               if (p->in_memstall)
>                         clear |= TSK_MEMSTALL;
>         } else {
>                 /*
> @@ -117,14 +117,14 @@ static inline void psi_ttwu_dequeue(struct task_struct *p)
>          * deregister its sleep-persistent psi states from the old
>          * queue, and let psi_enqueue() know it has to requeue.
>          */
> -       if (unlikely(p->in_iowait || (p->flags & PF_MEMSTALL))) {
> +       if (unlikely(p->in_iowait || p->in_memstall)) {
>                 struct rq_flags rf;
>                 struct rq *rq;
>                 int clear = 0;
>
>                 if (p->in_iowait)
>                         clear |= TSK_IOWAIT;
> -               if (p->flags & PF_MEMSTALL)
> +               if (p->in_memstall)
>                         clear |= TSK_MEMSTALL;
>
>                 rq = __task_rq_lock(p, &rf);
> @@ -149,7 +149,7 @@ static inline void psi_task_tick(struct rq *rq)
>         if (static_branch_likely(&psi_disabled))
>                 return;
>
> -       if (unlikely(rq->curr->flags & PF_MEMSTALL))
> +       if (unlikely(rq->curr->in_memstall))
>                 psi_memstall_tick(rq->curr, cpu_of(rq));
>  }
>  #else /* CONFIG_PSI */

+ Andrew

Hi Peter,

This patch was aleady added into Andrew's -mm tree.[1]
I'm not sure whether that could cause merge conflict when both of them
are merged into Linus's tree.

[1]. https://marc.info/?l=linux-mm-commits&m=158456557519886&w=2

-- 
Yafang Shao
DiDi
