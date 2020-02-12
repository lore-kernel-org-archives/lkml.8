Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533E4C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DBD2073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/EY/1vo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgBLPDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:03:43 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43815 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbgBLPDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:03:43 -0500
Received: by mail-lf1-f66.google.com with SMTP id 9so1824523lfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 07:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mJjUPQPGWzcs5bvAiI21vS0L5Gpnej33TBvxNbVOgSU=;
        b=B/EY/1voNoXzgMNiBuTQdRkXq4qfG/V3Zx2xexNx/Q1pMAyzZvwTj83zHfZ8KjiYnb
         sZ24ECoyQ/8awiQUnvwW8Bp66smCmY/ZGoHjqwnAIPDOgOY1xu/KHPW6wH56h2/5UV3A
         DM6Ve9M+3C3Em2YSQb/2q1dh9e0RBPnbUVXXU/sCeaxgga+DzP9AzDUMIYRiTwfnW52S
         2TxjSfJQXZeYDubAgyjdoSOpVvLt6ghQS0N918IRhizYXfXSs/c7yLX66erZEUwBbk3E
         SMhyYLvyQ4PXRg7dhke4qqqrUAY+5ymxxpcuag/1sm7dK3boOaE5t1ty0IQ341ZweA4b
         152A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mJjUPQPGWzcs5bvAiI21vS0L5Gpnej33TBvxNbVOgSU=;
        b=UqO/hajS6wxtdDU3qkIUf8fvtf6EysER+4BnMcMjpavChwmp9msxODmSwMUAq73Lka
         YafmDXLEikYmdGuZ4u8XlICghEePF/uEw4IYuJXVYzD6AD6n2Y8LIwUPRDdPlsooYuNg
         rOyWEGJcUmXUKxT4YaGz+Mgt5HKaw+3gzz9tZN644i5h2oYnr7lUfsrr9bSyD4SC77Lf
         ifJFOElymstXwIlYNKjRSaCyroOnl5F6d5pKdWI6JhFBv4B75tLPkqkT+bHF4MO2lT67
         qsp9e8lJybkuTNDZiu9/h2sOrcTutfY6nqWOIp7LuuUfhe3yqvJT+0uB/ACHPfIkSJX1
         GeGg==
X-Gm-Message-State: APjAAAWWwabJHbdRKEvyk/QB/TVZ7WyYeOSaQ63qwU0m06TIFWAdL0Bi
        c3FQvBNtB0aoRijdIklrLgIfBcfpE+Jgu8Sr4y/jYefvY1SLng==
X-Google-Smtp-Source: APXvYqzdKTMQbbWbkl4hxV5duXRwdbTo16CAKO67F9sB05Hk18MPwDKsxrsmtBk8IJD+A8k/LoYk7X7Vm7SJzRBwgRk=
X-Received: by 2002:ac2:59dd:: with SMTP id x29mr6818241lfn.95.1581519820104;
 Wed, 12 Feb 2020 07:03:40 -0800 (PST)
MIME-Version: 1.0
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
 <20200211174651.10330-3-vincent.guittot@linaro.org> <20200212133715.GU3420@suse.de>
In-Reply-To: <20200212133715.GU3420@suse.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 12 Feb 2020 16:03:28 +0100
Message-ID: <CAKfTPtAJE_eDgR8dmScgVbOgS9sQSJg27Mw62Z1htMCmgN_Yew@mail.gmail.com>
Subject: Re: [RFC 2/4] sched/numa: replace runnable_load_avg by load_avg
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 at 14:37, Mel Gorman <mgorman@suse.de> wrote:
>
> On Tue, Feb 11, 2020 at 06:46:49PM +0100, Vincent Guittot wrote:
> > Similarly to what has been done for the normal load balance, we can
> > replace runnable_load_avg by load_avg in numa load balancing and track
> > other statistics like the utilization and the number of running tasks to
> > get to better view of the current state of a node.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 102 ++++++++++++++++++++++++++++++++------------
> >  1 file changed, 75 insertions(+), 27 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index a1ea02b5362e..6e4c2b012c48 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
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
> >
>
> Ok, to reconcile this with the load balancer, it would need to account
> for imbalanced but that's ok in the context of this patch.
>
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
>
> Ok, so this is essentially group_is_overloaded.
>
>
> > +     if ((ns->nr_running < ns->weight) ||
> > +         ((ns->compute_capacity * 100) > (ns->util * imbalance_pct)))
> > +             return node_has_spare;
> > +
>
> And this is group_has_capacity. What I did was have a common helper
> for both NUMA and normal load balancing and translated the fields from
> sg_lb_stats and numa_stats into a common helper. This is to prevent them
> getting out of sync. The conversion was incomplete in my case but in
> principle, both NUMA and CPU load balancing should use common helpers or
> they'll get out of sync.

