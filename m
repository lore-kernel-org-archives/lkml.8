Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87024C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A0FD207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592241712;
	bh=CwGcx1gJEnXaVwsKUYjXm50dgAZOqK50Bz4f01JpWpo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=iehwkSpzHgzTaBay1WNtiy5XUAUPa7L5dDdk6Sv680lRGxCdR8I5F2J7SEk8QRWm8
	 m/z+OYuYn/mRu0haYDcep86lNKSIv/0SItniN5GZiCI9D6cTljdqLPQ6aloZk5cVRS
	 AT9ZNxPb/iCZxoT2II+tknQRFuI9l6jxIFv55G1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbgFORVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729782AbgFORVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:21:50 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 019E9207D4;
        Mon, 15 Jun 2020 17:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592241710;
        bh=CwGcx1gJEnXaVwsKUYjXm50dgAZOqK50Bz4f01JpWpo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mkdeG63SraX9hKhayj9ufeTqTE/NI+P11ltzHiuWfyv65OtWxwe7lSiqw35jHzMBL
         Ax5/65YWoUXumXWUo5Wc1Qfd5DIYtRM85r8IwWzR29enNyG6EojjYWoizKzTh6mvxW
         ZSgvkdxo4v7hAoEAXfM1iQHtaBIKQk40Rfw3h08U=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A044335218F0; Mon, 15 Jun 2020 10:21:49 -0700 (PDT)
Date:   Mon, 15 Jun 2020 10:21:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, frederic@kernel.org
Subject: Re: [PATCH 0/6] sched: TTWU, IPI, and assorted stuff
Message-ID: <20200615172149.GJ2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200615125654.678940605@infradead.org>
 <20200615162330.GF2723@paulmck-ThinkPad-P72>
 <20200615164048.GC2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615164048.GC2531@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 06:40:48PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 15, 2020 at 09:23:30AM -0700, Paul E. McKenney wrote:
> > On Mon, Jun 15, 2020 at 02:56:54PM +0200, Peter Zijlstra wrote:
> > > Hi,
> > > 
> > > So Paul reported rcutorture hitting a NULL dereference, and patch #1 fixes it.
> > > 
> > > Now, patch #1 is obviously correct, but I can't explain how exactly it leads to
> > > the observed NULL pointer dereference. The NULL pointer deref happens in
> > > find_matching_se()'s last while() loop when is_same_group() fails even though
> > > both parents are NULL.
> > 
> > My bisection of yet another bug sometimes hits the scheduler NULL pointer
> > dereference on older commits.  I will try out patch #2.
> 
> Thanks! I've got 16*TREE03 running since this morning, so far so nothing :/
> (FWIW that's 16/9 times overcommit, idle time fluctuates around 10%).

My large system as large remote memory latencies, as in the better part
of a microsecond.  My small system is old (Haswell).  So, just to grasp
at the obvious straw, do you have access to a multisocket Haswell system?

Or maybe Thomas can reproduce this one as well?

Right now I am running your earlier fix patch against mainline commit
d2d5439df22f ("Merge tag 'for-linus-5.8b-rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip").

> > Whether this is reassuring or depressing, I have no idea.  :-/
> 
> Worrysome at least, I don't trust stuff I can't explain.

I know that feeling!

> > > The only explanation I have for that is that we just did an activate_task()
> > > while: 'task_cpu(p) != cpu_of(rq)', because then 'p->se.cfs_rq' doesn't match.
> > > However, I can't see how the lack of #1 would lead to that. Never-the-less,
> > > patch #2 adds assertions to warn us of this case.
> > > 
> > > Patch #3 is a trivial rename that ought to eradicate some confusion.
> > > 
> > > The last 3 patches is what I ended up with for cleaning up the whole
> > > smp_call_function/irq_work/ttwu thing more.
> > 
> > Would it be possible to allow a target CPU # on those instances of
> > __call_single_data?  This is extremely helpful for debugging lost
> > smp_call_function*() calls.
> 
> target or source ? Either would be possible, perhaps even both. We have
> a spare u32 in __call_single_node.

The target CPU is the immediate concern, but I could easily imagine
cases where the source CPU might also be needed.

> Something like the below on top of 1-4. If we want to keep this, we
> should probably stick it under some CONFIG_DBUG thing or other.

Looks plausible to me, and CONFIG_DEBUG or whatever makes a lot of
sense.

How would you like to proceed?  I can take this one and then port
the existing debug code on top of it, for example.

							Thanx, Paul

> --- a/include/linux/smp_types.h
> +++ b/include/linux/smp_types.h
> @@ -61,6 +61,7 @@ struct __call_single_node {
>  		unsigned int	u_flags;
>  		atomic_t	a_flags;
>  	};
> +	u16 src, dst;
>  };
>  
>  #endif /* __LINUX_SMP_TYPES_H */
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -135,8 +135,14 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(cal
>  
>  void __smp_call_single_queue(int cpu, struct llist_node *node)
>  {
> +	struct __call_single_node *n =
> +		container_of(node, struct __call_single_node, llist);
> +
>  	WARN_ON_ONCE(cpu == smp_processor_id());
>  
> +	n->src = smp_processor_id();
> +	n->dst = cpu;
> +
>  	/*
>  	 * The list addition should be visible before sending the IPI
>  	 * handler locks the list to pull the entry off it because of
> 
