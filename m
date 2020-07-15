Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B8CC433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B40402065E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jlaH/vNI";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RM+M6cSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgGOQZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:25:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35230 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726820AbgGOQZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:25:11 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FGLJiV016990;
        Wed, 15 Jul 2020 09:24:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=AKMscFPEjRfOxzixkQ5UNZO3+oJieTzJLIDRhBAyu58=;
 b=jlaH/vNIdPS1w7KouKH+ZL+B90hdtkuvMxltWe8hv+3UTRRc4ntJFX3xRBh32Hr4AoMj
 mO/WTn51bdFSFcqgN2MRwhyr7IGEHOYHY4FOrSaFj9JRat8KEtpLOJ/zWtVHErhGgcTl
 rULZiHK2qQrQjIyQAmx1Al1Adl8VQnOGTL0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32a43f0dm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Jul 2020 09:24:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 15 Jul 2020 09:24:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQ1H59O19d30lDC9h4rKsCr9wC3VN1cX6Qu7N35RMLbfHEvQ3993Q8YgP0NZRSuVjhBG5hBiMTnr6BcjuOH9p85vcJ5bhgpNM0HlnhGg6oMHdnR1AxBnOH7eKvqw+hN6l8WCU2uL0kXbP3G5dbIunOQjvQJuShyhonpg+QS2J+JiCFNxSFJoxz0cOLFmBhy6DroosbLE9gyl/Oo7GO7cUfvNLvLF7+vD38sul3B1PQiiwTAgo2bwou9ZPMbiB8HQ7dBIhJLOOzVL0pswT6Egfd4Kb/NUBNg0j05ofUKahV2gwIc85/3PazR6cbaH2CGplfLHxxVyXWCu+ZPHEGpT4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKMscFPEjRfOxzixkQ5UNZO3+oJieTzJLIDRhBAyu58=;
 b=gWLyBJVtGIRYDzbHiY3hGu9ysab0V2Brw/GEXVlIGR+f12wSV6I7OoNyFPPr2gbtTk1wYsEo4U4re7V4oLPZyyb8Zs2anttpYE5RVHw9hTicO8QG4m+/e9R36ek5YVOVzGGFS/PRBlEL0r0e0Z7eA/vdvdJu1+SB8Wds5ptnl1t4RIAdxtA/NLzWY+aHjhk29wsYgUl16jVWq4z+dG7gmgkdFAtVNmRgffEIsL/gPEk6M8dXgnsAAP9cKIIFiWWckVZt+1Zf/DBxh6wMRfMDJvXDIc1lBJjYAU1SUW0Gz7lEMerHVJOyNDDdhWS/5csESO0Q43GEFM1ajuUylWLSkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKMscFPEjRfOxzixkQ5UNZO3+oJieTzJLIDRhBAyu58=;
 b=RM+M6cSSVVpbA6a0pNN5DiHOqjCNsxYtixKa+bYtaLSVMnCNlmJ93PEOS3DcHVRew0k8+uXb5a3omPuXhrlFWb+J8LJkVuWi7rVGIhOMdKLhQwg7NfkS8aQIpnmKa4ixtN6lwFz5EZzdTfKaj8sotU4ZRSM5QeuykRyX08BxRGc=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3603.namprd15.prod.outlook.com (2603:10b6:a03:1f7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 15 Jul
 2020 16:24:52 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3195.018; Wed, 15 Jul 2020
 16:24:52 +0000
Date:   Wed, 15 Jul 2020 09:24:45 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Muchun Song <songmuchun@bytedance.com>, <cl@linux.com>,
        <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <shakeelb@google.com>
Subject: Re: [PATCH v5.4.y, v4.19.y] mm: memcg/slab: fix memory leak at
 non-root kmem_cache destroy
Message-ID: <20200715162445.GA4003@carbon.lan>
References: <20200707062754.8383-1-songmuchun@bytedance.com>
 <3d06418e-e75c-e7b8-91cd-ba56283045be@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d06418e-e75c-e7b8-91cd-ba56283045be@suse.cz>
X-ClientProxiedBy: MN2PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:208:120::39) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c091:480::1:c66) by MN2PR10CA0026.namprd10.prod.outlook.com (2603:10b6:208:120::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend Transport; Wed, 15 Jul 2020 16:24:50 +0000
X-Originating-IP: [2620:10d:c091:480::1:c66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d99cd9b7-94e9-4236-68b2-08d828db9a70
X-MS-TrafficTypeDiagnostic: BY5PR15MB3603:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3603338154CEF46E63C046C6BE7E0@BY5PR15MB3603.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QyyFjDrNPH4oJemLE+ISkt8zgsM9Z6CrllDnmlrp6JSYLqR0tV1pvJg48YcLAkfXULNZq7OioAQ1jkWrO8+Gt348L2/Lp6y+YdgJvclPfes9pO4vbo6I9o8Wz/K7Re4nAmhf9JoXgCbLW5d2OxPD1x1lPTck3qlHhf2zvmicaeoIObTzK+xLYAiIA2LaGDxPZbQEjXrXI851/pn/EOWnRi0I2WfYHLLWis09HQuGWOmPb3VYChtGV8RmVYoEcods3FWgO2qK5Fpa7B1hXRAoiXPut+puOUNWwMrgsIxVyaDMF+xJn8mrtIqfNci7XVFdHEsaLQJDo16kKLIROumTsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(366004)(39860400002)(136003)(396003)(316002)(33656002)(55016002)(6666004)(66556008)(8886007)(66946007)(9686003)(66476007)(478600001)(86362001)(6916009)(83380400001)(5660300002)(36756003)(4326008)(186003)(2906002)(6506007)(7696005)(1076003)(8936002)(8676002)(7416002)(16526019)(52116002)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Q64SgeHyZghmUcB7uYh6L87ZzDs9RKQTSrCvVQDTvZlBYwVQOl2SQsByP3y05UCTVTyq5mjohtc7Sn2rhnpB7hoKkWxg1Up4kVC+knnX2xcw3Tlh11/MpGwkLIIGmKQObQK/CwJrr7zX/xFo1dojDxo7M74TOkc71MoAgd3puH2p/R/oRnAC3j5wAPnxjk/QrQrOUJ9ap42ypn1cv2jJf5uJfG0v9KhYk5e+W/OnUMa/OIaWHG+Q5yN4kRXG3tNTkAhjRB3OGFN5lR5ie9Ewp0sP3Dl5AI5b8aJCZ3w2CyBJeSGrmi/H/KmuAXySuNf1Kan9JxWMCIKj7OzBPh92j28ZYSTjn3++QMsBgZoM9eHkhM2RUzxW+TF2kh8/NpE85MsrHNCjJIEYZA3ttFDfmFJbgQuM36i5QSNtWcy40RWPUZwsqmhbK4fnzIDnDqlM43gVXjHR6X5rrEWhw0jZ8pGJIEVNwUX/ntx8bOzWh8JqIrjIXi05lKy+IvytX0KinhuxxoHLkBYbe4VBNAACrQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d99cd9b7-94e9-4236-68b2-08d828db9a70
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 16:24:52.8911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Q9yTHA3HNRi96V9ibgjGdhx/V9Sbvc1O0djkfAuvZvvL8kJmoZ6BKydYArp0kXQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3603
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 impostorscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=1 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150129
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 01:32:00PM +0200, Vlastimil Babka wrote:
> On 7/7/20 8:27 AM, Muchun Song wrote:
> > If the kmem_cache refcount is greater than one, we should not
> > mark the root kmem_cache as dying. If we mark the root kmem_cache
> > dying incorrectly, the non-root kmem_cache can never be destroyed.
> > It resulted in memory leak when memcg was destroyed. We can use the
> > following steps to reproduce.
> > 
> >   1) Use kmem_cache_create() to create a new kmem_cache named A.
> >   2) Coincidentally, the kmem_cache A is an alias for kmem_cache B,
> >      so the refcount of B is just increased.
> >   3) Use kmem_cache_destroy() to destroy the kmem_cache A, just
> >      decrease the B's refcount but mark the B as dying.
> >   4) Create a new memory cgroup and alloc memory from the kmem_cache
> >      A. It leads to create a non-root kmem_cache for allocating.
> >   5) When destroy the memory cgroup created in the step 4), the
> >      non-root kmem_cache can never be destroyed.

