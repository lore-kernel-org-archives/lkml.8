Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E16C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 322712073E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EvjfHgAY";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="fyEF1mWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgFQDTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:19:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2818 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726759AbgFQDTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:19:51 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05H3HIoV016091;
        Tue, 16 Jun 2020 20:19:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ynI9arLyEGXh1Vk8F49zpTkYwCK/da24pE5uUXx+b+I=;
 b=EvjfHgAYCH4nCQ+KtB/89dgor5plUFuJUEb/N1/jVqkvErqYFuN1kNmR5eEhsv2DHfLc
 7/nR8UKndi+Jd6h6Izbm56H1lti+WEdLrJb5xy6gEhR6QXDRzFmAoqGMsU0WZd/VgQVy
 jSJvo4qEmaG0S3OwDiorfi8iUuwfkYVj/to= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 31q644h5pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Jun 2020 20:19:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 16 Jun 2020 20:19:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIcxSKX+48Y+oqAppOxfGzK04qKoMqr2rg/RxByQumd6WtPEFg1e1Kjwdxiej91CaRR9yqXRkYgxj7bBzSYFppi+I/yMrQ8HBxIk3nAm294vzAH6Ce6hbckr0qvtidU7KW9HKXBCP9zNLj0m4LJ9ZCeuMXAhZMhlUWRi0KHCkczn+67PSVnuem5q7Fsi7SFmAuh8Mw7llDOLcu0V60b8fWaXUYQcJmEkOAxdqfWuQGjz9EC4GmLDVExCxexjOn/zO/wCXhRniiIQfsrFMQgVxHFzCd5wVwVqjj5ysm8LNaddc82K5/SfWjuI/h6ffajxgEzOqJJPRURcl5AMS72a4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynI9arLyEGXh1Vk8F49zpTkYwCK/da24pE5uUXx+b+I=;
 b=ivKPR0iehAIxfcltOEmWp4nxMrGmxdX5JM0l/BIguhqBCGsZmLD0kF+esuYOI37vLtQWEftn6jjswNg41YnPxcnGqrntxlhF3lR08EpAY11VeW7mV9A0OHDFJh1xMTkuvTZvgkhIN1wYMkbTWterqZ6xPkbIG99jVG/oLCbI899+vBq8zIyVMYUYARG1gpNu2U/4iR5+hXoXDhVtcDPZRfCvQxbxCl3z39Uiv00cnw8M7c75U9LXga4D9Jja7nn+VtTAJpZiKV0HtzYYViGAiLXObO5fQaeRBfE+YR4ey8Kz+CQo8N7RNITZ5h1QPvX6xqpDDa/u7Ah2nLpxJHKYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynI9arLyEGXh1Vk8F49zpTkYwCK/da24pE5uUXx+b+I=;
 b=fyEF1mWUSVCELUuhlTi5+TXPbGBpNIHybTfjpyqLFzQlYARySQv5jMP47BUGFGUZvQQ3ND3ya2rSN9HvY/+7RsYAdRjVOpgzvqj399ZPdxYKSFDOaRmY804/f+80f1AeLaRR6P4UR1Xy9tRLtxCdso+0bci+Teu4xnrFD6KnHrA=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3681.namprd15.prod.outlook.com (2603:10b6:a03:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.25; Wed, 17 Jun
 2020 03:19:29 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 03:19:29 +0000
Date:   Tue, 16 Jun 2020 20:19:26 -0700
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
Subject: Re: [PATCH v6 02/19] mm: memcg: prepare for byte-sized vmstat items
Message-ID: <20200617031926.GC10812@carbon.lan>
References: <20200608230654.828134-1-guro@fb.com>
 <20200608230654.828134-3-guro@fb.com>
 <CALvZod7B9NFtAZS_cd8pPt0=BUB0sL4WuDtbOhvfMhroGs9PMg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7B9NFtAZS_cd8pPt0=BUB0sL4WuDtbOhvfMhroGs9PMg@mail.gmail.com>
X-ClientProxiedBy: BY5PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::14) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:d0dc) by BY5PR04CA0004.namprd04.prod.outlook.com (2603:10b6:a03:1d0::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Wed, 17 Jun 2020 03:19:28 +0000
X-Originating-IP: [2620:10d:c090:400::5:d0dc]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6a6173d-b430-4820-8f0e-08d8126d3f10
X-MS-TrafficTypeDiagnostic: BY5PR15MB3681:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB36818EE8D11DEDF9DDF53559BE9A0@BY5PR15MB3681.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9RAjXxlDv9IyddyVUDKmTxKSPDMPJTFEzzl8MX62ODp4zn+5gCwwwP11kzFEKdteDb0RN/O8M40/WNHaY6c0qPLMBbefZojiem+/9o+ea3icH+BcK4rVesmSluG6B95Vfv1ckTR8iGTDm5GfrIwbYzlL531XqOyAARZjGX46orq9BMIAGG4UjqbDFLxXDeD+Y9M3nFJ2avjRxxpiMsh42Zut77kk8DJe0xn7PIFMHilbkIB/MZd7oHK1Kt+Xklkiq+EEk3RESBBYR9GGj1+3IfeWZGM7lLr5v+/EKmLIT0lUO17/F+uRkZgY79BUQTTwdLRDIG0h/LkSgAhoa75QWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(366004)(396003)(376002)(39860400002)(55016002)(36756003)(54906003)(86362001)(9686003)(33656002)(66946007)(52116002)(4326008)(66556008)(316002)(7696005)(66476007)(8676002)(8936002)(53546011)(6506007)(16526019)(186003)(6916009)(1076003)(8886007)(478600001)(83380400001)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: NOQAhA2vP8tX+9KKYjmgRwbkD66T89VObucnGu7oyYbSRjJBpqn6K6U7q1ng/OOmg6dMG9k5KvvF7SEHxuAfqIYsEOdYwmYpgNO/aOSNbnKU9Q4YvU50r7JSPQ81u6GjfcrpN43/IUuy9cNjQOIKnxMT6XOj0e/cbUfqogI0PIBciVltNoT9wOFPLBSerEFtIUwFV28uZwz4VCwEHcgpiyHvVPAocXWeiMx4CcjnIDUoPS53ikvi0Do3mgtwFUfpKqha2B37sqH4wz28TWOqAvJMNdlO0LpDaqWGU8c4csfgvA43gBi6epEyCkpfJNazq2da2I/JP8vniGls5hOP1sQNFTwCQBz2dOrsgAgN0d7/ImB4Uq88dH5RKsimO9dZ1WtJaRZ2PUBgJ8QgO04PePiEtkJqAFBhKyWQSB4WLchLLaDsMzapBAaNNn2fMRywCI2bBz0LEUb1gg+vuMPfslDRYRWJL4KxJ53rDFwVBRoBaqJX/NX48kZnSofuoIkv/ztebDnzK6snJDhTgk45WQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a6173d-b430-4820-8f0e-08d8126d3f10
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 03:19:29.3808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlDch7pWPFKsk6Mi+X7F3xHltLG67Y8uXdLSSnag2m5CcH6lj5dhPahPhP2naClE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3681
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_13:2020-06-16,2020-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 cotscore=-2147483648 suspectscore=1 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006170026
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 07:57:54PM -0700, Shakeel Butt wrote:
> On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > To implement per-object slab memory accounting, we need to
> > convert slab vmstat counters to bytes. Actually, out of
> > 4 levels of counters: global, per-node, per-memcg and per-lruvec
> > only two last levels will require byte-sized counters.
> > It's because global and per-node counters will be counting the
> > number of slab pages, and per-memcg and per-lruvec will be
> > counting the amount of memory taken by charged slab objects.
> >
> > Converting all vmstat counters to bytes or even all slab
> > counters to bytes would introduce an additional overhead.
> > So instead let's store global and per-node counters
> > in pages, and memcg and lruvec counters in bytes.
> >
> > To make the API clean all access helpers (both on the read
> > and write sides) are dealing with bytes.
> >
> 
> The "dealing with bytes" is only for slab stats or all vmstat stats?

Only slab stats as now.
I've sent a percpu memory accounting patchset separately, which
will add another byte-sized counter.

> 
> > To avoid back-and-forth conversions a new flavor of read-side
> > helpers is introduced, which always returns values in pages:
> > node_page_state_pages() and global_node_page_state_pages().
> >
> > Actually new helpers are just reading raw values. Old helpers are
> > simple wrappers, which will complain on an attempt to read
> > byte value, because at the moment no one actually needs bytes.
> >
> > Thanks to Johannes Weiner for the idea of having the byte-sized API
> > on top of the page-sized internal storage.
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  drivers/base/node.c    |  2 +-
> >  include/linux/mmzone.h | 10 ++++++++++
> >  include/linux/vmstat.h | 14 +++++++++++++-
> >  mm/memcontrol.c        | 14 ++++++++++----
> >  mm/vmstat.c            | 30 ++++++++++++++++++++++++++----
> >  5 files changed, 60 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > index 5b02f69769e8..e21e31359297 100644
> > --- a/drivers/base/node.c
> > +++ b/drivers/base/node.c
> > @@ -513,7 +513,7 @@ static ssize_t node_read_vmstat(struct device *dev,
> >
> >         for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> >                 n += sprintf(buf+n, "%s %lu\n", node_stat_name(i),
> > -                            node_page_state(pgdat, i));
> > +                            node_page_state_pages(pgdat, i));
> >
> >         return n;
> >  }
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index c4c37fd12104..fa8eb49d9898 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -206,6 +206,16 @@ enum node_stat_item {
> >         NR_VM_NODE_STAT_ITEMS
> >  };
> >
> > +/*
> > + * Returns true if the value is measured in bytes (most vmstat values are
> > + * measured in pages). This defines the API part, the internal representation
> > + * might be different.
> > + */
> > +static __always_inline bool vmstat_item_in_bytes(enum node_stat_item item)
> > +{
> > +       return false;
> > +}
> > +
> >  /*
> >   * We do arithmetic on the LRU lists in various places in the code,
> >   * so it is important to keep the active lists LRU_ACTIVE higher in
> > diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> > index aa961088c551..91220ace31da 100644
> > --- a/include/linux/vmstat.h
> > +++ b/include/linux/vmstat.h
> > @@ -8,6 +8,7 @@
> >  #include <linux/vm_event_item.h>
> >  #include <linux/atomic.h>
> >  #include <linux/static_key.h>
> > +#include <linux/mmdebug.h>
> >
> >  extern int sysctl_stat_interval;
> >
> > @@ -192,7 +193,8 @@ static inline unsigned long global_zone_page_state(enum zone_stat_item item)
> >         return x;
> >  }
> >
> > -static inline unsigned long global_node_page_state(enum node_stat_item item)
> > +static inline
> > +unsigned long global_node_page_state_pages(enum node_stat_item item)
> >  {
> >         long x = atomic_long_read(&vm_node_stat[item]);
> >  #ifdef CONFIG_SMP
> > @@ -202,6 +204,13 @@ static inline unsigned long global_node_page_state(enum node_stat_item item)
> >         return x;
> >  }
> >
> > +static inline unsigned long global_node_page_state(enum node_stat_item item)
> > +{
> > +       VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
> > +
> > +       return global_node_page_state_pages(item);
> > +}
> > +
> >  static inline unsigned long zone_page_state(struct zone *zone,
> >                                         enum zone_stat_item item)
> >  {
> > @@ -242,9 +251,12 @@ extern unsigned long sum_zone_node_page_state(int node,
> >  extern unsigned long sum_zone_numa_state(int node, enum numa_stat_item item);
> >  extern unsigned long node_page_state(struct pglist_data *pgdat,
> >                                                 enum node_stat_item item);
> > +extern unsigned long node_page_state_pages(struct pglist_data *pgdat,
> > +                                          enum node_stat_item item);
> >  #else
> >  #define sum_zone_node_page_state(node, item) global_zone_page_state(item)
> >  #define node_page_state(node, item) global_node_page_state(item)
> > +#define node_page_state_pages(node, item) global_node_page_state_pages(item)
> >  #endif /* CONFIG_NUMA */
> >
> >  #ifdef CONFIG_SMP
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index e8a91e98556b..07d02e61a73e 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -681,13 +681,16 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
> >   */
> >  void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
> >  {
> > -       long x;
> > +       long x, threshold = MEMCG_CHARGE_BATCH;
> >
> >         if (mem_cgroup_disabled())
> >                 return;
> >
> > +       if (vmstat_item_in_bytes(idx))
> > +               threshold <<= PAGE_SHIFT;
> > +
> 
> From the above am I understanding correctly that even after moving to
> byte-level accounting, we can still see stats with potential error
> limited by (BATCH-1)*PAGE_SIZE*nr_cpus?
> 
> >         x = val + __this_cpu_read(memcg->vmstats_percpu->stat[idx]);
> > -       if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
> > +       if (unlikely(abs(x) > threshold)) {
> >                 struct mem_cgroup *mi;
> >
> >                 /*
> > @@ -718,7 +721,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> >  {
> >         struct mem_cgroup_per_node *pn;
> >         struct mem_cgroup *memcg;
> > -       long x;
> > +       long x, threshold = MEMCG_CHARGE_BATCH;
> >
> >         pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> >         memcg = pn->memcg;
> > @@ -729,8 +732,11 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> >         /* Update lruvec */
> >         __this_cpu_add(pn->lruvec_stat_local->count[idx], val);
> >
> > +       if (vmstat_item_in_bytes(idx))
> > +               threshold <<= PAGE_SHIFT;
> > +
> >         x = val + __this_cpu_read(pn->lruvec_stat_cpu->count[idx]);
> > -       if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
> > +       if (unlikely(abs(x) > threshold)) {
> >                 pg_data_t *pgdat = lruvec_pgdat(lruvec);
> >                 struct mem_cgroup_per_node *pi;
> >
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index 80c9b6221535..f1c321e1d6d3 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -341,6 +341,11 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
> >         long x;
> >         long t;
> >
> > +       if (vmstat_item_in_bytes(item)) {
> > +               VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
> > +               delta >>= PAGE_SHIFT;
> > +       }
> > +
> >         x = delta + __this_cpu_read(*p);
> >
> >         t = __this_cpu_read(pcp->stat_threshold);
> > @@ -398,6 +403,8 @@ void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
> >         s8 __percpu *p = pcp->vm_node_stat_diff + item;
> >         s8 v, t;
> >
> > +       VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
> > +
> >         v = __this_cpu_inc_return(*p);
> >         t = __this_cpu_read(pcp->stat_threshold);
> >         if (unlikely(v > t)) {
> > @@ -442,6 +449,8 @@ void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
> >         s8 __percpu *p = pcp->vm_node_stat_diff + item;
> >         s8 v, t;
> >
> > +       VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
> > +
> >         v = __this_cpu_dec_return(*p);
> >         t = __this_cpu_read(pcp->stat_threshold);
> >         if (unlikely(v < - t)) {
> > @@ -541,6 +550,11 @@ static inline void mod_node_state(struct pglist_data *pgdat,
> >         s8 __percpu *p = pcp->vm_node_stat_diff + item;
> >         long o, n, t, z;
> >
> > +       if (vmstat_item_in_bytes(item)) {
> > +               VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
> > +               delta >>= PAGE_SHIFT;
> > +       }
> > +
> >         do {
> >                 z = 0;  /* overflow to node counters */
> >
> > @@ -989,8 +1003,8 @@ unsigned long sum_zone_numa_state(int node,
> >  /*
> >   * Determine the per node value of a stat item.
> >   */
> > -unsigned long node_page_state(struct pglist_data *pgdat,
> > -                               enum node_stat_item item)
> > +unsigned long node_page_state_pages(struct pglist_data *pgdat,
> > +                                   enum node_stat_item item)
> >  {
> >         long x = atomic_long_read(&pgdat->vm_stat[item]);
> >  #ifdef CONFIG_SMP
> > @@ -999,6 +1013,14 @@ unsigned long node_page_state(struct pglist_data *pgdat,
> >  #endif
> >         return x;
> >  }
> > +
> > +unsigned long node_page_state(struct pglist_data *pgdat,
> > +                             enum node_stat_item item)
> > +{
> > +       VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
> > +
> > +       return node_page_state_pages(pgdat, item);
> > +}
> 
> So, for non-slab, node_page_state and node_page_state_pages will be
> the same but different for slab vmstats. However we should not be
> calling node_page_state with slab vmstats because we don't need it,
> right?

Right.
