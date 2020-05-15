Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE2AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0914A2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GV1f5TcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgEONBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgEONBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:01:01 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69555C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 06:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h2owgyYDbTAlYqnctNoL/S3qPxaT1kcJhxurcXxw10o=; b=GV1f5TcNia61n2ZO7zfukMn4ut
        uDX9S1Nlpr8L2Br5bOxQLG/83xdIZENw80kP5o44MoEZRWlB09/m6NbgRJLTy/tsTHLQZ+8yXaygS
        FsNq0ZeVs4Z9cPm/zROCvZ/+5/cA4ih1ohVyZTnSLGonD0L8k+L6EkDuu+T89NpqA2MB6P3w4fHP9
        Mqj3DtKmEhHmUMkKv6CmNbGSVSPKqlrwteLtDwLsxloKX5Dv3LQ24DSKYU8h8nmGqj0AsBjB7xd0C
        STLHfPvxmi+YXIsxtBieaqxPS53FbnkrWCrrDvbgxkf7hL5XQRRtj+1ml4UiqLgOydhCEIxLEg2Oy
        4UQap32w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZZx2-0000DP-MY; Fri, 15 May 2020 13:00:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AD5713007CD;
        Fri, 15 May 2020 15:00:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1768A2024968B; Fri, 15 May 2020 15:00:30 +0200 (CEST)
Date:   Fri, 15 May 2020 15:00:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michel Lespinasse <walken@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <David.Woodhouse@intel.com>,
        Rik van Riel <riel@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/2] rbtree_latch: quit searching when reaching to
 maximum depth
Message-ID: <20200515130030.GV2957@hirez.programming.kicks-ass.net>
References: <20200515124710.16439-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515124710.16439-1-laijs@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 12:47:06PM +0000, Lai Jiangshan wrote:
> lib/rbtree.c has ensured that there is not possible to
> inadvertently cause (temporary) loops in the tree structure
> as seen in program order of the modifier. But loop is still
> possible to be seen in searcher due to CPU's reordering.
> 
> for example:
> modifier				searcher
> 
> left rotate at parent
> parent->rb_right is node
> 					search to parent
> 					parent->rb_right is node
> 				     +->see node->rb_left changed
> WRITE_ONCE(parent->rb_right, tmp);-+ |  node->rb_left is parennt
> no smp_wmb(), some arch can        | |
> reorder these two writes           | |  loop long between
> WRITE_ONCE(node->rb_left, parent);-+-+  parent and node
> 				   |
> 				   +--->finally see
> 					parent->rb_right
> 
> The long loop won't stop until the modifer's CPU flushes
> its writes. Too avoid it, we should limit the searching depth.

Cute, have you actually observed this? Did you have performance issues?

> There are no more than (1<<BITS_PER_LONG)-1 nodes in the tree.
> And the max_depth of a tree is no more than 2*lg(node_count+1),
> which is no mare than 2*BITS_PER_LONG.
> 
> So the serarch should stop when diving down up to
> 2*BITS_PER_LONG depth.

Arguably you can have a larger key space, but I think due to memory
constraints this limit still isn't wrong. But I do feel you need a
comment with that.
