Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D55C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B456D20674
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aTE4Co+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbgGHPff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730055AbgGHPfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:35:34 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A056C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 08:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=06DhFPI/bSOhbMuJCIcZ8o36pTZoMD/PMuyDuMUF1Y4=; b=aTE4Co+I1bx48kwkvSSgEEIL5C
        1u2r4hQ/VMBHcC499jkSzdOngZTTbBuhlZF/JLHmwLXe3qUwZkbKdfmzSYuB8Zot2XWOf8H0tOIfo
        NBTXOOSIsLP4h5KxdUNOekSP9eUz3rke9RX4F2/o9uP8yaJpA75+Cg/3zprFcFXwtWLZGWiHLLtG+
        T00UWrzW44Q6rz9MmnHTVx7g2Pc+nmFb0IaKpF6gjwKSXgK5EwS4JR34g0iCXssFxYhcGbitXPuka
        +RF7oKT6RZmDj4CoIFfNoNnNPcjOOEXsEViwgvNwxQ7i9PjmvADDEfLpkXP7uIj9Ga+L+2H5p99FY
        KOHCcszQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtC6X-0005lc-Ch; Wed, 08 Jul 2020 15:35:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81765305C11;
        Wed,  8 Jul 2020 17:35:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3EE6A214ECDA4; Wed,  8 Jul 2020 17:35:22 +0200 (CEST)
Date:   Wed, 8 Jul 2020 17:35:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/20] seqlock: Extend seqcount API with associated
 locks
Message-ID: <20200708153522.GR4800@hirez.programming.kicks-ass.net>
References: <20200630054452.3675847-1-a.darwish@linutronix.de>
 <20200630054452.3675847-7-a.darwish@linutronix.de>
 <20200706212148.GE5523@worktop.programming.kicks-ass.net>
 <20200707084024.GA4097637@debian-buster-darwi.lab.linutronix.de>
 <20200707130410.GO4800@hirez.programming.kicks-ass.net>
 <20200707143726.GO117543@hirez.programming.kicks-ass.net>
 <20200708103314.GB4151780@debian-buster-darwi.lab.linutronix.de>
 <20200708122938.GQ4800@hirez.programming.kicks-ass.net>
 <20200708150930.GA147323@debian-buster-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708150930.GA147323@debian-buster-darwi.lab.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 05:09:30PM +0200, Ahmed S. Darwish wrote:
> On Wed, Jul 08, 2020 at 02:29:38PM +0200, Peter Zijlstra wrote:

> > How about something disguisting like this then?
> >
> ...
> > #define __SEQ_RT	IS_BUILTIN(CONFIG_PREEMPT_RT)
> >
> > SEQCOUNT_LOCKTYPE(raw_spinlock, raw_spinlock_t,	false,		lock)
> > SEQCOUNT_LOCKTYPE(spinlock,	spinlock_t,		__SEQ_RT,	lock)
> > SEQCOUNT_LOCKTYPE(rwlock,	rwlock_t,		__SEQ_RT,	lock)
> > SEQCOUNT_LOCKTYPE(mutex,	struct mutex,		true,		lock)
> > SEQCOUNT_LOCKTYPE(ww_mutex,	struct ww_mutex,	true,		lock->base)
> >
> > #if (defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 40900) || defined(__CHECKER__)
> >
> > #define __seqprop_pick(const_expr, s, locktype, prop, otherwise)	\
> > 	__builtin_choose_expr(const_expr,				\
> > 			      __seqprop_##locktype##_##prop((void *)(s)), \
> > 			      otherwise)
> >
> > extern void __seqprop_invalid(void);
> >
> > #define __seqprop(s, prop)								\
> > 	__seqprop_pick(__same_type(*(s), seqcount_t), (s), seqcount, prop,		\
> > 	  __seqprop_pick(__same_type(*(s), seqcount_raw_spinlock_t), (s), raw_spinlock, prop, \
> > 	    __seqprop_pick(__same_type(*(s), seqcount_spinlock_t), (s), spinlock, prop,	\
> > 	      __seqprop_pick(__same_type(*(s), seqcount_rwlock_t), (s), rwlock, prop,	\
> > 	        __seqprop_pick(__same_type(*(s), seqcount_mutex_t), (s), mutex, prop,	\
> > 	          __seqprop_pick(__same_type(*(s), seqcount_ww_mutex_t), (s), ww_mutex, prop, \
> > 		    __seqprop_invalid()))))))
> >
> > #else
> >
> > #define __seqprop_case(s, locktype, prop) \
> > 	seqcount_##locktype##_t: __seqprop_##locktype##_##prop((void *)s)
> >
> > #define __seqprop(s, prop)					\
> > 	_Generic(*(s),						\
> > 		 seqcount_t: __seqprop_seqcount_##prop((void*)s),\
> > 		 __seqprop_case((s), raw_spinlock, prop),	\
> > 		 __seqprop_case((s), spinlock, prop),		\
> > 		 __seqprop_case((s), rwlock, prop),		\
> > 		 __seqprop_case((s), mutex, prop),		\
> > 		 __seqprop_case((s), ww_mutex, prop))
> >
> > #endif
> >
> > #define __to_seqcount_t(s)			__seqprop(s, ptr)
> > #define __associated_lock_is_preemptible(s)	__seqprop(s, preempt)
> > #define __assert_associated_lock_held(s)	__seqprop(s, assert)
> 
> Hmm, I'll prototype the whole thing (along with PREEMPT_RT associated
> lock()/unlock() as you've mentioned in the other e-mail), and come back.
> 
> Honestly, I have a first impression that this is heading into too much
> complexity and compaction, but let's finish the whole thing first.

So the thing I pasted compiles kernel/sched/cputime.o, but that only
uses the old seqcount_t thing, not any of the fancy new stuff, still the
compiler groks it all.

And while the gcc-4.8 code is horrendous crap, the rest should be pretty
straight forward and concentrates on the pieces where there are
differences.

I even considered:

#define __SEQPROP(name, prop, expr) \
static __always_inline __seqprop_##prop##_t \
__seqprop##name##_##prop(seqcount##name##_t *s) \
{ \
	expr; \
}

Such that we could write:

__SEQPROP(, ptr, return s)
__SEQPROP(, preempt, return false)
__SEQPROP(, assert, )

__SEQPROP(_##locktype, ptr, return &s->seqcount) \
__SEQPROP(_##locktype, preempt, return preempt) \
__SEQPROP(_##locktype, assert, __SEQCOUNT_LOCKDEP(lockdep_assert_held(s->lockmember))) \

But I figured _that_ might've been one step too far ;-)
