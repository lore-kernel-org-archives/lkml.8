Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC8AC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0B72074F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbgCKXEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 19:04:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:40902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729739AbgCKXEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 19:04:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 67014AC61;
        Wed, 11 Mar 2020 23:04:02 +0000 (UTC)
Subject: Re: [PATCH] mm,page_alloc,cma: conditionally prefer cma pageblocks
 for movable allocations
To:     Roman Gushchin <guro@fb.com>
Cc:     Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20200306150102.3e77354b@imladris.surriel.com>
 <20200307143849.a2fcb81a9626dad3ee46471f@linux-foundation.org>
 <2f3e2cde7b94dfdb8e1f0532d1074e07ef675bc4.camel@surriel.com>
 <5ed7f24b-d21b-75a1-ff74-49a9e21a7b39@suse.cz>
 <20200311225832.GA178154@carbon.DHCP.thefacebook.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <55f366be-ed3e-7b57-0fae-54845574d98a@suse.cz>
Date:   Thu, 12 Mar 2020 00:03:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311225832.GA178154@carbon.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/20 11:58 PM, Roman Gushchin wrote:
>> 
>> I agree it should be in the noise. But please do put it behind CONFIG_CMA
>> #ifdef. My x86_64 desktop distro kernel doesn't have CONFIG_CMA. Even if this is
>> effectively no-op with __rmqueue_cma_fallback() returning NULL immediately, I
>> think the compiler cannot eliminate the two zone_page_state()'s which are
>> atomic_long_read(), even if it's just ultimately READ_ONCE() here, that's a
>> volatile cast which means elimination not possible AFAIK? Other architectures
>> might be even more involved.
> 
> I agree.
> 
> Andrew,
> can you, please, squash the following diff into the patch?

Thanks,

then please add to the result

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> Thank you!
> 
> --
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7d9067b75dcb..bc65931b3901 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2767,6 +2767,7 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
>  {
>         struct page *page;
>  
> +#ifdef CONFIG_CMA
>         /*
>          * Balance movable allocations between regular and CMA areas by
>          * allocating from CMA when over half of the zone's free memory
> @@ -2779,6 +2780,7 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
>                 if (page)
>                         return page;
>         }
> +#endif
>  retry:
>         page = __rmqueue_smallest(zone, order, migratetype);
>         if (unlikely(!page)) {
> 
> 

