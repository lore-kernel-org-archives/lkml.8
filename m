Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B19C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 553172065F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390412AbgFXMVQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:21:16 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:55174 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388548AbgFXMVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:21:13 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21602377-1500050 
        for multiple; Wed, 24 Jun 2020 13:21:08 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200624121053.GD6578@ziepe.ca>
References: <20200624080248.3701-1-chris@chris-wilson.co.uk> <20200624121053.GD6578@ziepe.ca>
From:   Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 1/2] mm/mmu_notifier: Mark up direct reclaim paths with MAYFAIL
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>
Message-ID: <159300126338.4527.3968787379471939056@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Wed, 24 Jun 2020 13:21:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jason Gunthorpe (2020-06-24 13:10:53)
> On Wed, Jun 24, 2020 at 09:02:47AM +0100, Chris Wilson wrote:
> > When direct reclaim enters the shrinker and tries to reclaim pages, it
> > has to opportunitically unmap them [try_to_unmap_one]. For direct
> > reclaim, the calling context is unknown and may include attempts to
> > unmap one page of a dma object while attempting to allocate more pages
> > for that object. Pass the information along that we are inside an
> > opportunistic unmap that can allow that page to remain referenced and
> > mapped, and let the callback opt in to avoiding a recursive wait.
> 
> i915 should already not be holding locks shared with the notifiers
> across allocations that can trigger reclaim. This is already required
> to use notifiers correctly anyhow - why do we need something in the
> notifiers?

for (n = 0; n < num_pages; n++)
	pin_user_page()

may call try_to_unmap_page from the lru shrinker for [0, n-1].

We're in the middle of allocating the object, how are we best to untangle
that?

Or during allocation of something that is using the pages pinned by that
object, how are we best to not to shrink that object as there is a
mutual dependency?
-Chris
