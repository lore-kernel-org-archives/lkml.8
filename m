Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1229C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D232070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mPTF7gTz";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZrUEuwUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgEUAqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 20:46:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22322 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbgEUAqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 20:46:33 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04L0AnX9003729;
        Wed, 20 May 2020 17:46:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=YKIBHUV2dPzf/+BM6Kj4yICJt+LdJ6W9Cp5jm0NbmsY=;
 b=mPTF7gTzXNxGaNk5B390WfS0jgwt09Q89tg6YDGc9cQswAJ6gPfNGdRBy0QmGH3kewRT
 3IYRcOOlU3CmvHD783V+RYZXv6iIhe/bcJoDDG/+5OOfn4QQi0TVYaEBbKWQXI3RsXSG
 HL7V+yQW0/Y38eWwr2mTiCjSiD3rjow1oms= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 312yvdnn8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 20 May 2020 17:46:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 20 May 2020 17:46:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7NJmcDDUjOMRjF2yykJur9Lg7Qkuzn4vg8wviygn+myT8ThnALLvVup63y3TL0IlUVNJQZ9MsnKN40fkUtekIL38DL9jJegGjGTvwRlJpQG1nQsNImno+CS6xK9drdN9kcSCHar24Kdbl23DrXhfO/JBAKXmwvK1pHK+jzI8MSdD+c5Odost9HivvYEtCoLj87/GJoGXaZhGwyoRVwCwbI7QKC+87a4zAXUe34FkUWydaCD6cD8OoFuu4yfhQCEBCe9/7fFK/w6eq8xOhKJrKhubCmR6JUrO5nmwjK4xzYiY53S3mHO9ZuaJhIpY0n9+5rx1JTXCxKL81F25pgPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKIBHUV2dPzf/+BM6Kj4yICJt+LdJ6W9Cp5jm0NbmsY=;
 b=iDCUhlt0Udbj9GFwyKbgGuucsvUbnfeRDsS+DsUusgGnsEcuFCGzmWCatVIraOdFGB+/hKAOGip/Gr8sp8VK19IGe1P/ZS6MUl93GebOsT/qau6SJ119TnovkQEl/jJX6NjeKQ7NLMZSNwjr3DkwsaEn1Q36NuUcy4TwD3xM1l8sTiPjF3hOie/Rf45kruhHqgjbwfbsQiwbzYr1J2FHL+ysfYViEQ4FoUzmUxJIa0pNaS57DhHKULQQ7JrBV9MCjVtOxgawReUGyaNBaOTI34006MxygRsqYZO+iZTrJw87WuAgCK7JOts1nLRa+HptKxKP/bGioT74u3g2NItRXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKIBHUV2dPzf/+BM6Kj4yICJt+LdJ6W9Cp5jm0NbmsY=;
 b=ZrUEuwUJgyMXTlwkiP2WR6iMvSmVHQ8hed2hDQXZeottfUjvlsIBJiGhwxn2XCll87DxucO6eZk0fQXj0CXgyET+DSjnchSnJznWtJekyhqwQUoPYHbt4JIx2dv7M23SeJ3dgCTcwdJ+hYb8uvEw88baBuWgU5YMyBgqyebUcNo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3030.namprd15.prod.outlook.com (2603:10b6:a03:fb::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Thu, 21 May
 2020 00:46:11 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 00:46:11 +0000
Date:   Wed, 20 May 2020 17:46:08 -0700
From:   Roman Gushchin <guro@fb.com>
To:     <js1304@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 04/11] mm/hugetlb: unify hugetlb migration callback
 function
Message-ID: <20200521004608.GC317575@carbon.dhcp.thefacebook.com>
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1589764857-6800-5-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589764857-6800-5-git-send-email-iamjoonsoo.kim@lge.com>
X-ClientProxiedBy: BYAPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::36) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:bc17) by BYAPR07CA0023.namprd07.prod.outlook.com (2603:10b6:a02:bc::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.25 via Frontend Transport; Thu, 21 May 2020 00:46:10 +0000
X-Originating-IP: [2620:10d:c090:400::5:bc17]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 509ba7d0-2c49-4f4c-bfed-08d7fd205b96
X-MS-TrafficTypeDiagnostic: BYAPR15MB3030:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3030C7212EE7E09D6998EDC3BEB70@BYAPR15MB3030.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0AhT1xnotsokF3hfYruQpqWJabq9rqfYo8hE/XDmN5HnVulpb3s+Du4qbdrWg/46Iw4JVUsjGvcr4RN22dTAoino0DWRtuD9jRg0l63lgUMr0LmxLi9kml5yz0/AQc95i/gXwEf/KRTT43YdlbSRZqP6RxV3zpcv6oRCVPOz5F9IwWIp7ltq2axfs9DWORaoeiy6EzCE5dBppto9HdfU4SqCif/a/QEgrjCF5VUICPhnxMvL0VQmO6JJs2lejf/dl3plx826vTjA/YaI1tKJQwjBDNXG2UYxAM3wZekLbxKfTko0MgKSwtbmSpWZwFXZ7NVE1e+3Wm+fAHbHyxR9uocXQ7ijl0x1Yy4dTWI1MXWBHNCvN+NzZoNkeYdlEz/mJNz519jGuhwCDcDyNmrUS2aJ7VY9IzyjvxWqCJH1jLVU1RmVV5s1wXUg6rKgnJkz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(396003)(376002)(346002)(136003)(8936002)(1076003)(478600001)(33656002)(66476007)(52116002)(16526019)(66946007)(6506007)(66556008)(186003)(316002)(55016002)(7416002)(54906003)(5660300002)(8676002)(9686003)(2906002)(7696005)(6916009)(4326008)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: mhtfu8BATpesbltkFvRlWY/p5LZEUU15X2dti/ps7gz06NR8gGj46wcIMRWvFCNg8Qs1dKf9BmHjfYQIc5RBdnVfFgAwNKuTqu4+3d23oMxRGdF/qwWY1wMqq2MFVK3dlBOHxuaENHSNseTdexgIMLxM43HVBTU+ul5sJtRIu35k1v40bW26d8r0CccvCZLsqeL6CtMsmSKjkfSiQNd1Cx/4c9r/py8KV7rix+DqlCl301N5L5XBOdkoFk3rg7cW9ShxfI1l7vpbMI9STPaZjbaL9iAWiq1wesJIPRQBdDptG0QbLNzfNFf2UDgpZFvcUFAwH4OKgd6UBTz6jhUjpt1ItdtKpW5aUt4NDQd7I+jxbcINh5mSi+Pl/SkDq3L9W5qNzB9WSBouC1pCgHje1eyz7aN9mA2F754S3wbOeVcg44I4RnMB0bhAtQtvigscmwq6f224R+LcHluCJffB/6VlJjWtlFi2D1TBMlWUtMdCRt6lB1j22itKSwmhpPjniJ2XBPjpBCUOUZwmLBN5FQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 509ba7d0-2c49-4f4c-bfed-08d7fd205b96
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 00:46:11.5880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXM2Lke0ES9B4UaVByTcusdmIvwkuQnIH78tgl8PEsWwt7aQjMaDbdaXic11eklM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3030
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_18:2020-05-20,2020-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 suspectscore=10 mlxscore=0 clxscore=1015 priorityscore=1501
 cotscore=-2147483648 phishscore=0 mlxlogscore=563 bulkscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005210000
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 10:20:50AM +0900, js1304@gmail.com wrote:
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

Maybe drop _nodemask suffix in the remaining function?

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
>  };

Can you, please, add some comments what each field exactly mean?

Thanks!

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
> -- 
> 2.7.4
> 
