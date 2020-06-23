Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7567AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EEBC20706
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iQQgGHwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgFVJvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:51:02 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:28547 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgFVJvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:51:02 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200622095058epoutp042872e5cc0dceb871b6d7f3e6b51debc6~a1Nu_GT9d2254422544epoutp04v
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:50:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200622095058epoutp042872e5cc0dceb871b6d7f3e6b51debc6~a1Nu_GT9d2254422544epoutp04v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592819458;
        bh=QLt+yqOk8FHx2SLt+Cz8cVyAt0x2uGYL8c3FpEnwFZk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=iQQgGHwzzIfFF0EqSxm8QaCT8dwftTBh6TXFkagf34p2Pqu46vrz8R05uCn388zwd
         BDvAUglFd1Cb+G9Mit4+BrAW49NWik5PgJVSO1vm54NOtzV/7HCDmOgoU7MVb3ejYb
         0LM4xRzyVqCxI/vuRgW79wOZrHtdHuSXdG0wicIU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200622095057epcas1p3ca5bfd01ab4a7543786a1b4f4dcf49ce~a1Nt248aM3130831308epcas1p30;
        Mon, 22 Jun 2020 09:50:57 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.161]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49r4RM74tRzMqYkV; Mon, 22 Jun
        2020 09:50:55 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.79.19033.FFE70FE5; Mon, 22 Jun 2020 18:50:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200622095055epcas1p4dea3c6338270006b4476fc5c5df0479f~a1Nr3Ce8_1468914689epcas1p4W;
        Mon, 22 Jun 2020 09:50:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200622095055epsmtrp2ab7b55603b611b07ea34b64a9be69dec~a1Nr2MMrW3075130751epsmtrp2V;
        Mon, 22 Jun 2020 09:50:55 +0000 (GMT)
X-AuditID: b6c32a36-16fff70000004a59-22-5ef07eff1adf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.23.08303.EFE70FE5; Mon, 22 Jun 2020 18:50:54 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.229]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200622095054epsmtip1ab509b263003055f51b5e0e7337539fa~a1NrixMOi2446024460epsmtip1q;
        Mon, 22 Jun 2020 09:50:54 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     mhocko@kernel.org, vbabka@suse.cz, bhe@redhat.com,
        mgorman@techsingularity.net, minchan@kernel.org, mgorman@suse.de,
        hannes@cmpxchg.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, ytk.lee@samsung.com,
        cmlaika.kim@samsung.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v5] page_alloc: consider highatomic reserve in watermark
 fast
