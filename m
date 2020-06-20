Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43702C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 00:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9BA218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 00:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oj4HEg56";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PzcwSkaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbgFTA0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 20:26:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59842 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730293AbgFTA0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 20:26:19 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05K00rCq001047;
        Fri, 19 Jun 2020 17:25:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=zhIMb/HNVPHbKZXkaSEt8ccTlSKPnuIm9EbVD3hNhvY=;
 b=oj4HEg56MQUl8+ltXTPtR57E2S1BAinNFKowsN2jSvsUTUpC1xQsggR9EP51pLKgQ0cK
 68LcAkQbRjVfwchI0z/9pQ3/Jx7VPm025mAeyDFt7tdbd0qtxBBQbuKhdtNhAErL5Ori
 Y+U8PGwfVYQpXNf30ZGifv4NtaXyJddga9c= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31rqwqxyjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Jun 2020 17:25:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 17:25:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkccsLDRU6GZCSMqUrUlBGcQ0kOlPvMwGXB6dxSp+0YPpaS61pq4e8gWxjuzeHlajRJ4ExAG6RfEIGVbzd97R/9oFSFaqMFhN/h2RKmaqC8Oc6Ejy0M1kSVKOgSuIPrn4rO5OTWFkPC/QcYlgq39zTRkaX3zF6jTIv1yUajAmgmw6iMMOoqbzY1g4ln+AWD7W0EBY/3KYPlCdaWh7hlz9ERO9QrwYub4DjMostJDWnSItRfXvEH+cK9nvL/ozrJ1yHTJqioBglwyx50wkXsHjVLmhGdeu2d1qcQkGN9h1yQymaBedBsJpKpD3527qOAKearpBIGuVhrg4S77UEvBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhIMb/HNVPHbKZXkaSEt8ccTlSKPnuIm9EbVD3hNhvY=;
 b=QEecx14NF0WCt//qAhKgQWRn4maCtXlFplqH6QQR3B0GyDY9Zu42yRPR8E/cRIAWnhGMJcHc57UYoSiEQCA43O1Rz1xsRN0Ej32Hu61qY13KSzjgy2lohIUlNND0ReLyAAbJvVnoN5FwSxnLrDyfzvE161jhDeNs3H6TF1qtK2QJfNGo/BPtI16w77XTMfyH6CtjtT8bohm+yK84AqxP6hOHlI3cz7S6Yrjcbq9UsuUjVplxMDN2CF20KSBUdj8ViuVJij6ybbIdcj+uXnOPgWtK+lYoha7pRg0kT1hT6l2/xtal4kr955JZuL7zx+B33vkaTMYn0HafGXeCyjBSfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhIMb/HNVPHbKZXkaSEt8ccTlSKPnuIm9EbVD3hNhvY=;
 b=PzcwSkaI5vQSwfvIUAMb4+pR+OedQK93fyRE4NyDDSFLIpLU8/hpECHbZJAPiuFnrl+J+8RQ6Zj1SW+vDtUy6KlUNPmIGVHj3TZVvNSJpg0Z7xaT+ImUaN0qY+M3Ra7SwvKzH2RhTcAjCi3Xz1+HnXHpQ8mTyp4CgzC7WPZrCuo=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3447.namprd15.prod.outlook.com (2603:10b6:a03:107::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Sat, 20 Jun
 2020 00:25:16 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.021; Sat, 20 Jun 2020
 00:25:16 +0000
Date:   Fri, 19 Jun 2020 17:25:13 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 07/19] mm: memcg/slab: allocate obj_cgroups for
 non-root slab pages
Message-ID: <20200620002513.GD237539@carbon.dhcp.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
 <20200608230654.828134-8-guro@fb.com>
 <CALvZod56d1RDJscJY2mRrhXr7uBn4bxJobuq_xRjDPQUHfWm5A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod56d1RDJscJY2mRrhXr7uBn4bxJobuq_xRjDPQUHfWm5A@mail.gmail.com>
