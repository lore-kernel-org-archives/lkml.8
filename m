Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D643C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E2E206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RxkDKFwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgGHOZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729468AbgGHOZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 10:25:34 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722DAC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 07:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+YUe1fHnh8Fc6MZuglb4QKVpoNIXOUgI7dCHoGx1luE=; b=RxkDKFwZoqNTLBBbYfGgGUe4+O
        5j83xJFKnsJW4vLbLWpzdQQJwqJ+6HP1kWNO3GX1zCgW7es+pDcpixR07wcr1bnkCuiKALYeSaVhY
        hScSwsKk7WByOKncEwgTCxofH9YZ6+R7ccEwJJEq/wfYnwazkdSv6JjIH/qAYW/auTb0pJ8bz0UAx
        8CP4L0EthAkXqyuZ0Mh7RNlZbV4I7E4LMaADnJx03SfpBw5rNKtQS3/wJD2aMgiXYVdcutefbIFye
        ITonfS6BRI+r9t6sVO8ZTyaoTBnitjtANNK44rwMgUfFzR5e6ZYZ8W38RLeqyxKak+6iZckJtqkmq
        4xzyYt5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtB0q-0007AN-9E; Wed, 08 Jul 2020 14:25:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DFBD0304D58;
        Wed,  8 Jul 2020 16:25:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 970BF214ECDC2; Wed,  8 Jul 2020 16:25:26 +0200 (CEST)
Date:   Wed, 8 Jul 2020 16:25:26 +0200
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
Message-ID: <20200708142526.GR117543@hirez.programming.kicks-ass.net>
References: <20200630054452.3675847-1-a.darwish@linutronix.de>
 <20200630054452.3675847-7-a.darwish@linutronix.de>
 <20200706212148.GE5523@worktop.programming.kicks-ass.net>
 <20200707084024.GA4097637@debian-buster-darwi.lab.linutronix.de>
 <20200707130410.GO4800@hirez.programming.kicks-ass.net>
 <20200707143726.GO117543@hirez.programming.kicks-ass.net>
 <20200708103314.GB4151780@debian-buster-darwi.lab.linutronix.de>
 <20200708122938.GQ4800@hirez.programming.kicks-ass.net>
 <20200708141332.GQ117543@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708141332.GQ117543@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 04:13:32PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 08, 2020 at 02:29:38PM +0200, Peter Zijlstra wrote:
> 
> > #define SEQCOUNT_LOCKTYPE(name, locktype, preempt, lockmember)		\
> > typedef struct seqcount_##name {					\
> > 	seqcount_t	seqcount;					\
> > 	__SEQCOUNT_LOCKDEP(locktype *lock);				\
> > } seqcount_##name##_t;							\
> > 									\
> > static __always_inline void						\
> > seqcount_##name##_init(seqcount_##name##_t *s, locktype *l)		\
> > {									\
> > 	seqcount_init(&s->seqcount);					\
> > 	__SEQCOUNT_LOCKDEP(s->lock = l);				\
> > }									\
> > 									\
> > static __always_inline __seqprop_ptr_t					\
> > __seqprop_##name##_ptr(seqcount_##name##_t *s)				\
> > {									\
> > 	return &s->seqcount;						\
> > }									\
> > 									\
> > static __always_inline __seqprop_preempt_t				\
> > __seqprop_##name##_preempt(seqcount_##name##_t *s)			\
> > {									\
> > 	return preempt;							\
> > }									\
> > 									\
> > static __always_inline __seqprop_assert_t				\
> > __seqprop_##name##_assert(seqcount_##name##_t *s)			\
> > {									\
> > 	__SEQCOUNT_LOCKDEP(lockdep_assert_held(s->lockmember));		\
> > }
> 
> For PREEMPT_RT's magic thing, you can add:
> 
> static __always_inline void						\
> __seqprop_##name##_lock(seqcount_##name##_t *s)				\
> {									\
> 	if (!__SEQ_RT || !preempt)					\
> 		return;							\
> 									\
> 	lockbase##_lock(&s->lock);					\
> 	lockbase##_unlock(&s->lock);					\
> }
> 
> and:
> 
> #define __rt_lock_unlock_associated_sleeping_lock(s) __seqprop(s, lock)

Or possible have it like:

	if (!__SEQ_RT || !preempt)
		return smp_cond_load_relaxed(&s->seqcount->sequence, !(VAL & 1));

	lockbase##_lock(&s->lock);
	lockbase##_unlock(&s->lock);

	return READ_ONCE(s->seqcount->sequence);

and then replace most of __read_seqcount_begin() with it.
