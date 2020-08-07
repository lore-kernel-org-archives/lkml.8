Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3779EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168CF22C9F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="utQ1/KXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgHGINF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGINF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:13:05 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAB3C061574;
        Fri,  7 Aug 2020 01:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qp7LQ+rs4r8P2XqNJ8nqxuIe5TvSgVYBoyIvFE6P4/Y=; b=utQ1/KXbWWF7ww03dFDexVNvlM
        XGH8p9Zf3umY/wm02uThSSqSASxJ9FhjZalyXGNz+GtzCMcAgsY1B8rYsFWWuOKMrbvgoudrqNzDH
        2Yacs0BCgsqhxNqknPMSmz6Hz1tB2LUQpj71LLe+B3nT7K3HRJGUFJH8rWzJFQmvM8tUtWCb/K9YD
        8RLqJ5vRl6GIh7vnl8FKlb2ovPJXyHjwb9QZC7kPm9PHcs4GHhFVSSFGL4V/Kn6KNb8QPhLtSqWON
        zpkeuw4ypDSq1/KAM4R5o2n6VAzvAyvC1LiuRHi7JKdP4IJ4peRnoz1CTbTrMY/aSyXtyx8x2DE8o
        59sH3ObQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3xUq-0003X3-FC; Fri, 07 Aug 2020 08:13:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 181FF3010D2;
        Fri,  7 Aug 2020 10:12:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E53362C1FAC7B; Fri,  7 Aug 2020 10:12:53 +0200 (CEST)
Date:   Fri, 7 Aug 2020 10:12:53 +0200
From:   peterz@infradead.org
To:     Guo Ren <guoren@kernel.org>
Cc:     Ren Guo <ren_guo@c-sky.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, mathieu.desnoyers@efficios.com,
        Will Deacon <will@kernel.org>
Subject: Re: csky: smp_mb__after_spinlock
Message-ID: <20200807081253.GD2674@hirez.programming.kicks-ass.net>
References: <20200805104146.GP2674@hirez.programming.kicks-ass.net>
 <CAJF2gTRqi-HuxJsMOjHTpaf33f1L9LypF-FkWo8OZm4SP12Hnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTRqi-HuxJsMOjHTpaf33f1L9LypF-FkWo8OZm4SP12Hnw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 08:22:36AM +0800, Guo Ren wrote:
> Hi Peter,
> 
> On Thu, Aug 6, 2020 at 3:53 AM <peterz@infradead.org> wrote:
> >
> > Hi,
> >
> > While doing an audit of smp_mb__after_spinlock, I found that csky
> > defines it, why?
> >
> > CSKY only has smp_mb(), it doesn't override __atomic_acquire_fence or
> > otherwise special cases it's atomic*_acquire() primitives. It has an
> > explicit smp_mb() in its arch_spin_lock().
> 
> Yes, csky didn't implement ACQUIRE/RELEASE in spinlock.h. So it is a
> redundant and side-effect wrong macro, we should remove it to fixup.
> 
> TODO:
>  - implement csky's ACQUIRE/RELEASE barrier

Fair enough; please Cc me when you get to it.

> > Also, why have two implementations of all the locking?
> 
> I just kept my baby's codes :P. Now, we could remove it and just keep
> the ticket's one.
> 
> BTW, I want to change the spinlock to qspinlock, but csky only has
> 32-bit atomic operation in hardware.

Yeah, that's okay, you can do 'short' atomics using wider RmW.

> Any plan to deal with this in spinlock?
> 
> Maybe for the embedded scenario, qspinlock seems a bit heavy,

I tend to agree, qspinlock only really makes sense when you have
multiple cache domains and NUMA makes it shine.

> are any
> tickets-like comm spinlock infrastructures in the plan?

No. ticket locks are 'simple' and their implementation fairly straight
forward. Also, since the generic code only has cmpxchg, a generic ticket
lock would be sub-optimal on LL/SC (or even x86 for that matter).

It would look something like this, which I think is pretty terrible for
just about any arch compared to what you can do with inline asm.

struct ticket_lock {
	union {
		atomic_t	val;
		struct {
#ifdef __LITTLE_ENDIAN
			u16	head;
			u16	tail;
#else
			u16	tail;
			u16	head;
#endif
		};
	};
};

void ticket_lock(struct ticket_lock *lock)
{
	unsigned int val = atomic_read(&lock->val);
	struct ticket_lock lock;

	do {
		lock.val = ATOMIC_INIT(val);
		lock.head++;
	} while (!atomic_try_cmpxchg_relaxed(&lock->lock, &val, lock.val));

	atomic_cond_read_acquire(&lock->val, (VAL >> 16) == lock.head);
}

void ticket_unlock(struct ticket_lock *lock)
{
	atomic_fetch_inc_release(&lock->val);
}

