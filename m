Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D5CC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4CA21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PBAV8LV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgBRPd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:33:28 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40922 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgBRPd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 10:33:28 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18so23443077ljo.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 07:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BzEWLvcFSaCbrCpz0nr75OD3J67QR5Liqg2BI7LH4tY=;
        b=PBAV8LV/+MdR3jrCwWHVfYbS/SB2ByiNPA16fHDsrbyw3cRsXc5Hf99obK7C9zU/dB
         rVUQSZNkW8CuIA/99O93wiJcksqASUzhqey7F9IxziUsFZv0hPlTkRYol/qQhekY6O7P
         V1JFlYdowHWxMAb4es4KB6xPczkz7w4IDZW6pbnKTzAoFWnLnuMvGRoOKypLvWFaNCXz
         9FzCcnxoHIVg70pV3mgxTQZh99LzdgEyZEaGofRMVtslQtttfNr4T9i/FBLXhvvidjRR
         zdx9uYzX4wg+HJyU/z6TAd+jTR/YaBo60wFbJBlABYveurhV6GDXVndIJm8F5v403Xjg
         sliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BzEWLvcFSaCbrCpz0nr75OD3J67QR5Liqg2BI7LH4tY=;
        b=tfTp7OUip7jcFM3CwQ4I93mf0SoHiyZvlZiBJaYQoXUHN2wicECfgr2P1MzE2XTviq
         vtfLoYHQk8B1DFqDUcXPerPBpPTCUuo3iGID8/juYIf7U4xTV0MgbTdd9uqGKDCOyeJ4
         Tz4xBLLSJBTj0h4FJfQPtCvcAl1gY4MKbMEh6RtdP/zRdKWkqQ6smO0+8YimaQHhEgnf
         qoLkuloSGzz2EHI3qKsLcJutI+14f31V3VG75RKGY2zkU22t0yVTbVc89PTQ2SAfH7Zr
         lXRXbMq4cA++yIrp2gTCjgyOFpDQKqRDsarLIqnlMsRL664hgfBEU+a0VVZ+PrhEmuC7
         E7Aw==
X-Gm-Message-State: APjAAAWztYWr0gyldRXCLIVazxcCPbhGc9a/PBlAiqQfQtvBsrKjBF+4
        xogzv52g1Z9oz+UYDVFbjqXIidYVvxyH2qlX5HY4TQ==
X-Google-Smtp-Source: APXvYqy5mGwt1tHS3LUG2Y66FDBL4M5k2UdAHgSa9WCBEB7zOUneiygpeigrNgtVc8oQVKHIliRmlYwvC30EqwEi7hQ=
X-Received: by 2002:a2e:808a:: with SMTP id i10mr13127195ljg.151.1582040005674;
 Tue, 18 Feb 2020 07:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-3-vincent.guittot@linaro.org> <b67ae78b-17ba-8f3f-9052-fecefb848e3d@arm.com>
In-Reply-To: <b67ae78b-17ba-8f3f-9052-fecefb848e3d@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 18 Feb 2020 16:33:14 +0100
Message-ID: <CAKfTPtB04MdaU+C4uSS=qU8O69UFjNsOJw5Ck17WBhxVNHETmg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] sched/numa: Replace runnable_load_avg by load_avg
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 at 15:54, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 2/14/20 3:27 PM, Vincent Guittot wrote:
> > @@ -1473,38 +1473,35 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
> >              group_faults_cpu(ng, src_nid) * group_faults(p, dst_nid) * 4;
> >  }
> >
> > -static inline unsigned long cfs_rq_runnable_load_avg(struct cfs_rq *cfs_rq);
> > -
> > -static unsigned long cpu_runnable_load(struct rq *rq)
> > -{
> > -     return cfs_rq_runnable_load_avg(&rq->cfs);
> > -}
> > +/*
> > + * 'numa_type' describes the node at the moment of load balancing.
> > + */
> > +enum numa_type {
> > +     /* The node has spare capacity that can be used to run more tasks.  */
> > +     node_has_spare = 0,
> > +     /*
> > +      * The node is fully used and the tasks don't compete for more CPU
> > +      * cycles. Nevertheless, some tasks might wait before running.
> > +      */
> > +     node_fully_busy,
> > +     /*
> > +      * The node is overloaded and can't provide expected CPU cycles to all
> > +      * tasks.
> > +      */
> > +     node_overloaded
> > +};
>
> Could we reuse group_type instead? The definitions are the same modulo
> s/group/node/.

