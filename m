Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DCEC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A4A207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pt0kC2B6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bQnestss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgH1Ogc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:36:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45624 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgH1OgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:36:12 -0400
Date:   Fri, 28 Aug 2020 16:36:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598625364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BSovyqDfmPCPEib/KWIWlJ0IAJg/5IQArvXAUs+2PUY=;
        b=pt0kC2B6nyFbu8RDsQ6n4PquGn0T4ZoO8QQ61dO/ffkQgkCmGmsJB5rY9xbvkPln/ptxoY
        I5Dk+CqLkNa9NILFD4sBF9QNUopSeQOBIJdZDNJN+I0mGYb5G5J8eZP9LYwH2h9J7KqGZS
        thEuF+WeE5GJ56taBRgalvT7+/tl+WfBY1BsBg771+HfT2ajIAKEF+y/0ip5uTpaTXhlI/
        TAUI1qpr5UXadHhFeUWWuwkCYb9A2ZZkAqJFr0zQgLhSRR+qX0pe/8/2HmaosK7nar4ciu
        KydrdM0vQW8+NPOg8MNye8pwEqhmXoxphv37SNnbwhDZKWPzIHyVLOHOPBQB/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598625364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BSovyqDfmPCPEib/KWIWlJ0IAJg/5IQArvXAUs+2PUY=;
        b=bQnestssn8lajILGdoZtMd7gyV1QUAV8D5cb3JQ1Pslw1lKGjk/FwixMQvoW4ahN7Hr8O0
        XhjxlQP7eyWvNPAA==
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
Message-ID: <20200828143623.GA10273@lx-t490>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200828010710.5407-1-a.darwish@linutronix.de>
 <20200828010710.5407-5-a.darwish@linutronix.de>
 <20200828085938.GS1362448@hirez.programming.kicks-ass.net>
 <20200828093130.GA7672@lx-t490>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828093130.GA7672@lx-t490>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 11:31:32AM +0200, Ahmed S. Darwish wrote:
> On Fri, Aug 28, 2020 at 10:59:38AM +0200, peterz@infradead.org wrote:
> > On Fri, Aug 28, 2020 at 03:07:09AM +0200, Ahmed S. Darwish wrote:
> > > +#define __SEQ_RT	IS_ENABLED(CONFIG_PREEMPT_RT)
> > > +
> > > +SEQCOUNT_LOCKTYPE(raw_spinlock, raw_spinlock_t,  false,    s->lock,        raw_spin, raw_spin_lock(s->lock))
> > > +SEQCOUNT_LOCKTYPE(spinlock,     spinlock_t,      __SEQ_RT, s->lock,        spin,     spin_lock(s->lock))
> > > +SEQCOUNT_LOCKTYPE(rwlock,       rwlock_t,        __SEQ_RT, s->lock,        read,     read_lock(s->lock))
> > > +SEQCOUNT_LOCKTYPE(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
> > > +SEQCOUNT_LOCKTYPE(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
> >
> > Ooh, reading is hard, but ^^^^ you already have that.
> >
>
> Haha, I was just answering the other mail :)
>
> > > +/*
> > > + * Automatically disable preemption for seqcount_LOCKTYPE_t writers, if the
> > > + * associated lock does not implicitly disable preemption.
> > > + *
> > > + * Don't do it for PREEMPT_RT. Check __SEQ_LOCK().
> > > + */
> > > +#define __seq_enforce_preemption_protection(s)				\
> > > +	(!IS_ENABLED(CONFIG_PREEMPT_RT) && __seqcount_lock_preemptible(s))
> >
> > Then what is this doing ?!? I'm confused now.
>
> There were a number of call sites (at DRM mainly) that protected their
> seqcount_t write sections with mutex and ww_mutex. So, they manually
> disabled preemption before entering the seqcount_t write sections.
>
> Unfortunately these write sections were big, and spinlocks were also
> acquired inside them.  This was all very bad for RT...
>
> So the idea was to relieve call sites from the responsibility of
> disabling/enabling preemption upon entering a seqcount_LOCKNAME_t write
> section, and let seqlock.h automatically handle it if LOCKNAME_t is
> preemptible (the macro's condition, second part).
>
> Having seqlock.h control the preempt disable/enable allows us to never
> disable preemption for RT, which is exactly what is needed since we
> already handle any possible livelock through the mechanisms described at
> __SEQ_LOCK (the macro's condition test, first part).
>

So to summarize, __seqcount_lock_preemptible() has two use cases:

    1. For !PREEMPT_RT, to automatically disable preemption on the write
       side when the seqcount associated lock is preemptible.

    2. For PREEMPT_RT, to lock/unlock the seqcount associated lock on
       the read side if it is RT-preemptible (sleeping lock).

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
