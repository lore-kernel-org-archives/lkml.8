Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEC5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 666C620720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OJah8P1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgGHMaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:30:19 -0400
Received: from casper.infradead.org ([90.155.50.34]:33586 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbgGHMaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o/lzvWFzjdHynQdNJqcIzQswus3wML7F438jMaF6d3U=; b=OJah8P1BmWPpkyAYVwhtx05M68
        9hKVTVheLCxfrgBiyBfuPBNKmV93Lp6G4AWyp6Apxkg1hzbKE3zoS5a9ULJxDNtyuBhJugQOFfTz0
        SKZiBTdbYoZo3mdQmG446ZwXZcFutkCNWSfVAkqWC+LdJLIlKU1w0tA2RPAT2uBfVMkjztJ3Ot/DY
        6gFXxj+iyG+UoIL2QyiLe0x3EqZhI3JTZ8GeQPZHc4ZSOnQdYhou2zQhRTyXDrkJfysgkJ/M1wEA9
        bkj6yea2qMzJMBPuM263EHkgLlMMzrnVNyHNPKrOMrrn9Bp63tGLon/x2om3HT+tSHKPSS5xJOAKh
        cdDvijAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jt9Cu-0001sV-Il; Wed, 08 Jul 2020 12:29:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C17930047A;
        Wed,  8 Jul 2020 14:29:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CD59203A6159; Wed,  8 Jul 2020 14:29:38 +0200 (CEST)
Date:   Wed, 8 Jul 2020 14:29:38 +0200
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
Message-ID: <20200708122938.GQ4800@hirez.programming.kicks-ass.net>
References: <20200630054452.3675847-1-a.darwish@linutronix.de>
 <20200630054452.3675847-7-a.darwish@linutronix.de>
 <20200706212148.GE5523@worktop.programming.kicks-ass.net>
 <20200707084024.GA4097637@debian-buster-darwi.lab.linutronix.de>
 <20200707130410.GO4800@hirez.programming.kicks-ass.net>
 <20200707143726.GO117543@hirez.programming.kicks-ass.net>
 <20200708103314.GB4151780@debian-buster-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708103314.GB4151780@debian-buster-darwi.lab.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 12:33:14PM +0200, Ahmed S. Darwish wrote:

> > +#define read_seqcount_begin(s)	do_read_seqcount_begin(__to_seqcount_t(s))
> > +
> > +static inline unsigned do_read_seqcount_begin(const seqcount_t *s)
> > +{
> ...
> 
> Hmm, the __to_seqcount_t(s) force cast is not good. It will break the
> arguments type-safety of seqcount macros that do not have either:
> 
>     __associated_lock_is_preemptible() or
>     __assert_associated_lock_held()
> 
> in their path. This basically includes all the read path macros, and
> even some others (e.g. write_seqcount_invalidate()).
> 
> With the suggested force cast above, I can literally *pass anything* to
> read_seqcount_begin() and friends, and the compiler won't say a thing.
> 
> So, I'll restore __to_seqcount_t(s) that to its original implementation:

Right, I figured that the write side would be enough to catch glaring
abuse. But sure.

It's a bummer we didn't upgrade the minimum compiler version to 4.9,
that would've given us _Generic(), which allows one to write this
slightly less verbose I think.

How about something disguisting like this then?


#ifdef CONFIG_LOCKDEP
#define __SEQCOUNT_LOCKDEP(expr)	expr
#else
#define __SEQCOUNT_LOCKDEP(expr)
#endif

typedef seqcount_t * __seqprop_ptr_t;
typedef bool	     __seqprop_preempt_t;
typedef void	     __seqprop_assert_t;

static __always_inline __seqprop_ptr_t
__seqprop_seqcount_ptr(seqcount_t *s)
{
	return s;
}

static __always_inline __seqprop_preempt_t
__seqprop_seqcount_preempt(seqcount_t *s)
{
	return false;
}

static __always_inline __seqprop_assert_t
__seqprop_seqcount_assert(seqcount_t *s)
{
}

#define SEQCOUNT_LOCKTYPE(name, locktype, preempt, lockmember)		\
typedef struct seqcount_##name {					\
	seqcount_t	seqcount;					\
	__SEQCOUNT_LOCKDEP(locktype *lock);				\
} seqcount_##name##_t;							\
									\
static __always_inline void						\
seqcount_##name##_init(seqcount_##name##_t *s, locktype *l)		\
{									\
	seqcount_init(&s->seqcount);					\
	__SEQCOUNT_LOCKDEP(s->lock = l);				\
}									\
									\
static __always_inline __seqprop_ptr_t					\
__seqprop_##name##_ptr(seqcount_##name##_t *s)				\
{									\
	return &s->seqcount;						\
}									\
									\
static __always_inline __seqprop_preempt_t				\
__seqprop_##name##_preempt(seqcount_##name##_t *s)			\
{									\
	return preempt;							\
}									\
									\
static __always_inline __seqprop_assert_t				\
__seqprop_##name##_assert(seqcount_##name##_t *s)			\
{									\
	__SEQCOUNT_LOCKDEP(lockdep_assert_held(s->lockmember));		\
}


#define SEQCNT_LOCKTYPE_ZERO(_name, _lock) {				\
	.seqcount = SEQCNT_ZERO(_name.seqcount),			\
	__SEQCOUNT_LOCKDEP(.lock = (_lock))				\
}

