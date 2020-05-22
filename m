Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F84C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E54206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgEVLGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 07:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbgEVLGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 07:06:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1ACC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 04:06:01 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jc5Uz-0002l6-Qe; Fri, 22 May 2020 13:05:57 +0200
Date:   Fri, 22 May 2020 13:05:56 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/8] locking: Introduce local_lock()
Message-ID: <20200522110556.czizy72ak2nr32ve@linutronix.de>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-2-bigeasy@linutronix.de>
 <20200520120450.GL317569@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200520120450.GL317569@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-20 14:04:50 [+0200], Peter Zijlstra wrote:
> On Tue, May 19, 2020 at 10:19:05PM +0200, Sebastian Andrzej Siewior wrote:
> > +/**
> > + * DEFINE_LOCAL_LOCK - Define and initialize a per CPU local lock
> > + * @lock:	Name of the lock instance
> > + */
> > +#define DEFINE_LOCAL_LOCK(lvar)					\
> > +	DEFINE_PER_CPU(struct local_lock, lvar) = { INIT_LOCAL_LOCK(lvar) }
> > +
> > +/**
> > + * DECLARE_LOCAL_LOCK - Declare a defined per CPU local lock
> > + * @lock:	Name of the lock instance
> > + */
> > +#define DECLARE_LOCAL_LOCK(lvar)				\
> > +	DECLARE_PER_CPU(struct local_lock, lvar)
> 
> So I think I'm going to argue having these is a mistake. The local_lock
> should be put in a percpu structure along with the data it actually
> protects.

So I got rid of these and made the local_lock part of the per-CPU
struct.

> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +# define LL_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname }
> 
> That wants to be:
> 
> 	.dep_map = {
> 		.name = #lockname,
> 		.wait_type_inner = LD_WAIT_SPIN,

Why LD_WAIT_SPIN and not LD_WAIT_SLEEP? On RT the lock becomes sleeping
and none of the SPIN restrictions apply. 

> 	}
> 
> > +#else
> > +# define LL_DEP_MAP_INIT(lockname)
> > +#endif

Sebastian
