Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97F4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9091B20738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fNofrvXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405206AbgFXQvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404017AbgFXQvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:51:00 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D17C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:50:59 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i16so2223190qtr.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CJ/zC3i7uCzBrZdCj1lkfa2qkxImL6pVZToepDWiydA=;
        b=fNofrvXCudeSmx5WZQAI95REcbM9q5qe8B5GgBeLz1AQDJ9q8fVr6Liu0M1HeFNR9t
         vDLzyn3jzM/PlfbV+oOQ4Ade4v9F3kraTj9mPDUWLh95/G3qpnGZ+o23sKoEvRoLmeTP
         QyyJD2gbAsaTk1e33GlQsdAUFLd7IOt/TQ+PnVtLmAENZumTprYOQGPzI9c3vtWDlvDV
         WxQMPTTmmU70MhWwFsxLpBSY7BRPdCWA7HpGv7V/iDK33NI5lw2vC39Xx2jYI8pfDm3B
         jL/kbwjuMqLE82rWq8+ksr8Ekmt4QkTmpsYoyP7ujjxWl59agDEhkJUvc1IVbskO3CTy
         rrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CJ/zC3i7uCzBrZdCj1lkfa2qkxImL6pVZToepDWiydA=;
        b=KsWC/rHurMzEDUyJv5h+UIVm6adepz6Q2MF0ogbYdKCgyHHqdlSRbtDmxabwYzHiTX
         jVxTdMb0Q2wDN6iHoAmlRDIrLZ0Dm4Eu1W1NkxxmSZ6h6gyrbSBVux6RVBKFDqYtB/e6
         GPYKCbLnqXTo867OXecb/qXYc06wGeb/5y7utvCa5C8yhzjtIA0blYPJss0boeH+Cras
         ZhF+rYglzBITO7X/nIWTf6t8vuy7Sak+Cdmf1dVjL6+Ttrwk54ZtKxV4Zkp77VrcmirJ
         mzosL6O4C1ae+L/VOwZ6zl7dBXITm3NjggB8mQnoddCBG3vTCqcgA2FllQ08YPgSc66S
         XlEg==
X-Gm-Message-State: AOAM5321niKIx4xln97uA8Vfdg9xWIMxYd9SRg6ZJte/Wmqun3V/ToTE
        lUPA/t8Ettld54D33NHctf4WnBZB9TWmhA==
X-Google-Smtp-Source: ABdhPJxXiUpQ+IwyKRJYOkeapuUApsWhRsPzjsWzdixzDzM/nldiWeHsm/fBSUu2FiJNnggqRfkR2A==
X-Received: by 2002:ac8:8a4:: with SMTP id v33mr18850490qth.392.1593017458806;
        Wed, 24 Jun 2020 09:50:58 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id g16sm4579452qko.5.2020.06.24.09.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 09:50:58 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jo8bx-00DYYk-89; Wed, 24 Jun 2020 13:50:57 -0300
Date:   Wed, 24 Jun 2020 13:50:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm/mmu_notifier: Mark up direct reclaim paths with
 MAYFAIL
Message-ID: <20200624165057.GJ6578@ziepe.ca>
References: <20200624080248.3701-1-chris@chris-wilson.co.uk>
 <20200624121053.GD6578@ziepe.ca>
 <159300126338.4527.3968787379471939056@build.alporthouse.com>
 <20200624123910.GA3178169@ziepe.ca>
 <159300796224.4527.2014771396582759689@build.alporthouse.com>
 <20200624141604.GH6578@ziepe.ca>
 <159300850942.4527.8335506003268197914@build.alporthouse.com>
 <20200624142544.GI6578@ziepe.ca>
 <159300945202.4527.4366416413140642633@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159300945202.4527.4366416413140642633@build.alporthouse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 03:37:32PM +0100, Chris Wilson wrote:
> Quoting Jason Gunthorpe (2020-06-24 15:25:44)
> > On Wed, Jun 24, 2020 at 03:21:49PM +0100, Chris Wilson wrote:
> > > Quoting Jason Gunthorpe (2020-06-24 15:16:04)
> > > > On Wed, Jun 24, 2020 at 03:12:42PM +0100, Chris Wilson wrote:
> > > > > Quoting Jason Gunthorpe (2020-06-24 13:39:10)
> > > > > > On Wed, Jun 24, 2020 at 01:21:03PM +0100, Chris Wilson wrote:
> > > > > > > Quoting Jason Gunthorpe (2020-06-24 13:10:53)
> > > > > > > > On Wed, Jun 24, 2020 at 09:02:47AM +0100, Chris Wilson wrote:
> > > > > > > > > When direct reclaim enters the shrinker and tries to reclaim pages, it
> > > > > > > > > has to opportunitically unmap them [try_to_unmap_one]. For direct
> > > > > > > > > reclaim, the calling context is unknown and may include attempts to
> > > > > > > > > unmap one page of a dma object while attempting to allocate more pages
> > > > > > > > > for that object. Pass the information along that we are inside an
> > > > > > > > > opportunistic unmap that can allow that page to remain referenced and
> > > > > > > > > mapped, and let the callback opt in to avoiding a recursive wait.
> > > > > > > > 
> > > > > > > > i915 should already not be holding locks shared with the notifiers
> > > > > > > > across allocations that can trigger reclaim. This is already required
> > > > > > > > to use notifiers correctly anyhow - why do we need something in the
> > > > > > > > notifiers?
> > > > > > > 
> > > > > > > for (n = 0; n < num_pages; n++)
> > > > > > >       pin_user_page()
> > > > > > > 
> > > > > > > may call try_to_unmap_page from the lru shrinker for [0, n-1].
> > > > > > 
> > > > > > Yes, of course you can't hold any locks that intersect with notifiers
> > > > > > across pin_user_page()/get_user_page()
> > > > > 
> > > > > What lock though? It's just the page refcount, shrinker asks us to drop
> > > > > it [via mmu], we reply we would like to keep using that page as freeing
> > > > > it for the current allocation is "robbing Peter to pay Paul".
> > > > 
> > > > Maybe I'm unclear what this series is actually trying to fix? 
> > > > 
> > > > You said "avoiding a recursive wait" which sounds like some locking
> > > > deadlock to me.
> > > 
> > > It's the shrinker being called while we are allocating for/on behalf of
> > > the object. As we are actively using the object, we don't want to free
> > > it -- the partial object allocation being the clearest, if the object
> > > consists of 2 pages, trying to free page 0 in order to allocate page 1
> > > has to fail (and the shrinker should find another candidate to reclaim,
> > > or fail the allocation).
> > 
> > mmu notifiers are not for influencing policy of the mm.
> 
> It's policy is "this may fail" regardless of the mmu notifier at this
> point. That is not changed.

MMU notifiers are for tracking updates, they are not allowed to fail.
The one slightly weird case of non-blocking is the only exception.

> Your suggestion is that we move the pages to the unevictable mapping so
> that the shrinker LRU is never invoked on pages we have grabbed with
> pin_user_page. Does that work with the rest of the mmu notifiers?

That is beyond what I'm familiar with - but generally - if you want to
influence decisions the MM is making then it needs to be at the
front of the process and not inside notifiers. 

So what you describe seems broadly appropriate to me.

I'm still a little unclear on what you are trying to fix - pinned
pages are definitely not freed, do you have some case where pages
which are pinned are being cleaned out from the MM despite being
pinned? Sounds a bit strange, maybe that is worth adressing directly?

Jason
