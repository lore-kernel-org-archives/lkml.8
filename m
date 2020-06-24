Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EA5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F02D206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405899AbgFXR67 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:58:59 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:49507 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405377AbgFXR66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:58:58 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21606053-1500050 
        for multiple; Wed, 24 Jun 2020 18:58:53 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200624165057.GJ6578@ziepe.ca>
References: <20200624080248.3701-1-chris@chris-wilson.co.uk> <20200624121053.GD6578@ziepe.ca> <159300126338.4527.3968787379471939056@build.alporthouse.com> <20200624123910.GA3178169@ziepe.ca> <159300796224.4527.2014771396582759689@build.alporthouse.com> <20200624141604.GH6578@ziepe.ca> <159300850942.4527.8335506003268197914@build.alporthouse.com> <20200624142544.GI6578@ziepe.ca> <159300945202.4527.4366416413140642633@build.alporthouse.com> <20200624165057.GJ6578@ziepe.ca>
From:   Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 1/2] mm/mmu_notifier: Mark up direct reclaim paths with MAYFAIL
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>
Message-ID: <159302152915.4527.9099070806700792078@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Wed, 24 Jun 2020 18:58:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jason Gunthorpe (2020-06-24 17:50:57)
> On Wed, Jun 24, 2020 at 03:37:32PM +0100, Chris Wilson wrote:
> > Quoting Jason Gunthorpe (2020-06-24 15:25:44)
> > > On Wed, Jun 24, 2020 at 03:21:49PM +0100, Chris Wilson wrote:
> > > > Quoting Jason Gunthorpe (2020-06-24 15:16:04)
> > > > > On Wed, Jun 24, 2020 at 03:12:42PM +0100, Chris Wilson wrote:
> > > > > > Quoting Jason Gunthorpe (2020-06-24 13:39:10)
> > > > > > > On Wed, Jun 24, 2020 at 01:21:03PM +0100, Chris Wilson wrote:
> > > > > > > > Quoting Jason Gunthorpe (2020-06-24 13:10:53)
> > > > > > > > > On Wed, Jun 24, 2020 at 09:02:47AM +0100, Chris Wilson wrote:
> > > > > > > > > > When direct reclaim enters the shrinker and tries to reclaim pages, it
> > > > > > > > > > has to opportunitically unmap them [try_to_unmap_one]. For direct
> > > > > > > > > > reclaim, the calling context is unknown and may include attempts to
> > > > > > > > > > unmap one page of a dma object while attempting to allocate more pages
> > > > > > > > > > for that object. Pass the information along that we are inside an
> > > > > > > > > > opportunistic unmap that can allow that page to remain referenced and
> > > > > > > > > > mapped, and let the callback opt in to avoiding a recursive wait.
> > > > > > > > > 
> > > > > > > > > i915 should already not be holding locks shared with the notifiers
> > > > > > > > > across allocations that can trigger reclaim. This is already required
> > > > > > > > > to use notifiers correctly anyhow - why do we need something in the
> > > > > > > > > notifiers?
> > > > > > > > 
> > > > > > > > for (n = 0; n < num_pages; n++)
> > > > > > > >       pin_user_page()
> > > > > > > > 
> > > > > > > > may call try_to_unmap_page from the lru shrinker for [0, n-1].
> > > > > > > 
> > > > > > > Yes, of course you can't hold any locks that intersect with notifiers
> > > > > > > across pin_user_page()/get_user_page()
> > > > > > 
> > > > > > What lock though? It's just the page refcount, shrinker asks us to drop
> > > > > > it [via mmu], we reply we would like to keep using that page as freeing
> > > > > > it for the current allocation is "robbing Peter to pay Paul".
> > > > > 
> > > > > Maybe I'm unclear what this series is actually trying to fix? 
> > > > > 
> > > > > You said "avoiding a recursive wait" which sounds like some locking
> > > > > deadlock to me.
> > > > 
> > > > It's the shrinker being called while we are allocating for/on behalf of
> > > > the object. As we are actively using the object, we don't want to free
> > > > it -- the partial object allocation being the clearest, if the object
> > > > consists of 2 pages, trying to free page 0 in order to allocate page 1
> > > > has to fail (and the shrinker should find another candidate to reclaim,
> > > > or fail the allocation).
> > > 
> > > mmu notifiers are not for influencing policy of the mm.
> > 
> > It's policy is "this may fail" regardless of the mmu notifier at this
> > point. That is not changed.
> 
> MMU notifiers are for tracking updates, they are not allowed to fail.
> The one slightly weird case of non-blocking is the only exception.
> 
> > Your suggestion is that we move the pages to the unevictable mapping so
> > that the shrinker LRU is never invoked on pages we have grabbed with
> > pin_user_page. Does that work with the rest of the mmu notifiers?
> 
> That is beyond what I'm familiar with - but generally - if you want to
> influence decisions the MM is making then it needs to be at the
> front of the process and not inside notifiers. 
> 
> So what you describe seems broadly appropriate to me.

Sadly, it's a mlock_vma_page problem all over again.
 
> I'm still a little unclear on what you are trying to fix - pinned
> pages are definitely not freed, do you have some case where pages
> which are pinned are being cleaned out from the MM despite being
> pinned? Sounds a bit strange, maybe that is worth adressing directly?

It suffices to say that pin_user_pages does not prevent try_to_unmap_one
from trying to revoke the page. But we could perhaps slip a
page_maybe_dma_pinned() in around there and see what happens.
-Chris
