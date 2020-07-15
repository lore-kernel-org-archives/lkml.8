Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACCDC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D12920663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bo8bgxdX";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bTkZx/Gd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgGORy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 13:54:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18566 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725861AbgGORy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 13:54:56 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FHrERv030456;
        Wed, 15 Jul 2020 10:54:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=iAzDE6ANrnv69PNW9YgY+QZrI4RSvQqxgs4IxX11NhM=;
 b=bo8bgxdXOAXk3QUZJqlEIcjwgT+8MSaslQ3boBtY8w5AluiqFmxqdNDbiT9TJ31IDvVQ
 e778k5cqr8jmCw1VI/XDvU2pIEP4Yd6N2+S0ezgqV2fxRT0bEP4HJoHe18tPpHKPKGjQ
 3L9QnHe5nBe8T1rDSLUgejDlgYRKWLknebA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 329nqvc4pu-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Jul 2020 10:54:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 15 Jul 2020 10:54:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3eNq3c9e1Be9R1wfq19Y0ws/29ofwULqKy59pDWCfizVApQOkl5ccxsSSBNaumrdQika6z+jK9jEhu/k7Lit/B2bX4YBK0zv9pB9IpzPygh3EhMedoa4VgfkTiQM5ZfPqDqhu8roT40Z8Z+0Vtkoe1eyR6uzSYcASGNR2oC3mMOHG63Ys4A38VM+24NbmH5VVaAGCY4P4an/5XxuJyuFK5SVY2byq34M2Z3owcaeo6kjqnJ7+dlq+0vLI22FkJARam84aN/M20Moay9atkqt9A3M4GaYQk6V1JTmzQmWL8jE90tMjQdIQE1apVEuHJlNCu6Xl2ssKT6YAtUrtV55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAzDE6ANrnv69PNW9YgY+QZrI4RSvQqxgs4IxX11NhM=;
 b=c4B1yRhwsLewa1D6Okjrz2U04jP1RHfYx4SoyiASyDLyXrlTHg4u+Do3TUKmSyMJNoOlN1mcoJy/8PYVr5ni8mYWhCsGU5MChwxdFR5ij+/Gw+VYDXXRKltJAsSkvs+b86OhAAGzojZlm+1TZdExXhEJnugGpI1VphlSpdyrglFUd8PGOAG0aVeYVKTgMv2WTzKyJoAg9nHiEN9l99SEqBA2iB485xWut0YD92UMAEggrOYNiSewWloZIZglBKpi5cobuPz+ir2WKn0PLPGOL4vyMMJ0bUb/sPEi1nuTFNaUOWshvOnGlgOxKrsqYoZE9MXK+Ar3s7CFMvIlgnFlzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAzDE6ANrnv69PNW9YgY+QZrI4RSvQqxgs4IxX11NhM=;
 b=bTkZx/GddrA/hQo56Rmm70VmQ2ZcObgcNPaE4pXEMHIAABjC7NICulQ9qdFEGwblLTPgkdwSlQ2TdS1svr9FlHVci7aVzLL072XYEVGaQ94PYs2/lbp6ftqhjZV+MKZMOJ42CXjYFFX+iTMZwMuZpMnYds1hFxQbj0aKfiUg0GA=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3221.namprd15.prod.outlook.com (2603:10b6:a03:102::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 15 Jul
 2020 17:54:40 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3195.018; Wed, 15 Jul 2020
 17:54:40 +0000
Date:   Wed, 15 Jul 2020 10:54:32 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <vbabka@suse.cz>, <cl@linux.com>, <penberg@kernel.org>,
        <rientjes@google.com>, <iamjoonsoo.kim@lge.com>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: memcg/slab: fix memory leak at non-root
 kmem_cache destroy
Message-ID: <20200715175432.GA6314@carbon.lan>
References: <20200715165023.29919-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715165023.29919-1-songmuchun@bytedance.com>
X-ClientProxiedBy: BL1PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:208:257::26) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c091:480::1:5184) by BL1PR13CA0051.namprd13.prod.outlook.com (2603:10b6:208:257::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.9 via Frontend Transport; Wed, 15 Jul 2020 17:54:37 +0000
X-Originating-IP: [2620:10d:c091:480::1:5184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 353d6e34-7dfd-4729-9142-08d828e8257a
X-MS-TrafficTypeDiagnostic: BYAPR15MB3221:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3221F55711D29690BFC36597BE7E0@BYAPR15MB3221.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uTSX7PpvLx4j98zVjv6Fn25yfx0tJGG7mxyCNpiFCeZEVbG/ywenGCLL/QGk5vBc+WufDclU4Pzhx/orJgZDMXk4IjwLtL+bjjsJGaFKtfOUMV9KlBCu+XTZ2/ziVBEiiCF+5ZtTmCJ9Msnh2uK89BJRY9T2iRZpPkiKl9zTA70flbpbXU4TWWfHEdSUrvqDRshgV8f1+0aTOwyflQ4R01DmVXELs2fhBhGaDinObJDBLCcHr+fFxei+RVjAXMmAEbyPOQUTbDBPgU1gSIBavku3C7/PXFutc4LOFok9o90wW9WkgabCMRQd481/E93zGPGSEyO14SnJLUIZyC5MPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(366004)(346002)(39860400002)(376002)(1076003)(316002)(55016002)(9686003)(66476007)(36756003)(5660300002)(8886007)(6666004)(66556008)(66946007)(7416002)(186003)(6916009)(8936002)(8676002)(86362001)(52116002)(16526019)(7696005)(478600001)(4326008)(2906002)(83380400001)(6506007)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: SkEmKyCXd5A62BOCEVAPLgFpfkUB4caes8RRDdJRFHb9hJTFEldx5D+qshuZU4Ya9nbT4/FuQvh5QamWbClQLRVPp3WcCX0YhBzghEz2E8tu7cwOpAeCfzlVPO/ECI7LyOEesT1MTfKNICb9NS/b7mmpGesZrm/ohe9vT3m9vObJTYoJb4N8HHYVVuXscXvvlOjkVR5LPZ59KuD4eO9bkuS/PIOptk/g+Xk2IwKkHuXknraGQnsetbNX1QhvGVD0yRchR77m3Bpjm7qypsZdfQFYdt9sd65hx7g+w0Ft+f2CfNrQ5gnO5mKQDo73wHZnbgUnvJdRif4BsUwKgYzrDOqmEaggoCAJFIQPA3TFvAWiXhE6wFT7bizf0qaUEKdGRpxVS5ndNezCwUDSynMUUzlpPqH31zHmCWWt8LSNprnenah9efaHShBAoQZjrnYk9Aoi/B0VxZKa6QCnntWMf0E8HTr2MaQnnm/YL8beiSrUcn5SKThpqS92hL+4YaH7E0BjAoaSGYdAr2de9TcO+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 353d6e34-7dfd-4729-9142-08d828e8257a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 17:54:40.0707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 385D720+Pp4oqgG42wLr+0ElyXpF0fx/iZmE9cfTmq50fROD+PDVHsj+pB0kWDOw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3221
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 suspectscore=1 phishscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150139
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 12:50:22AM +0800, Muchun Song wrote:
> If the kmem_cache refcount is greater than one, we should not
> mark the root kmem_cache as dying. If we mark the root kmem_cache
> dying incorrectly, the non-root kmem_cache can never be destroyed.
> It resulted in memory leak when memcg was destroyed. We can use the
> following steps to reproduce.
> 
>   1) Use kmem_cache_create() to create a new kmem_cache named A.
>   2) Coincidentally, the kmem_cache A is an alias for kmem_cache B,
>      so the refcount of B is just increased.
>   3) Use kmem_cache_destroy() to destroy the kmem_cache A, just
>      decrease the B's refcount but mark the B as dying.
>   4) Create a new memory cgroup and alloc memory from the kmem_cache
>      B. It leads to create a non-root kmem_cache for allocating memory.
>   5) When destroy the memory cgroup created in the step 4), the
>      non-root kmem_cache can never be destroyed.
> 
> If we repeat steps 4) and 5), this will cause a lot of memory leak.
> So only when refcount reach zero, we mark the root kmem_cache as dying.
> 
> Fixes: 92ee383f6daa ("mm: fix race between kmem_cache destroy, create and deactivate")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> ---
> 
> changelog in v2:
>  1) Fix a confusing typo in the commit log.

