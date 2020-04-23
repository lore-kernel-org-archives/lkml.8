Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E574C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7172A20724
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cGsysLLV";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="K9aTrsp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgDWUUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:20:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33052 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbgDWUUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 16:20:22 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03NKKDQp007656;
        Thu, 23 Apr 2020 13:20:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=3mg1GJQRn55DomFfK8HweijyTQcf1NrP0G9y4FzehbI=;
 b=cGsysLLVF/EMCP/k0ZwSPomd/AmfR3kVyzH3FLmniaOaUccLUi4RrScon9GZqQ45/Nh5
 xJ7nmrVmQf+R8CjMHnliecT4O/OdMqaDEOlSOfN2UMORG1UTe75lobj1LrXhPzYEZq3F
 cfzWOhGWrDKeodvLpPiFPmRgRVHKS8GuzG4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30kc0rakh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Apr 2020 13:20:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 23 Apr 2020 13:20:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVDuvgIYpbudWMEqucX7mbupq1kNL9VPgZE1znVpj6N2vcGfHVZr8CEDPR4Hx1jUpNp4VaQZ0ZpAFVHWX9GQx9GeNRKxomdJpwSoDgxuROElTeRUiyQU5iNApLwB+eUkgcLOJHBwfW21r82wUOa1N+/TJkSK8RLvz5bfIRhQKylWXkzH7+aTo6cmp9q641kba/cxe712BZ52ZCe5VXd0w6a0tt90OklVz846Y4vciGdS+7dZjqkk8pdsqZPYJRBJ2su4Bl8EmlDUDX0sz2imR1w1OmjqS2xucDH+mfO+dgUdMJIVL2yKM8he1ge3BHh47zANL+nb8qU3QqHcywBksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mg1GJQRn55DomFfK8HweijyTQcf1NrP0G9y4FzehbI=;
 b=jf3rkI5TnU1n7jl364HrappSMONBx9VXKdKC5Qhsre1dWhhN/DQUwOpBewTorVAZAR0QZ/iD275yQkGFFlJRLVz+/MdtWJJU0q1id4SrcXEA5PiS2yQcvK+Fn3VbyysztuzgRyXKL2h6dF+MjD5M7v6Y0PoPf2JzONND7B0vrEVUqeALLi9U9bZ3bt6yvdykCizHdqyLk+gIexaD7BnhElRfZAeGGFv+q7wilfYBUBZR5Y42JPOe3nPe0R50gS62eROIYi6xZKeTSgaUP4YMm4yYjQdkXBas40agO+W4VuVVq/GKXpSQT+sZO0t5MbHDD0ldYbpeQJDRrrHrZG/pKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mg1GJQRn55DomFfK8HweijyTQcf1NrP0G9y4FzehbI=;
 b=K9aTrsp5N5YzAbP5FoE+69vU52qN3h5sLgzIdwR6h4XHH37Hfno+SzoQNfDFm3RgzF3KZn4wjltWO0b5Og3Pf7e9iEXCioDYFR67MB2RSXwmKJt/Cf/ZHLanb4QutvjgG7sisSS2iU+uK/J8PtZ6J1LWALT2/gqxRV12Newgfts=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2344.namprd15.prod.outlook.com (2603:10b6:a02:90::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Thu, 23 Apr
 2020 20:20:11 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 20:20:11 +0000
Date:   Thu, 23 Apr 2020 13:20:06 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/19] mm: memcg/slab: allocate obj_cgroups for
 non-root slab pages
