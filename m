Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67950C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EDBC2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596150728;
	bh=m2t34d5YnSi9udUc3+Zve/FSetve41PZXbnLhDl0L0A=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=X4EVAUd+9aOBxbYe5n8rIP4N6QSQlAbakWHw82IEHESdWZnakeHFb8d/ocKsU958s
	 mw8ghtFZ1je2j6kQQoQ8LOA3OPEAizEwKDXvHtqTBPGHpR/ltw2tCtQy3qf+QqjbAV
	 JggKliwkeodHmNTwDQThebXcRq2Rp9FVrO+Qj8n0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbgG3XMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 19:12:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729896AbgG3XMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 19:12:06 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71BD620809;
        Thu, 30 Jul 2020 23:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596150725;
        bh=m2t34d5YnSi9udUc3+Zve/FSetve41PZXbnLhDl0L0A=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=F4nnpSxvFGAvdLHn6xWj4xZAJU4VmRYfPbR9WcWujLRTlZkMIVLkp2vyP5cb0l+7g
         58TzGPEOopo3Na1cctJ/0xq9ddlPipJBgUtB/OLsZGAK0pTe0yv1JAwT9r6JwtX5Ur
         lG0dOKKZifunmBQiuZiesz2nRw949ghrilCjSoZ0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 513BC3522635; Thu, 30 Jul 2020 16:12:05 -0700 (PDT)
Date:   Thu, 30 Jul 2020 16:12:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, willy@infradead.org, urezki@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Raw spinlocks and memory allocation
Message-ID: <20200730231205.GA11265@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

We have an interesting issue involving interactions between RCU,
memory allocation, and "raw atomic" contexts.  The most attractive
solution to this issue requires adding a new GFP_ flag.  Perhaps this
is a big ask, but on the other hand, the benefit is a large reduction
in linked-list-induced cache misses when invoking RCU callbacks.

For more details, please read on!

Examples of raw atomic contexts include disabled hardware interrupts
(that is, a hardware irq handler rather than a threaded irq handler),
code holding a raw_spinlock_t, and code with preemption disabled (but
only in cases where -rt cannot safely map it to disabled migration).

It turns out that call_rcu() is already invoked from raw atomic contexts,
and we therefore anticipate that kfree_rcu() will also be at some point.

This matters due to recent work to fix a weakness in both call_rcu()
and kfree_rcu() that was pointed out long ago by Christoph Lameter,
among others.  The weakness is that RCU traverses linked callback lists
when invoking those callbacks.  Because the just-ended grace period will
have rendered these lists cache-cold, this results in an expensive cache
miss on each and every callback invocation.  Uladzislau Rezki (CCed) has
recently produced patches for kfree_rcu() that instead store pointers
to callbacks in arrays, so that callback invocation can step through
the array using the kfree_bulk() interface.  This greatly reducing the
number of cache misses.  The benefits are not subtle:

https://lore.kernel.org/lkml/20191231122241.5702-1-urezki@gmail.com/

Of course, the arrays have to come from somewhere, and that somewhere
is the memory allocator.  Yes, memory allocation can fail, but in that
rare case, kfree_rcu() just falls back to the old approach, taking a
few extra cache misses, but making good (if expensive) forward progress.

This works well until someone invokes kfree_rcu() with a raw spinlock
held.  Even that works fine unless the memory allocator has exhausted
its caches, at which point it will acquire a normal spinlock.  In kernels
built with CONFIG_PROVE_RAW_LOCK_NESTING=y this will result in a lockdep
splat.  Worse yet, in -rt kernels, this can result in scheduling while
atomic.

So, may we add a GFP_ flag that will cause kmalloc() and friends to return
NULL when they would otherwise need to acquire their non-raw spinlock?
This avoids adding any overhead to the slab-allocator fastpaths, but
allows callback invocation to reduce cache misses without having to
restructure some existing callers of call_rcu() and potential future
callers of kfree_rcu().

Thoughts?

							Thanx, Paul

PS.  Other avenues investigated:

o	Just don't invoke kmalloc() when kfree_rcu() is invoked
	from raw atomic contexts.  The problem with this is that
	there is no way to detect raw atomic contexts in production
	kernels built with CONFIG_PREEMPT=n.  Adding means to detect
	this would increase overhead on numerous fastpaths.

o	Just say "no" to invoking call_rcu() and kfree_rcu() from
	raw atomic contexts.  This would require that the affected
	call_rcu() and kfree_rcu() invocations be deferred.  This is
	in theory simple, but can get quite messy, and often requires
	fallbacks such as timers that can degrade energy efficiency and
	realtime response.

o	Provide a different non-allocating API such as kfree_rcu_raw()
	and call_rcu_raw() that are used from raw atomic contexts and also
	on memory-allocation failure from kfree_rcu() and call_rcu().
	This results in unconditional callback-invocation cache misses
	for calls from raw contexts, including for common code that is
	only occasionally invoked from raw atomic contexts.  This approach
	also forces developers to worry about two more RCU API members.

o	Move the memory allocator's spinlocks to raw_spinlock_t.
	This would be bad for realtime response, and would likely require
	even more conversions when the allocator invokes other subsystems
	that also use non-raw spinlocks.
