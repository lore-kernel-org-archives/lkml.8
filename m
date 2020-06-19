Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E27C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08445214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592592410;
	bh=rgZhKcine/cbKmZM9wvyxwvuVixJvYd8fRncSEC5uzs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=zaMtevFVbOWugib494Plyqwpu+bDaxegkdLzMsee3FS5jtzfzideL1jnmg1YwK/6u
	 GUQEOGRsHspBeLjoqDKv3fzpz23BL0yCvotshJSwYPfQ/byRzni9/SRqhJXCBRuXnk
	 toe6/3BFWfvd4gDweEQUZVFpI+m5Y7965cu9O68s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393272AbgFSSqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:46:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388053AbgFSSqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:46:45 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC4DF208D5;
        Fri, 19 Jun 2020 18:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592592404;
        bh=rgZhKcine/cbKmZM9wvyxwvuVixJvYd8fRncSEC5uzs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Hfg9Vci1KqtJGgjaS4wIYbVdmSUIENXTPnY3ixDzBeNrmxd2VjF4J6Nf/ANyZnu9w
         om/n+2iz/21y5MODJw6/qGEINCYio+bI/2Lrkdg4K67CmiuqfZ8v8fYPhSyCx/WqFo
         gilOhzvASbyrFmyQNDuUkZPwPK5Ea4hiqofvDQZk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A05093522B50; Fri, 19 Jun 2020 11:46:44 -0700 (PDT)
Date:   Fri, 19 Jun 2020 11:46:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, frederic@kernel.org,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        npiggin@gmail.com
Subject: Re: [PATCH 0/6] sched: TTWU, IPI, and assorted stuff
Message-ID: <20200619184644.GN2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200615162330.GF2723@paulmck-ThinkPad-P72>
 <20200615164048.GC2531@hirez.programming.kicks-ass.net>
 <20200615172149.GJ2723@paulmck-ThinkPad-P72>
 <20200615191158.GK2531@hirez.programming.kicks-ass.net>
 <20200616170410.GL2554@hirez.programming.kicks-ass.net>
 <20200616171721.GM2554@hirez.programming.kicks-ass.net>
 <20200619134423.GB577403@hirez.programming.kicks-ass.net>
 <20200619172047.GK2723@paulmck-ThinkPad-P72>
 <20200619174802.GA10403@paulmck-ThinkPad-P72>
 <20200619181128.GC576888@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619181128.GC576888@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 08:11:28PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 19, 2020 at 10:48:02AM -0700, Paul E. McKenney wrote:
> > On Fri, Jun 19, 2020 at 10:20:47AM -0700, Paul E. McKenney wrote:
> 
> > > > @@ -2615,7 +2617,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> > > >  	 * let the waker make forward progress. This is safe because IRQs are
> > > >  	 * disabled and the IPI will deliver after on_cpu is cleared.
> > > >  	 */
> > > > -	if (READ_ONCE(p->on_cpu) && ttwu_queue_wakelist(p, cpu, wake_flags | WF_ON_RQ))
> > > > +	if (smp_load_acquire(&p->on_cpu) &&
> > 
> > Given the x86 memory model, this only protects against the compiler
> > reordering accesses in ttwu_queue_wakelist() against the fetch of
> > p->on_cpu, correct?
> 
> Yes.
> 
> > Don't get me wrong, I do see some potential compiler misorderings,
> > including with cpu_rq(cpu)->nr_running.  Just curious.
> 
> Given this is arch independent code, I'd better write generic code, and
> there I really think this wants to be acquire. I'll also try and write a
> comment for next time.

I completely understand and agree.  Just trying to work out why my
systems hit this more than an order of magnitude more often than do
yours.  Compiler version might be important?  As noted on IRC, I am
using gcc 8.2.1.

							Thanx, Paul
