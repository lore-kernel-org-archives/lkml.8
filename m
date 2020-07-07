Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091DAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC70206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgGGQeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:34:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:45550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbgGGQeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:34:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 59423B007;
        Tue,  7 Jul 2020 16:34:07 +0000 (UTC)
Subject: Re: [PATCH v4 10/11] mm/memory-failure: remove a wrapper for
 alloc_migration_target()
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-11-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7a0c02ca-5354-2508-a8a1-ff80d413af59@suse.cz>
Date:   Tue, 7 Jul 2020 17:00:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1594107889-32228-11-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 9:44 AM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> There is a well-defined standard migration target callback. Use it
> directly.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/memory-failure.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 609d42b6..3b89804 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1677,16 +1677,6 @@ int unpoison_memory(unsigned long pfn)
>  }
>  EXPORT_SYMBOL(unpoison_memory);
>  
> -static struct page *new_page(struct page *p, unsigned long private)
> -{
> -	struct migration_target_control mtc = {
> -		.nid = page_to_nid(p),
> -		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
> -	};
> -
> -	return alloc_migration_target(p, (unsigned long)&mtc);
> -}
> -
>  /*
>   * Safely get reference count of an arbitrary page.
>   * Returns 0 for a free page, -EIO for a zero refcount page
> @@ -1793,6 +1783,10 @@ static int __soft_offline_page(struct page *page)
>  	const char *msg_page[] = {"page", "hugepage"};
>  	bool huge = PageHuge(page);
>  	LIST_HEAD(pagelist);
> +	struct migration_target_control mtc = {
> +		.nid = NUMA_NO_NODE,
> +		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
> +	};
>  
>  	/*
>  	 * Check PageHWPoison again inside page lock because PageHWPoison
> @@ -1829,8 +1823,8 @@ static int __soft_offline_page(struct page *page)
>  	}
>  
>  	if (isolate_page(hpage, &pagelist)) {
> -		ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
> -					MIGRATE_SYNC, MR_MEMORY_FAILURE);
> +		ret = migrate_pages(&pagelist, alloc_migration_target, NULL,
> +			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_FAILURE);
>  		if (!ret) {
>  			bool release = !huge;
>  
> 

