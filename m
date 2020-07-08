Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61054C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 01:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C10220708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 01:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="oPOUs7hu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgGHBUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 21:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbgGHBUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 21:20:49 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C9CC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 18:20:48 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id k18so40062899qke.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 18:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T4M1B4qM+7ZvUDq044qTiNIFQ+YmibanY8+olYKTuis=;
        b=oPOUs7hui+vx+MfAq53b7oyxVn9FPPpZJcI2qOZGjRKdoLs503PtAH1IYUaqGmaVdB
         HGLtS5DYEqGKw/6DGVF91mlmkABv+Sqg6HiR1Y2peF7oj95iyBn7pC4D5rpWYxmTTsGG
         7fpUuIc7i0XYQGOnIvdhiVGpXr2MNzE5l1eP/SNMoC/TW2tTfY7OLhADrnMGBSRYoY/L
         bYCFp9hLddKoX0xHaVGB5kMBauaBb4eaaocA/nbxlTBUwUHMBD2fTIcWUczhTxxnyCWV
         o5z7S7xfAHrUzG7XyGbinhUQwHQhKpoOJt6+04iUZf3RUP51qo4L10uf6VGSKwwQBSSG
         VSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T4M1B4qM+7ZvUDq044qTiNIFQ+YmibanY8+olYKTuis=;
        b=LuC6cAyBFJigyoMf0ZNt2MSe1WjPWbANXS3Jov2eKzPEF6c6S8JdQSojcGByPCEhWk
         Q5u119XMwo3WDkEv7z27g2QW+e6hVSRd/PerPPfpUO/YgpwQiNU8tmN1jjylzYG6IgSe
         Ioz4BjlPledbIFCx8lJCN6ADZug58w51vkRiM3e1LcxCGs3UkjcUbCY/TCPNue78zczM
         WEAHxNPXXW69Fgr1+yqvxw6e6SurdY+qOoxQtUCbgSUWRFq2H4NlrJS6sZUAap3wueQ8
         /fDdeHJLaNqlXxnRF45LxYylKlUirerfNzFthhF2UgVtW0FMTTopNaqJNIFX0hCMOfGU
         uuXg==
X-Gm-Message-State: AOAM5316grlyRbhhsFKMx5V091B7h4YFU+JqxGgNAPFTZlLIOJWSrub5
        pWlJuevDe1HoRj/y1SexNnsnJQ==
X-Google-Smtp-Source: ABdhPJzZAOBZ9qmphfIpmS50P4guPlKVzwppY95PUCu8u0a/NhfJ7V0x1+mP14gm92imEAw1uDHvcA==
X-Received: by 2002:a37:4fd1:: with SMTP id d200mr16320898qkb.163.1594171247229;
        Tue, 07 Jul 2020 18:20:47 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q189sm25794624qke.21.2020.07.07.18.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 18:20:46 -0700 (PDT)
Date:   Tue, 7 Jul 2020 21:20:44 -0400
From:   Qian Cai <cai@lca.pw>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v3 7/8] mm/mempolicy: use a standard migration target
 allocation callback
