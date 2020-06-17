Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE0BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20BF206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NZIJrzhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgFPIE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:04:27 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:41370 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgFPIEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:04:22 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200616080416epoutp041463fe4a30ddf527cbd99c94b66d0590~Y9424J1N00581905819epoutp049
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 08:04:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200616080416epoutp041463fe4a30ddf527cbd99c94b66d0590~Y9424J1N00581905819epoutp049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592294656;
        bh=oRbHyIXUJAGMWKLhaPz0JjuKkfxnaueeGU3pawOP+IY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=NZIJrzhfG3xpPg7zKuGe0ZUT3dxl4IyXT6up5G7oAHOCx6mJ4qLLc+KUgOeSmdlEF
         wVWG3z/fyLxT0KtotvDrASCTMClVkTndHxVPDmiOOxWp4tIhYii9BfBhgu8hBI9pfw
         KR05J5nSj5j80tXVuDDv0xQMG3ZWY+rOTkaoow8Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200616080415epcas1p473686afbba657bcbc05580b728e2b0ce~Y942XClvx0344503445epcas1p4q;
        Tue, 16 Jun 2020 08:04:15 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.160]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49mLM23W78zMqYl5; Tue, 16 Jun
        2020 08:04:14 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.A1.19033.DFC78EE5; Tue, 16 Jun 2020 17:04:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200616080413epcas1p4c8ff98e9a79c59fd9a43db6a9d507417~Y94z3Dbfl0344503445epcas1p4f;
        Tue, 16 Jun 2020 08:04:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200616080413epsmtrp15ad294868c14290683eaac3425a8cf78~Y94z2VqnK3169631696epsmtrp1v;
        Tue, 16 Jun 2020 08:04:13 +0000 (GMT)
X-AuditID: b6c32a36-6ed22a8000004a59-6e-5ee87cfd9935
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.8C.08382.CFC78EE5; Tue, 16 Jun 2020 17:04:12 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.229]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200616080412epsmtip15779ac4a6b33ee5267dc26596efeba01~Y94zq9ey70885008850epsmtip1-;
        Tue, 16 Jun 2020 08:04:12 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     vbabka@suse.cz, bhe@redhat.com, mgorman@techsingularity.net,
        minchan@kernel.org, mgorman@suse.de, hannes@cmpxchg.org,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, ytk.lee@samsung.com,
        cmlaika.kim@samsung.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v3] page_alloc: consider highatomic reserve in wmartermark
 fast
