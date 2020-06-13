Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127D4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29FA206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CznrQoVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgFLIuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 04:50:35 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:64628 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgFLIue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 04:50:34 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200612085029epoutp03a69585d66a6066266f935a52ea44dd32~Xv8E9tga62490524905epoutp03L
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 08:50:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200612085029epoutp03a69585d66a6066266f935a52ea44dd32~Xv8E9tga62490524905epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591951830;
        bh=wjBcconf/6hLgF1WnbdIfr/JTD+D08cX7OzDCjsEdYA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=CznrQoVFyJnMj65PMw7ww2TISDGxaAP6ISBC86nhTsFzl3shrv5MKNEY0tP2QpTVd
         Brf56efY/abWswiHn2m6EtPNtTNvLMFMfZrod687TzU/hqQTPoxOZD/SKBtqN1+Wtx
         5CKHSljFtfpgnYnpUuAnvCT1XKgd/MsTUcFxs8AE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200612085028epcas1p351f34b13516d6045dd684c79f5a9b8bc~Xv8D-O_B62657826578epcas1p3M;
        Fri, 12 Jun 2020 08:50:28 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.162]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49jvZC6RKgzMqYl4; Fri, 12 Jun
        2020 08:50:27 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.30.18978.3D143EE5; Fri, 12 Jun 2020 17:50:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200612085027epcas1p46383a7eda792eabbd1e74cd08fe988c9~Xv8CeKmsG0746507465epcas1p4u;
        Fri, 12 Jun 2020 08:50:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200612085027epsmtrp15e687dc1b5374561b8850763e48d820d~Xv8CdY_yT1543715437epsmtrp1q;
        Fri, 12 Jun 2020 08:50:27 +0000 (GMT)
X-AuditID: b6c32a35-5edff70000004a22-dc-5ee341d32b32
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.BF.08382.3D143EE5; Fri, 12 Jun 2020 17:50:27 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.229]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200612085027epsmtip1cbffd0d5afc029e5637f18668775473b~Xv8CRGAsm1749617496epsmtip1z;
        Fri, 12 Jun 2020 08:50:27 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     mgorman@techsingularity.net, minchan@kernel.org, mgorman@suse.de,
        hannes@cmpxchg.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, ytk.lee@samsung.com,
        cmlaika.kim@samsung.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v2] page_alloc: consider highatomic reserve in wmartermark
 fast
