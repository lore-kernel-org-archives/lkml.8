Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDD6C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B2824954
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YwGS5t8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgEAMa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 08:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726131AbgEAMa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 08:30:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0137BC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 05:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bdc8uifcR0c4hvJPP9O5By2zoNylxi5bzmzOSpanTI4=; b=YwGS5t8JdPB3Z3qA64W7pxhZ2z
        KUMDXSQhqrWD77KlR5FTR+NKpB+Sy9UQzH7a+2U8sWMelF3Vad2N+z05pUPlurXarTPvrBigGWb2v
        Adpq+7KF5ZIdkm5RO18yh6pRdIwOnCyeUr5fn2iMTbR4nQ70idjirtRW7CiJYBcciVOJR+bmQGPSn
        QmLcXHCTxXPyOIIiMkRUUHt/FiQ/pILWZ3w+lnLODfvfaEi5+GKJLbunbH2FjbIHCSf9/BS5nPOUo
        3qTDIhRCxjz1pQqyXq01z9cbYm/6I4ZMGwyselbAzVANZCiby04sKTWs5SR87sM7yBcbE4tKvaW5r
        /bhztg+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUUoe-0006lN-JD; Fri, 01 May 2020 12:30:52 +0000
Date:   Fri, 1 May 2020 05:30:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 07/10] mm: separate PageHighMem() and
 PageHighMemZone() use case
Message-ID: <20200501123052.GD21897@infradead.org>
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1588130803-20527-8-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588130803-20527-8-git-send-email-iamjoonsoo.kim@lge.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 12:26:40PM +0900, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Until now, PageHighMem() is used for two different cases. One is to check
> if there is a direct mapping for this page or not. The other is to check
> the zone of this page, that is, weather it is the highmem type zone or not.
> 
> Now, we have separate functions, PageHighMem() and PageHighMemZone() for
> each cases. Use appropriate one.
> 
> Note that there are some rules to determine the proper macro.
> 
> 1. If PageHighMem() is called for checking if the direct mapping exists
> or not, use PageHighMem().
> 2. If PageHighMem() is used to predict the previous gfp_flags for
> this page, use PageHighMemZone(). The zone of the page is related to
> the gfp_flags.
> 3. If purpose of calling PageHighMem() is to count highmem page and
> to interact with the system by using this count, use PageHighMemZone().
> This counter is usually used to calculate the available memory for an
> kernel allocation and pages on the highmem zone cannot be available
> for an kernel allocation.
> 4. Otherwise, use PageHighMemZone(). It's safe since it's implementation
> is just copy of the previous PageHighMem() implementation and won't
> be changed.
> 
> I apply the rule #3 for this patch.
> 
> Acked-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  mm/memory_hotplug.c | 2 +-
>  mm/page_alloc.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 555137b..891c214 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -593,7 +593,7 @@ void generic_online_page(struct page *page, unsigned int order)
>  	__free_pages_core(page, order);
>  	totalram_pages_add(1UL << order);
>  #ifdef CONFIG_HIGHMEM
> -	if (PageHighMem(page))
> +	if (PageHighMemZone(page))
>  		totalhigh_pages_add(1UL << order);
>  #endif
>  }
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fc5919e..7fe5115 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7444,7 +7444,7 @@ void adjust_managed_page_count(struct page *page, long count)
>  	atomic_long_add(count, &page_zone(page)->managed_pages);
>  	totalram_pages_add(count);
>  #ifdef CONFIG_HIGHMEM
> -	if (PageHighMem(page))
> +	if (PageHighMemZone(page))
>  		totalhigh_pages_add(count);
>  #endif

This function already uses the page_zone structure above, I think
life would be easier of you compare against that, as that makes
the code more obvious. 