Date:   Wed, 17 Jun 2020 11:05:50 +0900
Message-Id: <20200617020550.23159-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdljTQPdvzYs4g6PfRCzmrF/DZnH+wS82
        i5XzzrFZrN7ka9G9eSajRe/7V0wWl3fNYbO4t+Y/q8Xkd88YLXYs3cdksezre3aL2Y19jBaP
        13M78HocfvOe2WPnrLvsHptWdbJ5bPo0id3jxIzfLB7v911l8+jbsorR48yCI+wem09Xe2z9
        ZefxeZNcAHdUjk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4Cu
        W2YO0PlKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAJDgwK94sTc4tK8dL3k/Fwr
        QwMDI1OgyoScjNNr7rIXTM2omNvRytrAeCGyi5GTQ0LAROLk90fsXYxcHEICOxglpmyaAOV8
        YpT4/GwuC4TzjVFi2cLVbDAt7Y9uMEIk9jJKTGxeyAzh/GCUeLPoKStIFZuAtsT7BZNYQRIi
        AtMZJfbcWwLWwiywlFHi8q0bQFs4OIQFAiVaXvOBNLAIqEo8eXQZbAWvgK3EpVVHmSHWyUus
        3nAAbIOEQCeHxLOeOYwQCReJ5xOmskDYwhKvjm9hh7ClJF72t0HZ9RJ79v+FGtTAKPH/owCE
        bSwxvwXkbA6ggzQl1u/ShwgrSuz8PRdsPLMAn8S7rz2sICUSArwSHW1CECVqEi3PvrJC2DIS
        f/89g7I9JJYtWgRmCwnESnQvOcIygVF2FsKCBYyMqxjFUguKc9NTiw0LjJCjaRMjOFFqme1g
        nPT2g94hRiYOxkOMEhzMSiK80bYv4oR4UxIrq1KL8uOLSnNSiw8xmgLDayKzlGhyPjBV55XE
        G5oaGRsbW5iYmZuZGiuJ86rJXIgTEkhPLEnNTk0tSC2C6WPi4JRqYKp6f+HoDgbezhllNrUB
        T1h+pEz0mMgn721neHV7kXfKoiuBopY7dyhYybFNjq5a9iv0+qKsCYeetv3wuXikqvP5J6aw
        ycWCYq7M6bqcX7l4Xn/q6VV8lMv6cY/Wok5zxttZBpLRG18Ia/9XYeC3+NW1c5cvv2KObOS6
        Qn+zGd/3RPT2Tsyw6W52yjBpPDdHcVL4wl+iD/ub1nQx2cpcPtvwa67WQac8nnscuZoG3DYT
        A9Tnf57XPGP6Su7S/d1hW7lC1367/fz7Tp05G+KPqnknC/+yd7G/as10ftvD82G8wdKHpuWF
        1k+r+zYxcJv6w7VlF9x1PfdOWxMhPiX64clfGd8f/6mJMc8MlLn9T4mlOCPRUIu5qDgRAHYB
        PpwdBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSnO7fmhdxBjMFLeasX8Nmcf7BLzaL
        lfPOsVms3uRr0b15JqNF7/tXTBaXd81hs7i35j+rxeR3zxgtdizdx2Sx7Ot7dovZjX2MFo/X
        czvwehx+857ZY+esu+wem1Z1snls+jSJ3ePEjN8sHu/3XWXz6NuyitHjzIIj7B6bT1d7bP1l
        5/F5k1wAdxSXTUpqTmZZapG+XQJXxuk1d9kLpmZUzO1oZW1gvBDZxcjJISFgItH+6AZjFyMX
        h5DAbkaJnRNeMkIkZCTenH/K0sXIAWQLSxw+XAxR841R4mHvFFaQGjYBbYn3CyaxgiREBOYz
        SuxZd4oNxGEWWA1U9eEwM0i3sIC/xOY2UZAGFgFViSePLrOB2LwCthKXVh1lhlgmL7F6wwHm
        CYw8CxgZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBAetluYOxu2rPugdYmTiYDzE
        KMHBrCTCG237Ik6INyWxsiq1KD++qDQntfgQozQHi5I4743ChXFCAumJJanZqakFqUUwWSYO
        TqkGJvb64+u83DU2q2o2TT5ebj1z3+qkRlmD2ru+i84ZztzKufDuk43MLjvM73Dk+PyOLHOy
        Uu0oEt0tMneuUk31ksnV6pItbyKnVX1YF1Re+eOw702vI8anlh4R23fNNfjdlGe5VzeYik6P
        CZrgwqmwP7IuxWzbozUJT3Y/ZnWoSeXNnlA3YdPUVUFbjlwIdtjUvOr4ND8J3ZULw2PcygOD
        Ft+8+dPsVJTPya+nC2/NZPVbuGlDd3Iy1/Xbce+XGSTt1UgSLZ1i9/7dg5OXZm/j/Piu+J57
        BqfkL5aUH6WbVaYvCWarWOhf6eUpt8im+PaNE18fBurMmukaebNcZp+y/pLCTZdcOwzWF5er
        tmo9k1ViKc5INNRiLipOBABmNHqhyQIAAA==
X-CMS-MailID: 20200616080413epcas1p4c8ff98e9a79c59fd9a43db6a9d507417
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200616080413epcas1p4c8ff98e9a79c59fd9a43db6a9d507417
References: <CGME20200616080413epcas1p4c8ff98e9a79c59fd9a43db6a9d507417@epcas1p4.samsung.com>
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

This is an example of ALLOC_NO_WATERMARKS allocation failure using v4.14
based kernel.

