Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D5CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 22:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E015204EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 22:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lL03sSms";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="J6Qau7+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgEOWCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 18:02:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12704 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726228AbgEOWCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 18:02:05 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04FM1u77005490;
        Fri, 15 May 2020 15:01:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=F1AbqPWcACLY4kjPkXzwMU5tjuaPYG1qjQy3CC3l3M0=;
 b=lL03sSmsof+mO/e9UDZhG9h37CF4d7NLsqEhtzy0ND0AcwUmrRaYv6FsIrO2+vdzLpkH
 n9ss3y6mUBvuEFg/OXOtysj0uGDRd59HDT875p1iDQ0W1a7YoqSE27xfj1p7BvMTHjfV
 Iem+FxBTGrVycepM/gnB9jHuzNl79MtGhRE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3119kq02qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 May 2020 15:01:55 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 15 May 2020 15:01:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kccn/OHhZ3bzC6zex++Yl8vTIOHYijxY8xA3A57iapdtfhWZYvKuXTOH1TIa+hjzSFIDVLDQKh2d2B+cTlPtT9gacETDtkIpr/IloybZwnvccRkxm9xAqAKbvqWAFBnpY7097kknSjhgwWE47TZtUARmeTUk8AhdBtDsv2MjpDt2f2OyQ2S/6meG3o5k9s+/LAUIUcKeU7YzQwsRPmcYxiaPC2v/i0SaaCb+OzpOhUCS/e0t/1vpd17JiNNanR/ZlVa3eUygEN6OXQ0Haea/GAxHz0GPzQcmGr2mCbXA4AjZbepoBF9PhmrEE6Kyf41sqdEwanZ/Iydkw7IKyiQfWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1AbqPWcACLY4kjPkXzwMU5tjuaPYG1qjQy3CC3l3M0=;
 b=lPMeIOd+t22S0pqW5OJsvSSuxoOxnJOFJ2lou0v5ryJV63jS5dORJiFAlM6TZKL6e9UsFmMU/s1VgbVDGqGZSoeyx9Q6xt8PD/PJEJpLKht6VuOstxvJ0sgH5llpkcrwnSmym6JowNxuN08b2naMsdoHBpbd8LQeld+kLy9Gt+5On8bBrhik/7jhRB+ehXoCFZUweaGn084cR2h5U3PxIAIiswIjpVBTMO/B8YZuUxGcRk6XHlU5Rvte/N/ZIGZU8y01exnVsPwCcG5dHO6uK8HeY36+Ga9wGh9NhzvMHM8a+lxB2qe1uoQ+9sPopeCtkJSf16/Dx6/3kDR8k8dz4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1AbqPWcACLY4kjPkXzwMU5tjuaPYG1qjQy3CC3l3M0=;
 b=J6Qau7+i3yiFYCv5c9K+CVPTbC4cALgN0Ipf2S6ksMZ1OPbLFo187soS1srYek5jdm4Av7AoGDxbQut0N4aAGXcNJBXO40uQhAT3aDk+b7g7Uaf4yjMhEqqBlEvh6euTIYoTd/GzPXqoPpDdqYqHYFWw4bKlQ0Fi+/xlJEGX670=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2904.namprd15.prod.outlook.com (2603:10b6:a03:b0::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30; Fri, 15 May
 2020 22:01:07 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2979.033; Fri, 15 May 2020
 22:01:07 +0000
Date:   Fri, 15 May 2020 15:01:04 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/19] mm: memcg/slab: obj_cgroup API
Message-ID: <20200515220104.GD94522@carbon.DHCP.thefacebook.com>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-7-guro@fb.com>
 <20200507210314.GD161043@cmpxchg.org>
 <20200507222631.GA81857@carbon.dhcp.thefacebook.com>
 <20200512225645.GA488426@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512225645.GA488426@cmpxchg.org>