Also, imbalance might have but misfit and asym have no meaning at NUMA level

For now I prefer to keep them separate to ease code readability. Also
more changes will come on top of this for NUMA balancing which could
also ends up with numa dedicated states

>
> >
> >  /* Cached statistics for all CPUs within a node */
> >  struct numa_stats {
> >       unsigned long load;
> > -
> > +     unsigned long util;
> >       /* Total compute capacity of CPUs on a node */
> >       unsigned long compute_capacity;
> > +     unsigned int nr_running;
> > +     unsigned int weight;
> > +     enum numa_type node_type;
> >  };
> >
> > -/*
> > - * XXX borrowed from update_sg_lb_stats
> > - */
> > -static void update_numa_stats(struct numa_stats *ns, int nid)
> > -{
> > -     int cpu;
> > -
> > -     memset(ns, 0, sizeof(*ns));
> > -     for_each_cpu(cpu, cpumask_of_node(nid)) {
> > -             struct rq *rq = cpu_rq(cpu);
> > -
> > -             ns->load += cpu_runnable_load(rq);
> > -             ns->compute_capacity += capacity_of(cpu);
> > -     }
> > -
> > -}
> > -
> >  struct task_numa_env {
> >       struct task_struct *p;
> >
> > @@ -1521,6 +1518,47 @@ struct task_numa_env {
> >       int best_cpu;
> >  };
> >
> > +static unsigned long cpu_load(struct rq *rq);
> > +static unsigned long cpu_util(int cpu);
> > +
> > +static inline enum
> > +numa_type numa_classify(unsigned int imbalance_pct,
> > +                      struct numa_stats *ns)
> > +{
> > +     if ((ns->nr_running > ns->weight) &&
> > +         ((ns->compute_capacity * 100) < (ns->util * imbalance_pct)))
> > +             return node_overloaded;
> > +
> > +     if ((ns->nr_running < ns->weight) ||
> > +         ((ns->compute_capacity * 100) > (ns->util * imbalance_pct)))
> > +             return node_has_spare;
> > +
> > +     return node_fully_busy;
> > +}
> > +
>
> As Mel pointed out, this is group_is_overloaded() and group_has_capacity().
> @Mel, you mentioned having a common helper, do you have that laying around?
> I haven't seen it in your reconciliation series.
>
> What I'm naively thinking here is that we could have either move the whole
> thing to just sg_lb_stats (AFAICT the fields of numa_stats are a subset of it),
> or if we really care about the stack we could tweak the ordering to ensure
> we can cast one into the other (not too enticed by that one though).
>
> > +/*
> > + * XXX borrowed from update_sg_lb_stats
> > + */
> > +static void update_numa_stats(struct task_numa_env *env,
> > +                           struct numa_stats *ns, int nid)
> > +{
> > +     int cpu;
> > +
> > +     memset(ns, 0, sizeof(*ns));
> > +     for_each_cpu(cpu, cpumask_of_node(nid)) {
> > +             struct rq *rq = cpu_rq(cpu);
> > +
> > +             ns->load += cpu_load(rq);
> > +             ns->util += cpu_util(cpu);
> > +             ns->nr_running += rq->cfs.h_nr_running;
> > +             ns->compute_capacity += capacity_of(cpu);
> > +     }
> > +
> > +     ns->weight = cpumask_weight(cpumask_of_node(nid));
> > +
> > +     ns->node_type = numa_classify(env->imbalance_pct, ns);
> > +}
> > +
> >  static void task_numa_assign(struct task_numa_env *env,
> >                            struct task_struct *p, long imp)
> >  {
