Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F089C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2343520717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgGUBfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:35:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgGUBfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 21:35:55 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C57C206F2;
        Tue, 21 Jul 2020 01:35:52 +0000 (UTC)
Date:   Mon, 20 Jul 2020 21:35:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 01/24] Documentation: locking: Describe seqlock
 design and usage
Message-ID: <20200720213551.5ba9bc6d@oasis.local.home>
In-Reply-To: <20200720155530.1173732-2-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
        <20200720155530.1173732-1-a.darwish@linutronix.de>
        <20200720155530.1173732-2-a.darwish@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 17:55:07 +0200
"Ahmed S. Darwish" <a.darwish@linutronix.de> wrote:
> +Read path, three categories:
> +
> +1. Normal Sequence readers which never block a writer but they must
> +   retry if a writer is in progress by detecting change in the sequence
> +   number.  Writers do not wait for a sequence reader::
> +
> +	do {
> +		seq = read_seqbegin(&foo_seqlock);
> +
> +		/* ... [[read-side critical section]] ... */
> +
> +	} while (read_seqretry(&foo_seqlock, seq));
> +
> +2. Locking readers which will wait if a writer or another locking reader
> +   is in progress. A locking reader in progress will also block a writer
> +   from entering its critical section. This read lock is
> +   exclusive. Unlike rwlock_t, only one locking reader can acquire it::

