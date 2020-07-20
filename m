Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EDDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB7BF20734
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgGTEhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 00:37:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:22523 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgGTEhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 00:37:34 -0400
IronPort-SDR: o/e9iNgNhuYKLtIT9HBEgRztkyPyabxcbY2iHXd99xYrTzWlWw1Gll3gy92SUejwKxeV7p8+xX
 1yYa6rkF7R9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="167979650"
X-IronPort-AV: E=Sophos;i="5.75,373,1589266800"; 
   d="scan'208";a="167979650"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2020 21:37:03 -0700
IronPort-SDR: PkfP5Y/fAtlVgxHEkyyBdBGuU+DUKF/0YJQlUQoxG7klYfoiIwbm/nSMUbmeb43S7hcdxntIua
 5kXYnhymL+/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,373,1589266800"; 
   d="scan'208";a="283392635"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga003.jf.intel.com with ESMTP; 19 Jul 2020 21:37:00 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: linux-next: not-present page at swap_vma_readahead()
References: <62A0ACFC-E023-4269-8121-F96B879A8C51@lca.pw>
        <81F06AA9-F25B-4342-9CF7-2763AC394A18@lca.pw>
        <874ktl1p7y.fsf@yhuang-dev.intel.com> <20200616011334.GA815@lca.pw>
        <CA2E3DE2DD06CA4FA11644750E4E292F454E35A9@SHSMSX104.ccr.corp.intel.com>
        <20200720021227.GA7354@lca.pw>
        <CA2E3DE2DD06CA4FA11644750E4E292F454E3B6D@SHSMSX104.ccr.corp.intel.com>
        <20200720035411.GB7354@lca.pw>