X-ClientProxiedBy: BY3PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:217::6) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:fd9b) by BY3PR04CA0001.namprd04.prod.outlook.com (2603:10b6:a03:217::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 22:01:06 +0000
X-Originating-IP: [2620:10d:c090:400::5:fd9b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2baca28e-17fc-40f0-d833-08d7f91b7826
X-MS-TrafficTypeDiagnostic: BYAPR15MB2904:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2904FD9DA89474B8A11B0631BEBD0@BYAPR15MB2904.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T2zsQFdJZPudlRgSBcfAm3EuFAkDz/gna08eZ4lYRVMihBcR2eGWAU5XPkwYys9uSmT6iiQJ9hDTRbWFKM5XY260BpOiLZuVXrrXdA4OGcvrI68Xdl05T44Bvr4Q8wpq0WZHbhLCKWwEs+hWILPvtZdRJf1zIjVh38HbGZIzm20GXizAcnCHA9DQVE/5Ra7e9DS1sWBi/1ADfYjQhwXgH0nogsXxRdSzhqNfr0qLbZwWTi5tU41i8RTDg4oMDqGga5db6j2TCjPdTUOpkqAmKSvIXrJpS5MWV9JwmNbjDwmSVzKvr/puNcDlBxwUbt54tfkFqGrcAgzdBRbCou9qDKZBRahgw44Mq8gigwpUaflfBYhhhbP+HTknocKCJItZLxyy56J40BgxHXGdm7KZJhZsexVNpsbr9me88bkkC51eDb6mSq84R30T0LAeK/JG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(376002)(346002)(39860400002)(366004)(478600001)(8936002)(30864003)(86362001)(52116002)(6506007)(8676002)(7696005)(53546011)(186003)(16526019)(2906002)(66556008)(55016002)(5660300002)(1076003)(54906003)(316002)(66476007)(4326008)(9686003)(6916009)(66946007)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /1M+8o1G7dFxi/EZbBq7E1PVolAg7oDWVf00H5qVRqbsiOE1JW1VLQAdIDjORx1P/LBNuB8DOy/41N7GJE01vyuoRqnPIS2cmym3Y9b0Cc4TzTzoT6p5dJTRsMv1VSMKonj3esHe1x2j5ww/C68bRZZiv7/MS7e+wnZM5OHVNb+nQ4RmZeYW6CasDQevd3i2gTVPXsqXsx8qOSTN49gZK+21imXdodFAq7tYoBkdT452SuE/nh8HxaUlZiEzQEwEmGC5cJmWYetDFX7cLImJfK84OT82cCYs+V+fxzTbAcWVG2QNLbsNRPNid6Hj7qtkHoUK3cHutnsYHew8Y6jP2BFY4MAE22e2238EorxgFfAjg6SKFGYB1rVfC1rMSbB/811ohJkVlzfShvr1yFzj75tMkk/i+D9LHtv83okFsI3W/o0t1DsVwu8q/1KJyQlHIX9tKV88LHEaZw8zGsXwIQWnF3xQ+D6aJl62bpB/xaB7TsqGVixZsl7RMAaOvFA6klOEaS8/MssjLLDvm1/B3g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2baca28e-17fc-40f0-d833-08d7f91b7826
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 22:01:07.4497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1G1Py5joBR8XKFJ0WucVEUhPLEkhLrcMJy+gM8N+rAqsXxcFId01CkUKmlBiES56
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2904
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-15_07:2020-05-15,2020-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=5 cotscore=-2147483648 mlxlogscore=999
 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005150185
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 06:56:45PM -0400, Johannes Weiner wrote:
> On Thu, May 07, 2020 at 03:26:31PM -0700, Roman Gushchin wrote:
> > On Thu, May 07, 2020 at 05:03:14PM -0400, Johannes Weiner wrote:
> > > On Wed, Apr 22, 2020 at 01:46:55PM -0700, Roman Gushchin wrote:
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -257,6 +257,78 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
> > > >  }
> > > >  
> > > >  #ifdef CONFIG_MEMCG_KMEM
> > > > +extern spinlock_t css_set_lock;
> > > > +
> > > > +static void obj_cgroup_release(struct percpu_ref *ref)
> > > > +{
> > > > +	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
> > > > +	struct mem_cgroup *memcg;
> > > > +	unsigned int nr_bytes;
> > > > +	unsigned int nr_pages;
> > > > +	unsigned long flags;
> > > > +
> > > > +	nr_bytes = atomic_read(&objcg->nr_charged_bytes);
> > > > +	WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
> > > > +	nr_pages = nr_bytes >> PAGE_SHIFT;
> > > 
> > > What guarantees that we don't have a partial page in there at this
> > > point? I guess any outstanding allocations would pin the objcg, so
> > > when it's released all objects have been freed.
> > 
> > Right, this is exactly the reason why there can't be a partial page
> > at this point.
> > 
> > > 
> > > But if that's true, how can we have full pages remaining in there now?
> > 
> > Imagine the following sequence:
> > 1) CPU0: objcg == stock->cached_objcg
> > 2) CPU1: we do a small allocation (e.g. 92 bytes), page is charged
> > 3) CPU1: a process from another memcg is allocating something, stock if flushed,
> >    objcg->nr_charged_bytes = PAGE_SIZE - 92
> > 5) CPU0: we do release this object, 92 bytes are added to stock->nr_bytes
> > 6) CPU0: stock is flushed, 92 bytes are added to objcg->nr_charged_bytes
> > 
> > In the result, nr_charged_bytes == PAGE_SIZE. This PAGE will be uncharged
> > in obj_cgroup_release().
> > 
> > I've double checked this, it's actually pretty easy to trigger in the real life.
> 
> Ah, so no outstanding allocations, but a full page split between the
> percpu cache and objcg->nr_charged_bytes.
> 
> Would it simplify things if refill_obj_stock() drained on >= PAGE_SIZE
> stock instead of > PAGE_SIZE?
> 
> Otherwise, the scenario above would be good to have as a comment as
> the drain on release is not self-explanatory.
> 
> > > > +int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
> > > > +{
> > > > +	struct mem_cgroup *memcg;
> > > > +	unsigned int nr_pages, nr_bytes;
> > > > +	int ret;
> > > > +
> > > > +	if (consume_obj_stock(objcg, size))
> > > > +		return 0;
> > > > +
> > > > +	rcu_read_lock();
> > > > +	memcg = obj_cgroup_memcg(objcg);
> > > > +	css_get(&memcg->css);
> > > > +	rcu_read_unlock();
> > > > +
> > > > +	nr_pages = size >> PAGE_SHIFT;
> > > > +	nr_bytes = size & (PAGE_SIZE - 1);
> > > > +
> > > > +	if (nr_bytes)
> > > > +		nr_pages += 1;
> > > > +
> > > > +	ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
> > > 
> > > If consume_obj_stock() fails because some other memcg is cached,
> > > should this try to consume the partial page in objcg->nr_charged_bytes
> > > before getting more pages?
> > 
> > We can definitely do it, but I'm not sure if it's good for the performance.
> > 
> > Dealing with nr_charged_bytes will require up to two atomic writes,
> > so calling __memcg_kmem_charge() can be faster if memcg is cached
> > on percpu stock.
> 
> Hm, but it's the slowpath. And sooner or later somebody has to deal
> with the remaining memory in there.
> 
> > > > +	if (!ret && nr_bytes)
> > > > +		refill_obj_stock(objcg, PAGE_SIZE - nr_bytes);
> > > 
> > > This will put the cgroup into the cache if the allocation resulted in
> > > a partially free page.
> > > 
> > > But if this was a page allocation, we may have objcg->nr_cache_bytes
> > > from a previous subpage allocation that we should probably put back
> > > into the stock.
> > 
> > Yeah, we can do this, but I don't know if there will be any benefits.
> 
> It's mostly about understanding the code.
> 
> > Actually we don't wanna to touch objcg->nr_cache_bytes too often, as
> > it can become a contention point if there are many threads allocating
> > in the memory cgroup.
> > 
> > So maybe we want to do the opposite: relax it a bit and stop flushing
> > it on every stock refill and flush only if it exceeds a certain value.
> 
> That could be useful, yes.
> 
> > > It's not a common case, I'm just trying to understand what
> > > objcg->nr_cache_bytes holds and when it does so.
> > 
> > So it's actually a centralized leftover from the rounding of the actual
> > charge to the page size.
> 
> It would be good to add code comments explaining this.


Thanks you for comments! Please, find the updated version with some added
explanations below. No functional changes, just added some comments here
and there. Thanks!

--

From a9eadd2b624c37ffda981d172f2bfb9ceae0f984 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Tue, 14 Jan 2020 08:59:24 -0800
Subject: [PATCH v3.1 06/20] mm: memcg/slab: obj_cgroup API

Obj_cgroup API provides an ability to account sub-page sized kernel
objects, which potentially outlive the original memory cgroup.

The top-level API consists of the following functions:
  bool obj_cgroup_tryget(struct obj_cgroup *objcg);
  void obj_cgroup_get(struct obj_cgroup *objcg);
  void obj_cgroup_put(struct obj_cgroup *objcg);

  int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
  void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);

  struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg);
  struct obj_cgroup *get_obj_cgroup_from_current(void);