[ 4738.329298] kswapd0: page allocation failure: order:0, mode:0x140000a(GFP_NOIO|__GFP_HIGHMEM|__GFP_MOVABLE), nodemask=(null)
[ 4738.329325] kswapd0 cpuset=/ mems_allowed=0
[ 4738.329339] CPU: 4 PID: 1221 Comm: kswapd0 Not tainted 4.14.113-18770262-userdebug #1
[ 4738.329350] Call trace:
[ 4738.329366] [<0000000000000000>] dump_backtrace+0x0/0x248
[ 4738.329377] [<0000000000000000>] show_stack+0x18/0x20
[ 4738.329390] [<0000000000000000>] __dump_stack+0x20/0x28
[ 4738.329398] [<0000000000000000>] dump_stack+0x68/0x90
[ 4738.329409] [<0000000000000000>] warn_alloc+0x104/0x198
[ 4738.329417] [<0000000000000000>] __alloc_pages_nodemask+0xdc0/0xdf0
[ 4738.329427] [<0000000000000000>] zs_malloc+0x148/0x3d0
[ 4738.329438] [<0000000000000000>] zram_bvec_rw+0x410/0x798
[ 4738.329446] [<0000000000000000>] zram_rw_page+0x88/0xdc
[ 4738.329455] [<0000000000000000>] bdev_write_page+0x70/0xbc
[ 4738.329463] [<0000000000000000>] __swap_writepage+0x58/0x37c
[ 4738.329469] [<0000000000000000>] swap_writepage+0x40/0x4c
[ 4738.329478] [<0000000000000000>] shrink_page_list+0xc30/0xf48
[ 4738.329486] [<0000000000000000>] shrink_inactive_list+0x2b0/0x61c
[ 4738.329494] [<0000000000000000>] shrink_node_memcg+0x23c/0x618
[ 4738.329501] [<0000000000000000>] shrink_node+0x1c8/0x304
[ 4738.329509] [<0000000000000000>] kswapd+0x680/0x7c4
[ 4738.329518] [<0000000000000000>] kthread+0x110/0x120
[ 4738.329527] [<0000000000000000>] ret_from_fork+0x10/0x18
[ 4738.329538] Mem-Info:
[ 4738.329574] active_anon:111826 inactive_anon:65557 isolated_anon:0\x0a active_file:44260 inactive_file:83422 isolated_file:0\x0a unevictable:4158 dirty:117 writeback:0 unstable:0\x0a            slab_reclaimable:13943 slab_unreclaimable:43315\x0a mapped:102511 shmem:3299 pagetables:19566 bounce:0\x0a free:3510 free_pcp:553 free_cma:0
[ 4738.329593] Node 0 active_anon:447304kB inactive_anon:262228kB active_file:177040kB inactive_file:333688kB unevictable:16632kB isolated(anon):0kB isolated(file):0kB mapped:410044kB d irty:468kB writeback:0kB shmem:13196kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
[ 4738.329603] Normal free:14040kB min:7440kB low:94500kB high:98136kB reserved_highatomic:32768KB active_anon:447336kB inactive_anon:261668kB active_file:177572kB inactive_file:333768k           B unevictable:16632kB writepending:480kB present:4081664kB managed:3637088kB mlocked:16632kB kernel_stack:47072kB pagetables:78264kB bounce:0kB free_pcp:2280kB local_pcp:720kB free_cma:0kB        [ 4738.329607] lowmem_reserve[]: 0 0
[ 4738.329615] Normal: 860*4kB (H) 453*8kB (H) 180*16kB (H) 26*32kB (H) 34*64kB (H) 6*128kB (H) 2*256kB (H) 0*512kB 0*1024kB 0*2048kB 0*4096kB = 14232kB

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
---
v3: change log in description to one having reserved_highatomic
    change comment in code
v2: factor out common part
v1: consider highatomic reserve
---
 mm/page_alloc.c | 66 +++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 48eb0f1410d4..fe83f88ce188 100644
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
+	long unusable_free;
 
-#ifdef CONFIG_CMA
-	/* If allocation can't use CMA areas don't use free CMA pages */
-	if (!(alloc_flags & ALLOC_CMA))
-		cma_pages = zone_page_state(z, NR_FREE_CMA_PAGES);
-#endif
+	free_pages = zone_page_state(z, NR_FREE_PAGES);
+	unusable_free = __zone_watermark_unusable_free(z, order, alloc_flags);
 
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
+		long fast_free = free_pages - unusable_free;
+
+		if (fast_free > mark + z->lowmem_reserve[highest_zoneidx])
+			return true;
+	}
 
 	return __zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
 					free_pages);
-- 
2.17.1

