Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0172C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2D0C20771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w+lrxWq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439618AbgDPHrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439413AbgDPHrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:47:00 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB19C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:46:59 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h6so4877947lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wrT4kliUhkcTWbKvDU2s1BB4QC4IAQbCP0rRmXI2zns=;
        b=w+lrxWq9ee6NX3P73IlpYIptRYrDT9aYkMXMjYkDs/nWk0mcsc9jqinrTp9mIKeOtB
         L7PP921kukRkCKsMORjD3NIIKNsHXyep/M1HoTPVD8DXqJ2Tv2AlUGvJEH9OcGniRlhw
         SDIrjW9HjvTfyd4HfBy23pH+fvfsVgpucSwMVgRcVcG7VZWKOHdzMlGCKeR1i127zPYt
         wn7SyzHrTdZK2MSKhWe3YRp2delTL8Baek/0dELOa5kDBZdVYVr/lmrVvMdU4WB+zZVw
         4N2m/+aezN7ONDyR0hiVBwi3TuEPq5efIG3Mi+RzJz7iGUJsFUWnTYGeLLYSYG1Ll2In
         hLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrT4kliUhkcTWbKvDU2s1BB4QC4IAQbCP0rRmXI2zns=;
        b=Ub8/5jYKeSGImjZXIXqNrJO5JuKKZzCb9dNH+ezuMrMO3sB6qUMUvjzo+GgPtKqlcz
         KDqQgMcn/1bjY05fUyDH4GeqSwTcSWyHyBh9SLG7SNENe+DlM7zk2LJ+VpW4U/QdKWOb
         pFGD5AUbv5yc+vyLvscbync3Pmp14n1/5wwp/aHUGx8VGlfcuWWd4+bn2bnEphscr7t2
         g5P+oAnkKqks6WB/+D2crR/ZYa/otpwW+ZLZKktNv6RixkqXJmR9QmrnQQWIJhtpMgNL
         pa4valURckfgrrbNyxywOyGhHY+MvDaSmUOUtxwfYmcdq+M/Xhm/zzq/HXHS1Q8moM6b
         AqaQ==
X-Gm-Message-State: AGi0PuaTbRCcaugY8060Ey5NjiCtO9qGxY/C9bvJxhYVv27jBInF8192
        K6nAa8gtN7t427mMjTtrEbqoq6/XP7XtFg2KnA/sTw==
X-Google-Smtp-Source: APiQypIU91uSSug7jGlF8EyXy6RrOeGt2+nXwBTwBTyAYl/5kVv/qIRiwCNDp4l/daTYYOOmlGzHx1Ke4pJHOcvafVg=
X-Received: by 2002:a19:c7d8:: with SMTP id x207mr5204452lff.190.1587023218195;
 Thu, 16 Apr 2020 00:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200415210512.805-1-valentin.schneider@arm.com> <20200415210512.805-10-valentin.schneider@arm.com>
In-Reply-To: <20200415210512.805-10-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 16 Apr 2020 09:46:46 +0200
Message-ID: <CAKfTPtBDGzrvG=YhjBZBEgfx5EtM-rTC-dWX5phqh4bOY5XqgA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] sched/topology: Define and use shortcut pointers
 for wakeup sd_flag scan
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 at 23:05, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Reworking select_task_rq_fair()'s domain walk exposed that !want_affine
> wakeups only look for highest sched_domain with the required sd_flag
> set. This is something we can cache at sched domain build time to slightly
> optimize select_task_rq_fair(). Note that this isn't a "free" optimization:
> it costs us 3 pointers per CPU.
>
> Add cached per-CPU pointers for the highest domains with SD_BALANCE_WAKE,
> SD_BALANCE_EXEC and SD_BALANCE_FORK. Use them in select_task_rq_fair().
>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c     | 25 +++++++++++++------------
>  kernel/sched/sched.h    |  3 +++
>  kernel/sched/topology.c | 12 ++++++++++++
>  3 files changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6f8cdb99f4a0..db4fb29a88d9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6631,17 +6631,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>         int want_affine = 0;
>         int sd_flag;
>
> -       switch (wake_flags & (WF_TTWU | WF_FORK | WF_EXEC)) {
> -       case WF_TTWU:
> -               sd_flag = SD_BALANCE_WAKE;
> -               break;
> -       case WF_FORK:
> -               sd_flag = SD_BALANCE_FORK;
> -               break;
> -       default:
> -               sd_flag = SD_BALANCE_EXEC;
> -       }
> -
>         if (wake_flags & WF_TTWU) {
>                 record_wakee(p);
>
> @@ -6657,7 +6646,19 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>
>         rcu_read_lock();
>
> -       sd = highest_flag_domain(cpu, sd_flag);
> +       switch (wake_flags & (WF_TTWU | WF_FORK | WF_EXEC)) {
> +       case WF_TTWU:
> +               sd_flag = SD_BALANCE_WAKE;
> +               sd = rcu_dereference(per_cpu(sd_balance_wake, cpu));

It's worth having a direct pointer for the fast path which we always
try to keep short but the other paths are already slow and will not
get any benefit of this per cpu pointer.
We should keep the loop for the slow paths

> +               break;
> +       case WF_FORK:
> +               sd_flag = SD_BALANCE_FORK;
> +               sd = rcu_dereference(per_cpu(sd_balance_fork, cpu));
> +               break;
> +       default:
> +               sd_flag = SD_BALANCE_EXEC;
> +               sd = rcu_dereference(per_cpu(sd_balance_exec, cpu));
> +       }
>
>         /*
>          * If !want_affine, we just look for the highest domain where
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 448f5d630544..4b014103affb 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1423,6 +1423,9 @@ DECLARE_PER_CPU(int, sd_llc_size);
>  DECLARE_PER_CPU(int, sd_llc_id);
>  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> +DECLARE_PER_CPU(struct sched_domain __rcu *, sd_balance_wake);
> +DECLARE_PER_CPU(struct sched_domain __rcu *, sd_balance_fork);
> +DECLARE_PER_CPU(struct sched_domain __rcu *, sd_balance_exec);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
>  extern struct static_key_false sched_asym_cpucapacity;
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 1d7b446fac7d..66763c539bbd 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -618,6 +618,9 @@ DEFINE_PER_CPU(int, sd_llc_size);
>  DEFINE_PER_CPU(int, sd_llc_id);
>  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> +DEFINE_PER_CPU(struct sched_domain __rcu *, sd_balance_wake);
> +DEFINE_PER_CPU(struct sched_domain __rcu *, sd_balance_fork);
> +DEFINE_PER_CPU(struct sched_domain __rcu *, sd_balance_exec);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
>  DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
> @@ -644,6 +647,15 @@ static void update_top_cache_domain(int cpu)
>         sd = lowest_flag_domain(cpu, SD_NUMA);
>         rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
>
> +       sd = highest_flag_domain(cpu, SD_BALANCE_WAKE);
> +       rcu_assign_pointer(per_cpu(sd_balance_wake, cpu), sd);
> +
> +       sd = highest_flag_domain(cpu, SD_BALANCE_FORK);
> +       rcu_assign_pointer(per_cpu(sd_balance_fork, cpu), sd);
> +
> +       sd = highest_flag_domain(cpu, SD_BALANCE_EXEC);
> +       rcu_assign_pointer(per_cpu(sd_balance_exec, cpu), sd);
> +
>         sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
>         rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);
>
> --
> 2.24.0
>
