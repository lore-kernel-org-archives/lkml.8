Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37116C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 00:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 050FB2072C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 00:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590193456;
	bh=Ltqk5S7sTe6qhzTsLX+lmDJTePgoj+yWfBQOSW1e5F8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wZ9g5kMoLXaWckn83reSwYI87r3fKBbTMAQ2qM0bPk5pYYXW50OcGVpSEumDtrh/u
	 V84ZzCdI5VOg4b2MfkVfXEkePBCj1icVPN2gp7Z0WSMsKnKKIody/GDBVUVazxMvvi
	 Osh8qxrKGW/sSrEvIC+A6F4vRHedPqH3OeJsHads=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbgEWAYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 20:24:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731169AbgEWAYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 20:24:14 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F161C206B6;
        Sat, 23 May 2020 00:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590193454;
        bh=Ltqk5S7sTe6qhzTsLX+lmDJTePgoj+yWfBQOSW1e5F8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1bkaaMvhTxF5JMHQIXeMj1VUx4IxQzKJsYnk9y9BesD/kJ1NP93vE9yr7FoNNbDBS
         GeeUnYVf9sO7wwe+wmjsUDnFf3KF0cV1FwI/fT1mKecJ3TmJeSLozYUh1+u751XCA/
         7ihIEaQJI1cwlxIqd2N87NnqyzPwHpOeX5nIo0NI=
Date:   Fri, 22 May 2020 17:24:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mmotm] mm/swap: fix livelock in
 __read_swap_cache_async()
Message-Id: <20200522172413.19c1d45848b4f3db1015a534@linux-foundation.org>
In-Reply-To: <alpine.LSU.2.11.2005212246080.8458@eggly.anvils>
References: <alpine.LSU.2.11.2005212246080.8458@eggly.anvils>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 22:56:20 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> I've only seen this livelock on one machine (repeatably, but not to
> order), and not fully analyzed it - two processes seen looping around
> getting -EEXIST from swapcache_prepare(), I guess a third (at lower
> priority? but wanting the same cpu as one of the loopers? preemption
> or cond_resched() not enough to let it back in?) set SWAP_HAS_CACHE,
> then went off into direct reclaim, scheduled away, and somehow could
> not get back to add the page to swap cache and let them all complete.
> 
> Restore the page allocation in __read_swap_cache_async() to before
> the swapcache_prepare() call: "mm: memcontrol: charge swapin pages
> on instantiation" moved it outside the loop, which indeed looks much
> nicer, but exposed this weakness.  We used to allocate new_page once
> and then keep it across all iterations of the loop: but I think that
> just optimizes for a rare case, and complicates the flow, so go with
> the new simpler structure, with allocate+free each time around (which
> is more considerate use of the memory too).
> 
> Fix the comment on the looping case, which has long been inaccurate:
> it's not a racing get_swap_page() that's the problem here.
> 
> Fix the add_to_swap_cache() and mem_cgroup_charge() error recovery:
> not swap_free(), but put_swap_page() to undo SWAP_HAS_CACHE, as was
> done before; but delete_from_swap_cache() already includes it.
> 
> And one more nit: I don't think it makes any difference in practice,
> but remove the "& GFP_KERNEL" mask from the mem_cgroup_charge() call:
> add_to_swap_cache() needs that, to convert gfp_mask from user and page
> cache allocation (e.g. highmem) to radix node allocation (lowmem), but
> we don't need or usually apply that mask when charging mem_cgroup.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> Mostly fixing mm-memcontrol-charge-swapin-pages-on-instantiation.patch
> but now I see that mm-memcontrol-delete-unused-lrucare-handling.patch
> made a further change here (took an arg off the mem_cgroup_charge call):
> as is, this patch is diffed to go on top of both of them, and better
> that I get it out now for Johannes look at; but could be rediffed for
> folding into blah-instantiation.patch later.

Thanks - I did the necessary jiggery-pokery to get this into the right
place.