Date:   Tue, 23 Jun 2020 12:52:42 +0900
Message-Id: <20200623035242.27232-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTV/d/3Yc4g/nvTSzmrF/DZnH+wS82
        i5XzzrFZrN7ka9G9eSajRe/7V0wWl3fNYbO4t+Y/q8Xkd88YLXYs3cdk8frbMmaLZV/fs1vM
        buxjtHi8ntuBz+Pwm/fMHjtn3WX32LSqk81j06dJ7B4nZvxm8Xi/7yqbR9+WVYweZxYcYffY
        fLraY+svO4/Pm+QCuKNybDJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1Nt
        lVx8AnTdMnOAflBSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFBgaFOgVJ+YWl+al
        6yXn51oZGhgYmQJVJuRkTPgqXvAvpuLPlxWMDYxH/LsYOTkkBEwkrr88zdrFyMUhJLCDUeLJ
        ojdsEM4nRomTn34wQjifGSUOtZ1hhGnpPT4JKrGLUWLnr/vsEM4PRom9/V+ZQarYBLQl3i+Y
        BDZYRGAVo8SGXXPBqpgFljJKXL51gx2kSljAX2LW7sVgc1kEVCWOPjzFBmLzCthKnD96nw1i
        n7zE6g0HmCHsXg6JPYs4IGwXiRm3HkPVCEu8Or6FHcKWkvj8bi9UvF5iz/6/UL0NjBL/PwpA
        2MYS81sWAsU5gA7SlFi/Sx8irCix8/dcsHOYBfgk3n3tYQUpkRDglehoE4IoUZNoefaVFcKW
        kfj77xmU7SHxaNpusFYhgViJnz9OMk5glJ2FsGABI+MqRrHUguLc9NRiwwIj5FjaxAhOmFpm
        Oxgnvf2gd4iRiYPxEKMEB7OSCO/rgHdxQrwpiZVVqUX58UWlOanFhxhNgcE1kVlKNDkfmLLz
        SuINTY2MjY0tTMzMzUyNlcR51WQuxAkJpCeWpGanphakFsH0MXFwSjUwzXN/y2Fyq84/vPtc
        quKk6uvTI94wLV3a9P1cUkzjhozlG8svGMuwPz4S3XZB5t8Nd5t2tqqnmWKNtq/DCpu0v+/P
        fxPL+Jev5u3jM5Vx8lt9bj74dCFAZ0//rNSDVnfXTZugmcps+cRIyXjami2qEdz3lOqOmLet
        ny3bdeJphEN94L4532tncP6UrTEycztV37OTKVrjuKljUcEc/i1zX+w/N/HkeqPJa9//4jl6
        WPP6Kpcqs2ipQy121faGL84e+ua3cUfB/1tGDU9NnIL5VrSKrlXzf8u706hBxdD6/gQFs6i1
        QfaH/yZPDEx2Uvh8e939D6HHOc/m3boXfNV5ceaqQAHpX3uunSqLuTCTWYmlOCPRUIu5qDgR
        ALerHlIhBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSnO6/ug9xBs9nWlvMWb+GzeL8g19s
        FivnnWOzWL3J16J780xGi973r5gsLu+aw2Zxb81/VovJ754xWuxYuo/J4vW3ZcwWy76+Z7eY
        3djHaPF4PbcDn8fhN++ZPXbOusvusWlVJ5vHpk+T2D1OzPjN4vF+31U2j74tqxg9ziw4wu6x
        +XS1x9Zfdh6fN8kFcEdx2aSk5mSWpRbp2yVwZUz4Kl7wL6biz5cVjA2MR/y7GDk5JARMJHqP
        T2LsYuTiEBLYwSjRsOsdE0RCRuLN+acsXYwcQLawxOHDxRA13xglvk3uYwOpYRPQlni/YBIr
        SEJEYAujxPcFM1hAHGaB1YwSDz8cZgapEhbwlbjVf48dxGYRUJU4+vAUWDevgK3E+aP32SC2
        yUus3nCAeQIjzwJGhlWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMEBrKW1g3HPqg96
        hxiZOBgPMUpwMCuJ8L4OeBcnxJuSWFmVWpQfX1Sak1p8iFGag0VJnPfrrIVxQgLpiSWp2amp
        BalFMFkmDk6pBqYyk+qY5vaP/dYchW4ez07NKJp/pO54zacHSfNv8qm0vndhtNztEvdngnYU
        S4sW75cz0q9Wq/1czCgoEiwjNKv55YsT5mt7NJM/aqtIntWIsix9u+JIve9i62/dVrEsf198
        C3z06lbynyWL5ddbyaw72nXy2N0E5dYNv65t557eF3nGcHcwU+l5iVTBv+miHU+WxybP9Fh3
        8cvEMLn2K3YBLfzzchynXpr191ig/b6ptpW7jxv4MsuJynDn/PH0XBTey8Y1pTlVTzvYtc6n
        bXuU7F5Bu8PvAq5zCS+3bOK8Urjvx/zwImFvXzFjhltrVs4vEt/w/E3A7Tuvt1t48n83eRjQ
        9b/HOsKgVbt/jhJLcUaioRZzUXEiABF8wzvPAgAA
