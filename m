Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020ECC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B759720756
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dLd5sowy";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="WTW4jH4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgEUAnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 20:43:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40036 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726754AbgEUAny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 20:43:54 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04L0E1Ap026382;
        Wed, 20 May 2020 17:43:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ryWOH8Lc6g0rUMEH2it0Q+w05BL58dT/27bXsJC8zzc=;
 b=dLd5sowy7EBg7zQ7hczylou1frXIsJ42Ns90c6eRaIV60APP9xOF5WP8HMYkE0jX5Dyf
 CNrR5SPNp0wdR6enlee5Iswkch95Z5RXzI5Lvb1Pa4iY4Fngu3j5VczFkjqyHl9fQ09o
 isru5NGA5yUsDDB7Ud8qMv+j0K8IacNgtEM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 314s854ryb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 20 May 2020 17:43:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 20 May 2020 17:43:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhZPlNekbfzpL622yI7/M6Zwwa6Hvukgr2KHhG0hnq/zHbTLGLrUSmrDYNqzGDJsSaX+mvIYgxzP47ahOIo39Tjs5hlk6460fwnEML22B0hmWoru1Kw4DlqcILc/0n5d6+X/4kJ1kmMEf/bfucEFSEVnTmZTZ3HLanXGArx+ffpwDJfiTMkK5+So9plA0DdctLLkbetqwFLxFmVrMqDVHYvZ0x91lPIF2NauIwbsqdmEbMsJw2gKfHm4TDuH7flt86LgSKA4TnzDLd790fnrhhDgHmjcHtY5RNK1m/NWozNAYfg/Pv5N7Wh0rwNs+JdeeNUxLyf1Z/vw0u2uCb6wRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryWOH8Lc6g0rUMEH2it0Q+w05BL58dT/27bXsJC8zzc=;
 b=IZ7eKWUGk9gkts+/aZopHrPj/jML42V19dT13Tmx9Mw28dBOCOBcZ3y1XEoQaIWHl0s1rkvirMPLYSUV/Y8wMnCxouToxUkf62MWeUJ4UwsmqcvgYwU36vm5xLDn9y7TPGE18hkjSKfzsQiOlzxBz1lmhzE+kYxUI6dempDaRHS/BgB/rTENIR7112gw8OPZy9e4OlwB/mceijH+gbDe/wXqsp7hoZ0NU2NfO8+MyAjtGhLKgfsiTxaXxInW/zOb7I+mZc0joiao7XTIiuUm0CA8L2ppk+eIJHnPWy1bHGVgOlkcGQzde2yt5x8y84O++V2CfBfPXmDvCJwBHEOMfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryWOH8Lc6g0rUMEH2it0Q+w05BL58dT/27bXsJC8zzc=;
 b=WTW4jH4VaEyDnfAReC+6Xuyry7WpyCHYiV2rkAPpA0dWact/SB5grWzvEDItFL7za6o5KC+jQm3skEJyW9jyQIvGKjaTlz2cCF2baNiGjjxIe0kAKen6A/q4hTXPZp/60jCDo8w9A+QGCtiA5Zs8vkZtfD8TQ0mTuu/SqHwVGZI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3272.namprd15.prod.outlook.com (2603:10b6:a03:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Thu, 21 May
 2020 00:43:33 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 00:43:33 +0000
Date:   Wed, 20 May 2020 17:43:24 -0700
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
Subject: Re: [PATCH 03/11] mm/hugetlb: introduce alloc_control structure to
 simplify migration target allocation APIs
Message-ID: <20200521004324.GB317575@carbon.dhcp.thefacebook.com>
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1589764857-6800-4-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589764857-6800-4-git-send-email-iamjoonsoo.kim@lge.com>
X-ClientProxiedBy: BYAPR07CA0050.namprd07.prod.outlook.com
 (2603:10b6:a03:60::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:bc17) by BYAPR07CA0050.namprd07.prod.outlook.com (2603:10b6:a03:60::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 00:43:32 +0000
X-Originating-IP: [2620:10d:c090:400::5:bc17]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 147d0f11-e889-4b53-56ff-08d7fd1ffcfd
X-MS-TrafficTypeDiagnostic: BYAPR15MB3272:
X-Microsoft-Antispam-PRVS: <BYAPR15MB327228219016DB9EE3D4C2B2BEB70@BYAPR15MB3272.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0J50a0h65FAUmwFc2zdprWoXEZFD74nv3bisIpDzae1V+zQm9ysBy0wnnI08nvwDqZ2Das1xN2B4Ci5aA9GwXI9fH8kQ2ILxHZnPDlTkkZiCky4DdY9nK8Ks/KGelGSgpO/l7e3/E4nXdKUv8x7GePet+PR0wwggiLPSu//snvRD3AY2/VlSak7QG9FtBemeRgN+Z+ye7zbrCS1pmVjCHer4sSr/NiDRo8y5qZ6hG570xJpaWAHJVEk3soBfM0kKWlGvh0YaiVaeWFpXovodh9r4f5WhkY+Z5nqpvjRhJioazCIE/Rse2CXF4P5trxS4OeJrUdn3UWI6Ra8iHM44WMEiMOqVhA8Is0kuAzAt8VLXwOMkxGmVkJaRV8y7hBafLBB/Iea4h4Izt0hv6jkyybX5PQ/OzzEcHkFWQcXsFBF1cQ+TrD80oMf2jN2QMN1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(396003)(136003)(366004)(39860400002)(54906003)(5660300002)(8676002)(4326008)(8936002)(30864003)(55016002)(478600001)(33656002)(9686003)(7416002)(186003)(2906002)(1076003)(6916009)(6666004)(16526019)(86362001)(316002)(52116002)(7696005)(66476007)(66946007)(6506007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: n2pPUc+TqvqOgciC5IAFeWOCK54xNnfQxXM/qzedZ3hTKYW6mL66z3Cx8jxASutY/1jZl8CsviVDWIXl0Eq8mXMAEwgGf35M9CzqMxt/XVWz7pcFtgoulwg4CbDk/ouhPpstMLBMhIryTr5zn0RG1UZbmjLYKtKnAppt+4mHVU7FMZVc7jGeD4tHRXckENOZxzSlczDY/49yYDJuTwUeDQa2Uk9Hs1G0hLenTFmIX5Fc5cUvPkSTgWl32I0JMbb5kPS99Pulg4bi9Bwyxfy+jhLznilj9N63Lmo5OuKhnIGXnDZytWV7db+od5rme6IH/yAVvNJPQsAtotZMSN4Fxwghulj1Uq7qEOBffTSn2Y7DqRydlT/LBPsi4c8jwqhfRDu8Vomxr2mfcyc3UJTAgE5lK9BKyBQTZT1fppuIjR0iJR64p0A1/pRy3yyxgNXbRXAiTGG1E80q+d+Q58K75kuh7ki/C9MaHwy4UiDT8jW1o7tI6so6hTac40gKr/XAdYy207BRSXQlJOyLBK6tlg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 147d0f11-e889-4b53-56ff-08d7fd1ffcfd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 00:43:32.8997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ayuez4QxQDJ6CvgznmwA3y3M4lAghj3NoA8X7a879GUgJsJ4g9Ibc7Y3rZKXqZK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3272
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_18:2020-05-20,2020-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 cotscore=-2147483648 spamscore=0 bulkscore=0 suspectscore=10
 mlxlogscore=999 impostorscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005210000
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 10:20:49AM +0900, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Currently, page allocation functions for migration requires some arguments.
> More worse, in the following patch, more argument will be needed to unify
> the similar functions. To simplify them, in this patch, unified data
> structure that controls allocation behaviour is introduced.

Is it all about huge pages only? If so, maybe adding huge_page suffix/prefix
to struct alloc_control? E.g. huge_alloc_control or something like this.

> 
> For clean-up, function declarations are re-ordered.
> 
> Note that, gfp_mask handling on alloc_huge_page_(node|nodemask) is
> slightly changed, from ASSIGN to OR. It's safe since caller of these
> functions doesn't pass extra gfp_mask except htlb_alloc_mask().

Changes make sense to me, but it feels like this patch is doing several
thing simultaneously. Do you mind splitting it into few?

Thanks!

> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  include/linux/hugetlb.h | 35 +++++++++++++++-------------
>  mm/gup.c                | 11 ++++++---
>  mm/hugetlb.c            | 62 ++++++++++++++++++++++++-------------------------
>  mm/internal.h           |  7 ++++++
>  mm/mempolicy.c          | 13 +++++++----
>  mm/migrate.c            | 13 +++++++----
>  6 files changed, 83 insertions(+), 58 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 0cced41..6da217e 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -14,6 +14,7 @@
>  struct ctl_table;
>  struct user_struct;
>  struct mmu_gather;
> +struct alloc_control;
>  
>  #ifndef is_hugepd
>  typedef struct { unsigned long pd; } hugepd_t;
> @@ -502,15 +503,16 @@ struct huge_bootmem_page {
>  	struct hstate *hstate;
>  };
>  
> -struct page *alloc_huge_page(struct vm_area_struct *vma,
> -				unsigned long addr, int avoid_reserve);
> -struct page *alloc_huge_page_node(struct hstate *h, int nid);
> -struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
> -				nodemask_t *nmask);
> +struct page *alloc_migrate_huge_page(struct hstate *h,
> +				struct alloc_control *ac);
> +struct page *alloc_huge_page_node(struct hstate *h,
> +				struct alloc_control *ac);
> +struct page *alloc_huge_page_nodemask(struct hstate *h,
> +				struct alloc_control *ac);
>  struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
>  				unsigned long address);
> -struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
> -				     int nid, nodemask_t *nmask);
> +struct page *alloc_huge_page(struct vm_area_struct *vma,
> +				unsigned long addr, int avoid_reserve);
>  int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
>  			pgoff_t idx);
>  
> @@ -752,20 +754,14 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
>  #else	/* CONFIG_HUGETLB_PAGE */
>  struct hstate {};
>  
> -static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
> -					   unsigned long addr,
> -					   int avoid_reserve)
> -{
> -	return NULL;
> -}
> -
> -static inline struct page *alloc_huge_page_node(struct hstate *h, int nid)
> +static inline struct page *
> +alloc_huge_page_node(struct hstate *h, struct alloc_control *ac)
>  {
>  	return NULL;
>  }
>  
>  static inline struct page *
> -alloc_huge_page_nodemask(struct hstate *h, int preferred_nid, nodemask_t *nmask)
> +alloc_huge_page_nodemask(struct hstate *h, struct alloc_control *ac)
>  {
>  	return NULL;
>  }
> @@ -777,6 +773,13 @@ static inline struct page *alloc_huge_page_vma(struct hstate *h,
>  	return NULL;
>  }
>  
> +static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
> +					   unsigned long addr,
> +					   int avoid_reserve)
> +{
> +	return NULL;
> +}
> +
>  static inline int __alloc_bootmem_huge_page(struct hstate *h)
>  {
>  	return 0;
> diff --git a/mm/gup.c b/mm/gup.c
> index 0d64ea8..9890fb0 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1613,16 +1613,21 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
>  	if (PageHighMem(page))
>  		gfp_mask |= __GFP_HIGHMEM;
>  
> -#ifdef CONFIG_HUGETLB_PAGE
>  	if (PageHuge(page)) {
>  		struct hstate *h = page_hstate(page);
> +		struct alloc_control ac = {
> +			.nid = nid,
> +			.nmask = NULL,
> +			.gfp_mask = gfp_mask,
> +		};
> +
>  		/*
>  		 * We don't want to dequeue from the pool because pool pages will
>  		 * mostly be from the CMA region.
>  		 */
> -		return alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
> +		return alloc_migrate_huge_page(h, &ac);
>  	}
> -#endif
> +
>  	if (PageTransHuge(page)) {
>  		struct page *thp;
>  		/*
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index dcb34d7..859dba4 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1054,8 +1054,8 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
>  	return page;
>  }
>  
> -static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask, int nid,
> -		nodemask_t *nmask)
> +static struct page *dequeue_huge_page_nodemask(struct hstate *h,
> +				struct alloc_control *ac)
>  {
>  	unsigned int cpuset_mems_cookie;
>  	struct zonelist *zonelist;
> @@ -1063,14 +1063,15 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
>  	struct zoneref *z;
>  	int node = NUMA_NO_NODE;
>  
> -	zonelist = node_zonelist(nid, gfp_mask);
> +	zonelist = node_zonelist(ac->nid, ac->gfp_mask);
>  
>  retry_cpuset:
>  	cpuset_mems_cookie = read_mems_allowed_begin();
> -	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp_mask), nmask) {
> +	for_each_zone_zonelist_nodemask(zone, z, zonelist,
> +			gfp_zone(ac->gfp_mask), ac->nmask) {
>  		struct page *page;
>  
> -		if (!cpuset_zone_allowed(zone, gfp_mask))
> +		if (!cpuset_zone_allowed(zone, ac->gfp_mask))
>  			continue;
>  		/*
>  		 * no need to ask again on the same node. Pool is node rather than
> @@ -1106,9 +1107,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
>  {
>  	struct page *page;
>  	struct mempolicy *mpol;
> -	gfp_t gfp_mask;
> -	nodemask_t *nodemask;
> -	int nid;
> +	struct alloc_control ac = {0};
>  
>  	/*
>  	 * A child process with MAP_PRIVATE mappings created by their parent
> @@ -1123,9 +1122,10 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
>  	if (avoid_reserve && h->free_huge_pages - h->resv_huge_pages == 0)
>  		goto err;
>  
> -	gfp_mask = htlb_alloc_mask(h);
> -	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
> -	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
> +	ac.gfp_mask = htlb_alloc_mask(h);
> +	ac.nid = huge_node(vma, address, ac.gfp_mask, &mpol, &ac.nmask);
> +
> +	page = dequeue_huge_page_nodemask(h, &ac);
>  	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
>  		SetPagePrivate(page);
>  		h->resv_huge_pages--;
> @@ -1938,15 +1938,16 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
>  	return page;
>  }
>  
> -struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
> -				     int nid, nodemask_t *nmask)
> +struct page *alloc_migrate_huge_page(struct hstate *h,
> +				struct alloc_control *ac)
>  {
>  	struct page *page;
>  
>  	if (hstate_is_gigantic(h))
>  		return NULL;
>  
> -	page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
> +	page = alloc_fresh_huge_page(h, ac->gfp_mask,
> +				ac->nid, ac->nmask, NULL);
>  	if (!page)
>  		return NULL;
>  
> @@ -1980,36 +1981,37 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
>  }
>  
>  /* page migration callback function */
> -struct page *alloc_huge_page_node(struct hstate *h, int nid)
> +struct page *alloc_huge_page_node(struct hstate *h,
> +				struct alloc_control *ac)
>  {
> -	gfp_t gfp_mask = htlb_alloc_mask(h);
>  	struct page *page = NULL;
>  
> -	if (nid != NUMA_NO_NODE)
> -		gfp_mask |= __GFP_THISNODE;
> +	ac->gfp_mask |= htlb_alloc_mask(h);
> +	if (ac->nid != NUMA_NO_NODE)
> +		ac->gfp_mask |= __GFP_THISNODE;
>  
>  	spin_lock(&hugetlb_lock);
>  	if (h->free_huge_pages - h->resv_huge_pages > 0)
> -		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, NULL);
> +		page = dequeue_huge_page_nodemask(h, ac);
>  	spin_unlock(&hugetlb_lock);
>  
>  	if (!page)
> -		page = alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
> +		page = alloc_migrate_huge_page(h, ac);
>  
>  	return page;
>  }
>  
>  /* page migration callback function */
> -struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
> -		nodemask_t *nmask)
> +struct page *alloc_huge_page_nodemask(struct hstate *h,
> +				struct alloc_control *ac)
>  {
> -	gfp_t gfp_mask = htlb_alloc_mask(h);
> +	ac->gfp_mask |= htlb_alloc_mask(h);
>  
>  	spin_lock(&hugetlb_lock);
>  	if (h->free_huge_pages - h->resv_huge_pages > 0) {
>  		struct page *page;
>  
> -		page = dequeue_huge_page_nodemask(h, gfp_mask, preferred_nid, nmask);
> +		page = dequeue_huge_page_nodemask(h, ac);
>  		if (page) {
>  			spin_unlock(&hugetlb_lock);
>  			return page;
> @@ -2017,22 +2019,20 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
>  	}
>  	spin_unlock(&hugetlb_lock);
>  
> -	return alloc_migrate_huge_page(h, gfp_mask, preferred_nid, nmask);
> +	return alloc_migrate_huge_page(h, ac);
>  }
>  
>  /* mempolicy aware migration callback */
>  struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
>  		unsigned long address)
>  {
> +	struct alloc_control ac = {0};
>  	struct mempolicy *mpol;
> -	nodemask_t *nodemask;
>  	struct page *page;
> -	gfp_t gfp_mask;
> -	int node;
>  
> -	gfp_mask = htlb_alloc_mask(h);
> -	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
> -	page = alloc_huge_page_nodemask(h, node, nodemask);
> +	ac.gfp_mask = htlb_alloc_mask(h);
> +	ac.nid = huge_node(vma, address, ac.gfp_mask, &mpol, &ac.nmask);
> +	page = alloc_huge_page_nodemask(h, &ac);
>  	mpol_cond_put(mpol);
>  
>  	return page;
> diff --git a/mm/internal.h b/mm/internal.h
> index 791e4b5a..75b3f8e 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -613,4 +613,11 @@ static inline bool is_migrate_highatomic_page(struct page *page)
>  
>  void setup_zone_pageset(struct zone *zone);
>  extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
> +
> +struct alloc_control {
> +	int nid;
> +	nodemask_t *nmask;
> +	gfp_t gfp_mask;
> +};
> +
>  #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 1965e26..06f60a5 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1068,10 +1068,15 @@ static int migrate_page_add(struct page *page, struct list_head *pagelist,
>  /* page allocation callback for NUMA node migration */
>  struct page *alloc_new_node_page(struct page *page, unsigned long node)
>  {
> -	if (PageHuge(page))
> -		return alloc_huge_page_node(page_hstate(compound_head(page)),
> -					node);
> -	else if (PageTransHuge(page)) {
> +	if (PageHuge(page)) {
> +		struct hstate *h = page_hstate(page);
> +		struct alloc_control ac = {
> +			.nid = node,
> +			.nmask = NULL,
> +		};
> +
> +		return alloc_huge_page_node(h, &ac);
> +	} else if (PageTransHuge(page)) {
>  		struct page *thp;
>  
>  		thp = alloc_pages_node(node,
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a298a8c..94d2386 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1526,10 +1526,15 @@ struct page *new_page_nodemask(struct page *page,
>  	unsigned int order = 0;
>  	struct page *new_page = NULL;
>  
> -	if (PageHuge(page))
> -		return alloc_huge_page_nodemask(
> -				page_hstate(compound_head(page)),
> -				preferred_nid, nodemask);
> +	if (PageHuge(page)) {
> +		struct hstate *h = page_hstate(page);
> +		struct alloc_control ac = {
> +			.nid = preferred_nid,
> +			.nmask = nodemask,
> +		};
> +
> +		return alloc_huge_page_nodemask(h, &ac);
> +	}
>  
>  	if (PageTransHuge(page)) {
>  		gfp_mask |= GFP_TRANSHUGE;
> -- 
> 2.7.4
> 
