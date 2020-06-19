Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9218CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 21:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B385221E7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 21:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AtSnTegP";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="MfhQgEBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgFSVjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 17:39:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10858 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726220AbgFSVjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 17:39:15 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JLLdDi024614;
        Fri, 19 Jun 2020 14:38:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=1q0OkPp0CBUyiBdGShmF4NPr0Rxqv5kJiIMlvAyD4Ds=;
 b=AtSnTegPecx/4iV2/yIawtYzUaL8Mk0fzPYjYiC7l48Ck66J8e4/E4YnbS2Kdcqj/tFm
 3XkppJrRQN0YgDrC6iQfS4oh0kFKH6fbkHtb7Xut2PXAIPEg6nRXci007BmGeUaXu7l/
 xsBFObB7QMGiepEtQr1n7v+d8wCZN2ys/ls= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31r092mten-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Jun 2020 14:38:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 14:38:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWKlJTqT6NsRO+23rmV8cBYNCt9w8/HBOiuzwSDRNINHavEKuQYFDxLvil34+L34L8ZRLPmuIgPmgvtOipwA2Ue13fdOTaN0jH+xg9DszGacvPu6hVxdHJ0IeEdO85x0xYUaf7tgyBZodhsJzSRBcbYWCL/X+IGbaRBDOAlr2tNvGohMDhL+5F9H4zDNor3c1EIYaR8Yf3Jdx0IzL5zQ3KzIBxun7bYPMkcQarIl4wxhuXO5O7D4It6OZALRF8nOXBvwT2iAxgbZNuDW5AebV7tiCDUYV7ANtk1IMcphK45ZBwdNsBCCEb6dmIYzx6N0mOBcTErGFJo+LaEwCFzaGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1q0OkPp0CBUyiBdGShmF4NPr0Rxqv5kJiIMlvAyD4Ds=;
 b=DUIvqo6ra/dNmISIlbCkbZ5kjUjQ69DOykMo+5Yfy6g/heCjWuoKoCWz6bSR5VGRogQA2ybFn70BwHv1QdX3Q6IN4oIGDL+GAJSSHbK8SK09JB475JIvqtECIrBj+FGmqrtgXojBh43YGKqY0MHTZFEywMY7WH3ehoy6lUctAXP61j+AeyKrCxRmC7auf3f1emgFRw6goqTAVUX41dyZ3XrYFNr1akeCbTBhx3BbRCBQPK2E5IjBRRDaUSAbCUiiAC7eYR38YCNzyJkf8s/aeY78KXurIupO8VaCF0dSN2BZwX3Ic71FCXDu9fAFLbgckb28mhAPW9M2QbJVCKWaNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1q0OkPp0CBUyiBdGShmF4NPr0Rxqv5kJiIMlvAyD4Ds=;
 b=MfhQgEBV8vVjAz7lGVrZJjMyc2XgjITFKDueGdsOCpPgTnPhveBzGyAAA2bTzVUuRi8rCjZJb9GHSp1G2925TddDbOlYzXy2/qgDq0E8bbYwubszjVlk742Ak9UKAqWWLzCc0a4IVCJryLiipH/hZWLYL49b4HFIwJp0R+NnuhA=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2664.namprd15.prod.outlook.com (2603:10b6:a03:15a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 21:38:13 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 21:38:13 +0000
Date:   Fri, 19 Jun 2020 14:38:10 -0700
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
Subject: Re: [PATCH v6 06/19] mm: memcg/slab: obj_cgroup API
Message-ID: <20200619213810.GA237539@carbon.dhcp.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
 <20200608230654.828134-7-guro@fb.com>
 <CALvZod4hq5moKcb6f5L6VAS+v5+jKf8Hyd0gLotD7bMK7FsKgg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4hq5moKcb6f5L6VAS+v5+jKf8Hyd0gLotD7bMK7FsKgg@mail.gmail.com>
X-ClientProxiedBy: BYAPR06CA0035.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::48) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a2a9) by BYAPR06CA0035.namprd06.prod.outlook.com (2603:10b6:a03:d4::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 21:38:13 +0000
X-Originating-IP: [2620:10d:c090:400::5:a2a9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf42e689-4a9d-4fb0-d7ca-08d8149911e2
X-MS-TrafficTypeDiagnostic: BYAPR15MB2664:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB26645B63623F91D1293B9C24BE980@BYAPR15MB2664.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nszLsVS6kt+9x6AsiRKMS5KSUEvaR6gPG8MSTfbOe9V+qrL+rA4/7ZW49jLFTULcOCAkIfj/JuYXDtvfJjEHBDD2YI9YoWkQzAP52fQR5o1AbZ4pY5ybmfFgZGmJYZHg2KRFBsonSwTi/vuNR4UchmCb4YMyFy1LeFwkWuPHkfG4XiA/YSOBQltYK0kkJAbrUk4+OxPyuImg6aoiZKwsVn7VsXLYmeYTInr2qSQkKrMwboGEAR+lPUjQM+fl5YF2Q3dvM8C+k6GSSwhuuJ2JIe2fpKuO5Q4fws8G9OcCJl5CsZdrQ4/o7W8whcTODlBbM/bDSC9IUCMCqra5HSDgpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(346002)(376002)(136003)(39860400002)(6916009)(66476007)(66556008)(83380400001)(2906002)(66946007)(8676002)(8936002)(16526019)(478600001)(186003)(316002)(54906003)(52116002)(6506007)(53546011)(5660300002)(4326008)(55016002)(9686003)(1076003)(86362001)(7696005)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: c+srQR7i6XoiNBK0uLqskt8KVq5mBhSumuzMZ8QV+1PyQq2IlCqHJn5EmZdkuXlF7eYdEiJb1nEeuJdaxcJcNOS6XJv3yBROxSuMLd48fpOjKNRtygixa9VZDbZ/X0zNxTJvP1flpBlmxV+okBXKG6zqqTDHexTI5rP3jdR1Ad9SoxFgqy8EAEn6vS9N1cPOo0rcVGRJzh9DmPS0/IMGE7/GTvGaLmyyEj7J37xf9/F2LKtMaYEEgaoGehC/efJVD2ZYqOoY76aqSNGKLudxcow/nQkeeBSWZhMTSIxvPmGNCqb1H153QXYpQ8s9JILCEXKKHNb6H8dVD+1nM20wUkSaYh3YeoTHc+8h9CCcWxDVH2HLxlN1sDf2ij14sr2W8MveRGY6B0M3fmtcyH6izqOUCTM4blqUfAjHJ8bARKwZfAUfA75GhDSUSGo7fZNYFuGVksFeZlpb4xJ9vTt9rNltLWcfz9clwKEUlXrBuHnpnv9wonb2CwQiQfj/fjdcRWoQvXBG7or6oRWUsucqcg==
X-MS-Exchange-CrossTenant-Network-Message-Id: cf42e689-4a9d-4fb0-d7ca-08d8149911e2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 21:38:13.7672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hbp1YGZ10b/GdLxVpVpJEYLu2ROhFxy0/3owhZkxk6ME/xKG6C5jh0ywGx9m72Ki
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2664
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_22:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=1 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190151
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 08:42:34AM -0700, Shakeel Butt wrote:
> On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > Obj_cgroup API provides an ability to account sub-page sized kernel
> > objects, which potentially outlive the original memory cgroup.
> >
> > The top-level API consists of the following functions:
> >   bool obj_cgroup_tryget(struct obj_cgroup *objcg);
> >   void obj_cgroup_get(struct obj_cgroup *objcg);
> >   void obj_cgroup_put(struct obj_cgroup *objcg);
> >
> >   int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
> >   void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
> >
> >   struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg);
> >   struct obj_cgroup *get_obj_cgroup_from_current(void);
> >
> > Object cgroup is basically a pointer to a memory cgroup with a per-cpu
> > reference counter. It substitutes a memory cgroup in places where
> > it's necessary to charge a custom amount of bytes instead of pages.
> >
> > All charged memory rounded down to pages is charged to the
> > corresponding memory cgroup using __memcg_kmem_charge().
> >
> > It implements reparenting: on memcg offlining it's getting reattached
> > to the parent memory cgroup. Each online memory cgroup has an
> > associated active object cgroup to handle new allocations and the list
> > of all attached object cgroups. On offlining of a cgroup this list is
> > reparented and for each object cgroup in the list the memcg pointer is
> > swapped to the parent memory cgroup. It prevents long-living objects
> > from pinning the original memory cgroup in the memory.
> >
> > The implementation is based on byte-sized per-cpu stocks. A sub-page
> > sized leftover is stored in an atomic field, which is a part of
> > obj_cgroup object. So on cgroup offlining the leftover is automatically
> > reparented.
> >
> > memcg->objcg is rcu protected.
> > objcg->memcg is a raw pointer, which is always pointing at a memory
> > cgroup, but can be atomically swapped to the parent memory cgroup. So
> > the caller
> 
> What type of caller? The allocator?

Basically whoever uses the pointer. Is it better to s/caller/user?

> 
> > must ensure the lifetime of the cgroup, e.g. grab
> > rcu_read_lock or css_set_lock.
> >
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  include/linux/memcontrol.h |  51 +++++++
> >  mm/memcontrol.c            | 288 ++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 338 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 93dbc7f9d8b8..c69e66fe4f12 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -23,6 +23,7 @@
> >  #include <linux/page-flags.h>
> >
> >  struct mem_cgroup;
> > +struct obj_cgroup;
> >  struct page;
> >  struct mm_struct;
> >  struct kmem_cache;
> > @@ -192,6 +193,22 @@ struct memcg_cgwb_frn {
> >         struct wb_completion done;      /* tracks in-flight foreign writebacks */
> >  };
> >
> > +/*
> > + * Bucket for arbitrarily byte-sized objects charged to a memory
> > + * cgroup. The bucket can be reparented in one piece when the cgroup
> > + * is destroyed, without having to round up the individual references
> > + * of all live memory objects in the wild.
> > + */
> > +struct obj_cgroup {
> > +       struct percpu_ref refcnt;
> > +       struct mem_cgroup *memcg;
> > +       atomic_t nr_charged_bytes;
> 
> So, we still charge the mem page counter in pages but keep the
> remaining sub-page slack charge in nr_charge_bytes, right?

Kind of. The remainder is usually kept in a per-cpu stock,
but if the stock has to be flushed, it's getting flushed to nr_charge_bytes.

> 
> > +       union {
> > +               struct list_head list;
> > +               struct rcu_head rcu;
> > +       };
> > +};
> > +
> >  /*
> >   * The memory controller data structure. The memory controller controls both
> >   * page cache and RSS per cgroup. We would eventually like to provide
> > @@ -301,6 +318,8 @@ struct mem_cgroup {
> >         int kmemcg_id;
> >         enum memcg_kmem_state kmem_state;
> >         struct list_head kmem_caches;
> > +       struct obj_cgroup __rcu *objcg;
> > +       struct list_head objcg_list;
> >  #endif
> >
> [snip]
> > +
> > +static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
> > +                                 struct mem_cgroup *parent)
> > +{
> > +       struct obj_cgroup *objcg, *iter;
> > +
> > +       objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
> > +
> > +       spin_lock_irq(&css_set_lock);
> > +
> > +       /* Move active objcg to the parent's list */
> > +       xchg(&objcg->memcg, parent);
> > +       css_get(&parent->css);
> > +       list_add(&objcg->list, &parent->objcg_list);
> 
> So, memcg->objcs_list will always only contain the offlined
> descendants objcgs. I would recommend to rename objcg_list to clearly
> show that. Maybe offlined_objcg_list or descendants_objcg_list or
> something else.

Right. Let me add a comment for now and think of a better name.

> 
> > +
> > +       /* Move already reparented objcgs to the parent's list */
> > +       list_for_each_entry(iter, &memcg->objcg_list, list) {
> > +               css_get(&parent->css);
> > +               xchg(&iter->memcg, parent);
> > +               css_put(&memcg->css);
> > +       }
> > +       list_splice(&memcg->objcg_list, &parent->objcg_list);
> > +
> > +       spin_unlock_irq(&css_set_lock);
> > +
> > +       percpu_ref_kill(&objcg->refcnt);
> > +}
> > +
> >  /*
> [snip]
> >
> > +__always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> > +{
> > +       struct obj_cgroup *objcg = NULL;
> > +       struct mem_cgroup *memcg;
> > +
> > +       if (unlikely(!current->mm))
> > +               return NULL;
> 
> I have not seen the users of this function yet but shouldn't the above
> check be (!current->mm && !current->active_memcg)?

Yes, good catch, it might save a couple of cycles if
current->mm == current->active_memcg == NULL. Adding.

> 
> Do we need a mem_cgroup_disabled() check as well?

As now both call sides are guarded by memcg_kmem_enabled(),
so we don't need it.

But maybe it's a good target for some refactorings,
e.g. moving !current->mm and !current->active_memcg checks out
of memcg_kmem_bypass(). And _maybe_ it's better to move memcg_kmem_enabled()
here, but I'm not sure.

> 
> > +
> > +       rcu_read_lock();
> > +       if (unlikely(current->active_memcg))
> > +               memcg = rcu_dereference(current->active_memcg);
> > +       else
> > +               memcg = mem_cgroup_from_task(current);
> > +
> > +       for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
> > +               objcg = rcu_dereference(memcg->objcg);
> > +               if (objcg && obj_cgroup_tryget(objcg))
> > +                       break;
> > +       }
> > +       rcu_read_unlock();
> > +
> > +       return objcg;
> > +}
> > +
> [...]
> > +
> > +static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
> > +{
> > +       struct memcg_stock_pcp *stock;
> > +       unsigned long flags;
> > +
> > +       local_irq_save(flags);
> > +
> > +       stock = this_cpu_ptr(&memcg_stock);
> > +       if (stock->cached_objcg != objcg) { /* reset if necessary */
> > +               drain_obj_stock(stock);
> > +               obj_cgroup_get(objcg);
> > +               stock->cached_objcg = objcg;
> > +               stock->nr_bytes = atomic_xchg(&objcg->nr_charged_bytes, 0);
> > +       }
> > +       stock->nr_bytes += nr_bytes;
> > +
> > +       if (stock->nr_bytes > PAGE_SIZE)
> > +               drain_obj_stock(stock);
> 
> The normal stock can go to 32*nr_cpus*PAGE_SIZE. I am wondering if
> just PAGE_SIZE is too less for obj stock.

It works on top of the current stock of 32 pages, so it can grab these
32 pages without any atomic operations. And it should be easy to increase
this limit if we'll see any benefits.

Thank you for looking into the patchset!

Andrew, can you, please, squash the following fix based on Shakeel's suggestions?
Thanks!

--

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7ed3af71a6fb..2499f78cf32d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -326,7 +326,7 @@ struct mem_cgroup {
        int kmemcg_id;
        enum memcg_kmem_state kmem_state;
        struct obj_cgroup __rcu *objcg;
-       struct list_head objcg_list;
+       struct list_head objcg_list; /* list of inherited objcgs */
 #endif
 
 #ifdef CONFIG_CGROUP_WRITEBACK
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 70cd44b28db1..9f14b91700d9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2843,7 +2843,7 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
        struct obj_cgroup *objcg = NULL;
        struct mem_cgroup *memcg;
 
-       if (unlikely(!current->mm))
+       if (unlikely(!current->mm && !current->active_memcg))
                return NULL;
 
        rcu_read_lock();