I fact, I wanted to keep this patch simple and readable for the 1st
version in order to not afraid people from reviewing it. That's the
main reason I didn't merge it with load_balance but i agree that some
common helper function might be possible.

Also the struct sg_lb_stats has a lot more fields compared to struct numa_stats

Then, I wonder if we could end up with different rules for numa like
taking into account some NUMA specifics metrics to classify the node

>
>
> > +     return node_fully_busy;
> > +}
> > +
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
>
> Ok, this is more or less what I had except I wedged other stuff in there
> too specific to NUMA balancing to avoid multiple walks of the cpumask.
>
> >  static void task_numa_assign(struct task_numa_env *env,
> >                            struct task_struct *p, long imp)
> >  {
> > @@ -1556,6 +1594,11 @@ static bool load_too_imbalanced(long src_load, long dst_load,
> >       long orig_src_load, orig_dst_load;
> >       long src_capacity, dst_capacity;
> >
> > +
> > +     /* If dst node has spare capacity, there is no real load imbalance */
> > +     if (env->dst_stats.node_type == node_has_spare)
> > +             return false;
> > +
>
> Not exactly what the load balancer thinks though, the load balancer
> may decide to balance the tasks between NUMA groups even when there is
> capacity. That said, what you did here is compatible with the current code.
>
> I'll want to test this further but in general
>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
>
> However, I really would have preferred if numa_classify shared common
> code with group_[is_overloaded|has_capacity] instead of having
> equivalent but different implementations.
>
> >       /*
> >        * The load is corrected for the CPU capacity available on each node.
> >        *
> > @@ -1788,10 +1831,10 @@ static int task_numa_migrate(struct task_struct *p)
> >       dist = env.dist = node_distance(env.src_nid, env.dst_nid);
> >       taskweight = task_weight(p, env.src_nid, dist);
> >       groupweight = group_weight(p, env.src_nid, dist);
> > -     update_numa_stats(&env.src_stats, env.src_nid);
> > +     update_numa_stats(&env, &env.src_stats, env.src_nid);
> >       taskimp = task_weight(p, env.dst_nid, dist) - taskweight;
> >       groupimp = group_weight(p, env.dst_nid, dist) - groupweight;
> > -     update_numa_stats(&env.dst_stats, env.dst_nid);
> > +     update_numa_stats(&env, &env.dst_stats, env.dst_nid);
> >
> >       /* Try to find a spot on the preferred nid. */
> >       task_numa_find_cpu(&env, taskimp, groupimp);
> > @@ -1824,7 +1867,7 @@ static int task_numa_migrate(struct task_struct *p)
> >
> >                       env.dist = dist;
> >                       env.dst_nid = nid;
> > -                     update_numa_stats(&env.dst_stats, env.dst_nid);
> > +                     update_numa_stats(&env, &env.dst_stats, env.dst_nid);
> >                       task_numa_find_cpu(&env, taskimp, groupimp);
> >               }
> >       }
> > @@ -5446,6 +5489,11 @@ static unsigned long cpu_load_without(struct rq *rq, struct task_struct *p)
> >       return load;
> >  }
> >
> > +static unsigned long cpu_runnable_load(struct rq *rq)
> > +{
> > +     return cfs_rq_runnable_load_avg(&rq->cfs);
> > +}
> > +
> >  static unsigned long capacity_of(int cpu)
> >  {
> >       return cpu_rq(cpu)->cpu_capacity;
> > --
> > 2.17.1
> >
>
> --
> Mel Gorman
> SUSE Labs
