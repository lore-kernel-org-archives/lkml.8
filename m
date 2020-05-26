Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F1EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13AE120663
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="sXcb3w0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgEZPpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgEZPpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:45:53 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DB3C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:45:53 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id fb16so9645816qvb.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H9NFd0yHlWGmdk/EMdYVrUqJ2vOLGczXKpbxrO9cBaM=;
        b=sXcb3w0eQMDKcMmANV3bqeRrIPN376XqoY+mlxj5Ut31RFJurt5tGbdEwZIq3dbD4O
         4Xc1eosEIel58VXlkkgjWLU6wV7f/ifJVJIY07JVrM+eeQDSfAJ1DRQpeBWK9MAn05CM
         f65q0wh613K5qqBw7J2PgH74PTHqbY3svEhQF6173TcXPGfhIiy6D76vMl51zT4i5OQH
         czyiNq+uFO6cGRDKUE2rCPkKOLxAxLqoLRpcQ/uA1g3ZUDLGtqUNp6RFcDu4AbU0e8fY
         KqkZS1lI+fdy90NvlaVPglUzNlxWIrthSeVPMKt9kLvjdd+hs3o1FdwqWi0WbI2I2VAE
         p/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H9NFd0yHlWGmdk/EMdYVrUqJ2vOLGczXKpbxrO9cBaM=;
        b=IWl7uamd5swqdDMs0kVlgimq50iLQtR/SHK0+xVE+FP+Zx8jIHA6ZVbgmFdG4gJpmA
         sacs4tKuTt5s1sm0cdLN45Tvx/dyomylUPTlwq061P+b6+ubBSz7cW+sThIaNdRTq144
         CwR0a3OdHl29IohabX2Q0quU2MBOoIXsD1MQuKgEqzeUQ0O9j4MPZutvdEeGTX9A1QNF
         F14zY5Gt6f4UrjEp90u+6yKsNBJfrmj96muELdGDfNiq5Lg4PB3J/hCPO0TUP++6EfTu
         Sy246QGR/2JkeX96pqaPPIyQ9QiY0ObuYqHmxG5HntgBAuFp/vjUNH3URorFLPE1UJrC
         roxA==
X-Gm-Message-State: AOAM530wD0wbwl0VlEf7D1aCaOxlQhJFvWJHWlOw4rf9wmlQSeu2jCs6
        CzE9z5RlVQgnJFBdfSGfGpQlJA==
X-Google-Smtp-Source: ABdhPJyGbmCuym3Nq9WvLw7q9NvhV/jtJ2jDr9IOuxTqLV6KU5lEVPsyp3uWaVf/cbyx7wDkA7kjDQ==
X-Received: by 2002:ad4:404b:: with SMTP id r11mr21375700qvp.44.1590507952570;
        Tue, 26 May 2020 08:45:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:8152])
        by smtp.gmail.com with ESMTPSA id a27sm23969qtc.92.2020.05.26.08.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 08:45:51 -0700 (PDT)
Date:   Tue, 26 May 2020 11:45:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mmotm] mm/swap: fix livelock in __read_swap_cache_async()
Message-ID: <20200526154528.GA850116@cmpxchg.org>
References: <alpine.LSU.2.11.2005212246080.8458@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2005212246080.8458@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 10:56:20PM -0700, Hugh Dickins wrote:
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

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> Mostly fixing mm-memcontrol-charge-swapin-pages-on-instantiation.patch
> but now I see that mm-memcontrol-delete-unused-lrucare-handling.patch
> made a further change here (took an arg off the mem_cgroup_charge call):
> as is, this patch is diffed to go on top of both of them, and better
> that I get it out now for Johannes look at; but could be rediffed for
> folding into blah-instantiation.patch later.

IMO it's worth having as a separate change. Joonsoo was concerned
about the ordering but I didn't see it. Having this sequence of
changes on record would be good for later reference.