Date:   Sat, 13 Jun 2020 11:51:02 +0900
Message-Id: <20200613025102.12880-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmge5lx8dxBgvbjSzmrF/DZrFy3jk2
        i9WbfC26N89ktOh9/4rJ4vKuOWwW99b8Z7WY/O4Zo8WOpfuYLJZ9fc9u8Xg9twO3x+E375k9
        ds66y+6xaVUnm8emT5PYPU7M+M3i0bdlFaPH5tPVHlt/2Xl83iQXwBmVY5ORmpiSWqSQmpec
        n5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdKqSQlliTilQKCCxuFhJ386m
        KL+0JFUhI7+4xFYptSAlp8DQoECvODG3uDQvXS85P9fK0MDAyBSoMiEn48WytcwFm7Ir1p5e
        z9TAeDqqi5GTQ0LARKJz9wfGLkYuDiGBHYwSf9auYIJwPjFKrPiwih3C+cYoseNnCxtMy6TZ
        r1ggEnsZJS5/3QlV9YNRYv6yxSwgVWwC2hLvF0xiBbFFBEolmuavA5vLLLAUqOPWDXaQhLBA
        oMTZc83MIDaLgKrEqvnXwZp5BWwltu/5wgyxTl5i9YYDzCDNEgIv2SUWPDjBApFwkTj38R9U
        kbDEq+Nb2CFsKYmX/W1Qdr3Env1/oWoaGCX+fxSAsI0l5rcsBIpzAF2kKbF+lz5EWFFi5++5
        jCA2swCfxLuvPawgJRICvBIdbUIQJWoSLc++skLYMhJ//z2Dsj0k5l29zQRiCwnEShy/soVp
        AqPsLIQFCxgZVzGKpRYU56anFhsWGCJH0yZGcALUMt3BOPHtB71DjEwcjIcYJTiYlUR4BcUf
        xgnxpiRWVqUW5ccXleakFh9iNAWG10RmKdHkfGAKziuJNzQ1MjY2tjAxMzczNVYS5xWXuRAn
        JJCeWJKanZpakFoE08fEwSnVwGR+emGVh2ZpudS957WrOxZ7fHjWImaX+qgn6kfCut9vp/uX
        K/iq9yXcib3wmXHZBCtZ54L3Z24vsWzMLPvE7pN7arN73ibuJesmHyp+eSl+TdKJR4zR68Wb
        /q3kvSDzqItHipOb4alUtfVB0S9HM8R8NYOEVd5/LJI7YRBX+e5KVEDEgS5995fXrQs/Hp/7
        y/3u09h3b7z3Jy6pCqkwOelisLCldKcui+Lmumsiu73VnLTWxRyZYtwdYyxj2JGQznis4bdg
        471pjj5n9Oa3SntVHnKY+nJVkFtQsvdR5Xc/pRo+Sd2XfLfhqs1JqbXLi1uXG69ozNsYO7OS
        7dthWyV+OReNif2fhXKC9n6QUGIpzkg01GIuKk4EANWOAaoJBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsWy7bCSnO5lx8dxBkvbeC3mrF/DZrFy3jk2
        i9WbfC26N89ktOh9/4rJ4vKuOWwW99b8Z7WY/O4Zo8WOpfuYLJZ9fc9u8Xg9twO3x+E375k9
        ds66y+6xaVUnm8emT5PYPU7M+M3i0bdlFaPH5tPVHlt/2Xl83iQXwBnFZZOSmpNZllqkb5fA
        lfFi2Vrmgk3ZFWtPr2dqYDwd1cXIySEhYCIxafYrli5GLg4hgd2MEj2Pv7JAJGQk3px/CmRz
        ANnCEocPF0PUfGOU+NCyhhmkhk1AW+L9gkmsILaIQLXE5nm32UCKmAVWM0o8/HAYrEhYwF9i
        yZy5YENZBFQlVs2/DmbzCthKbN/zhRlimbzE6g0HmCcw8ixgZFjFKJlaUJybnltsWGCYl1qu
        V5yYW1yal66XnJ+7iREcjlqaOxi3r/qgd4iRiYPxEKMEB7OSCK+g+MM4Id6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4rw3ChfGCQmkJ5akZqemFqQWwWSZODilGphKOSXTpojf6P198+I/mc/OR34l
        CdmuXN017776JQP32D21X7e/KC4I8bkReo49kd961kO+iu2vjvj1mGvMP5T/jbn1WJv9vQQe
        bZMMfU/HiDieDVmlc18f/6vxUlkl/nLJvIyOzWEPJ3LtkjzSGblqjZk+13yegysXb4zb5Oz0
        qG1Fs/XbayyvmR/ILD8vpPKvPvBP5eeH1Tz3HAu+fbr1VuXcgy2R5nMtL1xyq3K8++bCiRn1
        n1K7uorEJLbuC3TjM+fm+qkku3Z5dhCL6YV1yw/tOl+wddEx052tvJ3vWYUrA1d0rPe43M8h
        mTbft2Uhl+7saVuLrI7FCN9vfnF0m8C1G/c5K3M5FrCKxVQosRRnJBpqMRcVJwIA2FFsZ7YC
        AAA=
X-CMS-MailID: 20200612085027epcas1p46383a7eda792eabbd1e74cd08fe988c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200612085027epcas1p46383a7eda792eabbd1e74cd08fe988c9
References: <CGME20200612085027epcas1p46383a7eda792eabbd1e74cd08fe988c9@epcas1p4.samsung.com>
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

This is an example of ALLOC_HARDER allocation failure.

