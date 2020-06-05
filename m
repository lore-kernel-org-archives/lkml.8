Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D170FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E72206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="P4hSz3Ez";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="X9S+9a2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgFEWor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 18:44:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30576 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728256AbgFEWoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 18:44:46 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 055MdIPI026423;
        Fri, 5 Jun 2020 15:44:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=OtV3XVdhLX2dH9D0qfHybW0PbEsiX3lybz6uYy9yZo0=;
 b=P4hSz3EzvarQ1e3GlL17JxelpGgmggdAInP9f2q4zIA2joKBR0eQH3cKV5r8d3VVZl6r
 vXvta/vuQQpXxoFtT8BxvPu29iqTjWRTv0yccidy31tIcj9hkNXjks1ITrkn37Cy32kS
 ae3IMSRG+DPgV8o17OjC9DAoP0yD38r6iHI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31f9005w2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Jun 2020 15:44:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Jun 2020 15:44:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nc42n0xolPh+Pu7I8frYrX/acNS92gTmw8vGFxnYCu9ofisEMTL3YDVzgGpcQQptNt8qSnxXAxm2Dzb3owLBbhZXBsD6Wf5aVmdK3fXQTChNNcpogR2oapM1X8ySMo8aRlmx8nQO9b9MnYLZbbX6HNnQx5UFhRxa3/WzFbb2CkBWkCGTZBX5nolZcIEKw8SBGAlq1XsVQVmn0El1yN++G/OkSdr5zUCf2POjAqPSJHsYXPuUZ7YfiRNOu+79OIEjnD8pk71vT//TXsAEUVypABCprGkl1ve4y6aTb/hAktnJOS3n3EidOBGSL/a8qYoVDeFxEtiXrRGYthchJNIGXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtV3XVdhLX2dH9D0qfHybW0PbEsiX3lybz6uYy9yZo0=;
 b=Y5V7UUyYJK7N6ijcU8EqEyuODj9NszknAcuR8WzmOmYOgqltbT6XqHFOkDmGQ4+v93AVDyTi2In+R+KzFOY4rXnkZZcBsf6SR1A+CXB49vpWJFiXb5JhbyDgLNe8PnyLk51H0TViDm2pYPu86kccXwvaMAs3BZlqtSQSfc8YmZfFB+OG4nvXq+Y9rjpl+GHKjEdp7ShiUqlNpyOWkLWTBOzZRHVTyhELngO1vA9KpViTQ4a+9MhAiTABHIIkdv39z3Sk3Pas/xP66t9ugma9wopA0C4URN4dHNlOit0goKFSMU/xwRwmUbhNWuq+GwvNMENBJLDW5A0Yt0MC9kTkew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtV3XVdhLX2dH9D0qfHybW0PbEsiX3lybz6uYy9yZo0=;
 b=X9S+9a2AUyJbMTTiHWfJOaQl/LtjNQjxQrmz8gYg8lcZLkt4jzv/r/KNcSKxxU1DWnWEk023F7ZVztSeM6663eUCeKU8/YpO+8xu5aeyMMb+JXimuHPQxRui+EYymvufk3HLBWQ4NCXZTkSfy6uRs4wTMq4BJ0x69tn1TQb3zYI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2293.namprd15.prod.outlook.com (2603:10b6:a02:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 22:44:30 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 22:44:30 +0000
Date:   Fri, 5 Jun 2020 15:44:27 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/5] mm: memcg/percpu: account percpu memory to memory
 cgroups
Message-ID: <20200605224427.GC561977@carbon.DHCP.thefacebook.com>
References: <20200528232508.1132382-1-guro@fb.com>
 <20200528232508.1132382-3-guro@fb.com>
 <20200605194953.GB224745@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605194953.GB224745@google.com>
