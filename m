Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F101AC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3A7206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tQBdUIHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgCLIhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:37:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45264 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCLIhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:37:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id b13so4054872lfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 01:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bJGiZhelnYqsHXoB8Wms+Qj3CRUnm4ECceVNlS0ZuqI=;
        b=tQBdUIHw9dstRBtSa4bLxg1mvFaa8YeETqW0FKQYxa2U5RqvvmlEyS1ciyTf5dxW6S
         FHbiWnFqRYuPi9Nl4GKz997Y+opTe6qQ3223jQirey3JWdZ6wPgN1/bm66CiyqNw1RBU
         m5PMIbV7yUNnbplbc/IOHC/XPE9mKp/ARWNz1sd4yx47iYdzZxldgJol/ulbZ8wRLlh5
         KgKJxZ/G0VtNXy3FXQsYiHwSm4BHD3dXkyGXdxIWBgXaY/pkzx5QxWqy+29+5Bciqswk
         ffCTd3bMo0lFCLvQf01qoMZ94ZbR6BXm7XX7qds/6kjqTECOEHmyRl2/iwd3GMvzqEAz
         OVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bJGiZhelnYqsHXoB8Wms+Qj3CRUnm4ECceVNlS0ZuqI=;
        b=q0mBqMjhDvAKJ5G2ofZXBG06sHHv0RouXFIjEuY2CNrQL+ofNsKbKXI3VDl2Ku1Cpc
         5y0VQbVmO8NU9cShQxNun8WPWqI7mNWRS51eoddQm0UILy8fptNq6NNlp8O6jWZ2X3lg
         M5oKi5Nf1GpoB6Bt1zxzj8gFwz+9SA1Os1FndHkQYLPz3+quc832mELK2juY+BDOMpTd
         4NeC+qEV2oUbeMp1rpe8QMOAhA3AvEobxwOC6p39U4zYdz/avQAy1TAQ5ACJMjF2+YWP
         eaWVjlvB6/UpRkoQZbdGZsrXRR8xoWLOiRPxDTeT4M9loZIKAE62wIoM69WIYVq3qOm5
         KRKw==
X-Gm-Message-State: ANhLgQ2By3JlLndPN5m3CD1J8Pb39Rj4EPY3byVHjKsku8klgU5NCeo6
        H5DVukQ+aS2sfVIQgOkSCFxkL9Zx9ywE4ZTFOz3IGw==
X-Google-Smtp-Source: ADFU+vuOrbxdjFN5jymltyyi2a0JZr2hn7d0ZLacwRUE5Q7mtB67OTp2ScwsjoR/RbEDhKtyQAYRo04qOp8N0r+Zu4I=
X-Received: by 2002:a05:6512:4c9:: with SMTP id w9mr4317407lfq.25.1584002228086;
 Thu, 12 Mar 2020 01:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200311202625.13629-1-daniel.lezcano@linaro.org>
In-Reply-To: <20200311202625.13629-1-daniel.lezcano@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 12 Mar 2020 09:36:56 +0100
Message-ID: <CAKfTPtAqeHhVCeSgE1DsaGGkM6nY-9oAvGw_6zWvv1bKyE85JQ@mail.gmail.com>
Subject: Re: [PATCH V2] sched: fair: Use the earliest break even
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, 11 Mar 2020 at 21:28, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> In the idle CPU selection process occuring in the slow path via the
> find_idlest_group_cpu() function, we pick up in priority an idle CPU
> with the shallowest idle state otherwise we fall back to the least
> loaded CPU.

The idea makes sense but this path is only used by fork and exec so
I'm not sure about the real impact

>
> In order to be more energy efficient but without impacting the
> performances, let's use another criteria: the break even deadline.
>
> At idle time, when we store the idle state the CPU is entering in, we
> compute the next deadline where the CPU could be woken up without
> spending more energy to sleep.
>
> At the selection process, we use the shallowest CPU but in addition we
> choose the one with the minimal break even deadline instead of relying
> on the idle_timestamp. When the CPU is idle, the timestamp has less
> meaning because the CPU could have wake up and sleep again several times
> without exiting the idle loop. In this case the break even deadline is
> more relevant as it increases the probability of choosing a CPU which
> reached its break even.
>
> Tested on:
>  - a synquacer 24 cores, 6 sched domains
>  - a hikey960 HMP 8 cores, 2 sched domains, with the EAS and energy probe
>
> sched/perf and messaging does not show a performance regression. Ran
> 50 times schbench, adrestia and forkbench.
>
> The tools described at https://lwn.net/Articles/724935/
>
>  --------------------------------------------------------------
> | Synquacer             | With break even | Without break even |
>  --------------------------------------------------------------
> | schbench *99.0th      |      14844.8    |         15017.6    |
> | adrestia / periodic   |        57.95    |              57    |
> | adrestia / single     |         49.3    |            55.4    |
>  --------------------------------------------------------------

