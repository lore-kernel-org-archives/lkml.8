Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8E0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F285206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Ac0Fjolr";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="AFlTw+EI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbgF3SgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:36:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32842 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725963AbgF3SgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:36:20 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05UIXe3X021800;
        Tue, 30 Jun 2020 11:36:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=W+L/0aSUNaRiwZzxfdfKelyMkMLJwRaY4stilb831iQ=;
 b=Ac0FjolrSnfbzTr4ioxUZR6KZPZBiKUIF+/MjbMxjvG2RA6ZkhnSJlEWt5c1T92RkbIS
 wnBs9ckzv4+3GUD+LSs35igTs3fRPe8My4fXd66X0kBXiCreUbgISfebrfOzidbA40Ae
 P4o7I1CX2GdNvs8XgjsM/ncMZuMljaR5/3Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31x3xgwvhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Jun 2020 11:36:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 30 Jun 2020 11:36:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmFRjhx20t7lICObEKE4TWi9gbjJFN0G74U45YvrD0k4kggwINeZJkZD4xCsJzMvYFn+39wGVR8mlEHfrtGRSHDyEMjhMuOgKvuPIrwPxt8C3urGDy7Oz6rnmr9Hlu8bRVOlPPAV38o6LnxbLhNhtKicuU8VK/7VK1cNn/qAfev6JJJpspCgv3SPPv2RkyxT9Boh/YXD2+784gbXG+oE4b8Y2UtZd5+tDTFgIIHc1yh8rnWkJaTJJVUajA98k22yedTU2wxXHLy8+GzQpEHZuAnfCOSXVStQpH6zVmJgXT0MLNRfybO/vta7FgNF4O0+Mx57RPma2fh2yugkPAu1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+L/0aSUNaRiwZzxfdfKelyMkMLJwRaY4stilb831iQ=;
 b=azQYcoMn5AJyXy1Vt1nTfAANSdHudybSXXPLS+lt3xiChOiJANVaAdPX9mcRS+C03+Mu90AOREtggSM/1Br8vqRLrik202HbZqdsIPUNTis2j6oC1vd+qOcxodXU8GfGfzcQLP2AVqJS2m/mj9tp1jQbstjBmZ7C+569X1sMk4Xt79WYc3AkFQe/w+BlhTKN4b65e9feIGFufsMSeEORJ1Yq3s+voAidi7jVgK/b6m4hWq/R8ZhdxMlKisdiIbPMQ0XYEZ12Dw4RA1OBDytVgCfp4C1MdBYuzsPZBt3Am0XR8hvrKS4g7VJt+09NJ9GqfJoV/GKTrzmbOmUcOdDUOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+L/0aSUNaRiwZzxfdfKelyMkMLJwRaY4stilb831iQ=;
 b=AFlTw+EIMZSTBv9CWcp1RZPW7lZO4vOkxkN+1YQPsizoFKB/uyqQb4sCKU1N/3kMjb1Oul+o7M3oeubAxr1HhfvotIQwf67/LBlZCDDye6vPjcXIZAlcMD1i6ULD1p/B/SYsE4BRKVLGcPooaSYN/dOeQbEhX+AmgbYaXMyWtc4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2632.namprd15.prod.outlook.com (2603:10b6:a03:152::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 18:36:08 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 18:36:08 +0000
Date:   Tue, 30 Jun 2020 11:36:05 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: memcontrol: account kernel stack per node
Message-ID: <20200630183605.GA37586@carbon.dhcp.thefacebook.com>
References: <20200630161539.1759185-1-shakeelb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630161539.1759185-1-shakeelb@google.com>
X-ClientProxiedBy: BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:c1f6) by BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend Transport; Tue, 30 Jun 2020 18:36:08 +0000
X-Originating-IP: [2620:10d:c090:400::5:c1f6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6707b267-3a9a-4067-6231-08d81d247484
X-MS-TrafficTypeDiagnostic: BYAPR15MB2632:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2632D4533A665ECD5FB15E88BE6F0@BYAPR15MB2632.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:313;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3MmUYvLXN8JMlK+nOLJRBdT0MnJ+sLBrNCAPksegOFuryqsBD7sd57UJ06FnzYiIUoL1LdsO6pAV8XDuv6JfY/JE+9+J+zYsngX4jjfdYQZATum4ms5g9Ev1/cZJy2TRSRrXyKRFeZvH8sejYFAJ4d9VdwNNTcP0eeUvxN+QiwPUBwoLn8kgP5iNJZiMaYF8a9h/WLhIHuFWx8ieWwPIWhBt2OwvsUcTRo9CUdZ+M6rbY/sUqfzQEOjvvPPNvCLLUaF9yU1f2uy8jd0cAIVFCG1OyZAqznx3juUSCNrlYonMoP6ugvskkH0ftrcZzRD0LeDJBPU3CPqsGH4L2tUB24MlEM5vR7tV+n/JV+36SbAeUW6GtMIXmIRS+ibHe4l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(396003)(366004)(136003)(39860400002)(5660300002)(1076003)(478600001)(86362001)(8936002)(316002)(33656002)(8676002)(16526019)(186003)(7696005)(52116002)(30864003)(6506007)(83380400001)(66556008)(66476007)(2906002)(6666004)(54906003)(9686003)(6916009)(66946007)(15650500001)(55016002)(4326008)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: rJxaBgj63xDWpyC4P1DwjB9b8+RgaxfQV23o7a+IoQtkwZTNEwo+S124WOFeS+dclMFZ+UNuXCZpLnn6kP4nY45KQaL4TSBqJC+ngq4fL8f7rpldoSo6sa0fLVdFL6IIVPNF+0u/zdsDCtzCY3dck8Kc8x7WqQVT+suppuoNA5WJNjlpgv6BorZ2AApdCIT36CrAmmgX0UkdM721rsOaqRTFOhEdVr5zCNYIge+nIHUXMhwzotG9laZTwjGV4lhOcwaM3Vvje6UlCFdd3+vFLjU9e98yL2j8G4xjCGCJ9kzH0rSljYyZqWnJutFFTJfoq8ytvaHZZ6OP2svHmrrPC61TFud4aEt6yXo+9jVjivuhBMKOgk3TgPJrbVx84j6CCvegQDDe9IZJ6NTcNjgIaqYVBoYhocKGKELcfddjwhOSbKH4DEAZk7s2XP8aWPfV8cdYpUikO/C4S3WN3PQuMGBEHpVBmCpC5ukFzDabqgKhT9fkKqkDs3op+acXUfav576jYYbygEAikvHeHtC4Pg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6707b267-3a9a-4067-6231-08d81d247484
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 18:36:08.5305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBa8Cqyb9bLHmFd529NXvHdG0I8l11CSJAUoUkxQDwFBpJyT+216WKGFd/mlqdRi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2632
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_06:2020-06-30,2020-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=5 mlxlogscore=999
 bulkscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 spamscore=0
 clxscore=1015 cotscore=-2147483648 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300127
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 09:15:39AM -0700, Shakeel Butt wrote:
> Currently the kernel stack is being accounted per-zone. There is no need
> to do that. In addition due to being per-zone, memcg has to keep a
> separate MEMCG_KERNEL_STACK_KB. Make the stat per-node and deprecate
> MEMCG_KERNEL_STACK_KB as memcg_stat_item is an extension of
> node_stat_item. In addition localize the kernel stack stats updates to
> account_kernel_stack().
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
> Changes since v1:
> - Use lruvec based stat update functions based on Roman's suggestion.

Reviewed-by: Roman Gushchin <guro@fb.com>

I really like it, it makes this complicated code way simpler.

Thanks, Shakeel!


> 
>  drivers/base/node.c        |  4 +--
>  fs/proc/meminfo.c          |  4 +--
>  include/linux/memcontrol.h | 21 ++++++++++++++--
>  include/linux/mmzone.h     |  8 +++---
>  kernel/fork.c              | 51 +++++++++++---------------------------
>  kernel/scs.c               |  2 +-
>  mm/memcontrol.c            |  2 +-
>  mm/page_alloc.c            | 16 ++++++------
>  mm/vmstat.c                |  8 +++---
>  9 files changed, 55 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 0cf13e31603c..508b80f6329b 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -440,9 +440,9 @@ static ssize_t node_read_meminfo(struct device *dev,
>  		       nid, K(node_page_state(pgdat, NR_FILE_MAPPED)),
>  		       nid, K(node_page_state(pgdat, NR_ANON_MAPPED)),
>  		       nid, K(i.sharedram),
> -		       nid, sum_zone_node_page_state(nid, NR_KERNEL_STACK_KB),
> +		       nid, node_page_state(pgdat, NR_KERNEL_STACK_KB),
>  #ifdef CONFIG_SHADOW_CALL_STACK
> -		       nid, sum_zone_node_page_state(nid, NR_KERNEL_SCS_KB),
> +		       nid, node_page_state(pgdat, NR_KERNEL_SCS_KB),
>  #endif
>  		       nid, K(sum_zone_node_page_state(nid, NR_PAGETABLE)),
>  		       nid, 0UL,
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index f262bff3ca31..887a5532e449 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -101,10 +101,10 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  	show_val_kb(m, "SReclaimable:   ", sreclaimable);
>  	show_val_kb(m, "SUnreclaim:     ", sunreclaim);
>  	seq_printf(m, "KernelStack:    %8lu kB\n",
> -		   global_zone_page_state(NR_KERNEL_STACK_KB));
> +		   global_node_page_state(NR_KERNEL_STACK_KB));
>  #ifdef CONFIG_SHADOW_CALL_STACK
>  	seq_printf(m, "ShadowCallStack:%8lu kB\n",
> -		   global_zone_page_state(NR_KERNEL_SCS_KB));
> +		   global_node_page_state(NR_KERNEL_SCS_KB));
>  #endif
>  	show_val_kb(m, "PageTables:     ",
>  		    global_zone_page_state(NR_PAGETABLE));
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index ba1e42715ecf..b8f52a3fed90 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -33,8 +33,6 @@ enum memcg_stat_item {
>  	MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
>  	MEMCG_SOCK,
>  	MEMCG_PERCPU_B,
> -	/* XXX: why are these zone and not node counters? */
> -	MEMCG_KERNEL_STACK_KB,
>  	MEMCG_NR_STAT,
>  };
>  
> @@ -737,8 +735,19 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  			int val);
>  void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val);
> +
>  void mod_memcg_obj_state(void *p, int idx, int val);
>  
> +static inline void mod_lruvec_slab_state(void *p, enum node_stat_item idx,
> +					 int val)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	__mod_lruvec_slab_state(p, idx, val);
> +	local_irq_restore(flags);
> +}
> +
>  static inline void mod_memcg_lruvec_state(struct lruvec *lruvec,
>  					  enum node_stat_item idx, int val)
>  {
> @@ -1159,6 +1168,14 @@ static inline void __mod_lruvec_slab_state(void *p, enum node_stat_item idx,
>  	__mod_node_page_state(page_pgdat(page), idx, val);
>  }
>  
> +static inline void mod_lruvec_slab_state(void *p, enum node_stat_item idx,
> +					 int val)
> +{
> +	struct page *page = virt_to_head_page(p);
> +
> +	mod_node_page_state(page_pgdat(page), idx, val);
> +}
> +
>  static inline void mod_memcg_obj_state(void *p, int idx, int val)
>  {
>  }
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 8e859444927a..b79f73ce8b57 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -153,10 +153,6 @@ enum zone_stat_item {
>  	NR_ZONE_WRITE_PENDING,	/* Count of dirty, writeback and unstable pages */
>  	NR_MLOCK,		/* mlock()ed pages found and moved off LRU */
>  	NR_PAGETABLE,		/* used for pagetables */
> -	NR_KERNEL_STACK_KB,	/* measured in KiB */
> -#if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
> -	NR_KERNEL_SCS_KB,	/* measured in KiB */
> -#endif
>  	/* Second 128 byte cacheline */
>  	NR_BOUNCE,
>  #if IS_ENABLED(CONFIG_ZSMALLOC)
> @@ -201,6 +197,10 @@ enum node_stat_item {
>  	NR_KERNEL_MISC_RECLAIMABLE,	/* reclaimable non-slab kernel pages */
>  	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
>  	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
> +	NR_KERNEL_STACK_KB,	/* measured in KiB */
> +#if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
> +	NR_KERNEL_SCS_KB,	/* measured in KiB */
> +#endif
>  	NR_VM_NODE_STAT_ITEMS
>  };
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 73fdfa9674b5..f00c7a4913e1 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -276,13 +276,8 @@ static inline void free_thread_stack(struct task_struct *tsk)
>  	if (vm) {
>  		int i;
>  
> -		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
> -			mod_memcg_page_state(vm->pages[i],
> -					     MEMCG_KERNEL_STACK_KB,
> -					     -(int)(PAGE_SIZE / 1024));
> -
> +		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
>  			memcg_kmem_uncharge_page(vm->pages[i], 0);
> -		}
>  
>  		for (i = 0; i < NR_CACHED_STACKS; i++) {
>  			if (this_cpu_cmpxchg(cached_stacks[i],
> @@ -382,31 +377,14 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
>  	void *stack = task_stack_page(tsk);
>  	struct vm_struct *vm = task_stack_vm_area(tsk);
>  
> -	BUILD_BUG_ON(IS_ENABLED(CONFIG_VMAP_STACK) && PAGE_SIZE % 1024 != 0);
> -
> -	if (vm) {
> -		int i;
> -
> -		BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
>  
> -		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
> -			mod_zone_page_state(page_zone(vm->pages[i]),
> -					    NR_KERNEL_STACK_KB,
> -					    PAGE_SIZE / 1024 * account);
> -		}
> -	} else {
> -		/*
> -		 * All stack pages are in the same zone and belong to the
> -		 * same memcg.
> -		 */
> -		struct page *first_page = virt_to_page(stack);
> -
> -		mod_zone_page_state(page_zone(first_page), NR_KERNEL_STACK_KB,
> -				    THREAD_SIZE / 1024 * account);
> -
> -		mod_memcg_obj_state(stack, MEMCG_KERNEL_STACK_KB,
> -				    account * (THREAD_SIZE / 1024));
> -	}
> +	/* All stack pages are in the same node. */
> +	if (vm)
> +		mod_lruvec_page_state(vm->pages[0], NR_KERNEL_STACK_KB,
> +				      account * (THREAD_SIZE / 1024));
> +	else
> +		mod_lruvec_slab_state(stack, NR_KERNEL_STACK_KB,
> +				      account * (THREAD_SIZE / 1024));
>  }
>  
>  static int memcg_charge_kernel_stack(struct task_struct *tsk)
> @@ -415,24 +393,23 @@ static int memcg_charge_kernel_stack(struct task_struct *tsk)
>  	struct vm_struct *vm = task_stack_vm_area(tsk);
>  	int ret;
>  
> +	BUILD_BUG_ON(IS_ENABLED(CONFIG_VMAP_STACK) && PAGE_SIZE % 1024 != 0);
> +
>  	if (vm) {
>  		int i;
>  
> +		BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
> +
>  		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
>  			/*
>  			 * If memcg_kmem_charge_page() fails, page->mem_cgroup
> -			 * pointer is NULL, and both memcg_kmem_uncharge_page()
> -			 * and mod_memcg_page_state() in free_thread_stack()
> -			 * will ignore this page. So it's safe.
> +			 * pointer is NULL, and memcg_kmem_uncharge_page() in
> +			 * free_thread_stack() will ignore this page.
>  			 */
>  			ret = memcg_kmem_charge_page(vm->pages[i], GFP_KERNEL,
>  						     0);
>  			if (ret)
>  				return ret;
> -
> -			mod_memcg_page_state(vm->pages[i],
> -					     MEMCG_KERNEL_STACK_KB,
> -					     PAGE_SIZE / 1024);
>  		}
>  	}
>  #endif
> diff --git a/kernel/scs.c b/kernel/scs.c
> index 5d4d9bbdec36..4ff4a7ba0094 100644
> --- a/kernel/scs.c
> +++ b/kernel/scs.c
> @@ -17,7 +17,7 @@ static void __scs_account(void *s, int account)
>  {
>  	struct page *scs_page = virt_to_page(s);
>  
> -	mod_zone_page_state(page_zone(scs_page), NR_KERNEL_SCS_KB,
> +	mod_node_page_state(page_pgdat(scs_page), NR_KERNEL_SCS_KB,
>  			    account * (SCS_SIZE / SZ_1K));
>  }
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b1a644224383..06de63901f81 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1485,7 +1485,7 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>  		       (u64)memcg_page_state(memcg, NR_FILE_PAGES) *
>  		       PAGE_SIZE);
>  	seq_buf_printf(&s, "kernel_stack %llu\n",
> -		       (u64)memcg_page_state(memcg, MEMCG_KERNEL_STACK_KB) *
> +		       (u64)memcg_page_state(memcg, NR_KERNEL_STACK_KB) *
>  		       1024);
>  	seq_buf_printf(&s, "slab %llu\n",
>  		       (u64)(memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 174c849ba9f2..0568b126f719 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5402,6 +5402,10 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
>  			" anon_thp: %lukB"
>  #endif
>  			" writeback_tmp:%lukB"
> +			" kernel_stack:%lukB"
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +			" shadow_call_stack:%lukB"
> +#endif
>  			" all_unreclaimable? %s"
>  			"\n",
>  			pgdat->node_id,
> @@ -5423,6 +5427,10 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
>  			K(node_page_state(pgdat, NR_ANON_THPS) * HPAGE_PMD_NR),
>  #endif
>  			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
> +			node_page_state(pgdat, NR_KERNEL_STACK_KB),
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +			node_page_state(pgdat, NR_KERNEL_SCS_KB),
> +#endif
>  			pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ?
>  				"yes" : "no");
>  	}
> @@ -5454,10 +5462,6 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
>  			" present:%lukB"
>  			" managed:%lukB"
>  			" mlocked:%lukB"
> -			" kernel_stack:%lukB"
> -#ifdef CONFIG_SHADOW_CALL_STACK
> -			" shadow_call_stack:%lukB"
> -#endif
>  			" pagetables:%lukB"
>  			" bounce:%lukB"
>  			" free_pcp:%lukB"
> @@ -5479,10 +5483,6 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
>  			K(zone->present_pages),
>  			K(zone_managed_pages(zone)),
>  			K(zone_page_state(zone, NR_MLOCK)),
> -			zone_page_state(zone, NR_KERNEL_STACK_KB),
> -#ifdef CONFIG_SHADOW_CALL_STACK
> -			zone_page_state(zone, NR_KERNEL_SCS_KB),
> -#endif
>  			K(zone_page_state(zone, NR_PAGETABLE)),
>  			K(zone_page_state(zone, NR_BOUNCE)),
>  			K(free_pcp),
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 2c5a96694490..96bf8bfffd1d 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1158,10 +1158,6 @@ const char * const vmstat_text[] = {
>  	"nr_zone_write_pending",
>  	"nr_mlock",
>  	"nr_page_table_pages",
> -	"nr_kernel_stack",
> -#if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
> -	"nr_shadow_call_stack",
> -#endif
>  	"nr_bounce",
>  #if IS_ENABLED(CONFIG_ZSMALLOC)
>  	"nr_zspages",
> @@ -1212,6 +1208,10 @@ const char * const vmstat_text[] = {
>  	"nr_kernel_misc_reclaimable",
>  	"nr_foll_pin_acquired",
>  	"nr_foll_pin_released",
> +	"nr_kernel_stack",
> +#if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
> +	"nr_shadow_call_stack",
> +#endif
>  
>  	/* enum writeback_stat_item counters */
>  	"nr_dirty_threshold",
> -- 
> 2.27.0.212.ge8ba1cc988-goog
> 
