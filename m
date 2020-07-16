Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FE4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254B32076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="a4ynSMFL";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="cebX6dGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgGPPrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:47:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56824 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728725AbgGPPq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:46:59 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06GFfWKR011044;
        Thu, 16 Jul 2020 08:46:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=06p+W+yjFcORm2TLAhgXRa6wsJY9vERXh+SCRYuoo9I=;
 b=a4ynSMFLSozZLo82Zy0iep5yMUgFMWDQCBW9O51p8DwtbTm6aZs/gLTQDLJuOLnWN9Sh
 uC9LhXn5k0KEQCuBTyxqB3B+ZFmdozn675y+8In4vnwrZsKta2GTBtk+3E1MB5vSXzPr
 oTR7CaJjwG72tsNLxEKjrzYae307LfVnn+0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32a43f5w2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Jul 2020 08:46:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 16 Jul 2020 08:46:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEVGh7LrQ0n7pxUPomvjezFK6AHo7IyQKbJ4rKBBQjP2nSlYizbw9I4+xud7ISdQH6jbup/HdbfAIOgaz5aYDkzlFvntw3Hj5cicHXFkv3140DS/1UBJi+hCMj1cSS3r84vJmszMKwrW6H4An60kdifXjByceYsplR9E1m7Zd2nS5plh+vSqwmV/RgQ4MP8fHWFtTYjlRjw2HVngFY5YW6W2YIhWCL8QGssqh2xb28vn28QsbERon96rNt6gfhbVRqJx62tyineuKc8R7Wtfr1h9AXTutCEchZXlZwNQUg8ipXMSsyvOK4CpwPrlf6l7276BTyi+kMxVB/RTeFdcMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06p+W+yjFcORm2TLAhgXRa6wsJY9vERXh+SCRYuoo9I=;
 b=JsWneYzZlDxieY9OMTLxkuxfQW9AaZrFY1KgZRf6xZygOLqzVgKIm49ykxOoTePORoEJoXqyI6WMkDHGGjg1JKdY+kSM+56MKghZ9KBOrF0AlnasV6RyPAQ9fv6AwHN/dNkb9NnzRo22GJvijZXNuY2D1L+vu9HuLy4ngjxCkbArXkFRrE9MGLbTm5Wx4bkFshSjH4XJFAdndRdJnyiT4iy39dS9XZuac5/fQ7K/oxt9Zp5uRSoa2l8oMPMUs69XkuEH3g9oLMvR+RrAVEh+qgy5dsZqu5w8OnD6Kz5iGu5tLL/Ow4mqCpq3gs4INL4sIAgBnOjKHDnGeM3ygJe+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06p+W+yjFcORm2TLAhgXRa6wsJY9vERXh+SCRYuoo9I=;
 b=cebX6dGvF5qowG+kZFt2SvlLYfOThqNUMgFWCjTRMt5lbXk6VmPsNuo3RniCKIfK9Or0V4peULXA8NwLEMSFpjIFwN2HO50eZrHqq3wQNmkhdjYP4bH63xADPB73XxK7aQx2KQSrh+ZUVlTayUU46t7yowWJW42mFWavXEmcOWQ=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3158.namprd15.prod.outlook.com (2603:10b6:a03:104::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 15:46:42 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 15:46:42 +0000
Date:   Thu, 16 Jul 2020 08:46:33 -0700
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
Message-ID: <20200716154633.GA15421@carbon.DHCP.thefacebook.com>
References: <20200715165023.29919-1-songmuchun@bytedance.com>
 <20200715175432.GA6314@carbon.lan>
 <CAMZfGtVupfg+WiXBvTsnXTZ=bgHxaztEFP1cQ8hnCfXmCUV=gw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtVupfg+WiXBvTsnXTZ=bgHxaztEFP1cQ8hnCfXmCUV=gw@mail.gmail.com>
X-ClientProxiedBy: BY5PR17CA0071.namprd17.prod.outlook.com
 (2603:10b6:a03:167::48) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:169b) by BY5PR17CA0071.namprd17.prod.outlook.com (2603:10b6:a03:167::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.19 via Frontend Transport; Thu, 16 Jul 2020 15:46:41 +0000
X-Originating-IP: [2620:10d:c090:400::5:169b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8688fba-eb45-4593-6a38-08d8299f6f4c
X-MS-TrafficTypeDiagnostic: BYAPR15MB3158:
X-Microsoft-Antispam-PRVS: <BYAPR15MB31586151B14029F79CB345A8BE7F0@BYAPR15MB3158.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+Y8rHYacoOwCIgOH2VWtfMvoIlMy+G1TUjKy9GCv5fHG5XRHFWnW6bP5X53/Xyy+XxQTHuoRtbRgJWKDtVwqb51nJArIwyyOuIM+wH2L9N8mlrgHg/eN0PQYNSGeaEX0bVHgouug2/QQgXmdr1N5UGFqBLPdsn70fJaBZAQmR7PfKfkxVPzkAmMWLBy1XpJSKTYvOmnwuG3p3fhXZQlujOx2oZ+QpeIGaNMIheFy7qIGqkPcM8+A4F6jMPN4l9VjKGnQIzBcr5skxgWqFOdyp9TP4C35J5a09n7r9J8x9zSHukv9J2PQ0/BsEYPdxqQ1ldwsBENAc9KqhqRXMD8Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(136003)(376002)(346002)(366004)(316002)(6506007)(55016002)(33656002)(1076003)(478600001)(86362001)(4326008)(5660300002)(16526019)(186003)(66556008)(9686003)(66946007)(52116002)(66476007)(6666004)(54906003)(53546011)(8676002)(2906002)(7416002)(7696005)(8936002)(83380400001)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: i5FsU+ksWkYFrZf9KeXbdOtzXu5pf60ms6gQ1aX6549oTFAeChDaduhpmQ4mWAMlAWzHYxWbFaGQIXnMFe9cvqvoguKCAQzMH64sJh3UM1VvZQCoJMgXNM7g5wIT9DHJLGsAhnfX2gUz9gPm84UE8JAtZNZAMWS92YZcgmI9Gd3OTJMyGq9lu2TgPF5MBEAJF08CQdf/MIqci3RPHWFubBgSvWGDMq3wcTTQlV9PR93bXowfxLoDI+yK7+haN19CSG0v/0Sh6z5t/lfbVXDTtOE1hpdW8qKmEkDfeaBZIUfvGhFTDANmWGzygFcvvCGXiKwDSs5TJYbLeBfpJTEKiU2sVO7W4kcy3SX7pilSdQgMPWfR/85DldEbX13bYXlNC6Qb24H+rRgx17nh21dIgeqpFiwFrg5MGXECJBGExxEPMIPCCTQZcuq6tY9nP9sirxheHDo1Wom4A4Uf0Ccd2EgLDK+VOJ5WUjOwW4mW6tVxhvhRcV4beq4oWELL18nXrclCbTq/+IMKC2VzU4IFjQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d8688fba-eb45-4593-6a38-08d8299f6f4c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 15:46:42.1190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8gRhTZPEOXGF2lk2vrGKRq8CSF+aYVnOm4dhPodErEVtvFehEuDFoXdY3JupVhP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3158
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_07:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=1 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160118
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 01:07:02PM +0800, Muchun Song wrote:
> On Thu, Jul 16, 2020 at 1:54 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Thu, Jul 16, 2020 at 12:50:22AM +0800, Muchun Song wrote:
> > > If the kmem_cache refcount is greater than one, we should not
> > > mark the root kmem_cache as dying. If we mark the root kmem_cache
> > > dying incorrectly, the non-root kmem_cache can never be destroyed.
> > > It resulted in memory leak when memcg was destroyed. We can use the
> > > following steps to reproduce.
> > >
> > >   1) Use kmem_cache_create() to create a new kmem_cache named A.
> > >   2) Coincidentally, the kmem_cache A is an alias for kmem_cache B,
> > >      so the refcount of B is just increased.
> > >   3) Use kmem_cache_destroy() to destroy the kmem_cache A, just
> > >      decrease the B's refcount but mark the B as dying.
> > >   4) Create a new memory cgroup and alloc memory from the kmem_cache
> > >      B. It leads to create a non-root kmem_cache for allocating memory.
> > >   5) When destroy the memory cgroup created in the step 4), the
> > >      non-root kmem_cache can never be destroyed.
> > >
> > > If we repeat steps 4) and 5), this will cause a lot of memory leak.
> > > So only when refcount reach zero, we mark the root kmem_cache as dying.
> > >
> > > Fixes: 92ee383f6daa ("mm: fix race between kmem_cache destroy, create and deactivate")
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > > ---
> > >
> > > changelog in v2:
> > >  1) Fix a confusing typo in the commit log.
> >
> > Ok, now I see the problem. Thank you for fixing the commit log!
> >
> > >  2) Remove flush_memcg_workqueue() for !CONFIG_MEMCG_KMEM.
> > >  3) Introduce a new helper memcg_set_kmem_cache_dying() to fix a race
> > >     condition between flush_memcg_workqueue() and slab_unmergeable().
> > >
> > >  mm/slab_common.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++-------
> > >  1 file changed, 47 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > > index 8c1ffbf7de45..c4958116e3fd 100644
> > > --- a/mm/slab_common.c
> > > +++ b/mm/slab_common.c
> > > @@ -258,6 +258,11 @@ static void memcg_unlink_cache(struct kmem_cache *s)
> > >               list_del(&s->memcg_params.kmem_caches_node);
> > >       }
> > >  }
> > > +
> > > +static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
> > > +{
> > > +     return is_root_cache(s) && s->memcg_params.dying;
> > > +}
> > >  #else
> > >  static inline int init_memcg_params(struct kmem_cache *s,
> > >                                   struct kmem_cache *root_cache)
> > > @@ -272,6 +277,11 @@ static inline void destroy_memcg_params(struct kmem_cache *s)
> > >  static inline void memcg_unlink_cache(struct kmem_cache *s)
> > >  {
> > >  }
> > > +
> > > +static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
> > > +{
> > > +     return false;
> > > +}
> > >  #endif /* CONFIG_MEMCG_KMEM */
> > >
> > >  /*
> > > @@ -326,6 +336,13 @@ int slab_unmergeable(struct kmem_cache *s)
> > >       if (s->refcount < 0)
> > >               return 1;
> > >
> > > +     /*
> > > +      * If the kmem_cache is dying. We should also skip this
> > > +      * kmem_cache.
> > > +      */
> > > +     if (memcg_kmem_cache_dying(s))
> > > +             return 1;
> > > +
> > >       return 0;
> > >  }
> > >
> > > @@ -886,12 +903,15 @@ static int shutdown_memcg_caches(struct kmem_cache *s)
> > >       return 0;
> > >  }
> > >
> > > -static void flush_memcg_workqueue(struct kmem_cache *s)
> > > +static void memcg_set_kmem_cache_dying(struct kmem_cache *s)
> > >  {
> > >       spin_lock_irq(&memcg_kmem_wq_lock);
> > >       s->memcg_params.dying = true;
> > >       spin_unlock_irq(&memcg_kmem_wq_lock);
> > > +}
> > >
> > > +static void flush_memcg_workqueue(struct kmem_cache *s)
> > > +{
> > >       /*
> > >        * SLAB and SLUB deactivate the kmem_caches through call_rcu. Make
> > >        * sure all registered rcu callbacks have been invoked.
> > > @@ -923,10 +943,6 @@ static inline int shutdown_memcg_caches(struct kmem_cache *s)
> > >  {
> > >       return 0;
> > >  }
> > > -
> > > -static inline void flush_memcg_workqueue(struct kmem_cache *s)
> > > -{
> > > -}
> > >  #endif /* CONFIG_MEMCG_KMEM */
> > >
> > >  void slab_kmem_cache_release(struct kmem_cache *s)
> > > @@ -944,8 +960,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
> > >       if (unlikely(!s))
> > >               return;
> > >
> > > -     flush_memcg_workqueue(s);
> > > -
> > >       get_online_cpus();
> > >       get_online_mems();
> > >
> > > @@ -955,6 +969,32 @@ void kmem_cache_destroy(struct kmem_cache *s)
> > >       if (s->refcount)
> > >               goto out_unlock;
> > >
> > > +#ifdef CONFIG_MEMCG_KMEM
> > > +     memcg_set_kmem_cache_dying(s);
> > > +
> > > +     mutex_unlock(&slab_mutex);
> >
> > Hm, but in theory s->refcount can be increased here?
> 
> I have tried my best to read all the codes that operate on s->refcount.
> There is only one place which increases the s->refcount, it is the
> __kmem_cache_alias(). If the kmem cache is dying, the slab_unmergeable()
> can never return true for the dying kmem cache because it is the same slab_mutex
> protection, so I think that there is not a problem, right?

So the problem is that you're checking s->refcount under slab_mutex,
then you're releasing the mutex and then set the dying bit. But nothing prevents
someone else to clone the kmem_cache on a different CPU as soon as you've released
the slab_mutex.

However, I think there is a simple solution for this problem.
Can you, please, check the following patch?

--
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 37d48a56431d..d6661e7af01e 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -326,6 +326,11 @@ int slab_unmergeable(struct kmem_cache *s)
 	if (s->refcount < 0)
 		return 1;
 
+#ifdef CONFIG_MEMCG_KMEM
+	if (s->memcg_params.dying)
+		return 1;
+#endif
+
 	return 0;
 }
 
