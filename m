Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C17DC3F2C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DE72469B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C03lseVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgB0XmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:42:06 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35728 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbgB0XmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:42:06 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RNY5kR190957;
        Thu, 27 Feb 2020 23:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=DYHZUukh22WLTtqSbPAO9mVsplLj82QEhpMV3Fq0/EQ=;
 b=C03lseVMkSagEfmcGJy4rG9Z91a056ig0txWkcMRmzptAUEgDg2LKqF6V8baKMVqxYCA
 Tl76H1BF69xMirvr0bfea/L2a44lrhXKkwHlwtUJf643DS/FTx7zxN6pAO9oTTlg2TvB
 59HtMdziqJ5zOGTTJKdWBMa/A0yWvdfmh7DJ/lePVvBMAGOEeNhvdoBc6LlkbLy564r1
 zoJs+91tursCjPgIBKV5yqtNdYEOj/rMuZ5qWRnFp60y90an1FxFXEt3ZXmZ9zLZ/GiG
 aqSjRHeKrtN41E3aoExjURJFgJ1VMcmMSd+wkr6+ZswhYGahGkSj0baaM3lryNErLlx5 Dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ydcsnp9j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 23:41:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RNWJ9v064789;
        Thu, 27 Feb 2020 23:41:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2ydcs6n28x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 23:41:43 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01RNff2G030013;
        Thu, 27 Feb 2020 23:41:41 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Feb 2020 15:41:41 -0800
Subject: Re: [PATCH v2 2/2] mm,thp,compaction,cma: allow THP migration for CMA
 allocations
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        mhocko@kernel.org, vbabka@suse.cz, mgorman@techsingularity.net,
        rientjes@google.com, aarcange@redhat.com, ziy@nvidia.com
References: <cover.1582321646.git.riel@surriel.com>
 <20200227213238.1298752-2-riel@surriel.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <df83c62f-209f-b1fd-3a5c-c81c82cb2606@oracle.com>
Date:   Thu, 27 Feb 2020 15:41:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227213238.1298752-2-riel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 1:32 PM, Rik van Riel wrote:
> The code to implement THP migrations already exists, and the code
> for CMA to clear out a region of memory already exists.
> 
> Only a few small tweaks are needed to allow CMA to move THP memory
> when attempting an allocation from alloc_contig_range.
> 
> With these changes, migrating THPs from a CMA area works when
> allocating a 1GB hugepage from CMA memory.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/compaction.c | 22 +++++++++++++---------
>  mm/page_alloc.c |  9 +++++++--
>  2 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 672d3c78c6ab..000ade085b89 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -894,12 +894,13 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  
>  		/*
>  		 * Regardless of being on LRU, compound pages such as THP and
> -		 * hugetlbfs are not to be compacted. We can potentially save
> -		 * a lot of iterations if we skip them at once. The check is
> -		 * racy, but we can consider only valid values and the only
> -		 * danger is skipping too much.
> +		 * hugetlbfs are not to be compacted unless we are attempting
> +		 * an allocation much larger than the huge page size (eg CMA).
> +		 * We can potentially save a lot of iterations if we skip them
> +		 * at once. The check is racy, but we can consider only valid
> +		 * values and the only danger is skipping too much.
>  		 */
> -		if (PageCompound(page)) {
> +		if (PageCompound(page) && !cc->alloc_contig) {
>  			const unsigned int order = compound_order(page);
>  
>  			if (likely(order < MAX_ORDER))
> @@ -969,7 +970,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  			 * and it's on LRU. It can only be a THP so the order
>  			 * is safe to read and it's 0 for tail pages.
>  			 */
> -			if (unlikely(PageCompound(page))) {
> +			if (unlikely(PageCompound(page) && !cc->alloc_contig)) {
>  				low_pfn += compound_nr(page) - 1;
>  				goto isolate_fail;
>  			}
> @@ -981,12 +982,15 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		if (__isolate_lru_page(page, isolate_mode) != 0)
>  			goto isolate_fail;
>  
> -		VM_BUG_ON_PAGE(PageCompound(page), page);
> +		/* The whole page is taken off the LRU; skip the tail pages. */
> +		if (PageCompound(page))
> +			low_pfn += compound_nr(page) - 1;
>  
>  		/* Successfully isolated */
>  		del_page_from_lru_list(page, lruvec, page_lru(page));
> -		inc_node_page_state(page,
> -				NR_ISOLATED_ANON + page_is_file_cache(page));
> +		mod_node_page_state(page_pgdat(page),
> +				NR_ISOLATED_ANON + page_is_file_cache(page),
> +				hpage_nr_pages(page));
>  
>  isolate_success:
>  		list_add(&page->lru, &cc->migratepages);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a36736812596..6257c849cc00 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8253,14 +8253,19 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  
>  		/*
>  		 * Hugepages are not in LRU lists, but they're movable.
> +		 * THPs are on the LRU, but need to be counted as #small pages.
>  		 * We need not scan over tail pages because we don't
>  		 * handle each tail page individually in migration.
>  		 */
> -		if (PageHuge(page)) {
> +		if (PageHuge(page) || PageTransCompound(page)) {
>  			struct page *head = compound_head(page);
>  			unsigned int skip_pages;
>  
> -			if (!hugepage_migration_supported(page_hstate(head)))
> +			if (PageHuge(page) &&
> +			    !hugepage_migration_supported(page_hstate(head)))
> +				return page;
> +
> +			if (!PageLRU(head) && !__PageMovable(head))

Pretty sure this is going to be true for hugetlb pages.  So, this will change
behavior and make all hugetlb pages look unmovable.  Perhaps, only check this
condition for THP pages?
-- 
Mike Kravetz

>  				return page;
>  
>  			skip_pages = compound_nr(head) - (page - head);
> 
