Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449FBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 176D020835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/yZXiAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgE0Vog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 17:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0Vof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 17:44:35 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDA4C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 14:44:35 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id v128so23121293oia.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 14:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=TFobVTEGsYU5ols9mN4BO6yuwl1VcOjdMiy1Mzv6JMs=;
        b=S/yZXiAEqv4YGcUAM8LIhrZsHZpM5QVrHMEl6m7QK/R9ugt5Zx2Yu/a9IZzRHrkcDM
         vOzcykdl7A6s0MoRjjoZD9q5Z0HIzV9dJVdY9vfLvg3hj0sqK4cTf6B/YdpNb1wg4gsF
         QTmm61L43pfSuUsI8/Oam2IHLEQ0GNWoBRW2jsqkePZJWEj2ETA07kCu3CozSGsLByqi
         8Q4qSGOomu7eYrYDsDh8kUHmZO1lUE1sRuER6bII6RnBrZUd23EY2iDURuTpfv7mnGTw
         rXcvbI+37bfWsLa0khW2lLcq6uHaWhuZ6pXUq3kPi/I77NQlqE1bDJSyyIAeRREXuNie
         UODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=TFobVTEGsYU5ols9mN4BO6yuwl1VcOjdMiy1Mzv6JMs=;
        b=EGvWLFoPTHPI0TUqVBo18LmMRgGJR1Oqd8CD42pjXFWEuWmaoFtC3ZkJS+x3vH4PJP
         eHPVO+3+bac5T/Py8e8nj3qC9SJeEckz+FbftyNAB9Hk23ldcvrVWVBV416QqBzhJDUX
         nY5Ud6+dxPX7qkWhK0Yjy6elzf4pHY7/P3mHyVJ7PWP/VaSlewr3DwB4QRkZOnZfx7Gc
         GZxwxMbKrq3KgJ3iaPZa/yFFb+XiE08EAPUmfpmz1j6fXKi7h3YH7w0DhtRLN2um6pfB
         fdhkFPJ278tZ4VyQZEZYU7YPcn31UHOyNn2d92AHEJTADh2X77VtSlh2YfKg9CVyFCBH
         kLqQ==
X-Gm-Message-State: AOAM532aw7+EP4we/DxTjDDFy2K4XzFTFesLyp3pmc8HLsY5HDP5Ctth
        CxbeZDdYUrtMyP9ckYSc1R2n0w==
X-Google-Smtp-Source: ABdhPJyjquagyh+2n6dKqIeSG8YAeGkOR/hXxDH/0NJUGTIje/gktyivIlOz9agJnBsxdyhpJxrE8w==
X-Received: by 2002:aca:e104:: with SMTP id y4mr177936oig.120.1590615873755;
        Wed, 27 May 2020 14:44:33 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c12sm1216280oib.22.2020.05.27.14.44.32
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 27 May 2020 14:44:32 -0700 (PDT)
Date:   Wed, 27 May 2020 14:44:31 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mmotm] mm/swap: fix livelock in
 __read_swap_cache_async()
In-Reply-To: <20200526154528.GA850116@cmpxchg.org>
Message-ID: <alpine.LSU.2.11.2005271428560.6459@eggly.anvils>
References: <alpine.LSU.2.11.2005212246080.8458@eggly.anvils> <20200526154528.GA850116@cmpxchg.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 May 2020, Johannes Weiner wrote:
> On Thu, May 21, 2020 at 10:56:20PM -0700, Hugh Dickins wrote:
> > I've only seen this livelock on one machine (repeatably, but not to
> > order), and not fully analyzed it - two processes seen looping around
> > getting -EEXIST from swapcache_prepare(), I guess a third (at lower
> > priority? but wanting the same cpu as one of the loopers? preemption
> > or cond_resched() not enough to let it back in?) set SWAP_HAS_CACHE,
> > then went off into direct reclaim, scheduled away, and somehow could
> > not get back to add the page to swap cache and let them all complete.
> > 
> > Restore the page allocation in __read_swap_cache_async() to before
> > the swapcache_prepare() call: "mm: memcontrol: charge swapin pages
> > on instantiation" moved it outside the loop, which indeed looks much
> > nicer, but exposed this weakness.  We used to allocate new_page once
> > and then keep it across all iterations of the loop: but I think that
> > just optimizes for a rare case, and complicates the flow, so go with
> > the new simpler structure, with allocate+free each time around (which
> > is more considerate use of the memory too).
> > 
> > Fix the comment on the looping case, which has long been inaccurate:
> > it's not a racing get_swap_page() that's the problem here.
> > 
> > Fix the add_to_swap_cache() and mem_cgroup_charge() error recovery:
> > not swap_free(), but put_swap_page() to undo SWAP_HAS_CACHE, as was
> > done before; but delete_from_swap_cache() already includes it.
> > 
> > And one more nit: I don't think it makes any difference in practice,
> > but remove the "& GFP_KERNEL" mask from the mem_cgroup_charge() call:
> > add_to_swap_cache() needs that, to convert gfp_mask from user and page
> > cache allocation (e.g. highmem) to radix node allocation (lowmem), but
> > we don't need or usually apply that mask when charging mem_cgroup.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> > Mostly fixing mm-memcontrol-charge-swapin-pages-on-instantiation.patch
> > but now I see that mm-memcontrol-delete-unused-lrucare-handling.patch
> > made a further change here (took an arg off the mem_cgroup_charge call):
> > as is, this patch is diffed to go on top of both of them, and better
> > that I get it out now for Johannes look at; but could be rediffed for
> > folding into blah-instantiation.patch later.
> 
> IMO it's worth having as a separate change. Joonsoo was concerned
> about the ordering but I didn't see it. Having this sequence of
> changes on record would be good for later reference.

Yes, there would be some value in that: whichever way Andrew prefers.

Now that the Acks are safely in (thanks guys), I will concede that
that SWAP_HAS_CACHE occasional busywait loop is not ideal - but with
this patch, no worse than it was before.

Later on I hope to come back and do something better there: it's not
immediately clear why swapcache_prepare() is important, and it would
be nicer if add_to_swap_cache() were the thing to fail with -EEXIST
(because then there's a page in the cache that others can lock to
wait on if required); but there's memories I need to dredge up
before going that way, and it may turn out to be a delusion.

Hugh
