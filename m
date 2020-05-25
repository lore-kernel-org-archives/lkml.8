Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570C4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415EF20723
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390248AbgEYL0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 07:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390170AbgEYL0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:26:41 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88B3C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:26:40 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jdBFe-0007Up-K5; Mon, 25 May 2020 13:26:38 +0200
Date:   Mon, 25 May 2020 13:26:38 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/7] locking: Introduce local_lock()
Message-ID: <20200525112638.5p2ctr5l26uzergb@linutronix.de>
References: <20200524215739.551568-1-bigeasy@linutronix.de>
 <20200524215739.551568-2-bigeasy@linutronix.de>
 <20200525070139.GB329373@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200525070139.GB329373@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-25 09:01:39 [+0200], Ingo Molnar wrote:
> 
> * Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > To address this PREEMPT_RT introduced the concept of local_locks which are
> > strictly per CPU.
> 
> > +++ b/include/linux/locallock_internal.h
> > @@ -0,0 +1,90 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_LOCALLOCK_H
> > +# error "Do not include directly, include linux/locallock.h"
> > +#endif
> > +
> > +#include <linux/percpu-defs.h>
> > +#include <linux/lockdep.h>
> > +
> > +struct local_lock {
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +	struct lockdep_map	dep_map;
> > +	struct task_struct	*owner;
> > +#endif
> > +};
> 
> This this looks very nice to me, there's a minor data structure 
> nomenclature related comment I have:
> 
> So local locks were supposed to be a look-alike to all the other 
> locking constructs we have, spinlock_t in particular. Why isn't there 
> a local_lock_t, instead of requiring 'struct local_lock'?

|git grep "struct \<spinlock\>"

and I did convert them spinlock_t and got even asked why
  https://lore.kernel.org/driverdev-devel/20190706100253.GA20497@kroah.com/

but yes. I can stick to local_lock_t instead.

> This abbreviation signals that these are 'small' data structures on 
> mainline kernels (zero size in fact), but the other advantage is that 
> the shorter name would prevent bloating of previously compact 
> structure definitions, such as:
> 
> >  struct squashfs_stream {
> > -	void		*stream;
> > +	void			*stream;
> > +	struct local_lock	lock;
> >  };
> 
> This would become:
> 
> >  struct squashfs_stream {
> >	void		*stream;
> > +	locallock_t	lock;
> >  };

Wasn't aware as this is considered bloating. 

> ( The other departure from spinlocks is that the 'spinlock_t' name, 
>   without underscores, while making the API names such as spin_lock() 
>   with an underscore, was a conscious didactic choice. Applying that 
>   principle to local locks gives us the spinlock_t-equivalent name of 
>   'locallock_t' - but the double 'l' reads a bit weirdly in this 
>   context. So I think using 'local_lock_t' as the data structure is 
>   probably the better approach. )

Okay, okay, I'm all yours.

> Thanks,
> 
> 	Ingo

Sebastian