Object cgroup is basically a pointer to a memory cgroup with a per-cpu
reference counter. It substitutes a memory cgroup in places where
it's necessary to charge a custom amount of bytes instead of pages.

All charged memory rounded down to pages is charged to the
corresponding memory cgroup using __memcg_kmem_charge().

It implements reparenting: on memcg offlining it's getting reattached
to the parent memory cgroup. Each online memory cgroup has an
associated active object cgroup to handle new allocations and the list
of all attached object cgroups. On offlining of a cgroup this list is
reparented and for each object cgroup in the list the memcg pointer is
swapped to the parent memory cgroup. It prevents long-living objects
from pinning the original memory cgroup in the memory.

The implementation is based on byte-sized per-cpu stocks. A sub-page
sized leftover is stored in an atomic field, which is a part of
obj_cgroup object. So on cgroup offlining the leftover is automatically
reparented.

memcg->objcg is rcu protected.
objcg->memcg is a raw pointer, which is always pointing at a memory
cgroup, but can be atomically swapped to the parent memory cgroup. So
the caller must ensure the lifetime of the cgroup, e.g. grab
rcu_read_lock or css_set_lock.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h |  51 +++++++
 mm/memcontrol.c            | 278 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 328 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c2eb73d89f5d..bf1be842fd27 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -23,6 +23,7 @@
 #include <linux/page-flags.h>
 
 struct mem_cgroup;
