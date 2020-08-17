Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5C4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 121CF207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597669212;
	bh=RMvr6YO+zDnQv57z11+kDa9qwJd5VGOLgh5RiQrKqsI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=MFM2VuNyuEYskcR/8jwS32ykNUTGVXvtRdAeifRQmIYQ6Y6YiUHv5O/BSq1y0LPp3
	 EfuFJHMXJswuuQqLmE2tEyzgKvauVpCkeJaTKNDN1zkoHpqUS85ZRsvWfdso3NVNxx
	 HEOIhnFJM6C0i+w5NDV6s/8mydzfoufA9T0dd04c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgHQNAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728422AbgHQNAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:00:06 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94E5D2078D;
        Mon, 17 Aug 2020 13:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597669205;
        bh=RMvr6YO+zDnQv57z11+kDa9qwJd5VGOLgh5RiQrKqsI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gPXeMUZxrJsLtySD17uBZEOxp386qqqH8HtblHyMvvRmLlQ+UkDeeyEhQdZcdfB97
         FBkVqam4y4xLCJrsGAoko0b432FgsPjIWgQaDUPoUzGo5geqetxVCcfYn+MAkJQPY5
         maQqiHjlc+8v41pE68NCBKjL7hqED2RSYwcSr/Hs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 726CC3522CAE; Mon, 17 Aug 2020 06:00:05 -0700 (PDT)
Date:   Mon, 17 Aug 2020 06:00:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, will@kernel.org, hch@lst.de,
        axboe@kernel.dk, chris@chris-wilson.co.uk, davem@davemloft.net,
        kuba@kernel.org, fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [RFC][PATCH 1/9] irq_work: Cleanup
Message-ID: <20200817130005.GC23602@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200722150149.525408253@infradead.org>
 <20200722153017.024407984@infradead.org>
 <20200723161411.GA23103@paulmck-ThinkPad-P72>
 <20200817090325.GK2674@hirez.programming.kicks-ass.net>
 <20200817091633.GL35926@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817091633.GL35926@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 11:16:33AM +0200, peterz@infradead.org wrote:
> On Mon, Aug 17, 2020 at 11:03:25AM +0200, peterz@infradead.org wrote:
> > On Thu, Jul 23, 2020 at 09:14:11AM -0700, Paul E. McKenney wrote:
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -1287,8 +1287,6 @@ static int rcu_implicit_dynticks_qs(stru
> > > >  		if (IS_ENABLED(CONFIG_IRQ_WORK) &&
> > > >  		    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
> > > >  		    (rnp->ffmask & rdp->grpmask)) {
> > > > -			init_irq_work(&rdp->rcu_iw, rcu_iw_handler);
> > > 
> > > We are actually better off with the IRQ_WORK_INIT_HARD() here rather
> > > than unconditionally at boot.
> > 
> > Ah, but there isn't an init_irq_work() variant that does the HARD thing.
> 
> Ah you meant doing:
> 
> 		rdp->rcu_iw = IRQ_WORK_INIT_HARD(rcu_iw_handler)
> 
> But then it is non-obvious how that doesn't trample state. I suppose
> that rcu_iw_pending thing ensures that... I'll think about it.

Yes, this is what I had in mind.  And you are right, the point of the
!rdp->rcu_iw_pending check is to prevent initialization while still
in use.

> > > The reason for this is that we get here only if a single grace
> > > period extends beyond 10.5 seconds (mainline) or beyond 30 seconds
> > > (many distribution kernels).  Which almost never happens.  And yes,
> > > rcutree_prepare_cpu() is also invoked as each CPU that comes online,
> > > not that this is all that common outside of rcutorture and boot time.  ;-)
> > 
> > What do you mean 'also' ? Afaict this is CPU bringup only code (initial
> > and hotplug). We really don't care about code there. It's the slowest
> > possible path we have in the kernel.

The "also" was acknowledging that a workload with lots of CPU hotplug
would also needlessly invoke IRQ_WORK_INIT_HARD() multiple times.

							Thanx, Paul

> > > > -			atomic_set(&rdp->rcu_iw.flags, IRQ_WORK_HARD_IRQ);
> > > >  			rdp->rcu_iw_pending = true;
> > > >  			rdp->rcu_iw_gp_seq = rnp->gp_seq;
> > > >  			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
> > 