Ok, now I see the problem. Thank you for fixing the commit log!

>  2) Remove flush_memcg_workqueue() for !CONFIG_MEMCG_KMEM.
>  3) Introduce a new helper memcg_set_kmem_cache_dying() to fix a race
>     condition between flush_memcg_workqueue() and slab_unmergeable(). 
> 
>  mm/slab_common.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 47 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 8c1ffbf7de45..c4958116e3fd 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -258,6 +258,11 @@ static void memcg_unlink_cache(struct kmem_cache *s)
>  		list_del(&s->memcg_params.kmem_caches_node);
>  	}
>  }
> +
> +static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
> +{
> +	return is_root_cache(s) && s->memcg_params.dying;
> +}
>  #else
>  static inline int init_memcg_params(struct kmem_cache *s,
>  				    struct kmem_cache *root_cache)
> @@ -272,6 +277,11 @@ static inline void destroy_memcg_params(struct kmem_cache *s)
>  static inline void memcg_unlink_cache(struct kmem_cache *s)
>  {
>  }
> +
> +static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_MEMCG_KMEM */
>  
>  /*
> @@ -326,6 +336,13 @@ int slab_unmergeable(struct kmem_cache *s)
>  	if (s->refcount < 0)
>  		return 1;
>  
> +	/*
> +	 * If the kmem_cache is dying. We should also skip this
> +	 * kmem_cache.
> +	 */
> +	if (memcg_kmem_cache_dying(s))
> +		return 1;
> +
>  	return 0;
>  }
>  
> @@ -886,12 +903,15 @@ static int shutdown_memcg_caches(struct kmem_cache *s)
>  	return 0;
>  }
>  
> -static void flush_memcg_workqueue(struct kmem_cache *s)
> +static void memcg_set_kmem_cache_dying(struct kmem_cache *s)
>  {
>  	spin_lock_irq(&memcg_kmem_wq_lock);
>  	s->memcg_params.dying = true;
>  	spin_unlock_irq(&memcg_kmem_wq_lock);
> +}
>  
> +static void flush_memcg_workqueue(struct kmem_cache *s)
> +{
>  	/*
>  	 * SLAB and SLUB deactivate the kmem_caches through call_rcu. Make
>  	 * sure all registered rcu callbacks have been invoked.
> @@ -923,10 +943,6 @@ static inline int shutdown_memcg_caches(struct kmem_cache *s)
>  {
>  	return 0;
>  }
> -
> -static inline void flush_memcg_workqueue(struct kmem_cache *s)
> -{
> -}
>  #endif /* CONFIG_MEMCG_KMEM */
>  
>  void slab_kmem_cache_release(struct kmem_cache *s)
> @@ -944,8 +960,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
>  	if (unlikely(!s))
>  		return;
>  
> -	flush_memcg_workqueue(s);
> -
>  	get_online_cpus();
>  	get_online_mems();
>  
> @@ -955,6 +969,32 @@ void kmem_cache_destroy(struct kmem_cache *s)
>  	if (s->refcount)
>  		goto out_unlock;
>  
> +#ifdef CONFIG_MEMCG_KMEM
> +	memcg_set_kmem_cache_dying(s);
> +
> +	mutex_unlock(&slab_mutex);

Hm, but in theory s->refcount can be increased here?
So it doesn't solve the problem completely, but makes it less probable, right?

I wonder if it's possible to (additionally) protect s->refcount with a
memcg_kmem_wq_lock, so that we can check it in the context of flush_memcg_workqueue()?

> +
> +	put_online_mems();
> +	put_online_cpus();
> +
> +	flush_memcg_workqueue(s);
> +
> +	get_online_cpus();
> +	get_online_mems();
> +
> +	mutex_lock(&slab_mutex);
> +
> +	if (WARN(s->refcount,
> +		 "kmem_cache_destroy %s: Slab cache is still referenced\n",
> +		 s->name)) {
> +		/*
> +		 * Reset the dying flag setted by memcg_set_kmem_cache_dying().
> +		 */
> +		s->memcg_params.dying = false;
> +		goto out_unlock;
> +	}
> +#endif
> +
>  	err = shutdown_memcg_caches(s);
>  	if (!err)
>  		err = shutdown_cache(s);
> -- 
> 2.11.0
> 

Other than the problem above your patch looks really good to me, however we should
be really careful here, as it should in theory be back-ported to a big number
of old stable kernels. And because it's (hopefully) fixed in 5.9, it's a backport-only
patch.

So I wonder if we can mitigate the problem by disabling cache sharing for some
specific kmem_caches instead? Like for all with SLAB_ACCOUNT and maybe for all except
a hard-coded list (if kmem accounting is enabled). Do you mind sharing any details
on how this problem reveals itself in the real life?

Thanks!

PS I'm off the keyboard for the rest of today, will think more and hopefully
come back with some ideas tomorrow.


