Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513E2C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 308FC206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgFVIza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:55:30 -0400
Received: from outbound-smtp01.blacknight.com ([81.17.249.7]:42584 "EHLO
        outbound-smtp01.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbgFVIza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:55:30 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp01.blacknight.com (Postfix) with ESMTPS id 1DA88C4A57
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:55:27 +0100 (IST)
Received: (qmail 7794 invoked from network); 22 Jun 2020 08:55:26 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.5])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Jun 2020 08:55:26 -0000
Date:   Mon, 22 Jun 2020 09:55:25 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     vbabka@suse.cz, bhe@redhat.com, minchan@kernel.org,
        mgorman@suse.de, hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, ytk.lee@samsung.com,
        cmlaika.kim@samsung.com
Subject: Re: [PATCH v4] page_alloc: consider highatomic reserve in watermark
 fast
Message-ID: <20200622085525.GO3183@techsingularity.net>
References: <CGME20200619055816epcas1p184da90b01aff559fe3cd690ebcd921ca@epcas1p1.samsung.com>
 <20200619235958.11283-1-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200619235958.11283-1-jaewon31.kim@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 20, 2020 at 08:59:58AM +0900, Jaewon Kim wrote:
> zone_watermark_fast was introduced by commit 48ee5f3696f6 ("mm,
> page_alloc: shortcut watermark checks for order-0 pages"). The commit
> simply checks if free pages is bigger than watermark without additional
> calculation such like reducing watermark.
> 
> It considered free cma pages but it did not consider highatomic
> reserved. This may incur exhaustion of free pages except high order
> atomic free pages.
> 
> Assume that reserved_highatomic pageblock is bigger than watermark min,
> and there are only few free pages except high order atomic free. Because
> zone_watermark_fast passes the allocation without considering high order
> atomic free, normal reclaimable allocation like GFP_HIGHUSER will
> consume all the free pages. Then finally order-0 atomic allocation may
> fail on allocation.
> 
> This means watermark min is not protected against non-atomic allocation.
> The order-0 atomic allocation with ALLOC_HARDER unwantedly can be
> failed. Additionally the __GFP_MEMALLOC allocation with
> ALLOC_NO_WATERMARKS also can be failed.
> 
> To avoid the problem, zone_watermark_fast should consider highatomic
> reserve. If the actual size of high atomic free is counted accurately
> like cma free, we may use it. On this patch just use
> nr_reserved_highatomic. Additionally introduce
> __zone_watermark_unusable_free to factor out common parts between
> zone_watermark_fast and __zone_watermark_ok.
> 
> This is an example of ALLOC_HARDER allocation failure using v4.19 based
> kernel.
> 
>  Binder:9343_3: page allocation failure: order:0, mode:0x480020(GFP_ATOMIC), nodemask=(null)
>  Call trace:
>  [<ffffff8008f40f8c>] dump_stack+0xb8/0xf0
>  [<ffffff8008223320>] warn_alloc+0xd8/0x12c
>  [<ffffff80082245e4>] __alloc_pages_nodemask+0x120c/0x1250
>  [<ffffff800827f6e8>] new_slab+0x128/0x604
>  [<ffffff800827b0cc>] ___slab_alloc+0x508/0x670
>  [<ffffff800827ba00>] __kmalloc+0x2f8/0x310
>  [<ffffff80084ac3e0>] context_struct_to_string+0x104/0x1cc
>  [<ffffff80084ad8fc>] security_sid_to_context_core+0x74/0x144
>  [<ffffff80084ad880>] security_sid_to_context+0x10/0x18
>  [<ffffff800849bd80>] selinux_secid_to_secctx+0x20/0x28
>  [<ffffff800849109c>] security_secid_to_secctx+0x3c/0x70
>  [<ffffff8008bfe118>] binder_transaction+0xe68/0x454c
>  Mem-Info:
>  active_anon:102061 inactive_anon:81551 isolated_anon:0
>   active_file:59102 inactive_file:68924 isolated_file:64
>   unevictable:611 dirty:63 writeback:0 unstable:0
>   slab_reclaimable:13324 slab_unreclaimable:44354
>   mapped:83015 shmem:4858 pagetables:26316 bounce:0
>   free:2727 free_pcp:1035 free_cma:178
>  Node 0 active_anon:408244kB inactive_anon:326204kB active_file:236408kB inactive_file:275696kB unevictable:2444kB isolated(anon):0kB isolated(file):256kB mapped:332060kB dirty:252kB writeback:0kB shmem:19432kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
>  Normal free:10908kB min:6192kB low:44388kB high:47060kB active_anon:409160kB inactive_anon:325924kB active_file:235820kB inactive_file:276628kB unevictable:2444kB writepending:252kB present:3076096kB managed:2673676kB mlocked:2444kB kernel_stack:62512kB pagetables:105264kB bounce:0kB free_pcp:4140kB local_pcp:40kB free_cma:712kB
>  lowmem_reserve[]: 0 0
>  Normal: 505*4kB (H) 357*8kB (H) 201*16kB (H) 65*32kB (H) 1*64kB (H) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 10236kB
>  138826 total pagecache pages
>  5460 pages in swap cache
>  Swap cache stats: add 8273090, delete 8267506, find 1004381/4060142
> 
> This is an example of ALLOC_NO_WATERMARKS allocation failure using v4.14
> based kernel.
> 
>  kswapd0: page allocation failure: order:0, mode:0x140000a(GFP_NOIO|__GFP_HIGHMEM|__GFP_MOVABLE), nodemask=(null)
>  kswapd0 cpuset=/ mems_allowed=0
>  CPU: 4 PID: 1221 Comm: kswapd0 Not tainted 4.14.113-18770262-userdebug #1
>  Call trace:
>  [<0000000000000000>] dump_backtrace+0x0/0x248
>  [<0000000000000000>] show_stack+0x18/0x20
>  [<0000000000000000>] __dump_stack+0x20/0x28
>  [<0000000000000000>] dump_stack+0x68/0x90
>  [<0000000000000000>] warn_alloc+0x104/0x198
>  [<0000000000000000>] __alloc_pages_nodemask+0xdc0/0xdf0
>  [<0000000000000000>] zs_malloc+0x148/0x3d0
>  [<0000000000000000>] zram_bvec_rw+0x410/0x798
>  [<0000000000000000>] zram_rw_page+0x88/0xdc
>  [<0000000000000000>] bdev_write_page+0x70/0xbc
>  [<0000000000000000>] __swap_writepage+0x58/0x37c
>  [<0000000000000000>] swap_writepage+0x40/0x4c
>  [<0000000000000000>] shrink_page_list+0xc30/0xf48
>  [<0000000000000000>] shrink_inactive_list+0x2b0/0x61c
>  [<0000000000000000>] shrink_node_memcg+0x23c/0x618
>  [<0000000000000000>] shrink_node+0x1c8/0x304
>  [<0000000000000000>] kswapd+0x680/0x7c4
>  [<0000000000000000>] kthread+0x110/0x120
>  [<0000000000000000>] ret_from_fork+0x10/0x18
>  Mem-Info:
>  active_anon:111826 inactive_anon:65557 isolated_anon:0\x0a active_file:44260 inactive_file:83422 isolated_file:0\x0a unevictable:4158 dirty:117 writeback:0 unstable:0\x0a            slab_reclaimable:13943 slab_unreclaimable:43315\x0a mapped:102511 shmem:3299 pagetables:19566 bounce:0\x0a free:3510 free_pcp:553 free_cma:0
>  Node 0 active_anon:447304kB inactive_anon:262228kB active_file:177040kB inactive_file:333688kB unevictable:16632kB isolated(anon):0kB isolated(file):0kB mapped:410044kB d irty:468kB writeback:0kB shmem:13196kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
>  Normal free:14040kB min:7440kB low:94500kB high:98136kB reserved_highatomic:32768KB active_anon:447336kB inactive_anon:261668kB active_file:177572kB inactive_file:333768k           B unevictable:16632kB writepending:480kB present:4081664kB managed:3637088kB mlocked:16632kB kernel_stack:47072kB pagetables:78264kB bounce:0kB free_pcp:2280kB local_pcp:720kB free_cma:0kB        [ 4738.329607] lowmem_reserve[]: 0 0
>  Normal: 860*4kB (H) 453*8kB (H) 180*16kB (H) 26*32kB (H) 34*64kB (H) 6*128kB (H) 2*256kB (H) 0*512kB 0*1024kB 0*2048kB 0*4096kB = 14232kB
> 
> This is trace log which shows GFP_HIGHUSER consumes free pages right
> before ALLOC_NO_WATERMARKS.
> 
>   <...>-22275 [006] ....   889.213383: mm_page_alloc: page=00000000d2be5665 pfn=970744 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>   <...>-22275 [006] ....   889.213385: mm_page_alloc: page=000000004b2335c2 pfn=970745 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>   <...>-22275 [006] ....   889.213387: mm_page_alloc: page=00000000017272e1 pfn=970278 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>   <...>-22275 [006] ....   889.213389: mm_page_alloc: page=00000000c4be79fb pfn=970279 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>   <...>-22275 [006] ....   889.213391: mm_page_alloc: page=00000000f8a51d4f pfn=970260 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>   <...>-22275 [006] ....   889.213393: mm_page_alloc: page=000000006ba8f5ac pfn=970261 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>   <...>-22275 [006] ....   889.213395: mm_page_alloc: page=00000000819f1cd3 pfn=970196 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>   <...>-22275 [006] ....   889.213396: mm_page_alloc: page=00000000f6b72a64 pfn=970197 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
> kswapd0-1207  [005] ...1   889.213398: mm_page_alloc: page= (null) pfn=0 order=0 migratetype=1 nr_free=3650 gfp_flags=GFP_NOWAIT|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_MOVABLE
> 
> Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
> Suggested-by: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