X-ClientProxiedBy: BYAPR07CA0056.namprd07.prod.outlook.com
 (2603:10b6:a03:60::33) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:384b) by BYAPR07CA0056.namprd07.prod.outlook.com (2603:10b6:a03:60::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Sat, 20 Jun 2020 00:25:15 +0000
X-Originating-IP: [2620:10d:c090:400::5:384b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f5c7b37-f1e7-46ba-e54d-08d814b067d2
X-MS-TrafficTypeDiagnostic: BYAPR15MB3447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3447B3E4EC59683038C30FFDBE990@BYAPR15MB3447.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0440AC9990
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmYMEgn32ZaXilfBnZG7/7rsErNSQoHetUcydUV98c57AQ5tOAnNwvyan515PMeRtbUsJe9EzvhXKPflQVW6QykKDT2R2lTaC9OMQiHK4yd9vt2ElLI/rJwUv0ZhubK4NhOGMkxzlNxVmTpi/9Vz4Uu1WoAadkcXEOZtpop6R3yqPXC+wAi4K8ywQYw+i004R3OOozoRDNKGvKLpvuEDUEg76ea1HUouGcedkGo6EMvXp8iSvyV+BJBi08NRFDCG7TO/khAcwHq1+HFsJ3SdyfgMkCptXxB/draDbWbUsxv2OaCP52qcs4V6g+hEMFNfYHVYOIAjhIIpmTqMeSSVJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(396003)(39860400002)(366004)(136003)(66946007)(66476007)(55016002)(478600001)(86362001)(186003)(16526019)(5660300002)(66556008)(9686003)(8676002)(4326008)(1076003)(8936002)(33656002)(83380400001)(52116002)(2906002)(54906003)(316002)(6506007)(6916009)(53546011)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: XmWw7Wrwp3QGtagwYfSNV/L4jHG1r/XTS4/4ys3IypXe6a1z5bXXlYwLeekaFWcBjJ+iMTuIW2+vsi+dPMy4aj9PaTCdhj9rrxjqpv5C1yb1yWlOxLtEuJVjxjLoXJd+y32fSqxOviaz/78QSjkujFGfvPD3a3GqxJVIq4HjMLWATK2+a+2G7755fx6ka5UJ8xkFWn9MyzYunw6+DC/LXeNqs5r1zzpIgi6QpI7QqARuwlavcw0+Kx0sIecXJkU5hcIGTW+D737M1Xc2RWctJ/vBla9ZPfL2IC3vxQeVl7E8pL5Lm2Vnm/P73dBtciuvpU0Xl/hE+SfebDxePuVPNqsqeNj0mzmfdU7HqkNglH5Qzt+6fiRUXNYn2PsvostwzjhPBDnG1fq0WTnrIQQbgkm2vT2PFoior2DmjNqU/CljE0Uxj0yPOnppt0UxtkrhPGAHIT36DimqC6WQwG586/j6eXuKNNIixUxe3akEBiiZ0Q6B18oJMel835jxAQ0ZrKS7Abawqih3aU2XklfZpw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5c7b37-f1e7-46ba-e54d-08d814b067d2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2020 00:25:16.4264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYWEq5Lc9qNKtlxQSmxSYZY8uMZqO0eJ09bXtvH/jkK/T3d+MKo61Rl8hZs5e7Zd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3447
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_22:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=1 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxlogscore=999
 cotscore=-2147483648 spamscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190170
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 09:36:16AM -0700, Shakeel Butt wrote:
> On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > Allocate and release memory to store obj_cgroup pointers for each
> > non-root slab page. Reuse page->mem_cgroup pointer to store a pointer
> > to the allocated space.
> >
> > To distinguish between obj_cgroups and memcg pointers in case
> > when it's not obvious which one is used (as in page_cgroup_ino()),
> > let's always set the lowest bit in the obj_cgroup case.
> >
> 
> I think the commit message should talk about the potential overhead
> (i.e an extra pointer for each object) along with the justifications
> (i.e. less internal fragmentation and potentially more savings than
> the overhead).

How about adding the following chunk? I don't like forward links in
commit messages, so maybe putting it into the cover letter?

This commit temporarily increases the memory footprint of the kernel memory
accounting. To store obj_cgroup pointers we'll need a place for an
objcg_pointer for each allocated object. However, the following patches
in the series will enable sharing of slab pages between memory cgroups,
which will dramatically increase the total slab utilization. And the final
memory footprint will be significantly smaller than before.

> 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  include/linux/mm_types.h |  5 +++-
> >  include/linux/slab_def.h |  6 +++++
> >  include/linux/slub_def.h |  5 ++++
> >  mm/memcontrol.c          | 17 +++++++++++---
> >  mm/slab.h                | 49 ++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 78 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 64ede5f150dc..0277fbab7c93 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -198,7 +198,10 @@ struct page {
> >         atomic_t _refcount;
> >
> >  #ifdef CONFIG_MEMCG
> > -       struct mem_cgroup *mem_cgroup;
> > +       union {
> > +               struct mem_cgroup *mem_cgroup;
> > +               struct obj_cgroup **obj_cgroups;
> > +       };
> >  #endif
> >
> >         /*
> > diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
> > index abc7de77b988..ccda7b9669a5 100644
> > --- a/include/linux/slab_def.h
> > +++ b/include/linux/slab_def.h
> > @@ -114,4 +114,10 @@ static inline unsigned int obj_to_index(const struct kmem_cache *cache,
> >         return reciprocal_divide(offset, cache->reciprocal_buffer_size);
> >  }
> >
> > +static inline int objs_per_slab_page(const struct kmem_cache *cache,
> > +                                    const struct page *page)
> > +{
> > +       return cache->num;
> > +}
> > +
> >  #endif /* _LINUX_SLAB_DEF_H */
> > diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> > index 30e91c83d401..f87302dcfe8c 100644
> > --- a/include/linux/slub_def.h
> > +++ b/include/linux/slub_def.h
> > @@ -198,4 +198,9 @@ static inline unsigned int obj_to_index(const struct kmem_cache *cache,
> >         return __obj_to_index(cache, page_address(page), obj);
> >  }
> >
> > +static inline int objs_per_slab_page(const struct kmem_cache *cache,
> > +                                    const struct page *page)
> > +{
> > +       return page->objects;
> > +}
> >  #endif /* _LINUX_SLUB_DEF_H */
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 7ff66275966c..2020c7542aa1 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -569,10 +569,21 @@ ino_t page_cgroup_ino(struct page *page)
> >         unsigned long ino = 0;
> >
> >         rcu_read_lock();
> > -       if (PageSlab(page) && !PageTail(page))
> > +       if (PageSlab(page) && !PageTail(page)) {
> >                 memcg = memcg_from_slab_page(page);
> > -       else
> > -               memcg = READ_ONCE(page->mem_cgroup);
> > +       } else {
> > +               memcg = page->mem_cgroup;
> > +
> > +               /*
> > +                * The lowest bit set means that memcg isn't a valid
> > +                * memcg pointer, but a obj_cgroups pointer.
> > +                * In this case the page is shared and doesn't belong
> > +                * to any specific memory cgroup.
> > +                */
> > +               if ((unsigned long) memcg & 0x1UL)
> > +                       memcg = NULL;
> > +       }
> > +
> >         while (memcg && !(memcg->css.flags & CSS_ONLINE))
> >                 memcg = parent_mem_cgroup(memcg);
> >         if (memcg)
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 8a574d9361c1..a1633ea15fbf 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -319,6 +319,18 @@ static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
> >         return s->memcg_params.root_cache;
> >  }
> >
> > +static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
> > +{
> > +       /*
> > +        * page->mem_cgroup and page->obj_cgroups are sharing the same
> > +        * space. To distinguish between them in case we don't know for sure
> > +        * that the page is a slab page (e.g. page_cgroup_ino()), let's
> > +        * always set the lowest bit of obj_cgroups.
> > +        */
> > +       return (struct obj_cgroup **)
> > +               ((unsigned long)page->obj_cgroups & ~0x1UL);
> > +}
> > +
> >  /*
> >   * Expects a pointer to a slab page. Please note, that PageSlab() check
> >   * isn't sufficient, as it returns true also for tail compound slab pages,
> > @@ -406,6 +418,26 @@ static __always_inline void memcg_uncharge_slab(struct page *page, int order,
> >         percpu_ref_put_many(&s->memcg_params.refcnt, nr_pages);
> >  }
> >
> > +static inline int memcg_alloc_page_obj_cgroups(struct page *page,
> > +                                              struct kmem_cache *s, gfp_t gfp)
> > +{
> > +       unsigned int objects = objs_per_slab_page(s, page);
> > +       void *vec;
> > +
> > +       vec = kcalloc(objects, sizeof(struct obj_cgroup *), gfp);
> 
> Should the above allocation be on the same node as the page?

Yeah, it's a clever idea. The following patch should do the trick.
Andrew, can you, please, squash this in?

Thank you!


diff --git a/mm/slab.h b/mm/slab.h
index 0a31600a0f5c..2a036eefbd7e 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -233,7 +233,8 @@ static inline int memcg_alloc_page_obj_cgroups(struct page *page,
        unsigned int objects = objs_per_slab_page(s, page);
        void *vec;
 
-       vec = kcalloc(objects, sizeof(struct obj_cgroup *), gfp);
+       vec = kcalloc_node(objects, sizeof(struct obj_cgroup *), gfp,
+                          page_to_nid(page));
        if (!vec)
                return -ENOMEM;
 
