Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC72C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3F820739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bEd8k/dg";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="A+8yY6jL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgGPQQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:16:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17950 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728837AbgGPQQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:16:41 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06GGGKRK006028;
        Thu, 16 Jul 2020 09:16:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=n80vOC6xXgAvPxINKlEdUBeBs4HH/cqNw8J4T9SrXiQ=;
 b=bEd8k/dgxZ/IQutvPCwZRDNpeazu8AhDDbxOwYSB8i6qL+6xDxUuDIowLproid0HtTFK
 gg7umy3h/J3RPfEao27Nrhvpd4k2zKgGsfxJJvil5k1Gv002RJInADVShIUfl3kFzqjX
 BA8kfAReLpj8kO6zGTi7s5s4vjP9XlmdsNI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32a7fpvusn-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Jul 2020 09:16:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 16 Jul 2020 09:16:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlmjcHhuofnHUtjkfQh/kEHvBxxR8E50vYPPHjra0pcyGjA/wxIYr3yc933IF0q9M61H1sy20fj2ltJe1JgmBYkaxdSyGSKzn9nzFlsckKO+zXv3UHA5E7D+ZPQ2P5QNBcT6C7M8Ov8Yz4YLC7gqvBiKLWcqJ0ihHqYdkgLLTodvHjYkmIj4YgCOsAlk2XxSrF1PkyAbNhZjyKtzZ5xXCjEZQi3wbCvUBHYhMFRcmGtEwjuodNWxfMmO6UrZwlKwSO5wZn6kGq4uTqnuiJkQtX1WgMOrkK2ECmEMB8VtKXkbODH4FI/r8nhtJcGfngiGpfSp/wmj+B8uhasFxU+3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n80vOC6xXgAvPxINKlEdUBeBs4HH/cqNw8J4T9SrXiQ=;
 b=ZUHT/mp/h39LMtj3i+lLsXTuC9PJ9VPSrAQc8i3tZklPHxKpulvWS8HHE1+IqaxL8EuPLDUz5iDKnSy8wtk8PbaGsnkcCGhC/ucjsg4XabIostxUrILd900ty5+1LNgJhYnVXJOkUd2bCnhPCaFG9K9qknUJ/JCJyrKgBfhK/7ot94BC0YJvV0kUehi2cfLtl4QOfjMlao8laq0R/rHfWuN1PHSHso8IPTFf5/BIOZKgEfGsjih7wSAKu1wM1R0AjMRkzHt/aZlfEXQHPtrh7Jk9beGqmMehb7xr5RSlc+2v3gTtgOTGBuh7Ns0y9eV4n3JgSBPHP3XWUPitLoSV3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n80vOC6xXgAvPxINKlEdUBeBs4HH/cqNw8J4T9SrXiQ=;
 b=A+8yY6jLIP+P8Xou41SV1e9dhWZ4XbqCgMQeZFZ85OPm6/rOOqhJ5nfPPNWaW6LS9uf71QsfUr029Ri54gUTtyYahD0mPfVviXtrQNo4FzVehSB2W5NqY5XBZQqbt6Q62BhPjwMeKxmVSNEfdKFdDJLaO61MucC77PPdlTLzyqM=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2504.namprd15.prod.outlook.com (2603:10b6:a02:8e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Thu, 16 Jul
 2020 16:16:22 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 16:16:22 +0000
Date:   Thu, 16 Jul 2020 09:16:18 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v2] mm: memcg/slab: fix memory leak at
 non-root kmem_cache destroy
Message-ID: <20200716161507.GA4217@carbon.lan>
References: <20200715165023.29919-1-songmuchun@bytedance.com>
 <20200715175432.GA6314@carbon.lan>
 <CAMZfGtVupfg+WiXBvTsnXTZ=bgHxaztEFP1cQ8hnCfXmCUV=gw@mail.gmail.com>
 <20200716154633.GA15421@carbon.DHCP.thefacebook.com>
 <CAMZfGtVMY3DqH4XxwkfY0AekD9EFvAN2xaavRUjxYK_s3yA89w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtVMY3DqH4XxwkfY0AekD9EFvAN2xaavRUjxYK_s3yA89w@mail.gmail.com>
