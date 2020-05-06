Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE3FC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAD12208DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588786821;
	bh=bE63Lp2f3tulJ939j+qr3C21dbeTCgpfD0tbW6on/aw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=jKDny+VYxMt/zTdidnDZQNYsRl0PgsJIL/9nlOeb+JNLGR1DCmi+N0QJugmhvBbDO
	 IjfQCdfIYNeAik/cCORT47nNgNWPWILewdc7MJGnRpuYDgWxlYKpb3MqdLTVgYa2Sl
	 Uvp5Zj5Nq/XM7XVtHi75RtFchhexHwELYKXyIx24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgEFRkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728047AbgEFRkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:40:20 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB2AA20936;
        Wed,  6 May 2020 17:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588786819;
        bh=bE63Lp2f3tulJ939j+qr3C21dbeTCgpfD0tbW6on/aw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mlCVdHQ7dipgESZw6Y2jcMAKucLqT5xaDH/m6SnEi+YH5SnCHHYsccqRSGB6042mK
         dcS1++vwRFeAXky0kr8QjrEbJUgZ26yXMFFgxyCNLtuLFhX6lM1GzsMS1ZTge3BkEQ
         uSuTUOllOcbM/dszbDh0MWxOg0mL9a5f73+fGCac=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A8103352306C; Wed,  6 May 2020 10:40:19 -0700 (PDT)
Date:   Wed, 6 May 2020 10:40:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Kmemleak infrastructure improvement for task_struct leaks and
 call_rcu()
Message-ID: <20200506174019.GA2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <45D2D811-C3B0-442B-9744-415B4AC5CCDB@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45D2D811-C3B0-442B-9744-415B4AC5CCDB@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 12:22:37PM -0400, Qian Cai wrote:
> == task struck leaks ==
> There are leaks from task struct from time to time where someone forgot to call put_task_struct() somewhere leading to leaks. For example,
> 
> https://lore.kernel.org/lkml/C1CCBDAC-A453-4FF2-908F-0B6E356223D1@lca.pw/
> 
> It was such a pain to debug this kind of leaks at the moment, as all we could do was to audit the code by checking all new put_task_struct()  and get_task_struct() call sites which is error-prone because there could be other new call sites like get_pid_task() which would also need to be balanced with put_task_struct() as well.
> 
> What do you think about adding some aux call traces for kmemleak in general? For example, if the tracking object is a task struct, it would save call traces for the first and last call of both get_task_struct() and put_task_struct(). Then, it could be expanded to track other refcount-based leaks in the future.
> 
> == call_rcu() leaks ==
> Another issue that might be relevant is that it seems sometimes, kmemleak will give a lot of false positives (hundreds) because the memory was supposed to be freed by call_rcu()  (for example, in dst_release()) but for some reasons, it takes a long time probably waiting for grace periods or some kind of RCU self-stall, but the memory had already became an orphan. I am not sure how we are going to resolve this properly until we have to figure out why call_rcu() is taking so long to finish?

I know nothing about kmemleak, but I won't let that stop me from making
random suggestions...

One approach is to do an rcu_barrier() inside kmemleak just before
printing leaked blocks, and check to see if any are still leaked after
the rcu_barrier().

If kmemleak works on crash dumps, another approach is to scan RCU's
callback lists.  This will miss those callbacks that rcu_do_batch()
was in the middle of invoking, though.  It also misses cases where
someone passes a linked structure to call_rcu(), and then frees the
structure piece by piece within the callback function.

> Another solution is to add aux call traces for both skb_dst_drop() and skb_dst_set() for this case, but that there are many places to free memory via call_rcu() like inode free etc.

And call_rcu() has no idea where the memory starts.  And again, sometimes
there is memory linked from that passed to call_rcu() that will be freed
by the callback function.

In theory, these linked-structure cases could be handled by checking
the callback function and then traversing the links.  I wouldn't be
that ambitious, but don't let me discourage you.  ;-)

							Thanx, Paul
