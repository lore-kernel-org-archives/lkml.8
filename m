Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9C3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22C392073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389928AbgEYKu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389484AbgEYKu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:50:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E56C061A0E;
        Mon, 25 May 2020 03:50:27 -0700 (PDT)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <a.darwish@linutronix.de>)
        id 1jdAgQ-0006wF-Fg; Mon, 25 May 2020 12:50:14 +0200
Date:   Mon, 25 May 2020 12:50:12 +0200
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 09/25] Documentation: locking: Describe seqlock design
 and usage
Message-ID: <20200525105012.GA375313@debian-buster-darwi.lab.linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-10-a.darwish@linutronix.de>
 <20200522180145.GR325280@hirez.programming.kicks-ass.net>
 <20200522182409.4016d83c@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522182409.4016d83c@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
> Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, May 19, 2020 at 11:45:31PM +0200, Ahmed S. Darwish wrote:
> > > diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> > > index d35be7709403..2a4af746b1da 100644
> > > --- a/include/linux/seqlock.h
> > > +++ b/include/linux/seqlock.h
> > > @@ -1,36 +1,15 @@
> > >  /* SPDX-License-Identifier: GPL-2.0 */
> > >  #ifndef __LINUX_SEQLOCK_H
> > >  #define __LINUX_SEQLOCK_H
> > > +
> > >  /*
> > > - * Reader/writer consistent mechanism without starving writers. This type of
> > > - * lock for data where the reader wants a consistent set of information
> > > - * and is willing to retry if the information changes. There are two types
> > > - * of readers:
> > > - * 1. Sequence readers which never block a writer but they may have to retry
> > > - *    if a writer is in progress by detecting change in sequence number.
> > > - *    Writers do not wait for a sequence reader.
> > > - * 2. Locking readers which will wait if a writer or another locking reader
> > > - *    is in progress. A locking reader in progress will also block a writer
> > > - *    from going forward. Unlike the regular rwlock, the read lock here is
> > > - *    exclusive so that only one locking reader can get it.
> > > + * seqcount_t / seqlock_t - a reader-writer consistency mechanism with
> > > + * lockless readers (read-only retry loops), and no writer starvation.
> > >   *
> > > - * This is not as cache friendly as brlock. Also, this may not work well
> > > - * for data that contains pointers, because any writer could
> > > - * invalidate a pointer that a reader was following.
> > > + * See Documentation/locking/seqlock.rst for full description.
> >
> > So I really really hate that... I _much_ prefer code comments to crappy
> > documents.
>
> Agreed. Comments are much less likely to bitrot than documents. The
> farther away the documentation is from the code, the quicker it becomes
> stale.
>
> It's fine to add "See Documentation/..." but please don't *ever* remove
> comments that's next to the actual code.
>

This patch was unfairly cut at the hunk above :)

If you follow the rest of it, you see that the documentation has just
moved 3 lines below:

     /*
    - * Version using sequence counter only.
    - * This can be used when code has its own mutex protecting the
    - * updating starting before the write_seqcountbeqin() and ending
    - * after the write_seqcount_end().
    + * Sequence counters (seqcount_t)
    + *
    + * The raw counting mechanism without any writer protection. Write side
    + * critical sections must be serialized and readers on the same CPU
    + * (e.g. through preemption or interrupts) must be excluded.
    + *
    + * If it's desired to automatically handle the sequence counter writer
    + * serialization and non-preemptibility requirements, use a sequential
    + * lock (seqlock_t) instead.
    + *
    + * See Documentation/locking/seqlock.rst
      */
    +
     typedef struct seqcount {

and:

    +/*
    + * Sequential locks (seqlock_t)
    + *
    + * Sequence counters with an embedded spinlock for writer serialization
    + * and non-preemptibility.
    + *
    + * See Documentation/locking/seqlock.rst
    + */
    +
     typedef struct {
     	struct seqcount seqcount;
     	spinlock_t lock;
     } seqlock_t;

This was done because, as said in the commit log, documentation of
seqcount_t and seqlock_t was originally intermingled. This is incorrect
and confusing since the usage constrains for each type are vastly
different.

Then, the brlock comment:

    This is not as cache friendly as brlock. Also, this may not work
    well for data that contains pointers, because any writer could
    invalidate a pointer that a reader was following.

was removed not because it's moved to Documentation/locking/seqlock.rst,
but because it's obsolete: 0f6ed63b1707 ("no need to keep brlock macros
anymore...").

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
