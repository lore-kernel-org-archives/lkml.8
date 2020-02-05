Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB2BC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86683218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580908272;
	bh=wSPjyDZaJd4iYDsHDvfTkbCVhxFTYWZXqFiynFRgSqQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=MS4O3XTnjF5iIs6tCFCuDRyu8YixNXvvMLyiO9CuUafF9K3MHZhsXoNQL7RkRba/K
	 FLMJOxluPqt3JaQwlumFjU+yMtxxKWyKI5ASU4ptgnoUkV9Dhi04F7VUgpqQpzdceQ
	 ta7Ht6xkmvPcVE816Iq3fol1wNLN96ewOjmj1JhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgBENLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:11:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:59118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbgBENLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:11:11 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D3B62082E;
        Wed,  5 Feb 2020 13:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580908270;
        bh=wSPjyDZaJd4iYDsHDvfTkbCVhxFTYWZXqFiynFRgSqQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lFln09VkBtkKNCzjna0O6RjF4HXeY041b+M9cjd6Gg+nM1BDA5etdYv1mR98VGfJD
         19dJOGyubTzNLTYO1TgPFs91g8c6SzX04APp359/ins/jR3jaif5VhBt3i8xwTGY3g
         EUEm4yg8Z6LWtBrnQ8/8skmEGJgZSklG5+b1A6AU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3EDCC352270F; Wed,  5 Feb 2020 05:11:10 -0800 (PST)
Date:   Wed, 5 Feb 2020 05:11:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Amol Grover <frextrite@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: Re: [PATCH] tracing: Annotate ftrace_graph_hash pointer with __rcu
Message-ID: <20200205131110.GT2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200201072703.17330-1-frextrite@gmail.com>
 <20200203163301.GB85781@google.com>
 <20200204200116.479f0c60@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204200116.479f0c60@oasis.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 08:01:16PM -0500, Steven Rostedt wrote:
> On Mon, 3 Feb 2020 11:33:01 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> 
> > > --- a/kernel/trace/trace.h
> > > +++ b/kernel/trace/trace.h
> > > @@ -950,22 +950,25 @@ extern void __trace_graph_return(struct trace_array *tr,
> > >  				 unsigned long flags, int pc);
> > >  
> > >  #ifdef CONFIG_DYNAMIC_FTRACE
> > > -extern struct ftrace_hash *ftrace_graph_hash;
> > > +extern struct ftrace_hash __rcu *ftrace_graph_hash;
> > >  extern struct ftrace_hash *ftrace_graph_notrace_hash;
> > >  
> > >  static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
> > >  {
> > >  	unsigned long addr = trace->func;
> > >  	int ret = 0;
> > > +	struct ftrace_hash *hash;
> > >  
> > >  	preempt_disable_notrace();
> > >  
> > > -	if (ftrace_hash_empty(ftrace_graph_hash)) {
> > > +	hash = rcu_dereference_protected(ftrace_graph_hash, !preemptible());  
> > 
> > I think you can use rcu_dereference_sched() here? That way no need to pass
> > !preemptible.
> > 
> > A preempt-disabled section is an RCU "sched flavor" section. Flavors are
> > consolidated in the backend, but in the front end the dereference API still
> > do have flavors.
> 
> Unfortunately, doing it with rcu_dereference_sched() causes a lockdep
> splat :-P. This is because ftrace can execute when rcu is not
> "watching" and that will trigger a lockdep error. That means, this
> origin patch *is* correct. I'm re-applying this one.

I strongly recommend a comment stating why disabling preemption prevents
ftrace_graph_hash from going away.  I see the synchronize_rcu() after
the rcu_assign_pointer() in ftrace_graph_release(), but I don't see
anything that waits on CPUs that RCU is not watching.

Of course, event tracing -makes- RCU watch when needed, but if that
was set up, then lockdep would not have complained.

So what am I missing?

							Thanx, Paul
