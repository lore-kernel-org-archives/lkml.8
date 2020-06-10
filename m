Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C985C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C04A92074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NZU3ks4F";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Ntere177"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgFJWqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:46:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23762 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726301AbgFJWqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:46:33 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05AMiQxd002219;
        Wed, 10 Jun 2020 15:46:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=M3YlEVjEHhxG1DTKWBeDt857J44ASaRwYekLx/oJmhk=;
 b=NZU3ks4FrDbEF5rE5rUIz+q5HbS2s7ZcM1TYmqpUns+JeyN/dQumBOVg6Lq7QrNSvRHd
 NhCPJnboJCRMLquWaoD505f+R+l9BI2CxZ/m8dmXnXOUXqJBFoLM5K35IKzxssRAPd+d
 kHOc8I9TFXUJ/5ffUx3PU7N9R2rI5a3L+Tw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31gu4rk4w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 10 Jun 2020 15:46:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 10 Jun 2020 15:46:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aA0CJKkPfZuCwggjvIL+sLHwbdOHVDVrbqo46/3tqmNKJErJnT83YQmLYGR4W5aa0CjANpqVtPkO0g0rxz79cikRCBZx3WQFttPaDmdO8s8IfbSZulgMWeG1boyq7o85Hv4Cjti5cf6eZcUTNQeULLINCg/jGEpT2L3Jivi30Z9qixmNkY0KWxjWaiCbDifmdGxC3MvQeYkq1Mig7UXc1v0YdMd1eFXzmcW1Z9dCukXoBk8tRmEfD8QHq7Ubt2Qj+ZdWDjxZolutfgyJM9TmvLzlR3BC7kx+C40Lgu804jJHoYT5im5YTGCaAlJIQ4SlALZpGU0m9Z3dBNxPEWahVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3YlEVjEHhxG1DTKWBeDt857J44ASaRwYekLx/oJmhk=;
 b=lqV4DzN+P5p9j4i+RtwZ17ljEPxVufR+7PnUX7UHhKsh3DDXX6m9lllNVsgHGlclgPL8dPXpPNqU6bm6iS9wKD8JlcdsvSsVFurxZ0YdOUu/gXQkXW20ajfW/GZ5CwQSBWQ7jI3hQZSeUmV0Ui5b9V8xXPrNxLQhV9Bu/UlxFRS2P4TtcqImOTJP0HLBrBhhhXommN4/FfEECiY1jU2zIACM67ho+xDVjM6QV0wp7IOpuNXfbuaH5xsueehL2hSYbM80DsW82ogGevfLu4CtOAFsBEw6I6h5dh2AhqezrKpLAXC7gDi/8Aq/4Y5cSq/+9x2HZtNw4jlGed7E15lruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3YlEVjEHhxG1DTKWBeDt857J44ASaRwYekLx/oJmhk=;
 b=Ntere177TChfjzL8ckS68ygIJXsFmcWgZdX/6i6kEALNjGLFViVOWKo8ybjsbT3KNWMsEFRMrs3TWht8ewI1NP5dQ6lFJ8vES1pB9iXaR3Y+rXqoRQll3pZPoFKXOJJW5LXYadS3UD6w+9S2YZ1YWcm6dVMV98zOIC8c8KqMblw=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2262.namprd15.prod.outlook.com (2603:10b6:a02:8c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Wed, 10 Jun
 2020 22:46:14 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 22:46:14 +0000
Date:   Wed, 10 Jun 2020 15:46:11 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@android.com>,
        <vinmenon@codeaurora.org>, Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [PATCH 9/9] mm, slab/slub: move and improve cache_from_obj()
Message-ID: <20200610224611.GD702969@carbon.DHCP.thefacebook.com>
References: <20200610163135.17364-1-vbabka@suse.cz>
 <20200610163135.17364-10-vbabka@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610163135.17364-10-vbabka@suse.cz>
X-ClientProxiedBy: BYAPR07CA0032.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::45) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:36fd) by BYAPR07CA0032.namprd07.prod.outlook.com (2603:10b6:a02:bc::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend Transport; Wed, 10 Jun 2020 22:46:13 +0000
X-Originating-IP: [2620:10d:c090:400::5:36fd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcdfc84f-6104-4a75-66a1-08d80d90147a
X-MS-TrafficTypeDiagnostic: BYAPR15MB2262:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2262BF29BADBCF2249DC6E8CBE830@BYAPR15MB2262.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6gNT5FXelihEfXYY4kgIe2v3P6QGfmFLG8abU7wupNnwG2ft/GTQ/o5PkGn5UChriS1vHniXWcK0a+XohbWcSWxScVUbvNBlFA6RJgzdJkyh/pINUtDLegQ+1BqQCb/PpG4uoGfIz3MMhaQc/kw/sLtAB+M5lXmwg/Z3QID57PSD+eOm1ADYxEputT7nbmM4zTEYzgrBrlUF5xm/r+Zo/E7q9sjADEPdfwhXq3P17iXo/H/4ZjlzjZm6sXxJ4Wga2VxyXG+tGvWH6eEVyhqeY/ei08IRn7dLJnpSQf5fCSuDRALlVpIIOpbyTfnuNI4LDYOz5/JF33GeSPZ7eY5aDysTBSuaXYvSdV8N3uSlOWF8eHsjgdmA5TUMo/Ciku/xftgd3j3d8Ihdl8RvqYXsRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(396003)(346002)(366004)(136003)(5660300002)(54906003)(66556008)(66946007)(66476007)(478600001)(966005)(6506007)(8676002)(7696005)(52116002)(186003)(4326008)(8936002)(9686003)(1076003)(7416002)(6916009)(316002)(55016002)(2906002)(33656002)(16526019)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Ztpl97mTESTJyYTHjj7hGDu4pfZ3hL4PNNznMRBGCef4eLvOjbP2cmKL6bDzgZ3T4Y5RgaxdUVtYIrnzdtI6oJBf+O1dmQW0cb+f75Gvmy6Fyb35akz07xIIjr+fYVLcnTHsLDDjXTqn05/RiclhQbCiop5uGyGExx7CL7IJtjZ3SSAU9D5NMf3H1Pe0t9MXBHtTq5Z2ezKlq2J82PEdA5llr7zEM6nLDWvNH/UJEERA7xVcih9sYErx22bFSnzfSWDjAso1jbh1fKEp+oNu69w7ZX1Q7DSyPBX9sYF+7m069jCAh77Y/R0IEk212j3zls4s1JjwGjdjJ6Sg1wZBfbw3LFBRPHCN7GWpmlsBfjF3+btnABJCqssUEB8SYMMF9wvwWbjBhKIdEbuLkrdLDV9fpq3zNZQMGJRJSszvg+ZhWj6+nl2lgA5NJHVa6scsVzVFOnsfiUFpynu42Rpv54DPzVkL2iPRaApTHnfF/lvaLyrNfEyB2siwXAST9689tdQ0IFMoiHap8xWzFw9zxg==
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdfc84f-6104-4a75-66a1-08d80d90147a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 22:46:14.4761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cy4MzUAeWkT/BCFjHwjaNETqssMrbgaNxqSKdOwH5MGz1QjfbrozwF6/vVVwC6TT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2262
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_13:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 cotscore=-2147483648 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0 mlxscore=0
 impostorscore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100165
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 06:31:35PM +0200, Vlastimil Babka wrote:
> The function cache_from_obj() was added by commit b9ce5ef49f00 ("sl[au]b:
> always get the cache from its page in kmem_cache_free()") to support kmemcg,
> where per-memcg cache can be different from the root one, so we can't use
> the kmem_cache pointer given to kmem_cache_free().
> 
> Prior to that commit, SLUB already had debugging check+warning that could be
> enabled to compare the given kmem_cache pointer to one referenced by the slab
> page where the object-to-be-freed resides. This check was moved to
> cache_from_obj(). Later the check was also enabled for SLAB_FREELIST_HARDENED
> configs by commit 598a0717a816 ("mm/slab: validate cache membership under
> freelist hardening").
> 
> These checks and warnings can be useful especially for the debugging, which can
> be improved. Commit 598a0717a816 changed the pr_err() with WARN_ON_ONCE() to
> WARN_ONCE() so only the first hit is now reported, others are silent. This
> patch changes it to WARN() so that all errors are reported.
> 
> It's also useful to print SLUB allocation/free tracking info for the offending
> object, if tracking is enabled. We could export the SLUB print_tracking()
> function and provide an empty one for SLAB, or realize that both the debugging
> and hardening cases in cache_from_obj() are only supported by SLUB anyway. So
> this patch moves cache_from_obj() from slab.h to separate instances in slab.c
> and slub.c, where the SLAB version only does the kmemcg lookup and even could
> be completely removed once the kmemcg rework [1] is merged. The SLUB version
> can thus easily use the print_tracking() function. It can also use the
> kmem_cache_debug_flags() static key check for improved performance in kernels
> without the hardening and with debugging not enabled on boot.
> 
> [1] https://lore.kernel.org/r/20200608230654.828134-18-guro@fb.com
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab.c |  8 ++++++++
>  mm/slab.h | 23 -----------------------
>  mm/slub.c | 21 +++++++++++++++++++++
>  3 files changed, 29 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 9350062ffc1a..6134c4c36d4c 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3672,6 +3672,14 @@ void *__kmalloc_track_caller(size_t size, gfp_t flags, unsigned long caller)
>  }
>  EXPORT_SYMBOL(__kmalloc_track_caller);
>  
> +static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
> +{
> +	if (memcg_kmem_enabled())
> +		return virt_to_cache(x);
> +	else
> +		return s;
> +}

Hm, it looks like all the SLAB version doesn't perform any sanity checks anymore.
Is it intended?

Also, Is it ever possible that s != virt_to_cache(x) if there are no bugs?

kmem_cache_free_bulk() in slab.c does contain the following:
	if (!orig_s) /* called via kfree_bulk */
		s = virt_to_cache(objp);
	else
		s = cache_from_obj(orig_s, objp);
which looks a bit strange with the version above.

> +
>  /**
>   * kmem_cache_free - Deallocate an object
>   * @cachep: The cache the allocation was from.
> diff --git a/mm/slab.h b/mm/slab.h
> index 815e4e9a94cd..c0c4244f75da 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -503,29 +503,6 @@ static __always_inline void uncharge_slab_page(struct page *page, int order,
>  	memcg_uncharge_slab(page, order, s);
>  }
>  
> -static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
> -{
> -	struct kmem_cache *cachep;
> -
> -	/*
> -	 * When kmemcg is not being used, both assignments should return the
> -	 * same value. but we don't want to pay the assignment price in that
> -	 * case. If it is not compiled in, the compiler should be smart enough
> -	 * to not do even the assignment. In that case, slab_equal_or_root
> -	 * will also be a constant.
> -	 */
> -	if (!memcg_kmem_enabled() &&
> -	    !IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
> -	    !unlikely(s->flags & SLAB_CONSISTENCY_CHECKS))
> -		return s;
> -
> -	cachep = virt_to_cache(x);
> -	WARN_ONCE(cachep && !slab_equal_or_root(cachep, s),
> -		  "%s: Wrong slab cache. %s but object is from %s\n",
> -		  __func__, s->name, cachep->name);
> -	return cachep;
> -}
> -
>  static inline size_t slab_ksize(const struct kmem_cache *s)
>  {
>  #ifndef CONFIG_SLUB
> diff --git a/mm/slub.c b/mm/slub.c
> index efb08f2e9c66..f7a1d8537674 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1524,6 +1524,10 @@ static bool freelist_corrupted(struct kmem_cache *s, struct page *page,
>  {
>  	return false;
>  }
> +
> +static void print_tracking(struct kmem_cache *s, void *object)
> +{
> +}
>  #endif /* CONFIG_SLUB_DEBUG */
>  
>  /*
> @@ -3175,6 +3179,23 @@ void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
>  }
>  #endif
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

Maybe we can define a trivial SLAB version of kmem_cache_debug_flags()
and keep a single version of cache_from_obj()?

Thank you!
