Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E327C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F33246A9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582829770;
	bh=LQ0WXpCM8stTZwuekeWBvrZIpMZ4vMG09DgE+tW0alM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ruyENaF1D/6s8yMxiLT++b66PFobW7Jz72fcFLaTW87ilpJL13WaoBjPCzSrqPfLI
	 EwbGMQBex3Bd49xmRu92RT0mYL+vOCPEp+ybqiYc4Nzm8wsg4FOJ2iFAEXWnQit+x3
	 ca+pbgLdbyWP4E/AyHxFmypFFwaPpgRUJduxbDg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbgB0S4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:56:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729564AbgB0S4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:56:08 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [163.114.132.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8EE1246A0;
        Thu, 27 Feb 2020 18:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582829767;
        bh=LQ0WXpCM8stTZwuekeWBvrZIpMZ4vMG09DgE+tW0alM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Zj1TBHwtCe6lsfbnWxvbU9UjcbNrn6iznIUA8E4IBU6un3v8UopUr252wzDqsvqYG
         R8NM6i01gs9TCU5zwnIk75Ynfz90tuKlgqKEhjXhIywHyp0SuA7SWWhNKGbdFQsO9m
         IzmVAUtIBpUu4kzLBqeU6PR9HQl1GkjXBsq1oD80=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 16BCD35211EA; Thu, 27 Feb 2020 10:56:07 -0800 (PST)
Date:   Thu, 27 Feb 2020 10:56:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Qian Cai <cai@lca.pw>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: suspicious RCU due to "Prefer using an idle CPU as a migration
 target instead of comparing tasks"
Message-ID: <20200227185607.GK2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1582812549.7365.134.camel@lca.pw>
 <1582814862.7365.135.camel@lca.pw>
 <jhjimjsvyoe.mognet@arm.com>
 <1582821327.7365.137.camel@lca.pw>
 <1582822024.7365.139.camel@lca.pw>
 <20200227171934.GI3818@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227171934.GI3818@techsingularity.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 05:19:34PM +0000, Mel Gorman wrote:
> On Thu, Feb 27, 2020 at 11:47:04AM -0500, Qian Cai wrote:
> > On Thu, 2020-02-27 at 11:35 -0500, Qian Cai wrote:
> > > On Thu, 2020-02-27 at 15:26 +0000, Valentin Schneider wrote:
> > > > On Thu, Feb 27 2020, Qian Cai wrote:
> > > > 
> > > > > On Thu, 2020-02-27 at 09:09 -0500, Qian Cai wrote:
> > > > > > The linux-next commit ff7db0bf24db ("sched/numa: Prefer using an idle CPU as a
> > > > > > migration target instead of comparing tasks") introduced a boot warning,
> > > > > 
> > > > > This?
> > > > > 
> > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > index a61d83ea2930..ca780cd1eae2 100644
> > > > > --- a/kernel/sched/fair.c
> > > > > +++ b/kernel/sched/fair.c
> > > > > @@ -1607,7 +1607,9 @@ static void update_numa_stats(struct task_numa_env *env,
> > > > > if (ns->idle_cpu == -1)
> > > > > ns->idle_cpu = cpu;
> > > > > 
> > > > > +rcu_read_lock();
> > > > > idle_core = numa_idle_core(idle_core, cpu);
> > > > > +rcu_read_unlock();
> > > > > }
> > > > > }
> > > > > 
> > > > 
> > > > 
> > > > Hmph right, we have
> > > > numa_idle_core()->test_idle_cores()->rcu_dereference().
> > > > 
> > > > Dunno if it's preferable to wrap the entirety of update_numa_stats() or
> > > > if that fine-grained read-side section is ok.
> > > 
> > > I could not come up with a better fine-grained one than this.
> > 
> > Correction -- this one,
> > 
> 
> Thanks for reporting this!
> 
> The proposed fix would be a lot of rcu locks and unlocks. While they are
> cheap, they're not free and it's a fairly standard pattern to acquire
> the rcu lock when scanning CPUs during a domain search (load balancing,
> nohz balance, idle balance etc). While in this context the lock is only
> needed for SMT, I do not think it's worthwhile fine-graining this or
> conditionally acquiring the rcu lock so will we keep it simple?

Indeed, scanning CPUs within a single RCU read-side critical section
should be OK.  As long as each CPU isn't burning too much time.  ;-)

						Thanx, Paul

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 11cdba201425..d34ac4ea5cee 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1592,6 +1592,7 @@ static void update_numa_stats(struct task_numa_env *env,
>  	memset(ns, 0, sizeof(*ns));
>  	ns->idle_cpu = -1;
>  
> +	rcu_read_lock();
>  	for_each_cpu(cpu, cpumask_of_node(nid)) {
>  		struct rq *rq = cpu_rq(cpu);
>  
> @@ -1611,6 +1612,7 @@ static void update_numa_stats(struct task_numa_env *env,
>  			idle_core = numa_idle_core(idle_core, cpu);
>  		}
>  	}
> +	rcu_read_unlock();
>  
>  	ns->weight = cpumask_weight(cpumask_of_node(nid));
>  
