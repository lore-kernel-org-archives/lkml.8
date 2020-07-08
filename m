Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC3BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68EE32078D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k6CxAh4P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CwdYDTxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgGHPJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:09:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51172 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729676AbgGHPJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:09:33 -0400
Date:   Wed, 8 Jul 2020 17:09:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594220971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sk2EpFmlcG5nTIKnaSOK7WLibT20WG+40/XonWzggkw=;
        b=k6CxAh4PVkh1KG2o0qvlbHm30a8aCBsmCcC+bj6C2XgCDcwHecs44g6NSI4I69OWyCsgY4
        7nerFQjLCdQYk/c4RRo5qUXH72OB1P46AdpQBPI8hVC9AIZZoQ71HwAIRZm8J4cnHV357N
        XSHbNeF5o/bWC6cSBrlyiV85TLRmfpd/y7eButAuzNZW+EeV0HldPxuilJTiI6TO7ULwGP
        I17zOLJs0Hm1AmXVBUzdgNxiUK7JYnDiAXuIctdzSUOuoyCd7+B/wxrpDUHGZz0MqLIeiM
        dI9d0fgjiGwF2x2GEnTbBTv+/ZZ5UQp0QQUJgc7eKV96Y3Ug6l7RkJGaqT3KAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594220971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sk2EpFmlcG5nTIKnaSOK7WLibT20WG+40/XonWzggkw=;
        b=CwdYDTxhNc1ymc0bQTO6KqGrRZJV4FvDWhc+vQg3oBTO64ChnyUYqZDYD6Qg5gAb/x8xCa
        wLIvyIUQdhsVZUCw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/20] seqlock: Extend seqcount API with associated
 locks
Message-ID: <20200708150930.GA147323@debian-buster-darwi.lab.linutronix.de>
References: <20200630054452.3675847-1-a.darwish@linutronix.de>
 <20200630054452.3675847-7-a.darwish@linutronix.de>
 <20200706212148.GE5523@worktop.programming.kicks-ass.net>
 <20200707084024.GA4097637@debian-buster-darwi.lab.linutronix.de>
 <20200707130410.GO4800@hirez.programming.kicks-ass.net>
 <20200707143726.GO117543@hirez.programming.kicks-ass.net>
 <20200708103314.GB4151780@debian-buster-darwi.lab.linutronix.de>
 <20200708122938.GQ4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708122938.GQ4800@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 02:29:38PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 08, 2020 at 12:33:14PM +0200, Ahmed S. Darwish wrote:
>
> > > +#define read_seqcount_begin(s)	do_read_seqcount_begin(__to_seqcount_t(s))
> > > +
> > > +static inline unsigned do_read_seqcount_begin(const seqcount_t *s)
> > > +{
> > ...
> >
> > Hmm, the __to_seqcount_t(s) force cast is not good. It will break the
> > arguments type-safety of seqcount macros that do not have either:
> >
> >     __associated_lock_is_preemptible() or
> >     __assert_associated_lock_held()
> >
> > in their path. This basically includes all the read path macros, and
> > even some others (e.g. write_seqcount_invalidate()).
> >
> > With the suggested force cast above, I can literally *pass anything* to
> > read_seqcount_begin() and friends, and the compiler won't say a thing.
> >
> > So, I'll restore __to_seqcount_t(s) that to its original implementation:
>
> Right, I figured that the write side would be enough to catch glaring
> abuse. But sure.
>
> It's a bummer we didn't upgrade the minimum compiler version to 4.9,
> that would've given us _Generic(), which allows one to write this
> slightly less verbose I think.
>

Looking at 5429ef62bcf3 ("compiler/gcc: Raise minimum GCC version for
kernel builds to 4.8"), it seems that the decision of picking gcc 4.8
vs. 4.9 was kinda arbitrary.

Anyway, please continue below.

> How about something disguisting like this then?
>
...
> #define __SEQ_RT	IS_BUILTIN(CONFIG_PREEMPT_RT)
>
> SEQCOUNT_LOCKTYPE(raw_spinlock, raw_spinlock_t,	false,		lock)
> SEQCOUNT_LOCKTYPE(spinlock,	spinlock_t,		__SEQ_RT,	lock)
> SEQCOUNT_LOCKTYPE(rwlock,	rwlock_t,		__SEQ_RT,	lock)
> SEQCOUNT_LOCKTYPE(mutex,	struct mutex,		true,		lock)
> SEQCOUNT_LOCKTYPE(ww_mutex,	struct ww_mutex,	true,		lock->base)
>
> #if (defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 40900) || defined(__CHECKER__)
>
> #define __seqprop_pick(const_expr, s, locktype, prop, otherwise)	\
> 	__builtin_choose_expr(const_expr,				\
> 			      __seqprop_##locktype##_##prop((void *)(s)), \
> 			      otherwise)
>
> extern void __seqprop_invalid(void);
>
> #define __seqprop(s, prop)								\
> 	__seqprop_pick(__same_type(*(s), seqcount_t), (s), seqcount, prop,		\
> 	  __seqprop_pick(__same_type(*(s), seqcount_raw_spinlock_t), (s), raw_spinlock, prop, \
> 	    __seqprop_pick(__same_type(*(s), seqcount_spinlock_t), (s), spinlock, prop,	\
> 	      __seqprop_pick(__same_type(*(s), seqcount_rwlock_t), (s), rwlock, prop,	\
> 	        __seqprop_pick(__same_type(*(s), seqcount_mutex_t), (s), mutex, prop,	\
> 	          __seqprop_pick(__same_type(*(s), seqcount_ww_mutex_t), (s), ww_mutex, prop, \
> 		    __seqprop_invalid()))))))
>
> #else
>
> #define __seqprop_case(s, locktype, prop) \
> 	seqcount_##locktype##_t: __seqprop_##locktype##_##prop((void *)s)
>
> #define __seqprop(s, prop)					\
> 	_Generic(*(s),						\
> 		 seqcount_t: __seqprop_seqcount_##prop((void*)s),\
> 		 __seqprop_case((s), raw_spinlock, prop),	\
> 		 __seqprop_case((s), spinlock, prop),		\
> 		 __seqprop_case((s), rwlock, prop),		\
> 		 __seqprop_case((s), mutex, prop),		\
> 		 __seqprop_case((s), ww_mutex, prop))
>
> #endif
>
> #define __to_seqcount_t(s)			__seqprop(s, ptr)
> #define __associated_lock_is_preemptible(s)	__seqprop(s, preempt)
> #define __assert_associated_lock_held(s)	__seqprop(s, assert)

Hmm, I'll prototype the whole thing (along with PREEMPT_RT associated
lock()/unlock() as you've mentioned in the other e-mail), and come back.

Honestly, I have a first impression that this is heading into too much
complexity and compaction, but let's finish the whole thing first.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