Have you got some figures or cpuidle statistics for the syncquacer ?


> | Hikey960              | With break even | Without break even |
>  --------------------------------------------------------------
> | schbench *99.0th      |      56140.8    |           56256    |
> | schbench energy       |      153.575    |         152.676    |
> | adrestia / periodic   |         4.98    |             5.2    |
> | adrestia / single     |         9.02    |            9.12    |
> | adrestia energy       |         1.18    |           1.233    |
> | forkbench             |        7.971    |            8.05    |
> | forkbench energy      |         9.37    |            9.42    |
>  --------------------------------------------------------------
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  kernel/sched/fair.c  | 18 ++++++++++++++++--
>  kernel/sched/idle.c  |  8 +++++++-
>  kernel/sched/sched.h | 20 ++++++++++++++++++++
>  3 files changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4b5d5e5e701e..8bd6ea148db7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5793,6 +5793,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>  {
>         unsigned long load, min_load = ULONG_MAX;
>         unsigned int min_exit_latency = UINT_MAX;
> +       s64 min_break_even = S64_MAX;
>         u64 latest_idle_timestamp = 0;
>         int least_loaded_cpu = this_cpu;
>         int shallowest_idle_cpu = -1;
> @@ -5810,6 +5811,8 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>                 if (available_idle_cpu(i)) {
>                         struct rq *rq = cpu_rq(i);
>                         struct cpuidle_state *idle = idle_get_state(rq);
> +                       s64 break_even = idle_get_break_even(rq);
> +
>                         if (idle && idle->exit_latency < min_exit_latency) {
>                                 /*
>                                  * We give priority to a CPU whose idle state
> @@ -5817,10 +5820,21 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>                                  * of any idle timestamp.
>                                  */
>                                 min_exit_latency = idle->exit_latency;
> +                               min_break_even = break_even;
>                                 latest_idle_timestamp = rq->idle_stamp;
>                                 shallowest_idle_cpu = i;
> -                       } else if ((!idle || idle->exit_latency == min_exit_latency) &&
> -                                  rq->idle_stamp > latest_idle_timestamp) {
> +                       } else if ((idle && idle->exit_latency == min_exit_latency) &&
> +                                  break_even < min_break_even) {
> +                               /*
> +                                * We give priority to the shallowest
> +                                * idle states with the minimal break
> +                                * even deadline to decrease the
> +                                * probability to choose a CPU which
> +                                * did not reach its break even yet
> +                                */
> +                               min_break_even = break_even;
> +                               shallowest_idle_cpu = i;
> +                       } else if (!idle && rq->idle_stamp > latest_idle_timestamp) {
>                                 /*
>                                  * If equal or no active idle state, then
>                                  * the most recently idled CPU might have
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index b743bf38f08f..3342e7bae072 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -19,7 +19,13 @@ extern char __cpuidle_text_start[], __cpuidle_text_end[];
>   */
>  void sched_idle_set_state(struct cpuidle_state *idle_state)
>  {
> -       idle_set_state(this_rq(), idle_state);
> +       struct rq *rq = this_rq();
> +
> +       idle_set_state(rq, idle_state);

Shouldn't the state be set after setting break even otherwise you will
have a time window with an idle_state != null but the break_even still
set to the previous value

> +
> +       if (idle_state)
> +               idle_set_break_even(rq, ktime_get_ns() +

What worries me a bit is that it adds one ktime_get call each time a
cpu enters idle

> +                                   idle_state->exit_latency_ns);
>  }
>
>  static int __read_mostly cpu_idle_force_poll;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 2a0caf394dd4..eef1e535e2c2 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1015,6 +1015,7 @@ struct rq {
>  #ifdef CONFIG_CPU_IDLE
>         /* Must be inspected within a rcu lock section */
>         struct cpuidle_state    *idle_state;
> +       s64                     break_even;
>  #endif
>  };
>
> @@ -1850,6 +1851,16 @@ static inline struct cpuidle_state *idle_get_state(struct rq *rq)
>
>         return rq->idle_state;
>  }
> +
> +static inline void idle_set_break_even(struct rq *rq, s64 break_even)
> +{
> +       WRITE_ONCE(rq->break_even, break_even);
> +}
> +
> +static inline s64 idle_get_break_even(struct rq *rq)
> +{
> +       return READ_ONCE(rq->break_even);
> +}
>  #else
>  static inline void idle_set_state(struct rq *rq,
>                                   struct cpuidle_state *idle_state)
> @@ -1860,6 +1871,15 @@ static inline struct cpuidle_state *idle_get_state(struct rq *rq)
>  {
>         return NULL;
>  }
> +
> +static inline void idle_set_break_even(struct rq *rq, s64 break_even)
> +{
> +}
> +
> +static inline s64 idle_get_break_even(struct rq *rq)
> +{
> +       return 0;
> +}
>  #endif
>
>  extern void schedule_idle(void);
> --
> 2.17.1
>
