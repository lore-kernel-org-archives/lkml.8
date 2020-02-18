Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11F3C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A72624654
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qx/Ndevz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgBRQvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:51:33 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37452 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgBRQvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:51:33 -0500
Received: by mail-lf1-f65.google.com with SMTP id b15so15046137lfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 08:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5zZ75K1w4t2h/6FHw5+qkGDgcX0ElQAs8/WEopDoc0=;
        b=Qx/Ndevzjm6AQqQl0JlGZ/D9FIhWS2JKw/YZNWKSqCqptoZ2SPo32DPkmTsvLXYajh
         txOx5GWT9abYHj4mdgeuN9V3zuv3zIdLzGV1qMFLg6yPi64miygWVSbXYCU2bmiIv4lN
         VXbjmepNbPYMKXI7ttnVgDcmBbVti5dEbtcIFt6DevKG1wXIcRBdscs8+5z7mcC/fZKo
         EhdTJ2Jf5R7fVyoeT1yGniWRdf2vHeezuHzGO+x8KfxhJ+GClpI/F8yQEhYGmjVUQkho
         D1iij6h2pB0Q8QtA5n8cylT+oTiA1jVnoRdE3BRCoS70PMcddEXCH8vl8wmzPjFUEZ5g
         khMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5zZ75K1w4t2h/6FHw5+qkGDgcX0ElQAs8/WEopDoc0=;
        b=EcJl9DuFQ/ueQQugQlsmxezPfZqG7HddWbdxZhcmffvHnaKmUauXHBK5MENl3qbMsy
         QuI9AWCkBhbYWHQLz1ZF/VGk3JoBJXEke5GxuDz2mKxWgAZ5E83ijcvzeHuaIGc0QiGm
         ccA9ZTsWILxeLJgUkNwtdo5m2t/yO5cdQesY9Hwvm1MdEJF9YYHzBQb7AyMp7ZDleSvB
         kmtoIW7+q9YNnW5X3HE697n5fS0Y8T8pYVoOXP5V+s6CsbBW5xKpVaytTmQ7a9g/8seS
         D0zZe7DQNzEM8ADgxdaN6v0SaGmFXq8+fpfZo3K4SMAfa7zA8hEvLcoBMcCmMn4zCpc5
         Gnaw==
X-Gm-Message-State: APjAAAXbRejn9tm3WbUlPuoRAJ3gVkLAr1iRnaOqW9TieD8Wwjqkczw1
        8nNjbvrCNIu2ZT94lBcPSHsLd5LL1RqSKsRCoZdMEA==
X-Google-Smtp-Source: APXvYqzEUZOWLFX7pzHXY0easL1vehb6ONtaxCBUvYOfCQl9UOcMfrAB1kIkkF1eUrzfhIU5fb1RtDbMELf46llfjH4=
X-Received: by 2002:a19:5504:: with SMTP id n4mr10335948lfe.25.1582044689196;
 Tue, 18 Feb 2020 08:51:29 -0800 (PST)
MIME-Version: 1.0
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-3-vincent.guittot@linaro.org> <b67ae78b-17ba-8f3f-9052-fecefb848e3d@arm.com>
 <20200218153801.GF3420@suse.de>
In-Reply-To: <20200218153801.GF3420@suse.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 18 Feb 2020 17:51:17 +0100
Message-ID: <CAKfTPtCjXhjb3_Qpd3UBDx43FwE-7Vh=yDFfWuBGM6MdN9_n9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] sched/numa: Replace runnable_load_avg by load_avg
To:     Mel Gorman <mgorman@suse.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 at 16:38, Mel Gorman <mgorman@suse.de> wrote:
>
> On Tue, Feb 18, 2020 at 02:54:14PM +0000, Valentin Schneider wrote:
> > On 2/14/20 3:27 PM, Vincent Guittot wrote:
> > > @@ -1473,38 +1473,35 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
> > >            group_faults_cpu(ng, src_nid) * group_faults(p, dst_nid) * 4;
> > >  }
> > >
> > > -static inline unsigned long cfs_rq_runnable_load_avg(struct cfs_rq *cfs_rq);
> > > -
> > > -static unsigned long cpu_runnable_load(struct rq *rq)
> > > -{
> > > -   return cfs_rq_runnable_load_avg(&rq->cfs);
> > > -}
> > > +/*
> > > + * 'numa_type' describes the node at the moment of load balancing.
> > > + */
> > > +enum numa_type {
> > > +   /* The node has spare capacity that can be used to run more tasks.  */
> > > +   node_has_spare = 0,
> > > +   /*
> > > +    * The node is fully used and the tasks don't compete for more CPU
> > > +    * cycles. Nevertheless, some tasks might wait before running.
> > > +    */
> > > +   node_fully_busy,
> > > +   /*
> > > +    * The node is overloaded and can't provide expected CPU cycles to all
> > > +    * tasks.
> > > +    */
> > > +   node_overloaded
> > > +};
> >
> > Could we reuse group_type instead? The definitions are the same modulo
> > s/group/node/.
> >
>
> I kept the naming because there is the remote possibility that NUMA
> balancing will deviate in some fashion. Right now, it's harmless.

