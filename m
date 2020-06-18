Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0174EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C499D207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="abIfJjV6";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UOZA5IiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbgFRUGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:06:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7130 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729154AbgFRUGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:06:50 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05IK6aSp010932;
        Thu, 18 Jun 2020 13:06:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Bt35ui5O9WgRjCG/1WQOzOirTp0hI/f4CFQSmauBr7I=;
 b=abIfJjV6FawS96Iv5udInj6FBNZBNsLPbidTQXHeyFi2zUdp6R9ZvbzFK05iEUdMYAR3
 9b3ozjA/jI+fAA85wTU2GC6vrPYPcKnoF/B1CJnCqu0DGBDq6sjQCXy6/Maj+y7UZQ7h
 ykIiCrJwk29Ah5VioWnIhHQwvOaPRaCqtqk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 31rcbe0y7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 13:06:35 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 13:06:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOOk9zRj4kxysmpSMpXqSNp31dfyJBirlCbzGX/m3TTtoC6Nr8SYI1xpOVqt8ejHyE5mHtTBSBiS4gHC+OEHIvggzYKNR15JLKY8Mp6SNu2b76N97W1Y2Ngd1CDqAmJ1fzYq4H4IwRhSeLaFoT7PF00g5lmeJ6az4/hOLgi8KhVnY43DnNre32x/DKuzpne3Es1UGJWQYLnM5ncwOLAaqkObG45DA2Jg/SxB6IRnhi3gS1Veil+1hlGhqMAZa2G9UrDnSHwIVigWqV9pvFD+ISCLqdslpK1Z5ms6CGHxSeIMpLS1NzsuyIJJHq7KH8hhwJt2X+e584EUurMKJ2+Ezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bt35ui5O9WgRjCG/1WQOzOirTp0hI/f4CFQSmauBr7I=;
 b=KvUrgquhIj9VgPXmCRkd/tEnbu7iqWMkDQOiDjePVmwS5Od72rJwN+hsml4Au79XA6NQxS6n6byI8j4+p+nZLLe3+MkWeszvKN4hc7j3mRUaN0pthipOyTlfDeMg2ewtJeD2HnzWP83K/ZbQrzCNWKCiytN2TFxXWSBII28lvkncSpLj+Zqch6xKvnvBmgbv6oZFiKv9M/FM9CZR8MGBT58FgKuNgeA+QM8kHCPccT9YX5c+MUwvi3G0WI7e2VzTtu9YEyPaLTMmK9fg/Rn16aXpYoNxqPldlSWeAl5Af0qGfgYOeFXJtJkg0fQsx51f1X0e+izRabfhtk3Ibq/0qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bt35ui5O9WgRjCG/1WQOzOirTp0hI/f4CFQSmauBr7I=;
 b=UOZA5IiQg8HX1u0DZmZyP3mxqsop5TDTtCXTHe5HUOgnYYW2N5opV7E1PLj5t7R00cwAt7spWe60FFefOEOv7EWoCCBEOr2wgWfZ6PQx8zU6rVKvycp05S4TDBO5/iE+sboJSgQJRekcyyIwgzIGNNh/2cZMsykLVnrc4AyEjx8=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3399.namprd15.prod.outlook.com (2603:10b6:a03:10a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Thu, 18 Jun
 2020 20:05:59 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 20:05:59 +0000
Date:   Thu, 18 Jun 2020 13:05:53 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@android.com>,
        <vinmenon@codeaurora.org>, Matthew Garrett <mjg59@google.com>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [PATCH 9/9] mm, slab/slub: move and improve cache_from_obj()
Message-ID: <20200618200553.GE110603@carbon.dhcp.thefacebook.com>
References: <20200610163135.17364-1-vbabka@suse.cz>
 <20200610163135.17364-10-vbabka@suse.cz>
 <202006171039.FBDF2D7F4A@keescook>
 <afeda7ac-748b-33d8-a905-56b708148ad5@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afeda7ac-748b-33d8-a905-56b708148ad5@suse.cz>
X-ClientProxiedBy: DM6PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:5:bc::30) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:632d) by DM6PR13CA0017.namprd13.prod.outlook.com (2603:10b6:5:bc::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.12 via Frontend Transport; Thu, 18 Jun 2020 20:05:57 +0000
X-Originating-IP: [2620:10d:c090:400::5:632d]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3361f039-3d84-4076-9de7-08d813c304e0
X-MS-TrafficTypeDiagnostic: BYAPR15MB3399:
X-Microsoft-Antispam-PRVS: <BYAPR15MB339944D8F9F318470214E1F7BE9B0@BYAPR15MB3399.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scs07Q0bKF8VxieDD5RXO+RI752mfwnF/SrsPw5y4aSyfBgPSXbya3QdoP+q8m/sq0hHhNRQi7Lq1lckh0p69iIsrnO1+Ss7YtIs2GQFCZF/YyUOHgiMLGOBw0KpHgpqc4sUdMnGp0w0CmvbR9tNIduxz+fj1w/SCdHZQv2UqxHOZu2ajDZbTiraJbAyjouuE5dMXr4IyxCT3ME4V4bTZqYbRE6MT8KiH96OfcuCLb1uZ80eFeKI1Tz73rbWhBdPZOk6ws0Kq/iJZqyOkWunTeFbCaHcl0uxEkF77MVcGfMcDHU5H73q1bPFsrkzjmpoVmqRGjFvuBgk5uSUmH3xODlEegGAqzuKJ4AH/IO0lyFlEC7NFUib+x867a9cGylNRw/RRTWqevi/Tq22PmLlIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(376002)(366004)(396003)(136003)(6916009)(33656002)(6666004)(9686003)(8676002)(478600001)(8936002)(316002)(4326008)(7416002)(83380400001)(966005)(54906003)(86362001)(66556008)(66946007)(66476007)(1076003)(2906002)(52116002)(55016002)(5660300002)(6506007)(53546011)(7696005)(16526019)(30864003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ikhSzm0Yn9LThL2GjsTPiVtT5J7y7bEcy/hbdsov2oZqj3zg2hADey63KuJN3IUW9MvCCgniCzRYJr3oIipE4Dkb+vvumC1jQSXAjbnK0aq/9MieUd2t7NTAh3qRcXQBAWJkmYwI7LeiUR0YqIv8wjMBJxbu3zNbUak0BILF6aRDnjhNCnMwk158/rIShM7vGi2SSdFbparGAGxI3Q33o4IodS10IfJ+qxAcZyak2RdsiiSsQSmbsN3Di4Iib4C02aKumB35R2X6IuCn70BHkHqgkA8/OTpdm0pbiREsjZ+vIWqoabA3Z9viD5mOMmXQDvcs3pnFXSOVhVmOrChKTckcph8ZJ/cjRZXsDLLXURH08VRAL2jCB+DRH/fg8HgSoB3VKAkx8pzh/3l0Z1cwvsoXH/AOpfoMkBPZGnCsLSn+EZqNtBDwUTd75BBvDfipvCqhEdP+6BqvLIpu5PdmWihUWV3HWWQU5FErkG9Dxxr0c7jm+BpV+Y1bEDJAFp6hEI2xb0kpuYQRzWfGMp/xmg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3361f039-3d84-4076-9de7-08d813c304e0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 20:05:59.7024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CznfLt1AVUeqsTAYUDCBhzZBPFbHio5MlJVeYG+CmdmXvIYR7WhYUnqkeHOGyrg7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3399
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_15:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 cotscore=-2147483648 malwarescore=0 adultscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180153
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 12:10:38PM +0200, Vlastimil Babka wrote:
> 
> On 6/17/20 7:49 PM, Kees Cook wrote:
> > On Wed, Jun 10, 2020 at 06:31:35PM +0200, Vlastimil Babka wrote:
> >> The function cache_from_obj() was added by commit b9ce5ef49f00 ("sl[au]b:
> >> always get the cache from its page in kmem_cache_free()") to support kmemcg,
> >> where per-memcg cache can be different from the root one, so we can't use
> >> the kmem_cache pointer given to kmem_cache_free().
> >> 
> >> Prior to that commit, SLUB already had debugging check+warning that could be
> >> enabled to compare the given kmem_cache pointer to one referenced by the slab
> >> page where the object-to-be-freed resides. This check was moved to
> >> cache_from_obj(). Later the check was also enabled for SLAB_FREELIST_HARDENED
> >> configs by commit 598a0717a816 ("mm/slab: validate cache membership under
> >> freelist hardening").
> >> 
> >> These checks and warnings can be useful especially for the debugging, which can
> >> be improved. Commit 598a0717a816 changed the pr_err() with WARN_ON_ONCE() to
> >> WARN_ONCE() so only the first hit is now reported, others are silent. This
> >> patch changes it to WARN() so that all errors are reported.
> >> 
> >> It's also useful to print SLUB allocation/free tracking info for the offending
> >> object, if tracking is enabled. We could export the SLUB print_tracking()
> >> function and provide an empty one for SLAB, or realize that both the debugging
> >> and hardening cases in cache_from_obj() are only supported by SLUB anyway. So
> >> this patch moves cache_from_obj() from slab.h to separate instances in slab.c
> >> and slub.c, where the SLAB version only does the kmemcg lookup and even could
> > 
> > Oops. I made a mistake when I applied CONFIG_SLAB_FREELIST_HARDENED
> > here, I was thinking of SLAB_FREELIST_RANDOM's coverage (SLUB and SLAB),
> > and I see now that I never updated CONFIG_SLAB_FREELIST_HARDENED to
> > cover SLAB and SLOB.
> > 
> > The point being: I still want the sanity check for the SLAB case under
> > hardening. This needs to stay a common function. The whole point is
> > to catch corruption from the wrong kmem_cache * being associated with
> > an object, and that's agnostic of slab/slub/slob.
> > 
> > So, I'll send a follow-up to this patch to actually do what I had
> > originally intended for 598a0717a816 ("mm/slab: validate cache membership
> > under freelist hardening"), which wasn't intended to be SLUB-specific.
> 
> To prvent the churn of your patch moving the cache_from_obj() back to slab.h, I
> think it's best if we modify my patch. The patch below should be squashed into
> the current version in mmots, with the commit log used for the whole result.
> 
> This will cause conflicts while reapplying Roman's
> mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-allocations.patch which
> can be fixed by
> a) throwing away the conflicting hunks for cache_from_obj() in slab.c and slub.c
> b) applying this hunk instead:
> 
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -455,12 +455,11 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
>  	struct kmem_cache *cachep;
>  
>  	if (!IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
> -	    !memcg_kmem_enabled() &&
>  	    !kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS))
>  		return s;
>  
>  	cachep = virt_to_cache(x);
> -	if (WARN(cachep && !slab_equal_or_root(cachep, s),
> +	if (WARN(cachep && cachep != s,
>  		  "%s: Wrong slab cache. %s but object is from %s\n",
>  		  __func__, s->name, cachep->name))
>  		print_tracking(cachep, x);
> 
> The fixup patch itself:
> ----8<----
> From b8df607d92b37e5329ce7bda62b2b364cc249893 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Thu, 18 Jun 2020 11:52:03 +0200
> Subject: [PATCH] mm, slab/slub: improve error reporting and overhead of
>  cache_from_obj()
> 
> The function cache_from_obj() was added by commit b9ce5ef49f00 ("sl[au]b:
> always get the cache from its page in kmem_cache_free()") to support
> kmemcg, where per-memcg cache can be different from the root one, so we
> can't use the kmem_cache pointer given to kmem_cache_free().
> 
> Prior to that commit, SLUB already had debugging check+warning that could
> be enabled to compare the given kmem_cache pointer to one referenced by
> the slab page where the object-to-be-freed resides.  This check was moved
> to cache_from_obj().  Later the check was also enabled for
> SLAB_FREELIST_HARDENED configs by commit 598a0717a816 ("mm/slab: validate
> cache membership under freelist hardening").
> 
> These checks and warnings can be useful especially for the debugging,
> which can be improved.  Commit 598a0717a816 changed the pr_err() with
> WARN_ON_ONCE() to WARN_ONCE() so only the first hit is now reported,
> others are silent.  This patch changes it to WARN() so that all errors are
> reported.
> 
> It's also useful to print SLUB allocation/free tracking info for the offending
> object, if tracking is enabled. Thus, export the SLUB print_tracking() function
> and provide an empty one for SLAB.
> 
> For SLUB we can also benefit from the static key check in
> kmem_cache_debug_flags(), but we need to move this function to slab.h and
> declare the static key there.
> 
> [1] https://lore.kernel.org/r/20200608230654.828134-18-guro@fb.com
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
>  mm/slab.c |  8 --------
>  mm/slab.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  mm/slub.c | 38 +-------------------------------------
>  3 files changed, 46 insertions(+), 45 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 6134c4c36d4c..9350062ffc1a 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3672,14 +3672,6 @@ void *__kmalloc_track_caller(size_t size, gfp_t flags, unsigned long caller)
>  }
>  EXPORT_SYMBOL(__kmalloc_track_caller);
>  
> -static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
> -{
> -	if (memcg_kmem_enabled())
> -		return virt_to_cache(x);
> -	else
> -		return s;
> -}
> -
>  /**
>   * kmem_cache_free - Deallocate an object
>   * @cachep: The cache the allocation was from.
> diff --git a/mm/slab.h b/mm/slab.h
> index a2696d306b62..a9f5ba9ce9a7 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -275,6 +275,34 @@ static inline int cache_vmstat_idx(struct kmem_cache *s)
>  		NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE;
>  }
>  
> +#ifdef CONFIG_SLUB_DEBUG
> +#ifdef CONFIG_SLUB_DEBUG_ON
> +DECLARE_STATIC_KEY_TRUE(slub_debug_enabled);
> +#else
> +DECLARE_STATIC_KEY_FALSE(slub_debug_enabled);
> +#endif
> +extern void print_tracking(struct kmem_cache *s, void *object);
> +#else
> +static inline void print_tracking(struct kmem_cache *s, void *object)
> +{
> +}
> +#endif
> +
> +/*
> + * Returns true if any of the specified slub_debug flags is enabled for the
> + * cache. Use only for flags parsed by setup_slub_debug() as it also enables
> + * the static key.
> + */
> +static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)
> +{
> +	VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS));
> +#ifdef CONFIG_SLUB_DEBUG
> +	if (static_branch_unlikely(&slub_debug_enabled))
> +		return s->flags & flags;
> +#endif
> +	return false;
> +}
> +
>  #ifdef CONFIG_MEMCG_KMEM
>  
>  /* List of all root caches. */
> @@ -503,6 +531,23 @@ static __always_inline void uncharge_slab_page(struct page *page, int order,
>  	memcg_uncharge_slab(page, order, s);
>  }
>  
> +static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
> +{
> +	struct kmem_cache *cachep;
> +
> +	if (!IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
> +	    !memcg_kmem_enabled() &&
> +	    !kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS))
> +		return s;
> +
> +	cachep = virt_to_cache(x);
> +	if (WARN(cachep && !slab_equal_or_root(cachep, s),
> +		  "%s: Wrong slab cache. %s but object is from %s\n",
> +		  __func__, s->name, cachep->name))
> +		print_tracking(cachep, x);
> +	return cachep;
> +}
> +
>  static inline size_t slab_ksize(const struct kmem_cache *s)
>  {
>  #ifndef CONFIG_SLUB
> diff --git a/mm/slub.c b/mm/slub.c
> index 202fb423d195..0e635a8aa340 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -122,21 +122,6 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
>  #endif
>  #endif
>  
> -/*
> - * Returns true if any of the specified slub_debug flags is enabled for the
> - * cache. Use only for flags parsed by setup_slub_debug() as it also enables
> - * the static key.
> - */
> -static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)
> -{
> -	VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS));
> -#ifdef CONFIG_SLUB_DEBUG
> -	if (static_branch_unlikely(&slub_debug_enabled))
> -		return s->flags & flags;
> -#endif
> -	return false;
> -}
> -
>  static inline bool kmem_cache_debug(struct kmem_cache *s)
>  {
>  	return kmem_cache_debug_flags(s, SLAB_DEBUG_FLAGS);
> @@ -653,7 +638,7 @@ static void print_track(const char *s, struct track *t, unsigned long pr_time)
>  #endif
>  }
>  
> -static void print_tracking(struct kmem_cache *s, void *object)
> +void print_tracking(struct kmem_cache *s, void *object)
>  {
>  	unsigned long pr_time = jiffies;
>  	if (!(s->flags & SLAB_STORE_USER))
> @@ -1525,10 +1510,6 @@ static bool freelist_corrupted(struct kmem_cache *s, struct page *page,
>  {
>  	return false;
>  }
> -
> -static void print_tracking(struct kmem_cache *s, void *object)
> -{
> -}
>  #endif /* CONFIG_SLUB_DEBUG */
>  
>  /*
> @@ -3180,23 +3161,6 @@ void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
>  }
>  #endif
>  
> -static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
> -{
> -	struct kmem_cache *cachep;
> -
> -	if (!IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
> -	    !memcg_kmem_enabled() &&
> -	    !kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS))
> -		return s;
> -
> -	cachep = virt_to_cache(x);
> -	if (WARN(cachep && !slab_equal_or_root(cachep, s),
> -		  "%s: Wrong slab cache. %s but object is from %s\n",
> -		  __func__, s->name, cachep->name))
> -		print_tracking(cachep, x);
> -	return cachep;
> -}
> -
>  void kmem_cache_free(struct kmem_cache *s, void *x)
>  {
>  	s = cache_from_obj(s, x);
> -- 
> 2.27.0
> 
> 
