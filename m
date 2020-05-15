Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AFCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9666A207CB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zm4VDdQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgEOPB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726163AbgEOPB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:01:56 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA753C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D4yOzx37h7CTmRBy7LPM1GIskTBvLjag0bAMrSDWwW0=; b=zm4VDdQ19zoS05KSe07Gh8BiTz
        0Vy1QPDRXqBFrHlrtr6MjWQ7+M7dFytPiuKtNTMl7RIcWZGDJhtpy2Kmk5msVldMf4meT8TEVg9MT
        yolK/H8PJcXVjK3VBliyUFZCG/Lho0V8cOEqXRd6rpbYKXNBrYPMA8Lz8SU3E6wgJL85XGIl6RhpA
        K+HehBB5ELX1ZFgsdvWOnBeH/+VOG5NtyrPispd/b+wCNBfXIQ8MoVGgH+CNgPqNdZJxgmQ3NmJY6
        lQcd/JqDlfwdSc4pl+JrPZjot2R0jtuDoflFp6zHYnqoBknIy5h0xcYdpG56o9+ZScpa0+2ZBWcYK
        6DKGbDdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZbq2-0003d0-HN; Fri, 15 May 2020 15:01:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C9BA83007CD;
        Fri, 15 May 2020 17:01:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1EE73201951F8; Fri, 15 May 2020 17:01:22 +0200 (CEST)
Date:   Fri, 15 May 2020 17:01:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michel Lespinasse <walken@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <David.Woodhouse@intel.com>,
        Rik van Riel <riel@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/2] rbtree_latch: quit searching when reaching to
 maximum depth
Message-ID: <20200515150122.GY2957@hirez.programming.kicks-ass.net>
References: <20200515124710.16439-1-laijs@linux.alibaba.com>
 <20200515130030.GV2957@hirez.programming.kicks-ass.net>
 <CAJhGHyAMOQ7Bp8kYF7urp572SguFjiLs5PmqQvTKAkwfwBrOKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyAMOQ7Bp8kYF7urp572SguFjiLs5PmqQvTKAkwfwBrOKQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 10:39:25PM +0800, Lai Jiangshan wrote:
> On Fri, May 15, 2020 at 9:04 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Fri, May 15, 2020 at 12:47:06PM +0000, Lai Jiangshan wrote:
> > > lib/rbtree.c has ensured that there is not possible to
> > > inadvertently cause (temporary) loops in the tree structure
> > > as seen in program order of the modifier. But loop is still
> > > possible to be seen in searcher due to CPU's reordering.
> > >
> > > for example:
> > > modifier                              searcher
> > >
> > > left rotate at parent
> > > parent->rb_right is node
> > >                                       search to parent
> > >                                       parent->rb_right is node
> > >                                    +->see node->rb_left changed
> > > WRITE_ONCE(parent->rb_right, tmp);-+ |  node->rb_left is parennt
> > > no smp_wmb(), some arch can        | |
> > > reorder these two writes           | |  loop long between
> > > WRITE_ONCE(node->rb_left, parent);-+-+  parent and node
> > >                                  |
> > >                                  +--->finally see
> > >                                       parent->rb_right
> > >
> > > The long loop won't stop until the modifer's CPU flushes
> > > its writes. Too avoid it, we should limit the searching depth.
> >
> > Cute, have you actually observed this? Did you have performance issues?
> 
> I can only test it on x86 by now, which implies smp_wmb() between
> writes. I haven't observed any thing wrong. I'm just imaging
> it on some other ARCHs.

Note that smp_wmb() doesn't imply flushing the store-buffers. Nor does
the TSO memory model of x86 (it's the main feature that distinguishes
TSO from SC).

x86's MFENCE is a completion barrier and does imply so though.

> I accidentally found this part of code when I searched for
> whether there is any attempt again to use rbtree with RCU, and
> whether there are the cases besides speculative page fault.

It got mentioned earlier in the contect of a stream of changes, an
uninterrupted modifier can basically starve a search.

But I don't think that's a problem with the current users.

> > > There are no more than (1<<BITS_PER_LONG)-1 nodes in the tree.
> > > And the max_depth of a tree is no more than 2*lg(node_count+1),
> > > which is no mare than 2*BITS_PER_LONG.
> > >
> > > So the serarch should stop when diving down up to
> > > 2*BITS_PER_LONG depth.
> >
> > Arguably you can have a larger key space, but I think due to memory
> > constraints this limit still isn't wrong. But I do feel you need a
> > comment with that.
> 
> Sure, I will add some comments about why "2*BITS_PER_LONG" in code.
> 
> But how it could be larger key space? there are not more than
> (1<<BITS_PER_LONG) bytes in the kernel dereferencable address
> space, and (1<<BITS_PER_LONG)/sizeof(rb_node) must be less than
> (1<<BITS_PER_LONG)-1.

Well, the key space is determined by the comparator operators that are
provided, which can easily compare values that are larger than 64bit.

But yes, the address space implies limits regardless of the actual
key-space. Note that BITS_PER_LONG does not related to the actual memory
space for things like i386-PAE and ARMv7-LPEA.