+struct obj_cgroup;
 struct page;
 struct mm_struct;
 struct kmem_cache;
@@ -194,6 +195,22 @@ struct memcg_cgwb_frn {
 	struct wb_completion done;	/* tracks in-flight foreign writebacks */
 };
 
+/*
+ * Bucket for arbitrarily byte-sized objects charged to a memory
+ * cgroup. The bucket can be reparented in one piece when the cgroup
+ * is destroyed, without having to round up the individual references
+ * of all live memory objects in the wild.
+ */
+struct obj_cgroup {
+	struct percpu_ref refcnt;
+	struct mem_cgroup *memcg;
+	atomic_t nr_charged_bytes;
+	union {
+		struct list_head list;
+		struct rcu_head rcu;
+	};
+};
+
 /*
  * The memory controller data structure. The memory controller controls both
  * page cache and RSS per cgroup. We would eventually like to provide
@@ -306,6 +323,8 @@ struct mem_cgroup {
 	int kmemcg_id;
 	enum memcg_kmem_state kmem_state;
 	struct list_head kmem_caches;
+	struct obj_cgroup __rcu *objcg;
+	struct list_head objcg_list;
 #endif
 
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -429,6 +448,33 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
 	return css ? container_of(css, struct mem_cgroup, css) : NULL;
 }
 
+static inline bool obj_cgroup_tryget(struct obj_cgroup *objcg)
+{
+	return percpu_ref_tryget(&objcg->refcnt);
+}
+
+static inline void obj_cgroup_get(struct obj_cgroup *objcg)
+{
+	percpu_ref_get(&objcg->refcnt);
+}
+
+static inline void obj_cgroup_put(struct obj_cgroup *objcg)
+{
+	percpu_ref_put(&objcg->refcnt);
+}
+
+/*
+ * After the initialization objcg->memcg is always pointing at
+ * a valid memcg, but can be atomically swapped to the parent memcg.
+ *
+ * The caller must ensure that the returned memcg won't be released:
+ * e.g. acquire the rcu_read_lock or css_set_lock.
+ */
+static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
+{
+	return READ_ONCE(objcg->memcg);
+}
+
 static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 {
 	if (memcg)
@@ -1390,6 +1436,11 @@ void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages);
 int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
 void __memcg_kmem_uncharge_page(struct page *page, int order);
 