Message-ID: <20200708012044.GC992@lca.pw>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-8-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592892828-1934-8-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 03:13:47PM +0900, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> There is a well-defined migration target allocation callback.
> Use it.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  mm/internal.h  |  1 -
>  mm/mempolicy.c | 30 ++++++------------------------
>  mm/migrate.c   |  8 ++++++--
>  3 files changed, 12 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index fb7f7fe..4f9f6b6 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -613,7 +613,6 @@ static inline bool is_migrate_highatomic_page(struct page *page)
>  }
>  
>  void setup_zone_pageset(struct zone *zone);
> -extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
>  
>  struct migration_target_control {
>  	int nid;		/* preferred node id */
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index a3abf64..85a3f21 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1065,28 +1065,6 @@ static int migrate_page_add(struct page *page, struct list_head *pagelist,
>  	return 0;
>  }
>  
> -/* page allocation callback for NUMA node migration */
> -struct page *alloc_new_node_page(struct page *page, unsigned long node)
> -{
> -	if (PageHuge(page)) {
> -		return alloc_huge_page_nodemask(
> -			page_hstate(compound_head(page)), node,
> -			NULL, __GFP_THISNODE, false);
> -	} else if (PageTransHuge(page)) {
> -		struct page *thp;
> -
> -		thp = alloc_pages_node(node,
> -			(GFP_TRANSHUGE | __GFP_THISNODE),
> -			HPAGE_PMD_ORDER);
> -		if (!thp)
> -			return NULL;
> -		prep_transhuge_page(thp);
> -		return thp;
> -	} else
> -		return __alloc_pages_node(node, GFP_HIGHUSER_MOVABLE |
> -						    __GFP_THISNODE, 0);
> -}
> -
>  /*
>   * Migrate pages from one node to a target node.
>   * Returns error or the number of pages not migrated.
> @@ -1097,6 +1075,10 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
>  	nodemask_t nmask;
>  	LIST_HEAD(pagelist);
>  	int err = 0;
> +	struct migration_target_control mtc = {
> +		.nid = dest,
> +		.gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_THISNODE,
> +	};
>  
>  	nodes_clear(nmask);
>  	node_set(source, nmask);
> @@ -1111,8 +1093,8 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
>  			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
>  
>  	if (!list_empty(&pagelist)) {
> -		err = migrate_pages(&pagelist, alloc_new_node_page, NULL, dest,
> -					MIGRATE_SYNC, MR_SYSCALL);
> +		err = migrate_pages(&pagelist, alloc_migration_target, NULL,
> +				(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
>  		if (err)
>  			putback_movable_pages(&pagelist);
>  	}
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 7c4cd74..1c943b0 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1590,9 +1590,13 @@ static int do_move_pages_to_node(struct mm_struct *mm,
>  		struct list_head *pagelist, int node)
>  {
>  	int err;
> +	struct migration_target_control mtc = {
> +		.nid = node,
> +		.gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_THISNODE,
> +	};
>  
> -	err = migrate_pages(pagelist, alloc_new_node_page, NULL, node,
> -			MIGRATE_SYNC, MR_SYSCALL);
> +	err = migrate_pages(pagelist, alloc_migration_target, NULL,
> +			(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);

migrate_pages() starts failing like this apparently using the new
callback on NUMA systems,

[ 6147.019063][T45242] LTP: starting move_pages12
[ 6147.475680][T64921] BUG: unable to handle page fault for address: ffffffffffffffe0
[ 6147.483301][T64921] #PF: supervisor read access in kernel mode
[ 6147.489170][T64921] #PF: error_code(0x0000) - not-present page
[ 6147.495040][T64921] PGD 5df817067 P4D 5df817067 PUD 5df819067 PMD 0 
[ 6147.501438][T64921] Oops: 0000 [#1] SMP KASAN NOPTI
[ 6147.506348][T64921] CPU: 35 PID: 64921 Comm: move_pages12 Tainted: G           O      5.8.0-rc4-next-20200707 #1
[ 6147.516586][T64921] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
[ 6147.525866][T64921] RIP: 0010:anon_vma_interval_tree_iter_first+0xa2/0x170
avc_start_pgoff at mm/interval_tree.c:63
(inlined by) __anon_vma_interval_tree_iter_first at mm/interval_tree.c:71
(inlined by) anon_vma_interval_tree_iter_first at mm/interval_tree.c:95
[ 6147.532787][T64921] Code: 00 00 00 00 fc ff df 48 8b 6d 08 48 8d 7d e0 48 89 f9 48 c1 e9 03 80 3c 01 00 0f 85 b3 00 00 00 48 b8 00 00 00 00 00 fc ff df <48> 8b 6d e0 48 8d bd 98 00 00 00 48 89 f9 48 c1 e9 03 80 3c 01 00
[ 6147.552370][T64921] RSP: 0018:ffffc9000bfdfa98 EFLAGS: 00010246
[ 6147.558327][T64921] RAX: dffffc0000000000 RBX: ffff888524019b28 RCX: 1ffffffffffffffc
[ 6147.566205][T64921] RDX: 00000000000003ff RSI: 0000000000000200 RDI: ffffffffffffffe0
[ 6147.574084][T64921] RBP: 0000000000000000 R08: fffff94002b1c001 R09: fffff94002b1c001
[ 6147.581962][T64921] R10: ffffea00158e0007 R11: fffff94002b1c000 R12: 0000000000000009
[ 6147.589839][T64921] R13: ffffea00158e0008 R14: ffffea00158e0000 R15: ffffea00158e0000
[ 6147.597717][T64921] FS:  00007f329cf18b80(0000) GS:ffff88881f7c0000(0000) knlGS:0000000000000000
[ 6147.606557][T64921] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6147.613037][T64921] CR2: ffffffffffffffe0 CR3: 000000081122a000 CR4: 00000000003506e0
[ 6147.620914][T64921] Call Trace:
[ 6147.624078][T64921]  rmap_walk_anon+0x141/0xa30
rmap_walk_anon at mm/rmap.c:1864
[ 6147.628639][T64921]  try_to_unmap+0x209/0x2d0
try_to_unmap at mm/rmap.c:1763
[ 6147.633026][T64921]  ? rmap_walk_locked+0x140/0x140
[ 6147.637936][T64921]  ? page_remove_rmap+0x1190/0x1190
[ 6147.643020][T64921]  ? page_not_mapped+0x10/0x10
[ 6147.647668][T64921]  ? page_get_anon_vma+0x290/0x290
[ 6147.652664][T64921]  ? page_mapcount_is_zero+0x10/0x10
[ 6147.657838][T64921]  ? hugetlb_page_mapping_lock_write+0x97/0x180
[ 6147.663972][T64921]  migrate_pages+0x1005/0x1fb0
unmap_and_move_huge_page at mm/migrate.c:1383
(inlined by) migrate_pages at mm/migrate.c:1468
[ 6147.668617][T64921]  ? remove_migration_pte+0xac0/0xac0
[ 6147.673875][T64921]  move_pages_and_store_status.isra.47+0xd7/0x1a0
do_move_pages_to_node at mm/migrate.c:1595
(inlined by) move_pages_and_store_status at mm/migrate.c:1683
[ 6147.680181][T64921]  ? migrate_pages+0x1fb0/0x1fb0
[ 6147.685002][T64921]  __x64_sys_move_pages+0xa5c/0x1100
[ 6147.690176][T64921]  ? trace_hardirqs_on+0x20/0x1b5
[ 6147.695084][T64921]  ? move_pages_and_store_status.isra.47+0x1a0/0x1a0
[ 6147.701653][T64921]  ? rcu_read_lock_sched_held+0xaa/0xd0
[ 6147.707088][T64921]  ? switch_fpu_return+0x196/0x400
[ 6147.712083][T64921]  ? lockdep_hardirqs_on_prepare+0x38c/0x550
[ 6147.717954][T64921]  ? do_syscall_64+0x24/0x310
[ 6147.722513][T64921]  do_syscall_64+0x5f/0x310
[ 6147.726897][T64921]  ? trace_hardirqs_off+0x12/0x1a0
[ 6147.731894][T64921]  ? asm_exc_page_fault+0x8/0x30
[ 6147.736714][T64921]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 6147.742495][T64921] RIP: 0033:0x7f329c3fe6ed
[ 6147.746791][T64921] Code: Bad RIP value.
[ 6147.750738][T64921] RSP: 002b:00007fff5b6b5f88 EFLAGS: 00000246 ORIG_RAX: 0000000000000117
[ 6147.759055][T64921] RAX: ffffffffffffffda RBX: 00007f329cf18af8 RCX: 00007f329c3fe6ed
[ 6147.766933][T64921] RDX: 00000000019b0ee0 RSI: 0000000000000400 RDI: 000000000000fd98
[ 6147.774809][T64921] RBP: 0000000000000400 R08: 00000000019b3f00 R09: 0000000000000004
[ 6147.782686][T64921] R10: 00000000019b2ef0 R11: 0000000000000246 R12: 0000000000000400
[ 6147.790563][T64921] R13: 00000000019b0ee0 R14: 00000000019b2ef0 R15: 00000000019b3f00
[ 6147.798440][T64921] Modules linked in: vfio_pci vfio_virqfd vfio_iommu_type1 vfio loop kvm_amd ses enclosure kvm irqbypass efivars acpi_cpufreq nls_ascii nls_cp437 vfat fat efivarfs ip_tables x_tables sd_mod smartpqi scsi_transport_sas tg3 mlx5_core libphy firmware_class dm_mirror dm_region_hash dm_log dm_mod [last unloaded: dummy_del_mod]
[ 6147.828701][T64921] CR2: ffffffffffffffe0
[ 6147.832736][T64921] ---[ end trace 40323b256f1c74a8 ]---
[ 6147.838083][T64921] RIP: 0010:anon_vma_interval_tree_iter_first+0xa2/0x170
[ 6147.845001][T64921] Code: 00 00 00 00 fc ff df 48 8b 6d 08 48 8d 7d e0 48 89 f9 48 c1 e9 03 80 3c 01 00 0f 85 b3 00 00 00 48 b8 00 00 00 00 00 fc ff df <48> 8b 6d e0 48 8d bd 98 00 00 00 48 89 f9 48 c1 e9 03 80 3c 01 00
[ 6147.864583][T64921] RSP: 0018:ffffc9000bfdfa98 EFLAGS: 00010246
[ 6147.870539][T64921] RAX: dffffc0000000000 RBX: ffff888524019b28 RCX: 1ffffffffffffffc
[ 6147.878417][T64921] RDX: 00000000000003ff RSI: 0000000000000200 RDI: ffffffffffffffe0
[ 6147.886294][T64921] RBP: 0000000000000000 R08: fffff94002b1c001 R09: fffff94002b1c001
[ 6147.894172][T64921] R10: ffffea00158e0007 R11: fffff94002b1c000 R12: 0000000000000009
[ 6147.902049][T64921] R13: ffffea00158e0008 R14: ffffea00158e0000 R15: ffffea00158e0000
[ 6147.909932][T64921] FS:  00007f329cf18b80(0000) GS:ffff88881f7c0000(0000) knlGS:0000000000000000
[ 6147.918771][T64921] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6147.925251][T64921] CR2: ffffffffffffffe0 CR3: 000000081122a000 CR4: 00000000003506e0
[ 6147.933130][T64921] Kernel panic - not syncing: Fatal exception
[ 6147.939493][T64921] Kernel Offset: 0x28c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 6147.951090][T64921] ---[ end Kernel panic - not syncing: Fatal exception ]---

>  	if (err)
>  		putback_movable_pages(pagelist);
>  	return err;
> -- 
> 2.7.4
> 
> 