Message-ID: <20200423202006.GB63356@carbon.lan>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-8-guro@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422204708.2176080-8-guro@fb.com>
X-ClientProxiedBy: CO1PR15CA0109.namprd15.prod.outlook.com
 (2603:10b6:101:21::29) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:1a02) by CO1PR15CA0109.namprd15.prod.outlook.com (2603:10b6:101:21::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 20:20:10 +0000
X-Originating-IP: [2620:10d:c090:400::5:1a02]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f11cd5fb-a0c7-4c82-45e4-08d7e7c3b92f
X-MS-TrafficTypeDiagnostic: BYAPR15MB2344:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2344C338E52989B4F6B628E3BED30@BYAPR15MB2344.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(54906003)(478600001)(66946007)(16526019)(5660300002)(8676002)(6916009)(52116002)(4326008)(316002)(81156014)(66476007)(66556008)(186003)(9686003)(1076003)(55016002)(86362001)(2906002)(36756003)(8936002)(7696005)(6506007)(53546011)(6666004)(8886007)(33656002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yASzzx0kCW3D22cSQACLYoOvGZvfgErbdAzpJ841QDb8+mdrzmPGFTPj3zah73ctOHW8aDdV22rRJVX84sSyDKjn7qwicNN5UpZKdSbct4kTY5v6gkZi8J2I71VTtQ8fZOM1m/ePiRullMwUNCoRBwSXzeRiLvQ/9wxqCR+BB8F6h4kGTwfw6Pf14RaLToL97jxt2fYWzTXjVRVNiNXPn4Ea1mH6ko/Ok3DVQjY3ulEWBX7lc7HWS44Fikkk4U+Fq8dAmH+gUBW/RHRnoMWuq9IrpZS/qffaGzx7ScWsv1cXY3vQRtSICyCt2077bjukC/tDT/n50uYzpsQhgdwZkvhne1G0JcLZzF5LVt5q/0DeTxt7fHJhTx7HrURnxwjV8AAWZJW+OamTK7LZknMWZudGidr844OtT2nPv+xVlqu6F6UM6pHiVPl0nLf3hOuQ
X-MS-Exchange-AntiSpam-MessageData: w3KsJeVKWPxureOEiwI3MKS/nmtuQ8WH8uBNyWloq1tP8Q4l5/8Qcn/E9WIXp8VaTOeJUkJzzBxdPRTSalhfEpaXVFysZGr8kKiYJCi1ZCSo1nvCihJ9MgP1X3+zOeRcSmHsv2oMbX+hmuO039XGQ3qW4oXg+20vY4U2VHuQrC+e22f0d4JsAodfjSejoWwB
X-MS-Exchange-CrossTenant-Network-Message-Id: f11cd5fb-a0c7-4c82-45e4-08d7e7c3b92f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 20:20:11.0105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfeWhv3sgdI2wFJ0qCqqYpwcs7ThtKY/sW8s5XWGjXgVzMYcukuqIpFFuFH0WtU6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2344
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_15:2020-04-23,2020-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 suspectscore=5 impostorscore=0 adultscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230150
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 01:46:56PM -0700, Roman Gushchin wrote:
> Allocate and release memory to store obj_cgroup pointers for each
> non-root slab page. Reuse page->mem_cgroup pointer to store a pointer
> to the allocated space.
> 
> To distinguish between obj_cgroups and memcg pointers in case
> when it's not obvious which one is used (as in page_cgroup_ino()),
> let's always set the lowest bit in the obj_cgroup case.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  include/linux/mm_types.h |  5 ++++-
>  include/linux/slab_def.h |  5 +++++
>  include/linux/slub_def.h |  2 ++
>  mm/memcontrol.c          | 17 +++++++++++---
>  mm/slab.c                |  3 ++-
>  mm/slab.h                | 48 ++++++++++++++++++++++++++++++++++++++++
>  mm/slub.c                |  5 +++++
>  7 files changed, 80 insertions(+), 5 deletions(-)
>
...
> diff --git a/mm/slub.c b/mm/slub.c
> index 8d16babe1829..68c2c45dfac1 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5992,4 +5992,9 @@ ssize_t slabinfo_write(struct file *file, const char __user *buffer,
>  {
>  	return -EIO;
>  }
> +
> +int objs_per_slab(struct kmem_cache *cache)
> +{
> +	return oo_objects(cache->oo);
> +}
>  #endif /* CONFIG_SLUB_DEBUG */
> -- 
> 2.25.3
> 


Ooops, the build bot found that objs_per_slab() was accidentally guarded by
CONFIG_SLUB_DEBUG. An updated version below.

--

From 6b358e0157815535c3a73b4ce7b28f9c4c7804b3 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Wed, 10 Jul 2019 15:44:38 -0700
Subject: [PATCH v3.1 07/19] mm: memcg/slab: allocate obj_cgroups for non-root
 slab pages

Allocate and release memory to store obj_cgroup pointers for each
non-root slab page. Reuse page->mem_cgroup pointer to store a pointer
to the allocated space.

To distinguish between obj_cgroups and memcg pointers in case
when it's not obvious which one is used (as in page_cgroup_ino()),
let's always set the lowest bit in the obj_cgroup case.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/mm_types.h |  5 ++++-
 include/linux/slab_def.h |  5 +++++
 include/linux/slub_def.h |  2 ++
 mm/memcontrol.c          | 17 +++++++++++---
 mm/slab.c                |  3 ++-
 mm/slab.h                | 48 ++++++++++++++++++++++++++++++++++++++++
 mm/slub.c                |  5 +++++
 7 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4aba6c0c2ba8..0ad7e700f26d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -198,7 +198,10 @@ struct page {
 	atomic_t _refcount;
 
 #ifdef CONFIG_MEMCG
-	struct mem_cgroup *mem_cgroup;
+	union {
+		struct mem_cgroup *mem_cgroup;
+		struct obj_cgroup **obj_cgroups;
+	};
 #endif
 
 	/*
diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
index abc7de77b988..967a9a525eab 100644
--- a/include/linux/slab_def.h
+++ b/include/linux/slab_def.h
@@ -114,4 +114,9 @@ static inline unsigned int obj_to_index(const struct kmem_cache *cache,
 	return reciprocal_divide(offset, cache->reciprocal_buffer_size);
 }
 
+static inline int objs_per_slab(const struct kmem_cache *cache)
+{
+	return cache->num;
+}
+
 #endif	/* _LINUX_SLAB_DEF_H */
diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index 200ea292f250..cbda7d55796a 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -191,4 +191,6 @@ static inline unsigned int obj_to_index(const struct kmem_cache *cache,
 				 cache->reciprocal_size);
 }
 
+extern int objs_per_slab(struct kmem_cache *cache);
+
 #endif /* _LINUX_SLUB_DEF_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7f87a0eeafec..63826e460b3f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -549,10 +549,21 @@ ino_t page_cgroup_ino(struct page *page)
 	unsigned long ino = 0;
 
 	rcu_read_lock();
-	if (PageSlab(page) && !PageTail(page))
+	if (PageSlab(page) && !PageTail(page)) {
 		memcg = memcg_from_slab_page(page);
-	else
-		memcg = READ_ONCE(page->mem_cgroup);
+	} else {
+		memcg = page->mem_cgroup;
+
+		/*
+		 * The lowest bit set means that memcg isn't a valid
+		 * memcg pointer, but a obj_cgroups pointer.
+		 * In this case the page is shared and doesn't belong
+		 * to any specific memory cgroup.
+		 */
+		if ((unsigned long) memcg & 0x1UL)
+			memcg = NULL;
+	}
+
 	while (memcg && !(memcg->css.flags & CSS_ONLINE))
 		memcg = parent_mem_cgroup(memcg);
 	if (memcg)
diff --git a/mm/slab.c b/mm/slab.c
index 9350062ffc1a..f2d67984595b 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1370,7 +1370,8 @@ static struct page *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
 		return NULL;
 	}
 
-	if (charge_slab_page(page, flags, cachep->gfporder, cachep)) {
+	if (charge_slab_page(page, flags, cachep->gfporder, cachep,
+			     cachep->num)) {
 		__free_pages(page, cachep->gfporder);
 		return NULL;
 	}
diff --git a/mm/slab.h b/mm/slab.h
index 8a574d9361c1..44def57f050e 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -319,6 +319,18 @@ static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
 	return s->memcg_params.root_cache;
 }
 
+static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
+{
+	/*
+	 * page->mem_cgroup and page->obj_cgroups are sharing the same
+	 * space. To distinguish between them in case we don't know for sure
+	 * that the page is a slab page (e.g. page_cgroup_ino()), let's
+	 * always set the lowest bit of obj_cgroups.
+	 */
+	return (struct obj_cgroup **)
+		((unsigned long)page->obj_cgroups & ~0x1UL);
+}
+
 /*
  * Expects a pointer to a slab page. Please note, that PageSlab() check
  * isn't sufficient, as it returns true also for tail compound slab pages,
@@ -406,6 +418,25 @@ static __always_inline void memcg_uncharge_slab(struct page *page, int order,
 	percpu_ref_put_many(&s->memcg_params.refcnt, nr_pages);
 }
 
+static inline int memcg_alloc_page_obj_cgroups(struct page *page, gfp_t gfp,
+					       unsigned int objects)
+{
+	void *vec;
+
+	vec = kcalloc(objects, sizeof(struct obj_cgroup *), gfp);
+	if (!vec)
+		return -ENOMEM;
+
+	page->obj_cgroups = (struct obj_cgroup **) ((unsigned long)vec | 0x1UL);
+	return 0;
+}
+
+static inline void memcg_free_page_obj_cgroups(struct page *page)
+{
+	kfree(page_obj_cgroups(page));
+	page->obj_cgroups = NULL;
+}
+
 extern void slab_init_memcg_params(struct kmem_cache *);
 extern void memcg_link_cache(struct kmem_cache *s, struct mem_cgroup *memcg);
 
@@ -455,6 +486,16 @@ static inline void memcg_uncharge_slab(struct page *page, int order,
 {
 }
 
+static inline int memcg_alloc_page_obj_cgroups(struct page *page, gfp_t gfp,
+					       unsigned int objects)
+{
+	return 0;
+}
+
+static inline void memcg_free_page_obj_cgroups(struct page *page)
+{
+}
+
 static inline void slab_init_memcg_params(struct kmem_cache *s)
 {
 }
@@ -481,12 +522,18 @@ static __always_inline int charge_slab_page(struct page *page,
 					    gfp_t gfp, int order,
 					    struct kmem_cache *s)
 {
+	int ret;
+
 	if (is_root_cache(s)) {
 		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
 				    PAGE_SIZE << order);
 		return 0;
 	}
 
+	ret = memcg_alloc_page_obj_cgroups(page, gfp, objs_per_slab(s));
+	if (ret)
+		return ret;
+
 	return memcg_charge_slab(page, gfp, order, s);
 }
 
@@ -499,6 +546,7 @@ static __always_inline void uncharge_slab_page(struct page *page, int order,
 		return;
 	}
 
+	memcg_free_page_obj_cgroups(page);
 	memcg_uncharge_slab(page, order, s);
 }
 
diff --git a/mm/slub.c b/mm/slub.c
index 8d16babe1829..a5fb0bb5c77a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -344,6 +344,11 @@ static inline unsigned int oo_objects(struct kmem_cache_order_objects x)
 	return x.x & OO_MASK;
 }
 
+int objs_per_slab(struct kmem_cache *cache)
+{
+	return oo_objects(cache->oo);
+}
+
 /*
  * Per slab locking using the pagelock
  */
-- 
2.25.3