Date:   Mon, 20 Jul 2020 12:37:00 +0800
In-Reply-To: <20200720035411.GB7354@lca.pw> (Qian Cai's message of "Sun, 19
        Jul 2020 23:54:12 -0400")
Message-ID: <875zaivm37.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <cai@lca.pw> writes:

> On Mon, Jul 20, 2020 at 03:32:59AM +0000, Huang, Ying wrote:
>> Thanks!  Can you try the dbg patch attached?  That will print more debugging information when abnormal PTE pointer is detected.
>
> Here with both of your patches applied,
>
> [  183.627876][ T3959] ra_info: 8, 3, 4, 00000000aabe3209
> [  183.633160][ T3959] i: 0, pte: 00000000aabe3209, faddr: 0
> [  183.638574][ T3959] ra_info: 8, 3, 4, 00000000aabe3209
> [  183.643787][ T3959] i: 1, pte: 0000000006e61f24, faddr: 0
> [  183.649189][ T3959] ra_info: 8, 3, 4, 00000000aabe3209
> [  183.654371][ T3959] i: 2, pte: 00000000ce16a68e, faddr: 0
> [  183.851372][ T3839] ra_info: 8, 3, 4, 0000000085efad17
> [  183.856550][ T3839] i: 0, pte: 0000000085efad17, faddr: 0
> [  183.862503][ T3839] ==================================================================
> [  183.870563][ T3839] BUG: KASAN: slab-out-of-bounds in swapin_readahead+0x840/0xd60
> [  183.878147][ T3839] Read of size 8 at addr ffff008919f1ffe8 by task trinity-c128/3839
> [  183.886001][ T3839] CPU: 9 PID: 3839 Comm: trinity-c128 Not tainted 5.8.0-rc5-next-20200717+ #2
> [  183.894710][ T3839] Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
> [  183.905157][ T3839] Call trace:
> [  183.908314][ T3839]  dump_backtrace+0x0/0x398
> [  183.912680][ T3839]  show_stack+0x14/0x20
> [  183.916704][ T3839]  dump_stack+0x140/0x1c8
> [  183.920910][ T3839]  print_address_description.constprop.10+0x54/0x550
> [  183.927454][ T3839]  kasan_report+0x134/0x1b8
> [  183.931833][ T3839]  __asan_report_load8_noabort+0x2c/0x50
> [  183.937334][ T3839]  swapin_readahead+0x840/0xd60
> [  183.942049][ T3839]  do_swap_page+0xb1c/0x1a78
> [  183.946508][ T3839]  handle_mm_fault+0xfd0/0x2c50
> [  183.948789][ T3754] ra_info: 8, 3, 4, 00000000d0b6ebd5
> [  183.951229][ T3839]  do_page_fault+0x230/0x818
> [  183.956402][ T3754] i: 0, pte: 00000000d0b6ebd5, faddr: 0
> [  183.960896][ T3839]  do_translation_fault+0x90/0xb0
> [  183.966330][ T3754] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
> [  183.971172][ T3839]  do_mem_abort+0x64/0x180
> [  183.971192][ T3839]  el0_sync_handler+0x2a0/0x410
> [  183.971207][ T3839]  el0_sync+0x140/0x180
> [  183.977984][ T3754] ra_info: 8, 3, 4, 00000000d0b6ebd5
> [  183.977997][ T3754] i: 1, pte: 00000000530a7b17, faddr: 0
> [  183.982278][ T3839] Allocated by task 3699:
> [  183.982296][ T3839]  kasan_save_stack+0x24/0x50
> [  183.982310][ T3839]  __kasan_kmalloc.isra.10+0xc4/0xe0
> [  183.987003][ T3754] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
> [  183.987019][ T3754] ra_info: 8, 3, 4, 00000000d0b6ebd5
> [  183.991033][ T3839]  kasan_slab_alloc+0x14/0x20
> [  183.991048][ T3839]  slab_post_alloc_hook+0x58/0x5d0
> [  183.991064][ T3839]  kmem_cache_alloc+0x19c/0x448
> [  183.996185][ T3754] i: 2, pte: 00000000031f0751, faddr: 0
> [  183.996200][ T3754] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
> [  184.001617][ T3839]  create_object+0x58/0x960
> [  184.001639][ T3839]  kmemleak_alloc+0x2c/0x38
> [  184.001657][ T3839]  slab_post_alloc_hook+0x78/0x5d0
> [  184.025674][ T3830] ra_info: 8, 3, 4, 00000000d77f2b57
> [  184.027442][ T3839]  kmem_cache_alloc+0x19c/0x448
> [  184.032002][ T3830] i: 0, pte: 0026 (3737) used g  184.047047][ T193][ T3839]  co T3932] i: 0, pt59417][ T3932] i: 1, pte: 00000000e38ee039, faddr: 0
> [  184.059424][ T3932] ra_info: 8, 3, 4, 000000004ae69ce9
> [  184.059431][ T3932] i: 2, pte: 0000000035544c25, faddr: 0
> [  184.062563][ T3830] ra_info: 8, 3, 4, 00000000d77f2b57
> [  184.067511][ T3839]  _do_fork+0x128/0x11f8
> [  184.072663][ T3830] i: 2, pte: 000000002f241b20, faddr: 0
> [  184.077369][ T3839]  __do_sys_clone+0xac/0xd8
> [  184.110993][ T3997] ra_info: 8, 3, 4, 00000000d40684b7
> [  184.113421][ T3839]  __arm64_sys_clone+0xa0/0xf8

This appears to run on ARM64.  Can you help to try this on x86?  I'm
not familiar with ARM.

Best Regards,
Huang, Ying

