Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20853C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 20:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9C642070B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 20:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KOcxNFyF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgGYUKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 16:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGYUKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 16:10:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2421AC08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 13:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pw5RUMobivqcNCfDWDHWYkXzCXE5qOoVsxCJP/NEQ88=; b=KOcxNFyFQPJAlT02SO5ozn3dyO
        VP7SPGW0orHgpa2x5jdZSazYY62jrFX+6p4Ucc8IXcpM4Evn1qHatKG2Kc7bdHSLI8Tpo+jFDneVf
        4GKx5s3nzq/5mnut6zoyoAgmdugvTAuPujSNJQys21qcMbDbIorBhAix3ErioCMUA3YBALhYaTHb0
        CM8MiFLp/UwIz4K2JerjC/7a5Ul0eH9gCoE/KSq00jjQq9ZqbOI8QqixkOZmbWal988elBSsqgak2
        FQVzGJrsrJclOnMrp0Zc4SU6MW0yxjSvsoZ/apvt96rrD8Kz9O3AW7Ka8LyQZgV50SJjo+H4cfBoI
        JKKOwWgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzQUr-0008Hv-PC; Sat, 25 Jul 2020 20:10:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 757B03013E5;
        Sat, 25 Jul 2020 22:10:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6045B2B8A8164; Sat, 25 Jul 2020 22:10:13 +0200 (CEST)
Date:   Sat, 25 Jul 2020 22:10:13 +0200
From:   peterz@infradead.org
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kcsan: Add option to allow watcher interruptions
Message-ID: <20200725201013.GZ119549@hirez.programming.kicks-ass.net>
References: <20200220141551.166537-1-elver@google.com>
 <20200220185855.GY2935@paulmck-ThinkPad-P72>
 <20200220213317.GA35033@google.com>
 <20200725145623.GZ9247@paulmck-ThinkPad-P72>
 <CANpmjNPhuvrhRHAiuv2Zju1VNSe7dO0aaYn+1TB99OF2Hv0S_A@mail.gmail.com>
 <20200725174430.GH10769@hirez.programming.kicks-ass.net>
 <20200725193909.GB9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725193909.GB9247@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 12:39:09PM -0700, Paul E. McKenney wrote:
> On Sat, Jul 25, 2020 at 07:44:30PM +0200, Peter Zijlstra wrote:

> > So the thing is, since RCU count is 0 per context (an IRQ must have an
> > equal amount of rcu_read_unlock() as it has rcu_read_lock()), interrupts
> > are not in fact a problem, even on load-store (RISC) architectures
> > (preempt_count has the same thing).
> 
> True enough!
> 
> > So the addition/subtraction in rcu_preempt_read_{enter,exit}() doesn't
> > need to be atomic vs interrupts. The only thing we really do need is
> > them being single-copy-atomic.
> > 
> > The problem with READ/WRITE_ONCE is that if we were to use it, we'd end
> > up with a load-store, even on x86, which is sub-optimal.
> 
> Agreed.
> 
> > I suppose the 'correct' code here would be something like:
> > 
> > 	*((volatile int *)&current->rcu_read_lock_nesting)++;
> > 
> > then the compiler can either do a single memop (x86 and the like) or a
> > load-store that is free from tearing.
> 
> Hah!!!  That is the original ACCESS_ONCE(), isn't it?  ;-)
> 
> 	ACCESS_ONCE(current->rcu_read_lock_nesting)++;

Indeed :-)

> But open-coding makes sense unless a lot of other places need something
> similar.  Besides, open-coding allows me to defer bikeshedding on the
> name, given that there are actually two accesses.  :-/

Yeah, ISTR that being one of the reasons we got rid of it.

> So:
> 	(*(volatile int *)&(current->rcu_read_lock_nesting))++;

Urgh, sorry for messing that up.

> This gets me the following for __rcu_read_lock():
> 
> 00000000000000e0 <__rcu_read_lock>:
>       e0:	48 8b 14 25 00 00 00 	mov    0x0,%rdx
>       e7:	00 
>       e8:	8b 82 e0 02 00 00    	mov    0x2e0(%rdx),%eax
>       ee:	83 c0 01             	add    $0x1,%eax
>       f1:	89 82 e0 02 00 00    	mov    %eax,0x2e0(%rdx)
>       f7:	c3                   	retq   
>       f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
>       ff:	00 
> 
> One might hope for a dec instruction, but this isn't bad.  We do lose
> a few instructions compared to the C-language case due to differences
> in address calculation:
> 
> 00000000000000e0 <__rcu_read_lock>:
>       e0:	48 8b 04 25 00 00 00 	mov    0x0,%rax
>       e7:	00 
>       e8:	83 80 e0 02 00 00 01 	addl   $0x1,0x2e0(%rax)
>       ef:	c3                   	retq   

Shees, that's daft... I think this is one of the cases where GCC is
perhaps overly cautious when presented with 'volatile'.

It has a history of generating excessively crap code around volatile,
and while it has improved somewhat, this seems to show there's still
room for improvement...

I suppose this is the point where we go bug a friendly compiler person.

Alternatively we can employ data_race() and trust the compiler not to be
daft about tearing... which we've been relying with this code anyway.
