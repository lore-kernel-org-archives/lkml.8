Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E906C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243DE2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbgCKRlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:41:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:32856 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgCKRlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:41:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B2BD2AE6F;
        Wed, 11 Mar 2020 17:41:40 +0000 (UTC)
Subject: Re: [PATCH] mm,page_alloc,cma: conditionally prefer cma pageblocks
 for movable allocations
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>, Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20200306150102.3e77354b@imladris.surriel.com>
 <8e67d88f-3ec8-4795-35dc-47e3735e530e@suse.cz>
 <CAAmzW4P6+3O_RLvgy_QOKD4iXw+Hk3HE7Toc4Ky7kvQbCozCeA@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <89865b7b-f0ed-999d-0f23-4dbfb45115db@suse.cz>
Date:   Wed, 11 Mar 2020 18:41:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAAmzW4P6+3O_RLvgy_QOKD4iXw+Hk3HE7Toc4Ky7kvQbCozCeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/20 11:13 AM, Joonsoo Kim wrote:
>>
>> Few years ago Joonsoo wanted to fix these kinds of weird MIGRATE_CMA corner
>> cases by using ZONE_MOVABLE instead [1]. Unfortunately it was reverted due to
>> unresolved bugs. Perhaps the idea could be resurrected now?
>>
>> [1]
>> https://lore.kernel.org/linux-mm/1512114786-5085-1-git-send-email-iamjoonsoo.kim@lge.com/
> 
> Thanks for ccing, Vlastimil.

No problem. Also, welcome back :)

> Recently, I'm working for resurrecting this idea.
> I will send the preparation patches in this or next week.

Good to hear!

> Unresolved bugs of my patchset comes from the fact that ZONE_MOVABLE
> which is used for
> serving CMA memory in my patchset could have both lowmem(direct mapped) and
> highmem(no direct mapped) pages on CONFIG_HIGHMEM enabled system.
> 
> For someone to use this memory, PageHighMem() should be called to
> check if there is direct
> mapping or not. Current PageHighMem() implementation is:
> 
> #define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))
> 
> Since ZONE_MOVABLE has both typed pages, ZONE_MOVABLE should be considered
> as highmem zone. In this case, PageHighMem() always returns TRUE for
> all pages on
> ZONE_MOVABLE and lowmem pages on ZONE_MOVABLE could make some troubles.

Doh, HighMem brings only troubles these days [1].

[1] https://lwn.net/Articles/813201/

> My plan to fix this problem is to change the PageHighMem() implementation.
> 
> #define PageHighMem(__p) (page_to_pfn(__p) >= max_low_pfn)
> 
> In fact, PageHighMem() is used to check whether direct mapping exists or not.
> With this new implementation, regardless of the zone type of the page, we can
> correctly check if the page is direct mapped or not. Changing the
> name, PageHighMem(),
> to !PageDirectMapped() is also planned but it will be done after
> everything have settle down.
> 
> Unfortunately, before changing the implementation, I should check the
> all call-sites
> of PageHighMem() since there is some callers who use PageHighMem() to check
> the zone type.
> 
> What my preparation patch will does is to correct this PageHighMem() usage.
> After fixing it, I will try to merge the patchset [1].
> 
> Thanks.
> 