#include <linux/spinlock.h>
#include <linux/ww_mutex.h>

#define __SEQ_RT	IS_BUILTIN(CONFIG_PREEMPT_RT)

SEQCOUNT_LOCKTYPE(raw_spinlock, raw_spinlock_t,	false,		lock)
SEQCOUNT_LOCKTYPE(spinlock,	spinlock_t,	__SEQ_RT,	lock)
SEQCOUNT_LOCKTYPE(rwlock,	rwlock_t,	__SEQ_RT,	lock)
SEQCOUNT_LOCKTYPE(mutex,	struct mutex,	true,		lock)
SEQCOUNT_LOCKTYPE(ww_mutex,	struct ww_mutex,true,		lock->base)

#if (defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 40900) || defined(__CHECKER__)

#define __seqprop_pick(const_expr, s, locktype, prop, otherwise)	\
	__builtin_choose_expr(const_expr,				\
			      __seqprop_##locktype##_##prop((void *)(s)), \
			      otherwise)

extern void __seqprop_invalid(void);

#define __seqprop(s, prop)								\
	__seqprop_pick(__same_type(*(s), seqcount_t), (s), seqcount, prop,		\
	  __seqprop_pick(__same_type(*(s), seqcount_raw_spinlock_t), (s), raw_spinlock, prop, \
	    __seqprop_pick(__same_type(*(s), seqcount_spinlock_t), (s), spinlock, prop,	\
	      __seqprop_pick(__same_type(*(s), seqcount_rwlock_t), (s), rwlock, prop,	\
	        __seqprop_pick(__same_type(*(s), seqcount_mutex_t), (s), mutex, prop,	\
	          __seqprop_pick(__same_type(*(s), seqcount_ww_mutex_t), (s), ww_mutex, prop, \
		    __seqprop_invalid()))))))

#else

#define __seqprop_case(s, locktype, prop) \
	seqcount_##locktype##_t: __seqprop_##locktype##_##prop((void *)s)

#define __seqprop(s, prop)					\
	_Generic(*(s),						\
		 seqcount_t: __seqprop_seqcount_##prop((void*)s),\
		 __seqprop_case((s), raw_spinlock, prop),	\
		 __seqprop_case((s), spinlock, prop),		\
		 __seqprop_case((s), rwlock, prop),		\
		 __seqprop_case((s), mutex, prop),		\
		 __seqprop_case((s), ww_mutex, prop))

#endif

#define __to_seqcount_t(s)			__seqprop(s, ptr)
#define __associated_lock_is_preemptible(s)	__seqprop(s, preempt)
#define __assert_associated_lock_held(s)	__seqprop(s, assert)
