Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC43C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B871120639
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="rK7l2L6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbgIIQCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730567AbgIIP5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:57:20 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6DEC061239
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 07:56:57 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id di5so1619129qvb.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 07:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bAr5DveSt2j6c3Ji2Xpkc3bdZPC9ueaRBHJ+E2ddcbI=;
        b=rK7l2L6Ba2JCzvKHKa2SJN5u2fNNGcz+xX5FS2fVzlzE39G8QwlSi/S9fdbWoWAxte
         lRCguLhNf5RYuc9lo5f3oE4Vg8A5hPxuxXsJdR2PC1c2dJzcKAd1xdT+aiqPbVFA2G+c
         NeXiQNVqrVoihFGdA17ilFkkFzBmfhBUldl7oOfmkoDbT8QG9KI/IuOhFH2SWcD6oNS/
         2g3NyQLRJuVPWj6iFMdDrGMoGxZFkRrepBFTsyENh17ExzZib5VUsUcKLuD/b/oTNTfu
         Da44+gz/P7k+oDOGzPrpBwvn8NpegUiR/09kLs5DB137Mbv5KbiO+WssE1W8pTn4BGwN
         DAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bAr5DveSt2j6c3Ji2Xpkc3bdZPC9ueaRBHJ+E2ddcbI=;
        b=GNMPzBfplch9D7F7lmyC9kXw6b9uvYCftS4qriiNViVEp1wfngZq6OEHjplHXrg2Vz
         4N5r5WuVw6we8QLuNLsVuhVeMwaIVLKOELlFa7uSz8Vh5ClYH83rwlvbCcq6I1gV2QtL
         bLFq5WFvc7PiqH1W3nTVXP+bO4LNUZMJRqdVAKIvDluTQeILaxJWJsFsw7WL4Ws/SPF3
         DLCLUhFPTlKzTJ8zbU6uG1FNkACAPE1JXB0XMdefyWyyUQy5QeUFdp7oVqhykGZ3bUSD
         quphhpHcOvzWsh3S8uIi9Ouhi6kR+/8gJQVX2/xygYoO375vIHKmKK1F2t3Zpav3poxY
         dCDw==
X-Gm-Message-State: AOAM530/2JRY2EOfCT6JTmQm1ksDRix/kKVEKQVIhTPPurXR55gZ2Vdg
        gkpyvqn0T+uJOuNNss5Ywr6VCg==
X-Google-Smtp-Source: ABdhPJyHGx6zvZoCwcK+52bMv7ajUNNqnFSrgAK1OIrd54oREZtOqFV8s0blObcX2qXQxFQT0Cl0Ew==
X-Received: by 2002:a05:6214:bce:: with SMTP id ff14mr4374172qvb.32.1599663416747;
        Wed, 09 Sep 2020 07:56:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:755a])
        by smtp.gmail.com with ESMTPSA id q35sm3172982qtd.75.2020.09.09.07.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 07:56:55 -0700 (PDT)
Date:   Wed, 9 Sep 2020 10:55:34 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        =Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: workingset: ignore slab memory size when calculating
 shadows pressure
Message-ID: <20200909145534.GA100698@cmpxchg.org>
References: <20200903230055.1245058-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903230055.1245058-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 04:00:55PM -0700, Roman Gushchin wrote:
> In the memcg case count_shadow_nodes() sums the number of pages in lru
> lists and the amount of slab memory (reclaimable and non-reclaimable)
> as a baseline for the allowed number of shadow entries.
> 
> It seems to be a good analogy for the !memcg case, where
> node_present_pages() is used. However, it's not quite true, as there
> two problems:
> 
> 1) Due to slab reparenting introduced by commit fb2f2b0adb98 ("mm:
> memcg/slab: reparent memcg kmem_caches on cgroup removal") local
> per-lruvec slab counters might be inaccurate on non-leaf levels.
> It's the only place where local slab counters are used.

Hm, that sounds like a bug tbh. We're reparenting the kmem caches and
the individual objects on the list_lru when a cgroup is removed -
shouldn't we also reparent the corresponding memory counters?

> 2) Shadow nodes by themselves are backed by slabs. So there is a loop
> dependency: the more shadow entries are there, the less pressure the
> kernel applies to reclaim them.

This effect is negligible in practice.

The permitted shadow nodes are a tiny percentage of memory consumed by
the cgroup. If shadow nodes make up a significant part of the cgroup's
footprint, or are the only thing left, they will be pushed out fast.

The formula is max_nodes = total_pages >> 3, and one page can hold 28
nodes. So if the cgroup holds nothing but 262,144 pages (1G) of shadow
nodes, the shrinker target is 32,768 nodes, which is 32,768 pages
(128M) in the worst packing case and 1,170 pages (4M) at best.

However, if you don't take slab into account here, it can evict shadow
entries with undue aggression when they are needed the most. If, say,
the inode or dentry cache explode temporarily and displace the page
cache, it would be a big problem to drop the cache's non-resident info
at the same time! This is when it's at its most important.

Let's drop this patch, please.
