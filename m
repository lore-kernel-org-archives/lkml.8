Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3FFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 05:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E8AD206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 05:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgHNFmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 01:42:47 -0400
Received: from verein.lst.de ([213.95.11.211]:48371 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgHNFmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 01:42:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 58BF068C7B; Fri, 14 Aug 2020 07:42:42 +0200 (CEST)
Date:   Fri, 14 Aug 2020 07:42:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        iommu <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] dma-debug: fix debug_dma_assert_idle(), use
 rcu_read_lock()
Message-ID: <20200814054241.GA719@lst.de>
References: <alpine.LSU.2.11.2008122005240.11996@eggly.anvils> <CAHk-=whYLHtbeF6BFmoiik9PTjP2+pnpWxXLE9f0ccnT0LAd5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whYLHtbeF6BFmoiik9PTjP2+pnpWxXLE9f0ccnT0LAd5A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 12:02:41PM -0700, Linus Torvalds wrote:
> Yeah, that's ridiculously expensive, and serializes things for no good reason.
> 
> Your patch looks obviously correct to me (Christoph?),

It also looks correct to me.

> but it also
> makes me go "why are we doing this in the first place"?
> 
> Because it looks to me like
>  (a) the debug check is wrong
>  (b) this is left-over from early debugging
> 
> In particular, I don't see why we couldn't do a COW on a page that is
> under writeback at the same time. We're not changing the page that is
> doing DMA.

Yes.  We don't need to check for a DMA to the device, but a DMA from
the device while under DMA obviously is bogus.  But then again you'd
need to try really hard to do that.

> In fact, the whole "COW with DMA" makes me feel like the real bug may
> have been due that whole "ambiguous COW" thing, which was fixed in
> 17839856fd58 ("gup: document and work around "COW can break either
> way" issue")
> 
> That debug thing goes back almost 7 years, and I don't think it has
> caught anything in those seven years, but I could be wrong.
> 
> The commit that adds it does talk about a bug, but that code was
> removed entirely eventually. And google shows no hits for
> debug_dma_assert_idle() since - until your email.
> 
> So my gut feel is that we should remove the check entirely, although
> your patch does seem like a big improvement.
> 
> Christoph?

The whole thing predates my involvement with the code, but I defintively
think the patch from Hugh is a major improvement.  But I would also
have no problem with just removing it entirely.