Nit, but I would mention that this acts similar to a normal spin_lock, and even disables preeption (in the non-RT case).
> +
> +	read_seqlock_excl(&foo_seqlock);
> +
> +	/* ... [[read-side critical section]] ... */
> +
> +	read_sequnlock_excl(&foo_seqlock);
> +
> +3. Conditional lockless reader (as in 1), or locking reader (as in 2),
> +   according to a passed marker. This is used to avoid lockless readers
> +   starvation (too much retry loops) in case of a sharp spike in write
> +   activity. First, a lockless read is tried (even marker passed). If
> +   that trial fails (odd sequence counter is returned, which is used as
> +   the next iteration marker), the lockless read is transformed to a
> +   full locking read and no retry loop is necessary::
> +
> +	/* marker; even initialization */
> +	int seq = 0;
> +	do {
> +		read_seqbegin_or_lock(&foo_seqlock, &seq);
> +
> +		/* ... [[read-side critical section]] ... */
> +
> +	} while (need_seqretry(&foo_seqlock, seq));
> +	done_seqretry(&foo_seqlock, seq);
> +
> +
> +API documentation
> +=================
> +
> +.. kernel-doc:: include/linux/seqlock.h
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index 8b97204f35a7..299d68f10325 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -1,36 +1,15 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef __LINUX_SEQLOCK_H
>  #define __LINUX_SEQLOCK_H
> +
>  /*
> - * Reader/writer consistent mechanism without starving writers. This type of
> - * lock for data where the reader wants a consistent set of information
> - * and is willing to retry if the information changes. There are two types
> - * of readers:
> - * 1. Sequence readers which never block a writer but they may have to retry
> - *    if a writer is in progress by detecting change in sequence number.
> - *    Writers do not wait for a sequence reader.
> - * 2. Locking readers which will wait if a writer or another locking reader
> - *    is in progress. A locking reader in progress will also block a writer
> - *    from going forward. Unlike the regular rwlock, the read lock here is
> - *    exclusive so that only one locking reader can get it.
> + * seqcount_t / seqlock_t - a reader-writer consistency mechanism with
> + * lockless readers (read-only retry loops), and no writer starvation.
>   *
> - * This is not as cache friendly as brlock. Also, this may not work well
> - * for data that contains pointers, because any writer could
> - * invalidate a pointer that a reader was following.
> + * See Documentation/locking/seqlock.rst
>   *
> - * Expected non-blocking reader usage:
> - * 	do {
> - *	    seq = read_seqbegin(&foo);
> - * 	...
> - *      } while (read_seqretry(&foo, seq));
> - *
> - *
> - * On non-SMP the spin locks disappear but the writer still needs
> - * to increment the sequence variables because an interrupt routine could
> - * change the state of the data.
> - *
> - * Based on x86_64 vsyscall gettimeofday 
> - * by Keith Owens and Andrea Arcangeli
> + * Copyrights:
> + * - Based on x86_64 vsyscall gettimeofday: Keith Owens, Andrea Arcangeli
>   */
>  
>  #include <linux/spinlock.h>
> @@ -41,8 +20,8 @@
>  #include <asm/processor.h>
>  
>  /*
> - * The seqlock interface does not prescribe a precise sequence of read
> - * begin/retry/end. For readers, typically there is a call to
> + * The seqlock seqcount_t interface does not prescribe a precise sequence of
> + * read begin/retry/end. For readers, typically there is a call to
>   * read_seqcount_begin() and read_seqcount_retry(), however, there are more
>   * esoteric cases which do not follow this pattern.
>   *
> @@ -50,16 +29,30 @@
>   * via seqcount_t under KCSAN: upon beginning a seq-reader critical section,
>   * pessimistically mark the next KCSAN_SEQLOCK_REGION_MAX memory accesses as
>   * atomics; if there is a matching read_seqcount_retry() call, no following
> - * memory operations are considered atomic. Usage of seqlocks via seqlock_t
> - * interface is not affected.
> + * memory operations are considered atomic. Usage of the seqlock_t interface
> + * is not affected.
>   */
>  #define KCSAN_SEQLOCK_REGION_MAX 1000
>  
>  /*
> - * Version using sequence counter only.
> - * This can be used when code has its own mutex protecting the
> - * updating starting before the write_seqcountbeqin() and ending
> - * after the write_seqcount_end().
> + * Sequence counters (seqcount_t)
> + *
> + * This is the raw counting mechanism, without any writer protection.
> + *
> + * Write side critical sections must be serialized and non-preemptible.
> + *
> + * If readers can be invoked from hardirq or softirq contexts,
> + * interrupts or bottom halves must also be respectively disabled before
> + * entering the write section.
> + *
> + * This mechanism can't be used if the protected data contains pointers,
> + * as the writer can invalidate a pointer that a reader is following.
> + *
> + * If it's desired to automatically handle the sequence counter writer
> + * serialization and non-preemptibility requirements, use a sequential
> + * lock (seqlock_t) instead.
> + *
> + * See Documentation/locking/seqlock.rst
>   */
>  typedef struct seqcount {
>  	unsigned sequence;
> @@ -398,10 +391,6 @@ static inline void raw_write_seqcount_latch(seqcount_t *s)
>         smp_wmb();      /* increment "sequence" before following stores */
>  }
>  
> -/*
> - * Sequence counter only version assumes that callers are using their
> - * own mutexing.
> - */
>  static inline void write_seqcount_begin_nested(seqcount_t *s, int subclass)
>  {
>  	raw_write_seqcount_begin(s);
> @@ -434,15 +423,21 @@ static inline void write_seqcount_invalidate(seqcount_t *s)
>  	kcsan_nestable_atomic_end();
>  }
>  
> +/*
> + * Sequential locks (seqlock_t)
> + *
> + * Sequence counters with an embedded spinlock for writer serialization
> + * and non-preemptibility.
> + *
> + * For more info, see:
> + *    - Comments on top of seqcount_t
> + *    - Documentation/locking/seqlock.rst
> + */
>  typedef struct {
>  	struct seqcount seqcount;
>  	spinlock_t lock;
>  } seqlock_t;
>  
> -/*
> - * These macros triggered gcc-3.x compile-time problems.  We think these are
> - * OK now.  Be cautious.
> - */
>  #define __SEQLOCK_UNLOCKED(lockname)			\
>  	{						\
>  		.seqcount = SEQCNT_ZERO(lockname),	\