X-ClientProxiedBy: BYAPR07CA0077.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:a382) by BYAPR07CA0077.namprd07.prod.outlook.com (2603:10b6:a03:12b::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 22:44:29 +0000
X-Originating-IP: [2620:10d:c090:400::5:a382]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d303442c-ccb0-4812-a1ea-08d809a20266
X-MS-TrafficTypeDiagnostic: BYAPR15MB2293:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB22930EF4FA5479B65D45B3A6BE860@BYAPR15MB2293.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xnNsA4ygICpagPlzv1FvO0PkIb8WAvN0cNeIAc2lr8XXkJ0TxCH/zpMbpEr5Up3vGeeDnPiNNFycSWGEkbPR/gFrKjFjxRFFaPi/d/Bs51xfXACLa8FeTVQnQzjhjkBtzOsVECV1mvgZv97tjvcDSU/7YkxArrfdkpTx5VorjgdRimxAuLXEmoHEoLZrR5TqxX4SE8J+c4xLPoAnjqK0//eqBOOuofJ5BYffiBxXZBbVdOUBwdrzDLu6k3UDZn5gq9LFF1ihCnpg3rFDrqsfYds6ywUWahHhlVDJY+RtxUzPNOKTDOucPIRk7/a1kigr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(376002)(136003)(39860400002)(366004)(15650500001)(54906003)(8676002)(186003)(16526019)(6506007)(83380400001)(8936002)(55016002)(9686003)(4326008)(316002)(1076003)(2906002)(66946007)(30864003)(86362001)(33656002)(6916009)(52116002)(66476007)(66556008)(5660300002)(7696005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: BwuUaiSlfUeqOuLaUaC4ARBnO39wlseYhkB1TLu2o8XvXc2ItgZgekYCcm/J9hHnlterxnL5s/gYCtccaXhe4wk1VwPYzwHSVjcvG1DUVX4S9VRc8q//b/LHdtBJdFDjo2wMgrR5SwlW52YNKcxZBlzDo5afNXPzmquW00cNctHmO+YU1J8vihOPse6tmLle4/FiHQ7Eu8joV8YrGt2I9lK2CWFp6R9oFZVa6QuxuRQjpiaSpGwfHIeKNL8y3szyL2itY1CZ48vACDG0DdZBHAzLp+oylwp0USH7eZ85RKM4GGYJfKUISEl6zbDXFaP4Njysx8tPBc/qLVFw5VEuifI/LWCl+v9pg6oxNyOPlxT7VGsqeJCfiC36Xu59NK8QZpUEQMpZz/co/0T28TyX86pUbIuvxzL4+hR2+Yok2/KVyfMTByzmhkv6icqHN26liPGWLHgDiP+QL/8o4eNCVLFVsEF6iR6Xfs3wfBsOkm10Cycm4PYi1zFM9A8KyGOZRgHhIuh5MetUmNQGBWly6w==
X-MS-Exchange-CrossTenant-Network-Message-Id: d303442c-ccb0-4812-a1ea-08d809a20266
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 22:44:30.5326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZ07V+8TgfGdbIFwAZLDwiDcFBNuIZufE+KL1Ou1ZA/XAeKHsUlX5T2mmx4EqGY/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2293
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_07:2020-06-04,2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=5 priorityscore=1501
 phishscore=0 bulkscore=0 cotscore=-2147483648 adultscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050167
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 07:49:53PM +0000, Dennis Zhou wrote:
> On Thu, May 28, 2020 at 04:25:05PM -0700, Roman Gushchin wrote:
> > Percpu memory is becoming more and more widely used by various
> > subsystems, and the total amount of memory controlled by the percpu
> > allocator can make a good part of the total memory.
> > 
> > As an example, bpf maps can consume a lot of percpu memory,
> > and they are created by a user. Also, some cgroup internals
> > (e.g. memory controller statistics) can be quite large.
> > On a machine with many CPUs and big number of cgroups they
> > can consume hundreds of megabytes.
> > 
> > So the lack of memcg accounting is creating a breach in the memory
> > isolation. Similar to the slab memory, percpu memory should be
> > accounted by default.
> > 
> > To implement the perpcu accounting it's possible to take the slab
> > memory accounting as a model to follow. Let's introduce two types of
> > percpu chunks: root and memcg. What makes memcg chunks different is
> > an additional space allocated to store memcg membership information.
> > If __GFP_ACCOUNT is passed on allocation, a memcg chunk should be be
> > used. If it's possible to charge the corresponding size to the target
> > memory cgroup, allocation is performed, and the memcg ownership data
> > is recorded. System-wide allocations are performed using root chunks,
> > so there is no additional memory overhead.
> > 
> > To implement a fast reparenting of percpu memory on memcg removal,
> > we don't store mem_cgroup pointers directly: instead we use obj_cgroup
> > API, introduced for slab accounting.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  mm/percpu-internal.h |  57 ++++++++++++-
> >  mm/percpu-km.c       |   5 +-
> >  mm/percpu-stats.c    |  36 +++++----
> >  mm/percpu-vm.c       |   5 +-
> >  mm/percpu.c          | 186 ++++++++++++++++++++++++++++++++++++++-----
> >  5 files changed, 248 insertions(+), 41 deletions(-)
> > 
> > diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
> > index 0468ba500bd4..0cf36337eb47 100644
> > --- a/mm/percpu-internal.h
> > +++ b/mm/percpu-internal.h
> > @@ -5,6 +5,27 @@
> >  #include <linux/types.h>
> >  #include <linux/percpu.h>
> >  
> > +/*
> > + * There are two chunk types: root and memcg-aware.
> > + * Chunks of each type have separate slots list.
> > + *
> > + * Memcg-aware chunks have an attached vector of obj_cgroup
> > + * pointers, which is used to store memcg membership data
> > + * of a percpu object. Obj_cgroups are ref-counted pointers
> > + * to a memory cgroup with an ability to switch dynamically
> > + * to the parent memory cgroup. This allows to reclaim a deleted
> > + * memory cgroup without reclaiming of all outstanding objects,
> > + * which do hold a reference at it.
> > + */
> 
> nit: do you mind reflowing this to 80 characters and doing 2 spaces
> after each period to keep the formatting uniform.
> 
> > +enum pcpu_chunk_type {
> > +	PCPU_CHUNK_ROOT,
> > +#ifdef CONFIG_MEMCG_KMEM
> > +	PCPU_CHUNK_MEMCG,
> > +#endif
> > +	PCPU_NR_CHUNK_TYPES,
> > +	PCPU_FAIL_ALLOC = PCPU_NR_CHUNK_TYPES
> > +};
> > +
> >  /*
> >   * pcpu_block_md is the metadata block struct.
> >   * Each chunk's bitmap is split into a number of full blocks.
> > @@ -54,6 +75,9 @@ struct pcpu_chunk {
> >  	int			end_offset;	/* additional area required to
> >  						   have the region end page
> >  						   aligned */
> > +#ifdef CONFIG_MEMCG_KMEM
> > +	struct obj_cgroup	**obj_cgroups;	/* vector of object cgroups */
> > +#endif
> >  
> >  	int			nr_pages;	/* # of pages served by this chunk */
> >  	int			nr_populated;	/* # of populated pages */
> > @@ -63,7 +87,7 @@ struct pcpu_chunk {
> >  
> >  extern spinlock_t pcpu_lock;
> >  
> > -extern struct list_head *pcpu_slot;
> > +extern struct list_head *pcpu_chunk_lists;
> >  extern int pcpu_nr_slots;
> >  extern int pcpu_nr_empty_pop_pages;
> >  
> > @@ -106,6 +130,37 @@ static inline int pcpu_chunk_map_bits(struct pcpu_chunk *chunk)
> >  	return pcpu_nr_pages_to_map_bits(chunk->nr_pages);
> >  }
> >  
> > +#ifdef CONFIG_MEMCG_KMEM
> > +static enum pcpu_chunk_type pcpu_chunk_type(struct pcpu_chunk *chunk)
> > +{
> > +	if (chunk->obj_cgroups)
> > +		return PCPU_CHUNK_MEMCG;
> > +	return PCPU_CHUNK_ROOT;
> > +}
> > +
> > +static bool pcpu_is_memcg_chunk(enum pcpu_chunk_type chunk_type)
> > +{
> > +	return chunk_type == PCPU_CHUNK_MEMCG;
> > +}
> > +
> > +#else
> > +static enum pcpu_chunk_type pcpu_chunk_type(struct pcpu_chunk *chunk)
> > +{
> > +	return PCPU_CHUNK_ROOT;
> > +}
> > +
> > +static bool pcpu_is_memcg_chunk(enum pcpu_chunk_type chunk_type)
> > +{
> > +	return false;
> > +}
> > +#endif
> > +
> > +static struct list_head *pcpu_chunk_list(enum pcpu_chunk_type chunk_type)
> > +{
> > +	return &pcpu_chunk_lists[pcpu_nr_slots *
> > +				 pcpu_is_memcg_chunk(chunk_type)];
> > +}
> > +
> >  #ifdef CONFIG_PERCPU_STATS
> >  
> >  #include <linux/spinlock.h>
> > diff --git a/mm/percpu-km.c b/mm/percpu-km.c
> > index 20d2b69a13b0..35c9941077ee 100644
> > --- a/mm/percpu-km.c
> > +++ b/mm/percpu-km.c
> > @@ -44,7 +44,8 @@ static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
> >  	/* nada */
> >  }
> >  
> > -static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
> > +static struct pcpu_chunk *pcpu_create_chunk(enum pcpu_chunk_type type,
> > +					    gfp_t gfp)
> >  {
> >  	const int nr_pages = pcpu_group_sizes[0] >> PAGE_SHIFT;
> >  	struct pcpu_chunk *chunk;
> > @@ -52,7 +53,7 @@ static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
> >  	unsigned long flags;
> >  	int i;
> >  
> > -	chunk = pcpu_alloc_chunk(gfp);
> > +	chunk = pcpu_alloc_chunk(type, gfp);
> >  	if (!chunk)
> >  		return NULL;
> >  
> > diff --git a/mm/percpu-stats.c b/mm/percpu-stats.c
> > index 32558063c3f9..c8400a2adbc2 100644
> > --- a/mm/percpu-stats.c
> > +++ b/mm/percpu-stats.c
> > @@ -34,11 +34,15 @@ static int find_max_nr_alloc(void)
> >  {
> >  	struct pcpu_chunk *chunk;
> >  	int slot, max_nr_alloc;
> > +	enum pcpu_chunk_type type;
> >  
> >  	max_nr_alloc = 0;
> > -	for (slot = 0; slot < pcpu_nr_slots; slot++)
> > -		list_for_each_entry(chunk, &pcpu_slot[slot], list)
> > -			max_nr_alloc = max(max_nr_alloc, chunk->nr_alloc);
> > +	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++)
> > +		for (slot = 0; slot < pcpu_nr_slots; slot++)
> > +			list_for_each_entry(chunk, &pcpu_chunk_list(type)[slot],
> > +					    list)
> > +				max_nr_alloc = max(max_nr_alloc,
> > +						   chunk->nr_alloc);
> >  
> >  	return max_nr_alloc;
> >  }
> > @@ -129,6 +133,9 @@ static void chunk_map_stats(struct seq_file *m, struct pcpu_chunk *chunk,
> >  	P("cur_min_alloc", cur_min_alloc);
> >  	P("cur_med_alloc", cur_med_alloc);
> >  	P("cur_max_alloc", cur_max_alloc);
> > +#ifdef CONFIG_MEMCG_KMEM
> > +	P("memcg_aware", pcpu_is_memcg_chunk(pcpu_chunk_type(chunk)));
> > +#endif
> >  	seq_putc(m, '\n');
> >  }
> >  
> > @@ -137,6 +144,7 @@ static int percpu_stats_show(struct seq_file *m, void *v)
> >  	struct pcpu_chunk *chunk;
> >  	int slot, max_nr_alloc;
> >  	int *buffer;
> > +	enum pcpu_chunk_type type;
> >  
> >  alloc_buffer:
> >  	spin_lock_irq(&pcpu_lock);
> > @@ -202,18 +210,18 @@ static int percpu_stats_show(struct seq_file *m, void *v)
> >  		chunk_map_stats(m, pcpu_reserved_chunk, buffer);
> >  	}
> >  
> > -	for (slot = 0; slot < pcpu_nr_slots; slot++) {
> > -		list_for_each_entry(chunk, &pcpu_slot[slot], list) {
> > -			if (chunk == pcpu_first_chunk) {
> > -				seq_puts(m, "Chunk: <- First Chunk\n");
> > -				chunk_map_stats(m, chunk, buffer);
> > -
> > -
> > -			} else {
> > -				seq_puts(m, "Chunk:\n");
> > -				chunk_map_stats(m, chunk, buffer);
> > +	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++) {
> > +		for (slot = 0; slot < pcpu_nr_slots; slot++) {
> > +			list_for_each_entry(chunk, &pcpu_chunk_list(type)[slot],
> > +					    list) {
> > +				if (chunk == pcpu_first_chunk) {
> > +					seq_puts(m, "Chunk: <- First Chunk\n");
> > +					chunk_map_stats(m, chunk, buffer);
> > +				} else {
> > +					seq_puts(m, "Chunk:\n");
> > +					chunk_map_stats(m, chunk, buffer);
> > +				}
> >  			}
> > -
> >  		}
> >  	}
> >  
> > diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
> > index a2b395acef89..e46f7a6917f9 100644
> > --- a/mm/percpu-vm.c
> > +++ b/mm/percpu-vm.c
> > @@ -328,12 +328,13 @@ static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
> >  	pcpu_free_pages(chunk, pages, page_start, page_end);
> >  }
> >  
> > -static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
> > +static struct pcpu_chunk *pcpu_create_chunk(enum pcpu_chunk_type type,
> > +					    gfp_t gfp)
> >  {
> >  	struct pcpu_chunk *chunk;
> >  	struct vm_struct **vms;
> >  
> > -	chunk = pcpu_alloc_chunk(gfp);
> > +	chunk = pcpu_alloc_chunk(type, gfp);
> >  	if (!chunk)
> >  		return NULL;
> >  
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index aa36b78d45a6..85f5755c9114 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -37,9 +37,14 @@
> >   * takes care of normal allocations.
> >   *
> >   * The allocator organizes chunks into lists according to free size and
> > - * tries to allocate from the fullest chunk first.  Each chunk is managed
> > - * by a bitmap with metadata blocks.  The allocation map is updated on
> > - * every allocation and free to reflect the current state while the boundary
> > + * memcg-awareness.  To make a percpu allocation memcg-aware the __GFP_ACCOUNT
> > + * flag should be passed.  All memcg-aware allocations are sharing one set
> > + * of chunks and all unaccounted allocations and allocations performed
> > + * by processes belonging to the root memory cgroup are using the second set.
> > + *
> > + * The allocator tries to allocate from the fullest chunk first. Each chunk
> > + * is managed by a bitmap with metadata blocks.  The allocation map is updated
> > + * on every allocation and free to reflect the current state while the boundary
> >   * map is only updated on allocation.  Each metadata block contains
> >   * information to help mitigate the need to iterate over large portions
> >   * of the bitmap.  The reverse mapping from page to chunk is stored in
> > @@ -81,6 +86,7 @@
> >  #include <linux/kmemleak.h>
> >  #include <linux/sched.h>
> >  #include <linux/sched/mm.h>
> > +#include <linux/memcontrol.h>
> >  
> >  #include <asm/cacheflush.h>
> >  #include <asm/sections.h>
> > @@ -160,7 +166,7 @@ struct pcpu_chunk *pcpu_reserved_chunk __ro_after_init;
> >  DEFINE_SPINLOCK(pcpu_lock);	/* all internal data structures */
> >  static DEFINE_MUTEX(pcpu_alloc_mutex);	/* chunk create/destroy, [de]pop, map ext */
> >  
> > -struct list_head *pcpu_slot __ro_after_init; /* chunk list slots */
> > +struct list_head *pcpu_chunk_lists __ro_after_init; /* chunk list slots */
> >  
> >  /* chunks which need their map areas extended, protected by pcpu_lock */
> >  static LIST_HEAD(pcpu_map_extend_chunks);
> > @@ -500,6 +506,9 @@ static void __pcpu_chunk_move(struct pcpu_chunk *chunk, int slot,
> >  			      bool move_front)
> >  {
> >  	if (chunk != pcpu_reserved_chunk) {
> > +		struct list_head *pcpu_slot;
> > +
> > +		pcpu_slot = pcpu_chunk_list(pcpu_chunk_type(chunk));
> >  		if (move_front)
> >  			list_move(&chunk->list, &pcpu_slot[slot]);
> >  		else
> > @@ -1341,6 +1350,10 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
> >  		panic("%s: Failed to allocate %zu bytes\n", __func__,
> >  		      alloc_size);
> >  
> > +#ifdef CONFIG_MEMCG_KMEM
> > +	/* first chunk isn't memcg-aware */
> > +	chunk->obj_cgroups = NULL;
> > +#endif
> >  	pcpu_init_md_blocks(chunk);
> >  
> >  	/* manage populated page bitmap */
> > @@ -1380,7 +1393,7 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
> >  	return chunk;
> >  }
> >  
> > -static struct pcpu_chunk *pcpu_alloc_chunk(gfp_t gfp)
> > +static struct pcpu_chunk *pcpu_alloc_chunk(enum pcpu_chunk_type type, gfp_t gfp)
> >  {
> >  	struct pcpu_chunk *chunk;
> >  	int region_bits;
> > @@ -1408,6 +1421,16 @@ static struct pcpu_chunk *pcpu_alloc_chunk(gfp_t gfp)
> >  	if (!chunk->md_blocks)
> >  		goto md_blocks_fail;
> >  
> > +#ifdef CONFIG_MEMCG_KMEM
> > +	if (pcpu_is_memcg_chunk(type)) {
> > +		chunk->obj_cgroups =
> > +			pcpu_mem_zalloc(pcpu_chunk_map_bits(chunk) *
> > +					sizeof(struct obj_cgroup *), gfp);
> > +		if (!chunk->obj_cgroups)
> > +			goto objcg_fail;
> > +	}
> > +#endif
> > +
> >  	pcpu_init_md_blocks(chunk);
> >  
> >  	/* init metadata */
> > @@ -1415,6 +1438,8 @@ static struct pcpu_chunk *pcpu_alloc_chunk(gfp_t gfp)
> >  
> >  	return chunk;
> >  
> > +objcg_fail:
> > +	pcpu_mem_free(chunk->md_blocks);
> >  md_blocks_fail:
> >  	pcpu_mem_free(chunk->bound_map);
> >  bound_map_fail:
> > @@ -1429,6 +1454,9 @@ static void pcpu_free_chunk(struct pcpu_chunk *chunk)
> >  {
> >  	if (!chunk)
> >  		return;
> > +#ifdef CONFIG_MEMCG_KMEM
> > +	pcpu_mem_free(chunk->obj_cgroups);
> > +#endif
> >  	pcpu_mem_free(chunk->md_blocks);
> >  	pcpu_mem_free(chunk->bound_map);
> >  	pcpu_mem_free(chunk->alloc_map);
> > @@ -1505,7 +1533,8 @@ static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
> >  			       int page_start, int page_end, gfp_t gfp);
> >  static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
> >  				  int page_start, int page_end);
> > -static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp);
> > +static struct pcpu_chunk *pcpu_create_chunk(enum pcpu_chunk_type type,
> > +					    gfp_t gfp);
> >  static void pcpu_destroy_chunk(struct pcpu_chunk *chunk);
> >  static struct page *pcpu_addr_to_page(void *addr);
> >  static int __init pcpu_verify_alloc_info(const struct pcpu_alloc_info *ai);
> > @@ -1547,6 +1576,77 @@ static struct pcpu_chunk *pcpu_chunk_addr_search(void *addr)
> >  	return pcpu_get_page_chunk(pcpu_addr_to_page(addr));
> >  }
> >  
> > +#ifdef CONFIG_MEMCG_KMEM
> > +static enum pcpu_chunk_type pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
> > +						     struct obj_cgroup **objcgp)
> > +{
> > +	struct obj_cgroup *objcg;
> > +
> > +	if (!memcg_kmem_enabled() || !(gfp & __GFP_ACCOUNT) ||
> > +	    memcg_kmem_bypass())
> > +		return PCPU_CHUNK_ROOT;
> > +
> > +	objcg = get_obj_cgroup_from_current();
> > +	if (!objcg)
> > +		return PCPU_CHUNK_ROOT;
> > +
> > +	if (obj_cgroup_charge(objcg, gfp, size * num_possible_cpus())) {
> > +		obj_cgroup_put(objcg);
> > +		return PCPU_FAIL_ALLOC;
> > +	}
> > +
> > +	*objcgp = objcg;
> > +	return PCPU_CHUNK_MEMCG;
> > +}
> > +
> > +static void pcpu_memcg_post_alloc_hook(struct obj_cgroup *objcg,
> > +				       struct pcpu_chunk *chunk, int off,
> > +				       size_t size)
> > +{
> > +	if (!objcg)
> > +		return;
> > +
> > +	if (chunk) {
> > +		chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = objcg;
> > +	} else {
> > +		obj_cgroup_uncharge(objcg, size * num_possible_cpus());
> > +		obj_cgroup_put(objcg);
> > +	}
> > +}
> > +
> > +static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
> > +{
> > +	struct obj_cgroup *objcg;
> > +
> > +	if (!pcpu_is_memcg_chunk(pcpu_chunk_type(chunk)))
> > +		return;
> > +
> > +	objcg = chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT];
> > +	chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = NULL;
> > +
> > +	obj_cgroup_uncharge(objcg, size * num_possible_cpus());
> > +
> > +	obj_cgroup_put(objcg);
> > +}
> > +
> > +#else /* CONFIG_MEMCG_KMEM */
> > +static enum pcpu_chunk_type pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
> > +						     struct mem_cgroup **memcgp)
> > +{
> > +	return PCPU_CHUNK_ROOT;
> > +}
> > +
> > +static void pcpu_memcg_post_alloc_hook(struct mem_cgroup *memcg,
> > +				       struct pcpu_chunk *chunk, int off,
> > +				       size_t size)
> > +{
> > +}
> > +
> > +static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
> > +{
> > +}
> > +#endif /* CONFIG_MEMCG_KMEM */
> > +
> >  /**
> >   * pcpu_alloc - the percpu allocator
> >   * @size: size of area to allocate in bytes
> > @@ -1568,6 +1668,9 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
> >  	gfp_t pcpu_gfp;
> >  	bool is_atomic;
> >  	bool do_warn;
> > +	enum pcpu_chunk_type type;
> > +	struct list_head *pcpu_slot;
> > +	struct obj_cgroup *objcg = NULL;
> >  	static int warn_limit = 10;
> >  	struct pcpu_chunk *chunk, *next;
> >  	const char *err;
> > @@ -1602,16 +1705,23 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
> >  		return NULL;
> >  	}
> >  
> > +	type = pcpu_memcg_pre_alloc_hook(size, gfp, &objcg);
> > +	if (unlikely(type == PCPU_FAIL_ALLOC))
> > +		return NULL;
> > +	pcpu_slot = pcpu_chunk_list(type);
> > +
> >  	if (!is_atomic) {
> >  		/*
> >  		 * pcpu_balance_workfn() allocates memory under this mutex,
> >  		 * and it may wait for memory reclaim. Allow current task
> >  		 * to become OOM victim, in case of memory pressure.
> >  		 */
> > -		if (gfp & __GFP_NOFAIL)
> > +		if (gfp & __GFP_NOFAIL) {
> >  			mutex_lock(&pcpu_alloc_mutex);
> > -		else if (mutex_lock_killable(&pcpu_alloc_mutex))
> > +		} else if (mutex_lock_killable(&pcpu_alloc_mutex)) {
> > +			pcpu_memcg_post_alloc_hook(objcg, NULL, 0, size);
> >  			return NULL;
> > +		}
> >  	}
> >  
> >  	spin_lock_irqsave(&pcpu_lock, flags);
> > @@ -1637,7 +1747,8 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
> >  restart:
> >  	/* search through normal chunks */
> >  	for (slot = pcpu_size_to_slot(size); slot < pcpu_nr_slots; slot++) {
> > -		list_for_each_entry_safe(chunk, next, &pcpu_slot[slot], list) {
> > +		list_for_each_entry_safe(chunk, next, &pcpu_slot[slot],
> > +					 list) {
> 
> nit: this line change doesn't do anything. Can you please remove it.
> 
> >  			off = pcpu_find_block_fit(chunk, bits, bit_align,
> >  						  is_atomic);
> >  			if (off < 0) {
> > @@ -1666,7 +1777,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
> >  	}
> >  
> >  	if (list_empty(&pcpu_slot[pcpu_nr_slots - 1])) {
> > -		chunk = pcpu_create_chunk(pcpu_gfp);
> > +		chunk = pcpu_create_chunk(type, pcpu_gfp);
> >  		if (!chunk) {
> >  			err = "failed to allocate new chunk";
> >  			goto fail;
> > @@ -1723,6 +1834,8 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
> >  	trace_percpu_alloc_percpu(reserved, is_atomic, size, align,
> >  			chunk->base_addr, off, ptr);
> >  
> > +	pcpu_memcg_post_alloc_hook(objcg, chunk, off, size);
> > +
> >  	return ptr;
> >  
> >  fail_unlock:
> > @@ -1744,6 +1857,9 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
> >  	} else {
> >  		mutex_unlock(&pcpu_alloc_mutex);
> >  	}
> > +
> > +	pcpu_memcg_post_alloc_hook(objcg, NULL, 0, size);
> > +
> >  	return NULL;
> >  }
> >  
> > @@ -1803,8 +1919,8 @@ void __percpu *__alloc_reserved_percpu(size_t size, size_t align)
> >  }
> >  
> >  /**
> > - * pcpu_balance_workfn - manage the amount of free chunks and populated pages
> > - * @work: unused
> > + * __pcpu_balance_workfn - manage the amount of free chunks and populated pages
> > + * @type: chunk type
> >   *
> >   * Reclaim all fully free chunks except for the first one.  This is also
> >   * responsible for maintaining the pool of empty populated pages.  However,
> > @@ -1813,11 +1929,12 @@ void __percpu *__alloc_reserved_percpu(size_t size, size_t align)
> >   * allocation causes the failure as it is possible that requests can be
> >   * serviced from already backed regions.
> >   */
> > -static void pcpu_balance_workfn(struct work_struct *work)
> > +static void __pcpu_balance_workfn(enum pcpu_chunk_type type)
> >  {
> >  	/* gfp flags passed to underlying allocators */
> >  	const gfp_t gfp = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
> >  	LIST_HEAD(to_free);
> > +	struct list_head *pcpu_slot = pcpu_chunk_list(type);
> >  	struct list_head *free_head = &pcpu_slot[pcpu_nr_slots - 1];
> >  	struct pcpu_chunk *chunk, *next;
> >  	int slot, nr_to_pop, ret;
> > @@ -1915,7 +2032,7 @@ static void pcpu_balance_workfn(struct work_struct *work)
> >  
> >  	if (nr_to_pop) {
> >  		/* ran out of chunks to populate, create a new one and retry */
> > -		chunk = pcpu_create_chunk(gfp);
> > +		chunk = pcpu_create_chunk(type, gfp);
> >  		if (chunk) {
> >  			spin_lock_irq(&pcpu_lock);
> >  			pcpu_chunk_relocate(chunk, -1);
> > @@ -1927,6 +2044,20 @@ static void pcpu_balance_workfn(struct work_struct *work)
> >  	mutex_unlock(&pcpu_alloc_mutex);
> >  }
> >  
> > +/**
> > + * pcpu_balance_workfn - manage the amount of free chunks and populated pages
> > + * @work: unused
> > + *
> > + * Call __pcpu_balance_workfn() for each chunk type.
> > + */
> > +static void pcpu_balance_workfn(struct work_struct *work)
> > +{
> > +	enum pcpu_chunk_type type;
> > +
> > +	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++)
> > +		__pcpu_balance_workfn(type);
> > +}
> > +
> >  /**
> >   * free_percpu - free percpu area
> >   * @ptr: pointer to area to free
> > @@ -1941,8 +2072,9 @@ void free_percpu(void __percpu *ptr)
> >  	void *addr;
> >  	struct pcpu_chunk *chunk;
> >  	unsigned long flags;
> > -	int off;
> > +	int size, off;
> >  	bool need_balance = false;
> > +	struct list_head *pcpu_slot;
> >  
> >  	if (!ptr)
> >  		return;
> > @@ -1956,7 +2088,11 @@ void free_percpu(void __percpu *ptr)
> >  	chunk = pcpu_chunk_addr_search(addr);
> >  	off = addr - chunk->base_addr;
> >  
> > -	pcpu_free_area(chunk, off);
> > +	size = pcpu_free_area(chunk, off);
> > +
> > +	pcpu_slot = pcpu_chunk_list(pcpu_chunk_type(chunk));
> > +
> > +	pcpu_memcg_free_hook(chunk, off, size);
> >  
> >  	/* if there are more than one fully free chunks, wake up grim reaper */
> >  	if (chunk->free_bytes == pcpu_unit_size) {
> > @@ -2267,6 +2403,7 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
> >  	int map_size;
> >  	unsigned long tmp_addr;
> >  	size_t alloc_size;
> > +	enum pcpu_chunk_type type;
> >  
> >  #define PCPU_SETUP_BUG_ON(cond)	do {					\
> >  	if (unlikely(cond)) {						\
> > @@ -2384,13 +2521,18 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
> >  	 * empty chunks.
> >  	 */
> >  	pcpu_nr_slots = __pcpu_size_to_slot(pcpu_unit_size) + 2;
> > -	pcpu_slot = memblock_alloc(pcpu_nr_slots * sizeof(pcpu_slot[0]),
> > -				   SMP_CACHE_BYTES);
> > -	if (!pcpu_slot)
> > +	pcpu_chunk_lists = memblock_alloc(pcpu_nr_slots *
> > +					  sizeof(pcpu_chunk_lists[0]) *
> > +					  PCPU_NR_CHUNK_TYPES,
> > +					  SMP_CACHE_BYTES);
> > +	if (!pcpu_chunk_lists)
> >  		panic("%s: Failed to allocate %zu bytes\n", __func__,
> > -		      pcpu_nr_slots * sizeof(pcpu_slot[0]));
> > -	for (i = 0; i < pcpu_nr_slots; i++)
> > -		INIT_LIST_HEAD(&pcpu_slot[i]);
> > +		      pcpu_nr_slots * sizeof(pcpu_chunk_lists[0]) *
> > +		      PCPU_NR_CHUNK_TYPES);
> > +
> > +	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++)
> > +		for (i = 0; i < pcpu_nr_slots; i++)
> > +			INIT_LIST_HEAD(&pcpu_chunk_list(type)[i]);
> >  
> >  	/*
> >  	 * The end of the static region needs to be aligned with the
> > -- 
> > 2.25.4
> > 
> 
> There were just 2 minor nits. Do you mind resending with them fixed as
> I'm not sure I'll be carrying these patches or not.

Sure, will send v2 based on the slab controller v6 early next week.

> 
> Acked-by: Dennis Zhou <dennis@kernel.org>

Thank you!