X-CMS-MailID: 20200622095055epcas1p4dea3c6338270006b4476fc5c5df0479f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200622095055epcas1p4dea3c6338270006b4476fc5c5df0479f
References: <CGME20200622095055epcas1p4dea3c6338270006b4476fc5c5df0479f@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zone_watermark_fast was introduced by commit 48ee5f3696f6 ("mm,
page_alloc: shortcut watermark checks for order-0 pages"). The commit
simply checks if free pages is bigger than watermark without additional
calculation such like reducing watermark.

It considered free cma pages but it did not consider highatomic
reserved. This may incur exhaustion of free pages except high order
atomic free pages.

Assume that reserved_highatomic pageblock is bigger than watermark min,
and there are only few free pages except high order atomic free. Because
zone_watermark_fast passes the allocation without considering high order
atomic free, normal reclaimable allocation like GFP_HIGHUSER will
consume all the free pages. Then finally order-0 atomic allocation may
fail on allocation.

This means watermark min is not protected against non-atomic allocation.
The order-0 atomic allocation with ALLOC_HARDER unwantedly can be
failed. Additionally the __GFP_MEMALLOC allocation with
ALLOC_NO_WATERMARKS also can be failed.

To avoid the problem, zone_watermark_fast should consider highatomic
reserve. If the actual size of high atomic free is counted accurately
like cma free, we may use it. On this patch just use
nr_reserved_highatomic. Additionally introduce
__zone_watermark_unusable_free to factor out common parts between
zone_watermark_fast and __zone_watermark_ok.

This is an example of ALLOC_HARDER allocation failure using v4.19 based
kernel.

 Binder:9343_3: page allocation failure: order:0, mode:0x480020(GFP_ATOMIC), nodemask=(null)
 Call trace:
 [<ffffff8008f40f8c>] dump_stack+0xb8/0xf0
 [<ffffff8008223320>] warn_alloc+0xd8/0x12c
 [<ffffff80082245e4>] __alloc_pages_nodemask+0x120c/0x1250
 [<ffffff800827f6e8>] new_slab+0x128/0x604
 [<ffffff800827b0cc>] ___slab_alloc+0x508/0x670
 [<ffffff800827ba00>] __kmalloc+0x2f8/0x310
 [<ffffff80084ac3e0>] context_struct_to_string+0x104/0x1cc
 [<ffffff80084ad8fc>] security_sid_to_context_core+0x74/0x144
 [<ffffff80084ad880>] security_sid_to_context+0x10/0x18
 [<ffffff800849bd80>] selinux_secid_to_secctx+0x20/0x28
 [<ffffff800849109c>] security_secid_to_secctx+0x3c/0x70
 [<ffffff8008bfe118>] binder_transaction+0xe68/0x454c
 Mem-Info:
 active_anon:102061 inactive_anon:81551 isolated_anon:0
  active_file:59102 inactive_file:68924 isolated_file:64
  unevictable:611 dirty:63 writeback:0 unstable:0
  slab_reclaimable:13324 slab_unreclaimable:44354
  mapped:83015 shmem:4858 pagetables:26316 bounce:0
  free:2727 free_pcp:1035 free_cma:178
 Node 0 active_anon:408244kB inactive_anon:326204kB active_file:236408kB inactive_file:275696kB unevictable:2444kB isolated(anon):0kB isolated(file):256kB mapped:332060kB dirty:252kB writeback:0kB shmem:19432kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
 Normal free:10908kB min:6192kB low:44388kB high:47060kB active_anon:409160kB inactive_anon:325924kB active_file:235820kB inactive_file:276628kB unevictable:2444kB writepending:252kB present:3076096kB managed:2673676kB mlocked:2444kB kernel_stack:62512kB pagetables:105264kB bounce:0kB free_pcp:4140kB local_pcp:40kB free_cma:712kB
 lowmem_reserve[]: 0 0
 Normal: 505*4kB (H) 357*8kB (H) 201*16kB (H) 65*32kB (H) 1*64kB (H) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 10236kB
 138826 total pagecache pages
 5460 pages in swap cache
 Swap cache stats: add 8273090, delete 8267506, find 1004381/4060142

This is an example of ALLOC_NO_WATERMARKS allocation failure using v4.14
based kernel.

 kswapd0: page allocation failure: order:0, mode:0x140000a(GFP_NOIO|__GFP_HIGHMEM|__GFP_MOVABLE), nodemask=(null)
 kswapd0 cpuset=/ mems_allowed=0
 CPU: 4 PID: 1221 Comm: kswapd0 Not tainted 4.14.113-18770262-userdebug #1
 Call trace:
 [<0000000000000000>] dump_backtrace+0x0/0x248
 [<0000000000000000>] show_stack+0x18/0x20
 [<0000000000000000>] __dump_stack+0x20/0x28
 [<0000000000000000>] dump_stack+0x68/0x90
 [<0000000000000000>] warn_alloc+0x104/0x198
 [<0000000000000000>] __alloc_pages_nodemask+0xdc0/0xdf0
 [<0000000000000000>] zs_malloc+0x148/0x3d0
 [<0000000000000000>] zram_bvec_rw+0x410/0x798
 [<0000000000000000>] zram_rw_page+0x88/0xdc
 [<0000000000000000>] bdev_write_page+0x70/0xbc
 [<0000000000000000>] __swap_writepage+0x58/0x37c
 [<0000000000000000>] swap_writepage+0x40/0x4c
 [<0000000000000000>] shrink_page_list+0xc30/0xf48
 [<0000000000000000>] shrink_inactive_list+0x2b0/0x61c
 [<0000000000000000>] shrink_node_memcg+0x23c/0x618
 [<0000000000000000>] shrink_node+0x1c8/0x304
 [<0000000000000000>] kswapd+0x680/0x7c4
 [<0000000000000000>] kthread+0x110/0x120
 [<0000000000000000>] ret_from_fork+0x10/0x18
 Mem-Info:
 active_anon:111826 inactive_anon:65557 isolated_anon:0\x0a active_file:44260 inactive_file:83422 isolated_file:0\x0a unevictable:4158 dirty:117 writeback:0 unstable:0\x0a            slab_reclaimable:13943 slab_unreclaimable:43315\x0a mapped:102511 shmem:3299 pagetables:19566 bounce:0\x0a free:3510 free_pcp:553 free_cma:0
 Node 0 active_anon:447304kB inactive_anon:262228kB active_file:177040kB inactive_file:333688kB unevictable:16632kB isolated(anon):0kB isolated(file):0kB mapped:410044kB d irty:468kB writeback:0kB shmem:13196kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
 Normal free:14040kB min:7440kB low:94500kB high:98136kB reserved_highatomic:32768KB active_anon:447336kB inactive_anon:261668kB active_file:177572kB inactive_file:333768k           B unevictable:16632kB writepending:480kB present:4081664kB managed:3637088kB mlocked:16632kB kernel_stack:47072kB pagetables:78264kB bounce:0kB free_pcp:2280kB local_pcp:720kB free_cma:0kB        [ 4738.329607] lowmem_reserve[]: 0 0
 Normal: 860*4kB (H) 453*8kB (H) 180*16kB (H) 26*32kB (H) 34*64kB (H) 6*128kB (H) 2*256kB (H) 0*512kB 0*1024kB 0*2048kB 0*4096kB = 14232kB

This is trace log which shows GFP_HIGHUSER consumes free pages right
before ALLOC_NO_WATERMARKS.

  <...>-22275 [006] ....   889.213383: mm_page_alloc: page=00000000d2be5665 pfn=970744 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
  <...>-22275 [006] ....   889.213385: mm_page_alloc: page=000000004b2335c2 pfn=970745 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
  <...>-22275 [006] ....   889.213387: mm_page_alloc: page=00000000017272e1 pfn=970278 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
  <...>-22275 [006] ....   889.213389: mm_page_alloc: page=00000000c4be79fb pfn=970279 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
  <...>-22275 [006] ....   889.213391: mm_page_alloc: page=00000000f8a51d4f pfn=970260 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
  <...>-22275 [006] ....   889.213393: mm_page_alloc: page=000000006ba8f5ac pfn=970261 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
  <...>-22275 [006] ....   889.213395: mm_page_alloc: page=00000000819f1cd3 pfn=970196 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
  <...>-22275 [006] ....   889.213396: mm_page_alloc: page=00000000f6b72a64 pfn=970197 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
kswapd0-1207  [005] ...1   889.213398: mm_page_alloc: page= (null) pfn=0 order=0 migratetype=1 nr_free=3650 gfp_flags=GFP_NOWAIT|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_MOVABLE

Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
Suggested-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Baoquan He <bhe@redhat.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
v5: remove redundant code for high-order
v4: change description only; typo and log
v3: change log in description to one having reserved_highatomic
    change comment in code
v2: factor out common part
v1: consider highatomic reserve
---
 mm/page_alloc.c | 66 +++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 48eb0f1410d4..15fe0a70b009 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3487,6 +3487,29 @@ static noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 }
 ALLOW_ERROR_INJECTION(should_fail_alloc_page, TRUE);
 
