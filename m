Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E75C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5AA520760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zv9TefdE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgGATpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgGATpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:45:20 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA73DC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 12:45:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k5so1885233pjg.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 12:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=MmYcz0HvWzSHDRJWGpLrqkNktn4/JnvsoNfPiLm5KlQ=;
        b=Zv9TefdEvjl7gyFCZ5lVCVicTgJt1CjvgutyIOpBITiOFrSh6wxtGnedgQ09N0dmor
         pS7qMg+F/+kJrWhLAlfgi7xmRqLBVK2TeE1tJwOC4ppPtuJSyJGfJ8T/CVcpv5AZYVul
         SRuSYxrQgCjxe7Ye2OYgFdFsytY/MGoGO5XlsAPkSUtU4kzEIyLF7fz0u6VvQNojqA4b
         8mBosRczpOzC7kixcI/LataPeCsZfBXYo70+i6WKTgBmUCQ1dmBMuFVJoJbxzm2siFMq
         y2bJrZH9P5MZgylpWyX4emAefMgXEDU1GSQbqIrL+2+KE4bJp5ivRUC+r+UL7JjO8AkT
         rSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=MmYcz0HvWzSHDRJWGpLrqkNktn4/JnvsoNfPiLm5KlQ=;
        b=B/SaSKkIIjtLItc15gf/Xf+BjIsPST9kmAexgArqiVc6wbOGkSyPNzuhYOlS6T9EOc
         Uvcy9S5kSxed84kaF1GhGdd9s4ns5G50PCXSfB0HbMfsTe5uypElPrk8igKQwLQP9oad
         ON+0+uvFb6uC8R7nMYKxbs9vPQwiZMr3OgwESWaf7h2t7LvURaBHz1uJ5gBbYFxz/UQ7
         CbvBF9QsNKuSTZXKhc7ljKhHO6uoIZqJJOa9UVstjsPc00tDtAbyWHKV9jCllhOM2DIY
         euIodzAdYg2191EWqVW/jv+vGuItgsUVCRuMVRKkGtYvbojuYRhyIJgWI5us3ZLGeh2E
         GrQQ==
X-Gm-Message-State: AOAM533u/DPhJJynk2bH+K4F82KBqJZleL/JGZSRNwao/33m52bzE4nn
        vDYZaU3OrM3CsaxPWvgMcpIbsw==
X-Google-Smtp-Source: ABdhPJzaiU4A5yAHnkdIdNyPO//R2fZVeUF9j+XbG7glANtj0xNS71ARFDddH7qLf/8qAr6uIClZJQ==
X-Received: by 2002:a17:90a:246:: with SMTP id t6mr29763294pje.230.1593632719108;
        Wed, 01 Jul 2020 12:45:19 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id u20sm6422921pfm.152.2020.07.01.12.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 12:45:18 -0700 (PDT)
Date:   Wed, 1 Jul 2020 12:45:17 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kbusch@kernel.org, ying.huang@intel.com, dan.j.williams@intel.com
Subject: Re: [RFC][PATCH 3/8] mm/vmscan: Attempt to migrate page in lieu of
 discard
In-Reply-To: <33028a57-24fd-e618-7d89-5f35a35a6314@linux.alibaba.com>
Message-ID: <alpine.DEB.2.23.453.2007011226240.1908531@chino.kir.corp.google.com>
References: <20200629234503.749E5340@viggo.jf.intel.com> <20200629234509.8F89C4EF@viggo.jf.intel.com> <alpine.DEB.2.22.394.2006301732010.1644114@chino.kir.corp.google.com> <039a5704-4468-f662-d660-668071842ca3@linux.alibaba.com>
 <alpine.DEB.2.22.394.2006302208460.1685201@chino.kir.corp.google.com> <33028a57-24fd-e618-7d89-5f35a35a6314@linux.alibaba.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020, Yang Shi wrote:

> > We can do this if we consider pmem not to be a separate memory tier from
> > the system perspective, however, but rather the socket perspective.  In
> > other words, a node can only demote to a series of exclusive pmem ranges
> > and promote to the same series of ranges in reverse order.  So DRAM node 0
> > can only demote to PMEM node 2 while DRAM node 1 can only demote to PMEM
> > node 3 -- a pmem range cannot be demoted to, or promoted from, more than
> > one DRAM node.
> > 
> > This naturally takes care of mbind() and cpuset.mems if we consider pmem
> > just to be slower volatile memory and we don't need to deal with the
> > latency concerns of cross socket migration.  A user page will never be
> > demoted to a pmem range across the socket and will never be promoted to a
> > different DRAM node that it doesn't have access to.
> 
> But I don't see too much benefit to limit the migration target to the
> so-called *paired* pmem node. IMHO it is fine to migrate to a remote (on a
> different socket) pmem node since even the cross socket access should be much
> faster then refault or swap from disk.
> 

Hi Yang,

Right, but any eventual promotion path would allow this to subvert the 
user mempolicy or cpuset.mems if the demoted memory is eventually promoted 
to a DRAM node on its socket.  We've discussed not having the ability to 
map from the demoted page to either of these contexts and it becomes more 
difficult for shared memory.  We have page_to_nid() and page_zone() so we 
can always find the appropriate demotion or promotion node for a given 
page if there is a 1:1 relationship.

Do we lose anything with the strict 1:1 relationship between DRAM and PMEM 
nodes?  It seems much simpler in terms of implementation and is more 
intuitive.

> I think using pmem as a node is more natural than zone and less intrusive
> since we can just reuse all the numa APIs. If we treat pmem as a new zone I
> think the implementation may be more intrusive and complicated (i.e. need a
> new gfp flag) and user can't control the memory placement.
> 

This is an important decision to make, I'm not sure that we actually 
*want* all of these NUMA APIs :)  If my memory is demoted, I can simply do 
migrate_pages() back to DRAM and cause other memory to be demoted in its 
place.  Things like MPOL_INTERLEAVE over nodes {0,1,2} don't make sense.  
Kswapd for a DRAM node putting pressure on a PMEM node for demotion that 
then puts the kswapd for the PMEM node under pressure to reclaim it serves 
*only* to spend unnecessary cpu cycles.

Users could control the memory placement through a new mempolicy flag, 
which I think are needed anyway for explicit allocation policies for PMEM 
nodes.  Consider if PMEM is a zone so that it has the natural 1:1 
relationship with DRAM, now your system only has nodes {0,1} as today, no 
new NUMA topology to consider, and a mempolicy flag MPOL_F_TOPTIER that 
specifies memory must be allocated from ZONE_MOVABLE or ZONE_NORMAL (and I 
can then mlock() if I want to disable demotion on memory pressure).
