Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93905C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EDB220720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589218459;
	bh=5Z7Qml4RQ3MPjBIIlhjG06U4sRXkHJ7HmXF/gF2FyYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C2Pmgxs+aHt9YdpyZL5Y2Q3H7RE919DLhRr43owaIkpEU4dh6ULcuGebPkmmHDEvd
	 B2QKON0efa9DGymxjX2UwfLsqFp4ZXOpH/g7nnidaiZOvRfYWsylfH5kPKrnRZEr87
	 sQo87e4sAmAG1+sn8j3H4eulthYpR0YiJidZ/Lhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbgEKReS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:34:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730215AbgEKReS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:34:18 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDD55206D6;
        Mon, 11 May 2020 17:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589218458;
        bh=5Z7Qml4RQ3MPjBIIlhjG06U4sRXkHJ7HmXF/gF2FyYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EdQthZ7eA7y0JgM/tZ+KCl24Ng8Bqo+RH6ZUw0/pUa6bsjFROzPLsAdUyLLKhucWD
         ooStrur1zZCuMCMttUQJo0AlyECjIT+5s8oKGQgXXQRXbmKMR29POVgfK9F3z50oLo
         YLpV7pljTGX1/UEr6FwPgktdYJ9dM+PjNekvXls4=
Date:   Mon, 11 May 2020 18:34:13 +0100
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, Elver Marco <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH -next v2] locking/osq_lock: annotate a data race in
 osq_lock
Message-ID: <20200511173412.GC23081@willie-the-truck>
References: <20200509161217.GN2869@paulmck-ThinkPad-P72>
 <45D9EEEB-D887-485D-9045-417A7F2C6A1A@lca.pw>
 <20200509213654.GO2869@paulmck-ThinkPad-P72>
 <20200511155812.GB22270@willie-the-truck>
 <20200511164319.GV2869@paulmck-ThinkPad-P72>
 <20200511165216.GA23081@willie-the-truck>
 <20200511172918.GW2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511172918.GW2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 10:29:18AM -0700, Paul E. McKenney wrote:
> On Mon, May 11, 2020 at 05:52:17PM +0100, Will Deacon wrote:
> > On Mon, May 11, 2020 at 09:43:19AM -0700, Paul E. McKenney wrote:
> > > On Mon, May 11, 2020 at 04:58:13PM +0100, Will Deacon wrote:
> > > > On Sat, May 09, 2020 at 02:36:54PM -0700, Paul E. McKenney wrote:
> > > > > diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> > > > > index 1f77349..1de006e 100644
> > > > > --- a/kernel/locking/osq_lock.c
> > > > > +++ b/kernel/locking/osq_lock.c
> > > > > @@ -154,7 +154,11 @@ bool osq_lock(struct optimistic_spin_queue *lock)
> > > > >  	 */
> > > > >  
> > > > >  	for (;;) {
> > > > > -		if (prev->next == node &&
> > > > > +		/*
> > > > > +		 * cpu_relax() below implies a compiler barrier which would
> > > > > +		 * prevent this comparison being optimized away.
> > > > > +		 */
> > > > > +		if (data_race(prev->next) == node &&
> > > > >  		    cmpxchg(&prev->next, node, NULL) == node)
> > > > >  			break;
> > > > 
> > > > I'm fine with the data_race() placement, but I don't find the comment
> > > > very helpful. We assign the result of a READ_ONCE() to 'prev' in the
> > > > loop, so I don't think that the cpu_relax() is really relevant.
> > > 
> > > Suppose that the compiler loaded a value that was not equal to "node".
> > > In that case, the cmpxchg() won't happen, so something else must force
> > > the compiler to do the reload in order to avoid an infinite loop, right?
> > > Or am I missing something here?
> > 
> > Then we just go round the loop and reload prev:
> > 
> > 	prev = READ_ONCE(node->prev);
> > 
> > which should be enough to stop the compiler, no?
> 
> Yes, that would also work.  Either have the cpu_relax() or a barrier()
> or whatever on the one hand, or, as you say, turn the data_race() into
> a READ_ONCE().  I personally prefer the READ_ONCE() myself, unless that
> would undesirably suppress other KCSAN warnings.

No, I mean here is the code after this patch is applied:

	for (;;) {
		if (data_race(prev->next) == node &&
		    cmpxchg(&prev->next, node, NULL) == node)
			break;

		/*
		 * We can only fail the cmpxchg() racing against an unlock(),
		 * in which case we should observe @node->locked becomming
		 * true.
		 */
		if (smp_load_acquire(&node->locked))
			return true;

		cpu_relax();

		/*
		 * Or we race against a concurrent unqueue()'s step-B, in which
		 * case its step-C will write us a new @node->prev pointer.
		 */
		prev = READ_ONCE(node->prev);
	}

I'm saying that this READ_ONCE at the end of the loop should be sufficient
to stop the compiler making value assumptions about prev->next. Do you
agree?

Will
