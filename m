Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46EBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A953820675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="eDldyeF5";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="W1Ufbyjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgF3DYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 23:24:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12450 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728956AbgF3DYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 23:24:19 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05U3DMau012735;
        Mon, 29 Jun 2020 20:24:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=eyj/JHifeRLEBPuXyGkRdLpTuRArNEp5R7NVMrlAVdg=;
 b=eDldyeF5RGZ7ph5IlaCfSbQF363blN1BVrwOD2tzwsZgxUoYQ+J2kKxR4xfEGpz2VeR2
 YNFowFakm4UW8nbTumzFC4kg8nYShtbEldHFuclAe72D/2qA9BJZ2l9MgRQLNkwMw+25
 I12jZ96i9waMepD/yCJZWhCzefRi6MEHF7I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 31ykcj2tb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Jun 2020 20:24:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 29 Jun 2020 20:24:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYq+gBa4Akbo53if/vgBLXvFqoNXZVb3om2CDXvQJzYvIcGfwSU3ZFpUQatCzmasCVzrH0ah1zGT3oAZUuCY20JQkgE52AxMfawnw4GyteUy/Sd4KjZwdU8MuSS4dHKnxZxx05UlaoFxY0iDfcseRUtFP2MIadCnWeSwzJkgo2eIuAuYCuZGgvFsDnyRK9DAQ31ZiTevFjl6vqTkBBGDnBtXvBMYwQ4RFdqqmy1NbZ0oqdonnxPf4jNmxkkNhXx4PUQhhBi+gIQdMX/d2QCMScGdZIi/oRi5ZpXLWbO+ZmcCXQgxUSZkwKOBL88DjMe8xgkeMzTc6KFilgJa1pPDQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyj/JHifeRLEBPuXyGkRdLpTuRArNEp5R7NVMrlAVdg=;
 b=jZea1KtPhD78eS86Y0/26S4Z3w1EoNWdlw6+ABjkKbhcw3NmnuJahK6CGBLUza900GUWJlhWWD71CG0XQafeVxSaafEjyooV3W9N4sb5I7O8eNGLaA4Ad5VSi93wg8J4OlpAlZK/gujDTplKdO6+GkzEJ8kQrAl+BEqMx66twB+nV+6PSKlsEF0YwJf3j6p/9IGQY0OGzRAda7vOL1URaTkaTpqF/d/P8LZF+uKqaTpBfom60LPlywO1+bBGIPw0ewRIecPujDwbmgUl37U2l0iXfnbNaSCQ4Cd2rzG9AL9z7hP1If3S7C9Q3eaf7Bkpi4zsMJXNUeDPkDNssQbTNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyj/JHifeRLEBPuXyGkRdLpTuRArNEp5R7NVMrlAVdg=;
 b=W1UfbyjnwhFWEPDqKQCpAjsrd9K/6ppLLrJR0+jBAeyA2wsFm5EM7dy4YWM4w1z7WSaOp0n3fUrvUmwm2Rwl5N4DnfzZAFmvRp3zpPQR/kOzKkvW+sPXUweSmvKpg2SKtW1lsxFaFqXl+p+aQNhaDd3ZbpRVVSM7IyAKQ515KWo=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3224.namprd15.prod.outlook.com (2603:10b6:a03:105::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 03:23:56 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 03:23:56 +0000
Date:   Mon, 29 Jun 2020 20:23:53 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memcontrol: account kernel stack per node
Message-ID: <20200630032353.GA26969@carbon.dhcp.thefacebook.com>
References: <20200630004413.1423733-1-shakeelb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630004413.1423733-1-shakeelb@google.com>
X-ClientProxiedBy: BYAPR06CA0047.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:bc3f) by BYAPR06CA0047.namprd06.prod.outlook.com (2603:10b6:a03:14b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Tue, 30 Jun 2020 03:23:55 +0000
X-Originating-IP: [2620:10d:c090:400::5:bc3f]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c0c6172-6eff-4f14-683c-08d81ca5059d
X-MS-TrafficTypeDiagnostic: BYAPR15MB3224:
X-Microsoft-Antispam-PRVS: <BYAPR15MB322488F895951736B3D612F5BE6F0@BYAPR15MB3224.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TNgV/Y7+45eDxoc+lK9RsAfxukk+hxTAwda00ubmbsPQ/OdsaDbP+MOrio52KtT3nVqDXn7FzfHPLNu0zVTf/lhaaIOptNAyS31I5piJxA9SzqJrz2u7MR9Cy/J5scszReZVWaS2OKnWfAhLC806+FFxPd/uGR+7LL6Piz7z11TtUjMimapzOfqR04M99KNz/71fI84DkoELQyc7cnbBrpHBit5hlYeWJUSSvNfhcLcINfMdaJWxTDO6KtfG5h4oN8BjouehCdv2jUWspZwIpe9u9wh8kFirsOuf5kUSHc4hHHcRnChjgT+b1KkMy9u27zpyh9mWmQklvB6PGCwd/a668JdKmnP7A9VJ1uCKEU7y7tNsWi8Vyc9Ak0uY2P1U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(396003)(366004)(376002)(346002)(52116002)(7696005)(6916009)(8936002)(5660300002)(478600001)(33656002)(6506007)(86362001)(2906002)(8676002)(54906003)(9686003)(15650500001)(83380400001)(1076003)(186003)(316002)(55016002)(16526019)(66946007)(66556008)(4326008)(66476007)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: BNECVlom/YQ9E3q2d7/pD13x61rx/v55apdBAhHXa5GL/nw+UsxnBuBn/Ki9B3lBOQrOQLUie47zVmDPZYO5m7QMahcXO+nkxfsERSWywW7AsmVjGMUyPvQh1MPxab6PlcEBae9mYYVjfCbrZ3hLyBRcbLMUqc78GOTf37UrJGsXr3DsxTNIKGId9/V7TlyBQ0sVpHbJ0Zl9YkWCm4VGaI6ouFQKAtjpMo+WlUeWZRyVGyoddy09bAmzTtJL8/Wy1Y2HLABT7qkI4opoG8XXqrbLMYVWWC+Iiy41+XxXJ+as7v8FaiRkcOM/e7OpBekFpdRqJb2Xn7EAyE+zaErk+7zcTgJjKAbi54956JHSkBBReWiUzgr32/hTk91GyKOuJcbjANOR7vvDdYqv6BRs1XG80SyGerjcR2+xliXh6fijYE/9IIrHrvv3Rl99YYZB5DsPy5R2aEtMe/FRaG6opwoXsKCGZ1y/e6GhyNnNoJXyENEnR30Q/aRQtxY2r5KIP+ALLY/Ym3sYlSxXvLb3Yg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0c6172-6eff-4f14-683c-08d81ca5059d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 03:23:56.4787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0r4tMIpgOeDbQsCezxw8h5aSTBjTiqYSEHAZt8oCYzemC0tHLetYj7GScty/+XqC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3224
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-29_21:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=5 lowpriorityscore=0
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 cotscore=-2147483648
 mlxscore=0 malwarescore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300023
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 05:44:13PM -0700, Shakeel Butt wrote:
> Currently the kernel stack is being accounted per-zone. There is no need
> to do that. In addition due to being per-zone, memcg has to keep a
> separate MEMCG_KERNEL_STACK_KB. Make the stat per-node and deprecate
> MEMCG_KERNEL_STACK_KB as memcg_stat_item is an extension of
> node_stat_item.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  drivers/base/node.c        |  4 ++--
>  fs/proc/meminfo.c          |  4 ++--
>  include/linux/memcontrol.h |  2 --
>  include/linux/mmzone.h     |  8 ++++----
>  kernel/fork.c              | 29 ++++++++++-------------------
>  kernel/scs.c               |  2 +-
>  mm/memcontrol.c            |  2 +-
>  mm/page_alloc.c            | 16 ++++++++--------
>  mm/vmstat.c                |  8 ++++----
>  9 files changed, 32 insertions(+), 43 deletions(-)
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
> index ba1e42715ecf..a3ddb236898e 100644
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
> index 73fdfa9674b5..ee5393350ef7 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -278,7 +278,7 @@ static inline void free_thread_stack(struct task_struct *tsk)
>  
>  		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
>  			mod_memcg_page_state(vm->pages[i],
> -					     MEMCG_KERNEL_STACK_KB,
> +					     NR_KERNEL_STACK_KB,
>  					     -(int)(PAGE_SIZE / 1024));

Hello, Shakeel!

Thank you for the cleanup, it makes total sense to me.

However I have some concerns: mod_memcg_page_state() does change only memcg's counters,
but not lruvec counters. So to make it per-node per-memcg (aka  lruvec)
we need to use mod_lruvec_state(), otherwise we won't have global per-node values.

>  
>  			memcg_kmem_uncharge_page(vm->pages[i], 0);
> @@ -381,32 +381,23 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
>  {
>  	void *stack = task_stack_page(tsk);
>  	struct vm_struct *vm = task_stack_vm_area(tsk);
> +	struct page *page;
>  
>  	BUILD_BUG_ON(IS_ENABLED(CONFIG_VMAP_STACK) && PAGE_SIZE % 1024 != 0);
>  
>  	if (vm) {
> -		int i;
> -
>  		BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
> +		page = vm->pages[0];
>  
> -		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
> -			mod_zone_page_state(page_zone(vm->pages[i]),
> -					    NR_KERNEL_STACK_KB,
> -					    PAGE_SIZE / 1024 * account);
> -		}
>  	} else {
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
> +		page = virt_to_page(stack);
> +		mod_memcg_obj_state(stack, NR_KERNEL_STACK_KB,
>  				    account * (THREAD_SIZE / 1024));
>  	}
> +
> +	/* All stack pages are in the same node. */
> +	mod_node_page_state(page_pgdat(page), NR_KERNEL_STACK_KB,
> +			    THREAD_SIZE / 1024 * account);
>  }

And then we probably don't need a separate change for memcg- and per-node counters.

Thanks!

>  
>  static int memcg_charge_kernel_stack(struct task_struct *tsk)
> @@ -431,7 +422,7 @@ static int memcg_charge_kernel_stack(struct task_struct *tsk)
>  				return ret;
>  
>  			mod_memcg_page_state(vm->pages[i],
> -					     MEMCG_KERNEL_STACK_KB,
> +					     NR_KERNEL_STACK_KB,
>  					     PAGE_SIZE / 1024);
>  		}
>  	}
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
