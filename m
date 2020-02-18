Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89CFC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC99208C4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgBRNvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 08:51:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:43334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgBRNvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:51:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F07D0BC9D;
        Tue, 18 Feb 2020 13:51:03 +0000 (UTC)
Date:   Tue, 18 Feb 2020 13:50:59 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, valentin.schneider@arm.com, hdanton@sina.com
Subject: Re: [PATCH v2 2/5] sched/numa: Replace runnable_load_avg by load_avg
Message-ID: <20200218135059.GE3420@suse.de>
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-3-vincent.guittot@linaro.org>
 <ecbf5317-e6cf-fc20-9871-4ea06a987952@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <ecbf5317-e6cf-fc20-9871-4ea06a987952@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 01:37:45PM +0100, Dietmar Eggemann wrote:
> On 14/02/2020 16:27, Vincent Guittot wrote:
> 
> [...]
> 
> >  	/*
> >  	 * The load is corrected for the CPU capacity available on each node.
> >  	 *
> > @@ -1788,10 +1831,10 @@ static int task_numa_migrate(struct task_struct *p)
> >  	dist = env.dist = node_distance(env.src_nid, env.dst_nid);
> >  	taskweight = task_weight(p, env.src_nid, dist);
> >  	groupweight = group_weight(p, env.src_nid, dist);
> > -	update_numa_stats(&env.src_stats, env.src_nid);
> > +	update_numa_stats(&env, &env.src_stats, env.src_nid);
> 
> This looks strange. Can you do:
> 
> -static void update_numa_stats(struct task_numa_env *env,
> +static void update_numa_stats(unsigned int imbalance_pct,
>                               struct numa_stats *ns, int nid)
> 
> -    update_numa_stats(&env, &env.src_stats, env.src_nid);
> +    update_numa_stats(env.imbalance_pct, &env.src_stats, env.src_nid);
> 

You'd also have to pass in env->p and while it could be done, I do not
think its worthwhile.

> [...]
> 
> > +static unsigned long cpu_runnable_load(struct rq *rq)
> > +{
> > +	return cfs_rq_runnable_load_avg(&rq->cfs);
> > +}
> > +
> 
> Why not remove cpu_runnable_load() in this patch rather moving it?
> 
> kernel/sched/fair.c:5492:22: warning: ???cpu_runnable_load??? defined but
> not used [-Wunused-function]
>  static unsigned long cpu_runnable_load(struct rq *rq)
> 

I took the liberty of addressing that when I picked up Vincent's patches
for "Reconcile NUMA balancing decisions with the load balancer v3" to fix
a build warning. I did not highlight it when I posted because it was such
a trivial change.

-- 
Mel Gorman
SUSE Labs
