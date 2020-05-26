Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29DFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F3320776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgEZOzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 10:55:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:44142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbgEZOzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 10:55:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2E30FAD5C;
        Tue, 26 May 2020 14:55:10 +0000 (UTC)
Subject: Re: [PATCH v3 17/19] mm: memcg/slab: use a single set of kmem_caches
 for all allocations
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-18-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8932b0f9-0d25-7298-c12c-b4ae455ef110@suse.cz>
Date:   Tue, 26 May 2020 16:55:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200422204708.2176080-18-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 10:47 PM, Roman Gushchin wrote:
> Instead of having two sets of kmem_caches: one for system-wide and
> non-accounted allocations and the second one shared by all accounted
> allocations, we can use just one.
> 
> The idea is simple: space for obj_cgroup metadata can be allocated
> on demand and filled only for accounted allocations.
> 
> It allows to remove a bunch of code which is required to handle
> kmem_cache clones for accounted allocations. There is no more need
> to create them, accumulate statistics, propagate attributes, etc.
> It's a quite significant simplification.
> 
> Also, because the total number of slab_caches is reduced almost twice
> (not all kmem_caches have a memcg clone), some additional memory
> savings are expected. On my devvm it additionally saves about 3.5%
> of slab memory.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

However, as this series will affect slab fastpaths, and perhaps especially this
patch will affect even non-kmemcg allocations being freed, I'm CCing Jesper and
Mel for awareness as they AFAIK did work on network stack memory management
performance, and perhaps some benchmarks are in order...