<4>[ 6207.637280]  [3:  Binder:9343_3:22875] Binder:9343_3: page allocation failure: order:0, mode:0x480020(GFP_ATOMIC), nodemask=(null)
<4>[ 6207.637311]  [3:  Binder:9343_3:22875] Call trace:
<4>[ 6207.637346]  [3:  Binder:9343_3:22875] [<ffffff8008f40f8c>] dump_stack+0xb8/0xf0
<4>[ 6207.637356]  [3:  Binder:9343_3:22875] [<ffffff8008223320>] warn_alloc+0xd8/0x12c
<4>[ 6207.637365]  [3:  Binder:9343_3:22875] [<ffffff80082245e4>] __alloc_pages_nodemask+0x120c/0x1250
<4>[ 6207.637374]  [3:  Binder:9343_3:22875] [<ffffff800827f6e8>] new_slab+0x128/0x604
<4>[ 6207.637381]  [3:  Binder:9343_3:22875] [<ffffff800827b0cc>] ___slab_alloc+0x508/0x670
<4>[ 6207.637387]  [3:  Binder:9343_3:22875] [<ffffff800827ba00>] __kmalloc+0x2f8/0x310
<4>[ 6207.637396]  [3:  Binder:9343_3:22875] [<ffffff80084ac3e0>] context_struct_to_string+0x104/0x1cc
<4>[ 6207.637404]  [3:  Binder:9343_3:22875] [<ffffff80084ad8fc>] security_sid_to_context_core+0x74/0x144
<4>[ 6207.637412]  [3:  Binder:9343_3:22875] [<ffffff80084ad880>] security_sid_to_context+0x10/0x18
<4>[ 6207.637421]  [3:  Binder:9343_3:22875] [<ffffff800849bd80>] selinux_secid_to_secctx+0x20/0x28
<4>[ 6207.637430]  [3:  Binder:9343_3:22875] [<ffffff800849109c>] security_secid_to_secctx+0x3c/0x70
<4>[ 6207.637442]  [3:  Binder:9343_3:22875] [<ffffff8008bfe118>] binder_transaction+0xe68/0x454c
<4>[ 6207.637569]  [3:  Binder:9343_3:22875] Mem-Info:
<4>[ 6207.637595]  [3:  Binder:9343_3:22875] active_anon:102061 inactive_anon:81551 isolated_anon:0
<4>[ 6207.637595]  [3:  Binder:9343_3:22875]  active_file:59102 inactive_file:68924 isolated_file:64
<4>[ 6207.637595]  [3:  Binder:9343_3:22875]  unevictable:611 dirty:63 writeback:0 unstable:0
<4>[ 6207.637595]  [3:  Binder:9343_3:22875]  slab_reclaimable:13324 slab_unreclaimable:44354
<4>[ 6207.637595]  [3:  Binder:9343_3:22875]  mapped:83015 shmem:4858 pagetables:26316 bounce:0
<4>[ 6207.637595]  [3:  Binder:9343_3:22875]  free:2727 free_pcp:1035 free_cma:178
<4>[ 6207.637616]  [3:  Binder:9343_3:22875] Node 0 active_anon:408244kB inactive_anon:326204kB active_file:236408kB inactive_file:275696kB unevictable:2444kB isolated(anon):0kB isolated(file):256kB mapped:332060kB dirty:252kB writeback:0kB shmem:19432kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
<4>[ 6207.637627]  [3:  Binder:9343_3:22875] Normal free:10908kB min:6192kB low:44388kB high:47060kB active_anon:409160kB inactive_anon:325924kB active_file:235820kB inactive_file:276628kB unevictable:2444kB writepending:252kB present:3076096kB managed:2673676kB mlocked:2444kB kernel_stack:62512kB pagetables:105264kB bounce:0kB free_pcp:4140kB local_pcp:40kB free_cma:712kB
<4>[ 6207.637632]  [3:  Binder:9343_3:22875] lowmem_reserve[]: 0 0
<4>[ 6207.637637]  [3:  Binder:9343_3:22875] Normal: 505*4kB (H) 357*8kB (H) 201*16kB (H) 65*32kB (H) 1*64kB (H) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 10236kB
<4>[ 6207.637655]  [3:  Binder:9343_3:22875] 138826 total pagecache pages
<4>[ 6207.637663]  [3:  Binder:9343_3:22875] 5460 pages in swap cache
<4>[ 6207.637668]  [3:  Binder:9343_3:22875] Swap cache stats: add 8273090, delete 8267506, find 1004381/4060142

This is an example of ALLOC_NO_WATERMARKS allocation failure.

