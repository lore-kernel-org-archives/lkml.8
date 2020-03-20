Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242EDC4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD45E2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CPNo3Mfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgCTPsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:48:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34721 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbgCTPsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:48:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id s13so6949283ljm.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 08:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3xA609GcrNBHpv4xye7Dp4/Zc4EcbhtU6KxpAKzkU6Y=;
        b=CPNo3MfkG3l8EFTVgAE+hR3XHwIRLsJvhTjThaIBAD+NpNHo9EHmfBSNsW3Jy9ctLZ
         iAL5g19baW0EX4jrvbyBBAz5lfey75g6lj5jfD2LtEfWmJIdFcDQl6uKCsyJ9Usl2Pp1
         tMUtMaBbxNd19FdwieIpDN0L7L65+7KaV7zyf9yWUiQXO6w/bwyEr/ve2Xh28jYvcKPq
         LwKKH0TDA4bgDBUvYE1+v/WfzEkZDuRKTggUedjLlb3ycXURkG0DR6+f6XrO2ZSAfv3E
         5BR0Ul/fn8dfOjPlLFdJbM8CPk1b2IzmwFd7T7HVbkJpJ/eX0IMMVH5rI6Y+fF/SXIfx
         wU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3xA609GcrNBHpv4xye7Dp4/Zc4EcbhtU6KxpAKzkU6Y=;
        b=Mg8xxV8UQP4xZk2M1jH+samAhXYJfGEvcereQC2qhIrY/omqLe7HVwwmc0cdjeHP1U
         BKlph7EXzsGLULWCgdlpNfzSFmemgvgnVkdHpJwviWsp1Sl3nuLQCKoOVf1vXVUiBDnG
         htaj2pdLiapsHaoPaS+yA7uY6WrM9AhPXaMNbowocMa0E+c2m58THb0leEvcPcGxCqNe
         FOUwhjVC8fP5BzEYu/I1BXoilAIilTgfoK3XHWV17TER4ffeo3R/zD4HHM8qRA1x7gJq
         tsMbo/IGlJApzEv45yCPeNQyUA6TAvo7feaPhMMJ1AyJo4nr5+PuUdHpbJLVPObQrXNe
         kf7Q==
X-Gm-Message-State: ANhLgQ3L0zGTaIPiQDy/AH7fkNiQIP2psvBwi4tpyuZ/uVYnYhFbCXR8
        3leY8eH+20qf3Y4K1YQvpxlcOD10vRDiHe001WnsGw==
X-Google-Smtp-Source: ADFU+vt3INLoz/TP6BG5R7dy4dZLHg2H9E1q6BoIdrqcox9Ga2dFPckZwtbv0jKVcKYS3CJRR8PjBj+WWmrUE07JLd4=
X-Received: by 2002:a2e:9a0d:: with SMTP id o13mr5601449lji.151.1584719330635;
 Fri, 20 Mar 2020 08:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200320151245.21152-1-mgorman@techsingularity.net> <20200320151245.21152-5-mgorman@techsingularity.net>
