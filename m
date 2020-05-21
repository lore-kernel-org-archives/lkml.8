Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310D8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 045A520823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0OXIa58K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgEUUyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:54:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53734 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbgEUUyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:54:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04LKpuwA133900;
        Thu, 21 May 2020 20:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=an+w1SbEEhDSs+geyhOROUbZ+KHfah9r1kvDCswuExA=;
 b=0OXIa58Kzdv7PQQn+s5Kk1fLzhwD8q2xexU/6qHseHbiynJIuGEUWemHitcahNNOISJx
 d26mMahZCuhCUutSj330IGruCqsVXC6VmuAos9ZSXmMXuFWrbB8bqr9DGRxxf7p1qgJa
 H2WOQYUNH8SRINMCZzo4gilHzC+TYNgM61cVY7IGYQc+nAXaQLrMYfl1JC7YWOPBN5Uo
 L6Fcmgz37+bt1VHfI6XnLqruHBw/SBu2CeFjSvlic7sahXYCQ4NmywQpc83KvQVuvWBY
 cIqlpOiWp4n8imNGDlGimGmYCmNAAaF5tct2Xs/A/j3FmtxdnP/KZ74m51lMFXS3Hy7N QQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31284mapv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 20:54:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04LKqXUH063337;
        Thu, 21 May 2020 20:54:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 314gm9x2ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 May 2020 20:54:25 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04LKsNu0032195;
        Thu, 21 May 2020 20:54:24 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 May 2020 13:54:22 -0700
Subject: Re: [PATCH 04/11] mm/hugetlb: unify hugetlb migration callback
 function
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1589764857-6800-5-git-send-email-iamjoonsoo.kim@lge.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <01cdaaea-892a-2b29-edbd-279611f418b0@oracle.com>
Date:   Thu, 21 May 2020 13:54:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589764857-6800-5-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=2
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005210155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005210155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/20 6:20 PM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> There is no difference between two migration callback functions,
> alloc_huge_page_node() and alloc_huge_page_nodemask(), except
> __GFP_THISNODE handling. This patch adds one more field on to
> the alloc_control and handles this exception.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  include/linux/hugetlb.h |  8 --------
>  mm/hugetlb.c            | 23 ++---------------------
>  mm/internal.h           |  1 +
>  mm/mempolicy.c          |  3 ++-
>  4 files changed, 5 insertions(+), 30 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 6da217e..4892ed3 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -505,8 +505,6 @@ struct huge_bootmem_page {
>  
>  struct page *alloc_migrate_huge_page(struct hstate *h,
>  				struct alloc_control *ac);
> -struct page *alloc_huge_page_node(struct hstate *h,
> -				struct alloc_control *ac);
>  struct page *alloc_huge_page_nodemask(struct hstate *h,
>  				struct alloc_control *ac);
>  struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
> @@ -755,12 +753,6 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
>  struct hstate {};
>  
>  static inline struct page *
> -alloc_huge_page_node(struct hstate *h, struct alloc_control *ac)
> -{
> -	return NULL;
> -}
> -
> -static inline struct page *
>  alloc_huge_page_nodemask(struct hstate *h, struct alloc_control *ac)
>  {
>  	return NULL;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 859dba4..60b0983 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1981,31 +1981,12 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
>  }
>  
>  /* page migration callback function */
> -struct page *alloc_huge_page_node(struct hstate *h,
> -				struct alloc_control *ac)
> -{
> -	struct page *page = NULL;
> -
> -	ac->gfp_mask |= htlb_alloc_mask(h);
> -	if (ac->nid != NUMA_NO_NODE)
> -		ac->gfp_mask |= __GFP_THISNODE;
> -
> -	spin_lock(&hugetlb_lock);
> -	if (h->free_huge_pages - h->resv_huge_pages > 0)
> -		page = dequeue_huge_page_nodemask(h, ac);
> -	spin_unlock(&hugetlb_lock);
> -
> -	if (!page)
> -		page = alloc_migrate_huge_page(h, ac);
> -
> -	return page;
> -}
> -
> -/* page migration callback function */
>  struct page *alloc_huge_page_nodemask(struct hstate *h,
>  				struct alloc_control *ac)
>  {
>  	ac->gfp_mask |= htlb_alloc_mask(h);
> +	if (ac->thisnode && ac->nid != NUMA_NO_NODE)
> +		ac->gfp_mask |= __GFP_THISNODE;
>  
>  	spin_lock(&hugetlb_lock);
>  	if (h->free_huge_pages - h->resv_huge_pages > 0) {
> diff --git a/mm/internal.h b/mm/internal.h
> index 75b3f8e..574722d0 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -618,6 +618,7 @@ struct alloc_control {
>  	int nid;
>  	nodemask_t *nmask;
>  	gfp_t gfp_mask;
> +	bool thisnode;

I wonder if the new field is necessary?

IIUC, it simply prevents the check for NUMA_NO_NODE and possible setting
of __GFP_THISNODE in previous alloc_huge_page_nodemask() calling sequences.
However, it appears that node (preferred_nid) is always set to something
other than NUMA_NO_NODE in those callers.

It obviously makes sense to add the field to guarantee no changes to
functionality while making the conversions.  However, it it is not really
necessary then it may cause confusion later.

-- 
Mike Kravetz

>  };
>  
>  #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 06f60a5..629feaa 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1073,9 +1073,10 @@ struct page *alloc_new_node_page(struct page *page, unsigned long node)
>  		struct alloc_control ac = {
>  			.nid = node,
>  			.nmask = NULL,
> +			.thisnode = true,
>  		};
>  
> -		return alloc_huge_page_node(h, &ac);
> +		return alloc_huge_page_nodemask(h, &ac);
>  	} else if (PageTransHuge(page)) {
>  		struct page *thp;
>  
> 
