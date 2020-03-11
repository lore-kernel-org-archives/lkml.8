Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F63C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9130F20739
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbgCKR6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:58:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:47484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730450AbgCKR6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:58:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5C5B3AFA1;
        Wed, 11 Mar 2020 17:58:02 +0000 (UTC)
Subject: Re: [PATCH] mm,page_alloc,cma: conditionally prefer cma pageblocks
 for movable allocations
To:     Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>,
        Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20200306150102.3e77354b@imladris.surriel.com>
 <20200307143849.a2fcb81a9626dad3ee46471f@linux-foundation.org>
 <2f3e2cde7b94dfdb8e1f0532d1074e07ef675bc4.camel@surriel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <5ed7f24b-d21b-75a1-ff74-49a9e21a7b39@suse.cz>
Date:   Wed, 11 Mar 2020 18:58:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2f3e2cde7b94dfdb8e1f0532d1074e07ef675bc4.camel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/20 2:23 PM, Rik van Riel wrote:
> On Sat, 2020-03-07 at 14:38 -0800, Andrew Morton wrote:
>> On Fri, 6 Mar 2020 15:01:02 -0500 Rik van Riel <riel@surriel.com>
>> wrote:
> 
>> > --- a/mm/page_alloc.c
>> > +++ b/mm/page_alloc.c
>> > @@ -2711,6 +2711,18 @@ __rmqueue(struct zone *zone, unsigned int
>> > order, int migratetype,
>> >  {
>> >  	struct page *page;
>> >  
>> > +	/*
>> > +	 * Balance movable allocations between regular and CMA areas by
>> > +	 * allocating from CMA when over half of the zone's free memory
>> > +	 * is in the CMA area.
>> > +	 */
>> > +	if (migratetype == MIGRATE_MOVABLE &&
>> > +	    zone_page_state(zone, NR_FREE_CMA_PAGES) >
>> > +	    zone_page_state(zone, NR_FREE_PAGES) / 2) {
>> > +		page = __rmqueue_cma_fallback(zone, order);
>> > +		if (page)
>> > +			return page;
>> > +	}
>> >  retry:
>> >  	page = __rmqueue_smallest(zone, order, migratetype);
>> >  	if (unlikely(!page)) {
>> 
>> __rmqueue() is a hot path (as much as any per-page operation can be a
>> hot path).  What is the impact here?
> 
> That is a good question. For MIGRATE_MOVABLE allocations,
> most allocations seem to be order 0, which go through the
> per cpu pages array, and rmqueue_pcplist, or be order 9.
> 
> For order 9 allocations, other things seem likely to dominate
> the allocation anyway, while for order 0 allocations the
> pcp list should take away the sting?

I agree it should be in the noise. But please do put it behind CONFIG_CMA
#ifdef. My x86_64 desktop distro kernel doesn't have CONFIG_CMA. Even if this is
effectively no-op with __rmqueue_cma_fallback() returning NULL immediately, I
think the compiler cannot eliminate the two zone_page_state()'s which are
atomic_long_read(), even if it's just ultimately READ_ONCE() here, that's a
volatile cast which means elimination not possible AFAIK? Other architectures
might be even more involved.

Otherwise I agree this is a reasonable solution until CMA is rewritten.

> What I do not know is how much impact this change would
> have on other allocations, like order 3 or order 4 network
> buffer allocations from irq context...
> 
> Are there cases in particular that we should be testing?
> 

