Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0D6C07548
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E6520795
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="han8RrIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgIJRwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgIJRvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:51:52 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9D9C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:51:51 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id z18so3776245qvp.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z7WGp/osfapiuNJrta4mkaaasL0vGqrH3BVPB/bzeHc=;
        b=han8RrIQfCqQWH64u3lhalgdRtLuZ7WI21ODSCMTTkM4YZgkKt6uoIYTV/7NEg3tcQ
         c4HZcxinyB676euhbsSzbxgsLUyM7LtYD/QtvH3pZRVlb9XKAgx7OyScx3qDT/+G9SYD
         UrWA6lALmVQHoNfO9Y0CW0wnwkTKvVgIHDC2f3FZIcljJOEs759gt8+Vw41U77zL6oh6
         5vfO8EMIFwXowzu0HdQ93Wv8gmUTriYzvJno/lvcgEwHCKaELOhYEzlTtx9LSjyniTKY
         4k0nZKjNl2Hs7RXHNtIzHpgFY0Sg3kurAzuenHmSWNYOV5s4Pm4ZMrRg3wgezkOLdqVt
         hSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z7WGp/osfapiuNJrta4mkaaasL0vGqrH3BVPB/bzeHc=;
        b=FiJhxHz0Q60J6HhwZnULCIjYcyMNugg9Nq8C9foqXJEiQPiQjGQSF7atXpa/D6R/51
         FX9KbQyQxYGVnHDEXG6QEPMphh6E+dG0vsKXOKmxH4KY/rLXvWHpumQfH3I0aIFTjqRU
         6yKkJtS6/e1H4UlRFkEiOEIKqK7Os8WR0z94Vm8kLXA8bPJOpi9x8hIz31ViHrBqU/ZM
         4MvqwEQ84tDDKi1qWURqrF4QYTWa8ip60OHR6OHXmaHDZytjXeg2h08Cy96ikMyoZkot
         76G/1TJapILbyPavHZb3NCgqnJSTXiD9UKlsxZ71QdFaMGvX/goruitjnEBhvY4doW7k
         8q0A==
X-Gm-Message-State: AOAM5314PcK8DxYGCG37qPlDXmZ21Aoy2USBF5PTNt9bkMrp9nfjCFxT
        ckIt021Ocn4qUhPIdmOk3K+sCQ==
X-Google-Smtp-Source: ABdhPJzpK7AeLxWHOKCbaz/UO5jOLKIevTlSltTLiEFDmhFBw0vJ33y26TscyqHU/oirreQYkxMdGA==
X-Received: by 2002:a0c:f984:: with SMTP id t4mr9825178qvn.18.1599760310881;
        Thu, 10 Sep 2020 10:51:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:d901])
        by smtp.gmail.com with ESMTPSA id w128sm7202350qkb.6.2020.09.10.10.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 10:51:50 -0700 (PDT)
Date:   Thu, 10 Sep 2020 13:50:26 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        =Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: workingset: ignore slab memory size when calculating
 shadows pressure
Message-ID: <20200910175026.GA107346@cmpxchg.org>
References: <20200903230055.1245058-1-guro@fb.com>
 <20200909145534.GA100698@cmpxchg.org>
 <20200909165520.GA1163084@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909165520.GA1163084@carbon.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 09:55:20AM -0700, Roman Gushchin wrote:
> On Wed, Sep 09, 2020 at 10:55:34AM -0400, Johannes Weiner wrote:
> > On Thu, Sep 03, 2020 at 04:00:55PM -0700, Roman Gushchin wrote:
> > > In the memcg case count_shadow_nodes() sums the number of pages in lru
> > > lists and the amount of slab memory (reclaimable and non-reclaimable)
> > > as a baseline for the allowed number of shadow entries.
> > > 
> > > It seems to be a good analogy for the !memcg case, where
> > > node_present_pages() is used. However, it's not quite true, as there
> > > two problems:
> > > 
> > > 1) Due to slab reparenting introduced by commit fb2f2b0adb98 ("mm:
> > > memcg/slab: reparent memcg kmem_caches on cgroup removal") local
> > > per-lruvec slab counters might be inaccurate on non-leaf levels.
> > > It's the only place where local slab counters are used.
> > 
> > Hm, that sounds like a bug tbh. We're reparenting the kmem caches and
> > the individual objects on the list_lru when a cgroup is removed -
> > shouldn't we also reparent the corresponding memory counters?
> 
> It's definitely an option too, the question is if the added code complexity
> is really worth it. I'd say no had we talk only about slab counters,
> but when we'll eventually start reparenting pagecache, we'll need to reparent
> other counters as well, so we'll need it anyway. So, ok, let's drop
> this patch for now.
> 
> > 
> > > 2) Shadow nodes by themselves are backed by slabs. So there is a loop
> > > dependency: the more shadow entries are there, the less pressure the
> > > kernel applies to reclaim them.
> > 
> > This effect is negligible in practice.
> > 
> > The permitted shadow nodes are a tiny percentage of memory consumed by
> > the cgroup. If shadow nodes make up a significant part of the cgroup's
> > footprint, or are the only thing left, they will be pushed out fast.
> > 
> > The formula is max_nodes = total_pages >> 3, and one page can hold 28
> > nodes. So if the cgroup holds nothing but 262,144 pages (1G) of shadow
> > nodes, the shrinker target is 32,768 nodes, which is 32,768 pages
> > (128M) in the worst packing case and 1,170 pages (4M) at best.
> > 
> > However, if you don't take slab into account here, it can evict shadow
> > entries with undue aggression when they are needed the most. If, say,
> > the inode or dentry cache explode temporarily and displace the page
> > cache, it would be a big problem to drop the cache's non-resident info
> > at the same time! This is when it's at its most important.
> 
> Just curious, have you seen this in the real life?

I have seen it with anon pages back when we targeted the page cache
instead of the total memory footprint. Especially in the context of
psi it missed thrashing situations, see:

commit 95f9ab2d596e8cbb388315e78c82b9a131bf2928
Author: Johannes Weiner <jweiner@fb.com>
Date:   Fri Oct 26 15:05:59 2018 -0700

    mm: workingset: don't drop refault information prematurely

I can't remember if I saw slabs doing the same, but it's equally
plausible.
