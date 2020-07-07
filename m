Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1866C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9993C2053B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QpCOFtZk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AMBCDo9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgGGIk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:40:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35158 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGIk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:40:28 -0400
Date:   Tue, 7 Jul 2020 10:40:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594111226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GqAXplW9IMPPcxExN56tSRMqmoQGJrD2ZNl6tLop2d8=;
        b=QpCOFtZksGKYVNiG/PXUaw7PHWi+3nofnC/pUWya8HiXIuqMJKtq8WkIyHB46g9aBrrDd7
        nN8s3gArnQIEHh4pkbP1MpxqIAx8MpEnOJkKLKL0PChrnNCAk17wzcJCUkCDzVjiTRoix9
        yWPCXdUwiE+owp29HiOAW1Bqt8ZboH53ADm/SdSnM9v+S2vq+HBYr0CG7ZwAI/Hjx49/mi
        Mnf9Dq7jK20BUiXapYQXdQN6NUcDXTNPJlWjdqEw1i6Cv7S/vVWPzIl2+t1LuC/NQlMwfy
        +UQqUpS+6M8UZzUtiRqQQTTakpydnMndAnYVoVued+HZp1OpRxAVkvFWDE63Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594111226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GqAXplW9IMPPcxExN56tSRMqmoQGJrD2ZNl6tLop2d8=;
        b=AMBCDo9/1qrJ9eWavF5yYzbh05BGTKQ+tRrXNoUF68zrqQONv0iXhNcHDzAfZcFv5n3q+D
        WTFVGVUcGD7k/XCA==
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
Message-ID: <20200707084024.GA4097637@debian-buster-darwi.lab.linutronix.de>
References: <20200630054452.3675847-1-a.darwish@linutronix.de>
 <20200630054452.3675847-7-a.darwish@linutronix.de>
 <20200706212148.GE5523@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706212148.GE5523@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 11:21:48PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 30, 2020 at 07:44:38AM +0200, Ahmed S. Darwish wrote:
> > +#include <linux/seqlock_types_internal.h>
>
> Why? why not include those lines directly here? Having it in a separate
> file actually makes it harder to read.
>

The seqlock_types_internal.h file contains mostly a heavy sequence of
typeof() branching macros, which is not related to the core logic of
sequence counters or sequential locks:

#define __to_seqcount_t(s)
({
	seqcount_t *seq;

	if (__same_type(*(s), seqcount_t))
		seq = (seqcount_t *)(s);
	else if (__same_type(*(s), seqcount_spinlock_t))
		seq = &((seqcount_spinlock_t *)(s))->seqcount;
	else if (__same_type(*(s), seqcount_raw_spinlock_t))
		seq = &((seqcount_raw_spinlock_t *)(s))->seqcount;
	else if (__same_type(*(s), seqcount_rwlock_t))
		seq = &((seqcount_rwlock_t *)(s))->seqcount;
	else if (__same_type(*(s), seqcount_mutex_t))
		seq = &((seqcount_mutex_t *)(s))->seqcount;
	else if (__same_type(*(s), seqcount_ww_mutex_t))
		seq = &((seqcount_ww_mutex_t *)(s))->seqcount;
	else
		BUILD_BUG_ON_MSG(1, "Unknown seqcount type");

	seq;
})

#define __associated_lock_exists_and_is_preemptible(s)
({
	bool ret;

	/* No associated lock for these */
	if (__same_type(*(s), seqcount_t) ||
	    __same_type(*(s), seqcount_irq_t)) {
		ret = false;
	} else if (__same_type(*(s), seqcount_spinlock_t)	||
		   __same_type(*(s), seqcount_raw_spinlock_t)	||
		   __same_type(*(s), seqcount_rwlock_t)) {
		ret = false;
	} else if (__same_type(*(s), seqcount_mutex_t)		||
		   __same_type(*(s), seqcount_ww_mutex_t)) {
		ret = true;
	} else
		BUILD_BUG_ON_MSG(1, "Unknown seqcount type");

	ret;
})

#define __assert_seqcount_write_section_is_protected(s)
do {
	/* Can't assert anything with plain seqcount_t */
	if (__same_type(*(s), seqcount_t))
		break;

	if (__same_type(*(s), seqcount_spinlock_t))
		lockdep_assert_held(((seqcount_spinlock_t *)(s))->lock);
	else if (__same_type(*(s), seqcount_raw_spinlock_t))
		lockdep_assert_held(((seqcount_raw_spinlock_t *)(s))->lock);
	else if (__same_type(*(s), seqcount_rwlock_t))
		lockdep_assert_held_write(((seqcount_rwlock_t *)(s))->lock);
	else if (__same_type(*(s), seqcount_mutex_t))
		lockdep_assert_held(((seqcount_mutex_t *)(s))->lock);
	else if (__same_type(*(s), seqcount_ww_mutex_t))
		lockdep_assert_held(&((seqcount_ww_mutex_t *)(s))->lock->base);
	else if (__same_type(*(s), seqcount_irq_t))
		lockdep_assert_irqs_disabled();
	else
		BUILD_BUG_ON_MSG(1, "Unknown seqcount type");
} while (0)

and so on and so forth. With the final patch that enables PREEMPT_RT
support (not yet submitted upstream), this file gets even more fugly:

#define __rt_lock_unlock_associated_sleeping_lock(s)
do {
	if (__same_type(*(s), seqcount_t)  ||
	    __same_type(*(s), seqcount_raw_spinlock_t))	{
		break;
	}

	if (__same_type(*(s), seqcount_spinlock_t)) {
		spin_lock(((seqcount_spinlock_t *) s)->lock);
		spin_unlock(((seqcount_spinlock_t *) s)->lock);
	} else if (__same_type(*(s), seqcount_rwlock_t)) {
		read_lock(((seqcount_rwlock_t *) s)->lock);
		read_unlock(((seqcount_rwlock_t *) s)->lock);
	} else if (__same_type(*(s), seqcount_mutex_t)) {
		mutex_lock(((seqcount_mutex_t *) s)->lock);
		mutex_unlock(((seqcount_mutex_t *) s)->lock);
	} else if (__same_type(*(s), seqcount_ww_mutex_t)) {
		ww_mutex_lock(((seqcount_ww_mutex_t *) s)->lock, NULL);
		ww_mutex_unlock(((seqcount_ww_mutex_t *) s)->lock);
	} else
		BUILD_BUG_ON_MSG(1, "Unknown seqcount type");
} while (0)

and even more macros not included here for brevity.

IMHO it makes sense to isolate these "not core logic" parts. Adding all
of this to plain seqlock.h makes it almost unreadable.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