+1
This 1st round mainly aims to align NUMA way of working with load
balance but we can imagine using some NUMA or memory specific
information to create new state

>
> > >
> > >  /* Cached statistics for all CPUs within a node */
> > >  struct numa_stats {
> > >     unsigned long load;
> > > -
> > > +   unsigned long util;
> > >     /* Total compute capacity of CPUs on a node */
> > >     unsigned long compute_capacity;
> > > +   unsigned int nr_running;
> > > +   unsigned int weight;
> > > +   enum numa_type node_type;
> > >  };
> > >
> > > -/*
> > > - * XXX borrowed from update_sg_lb_stats
> > > - */
> > > -static void update_numa_stats(struct numa_stats *ns, int nid)
> > > -{
> > > -   int cpu;
> > > -
> > > -   memset(ns, 0, sizeof(*ns));
> > > -   for_each_cpu(cpu, cpumask_of_node(nid)) {
> > > -           struct rq *rq = cpu_rq(cpu);
> > > -
> > > -           ns->load += cpu_runnable_load(rq);
> > > -           ns->compute_capacity += capacity_of(cpu);
> > > -   }
> > > -
> > > -}
> > > -
> > >  struct task_numa_env {
> > >     struct task_struct *p;
> > >
> > > @@ -1521,6 +1518,47 @@ struct task_numa_env {
> > >     int best_cpu;
> > >  };
> > >
> > > +static unsigned long cpu_load(struct rq *rq);
> > > +static unsigned long cpu_util(int cpu);
> > > +
> > > +static inline enum
> > > +numa_type numa_classify(unsigned int imbalance_pct,
> > > +                    struct numa_stats *ns)
> > > +{
> > > +   if ((ns->nr_running > ns->weight) &&
> > > +       ((ns->compute_capacity * 100) < (ns->util * imbalance_pct)))
> > > +           return node_overloaded;
> > > +
> > > +   if ((ns->nr_running < ns->weight) ||
> > > +       ((ns->compute_capacity * 100) > (ns->util * imbalance_pct)))
> > > +           return node_has_spare;
> > > +
> > > +   return node_fully_busy;
> > > +}
> > > +
> >
> > As Mel pointed out, this is group_is_overloaded() and group_has_capacity().
> > @Mel, you mentioned having a common helper, do you have that laying around?
> > I haven't seen it in your reconciliation series.
> >
>
> I didn't merge that part of the first version of my series. I was
> waiting to see how the implementation for allowing a small degree of
> imbalance looks like. If it's entirely confined in adjust_numa_balance
> then I'll create the common helper at the same time. For now, I left the
> possibility open that numa_classify would use something different than
> group_is_overloaded or group_has_capacity even if I find that hard to
> imagine at the moment.
>
> > What I'm naively thinking here is that we could have either move the whole
> > thing to just sg_lb_stats (AFAICT the fields of numa_stats are a subset of it),
> > or if we really care about the stack we could tweak the ordering to ensure
> > we can cast one into the other (not too enticed by that one though).
> >
>
> Yikes, no I'd rather not do that. Basically all I did before was create
> a common helper like __lb_has_capacity that only took basic types as
> parameters. group_has_capacity and numa_has_capacity were simple wrappers
> that read the correct fields from their respective stats structures.
>
> --
> Mel Gorman
> SUSE Labs