+struct obj_cgroup *get_obj_cgroup_from_current(void);
+
+int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
+void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
+
 extern struct static_key_false memcg_kmem_enabled_key;
 extern struct workqueue_struct *memcg_kmem_cache_wq;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 83805b48817d..0423705d3068 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -257,6 +257,98 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
 }
 
 #ifdef CONFIG_MEMCG_KMEM
+extern spinlock_t css_set_lock;
+
+static void obj_cgroup_release(struct percpu_ref *ref)
+{
+	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
+	struct mem_cgroup *memcg;
+	unsigned int nr_bytes;
+	unsigned int nr_pages;
+	unsigned long flags;
+
+	/*
+	 * At this point all allocated objects are freed, and
+	 * objcg->nr_charged_bytes can't have an arbitrary byte value.
+	 * However, it can be PAGE_SIZE or (x * PAGE_SIZE).
+	 *
+	 * The following sequence can lead to it:
+	 * 1) CPU0: objcg == stock->cached_objcg
+	 * 2) CPU1: we do a small allocation (e.g. 92 bytes),
+	 *          PAGE_SIZE bytes are charged
+	 * 3) CPU1: a process from another memcg is allocating something,
+	 *          the stock if flushed,
+	 *          objcg->nr_charged_bytes = PAGE_SIZE - 92
+	 * 5) CPU0: we do release this object,
+	 *          92 bytes are added to stock->nr_bytes
+	 * 6) CPU0: stock is flushed,
+	 *          92 bytes are added to objcg->nr_charged_bytes
+	 *
+	 * In the result, nr_charged_bytes == PAGE_SIZE.
+	 * This page will be uncharged in obj_cgroup_release().
+	 */
+	nr_bytes = atomic_read(&objcg->nr_charged_bytes);
+	WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
+	nr_pages = nr_bytes >> PAGE_SHIFT;
+
+	spin_lock_irqsave(&css_set_lock, flags);
+	memcg = obj_cgroup_memcg(objcg);
+	if (nr_pages)
+		__memcg_kmem_uncharge(memcg, nr_pages);
+	list_del(&objcg->list);
+	mem_cgroup_put(memcg);
+	spin_unlock_irqrestore(&css_set_lock, flags);
+
+	percpu_ref_exit(ref);
+	kfree_rcu(objcg, rcu);
+}
+
+static struct obj_cgroup *obj_cgroup_alloc(void)
+{
+	struct obj_cgroup *objcg;
+	int ret;
+
+	objcg = kzalloc(sizeof(struct obj_cgroup), GFP_KERNEL);
+	if (!objcg)
+		return NULL;
+
+	ret = percpu_ref_init(&objcg->refcnt, obj_cgroup_release, 0,
+			      GFP_KERNEL);
+	if (ret) {
+		kfree(objcg);
+		return NULL;
+	}
+	INIT_LIST_HEAD(&objcg->list);
+	return objcg;
+}
+
+static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
+				  struct mem_cgroup *parent)
+{
+	struct obj_cgroup *objcg, *iter;
+
+	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
+
+	spin_lock_irq(&css_set_lock);
+
+	/* Move active objcg to the parent's list */
+	xchg(&objcg->memcg, parent);
+	css_get(&parent->css);
+	list_add(&objcg->list, &parent->objcg_list);
+
+	/* Move already reparented objcgs to the parent's list */
+	list_for_each_entry(iter, &memcg->objcg_list, list) {
+		css_get(&parent->css);
+		xchg(&iter->memcg, parent);
+		css_put(&memcg->css);
+	}
+	list_splice(&memcg->objcg_list, &parent->objcg_list);
+
+	spin_unlock_irq(&css_set_lock);
+
+	percpu_ref_kill(&objcg->refcnt);
+}
+
 /*
  * This will be the memcg's index in each cache's ->memcg_params.memcg_caches.
  * The main reason for not using cgroup id for this:
@@ -2064,6 +2156,12 @@ EXPORT_SYMBOL(unlock_page_memcg);
 struct memcg_stock_pcp {
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
+
+#ifdef CONFIG_MEMCG_KMEM
+	struct obj_cgroup *cached_objcg;
+	unsigned int nr_bytes;
+#endif
+
 	struct work_struct work;
 	unsigned long flags;
 #define FLUSHING_CACHED_CHARGE	0
@@ -2071,6 +2169,22 @@ struct memcg_stock_pcp {
 static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
 static DEFINE_MUTEX(percpu_charge_mutex);
 
+#ifdef CONFIG_MEMCG_KMEM
+static void drain_obj_stock(struct memcg_stock_pcp *stock);
+static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
+				     struct mem_cgroup *root_memcg);
+
+#else
+static inline void drain_obj_stock(struct memcg_stock_pcp *stock)
+{
+}
+static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
+				     struct mem_cgroup *root_memcg)
+{
+	return false;
+}
+#endif
+
 /**
  * consume_stock: Try to consume stocked charge on this cpu.
  * @memcg: memcg to consume from.
@@ -2137,6 +2251,7 @@ static void drain_local_stock(struct work_struct *dummy)
 	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
+	drain_obj_stock(stock);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
@@ -2196,6 +2311,8 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 		if (memcg && stock->nr_pages &&
 		    mem_cgroup_is_descendant(memcg, root_memcg))
 			flush = true;
+		if (obj_stock_flush_required(stock, root_memcg))
+			flush = true;
 		rcu_read_unlock();
 
 		if (flush &&
@@ -2723,6 +2840,30 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
 	return page->mem_cgroup;
 }
 
+__always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
+{
+	struct obj_cgroup *objcg = NULL;
+	struct mem_cgroup *memcg;
+
+	if (unlikely(!current->mm))
+		return NULL;
+
+	rcu_read_lock();
+	if (unlikely(current->active_memcg))
+		memcg = rcu_dereference(current->active_memcg);
+	else
+		memcg = mem_cgroup_from_task(current);
+
+	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
+		objcg = rcu_dereference(memcg->objcg);
+		if (objcg && obj_cgroup_tryget(objcg))
+			break;
+	}
+	rcu_read_unlock();
+
+	return objcg;
+}
+
 static int memcg_alloc_cache_id(void)
 {
 	int id, size;
@@ -3007,6 +3148,130 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 	if (PageKmemcg(page))
 		__ClearPageKmemcg(page);
 }
+
+static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
+{
+	struct memcg_stock_pcp *stock;
+	unsigned long flags;
+	bool ret = false;
+
+	local_irq_save(flags);
+
+	stock = this_cpu_ptr(&memcg_stock);
+	if (objcg == stock->cached_objcg && stock->nr_bytes >= nr_bytes) {
+		stock->nr_bytes -= nr_bytes;
+		ret = true;
+	}
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+static void drain_obj_stock(struct memcg_stock_pcp *stock)
+{
+	struct obj_cgroup *old = stock->cached_objcg;
+
+	if (!old)
+		return;
+
+	if (stock->nr_bytes) {
+		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
+		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
+
+		if (nr_pages) {
+			rcu_read_lock();
+			__memcg_kmem_uncharge(obj_cgroup_memcg(old), nr_pages);
+			rcu_read_unlock();
+		}
+
+		/*
+		 * The leftover is flushed to the centralized per-memcg value.
+		 * On the next attempt to refill obj stock it will be moved
+		 * to a per-cpu stock (probably, on an other CPU), see
+		 * refill_obj_stock().
+		 *
+		 * How often it's flushed is a trade-off between the memory
+		 * limit enforcement accuracy and potential CPU contention,
+		 * so it might be changed in the future.
+		 */
+		atomic_add(nr_bytes, &old->nr_charged_bytes);
+		stock->nr_bytes = 0;
+	}
+
+	obj_cgroup_put(old);
+	stock->cached_objcg = NULL;
+}
+
+static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
+				     struct mem_cgroup *root_memcg)
+{
+	struct mem_cgroup *memcg;
+
+	if (stock->cached_objcg) {
+		memcg = obj_cgroup_memcg(stock->cached_objcg);
+		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
+			return true;
+	}
+
+	return false;
+}
+
+static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
+{
+	struct memcg_stock_pcp *stock;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	stock = this_cpu_ptr(&memcg_stock);
+	if (stock->cached_objcg != objcg) { /* reset if necessary */
+		drain_obj_stock(stock);
+		obj_cgroup_get(objcg);
+		stock->cached_objcg = objcg;
+		stock->nr_bytes = atomic_xchg(&objcg->nr_charged_bytes, 0);
+	}
+	stock->nr_bytes += nr_bytes;
+
+	if (stock->nr_bytes > PAGE_SIZE)
+		drain_obj_stock(stock);
+
+	local_irq_restore(flags);
+}
+
+int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
+{
+	struct mem_cgroup *memcg;
+	unsigned int nr_pages, nr_bytes;
+	int ret;
+
+	if (consume_obj_stock(objcg, size))
+		return 0;
+
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+	css_get(&memcg->css);
+	rcu_read_unlock();
+
+	nr_pages = size >> PAGE_SHIFT;
+	nr_bytes = size & (PAGE_SIZE - 1);
+
+	if (nr_bytes)
+		nr_pages += 1;
+
+	ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
+	if (!ret && nr_bytes)
+		refill_obj_stock(objcg, PAGE_SIZE - nr_bytes);
+
+	css_put(&memcg->css);
+	return ret;
+}
+
+void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
+{
+	refill_obj_stock(objcg, size);
+}
+
 #endif /* CONFIG_MEMCG_KMEM */
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -3429,6 +3694,7 @@ static void memcg_flush_percpu_vmevents(struct mem_cgroup *memcg)
 #ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
