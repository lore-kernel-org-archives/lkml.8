Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224EDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFE2120774
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YZ7FU1F8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbgGHONm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgGHONm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 10:13:42 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F107C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 07:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UgGkoSC3pvn7sODQI7rlQ09UUbHzMllpNaF4kJrXNEk=; b=YZ7FU1F8/X5YcRvnIiceJdDKdS
        sdePgY9euAhhfMh1BF6a8+N2pQkEQJu8FcP0g8j5ZLzjK20LH2tOa0r48V5PmvFer6R+CSp3hxBIH
        T+NKWw6ldYE7xRuanbrlQBWWdqOWCViQ3TV1G7h5UR6koc9CNe5tYseDkHJeCoPY76qwVWrBSaSHk
        cvu5c4+RjO7z33tFkR2VKcMRID4ixYr2sKqljXKuJVyulwJqnkpn4y0lGKYOa0oRYNaMk1WKKPlKr
        15dHIf9Yt7+p40+KN4jnRAEdIsIhAylmWdEJA4YmxMLRnX+v6DwoKacGy5GMyKP4uPP+2bruCGUnG
        loOFmGgg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtApK-0006G4-CT; Wed, 08 Jul 2020 14:13:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 63C12300739;
        Wed,  8 Jul 2020 16:13:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2022A214ECDC2; Wed,  8 Jul 2020 16:13:32 +0200 (CEST)
Date:   Wed, 8 Jul 2020 16:13:32 +0200
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
Message-ID: <20200708141332.GQ117543@hirez.programming.kicks-ass.net>
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

> #define SEQCOUNT_LOCKTYPE(name, locktype, preempt, lockmember)		\
> typedef struct seqcount_##name {					\
> 	seqcount_t	seqcount;					\
> 	__SEQCOUNT_LOCKDEP(locktype *lock);				\
> } seqcount_##name##_t;							\
> 									\
> static __always_inline void						\
> seqcount_##name##_init(seqcount_##name##_t *s, locktype *l)		\
> {									\
> 	seqcount_init(&s->seqcount);					\
> 	__SEQCOUNT_LOCKDEP(s->lock = l);				\
> }									\
> 									\
> static __always_inline __seqprop_ptr_t					\
> __seqprop_##name##_ptr(seqcount_##name##_t *s)				\
> {									\
> 	return &s->seqcount;						\
> }									\
> 									\
> static __always_inline __seqprop_preempt_t				\
> __seqprop_##name##_preempt(seqcount_##name##_t *s)			\
> {									\
> 	return preempt;							\
> }									\
> 									\
> static __always_inline __seqprop_assert_t				\
> __seqprop_##name##_assert(seqcount_##name##_t *s)			\
> {									\
> 	__SEQCOUNT_LOCKDEP(lockdep_assert_held(s->lockmember));		\
> }

For PREEMPT_RT's magic thing, you can add:

static __always_inline void						\
__seqprop_##name##_lock(seqcount_##name##_t *s)				\
{									\
	if (!__SEQ_RT || !preempt)					\
		return;							\
									\
	lockbase##_lock(&s->lock);					\
	lockbase##_unlock(&s->lock);					\
}

and:

#define __rt_lock_unlock_associated_sleeping_lock(s) __seqprop(s, lock)

