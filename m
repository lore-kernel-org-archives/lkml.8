Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772F6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A2F20853
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+YIXUya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgGATZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgGATZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:25:11 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC11C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 12:25:11 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 207so11228640pfu.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 12:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=sBsUXVNlnuQSVvIzRU1R9guTj/lYh/qxcsRbYVmHtpo=;
        b=J+YIXUyax0RYTHIbZKa4cWlTKXbWa5VU3LAw34i1eIv+ejZAPAv8VZn3v1wQxF/07N
         tQu+gDpVprCEqnjUwlhy5w9wBA+8AeDnu2o/5yLhAQIU6ol+xtZZTv1QD0uELxgxn3+z
         FatOseSEPAlPnKoigbwvfpACYhT2fmWY2NoCH3X+QRImw50FPMgFe5jg3dNnwv4P6LDV
         0lkCDVFk8eoqs/tmt3Zad8ghvFKKi33+6aKk6kqgZerzM/IoHYHypaWClFMJnynhL27A
         zOMIpAfNDkeK87gF/84Oxn5W1cUvuflxU9+viGMpag7BXzZt+8BUK1xrRk2/mEhfcimf
         mf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=sBsUXVNlnuQSVvIzRU1R9guTj/lYh/qxcsRbYVmHtpo=;
        b=buUQTx+hWx+PQ99FiHNwgAFSwQqKUNg32pnlqKvyEbjhVEb0auh7MglVOzmMc2h4KD
         9a42rd26qyDDht9yMShqPoWPurscj/Q6QIGPVvSmsZWA1UCeXtpD9c8C4lMA7FwrIVvZ
         RunIMGqTJXLVJ2ZISP6SQ0mbv3eNyMVFEHOq5NKgdwIswP0MsuOMSHTJqGbNvtvPVvvh
         ZEjOo6teMK5XtMWfU+vq/AGp1wYvTuq89VQgSMvuyG3KWWz0n4BXqlj/wpT3bjrQ7Bt9
         RGHte2QqGGSUETy5iM43Lp0az9zxugzD/hT5TqdRAz+auZoi4YpucM6PcjVE9t8C90QY
         UyOQ==
X-Gm-Message-State: AOAM531aNl8I9M4IyoqM/KLnawC+Svk/QhMaFyNXci6u/HcZaW+l9V+q
        0m5jxGgeZkaKVrXHavPzpjBOqA==
X-Google-Smtp-Source: ABdhPJyGxbCQkrju0gfdcbhYhDulZvMGIkoGO9+77qCi0+Grm0m8vysrkBTQPY8oAmOqTtTZ2wlPqA==
X-Received: by 2002:a63:201f:: with SMTP id g31mr20700099pgg.186.1593631510368;
        Wed, 01 Jul 2020 12:25:10 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id j36sm6782407pgj.39.2020.07.01.12.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 12:25:09 -0700 (PDT)
Date:   Wed, 1 Jul 2020 12:25:08 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Dave Hansen <dave.hansen@intel.com>
cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kbusch@kernel.org, yang.shi@linux.alibaba.com,
        ying.huang@intel.com, dan.j.williams@intel.com
Subject: Re: [RFC][PATCH 3/8] mm/vmscan: Attempt to migrate page in lieu of
 discard
In-Reply-To: <c06b4453-c533-a9ba-939a-8877fb301ad6@intel.com>
Message-ID: <alpine.DEB.2.23.453.2007011203500.1908531@chino.kir.corp.google.com>
References: <20200629234503.749E5340@viggo.jf.intel.com> <20200629234509.8F89C4EF@viggo.jf.intel.com> <alpine.DEB.2.22.394.2006301732010.1644114@chino.kir.corp.google.com> <c06b4453-c533-a9ba-939a-8877fb301ad6@intel.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020, Dave Hansen wrote:

> > Could this cause us to break a user's mbind() or allow a user to 
> > circumvent their cpuset.mems?
> 
> In its current form, yes.
> 
> My current rationale for this is that while it's not as deferential as
> it can be to the user/kernel ABI contract, it's good *overall* behavior.
>  The auto-migration only kicks in when the data is about to go away.  So
> while the user's data might be slower than they like, it is *WAY* faster
> than they deserve because it should be off on the disk.
> 

It's outside the scope of this patchset, but eventually there will be a 
promotion path that I think requires a strict 1:1 relationship between 
DRAM and PMEM nodes because otherwise mbind(), set_mempolicy(), and 
cpuset.mems become ineffective for nodes facing memory pressure.

For the purposes of this patchset, agreed that DRAM -> PMEM -> swap makes 
perfect sense.  Theoretically, I think you could have DRAM N0 and N1 and 
then a single PMEM N2 and this N2 can be the terminal node for both N0 and 
N1.  On promotion, I think we need to rely on something stronger than 
autonuma to decide which DRAM node to promote to: specifically any user 
policy put into effect (memory tiering or autonuma shouldn't be allowed to 
subvert these user policies).

As others have mentioned, we lose the allocation or process context at the 
time of demotion or promotion and any workaround for that requires some 
hacks, such as mapping the page to cpuset (what is the right solution for 
shared pages?) or adding NUMA locality handling to memcg.

I think a 1:1 relationship between DRAM and PMEM nodes is required if we 
consider the eventual promotion of this memory so that user memory can't 
eventually reappear on a DRAM node that is not allowed by mbind(), 
set_mempolicy(), or cpuset.mems.  I think it also makes this patchset much 
simpler.

> > Because we don't have a mapping of the page back to its allocation 
> > context (or the process context in which it was allocated), it seems like 
> > both are possible.
> > 
> > So let's assume that migration nodes cannot be other DRAM nodes.  
> > Otherwise, memory pressure could be intentionally or unintentionally 
> > induced to migrate these pages to another node.  Do we have such a 
> > restriction on migration nodes?
> 
> There's nothing explicit.  On a normal, balanced system where there's a
> 1:1:1 relationship between CPU sockets, DRAM nodes and PMEM nodes, it's
> implicit since the migration path is one deep and goes from DRAM->PMEM.
> 
> If there were some oddball system where there was a memory only DRAM
> node, it might very well end up being a migration target.
> 

Shouldn't DRAM->DRAM demotion be banned?  It's all DRAM and within the 
control of mempolicies and cpusets today, so I had assumed this is outside 
the scope of memory tiering support.  I had assumed that memory tiering 
support was all about separate tiers :)

> >> +static struct page *alloc_demote_node_page(struct page *page, unsigned long node)
> >> +{
> >> +	/*
> >> +	 * 'mask' targets allocation only to the desired node in the
> >> +	 * migration path, and fails fast if the allocation can not be
> >> +	 * immediately satisfied.  Reclaim is already active and heroic
> >> +	 * allocation efforts are unwanted.
> >> +	 */
> >> +	gfp_t mask = GFP_NOWAIT | __GFP_NOWARN | __GFP_NORETRY |
> >> +			__GFP_NOMEMALLOC | __GFP_THISNODE | __GFP_HIGHMEM |
> >> +			__GFP_MOVABLE;
> > 
> > GFP_NOWAIT has the side-effect that it does __GFP_KSWAPD_RECLAIM: do we 
> > actually want to kick kswapd on the pmem node?
> 
> In my mental model, cold data flows from:
> 
> 	DRAM -> PMEM -> swap
> 
> Kicking kswapd here ensures that while we're doing DRAM->PMEM migrations
> for kinda cold data, kswapd can be working on doing the PMEM->swap part
> on really cold data.
> 

Makes sense.