+	struct obj_cgroup *objcg;
 	int memcg_id;
 
 	if (cgroup_memory_nokmem)
@@ -3441,6 +3707,14 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	if (memcg_id < 0)
 		return memcg_id;
 
+	objcg = obj_cgroup_alloc();
+	if (!objcg) {
+		memcg_free_cache_id(memcg_id);
+		return -ENOMEM;
+	}
+	objcg->memcg = memcg;
+	rcu_assign_pointer(memcg->objcg, objcg);
+
 	static_branch_inc(&memcg_kmem_enabled_key);
 	/*
 	 * A memory cgroup is considered kmem-online as soon as it gets
@@ -3476,9 +3750,10 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 		parent = root_mem_cgroup;
 
 	/*
-	 * Deactivate and reparent kmem_caches.
+	 * Deactivate and reparent kmem_caches and objcgs.
 	 */
 	memcg_deactivate_kmem_caches(memcg, parent);
+	memcg_reparent_objcgs(memcg, parent);
 
 	kmemcg_id = memcg->kmemcg_id;
 	BUG_ON(kmemcg_id < 0);
@@ -5045,6 +5320,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	memcg->socket_pressure = jiffies;
 #ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id = -1;
+	INIT_LIST_HEAD(&memcg->objcg_list);
 #endif
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
-- 
2.25.4

