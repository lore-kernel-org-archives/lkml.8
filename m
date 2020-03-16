Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B43C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C102C20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbgCPKe5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:34:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51394 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730604AbgCPKe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:34:57 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jDn5C-0004bb-2E; Mon, 16 Mar 2020 11:34:54 +0100
Date:   Mon, 16 Mar 2020 11:34:54 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/9] Documentation: Add lock ordering and nesting
 documentation
Message-ID: <20200316103454.iodi65uzbpat4kv5@linutronix.de>
References: <20200313174701.148376-1-bigeasy@linutronix.de>
 <20200313174701.148376-2-bigeasy@linutronix.de>
 <2e0912cc-6780-18e9-4e4c-7cc60da6709f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <2e0912cc-6780-18e9-4e4c-7cc60da6709f@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-14 15:57:24 [-0700], Randy Dunlap wrote:
> Hi,
Hi Randy,

> A few comments for your consideration:

I merged all of you comments but two:

> On 3/13/20 10:46 AM, Sebastian Andrzej Siewior wrote:
…
> > +rwlock_t and PREEMPT_RT
> > +-----------------------
> > +
> > +On a PREEMPT_RT enabled kernel rwlock_t is mapped to a separate
> > +implementation based on rt_mutex which changes the semantics:
> > +
> > + - Same changes as for spinlock_t
> > +
> > + - The implementation is not fair and can cause writer starvation under
> > +   certain circumstances. The reason for this is that a writer cannot
> > +   inherit its priority to multiple readers. Readers which are blocked
> 
>       ^^^^^^^ I think this is backwards. Maybe more like so:
>                                                          a writer cannot
>       bequeath or grant or bestow or pass down    ...    its priority to

So the term "inherit" is the problem. The protocol is officially called
PI which is short for Priority Inheritance. Other documentation,
RT-mutex for instance, is also using this term when it is referring to
altering the priority of a task. For that reason I prefer to keep using
this term.

> > +   on a writer fully support the priority inheritance protocol.
…
> > +raw_spinlock_t
> > +--------------
> > +
> > +As raw_spinlock_t locking disables preemption and eventually interrupts the
> > +code inside the critical region has to be careful to avoid calls into code
> 
> Can I buy a comma in there somewhere, please?
> I don't get it as is.

What about

| As raw_spinlock_t locking disables preemption, and eventually interrupts, the
| code inside the critical region has to be careful to avoid calls into code

any better?

…

Sebastian
