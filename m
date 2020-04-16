Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C349C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDBB32064A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jDbYjq5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439617AbgDPHm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439328AbgDPHmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:42:52 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8845C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:42:50 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m8so6761581lji.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0VdHAofzjKiou8tV1+dVPXOIqJxr7GWJIpgp9ALy8M0=;
        b=jDbYjq5baULpkmlwYfNz04Hm25k7Oz/CmgHWCD2pXmOIq+5K3oI6VQP5tHdhuyvxHP
         n+GFJnRhBwXUqUrs6i11RiKm+iP6F5Q0JXmd2Zu588smMUNECixDKRzz9lzC5q+WSQjd
         Mum3upwVMLpZNRwM5/iBdN2l3ewfngYCWgX8w4jya91kY4GWNZ9Gu9P7O7SjcJe72Y+i
         BP+qE4VY1CnGA1JZgSMXHz3bGw5QgsiiPqxbcy+9WPEuo7/R1xsZCyV+DCChZpNQs017
         VArY8DO/jLV85cyBHTMJ/V61hbv7e94GzMUAxPjh7Y+A7vs1eteNKg941idxNo5AwPUW
         WF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0VdHAofzjKiou8tV1+dVPXOIqJxr7GWJIpgp9ALy8M0=;
        b=rZcL3w2pB5/LgniGXJv9dKnUDUPVd7eSRAfLOCk06czV5Z7/x2wfWirwS6u6Qsa6qA
         k8PXXgaIm+6z/tkkuN7ieq9qIswvB8VNEmckLU+mLFHbvjykubOhejWkWsJhUJxHAw3X
         kGD3lFtMNQDpZSwu8CFPaPKUEESPntatstc2tFCQ9Jihxr21bsIcAWhUQhuaIwCPwXPh
         kmuQvwoIyICtAK5iZ1Rtqh5FwRDAUDcjDGY+BnIC1+1n5HBsy+lXc/jstnrGvt20k0UY
         0PEJgCZ05DhQtB9maRe4X9O2eGxeLiCxdGqnkytFuvycJ1i5V6+kR/JLxK/dPIeqUs0q
         sbug==
X-Gm-Message-State: AGi0PuaS8IIhDNG7yAJwYxbgg7Se3niO6a/XBcfd6j3lUuD7Vsen9ZQI
        hXwQgJ9W/bSz6gTEbqd/qfjO5DZoUxXyfVUkPrQASg==
X-Google-Smtp-Source: APiQypLJEt34tw4UHQAkHdvTd8l1aPOb6xHnYJ1t3apJ8dLBzzBjZW+RvUeXA1KwNl6/oudrpoMdEoizSjkMGuxnPcA=
X-Received: by 2002:a2e:8046:: with SMTP id p6mr1618547ljg.21.1587022968469;
 Thu, 16 Apr 2020 00:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200415210512.805-1-valentin.schneider@arm.com> <20200415210512.805-7-valentin.schneider@arm.com>
