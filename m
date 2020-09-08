Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D14AC2D0A7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFD82078B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qBMMBzJJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sSmH5JrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbgIHRoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731659AbgIHQOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:14:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6168FC061375
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 05:48:25 -0700 (PDT)
Date:   Tue, 8 Sep 2020 14:48:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599569303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6fAFubHHqBfV7rm22ZeRY7ZslhBGVZwuDRVSmUBXy2E=;
        b=qBMMBzJJPqmVdjdvsckWg2x6CAY94WEen2gUNszKp9zlye67Jgrpr1YZdp7OwIso24T715
        IW8nCStN1L/QIqNTOewYPJxQFaTg+fab5NhXs8QR1HZCgI0GOohuXwZYSwT4ajwMJOhUbG
        F5u++3oekU8ixEpXV39zAlOqZRbNjpqVEwimcni11H/wahju6v+3F8OyhAf8xI7oa3fbAJ
        kpqcWtwZC/CY4ouNoMMrbxDQeFee5oT4jKpCwxySZ7YjHIovtNG5+d9gz6D8aEiHf06qV2
        ZA+lcRTjS6A6LdSBOde4NjqASAjAfvUFYz7qT9VcLJCnLCWzWBEx8Rpj7UyhkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599569303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6fAFubHHqBfV7rm22ZeRY7ZslhBGVZwuDRVSmUBXy2E=;
        b=sSmH5JrCzDTThVEx11l5gdKGySWNkg5t9mCiPqK+191e/J9iOpiD4nLQ5j+7/frijEZX5u
        CBvcG75OkebzF3CQ==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     peterz@infradead.org
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] seqlock: seqcount_LOCKNAME_t: Introduce
 PREEMPT_RT support
Message-ID: <20200908124850.GA487635@lx-t490>
References: <20200904153231.11994-1-a.darwish@linutronix.de>
 <20200904153231.11994-5-a.darwish@linutronix.de>
 <20200908114520.GS1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908114520.GS1362448@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 01:45:20PM +0200, peterz@infradead.org wrote:
> On Fri, Sep 04, 2020 at 05:32:30PM +0200, Ahmed S. Darwish wrote:
> > @@ -406,13 +443,20 @@ static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
> >  	return __read_seqcount_t_retry(s, start);
> >  }
> >
> > +/*
> > + * Enforce non-preemptibility for all seqcount_LOCKNAME_t writers. Don't
> > + * do it for PREEMPT_RT, for the reasons outlined at __SEQ_LOCK().
> > + */
> > +#define __seq_enforce_writer_non_preemptibility(s)			\
> > +	(!IS_ENABLED(CONFIG_PREEMPT_RT) && __seqcount_lock_preemptible(s))
> > +
> >  /**
> >   * raw_write_seqcount_begin() - start a seqcount_t write section w/o lockdep
> >   * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
> >   */
> >  #define raw_write_seqcount_begin(s)					\
> >  do {									\
> > -	if (__seqcount_lock_preemptible(s))				\
> > +	if (__seq_enforce_writer_non_preemptibility(s))			\
> >  		preempt_disable();					\
> >  									\
> >  	raw_write_seqcount_t_begin(__seqcount_ptr(s));			\
> > @@ -433,7 +477,7 @@ static inline void raw_write_seqcount_t_begin(seqcount_t *s)
> >  do {									\
> >  	raw_write_seqcount_t_end(__seqcount_ptr(s));			\
> >  									\
> > -	if (__seqcount_lock_preemptible(s))				\
> > +	if (__seq_enforce_writer_non_preemptibility(s))			\
> >  		preempt_enable();					\
> >  } while (0)
> >
> > @@ -456,7 +500,7 @@ static inline void raw_write_seqcount_t_end(seqcount_t *s)
> >  do {									\
> >  	__seqcount_assert_lock_held(s);					\
> >  									\
> > -	if (__seqcount_lock_preemptible(s))				\
> > +	if (__seq_enforce_writer_non_preemptibility(s))			\
> >  		preempt_disable();					\
> >  									\
> >  	write_seqcount_t_begin_nested(__seqcount_ptr(s), subclass);	\
> > @@ -483,7 +527,7 @@ static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
> >  do {									\
> >  	__seqcount_assert_lock_held(s);					\
> >  									\
> > -	if (__seqcount_lock_preemptible(s))				\
> > +	if (__seq_enforce_writer_non_preemptibility(s))			\
> >  		preempt_disable();					\
> >  									\
> >  	write_seqcount_t_begin(__seqcount_ptr(s));			\
> > @@ -504,7 +548,7 @@ static inline void write_seqcount_t_begin(seqcount_t *s)
> >  do {									\
> >  	write_seqcount_t_end(__seqcount_ptr(s));			\
> >  									\
> > -	if (__seqcount_lock_preemptible(s))				\
> > +	if (__seq_enforce_writer_non_preemptibility(s))			\
> >  		preempt_enable();					\
> >  } while (0)
>
> I've replaced the above with the below, afaict there were no users of
> __seqcount_lock_preemptible() left.
>
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -228,7 +228,11 @@ __seqprop_##lockname##_sequence(const se
>  static __always_inline bool						\
>  __seqprop_##lockname##_preemptible(const seqcount_##lockname##_t *s)	\
>  {									\
> -	return preemptible;						\
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))				\
> +		return preemptible;					\
> +									\
> +	/* PREEMPT_RT relies on the above LOCK+UNLOCK */		\
> +	return false;							\
>  }									\
>  									\

Sounds good.
