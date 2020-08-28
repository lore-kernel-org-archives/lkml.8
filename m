Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866B9C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5410D2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s9MNUqTE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+dv1raOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgH1JbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:31:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44136 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgH1JbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:31:13 -0400
Date:   Fri, 28 Aug 2020 11:31:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598607070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+363vywbnVCEVxIi8Y5h0DSwiMHbXktW2NcpgL5JfP8=;
        b=s9MNUqTEahCmCeuJMEVtzQRU/g3Glpee98Btnh7PEzty13itOAmurS7+fpD/Z1l30aso2f
        W6d4Vj0uZ5oKmRPHFXmkXWdU1Qhrp7gnDGU4PgZex1QHAcCVGiJJmmO/EIspV4GhDykZcs
        au+r+v4ZWtqnGC+V3rVUG9ViSGvXjo4uMm0LNekJFFPtZmfl7XHrNhUp9xA0x0Mhqotrn+
        Oyr+p3Pf7g7MFBs2QM4Tf4Ztwe+4WINiudrj+WifQnbDOo9W6Lot5lXscnyIjGcxpD/bH5
        8uQf4mCqle59J13r5WxHSY9MG6TlptWOD7lcSuNGDllTiO5yUvQ1n7uHq9fY+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598607070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+363vywbnVCEVxIi8Y5h0DSwiMHbXktW2NcpgL5JfP8=;
        b=+dv1raORZNCi2GS/wUIlPR32I0qmrnp4hPVCslKckQvLtABokNGtTYXGyCNDMKZg6b5bAq
        uvN9EjdXHkqHwwBA==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     peterz@infradead.org
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 4/5] seqlock: seqcount_LOCKTYPE_t: Introduce
 PREEMPT_RT support
Message-ID: <20200828093130.GA7672@lx-t490>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200828010710.5407-1-a.darwish@linutronix.de>
 <20200828010710.5407-5-a.darwish@linutronix.de>
 <20200828085938.GS1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828085938.GS1362448@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 10:59:38AM +0200, peterz@infradead.org wrote:
> On Fri, Aug 28, 2020 at 03:07:09AM +0200, Ahmed S. Darwish wrote:
> > +#define __SEQ_RT	IS_ENABLED(CONFIG_PREEMPT_RT)
> > +
> > +SEQCOUNT_LOCKTYPE(raw_spinlock, raw_spinlock_t,  false,    s->lock,        raw_spin, raw_spin_lock(s->lock))
> > +SEQCOUNT_LOCKTYPE(spinlock,     spinlock_t,      __SEQ_RT, s->lock,        spin,     spin_lock(s->lock))
> > +SEQCOUNT_LOCKTYPE(rwlock,       rwlock_t,        __SEQ_RT, s->lock,        read,     read_lock(s->lock))
> > +SEQCOUNT_LOCKTYPE(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
> > +SEQCOUNT_LOCKTYPE(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
>
> Ooh, reading is hard, but ^^^^ you already have that.
>

Haha, I was just answering the other mail :)

> > +/*
> > + * Automatically disable preemption for seqcount_LOCKTYPE_t writers, if the
> > + * associated lock does not implicitly disable preemption.
> > + *
> > + * Don't do it for PREEMPT_RT. Check __SEQ_LOCK().
> > + */
> > +#define __seq_enforce_preemption_protection(s)				\
> > +	(!IS_ENABLED(CONFIG_PREEMPT_RT) && __seqcount_lock_preemptible(s))
>
> Then what is this doing ?!? I'm confused now.

There were a number of call sites (at DRM mainly) that protected their
seqcount_t write sections with mutex and ww_mutex. So, they manually
disabled preemption before entering the seqcount_t write sections.

Unfortunately these write sections were big, and spinlocks were also
acquired inside them.  This was all very bad for RT...

So the idea was to relieve call sites from the responsibility of
disabling/enabling preemption upon entering a seqcount_LOCKNAME_t write
section, and let seqlock.h automatically handle it if LOCKNAME_t is
preemptible (the macro's condition, second part).

Having seqlock.h control the preempt disable/enable allows us to never
disable preemption for RT, which is exactly what is needed since we
already handle any possible livelock through the mechanisms described at
__SEQ_LOCK (the macro's condition test, first part).

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