+static inline long __zone_watermark_unusable_free(struct zone *z,
+				unsigned int order, unsigned int alloc_flags)
+{
+	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
+	long unusable_free = (1 << order) - 1;
+
+	/*
+	 * If the caller does not have rights to ALLOC_HARDER then subtract
+	 * the high-atomic reserves. This will over-estimate the size of the
+	 * atomic reserve but it avoids a search.
+	 */
+	if (likely(!alloc_harder))
+		unusable_free += z->nr_reserved_highatomic;
+
+#ifdef CONFIG_CMA
+	/* If allocation can't use CMA areas don't use free CMA pages */
+	if (!(alloc_flags & ALLOC_CMA))
+		unusable_free += zone_page_state(z, NR_FREE_CMA_PAGES);
+#endif
+
+	return unusable_free;
+}
+
 /*
  * Return true if free base pages are above 'mark'. For high-order checks it
  * will return true of the order-0 watermark is reached and there is at least
@@ -3502,19 +3525,12 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
 
 	/* free_pages may go negative - that's OK */
-	free_pages -= (1 << order) - 1;
+	free_pages -= __zone_watermark_unusable_free(z, order, alloc_flags);
 
 	if (alloc_flags & ALLOC_HIGH)
 		min -= min / 2;
 
-	/*
-	 * If the caller does not have rights to ALLOC_HARDER then subtract
-	 * the high-atomic reserves. This will over-estimate the size of the
-	 * atomic reserve but it avoids a search.
-	 */
-	if (likely(!alloc_harder)) {
-		free_pages -= z->nr_reserved_highatomic;
-	} else {
+	if (unlikely(alloc_harder)) {
 		/*
 		 * OOM victims can try even harder than normal ALLOC_HARDER
 		 * users on the grounds that it's definitely going to be in
@@ -3527,13 +3543,6 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 			min -= min / 4;
 	}
 
-
-#ifdef CONFIG_CMA
-	/* If allocation can't use CMA areas don't use free CMA pages */
-	if (!(alloc_flags & ALLOC_CMA))
-		free_pages -= zone_page_state(z, NR_FREE_CMA_PAGES);
-#endif
-
 	/*
 	 * Check watermarks for an order-0 allocation request. If these
 	 * are not met, then a high-order request also cannot go ahead
@@ -3582,25 +3591,22 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
 				unsigned long mark, int highest_zoneidx,
 				unsigned int alloc_flags)
 {
-	long free_pages = zone_page_state(z, NR_FREE_PAGES);
-	long cma_pages = 0;
+	long free_pages;
 
-#ifdef CONFIG_CMA
-	/* If allocation can't use CMA areas don't use free CMA pages */
-	if (!(alloc_flags & ALLOC_CMA))
-		cma_pages = zone_page_state(z, NR_FREE_CMA_PAGES);
-#endif
+	free_pages = zone_page_state(z, NR_FREE_PAGES);
 
 	/*
 	 * Fast check for order-0 only. If this fails then the reserves
-	 * need to be calculated. There is a corner case where the check
-	 * passes but only the high-order atomic reserve are free. If
-	 * the caller is !atomic then it'll uselessly search the free
-	 * list. That corner case is then slower but it is harmless.
+	 * need to be calculated.
 	 */
-	if (!order && (free_pages - cma_pages) >
-				mark + z->lowmem_reserve[highest_zoneidx])
-		return true;
+	if (!order) {
+		long fast_free;
+
+		fast_free = free_pages;
+		fast_free -= __zone_watermark_unusable_free(z, 0, alloc_flags);
+		if (fast_free > mark + z->lowmem_reserve[highest_zoneidx])
+			return true;
+	}
 
 	return __zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
 					free_pages);
-- 
2.17.1