In-Reply-To: <20200320151245.21152-5-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 20 Mar 2020 16:48:39 +0100
Message-ID: <CAKfTPtAUuO1Jp6P73gAiP+g5iLTx16UeBgBjm_5zjFxwiBD9=Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched/fair: Track possibly overloaded domains and
 abort a scan if necessary
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020 at 16:13, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> Once a domain is overloaded, it is very unlikely that a free CPU will
> be found in the short term but there is still potentially a lot of
> scanning. This patch tracks if a domain may be overloaded due to an
> excessive number of running tasks relative to available CPUs.  In the
> event a domain is overloaded, a search is aborted.
>
> This has a variable impact on performance for hackbench which often
> is overloaded on the test machines used. There was a mix of performance gains
> and losses but there is a substantial impact on search efficiency.
>
> On a 2-socket broadwell machine with 80 cores in total, tbench showed
> small gains and some losses
>
> Hmean     1        431.51 (   0.00%)      426.53 *  -1.15%*
> Hmean     2        842.69 (   0.00%)      839.00 *  -0.44%*
> Hmean     4       1631.09 (   0.00%)     1634.81 *   0.23%*
> Hmean     8       3001.08 (   0.00%)     3020.85 *   0.66%*
> Hmean     16      5631.75 (   0.00%)     5655.04 *   0.41%*
> Hmean     32      9736.22 (   0.00%)     9645.68 *  -0.93%*
> Hmean     64     13978.54 (   0.00%)    15215.65 *   8.85%*
> Hmean     128    20093.06 (   0.00%)    19389.45 *  -3.50%*
> Hmean     256    17491.34 (   0.00%)    18616.32 *   6.43%*
> Hmean     320    17423.67 (   0.00%)    17793.38 *   2.12%*
>
> However, the "SIS Domain Search Efficiency" went from 6.03% to 19.61%
> indicating that far fewer CPUs were scanned. The impact of the patch
> is more noticable when sockets have multiple L3 caches. While true for
> EPYC 2nd generation, it's particularly noticable on EPYC 1st generation
>
> Hmean     1        325.30 (   0.00%)      324.92 *  -0.12%*
> Hmean     2        630.77 (   0.00%)      621.35 *  -1.49%*
> Hmean     4       1211.41 (   0.00%)     1148.51 *  -5.19%*
> Hmean     8       2017.29 (   0.00%)     1953.57 *  -3.16%*
> Hmean     16      4068.81 (   0.00%)     3514.06 * -13.63%*
> Hmean     32      5588.20 (   0.00%)     6583.58 *  17.81%*
> Hmean     64      8470.14 (   0.00%)    10117.26 *  19.45%*
> Hmean     128    11462.06 (   0.00%)    17207.68 *  50.13%*
> Hmean     256    11433.74 (   0.00%)    13446.93 *  17.61%*
> Hmean     512    12576.88 (   0.00%)    13630.08 *   8.37%*
>
> On this machine, search efficiency goes from 21.04% to 32.66%. There
> is a noticable problem at 16 when there are enough clients for a LLC
> domain to spill over.
>
> With hackbench, the overload problem is a bit more obvious. On the
> 2-socket broadwell machine using processes and pipes we see
>
> Amean     1        0.3023 (   0.00%)      0.2893 (   4.30%)
> Amean     4        0.6823 (   0.00%)      0.6930 (  -1.56%)
> Amean     7        1.0293 (   0.00%)      1.0380 (  -0.84%)
> Amean     12       1.6913 (   0.00%)      1.7027 (  -0.67%)
> Amean     21       2.9307 (   0.00%)      2.9297 (   0.03%)
> Amean     30       4.0040 (   0.00%)      4.0270 (  -0.57%)
> Amean     48       6.0703 (   0.00%)      6.1067 (  -0.60%)
> Amean     79       9.0630 (   0.00%)      9.1223 *  -0.65%*
> Amean     110     12.1917 (   0.00%)     12.1693 (   0.18%)
> Amean     141     15.7150 (   0.00%)     15.4187 (   1.89%)
> Amean     172     19.5327 (   0.00%)     18.9937 (   2.76%)
> Amean     203     23.3093 (   0.00%)     22.2497 *   4.55%*
> Amean     234     27.8657 (   0.00%)     25.9627 *   6.83%*
> Amean     265     32.9783 (   0.00%)     29.5240 *  10.47%*
> Amean     296     35.6727 (   0.00%)     32.8260 *   7.98%*
>
> More of the SIS stats are worth looking at in this case
>
> Ops SIS Domain Search       10390526707.00  9822163508.00
> Ops SIS Scanned            223173467577.00 48330226094.00
> Ops SIS Domain Scanned     222820381314.00 47964114165.00
> Ops SIS Failures            10183794873.00  9639912418.00
> Ops SIS Recent Used Hit        22194515.00    22517194.00
> Ops SIS Recent Used Miss     5733847634.00  5500415074.00
> Ops SIS Recent Attempts      5756042149.00  5522932268.00
> Ops SIS Search Efficiency             4.81          21.08
>
> Search efficiency goes from 4.66% to 20.48% but the SIS Domain Scanned
> shows the sheer volume of searching SIS does when prev, target and recent
> CPUs are unavailable.
>
> This could be much more aggressive by also cutting off a search for idle
> cores. However, to make that work properly requires a much more intrusive
> series that is likely to be controversial. This seemed like a reasonable
> tradeoff to tackle the most obvious problem with select_idle_cpu.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  include/linux/sched/topology.h |  1 +
>  kernel/sched/fair.c            | 65 +++++++++++++++++++++++++++++++++++++++---
>  kernel/sched/features.h        |  3 ++
>  3 files changed, 65 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index af9319e4cfb9..76ec7a54f57b 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -66,6 +66,7 @@ struct sched_domain_shared {
>         atomic_t        ref;
>         atomic_t        nr_busy_cpus;
>         int             has_idle_cores;
> +       int             is_overloaded;

Can't nr_busy_cpus compared to sd->span_weight give you similar status  ?

>  };
>
>  struct sched_domain {
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 41913fac68de..31e011e627db 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5924,6 +5924,38 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
>         return new_cpu;
>  }
>
> +static inline void
> +set_sd_overloaded(struct sched_domain_shared *sds, int val)
> +{
> +       if (!sds)
> +               return;
> +
> +       WRITE_ONCE(sds->is_overloaded, val);
> +}
> +
> +static inline bool test_sd_overloaded(struct sched_domain_shared *sds)
> +{
> +       return READ_ONCE(sds->is_overloaded);
> +}
> +
> +/* Returns true if a previously overloaded domain is likely still overloaded. */
> +static inline bool
> +abort_sd_overloaded(struct sched_domain_shared *sds, int prev, int target)
> +{
> +       if (!sds || !test_sd_overloaded(sds))
> +               return false;
> +
> +       /* Are either target or a suitable prev 1 or 0 tasks? */
> +       if (cpu_rq(target)->nr_running <= 1 ||
> +           (prev != target && cpus_share_cache(prev, target) &&
> +            cpu_rq(prev)->nr_running <= 1)) {
> +               set_sd_overloaded(sds, 0);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
>  #ifdef CONFIG_SCHED_SMT
>  DEFINE_STATIC_KEY_FALSE(sched_smt_present);
>  EXPORT_SYMBOL_GPL(sched_smt_present);
> @@ -6060,15 +6092,18 @@ static inline int select_idle_smt(struct task_struct *p, int target)
>   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
>   * average idle time for this rq (as found in rq->avg_idle).
>   */
> -static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
> +static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd,
> +                          int prev, int target)
>  {
>         struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>         struct sched_domain *this_sd;
> +       struct sched_domain_shared *sds;
>         u64 avg_cost, avg_idle;
>         u64 time, cost;
>         s64 delta;
>         int this = smp_processor_id();
>         int cpu, nr = INT_MAX;
> +       int nr_scanned = 0, nr_running = 0;
>
>         this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>         if (!this_sd)
> @@ -6092,18 +6127,40 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>                         nr = 4;
>         }
>
> +       sds = rcu_dereference(per_cpu(sd_llc_shared, target));
> +       if (sched_feat(SIS_OVERLOAD)) {
> +               if (abort_sd_overloaded(sds, prev, target))
> +                       return -1;
> +       }
> +
>         time = cpu_clock(this);
>
>         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>
>         for_each_cpu_wrap(cpu, cpus, target) {
>                 schedstat_inc(this_rq()->sis_scanned);
> -               if (!--nr)
> -                       return -1;
> +               if (!--nr) {
> +                       cpu = -1;
> +                       break;
> +               }
>                 if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
>                         break;
> +               if (sched_feat(SIS_OVERLOAD)) {
> +                       nr_scanned++;
> +                       nr_running += cpu_rq(cpu)->nr_running;
> +               }
>         }
>
> +       /* Check if domain should be marked overloaded if no cpu was found. */
> +       if (sched_feat(SIS_OVERLOAD) && (signed)cpu >= nr_cpumask_bits &&
> +           nr_scanned && nr_running > (nr_scanned << 1)) {
> +               set_sd_overloaded(sds, 1);
> +       }
> +
> +       /* Scan cost not accounted for if scan is throttled */
> +       if (!nr)
> +               return -1;
> +
>         time = cpu_clock(this) - time;
>         cost = this_sd->avg_scan_cost;
>         delta = (s64)(time - cost) / 8;
> @@ -6236,7 +6293,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>         if ((unsigned)i < nr_cpumask_bits)
>                 return i;
>
> -       i = select_idle_cpu(p, sd, target);
> +       i = select_idle_cpu(p, sd, prev, target);
>         if ((unsigned)i < nr_cpumask_bits)
>                 return i;
>
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 7481cd96f391..c36ae01910e2 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -57,6 +57,9 @@ SCHED_FEAT(TTWU_QUEUE, true)
>  SCHED_FEAT(SIS_AVG_CPU, false)
>  SCHED_FEAT(SIS_PROP, true)
>
> +/* Limit scans if the domain is likely overloaded */
> +SCHED_FEAT(SIS_OVERLOAD, true)
> +
>  /*
>   * Issue a WARN when we do multiple update_rq_clock() calls
>   * in a single rq->lock section. Default disabled because the
> --
> 2.16.4
>
