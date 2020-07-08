Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F910C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB67F20739
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s1MkS0y5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uXndmB5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgGHKdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 06:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgGHKdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 06:33:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8608BC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 03:33:17 -0700 (PDT)
Date:   Wed, 8 Jul 2020 12:33:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594204396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A3pJuNIU0LykF2PIg+ZxlGqv3aULpQ+rRYQaYlSRZX8=;
        b=s1MkS0y59k1JFRXkZa8LTa0KDWLKgTQuPwc2dOcKEBeenA/wa+NP7Bxf4VYAkZt+8s9a25
        40CrEs4nVTg9Luwrt8iFLsGl3AbATjN2XLyowWYVe7WGBBmLssKiJe0iK/ol1RZ5XDg1cr
        rcMA11ZfO+at3Hbzu6KLLI7GXb8xx73OJdyG3Em+GfJ6TBHDiWXEhxjyJfh7HkvE0iTuRW
        RyP0+WoCsa/xjpxy1bxYIdOizMhC6aYI/3BNrPTnGFS030op7oyPkqnoiLlgLM7uFwlr5D
        NdLbe0JTKNs5p6eUmzBHNnXJS5BSoS0Bg3Sx+anVzy37f647PqQmtuDG7DEIZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594204396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A3pJuNIU0LykF2PIg+ZxlGqv3aULpQ+rRYQaYlSRZX8=;
        b=uXndmB5GznbaNs8Dy4fBXBYVozV4kOcWa/TFGlQvlabeh+mmEeuizA1enNEuNmqLzOoBVo
        0wRHid687OJerZBA==
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
Message-ID: <20200708103314.GB4151780@debian-buster-darwi.lab.linutronix.de>
References: <20200630054452.3675847-1-a.darwish@linutronix.de>
 <20200630054452.3675847-7-a.darwish@linutronix.de>
 <20200706212148.GE5523@worktop.programming.kicks-ass.net>
 <20200707084024.GA4097637@debian-buster-darwi.lab.linutronix.de>
 <20200707130410.GO4800@hirez.programming.kicks-ass.net>
 <20200707143726.GO117543@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707143726.GO117543@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 04:37:26PM +0200, Peter Zijlstra wrote:
>
> How's this? it removes a level of indirection and a bunch of repetition.

ACK, for the extra level of indirection removed.

> It's also more than 200 lines shorter.
...
> +#define __to_seqcount_t(s)	(seqcount_t *)(s)
...
> +#define read_seqcount_begin(s)	do_read_seqcount_begin(__to_seqcount_t(s))
> +
> +static inline unsigned do_read_seqcount_begin(const seqcount_t *s)
> +{
...

Hmm, the __to_seqcount_t(s) force cast is not good. It will break the
arguments type-safety of seqcount macros that do not have either:

    __associated_lock_is_preemptible() or
    __assert_associated_lock_held()

in their path. This basically includes all the read path macros, and
even some others (e.g. write_seqcount_invalidate()).

With the suggested force cast above, I can literally *pass anything* to
read_seqcount_begin() and friends, and the compiler won't say a thing.

So, I'll restore __to_seqcount_t(s) that to its original implementation:

/*
 * @s: pointer to seqcount_t or any of the seqcount_locktype_t variants
 */
#define __to_seqcount_t(s)						\
({									\
	seqcount_t *seq;						\
									\
	if (__same_type(*(s), seqcount_t))				\
		seq = (seqcount_t *)(s);				\
	else if (__same_type(*(s), seqcount_spinlock_t))		\
		seq = &((seqcount_spinlock_t *)(s))->seqcount;		\
	else if (__same_type(*(s), seqcount_raw_spinlock_t))		\
		seq = &((seqcount_raw_spinlock_t *)(s))->seqcount;	\
	else if (__same_type(*(s), seqcount_rwlock_t))			\
		seq = &((seqcount_rwlock_t *)(s))->seqcount;		\
	else if (__same_type(*(s), seqcount_mutex_t))			\
		seq = &((seqcount_mutex_t *)(s))->seqcount;		\
	else if (__same_type(*(s), seqcount_ww_mutex_t))		\
		seq = &((seqcount_ww_mutex_t *)(s))->seqcount;		\
	else								\
		BUILD_BUG_ON_MSG(1, "Unknown seqcount type");		\
									\
	seq;								\
})

Yes, I know, it's not the prettiest thing in the world, but I'd take
ugly over breaking the compiler type checks any day.

>
> It doesn't provide SEQCNT_LOCKTYPE_ZERO() for each LOCKTYPE, but you can
> use this one macro for any LOCKTYPE.
>

From call-sites perspectives, SEQCNT_SPINLOCK_ZERO() is much more
readable than SEQCNT_LOCKTYPE_ZERO() and so on. It only costs us 5 lines
*for all* the seqcount lock types. IMHO it's worth the trade-off.

>
> So I applied it all yesterday and tried to make sense of the resulting
> indirections and couldn't find stuff -- because it was hidding in
> another file.
>
> Specifically I disliked that *seqcount_t* naming and didn't see how it
> all connected.
>

Hmm, the idea was that write_seqcount_t_begin() and friends applies only
to plain old "seqcount_t". But, yes, I agree, it's confusing as hell.

The way you've organized the macros is much more readable, so thanks a
lot, I'll incorporate that in v4.

Kind regards,

--
Ahmed S. Darwish
Linutronix GmbH
