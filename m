Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CB4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D6E20823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589932719;
	bh=x77OGScDIde4TwlFEa+gPiHNd4pPSqVAZctmdtdQf+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xX1xEySIbK6ibvzHD34eCuNjU297XUQWtfWxBtuOax60vYxU/qF2jMCafk4IK4Oxh
	 kmt9MakeUBNKpj7dxjewHFeP6Adr/iJmzv9xg5lCzM+6TfcjUXj8mRdJ8XZaio9P4I
	 fSiYYCxAwpZBjLIHqOaIrm27GSs5ObQobR/CTFqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgESX6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 19:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgESX6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 19:58:38 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6ACE20709;
        Tue, 19 May 2020 23:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589932718;
        bh=x77OGScDIde4TwlFEa+gPiHNd4pPSqVAZctmdtdQf+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2I06lgu7e98/FtCn7fN7kQs4NOg0wiuoV2d61tLQ/OONM8ec7wot7wUuiAhhUEGjs
         u5CRjr33qLyVuX9TpXqy+2o5B5I3v8MQPgMxVBgKUvgsIYuxU1KdZbS+IkwVw3E1+Q
         hAIT0Ch2tMfGRaBUCiPtH97cFJs3gYfC3VEJ0uKU=
Date:   Tue, 19 May 2020 16:58:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org
Subject: Re: [PATCH 4/8] mm/swap: Use local_lock for protection
Message-Id: <20200519165837.883035d3228c582b9bff1d77@linux-foundation.org>
In-Reply-To: <20200519201912.1564477-5-bigeasy@linutronix.de>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
        <20200519201912.1564477-5-bigeasy@linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 22:19:08 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> From: Ingo Molnar <mingo@kernel.org>
> 
> The various struct pagevec per CPU variables are protected by disabling
> either preemption or interrupts across the critical sections. Inside
> these sections spinlocks have to be acquired.
> 
> These spinlocks are regular spinlock_t types which are converted to
> "sleeping" spinlocks on PREEMPT_RT enabled kernels. Obviously sleeping
> locks cannot be acquired in preemption or interrupt disabled sections.
> 
> local locks provide a trivial way to substitute preempt and interrupt
> disable instances. On a non PREEMPT_RT enabled kernel local_lock() maps
> to preempt_disable() and local_lock_irq() to local_irq_disable().
> 
> Add swapvec_lock to protect the per-CPU lru_add_pvec and
> lru_lazyfree_pvecs variables and rotate_lock to protect the per-CPU
> lru_rotate_pvecs variable
> 
> Change the relevant call sites to acquire these locks instead of using
> preempt_disable() / get_cpu() / get_cpu_var() and local_irq_disable() /
> local_irq_save().
> 
> There is neither a functional change nor a change in the generated
> binary code for non PREEMPT_RT enabled non-debug kernels.
> 
> When lockdep is enabled local locks have lockdep maps embedded. These
> allow lockdep to validate the protections, i.e. inappropriate usage of a
> preemption only protected sections would result in a lockdep warning
> while the same problem would not be noticed with a plain
> preempt_disable() based protection.
> 
> local locks also improve readability as they provide a named scope for
> the protections while preempt/interrupt disable are opaque scopeless.
> 
> Finally local locks allow PREEMPT_RT to substitute them with real
> locking primitives to ensure the correctness of operation in a fully
> preemptible kernel.
> No functional change.
>
> ...
>
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -12,6 +12,7 @@
>  #include <linux/fs.h>
>  #include <linux/atomic.h>
>  #include <linux/page-flags.h>
> +#include <linux/locallock.h>

Could we please make these local_lock.h and local_lock_internal.h?  Making
the filenames different from everything else is just irritating!

> +				local_lock(swapvec_lock);

It's quite peculiar that these operations appear to be pass-by-value. 
All other locking operations are pass-by-reference - spin_lock(&lock),
not spin_lock(lock).  This is what the eye expects to see and it's
simply more logical - calling code shouldn't have to "know" that the
locking operations are implemented as cpp macros.  And we'd be in a
mess if someone tried to convert these to real C functions.

Which prompts the question: why were all these operations implemented
in the processor anyway?  afaict they could have been written in C.


