Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7956DC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54A212070B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589218160;
	bh=Y0AyRy5PytrhGgLmg/Hp8S/MBbv7FCy3LT/yIl4vMN0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=R7mktIPOKsFNdFRS/Eg3zuybhoZLTvTc/CaztUgwKfk/yMqaVQM9aU2brGv0au8Q0
	 gs5T34WgmwGNoleVrKGXOVGBS2xi8dRLBH1ez77c57CrahZa0mPhL2fma8VW0jQy5w
	 ylLBStQsanKOzYLnabQ/rOPPol7oj4Pfpurb3JAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbgEKR3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:29:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730215AbgEKR3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:29:19 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2C13206D6;
        Mon, 11 May 2020 17:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589218158;
        bh=Y0AyRy5PytrhGgLmg/Hp8S/MBbv7FCy3LT/yIl4vMN0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Qpf47/BPnvhjPbF6hg3/O93LZ01qHIvN8hjY9L1WXYtQMIrPordVZeOYVS5nyTvuX
         nF+TWYJk3YilcqnK2lNjdGSgiONaSwp1ks3/mx8JLnKtdH6qpDX9cDk9Pv9fG/271D
         mfo9IZf+2SDuXfZKE+LDsqiVAyfi+yVdPKj9mZrQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 90648352271C; Mon, 11 May 2020 10:29:18 -0700 (PDT)
Date:   Mon, 11 May 2020 10:29:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, Elver Marco <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH -next v2] locking/osq_lock: annotate a data race in
 osq_lock
Message-ID: <20200511172918.GW2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200509161217.GN2869@paulmck-ThinkPad-P72>
 <45D9EEEB-D887-485D-9045-417A7F2C6A1A@lca.pw>
 <20200509213654.GO2869@paulmck-ThinkPad-P72>
 <20200511155812.GB22270@willie-the-truck>
 <20200511164319.GV2869@paulmck-ThinkPad-P72>
 <20200511165216.GA23081@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511165216.GA23081@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 05:52:17PM +0100, Will Deacon wrote:
> On Mon, May 11, 2020 at 09:43:19AM -0700, Paul E. McKenney wrote:
> > On Mon, May 11, 2020 at 04:58:13PM +0100, Will Deacon wrote:
> > > On Sat, May 09, 2020 at 02:36:54PM -0700, Paul E. McKenney wrote:
> > > > diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> > > > index 1f77349..1de006e 100644
> > > > --- a/kernel/locking/osq_lock.c
> > > > +++ b/kernel/locking/osq_lock.c
> > > > @@ -154,7 +154,11 @@ bool osq_lock(struct optimistic_spin_queue *lock)
> > > >  	 */
> > > >  
> > > >  	for (;;) {
> > > > -		if (prev->next == node &&
> > > > +		/*
> > > > +		 * cpu_relax() below implies a compiler barrier which would
> > > > +		 * prevent this comparison being optimized away.
> > > > +		 */
> > > > +		if (data_race(prev->next) == node &&
> > > >  		    cmpxchg(&prev->next, node, NULL) == node)
> > > >  			break;
> > > 
> > > I'm fine with the data_race() placement, but I don't find the comment
> > > very helpful. We assign the result of a READ_ONCE() to 'prev' in the
> > > loop, so I don't think that the cpu_relax() is really relevant.
> > 
> > Suppose that the compiler loaded a value that was not equal to "node".
> > In that case, the cmpxchg() won't happen, so something else must force
> > the compiler to do the reload in order to avoid an infinite loop, right?
> > Or am I missing something here?
> 
> Then we just go round the loop and reload prev:
> 
> 	prev = READ_ONCE(node->prev);
> 
> which should be enough to stop the compiler, no?

Yes, that would also work.  Either have the cpu_relax() or a barrier()
or whatever on the one hand, or, as you say, turn the data_race() into
a READ_ONCE().  I personally prefer the READ_ONCE() myself, unless that
would undesirably suppress other KCSAN warnings.

							Thanx, Paul
