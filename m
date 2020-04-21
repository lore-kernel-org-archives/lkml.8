Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B7DC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC722070B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587490760;
	bh=QF1+05dk/slmItoQhAvNaKvLSLjdXYQ42BslCBBfirY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=V5nKbEc+m7VJc3RwAx8S0ILBzb5BzxIqGqR5X/1gYMnpmbxq0y2TAMnr4kR8cy4aw
	 /fkHtW5qQf1Z4EIDz19ARfSMmpuAhjjFLmIgJY67tuzQr9SFe3tkSVve1XfzuWUTQd
	 ykKc4N8SzZzHVAacInUN2ltXA6ljsW45hFK34vfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgDURjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:39:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgDURjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:39:19 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DCF0206D9;
        Tue, 21 Apr 2020 17:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587490759;
        bh=QF1+05dk/slmItoQhAvNaKvLSLjdXYQ42BslCBBfirY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=yI1sPGI106lApWhdhZXySBdWafeZKfms2kGThJMkQzjiNdywnl8M6olzmztK5VfL6
         h+1tNxsXBIqAwaz/vfq5KHd5XD6hULgoHgC7RoePCFSnaSrh/01ux7SlMLN0AQnsks
         LP8W/81QgnGeYyFmaQz/TCE3UqeY6Dq/m7Cc6qqk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 108493523441; Tue, 21 Apr 2020 10:39:19 -0700 (PDT)
Date:   Tue, 21 Apr 2020 10:39:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Muchun Song <songmuchun@bytedance.com>, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        joel@joelfernandes.org
Subject: Re: [PATCH] sched/fair: Fix call walk_tg_tree_from() without hold
 rcu_lock
Message-ID: <20200421173919.GQ17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200406121008.62903-1-songmuchun@bytedance.com>
 <20200421135258.GS20730@hirez.programming.kicks-ass.net>
 <20200421154312.GO17661@paulmck-ThinkPad-P72>
 <20200421162452.GV20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421162452.GV20730@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 06:24:52PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 21, 2020 at 08:43:12AM -0700, Paul E. McKenney wrote:
> > On Tue, Apr 21, 2020 at 03:52:58PM +0200, Peter Zijlstra wrote:
> > > On Mon, Apr 06, 2020 at 08:10:08PM +0800, Muchun Song wrote:
> > > > The walk_tg_tree_from() caller must hold rcu_lock,
> > > 
> > > Not quite; with the RCU unification done 'recently' having preemption
> > > disabled is sufficient. AFAICT preemption is disabled.
> > > 
> > > In fact; and I mentioned this to someone the other day, perhaps Joel; we
> > > can go and delete a whole bunch of rcu_read_lock() from the scheduler --
> > > basically undo all the work we did after RCU was split many years ago.
> > 
> > "If only I knew then what I know now..."
> > 
> > Then again, I suspect that we all have ample opportunity to use that
> > particular old phrase.  ;-)
> 
> Quite so; I'm just fearing that rcu-lockdep annotation stuff. IIRC that
> doesn't (nor can it, in general) consider the implicit preempt-disable
> from locks and such for !PREEMPT builds.

Heh!  Now that might be me using that phrase again some time in the
future rather than you using it.  ;-)

But what exactly are you looking for?  After all, in !PREEMPT builds,
preemption is always disabled.  It should not be too hard to make
something that looked at the state provided by DEBUG_ATOMIC_SLEEP when
selected, for example.  Alternatively, there is always the option
of doing the testing in CONFIG_PREEMPT=y kernels.

But again, what exactly are you looking for?

							Thanx, Paul