In-Reply-To: <20200415210512.805-7-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 16 Apr 2020 09:42:36 +0200
Message-ID: <CAKfTPtA5-S_EyzZMDMr9SuVQmWZNdLXOVSLMAMTD+6Bow4jJBQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] sched: Kill select_task_rq()'s sd_flag parameter
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 at 23:05, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Only select_task_rq_fair() uses that parameter to do an actual domain
> search, other classes only care about what kind of wakeup is happening
> (fork, exec, or "regular") and thus just translate the flag into a wakeup
> type.
>
> WF_TTWU and WF_EXEC have just been added, use these along with WF_FORK to
> encode the wakeup types we care about. This cleans up the API a
> bit, but adds an extra conversion layer within select_task_rq_fair().
>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/core.c      | 10 +++++-----
>  kernel/sched/deadline.c  |  4 ++--
>  kernel/sched/fair.c      | 18 +++++++++++++++---
>  kernel/sched/idle.c      |  2 +-
>  kernel/sched/rt.c        |  4 ++--
>  kernel/sched/sched.h     |  2 +-
>  kernel/sched/stop_task.c |  2 +-
>  7 files changed, 27 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3a61a3b8eaa9..aea9badd397a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2094,12 +2094,12 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
>   * The caller (fork, wakeup) owns p->pi_lock, ->cpus_ptr is stable.
>   */
>  static inline
> -int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
> +int select_task_rq(struct task_struct *p, int cpu, int wake_flags)
>  {
>         lockdep_assert_held(&p->pi_lock);
>
>         if (p->nr_cpus_allowed > 1)
> -               cpu = p->sched_class->select_task_rq(p, cpu, sd_flags, wake_flags);
> +               cpu = p->sched_class->select_task_rq(p, cpu, wake_flags);
>         else
>                 cpu = cpumask_any(p->cpus_ptr);
>
> @@ -2612,7 +2612,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>                 atomic_dec(&task_rq(p)->nr_iowait);
>         }
>
> -       cpu = select_task_rq(p, p->wake_cpu, SD_BALANCE_WAKE, wake_flags);
> +       cpu = select_task_rq(p, p->wake_cpu, wake_flags | WF_TTWU);
>         if (task_cpu(p) != cpu) {
>                 wake_flags |= WF_MIGRATED;
>                 psi_ttwu_dequeue(p);
> @@ -2945,7 +2945,7 @@ void wake_up_new_task(struct task_struct *p)
>          * as we're not fully set-up yet.
>          */
>         p->recent_used_cpu = task_cpu(p);
> -       __set_task_cpu(p, select_task_rq(p, task_cpu(p), SD_BALANCE_FORK, 0));
> +       __set_task_cpu(p, select_task_rq(p, task_cpu(p), WF_FORK));
>  #endif
>         rq = __task_rq_lock(p, &rf);
>         update_rq_clock(rq);
> @@ -3486,7 +3486,7 @@ void sched_exec(void)
>         int dest_cpu;
>
>         raw_spin_lock_irqsave(&p->pi_lock, flags);
> -       dest_cpu = p->sched_class->select_task_rq(p, task_cpu(p), SD_BALANCE_EXEC, 0);
> +       dest_cpu = p->sched_class->select_task_rq(p, task_cpu(p), WF_EXEC);
>         if (dest_cpu == smp_processor_id())
>                 goto unlock;
>
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 504d2f51b0d6..0e96b435c51b 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1601,12 +1601,12 @@ static void yield_task_dl(struct rq *rq)
>  static int find_later_rq(struct task_struct *task);
>
>  static int
> -select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
> +select_task_rq_dl(struct task_struct *p, int cpu, int flags)
>  {
>         struct task_struct *curr;
>         struct rq *rq;
>
> -       if (sd_flag != SD_BALANCE_WAKE)
> +       if (!(flags & WF_TTWU))
>                 goto out;
>
>         rq = cpu_rq(cpu);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3d34b4e4060f..b0bf98e6798b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6611,7 +6611,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>
>  /*
>   * select_task_rq_fair: Select target runqueue for the waking task in domains
> - * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
> + * that have the relevant SD flag set. In practice, this is SD_BALANCE_WAKE,
>   * SD_BALANCE_FORK, or SD_BALANCE_EXEC.
>   *
>   * Balances load by selecting the idlest CPU in the idlest group, or under
> @@ -6622,13 +6622,25 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>   * preempt must be disabled.
>   */
>  static int
> -select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
> +select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  {
> +       int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
>         struct sched_domain *tmp, *sd = NULL;
>         int cpu = smp_processor_id();
>         int new_cpu = prev_cpu;
>         int want_affine = 0;
> -       int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
> +       int sd_flag;
> +
> +       switch (wake_flags & (WF_TTWU | WF_FORK | WF_EXEC)) {

You remove a function parameter, which was directly set with the right
flag, but then you add a switch case to recreate this sd_flag
internally. Not sure we can say that it's real benefit

> +       case WF_TTWU:
> +               sd_flag = SD_BALANCE_WAKE;
> +               break;
> +       case WF_FORK:
> +               sd_flag = SD_BALANCE_FORK;
> +               break;
> +       default:
> +               sd_flag = SD_BALANCE_EXEC;
> +       }
>
>         if (sd_flag & SD_BALANCE_WAKE) {
>                 record_wakee(p);
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index b743bf38f08f..e9c6a27f0647 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -367,7 +367,7 @@ void cpu_startup_entry(enum cpuhp_state state)
>
>  #ifdef CONFIG_SMP
>  static int
> -select_task_rq_idle(struct task_struct *p, int cpu, int sd_flag, int flags)
> +select_task_rq_idle(struct task_struct *p, int cpu, int flags)
>  {
>         return task_cpu(p); /* IDLE tasks as never migrated */
>  }
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index df11d88c9895..88427ea0231b 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1426,14 +1426,14 @@ static void yield_task_rt(struct rq *rq)
>  static int find_lowest_rq(struct task_struct *task);
>
>  static int
> -select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
> +select_task_rq_rt(struct task_struct *p, int cpu, int flags)
>  {
>         struct task_struct *curr;
>         struct rq *rq;
>         bool test;
>
>         /* For anything but wake ups, just return the task_cpu */
> -       if (sd_flag != SD_BALANCE_WAKE && sd_flag != SD_BALANCE_FORK)
> +       if (!(flags & (WF_TTWU | WF_FORK)))
>                 goto out;
>
>         rq = cpu_rq(cpu);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index f32c5fa229af..448f5d630544 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1767,7 +1767,7 @@ struct sched_class {
>
>  #ifdef CONFIG_SMP
>         int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
> -       int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
> +       int  (*select_task_rq)(struct task_struct *p, int task_cpu, int flags);
>         void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
>
>         void (*task_woken)(struct rq *this_rq, struct task_struct *task);
> diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
> index 4c9e9975684f..4f061ddf8470 100644
> --- a/kernel/sched/stop_task.c
> +++ b/kernel/sched/stop_task.c
> @@ -11,7 +11,7 @@
>
>  #ifdef CONFIG_SMP
>  static int
> -select_task_rq_stop(struct task_struct *p, int cpu, int sd_flag, int flags)
> +select_task_rq_stop(struct task_struct *p, int cpu, int flags)
>  {
>         return task_cpu(p); /* stop tasks as never migrate */
>  }
> --
> 2.24.0
>