@@ -888,9 +893,20 @@ static int shutdown_memcg_caches(struct kmem_cache *s)
 
 static void flush_memcg_workqueue(struct kmem_cache *s)
 {
-	spin_lock_irq(&memcg_kmem_wq_lock);
-	s->memcg_params.dying = true;
-	spin_unlock_irq(&memcg_kmem_wq_lock);
+	bool skip = false;
+
+	mutex_lock(&slab_mutex);
+	if (s->refcount == 1) {
+		spin_lock_irq(&memcg_kmem_wq_lock);
+		s->memcg_params.dying = true;
+		spin_unlock_irq(&memcg_kmem_wq_lock);
+	} else {
+		skip = true;
+	}
+	mutex_unlock(&slab_mutex);
+
+	if (skip)
+		return;
 
 	/*
 	 * SLAB and SLUB deactivate the kmem_caches through call_rcu. Make
-- 
2.26.2


--
> 
> > So it doesn't solve the problem completely, but makes it less probable, right?
> >
> > I wonder if it's possible to (additionally) protect s->refcount with a
> > memcg_kmem_wq_lock, so that we can check it in the context of flush_memcg_workqueue()?
> >
> > > +
> > > +     put_online_mems();
> > > +     put_online_cpus();
> > > +
> > > +     flush_memcg_workqueue(s);
> > > +
> > > +     get_online_cpus();
> > > +     get_online_mems();
> > > +
> > > +     mutex_lock(&slab_mutex);
> > > +
> > > +     if (WARN(s->refcount,
> > > +              "kmem_cache_destroy %s: Slab cache is still referenced\n",
> > > +              s->name)) {
> > > +             /*
> > > +              * Reset the dying flag setted by memcg_set_kmem_cache_dying().
> > > +              */
> > > +             s->memcg_params.dying = false;
> > > +             goto out_unlock;
> > > +     }
> > > +#endif
> > > +
> > >       err = shutdown_memcg_caches(s);
> > >       if (!err)
> > >               err = shutdown_cache(s);
> > > --
> > > 2.11.0
> > >
> >
> > Other than the problem above your patch looks really good to me, however we should
> > be really careful here, as it should in theory be back-ported to a big number
> > of old stable kernels. And because it's (hopefully) fixed in 5.9, it's a backport-only
> > patch.
> >
> > So I wonder if we can mitigate the problem by disabling cache sharing for some
> > specific kmem_caches instead? Like for all with SLAB_ACCOUNT and maybe for all except
> > a hard-coded list (if kmem accounting is enabled). Do you mind sharing any details
> > on how this problem reveals itself in the real life?
> 
> One day I debug another problem, coincidentally I executed the
> following command:
> 
>      cat /sys/kernel/debug/memcg_slabinfo | grep deact
> 
> And I found an interesting thing, a lot of non-root kmem_cache's
> active_objs is zero.
> But why are they not destroyed? So I launched a detailed
> investigation. Finally I found
> out that the reason is that we mark the root kmem_cache as dying
> incorrectly. I have
> applied this patch on our server for several weeks. And this problem
> has disappeared.

Got it, it's a great catch!

Thank you!

Roman