> [  184.116524][ T3832] ra_info: 8, 3, 4, 00000000b572965a
> [  184.116534][ T3832] i: 0, pte: 00000000b572965a, faddr: 0
> [  184.116541][ T3832] ra_info: 8, 3, 4, 00000000b572965a
> [  184.116549][ T3832] i: 1, pte: 000000007c91cc64, faddr: 0
> [  184.116556][ T3832] ra_info: 8, 3, 4, 00000000b572965a
> [  184.116563][ T3832] i: 2, pte: 0000000024f944e4, faddr: 0
> [  184.118541][ T3997] i: 0, pte: 00000000d40684b7, faddr: 0
> [  184.118552][ T3997] ra_info: 8, 3, 4, 00000000d40684b7
> [  184.123956][ T3839]  do_el0_svc+0x124/0x228
> [  184.123970][ T3839]  el0_sync_handler+0x260/0x410
> [  184.123988][ T3839]  el0_sync+0x140/0x180
> [  184.129119][ T3997] i: 1, pte: 0000000035d81ad0, faddr: 0
> [  184.134523][ T3839] The buggy address belongs to the object at ffff008919f1fd28
> [  184.134523][ T3839]  which belongs to the cache kmemleak_object of size 368
> [  184.134535][ T3839] The buggy address is located 336 bytes to the right of
> [  184.134535][ T3839]  368-byte region [ffff008919f1fd28, ffff008919f1fe98)
> [  184.134542][ T3839] The buggy address belongs to the page:
> [  184.139678][ T3997] ra_info: 8, 3, 4, 00000000d40684b7
> [  184.142537][ T3814] ra_info: 8, 3, 4, 000000005be43c1f
> [  184.142548][ T3814] i: 0, pte: 000000005be43c1f, faddr: 0
> [  184.142555][ T3814] ra_info: 8, 3, 4, 000000005be43c1f
> [  184.142563][ T3814] i: 1, pte: 00000000f65153b4, faddr: 0
> [  184.142570][ T3814] ra_info: 8, 3, 4, 000000005be43c1f
> [  184.142577][ T3814] i: 2, pte: 0000000057432c18, faddr: 0
> [  184.145074][ T3839] page:00000000ab369b24 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8999f1
> [  184.145085][ T3839] flags: 0x7ffff800000200(slab)
> [  184.145097][ T3839] raw: 007ffff800000200 ffffffe0222685c8 ffffffe022268848 ffff000000322480
> [  184.145107][ T3839] raw: 0000000000000000 00000000005b005b 00000001ffffffff 0000000000000000
> [  184.145117][ T3839] page dumped because: kasan: bad access detected
> [  184.150249][ T3997] i: 2, pte: 0000000073c2aff0, faddr: 0
> [  184.154339][ T3839] Memory state around the buggy address:
> [  184.154347][ T3839]  ffff008919f1fe80: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  184.154353][ T3839]  ffff008919f1ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  184.154359][ T3839] >ffff008919f1ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  184.154366][ T3839]                                                           ^
> [  184.171894][ T3831] ra_info: 8, 3, 4, 00000000cf472abe
> [  184.173847][ T3839]  ffff008919f20000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  184.178980][ T3831] i: 0, pte: 00000000cf472abe, faddr: 0
> [  184.184366][ T3839]  ffff008919f20080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  184.184370][ T3839] ==================================================================
> [  184.184374][ T3839] Disabling lock debugging due to kernel taint
> [  184.184407][ T3839] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
> [  184.184415][ T3839] ra_info: 8, 3, 4, 0000000085efad17
> [  184.184420][ T3839] i: 1, pte: 00000000e75f3a33, faddr: 0
> [  184.184425][ T3839] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
> [  184.184445][ T3839] ra_info: 8, 3, 4, 0000000085efad17
> [  184.189580][ T3831] ra_info: 8, 3, 4, 00000000cf472abe
> [  184.194979][ T3839] i: 2, pte: 0000000076a382e8, faddr: 0
> [  184.194985][ T3839] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
> [  184.211498][ T3749] ra_info: 8, 3, 4, 000000001c9e06b8
> [  184.216321][ T3831] i: 1, pte: 00000000d0a5b31e, faddr: 0
> [  184.220485][ T3749] i: 0, pte: 000000001c9e06b8, faddr: 0
> [  184.220499][ T3749] ra_info: 8, 3, 4, 000000001c9e06b8
> [  184.225255][ T3831] ra_info: 8, 3, 4, 00000000cf472abe
> [  184.229226][ T3749] i: 1, pte: 000000003db42685, faddr: 0
> [  184.229238][ T3749] ra_info: 8, 3, 4, 000000001c9e06b8
> [  184.234658][ T3831] i: 2, pte: 000000002ff7eea4, faddr: 0
> [  184.248902][ T3749] i: 2, pte: 00000000f6f36e76, faddr: 0
> [  184.278122][ T3946] ra_info: 8, 3, 4, 0000000084aa2721
> [  184.279536][ T3720] trinity-c9 (3720) used greatest stack depth: 19440 bytes left
> [  184.283740][ T3946] i: 0, pte: 0000000084aa2721, faddr: 0
> [  184.283746][ T3946] ra_info: 8, 3, 4, 0000000084aa2721
> [  184.283751][ T3946] i: 1, pte: 00000000baf34b7a, faddr: 0
> [  184.283757][ T3946] ra_info: 8, 3, 4, 0000000084aa2721
> [  184.283762][ T3946] i: 2, pte: 0000000097da2f82, faddr: 0
> [  184.311719][ T3789] ra_info: 8, 3, 4, 00000000642615f8
> [  184.346297][ T3846] ra_info: 8, 3, 4, 00000000bfc701b4
> [  184.348700][ T3789] i: 0, pte: 00000000642615f8, faddr: 0
> [  184.357498][ T3846] i: 0, pte: 00000000bfc701b4, faddr: 0
> [  184.362168][ T3789] ra_info: 8, 3, 4, 00000000642615f8
> [  184.370076][ T3846] ra_info: 8, 3, 4, 00000000bfc701b4
> [  184.377998][ T3789] i: 1, pte: 000000002e399dd1, faddr: 0
> [  184.378008][ T3789] ra_info: 8, 3, 4, 00000000642615f8
> [  184.385317][ T3846] i: 1, pte: 000000002f17c4d4, faddr: 0
> [  184.385324][ T3846] ra_info: 8, 3, 4, 00000000bfc701b4
> [  184.390452][ T3789] i: 2, pte: 000000006b9fd0f4, faddr: 0
> [  184.398368][ T3846] i: 2, pte: 00000000b6695126, faddr: 0
>
>> 
>> > From b6cad43ad3cf63d73e539e3eaadd4ec9d2744dc6 Mon Sep 17 00:00:00 2001
>> > From: Huang Ying <ying.huang@intel.com>
>> > Date: Fri, 10 Jul 2020 17:27:45 +0800
>> > Subject: [PATCH] dbg: Fix a logic hole in swap_ra_info()
>> >
>> > ---
>> >  mm/swap_state.c | 5 ++---
>> >  1 file changed, 2 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/mm/swap_state.c b/mm/swap_state.c
>> > index 05889e8e3c97..8481c15829b2 100644
>> > --- a/mm/swap_state.c
>> > +++ b/mm/swap_state.c
>> > @@ -669,12 +669,11 @@ static void swap_ra_info(struct vm_fault *vmf,
>> >       pte_t *tpte;
>> >  #endif
>> >
>> > +     ra_info->win = 1;
>> >       max_win = 1 << min_t(unsigned int, READ_ONCE(page_cluster),
>> >                            SWAP_RA_ORDER_CEILING);
>> > -     if (max_win == 1) {
>> > -             ra_info->win = 1;
>> > +     if (max_win == 1)
>> >               return;
>> > -     }
>> >
>> >       faddr = vmf->address;
>> >       orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
>> > --
>> > 2.27.0
>> >
>> 
>
>> From 3ca7a9ba58541d8692d3f83cbded2ad17be23359 Mon Sep 17 00:00:00 2001
>> From: Huang Ying <ying.huang@intel.com>
>> Date: Mon, 20 Jul 2020 11:29:38 +0800
>> Subject: [PATCH] dbg: dump upon abnormal pte values
>> 
>> ---
>>  mm/swap_state.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>> 
>> diff --git a/mm/swap_state.c b/mm/swap_state.c
>> index 05889e8e3c97..c1973136d035 100644
>> --- a/mm/swap_state.c
>> +++ b/mm/swap_state.c
>> @@ -756,6 +756,17 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
>>  	blk_start_plug(&plug);
>>  	for (i = 0, pte = ra_info.ptes; i < ra_info.nr_pte;
>>  	     i++, pte++) {
>> +		pte_t *tpte = pte_offset_map(vmf->pmd, vmf->address);
>> +
>> +		if (((unsigned long)pte >> PAGE_SHIFT) !=
>> +		    ((unsigned long)tpte >> PAGE_SHIFT)) {
>> +			pr_info("ra_info: %d, %d, %d, %p\n",
>> +				ra_info.win, ra_info.offset, ra_info.nr_pte,
>> +				ra_info.ptes);
>> +			pr_info("i: %d, pte: %p, faddr: %lx\n", i, pte,
>> +				vmf->address);
>> +		}
>> +		pte_unmap(tpte);
>>  		pentry = *pte;
>>  		if (pte_none(pentry))
>>  			continue;
>> -- 
>> 2.27.0
>> 
