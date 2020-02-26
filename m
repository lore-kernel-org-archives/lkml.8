Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB029C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CB62467E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgBZJsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:48:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:39982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbgBZJsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:48:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8A9FFAC91;
        Wed, 26 Feb 2020 09:48:39 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 2/2] mm,thp,compaction,cma: allow THP migration for CMA
 allocations
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        mhocko@kernel.org, mgorman@techsingularity.net,
        rientjes@google.com, aarcange@redhat.com
References: <cover.1582321645.git.riel@surriel.com>
 <3289dc5e6c4c3174999598d8293adf8ed3e93b57.1582321645.git.riel@surriel.com>
 <05027092-a43e-756f-4fee-78f29a048ca1@suse.cz>
 <b3529cfa33f55d47aa2e017c8b0291395c302a02.camel@surriel.com>
Message-ID: <81c8d2fa-a8ae-82b8-f359-bba055fbff68@suse.cz>
Date:   Wed, 26 Feb 2020 10:48:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <b3529cfa33f55d47aa2e017c8b0291395c302a02.camel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 7:44 PM, Rik van Riel wrote:
>> Also PageTransHuge() is basically just a PageHead() so for each
>> non-hugetlbfs compound page this will assume it's a THP, while
>> correctly
>> it should reach the __PageMovable() || PageLRU(page) tests below.
>> 
>> So probably this should do something like.
>> 
>> if (PageHuge(page) || PageTransCompound(page)) {
>> ...
>>    if (PageHuge(page) && !hpage_migration_supported)) return page.
> 
> So far so good.
> 
>>    if (!PageLRU(head) && !__PageMovable(head)) return page
> 
> I don't get this one, though. What about a THP that has
> not made it onto the LRU list yet for some reason?

Uh, is it any different from base pages which have to pass the same check? I
guess the caller could do e.g. lru_add_drain_all() first.

> I don't think anonymous pages are marked __PageMovable,
> are they? It looks like they only have the PAGE_MAPPING_ANON
> flag set, not the PAGE_MAPPING_MOVABLE one.
> 
> What am I missing?

My point is that we should not accept compound pages that are neither a
migratable hugetlbfs page nor a THP, as movable. And your PageTransHuge() test
and my PageTransCompound() is really just a test for all compound pages, not
"hugetlbfs or THP only". I should have perhaps suggested PageCompound() instead
of the PageTransCompound() wrapper, to make it more obvious.

So we should test non-hugetlbfs pages first whether they are the kind of
compound pages that are migratable. THP's should pass this test by PageLRU(),
other compound movable pages by __PageMovable(head).

> 
>> ...
>> 
>> >  			struct page *head = compound_head(page);
>> >  			unsigned int skip_pages;
>> >  
>> > -			if
>> > (!hugepage_migration_supported(page_hstate(head)))
>> > +			if (PageHuge(page) &&
>> > +			    !hugepage_migration_supported(page_hstate(h
>> > ead)))
>> >  				return page;
>> >  
>> >  			skip_pages = compound_nr(head) - (page - head);
>> > 
>> 
>> 
> 