X-ClientProxiedBy: BYAPR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::49) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:916c) by BYAPR02CA0036.namprd02.prod.outlook.com (2603:10b6:a02:ee::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.19 via Frontend Transport; Thu, 16 Jul 2020 16:16:21 +0000
X-Originating-IP: [2620:10d:c090:400::5:916c]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 127457f9-720f-4195-a581-08d829a39454
X-MS-TrafficTypeDiagnostic: BYAPR15MB2504:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2504C82E9F4BE8FE99BD3127BE7F0@BYAPR15MB2504.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: naaUgjFQNSqvotP3AvJG4x1X3WCjavOPBa7cZ+8o5PddUXNLAGxjVusznYZz11tneLpfFQneLZxZr2B5TyXZDIncfXDN8XfwUtajA3sbNtM1Nb9nUuoq6QROBkqMiAK8U1n7lwqbIZZ9PWZIa6MFmckJ1FwN0NCAUfmaThtwBmqVtpxAfvWHBiBESzzTIeK9jDnfLMHVWmQ34lXu6K8IAdKv/a4pnc+DTziHTrWcqH05Df+/8RkHuNMrP/8CKjJHSG7LlptWrjDN1AgIeMxcdRez8UhtbJe0jGPrirSwPzo7h2W7xtFFMaebVG+iA1NMw/xXLcenP1cDPBbdVhT44Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(366004)(39860400002)(376002)(136003)(66556008)(66946007)(36756003)(7416002)(66476007)(4326008)(83380400001)(54906003)(9686003)(55016002)(5660300002)(8886007)(186003)(478600001)(52116002)(16526019)(316002)(8676002)(33656002)(53546011)(6506007)(86362001)(1076003)(7696005)(2906002)(6916009)(8936002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: KsvSZcJDwBd3DTzuL8/Vy9D7v4UZbBIMrDUenJjmST3BbG4AXlxkDqkQPKLaqPGzjiLTj5Ij2BDuuI7kUy+8YuAFnfkmkZKS3PWtTegbci2F9O6qeX7lFvIRTV1c7gkf8LuQVkxDKTI2a8Lt+om/Am8WkWvg7jisPEhExTLN+kbJ2PvO+sdAHaV89N8rXrbOZt9zfD15CdgLnUh64aFa1D4H07K/QVr/kxfRyZUrOeu5gwKGRKGnRsyr+JF6YMM/m2QZ0h0NwRzK5UeDw5il3ArMDaufzIRjmUXDM5NEZ9ZGhZKemtZ6WyNDncjNzShnxM9/vmIYLzGf4kKWFhGS/OKv3gqr5/+fd57VGbhu58fFv6NW79uhw7c1/P/LQmxi3R2xI4o6vMw6CXmAbCytibNHAJhr5HfGJTS9VtHq9PTHa6d5M4Bph5hyd2lfwNVe9MTz5IhrEZx15PT9WPPf18TK9St9s/CUkQMN9O+QwsXDbc9VZ41+jcmjSRHCgXDHD+8gDdTC2oSlYq/UX1CBLQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 127457f9-720f-4195-a581-08d829a39454
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 16:16:21.8977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYMW7Jzp2XqKDw0E8C3ZWxzdgcTum6u56wDwqQDvKOc0mwSpUs0HBALVZTvOPiqs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2504
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_07:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=1 clxscore=1015 priorityscore=1501
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160123
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 11:54:37PM +0800, Muchun Song wrote:
> On Thu, Jul 16, 2020 at 11:46 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Thu, Jul 16, 2020 at 01:07:02PM +0800, Muchun Song wrote:
> > > On Thu, Jul 16, 2020 at 1:54 AM Roman Gushchin <guro@fb.com> wrote:
> > > >
> > > > On Thu, Jul 16, 2020 at 12:50:22AM +0800, Muchun Song wrote:
> > > > > If the kmem_cache refcount is greater than one, we should not
> > > > > mark the root kmem_cache as dying. If we mark the root kmem_cache
> > > > > dying incorrectly, the non-root kmem_cache can never be destroyed.
> > > > > It resulted in memory leak when memcg was destroyed. We can use the
> > > > > following steps to reproduce.
> > > > >
> > > > >   1) Use kmem_cache_create() to create a new kmem_cache named A.
> > > > >   2) Coincidentally, the kmem_cache A is an alias for kmem_cache B,
> > > > >      so the refcount of B is just increased.
> > > > >   3) Use kmem_cache_destroy() to destroy the kmem_cache A, just
> > > > >      decrease the B's refcount but mark the B as dying.
> > > > >   4) Create a new memory cgroup and alloc memory from the kmem_cache
> > > > >      B. It leads to create a non-root kmem_cache for allocating memory.
> > > > >   5) When destroy the memory cgroup created in the step 4), the
> > > > >      non-root kmem_cache can never be destroyed.
> > > > >
> > > > > If we repeat steps 4) and 5), this will cause a lot of memory leak.
> > > > > So only when refcount reach zero, we mark the root kmem_cache as dying.
> > > > >
> > > > > Fixes: 92ee383f6daa ("mm: fix race between kmem_cache destroy, create and deactivate")
> > > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > > > > ---
> > > > >
> > > > > changelog in v2:
> > > > >  1) Fix a confusing typo in the commit log.
> > > >
> > > > Ok, now I see the problem. Thank you for fixing the commit log!
> > > >
> > > > >  2) Remove flush_memcg_workqueue() for !CONFIG_MEMCG_KMEM.
> > > > >  3) Introduce a new helper memcg_set_kmem_cache_dying() to fix a race
> > > > >     condition between flush_memcg_workqueue() and slab_unmergeable().
> > > > >
> > > > >  mm/slab_common.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++-------
> > > > >  1 file changed, 47 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > > > > index 8c1ffbf7de45..c4958116e3fd 100644
> > > > > --- a/mm/slab_common.c
> > > > > +++ b/mm/slab_common.c
> > > > > @@ -258,6 +258,11 @@ static void memcg_unlink_cache(struct kmem_cache *s)
> > > > >               list_del(&s->memcg_params.kmem_caches_node);
> > > > >       }
> > > > >  }
> > > > > +
> > > > > +static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
> > > > > +{
> > > > > +     return is_root_cache(s) && s->memcg_params.dying;
> > > > > +}
> > > > >  #else
> > > > >  static inline int init_memcg_params(struct kmem_cache *s,
> > > > >                                   struct kmem_cache *root_cache)
> > > > > @@ -272,6 +277,11 @@ static inline void destroy_memcg_params(struct kmem_cache *s)
> > > > >  static inline void memcg_unlink_cache(struct kmem_cache *s)
> > > > >  {
> > > > >  }
> > > > > +
> > > > > +static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
> > > > > +{
> > > > > +     return false;
> > > > > +}
> > > > >  #endif /* CONFIG_MEMCG_KMEM */
> > > > >
> > > > >  /*
> > > > > @@ -326,6 +336,13 @@ int slab_unmergeable(struct kmem_cache *s)
> > > > >       if (s->refcount < 0)
> > > > >               return 1;
> > > > >
> > > > > +     /*
> > > > > +      * If the kmem_cache is dying. We should also skip this
> > > > > +      * kmem_cache.
> > > > > +      */
> > > > > +     if (memcg_kmem_cache_dying(s))
> > > > > +             return 1;
> > > > > +
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > @@ -886,12 +903,15 @@ static int shutdown_memcg_caches(struct kmem_cache *s)
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > -static void flush_memcg_workqueue(struct kmem_cache *s)
> > > > > +static void memcg_set_kmem_cache_dying(struct kmem_cache *s)
> > > > >  {
> > > > >       spin_lock_irq(&memcg_kmem_wq_lock);
> > > > >       s->memcg_params.dying = true;
> > > > >       spin_unlock_irq(&memcg_kmem_wq_lock);
> > > > > +}
> > > > >
> > > > > +static void flush_memcg_workqueue(struct kmem_cache *s)
> > > > > +{
> > > > >       /*
> > > > >        * SLAB and SLUB deactivate the kmem_caches through call_rcu. Make
> > > > >        * sure all registered rcu callbacks have been invoked.
> > > > > @@ -923,10 +943,6 @@ static inline int shutdown_memcg_caches(struct kmem_cache *s)
> > > > >  {
> > > > >       return 0;
> > > > >  }
> > > > > -
> > > > > -static inline void flush_memcg_workqueue(struct kmem_cache *s)
> > > > > -{
> > > > > -}
> > > > >  #endif /* CONFIG_MEMCG_KMEM */
> > > > >
> > > > >  void slab_kmem_cache_release(struct kmem_cache *s)
> > > > > @@ -944,8 +960,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
> > > > >       if (unlikely(!s))
> > > > >               return;
> > > > >
> > > > > -     flush_memcg_workqueue(s);
> > > > > -
> > > > >       get_online_cpus();
> > > > >       get_online_mems();
> > > > >
> > > > > @@ -955,6 +969,32 @@ void kmem_cache_destroy(struct kmem_cache *s)
> > > > >       if (s->refcount)
> > > > >               goto out_unlock;
> > > > >
> > > > > +#ifdef CONFIG_MEMCG_KMEM
> > > > > +     memcg_set_kmem_cache_dying(s);
> > > > > +
> > > > > +     mutex_unlock(&slab_mutex);
> > > >
> > > > Hm, but in theory s->refcount can be increased here?
> > >
> > > I have tried my best to read all the codes that operate on s->refcount.
> > > There is only one place which increases the s->refcount, it is the
> > > __kmem_cache_alias(). If the kmem cache is dying, the slab_unmergeable()
> > > can never return true for the dying kmem cache because it is the same slab_mutex
> > > protection, so I think that there is not a problem, right?
> >
> > So the problem is that you're checking s->refcount under slab_mutex,
> > then you're releasing the mutex and then set the dying bit. But nothing prevents
> 
> Maybe you miss something. The dying bit is set in the
> memcg_set_kmem_cache_dying()
> which is under the slab_mutex protection.  So I think there is no problem.

I'm sorry, I haven't noticed that you've fixed the race in v2.
But then we can probably drop the WARN() and resetting the dying flag part, right?

And because it's a backport-only patch I'd try to make it smaller
(e.g. avoid introducing new helpers, etc) to simplify the back-porting to old kernels.
But it's up to you (and Andrew).

Please, feel free to add
Acked-by: Roman Gushchin <guro@fb.com>
after dropping the dying flag reset part.

Thank you!