Hello, Muchun!

If the scenario above is accurate, it means that somebody is allocating
from the kmem_cache A (or it's memcg counterparts, doesn't matter) after
calling kmem_cache_destroy()? If so, it's an API violation, and the following
memory leak is a non-issue on the slab side. No one should allocate memory
after calling kmem_cache_destroy(). It has to be called after all outstanding
allocations are freed, and it should be literally the last operation
with the kmem_cache.

Kmem_cache aliasing/sharing, as well as memcg accounting implementation are
implementation details and should not affect the picture.

I wonder, did you see the problem in the wild? How does it look like?
Which kmem_cache is involved? Etc.

BTW, Vlastimil is absolutely right about stable backports and rework planned
for 5.9, but let's figure out the problem first.

Thank you!

> > 
> > If we repeat steps 4) and 5), this will cause a lot of memory leak.
> > So only when refcount reach zero, we mark the root kmem_cache as dying.
> > 
> > Fixes: 92ee383f6daa ("mm: fix race between kmem_cache destroy, create and deactivate")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> CC Roman, who worked in this area recently.
> 
> Also why is this marked "[PATCH v5.4.y, v4.19.y]"? Has it been fixed otherwise
> in 5.5+ ?
> 
> > ---
> >  mm/slab_common.c | 43 +++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 41 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 8c1ffbf7de45..83ee6211aec7 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -258,6 +258,11 @@ static void memcg_unlink_cache(struct kmem_cache *s)
> >  		list_del(&s->memcg_params.kmem_caches_node);
> >  	}
> >  }
> > +
> > +static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
> > +{
> > +	return is_root_cache(s) && s->memcg_params.dying;
> > +}
> >  #else
> >  static inline int init_memcg_params(struct kmem_cache *s,
> >  				    struct kmem_cache *root_cache)
> > @@ -272,6 +277,11 @@ static inline void destroy_memcg_params(struct kmem_cache *s)
> >  static inline void memcg_unlink_cache(struct kmem_cache *s)
> >  {
> >  }
> > +
> > +static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
> > +{
> > +	return false;
> > +}
> >  #endif /* CONFIG_MEMCG_KMEM */
> >  
> >  /*
> > @@ -326,6 +336,13 @@ int slab_unmergeable(struct kmem_cache *s)
> >  	if (s->refcount < 0)
> >  		return 1;
> >  
> > +	/*
> > +	 * If the kmem_cache is dying. We should also skip this
> > +	 * kmem_cache.
> > +	 */
> > +	if (memcg_kmem_cache_dying(s))
> > +		return 1;
> > +
> >  	return 0;
> >  }
> >  
> > @@ -944,8 +961,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >  	if (unlikely(!s))
> >  		return;
> >  
> > -	flush_memcg_workqueue(s);
> > -
> >  	get_online_cpus();
> >  	get_online_mems();
> >  
> > @@ -955,6 +970,30 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >  	if (s->refcount)
> >  		goto out_unlock;
> >  
> > +#ifdef CONFIG_MEMCG_KMEM
> > +	mutex_unlock(&slab_mutex);
> > +
> > +	put_online_mems();
> > +	put_online_cpus();
> > +
> > +	flush_memcg_workqueue(s);
> > +
> > +	get_online_cpus();
> > +	get_online_mems();
> > +
> > +	mutex_lock(&slab_mutex);
> > +
> > +	if (WARN(s->refcount,
> > +		 "kmem_cache_destroy %s: Slab cache is still referenced\n",
> > +		 s->name)) {
> > +		/*
> > +		 * Reset the dying flag setted by flush_memcg_workqueue().
> > +		 */
> > +		s->memcg_params.dying = false;
> > +		goto out_unlock;
> > +	}
> > +#endif
> > +
> >  	err = shutdown_memcg_caches(s);
> >  	if (!err)
> >  		err = shutdown_cache(s);
> > 
> 
