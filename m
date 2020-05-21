Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B97C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC1E920814
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EkWgRr4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbgEUWTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 18:19:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55674 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgEUWTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 18:19:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04LMHl9m093571;
        Thu, 21 May 2020 22:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=LgKeuMNV4bDqsxFgNkRXMQ5GMVXC66/4hmZzhGDwwXk=;
 b=EkWgRr4jJYv78YohHPacSZUz/xZbBbKvVtUNGqoWC0xq8G6OtifuzOdsi5+BVtkJt7wv
 inAHCFpXMgmb9jbeLOAtqN7gm9Ct8A2fgVIs/qYRF0Ldbbe/tiY47GxQFzPEaYCuxEri
 80Jx+RsIyo2MqPq/PEYxXwDUK7jz2pb3duV8rpfrymJ5Ma4GaAkMKT6f4wM/TcR3uqhe
 ABCkCWfY2RWqfOIDNSvYSOknmsWvm0Ar35hqP0AFyq9EZCVRKuDNWLJJ0fxC4o8xroBh
 wI+zmwYF+rOggaJ3K6lXaaZ0DjXCZJzoXPQ655+EU6TStx+dX0V77WMvMd39LudGMy+b tQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3127krk0n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 22:19:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04LMJFsb115760;
        Thu, 21 May 2020 22:19:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3150237a5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 May 2020 22:19:26 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04LMJL51018241;
        Thu, 21 May 2020 22:19:22 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 May 2020 15:19:20 -0700
Subject: Re: [PATCH 06/11] mm/hugetlb: do not modify user provided gfp_mask
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1589764857-6800-7-git-send-email-iamjoonsoo.kim@lge.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <027b9f05-4a24-e69c-eafa-dbf7cca3ac4e@oracle.com>
Date:   Thu, 21 May 2020 15:19:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589764857-6800-7-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=2 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005210166
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=2 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005210166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/20 6:20 PM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> It's not good practice to modify user input. Instead of using it to
> build correct gfp_mask for APIs, this patch introduces another gfp_mask
> field, __gfp_mask, for internal usage.

Modifying the flags as is done in the existing code does not bother me
too much, but that is just my opinion.  Adding __gfp_mask for modifications
is fine with me if others think it is a good thing.

Does dequeue_huge_page_vma() need to be modified so that it will set
ac.__gfp_mask before calling dequeue_huge_page_nodemask()?
-- 
Mike Kravetz

> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  mm/hugetlb.c  | 15 ++++++++-------
>  mm/internal.h |  2 ++
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 53edd02..5f43b7e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1069,15 +1069,15 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h,
>  	struct zoneref *z;
>  	int node = NUMA_NO_NODE;
>  
> -	zonelist = node_zonelist(ac->nid, ac->gfp_mask);
> +	zonelist = node_zonelist(ac->nid, ac->__gfp_mask);
>  
>  retry_cpuset:
>  	cpuset_mems_cookie = read_mems_allowed_begin();
>  	for_each_zone_zonelist_nodemask(zone, z, zonelist,
> -			gfp_zone(ac->gfp_mask), ac->nmask) {
> +			gfp_zone(ac->__gfp_mask), ac->nmask) {
>  		struct page *page;
>  
> -		if (!cpuset_zone_allowed(zone, ac->gfp_mask))
> +		if (!cpuset_zone_allowed(zone, ac->__gfp_mask))
>  			continue;
>  		/*
>  		 * no need to ask again on the same node. Pool is node rather than
> @@ -1952,7 +1952,7 @@ static struct page *alloc_migrate_huge_page(struct hstate *h,
>  	if (hstate_is_gigantic(h))
>  		return NULL;
>  
> -	page = alloc_fresh_huge_page(h, ac->gfp_mask,
> +	page = alloc_fresh_huge_page(h, ac->__gfp_mask,
>  				ac->nid, ac->nmask, NULL);
>  	if (!page)
>  		return NULL;
> @@ -1990,9 +1990,10 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
>  struct page *alloc_huge_page_nodemask(struct hstate *h,
>  				struct alloc_control *ac)
>  {
> -	ac->gfp_mask |= htlb_alloc_mask(h);
> +	ac->__gfp_mask = htlb_alloc_mask(h);
> +	ac->__gfp_mask |= ac->gfp_mask;
>  	if (ac->thisnode && ac->nid != NUMA_NO_NODE)
> -		ac->gfp_mask |= __GFP_THISNODE;
> +		ac->__gfp_mask |= __GFP_THISNODE;
>  
>  	spin_lock(&hugetlb_lock);
>  	if (h->free_huge_pages - h->resv_huge_pages > 0) {
> @@ -2011,7 +2012,7 @@ struct page *alloc_huge_page_nodemask(struct hstate *h,
>  	 * will not come from CMA area
>  	 */
>  	if (ac->skip_cma)
> -		ac->gfp_mask &= ~__GFP_MOVABLE;
> +		ac->__gfp_mask &= ~__GFP_MOVABLE;
>  
>  	return alloc_migrate_huge_page(h, ac);
>  }
> diff --git a/mm/internal.h b/mm/internal.h
> index 6b6507e..3239d71 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -620,6 +620,8 @@ struct alloc_control {
>  	gfp_t gfp_mask;
>  	bool thisnode;
>  	bool skip_cma;
> +
> +	gfp_t __gfp_mask;	/* Used internally in API implementation */
>  };
>  
>  #endif	/* __MM_INTERNAL_H */
> 
