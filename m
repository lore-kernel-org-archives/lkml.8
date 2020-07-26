Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19851C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91F72065E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2TtrIcN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgGZLww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 07:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgGZLww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 07:52:52 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D782BC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 04:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KjnRKLEHDr8Ifsf9arCUZI0KOq8oLtgssys0oHriYEo=; b=2TtrIcN2jOiRX3Q/kYQ11GmmlL
        WYx+GA09hXwgczIdN8KelbmcJK2ULiU7Ni1+sCobXjmuRtUBzmcs8CqTx3LnsjLQ6yGZklkMcuLOX
        mYH6xES74KhqiWQVVpZBBpSYPzjN3/lFBFabJWWG8gJ+dOVw5vW8SkRoPq82hnJ4yn69OtOD1ar3E
        OawOJoranHOkFWeHr2TLrLdDFXdqOpCOQ0WztALrMCHP7bG6yCllPPjjmf7Yy70ndXeZFX47u206H
        rZIfuuxzZcShaxu6KIHptWPMZvzKYB8HgDj8q2TyY8mloimv+Im7wno4Y524zY/0mWcuQdaYBJwBb
        bIKMnybQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzfCv-00086M-D6; Sun, 26 Jul 2020 11:52:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D0C1A301AC6;
        Sun, 26 Jul 2020 13:52:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 279DC2141FBAD; Sun, 26 Jul 2020 13:52:42 +0200 (CEST)
Date:   Sun, 26 Jul 2020 13:52:42 +0200
From:   peterz@infradead.org
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, jakub@redhat.com,
        hjl.tools@gmail.com
Subject: Re: [PATCH] kcsan: Add option to allow watcher interruptions
Message-ID: <20200726115242.GA119549@hirez.programming.kicks-ass.net>
References: <20200220141551.166537-1-elver@google.com>
 <20200220185855.GY2935@paulmck-ThinkPad-P72>
 <20200220213317.GA35033@google.com>
 <20200725145623.GZ9247@paulmck-ThinkPad-P72>
 <CANpmjNPhuvrhRHAiuv2Zju1VNSe7dO0aaYn+1TB99OF2Hv0S_A@mail.gmail.com>
 <20200725174430.GH10769@hirez.programming.kicks-ass.net>
 <20200725193909.GB9247@paulmck-ThinkPad-P72>
 <20200725201013.GZ119549@hirez.programming.kicks-ass.net>
 <20200725202131.GM43129@hirez.programming.kicks-ass.net>
 <20200725220750.GC9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725220750.GC9247@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 03:07:50PM -0700, Paul E. McKenney wrote:
> On Sat, Jul 25, 2020 at 10:21:31PM +0200, peterz@infradead.org wrote:
> > On Sat, Jul 25, 2020 at 10:10:13PM +0200, peterz@infradead.org wrote:
> > > On Sat, Jul 25, 2020 at 12:39:09PM -0700, Paul E. McKenney wrote:
> > 
> > > > This gets me the following for __rcu_read_lock():
> > > > 
> > > > 00000000000000e0 <__rcu_read_lock>:
> > > >       e0:	48 8b 14 25 00 00 00 	mov    0x0,%rdx
> > > >       e7:	00 
> > > >       e8:	8b 82 e0 02 00 00    	mov    0x2e0(%rdx),%eax
> > > >       ee:	83 c0 01             	add    $0x1,%eax
> > > >       f1:	89 82 e0 02 00 00    	mov    %eax,0x2e0(%rdx)
> > > >       f7:	c3                   	retq   
> > > >       f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
> > > >       ff:	00 
> > > > 
> > > > One might hope for a dec instruction, but this isn't bad.  We do lose
> > > > a few instructions compared to the C-language case due to differences
> > > > in address calculation:
> > > > 
> > > > 00000000000000e0 <__rcu_read_lock>:
> > > >       e0:	48 8b 04 25 00 00 00 	mov    0x0,%rax
> > > >       e7:	00 
> > > >       e8:	83 80 e0 02 00 00 01 	addl   $0x1,0x2e0(%rax)
> > > >       ef:	c3                   	retq   
> > > 
> > > Shees, that's daft... I think this is one of the cases where GCC is
> > > perhaps overly cautious when presented with 'volatile'.
> > > 
> > > It has a history of generating excessively crap code around volatile,
> > > and while it has improved somewhat, this seems to show there's still
> > > room for improvement...
> > > 
> > > I suppose this is the point where we go bug a friendly compiler person.
> 
> Sounds very good!  Do you have someone specific in mind?

Jakub perhaps?, Cc'ed

> > Having had a play with godbolt.org, it seems clang isn't affected by
> > this particular flavour of crazy, but GCC does indeed refuse to fuse the
> > address calculation and the addition.
> 
> So there is hope, then!
> 
> And even GCC's current state is an improvement.  Last I messed with this,
> the ACCESS_ONCE()++ approach generated a load, a register increment,
> and a store.
> 
> Do you still have the godbolt.org URLs?  I would be happy to file
> a bugzilla.

https://godbolt.org/z/rP8rYM