<6>[  156.701551]  [4:        kswapd0: 1209] kswapd0 cpuset=/ mems_allowed=0
<4>[  156.701563]  [4:        kswapd0: 1209] CPU: 4 PID: 1209 Comm: kswapd0 Tainted: G        W       4.14.113-18113966 #1
<4>[  156.701572]  [4:        kswapd0: 1209] Call trace:
<4>[  156.701605]  [4:        kswapd0: 1209] [<0000000000000000>] dump_stack+0x68/0x90
<4>[  156.701612]  [4:        kswapd0: 1209] [<0000000000000000>] warn_alloc+0x104/0x198
<4>[  156.701617]  [4:        kswapd0: 1209] [<0000000000000000>] __alloc_pages_nodemask+0xdc0/0xdf0
<4>[  156.701623]  [4:        kswapd0: 1209] [<0000000000000000>] zs_malloc+0x148/0x3d0
<4>[  156.701630]  [4:        kswapd0: 1209] [<0000000000000000>] zram_bvec_rw+0x250/0x568
<4>[  156.701634]  [4:        kswapd0: 1209] [<0000000000000000>] zram_rw_page+0x8c/0xe0
<4>[  156.701640]  [4:        kswapd0: 1209] [<0000000000000000>] bdev_write_page+0x70/0xbc
<4>[  156.701645]  [4:        kswapd0: 1209] [<0000000000000000>] __swap_writepage+0x58/0x37c
<4>[  156.701649]  [4:        kswapd0: 1209] [<0000000000000000>] swap_writepage+0x40/0x4c
<4>[  156.701654]  [4:        kswapd0: 1209] [<0000000000000000>] shrink_page_list+0xc3c/0xf54
<4>[  156.701659]  [4:        kswapd0: 1209] [<0000000000000000>] shrink_inactive_list+0x2b0/0x61c
<4>[  156.701664]  [4:        kswapd0: 1209] [<0000000000000000>] shrink_node_memcg+0x23c/0x618
<4>[  156.701668]  [4:        kswapd0: 1209] [<0000000000000000>] shrink_node+0x1c8/0x304
<4>[  156.701673]  [4:        kswapd0: 1209] [<0000000000000000>] kswapd+0x680/0x7c4
<4>[  156.701679]  [4:        kswapd0: 1209] [<0000000000000000>] kthread+0x110/0x120
<4>[  156.701684]  [4:        kswapd0: 1209] [<0000000000000000>] ret_from_fork+0x10/0x18
<4>[  156.701689]  [4:        kswapd0: 1209] Mem-Info:
<4>[  156.701712]  [4:        kswapd0: 1209] active_anon:88690 inactive_anon:88630 isolated_anon:0
<4>[  156.701712]  [4:        kswapd0: 1209]  active_file:99173 inactive_file:169305 isolated_file:32
<4>[  156.701712]  [4:        kswapd0: 1209]  unevictable:48292 dirty:538 writeback:38 unstable:0
<4>[  156.701712]  [4:        kswapd0: 1209]  slab_reclaimable:15131 slab_unreclaimable:47762
<4>[  156.701712]  [4:        kswapd0: 1209]  mapped:274654 shmem:2824 pagetables:25088 bounce:0
<4>[  156.701712]  [4:        kswapd0: 1209]  free:2489 free_pcp:444 free_cma:3
<4>[  156.701728]  [4:        kswapd0: 1209] Node 0 active_anon:354760kB inactive_anon:354520kB active_file:396692kB inactive_file:677220kB unevictable:193168kB isolated(anon):0kB isolated(file):128kB mapped:1098616kB dirty:2152kB writeback:152kB shmem:11296kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
<4>[  156.701738]  [4:        kswapd0: 1209] Normal free:9956kB min:7428kB low:93440kB high:97032kB active_anon:355176kB inactive_anon:354580kB active_file:396196kB inactive_file:677284kB unevictable:193168kB writepending:2304kB present:4081664kB managed:3593324kB mlocked:193168kB kernel_stack:55008kB pagetables:100352kB bounce:0kB free_pcp:1776kB local_pcp:656kB free_cma:12kB
<4>[  156.701741]  [4:        kswapd0: 1209] lowmem_reserve[]: 0 0
<4>[  156.701747]  [4:        kswapd0: 1209] Normal: 196*4kB (H) 141*8kB (H) 109*16kB (H) 63*32kB (H) 20*64kB (H) 8*128kB (H) 2*256kB (H) 1*512kB (H) 0*1024kB 0*2048kB 0*4096kB = 9000kB

Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
Suggested-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
v2: factor out common part
v1: consider highatomic reserve
---
 mm/page_alloc.c | 61 ++++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 48eb0f1410d4..c2177e056f19 100644
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
@@ -3582,14 +3591,11 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
 				unsigned long mark, int highest_zoneidx,
 				unsigned int alloc_flags)
 {
-	long free_pages = zone_page_state(z, NR_FREE_PAGES);
-	long cma_pages = 0;
+	long free_pages;
+	long unusable_free;
 
-#ifdef CONFIG_CMA
-	/* If allocation can't use CMA areas don't use free CMA pages */
-	if (!(alloc_flags & ALLOC_CMA))
-		cma_pages = zone_page_state(z, NR_FREE_CMA_PAGES);
-#endif
+	free_pages = zone_page_state(z, NR_FREE_PAGES);
+	unusable_free =  __zone_watermark_unusable_free(z, order, alloc_flags);
 
 	/*
 	 * Fast check for order-0 only. If this fails then the reserves
@@ -3598,9 +3604,12 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
 	 * the caller is !atomic then it'll uselessly search the free
 	 * list. That corner case is then slower but it is harmless.
 	 */
-	if (!order && (free_pages - cma_pages) >
-				mark + z->lowmem_reserve[highest_zoneidx])
-		return true;
+	if (!order) {
+		long fast_free = free_pages - unusable_free;
+
+		if (fast_free > mark + z->lowmem_reserve[highest_zoneidx])
+			return true;
+	}
 
 	return __zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
 					free_pages);
-- 
2.17.1

