Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005A5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98280207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gTtv81MU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgFLHzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:55:25 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:27339 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgFLHzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:55:24 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200612075519epoutp02075d96a4f340e8ab6d5a2065d1721042~XvL5mO75J0372703727epoutp02U
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 07:55:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200612075519epoutp02075d96a4f340e8ab6d5a2065d1721042~XvL5mO75J0372703727epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591948519;
        bh=iVnFF8VoAt3bfVNulK0Z04h0tssqIwC6ogaa32p25X0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gTtv81MU3uS9g1o8liA3/syILpLy8tQKelS3quyrzl/xuyoD45XFiCWx3YqJxFj82
         XHWaALgCs6sncvlkT5roJz1qA+PqU+fOHe/c2SyfDCbBaqYczVlBPsuI+sOcyIvHZv
         1AhFxa8e6SwEo8/ZHkZJAii/uRIuAquvFUnZMh9Q=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200612075518epcas1p143c369ba9bf00a7a2b10b03e392ce7ea~XvL46bnbR0984909849epcas1p17;
        Fri, 12 Jun 2020 07:55:18 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49jtLY2Yp3zMqYkW; Fri, 12 Jun
        2020 07:55:17 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.24.29173.2E433EE5; Fri, 12 Jun 2020 16:55:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200612075514epcas1p4a89eb048534f9465c96b3b340a04529e~XvL0v3TAB1718917189epcas1p4n;
        Fri, 12 Jun 2020 07:55:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200612075514epsmtrp19b17ab10dae95defd071b4e87ec13569~XvL0vLZlr1906719067epsmtrp1K;
        Fri, 12 Jun 2020 07:55:14 +0000 (GMT)
X-AuditID: b6c32a37-9b7ff700000071f5-62-5ee334e29549
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.FA.08382.1E433EE5; Fri, 12 Jun 2020 16:55:13 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200612075509epsmtip126327af6c62d6c3177513c46f38a6c8b~XvLwtI_qu2396623966epsmtip1b;
        Fri, 12 Jun 2020 07:55:09 +0000 (GMT)
Subject: Re: [PATCH] page_alloc: consider highatomic reserve in wmartermark
 fast
To:     Minchan Kim <minchan@kernel.org>
Cc:     mgorman@techsingularity.net, mgorman@suse.de, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com,
        ytk.lee@samsung.com, cmlaika.kim@samsung.com
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5EE334DB.5030208@samsung.com>
Date:   Fri, 12 Jun 2020 16:55:07 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200612074040.GA98223@google.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmru4jk8dxBn8aVCzmrF/DZrFy3jk2
        i9WbfC26N89ktLi8aw6bxb01/1ktJr97xmixY+k+JotlX9+zWzxez+3A5XH4zXtmj52z7rJ7
        bFrVyeax6dMkdo8TM36zePRtWcXosfl0tcfWX3YenzfJBXBG5dhkpCampBYppOYl56dk5qXb
        KnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAF2ppFCWmFMKFApILC5W0rezKcovLUlV
        yMgvLrFVSi1IySkwNCjQK07MLS7NS9dLzs+1MjQwMDIFqkzIyfi6ZhlrwYacirXTJ7M1MD6O
        7mLk5JAQMJG4e2giWxcjF4eQwA5GiXVPm1kgnE+MEm/Ob2KHcL4xSjxbeJsJpqWz5RYrRGIv
        o8SRQ5+YIZy3jBJ3jjxkBakSFgiSWHNzOjOILSKgIvHn6T9GkCJmgduMEv8vTgZLsAloS7xf
        MAmsgVdAS+JB53MWEJtFQFXiz/RPYDWiAhESO+Z+ZISoEZQ4OfMJWA2ngIHE0l9LweLMAvIS
        zVtng10hIbCWQ+JW6wZmiFtdJNYu28EKYQtLvDq+hR3ClpJ42d8GZddL7Nn/F6q+Aei6jwIQ
        trHE/JaFQHEOoAWaEut36UOEFSV2/p4LtZdP4t3XHlaQEgkBXomONiGIEjWJlmdfobbKSPz9
        9wzK9pDY1vwbbJOQwEEmid69XBMYFWYh+WwWkm9mISxewMi8ilEstaA4Nz212LDAGDmKNzGC
        062W+Q7GaW8/6B1iZOJgPMQowcGsJMIrKP4wTog3JbGyKrUoP76oNCe1+BCjKTB8JzJLiSbn
        AxN+Xkm8oamRsbGxhYmZuZmpsZI4r6/VhTghgfTEktTs1NSC1CKYPiYOTqkGJmnO+p+CSXFa
        Vm//Gwg82WMS8cF3qs38STvy41L/12Rlv695qsPD9uiY+JWW+Q5y7jyX5KWXsfGqfm18ve7/
        Lb8g0ab5MXEzX693MvvUoMf/lL89jbVvtouTRUx0ootzpEyvR+2PPlX/2tcbU1h/MopfMLRy
        NU4MOjpJXiXpoZmp59eDJ/Tn3C7i9TvudONerM2HOy1nYndUK11MOid4/lxE98ZlsQFr58Wv
        13se+6X53rfecws/N/F0tIVfs38U//4in9eJNKs/bVNDTPgSDIoXOzPyFb59MLXkPOPcyLVs
        Gd923Ug+yPrryo9b7XFW992T5j2eIK+jyjP164GUl+tMXoVqLs2UPfHlR+sDJZbijERDLeai
        4kQAzazynUAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSnO5Dk8dxBhs3W1rMWb+GzWLlvHNs
        Fqs3+Vp0b57JaHF51xw2i3tr/rNaTH73jNFix9J9TBbLvr5nt3i8ntuBy+Pwm/fMHjtn3WX3
        2LSqk81j06dJ7B4nZvxm8ejbsorRY/Ppao+tv+w8Pm+SC+CM4rJJSc3JLEst0rdL4Mr4umYZ
        a8GGnIq10yezNTA+ju5i5OSQEDCR6Gy5xdrFyMUhJLCbUeLI9r/MEAkZiTfnn7J0MXIA2cIS
        hw8XQ9S8ZpRo7PvGBFIjLBAksebmdLB6EQEViT9P/zFCFB1kkrj38gsziMMscJtRYsbbK2Ad
        bALaEu8XTGIFsXkFtCQedD5nAbFZBFQl/kz/BDZJVCBCYvW6a8wQNYISJ2c+AavhFDCQWPpr
        KSOIzSygLvFn3iVmCFteonnrbOYJjIKzkLTMQlI2C0nZAkbmVYySqQXFuem5xYYFhnmp5XrF
        ibnFpXnpesn5uZsYwXGkpbmDcfuqD3qHGJk4GA8xSnAwK4nwCoo/jBPiTUmsrEotyo8vKs1J
        LT7EKM3BoiTOe6NwYZyQQHpiSWp2ampBahFMlomDU6qBKTV9hvEKfffNbb9T7k3kvq9mopfP
        VTLj1YmWt2xzufczOm7IeNpkaLnxsu/ut2unOkz4sfzkfJFSBZ0HWu+OmvypNmv/LbReyGBH
        ZAhXMWfzLGcNvbeVjQc7l8Ulubm9zfMM+37acenKOZ9//LUvu9mpMOVkpA+fvEz9/TOzYqsO
        7Fl/NFy9/h7r53YTrRUNgryKPhznMnWn5TddEi9ovBh4RnzL8WmTbma+CEl2v/7y9dylCXUv
        XHfu2mNcanw+/peME9Ofg+1PnAJrt39u9hdk8y3qZFF/ZxOy2uO71N1Lf12vfuo9M92gt8K9
        qi1JRlxC+dP2sp7avp33ztVM1Jh7Y973mOnvui9M4vm7U4mlOCPRUIu5qDgRAAnjO9ISAwAA
X-CMS-MailID: 20200612075514epcas1p4a89eb048534f9465c96b3b340a04529e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200609095139epcas1p17f9c213de6daf25fe848921bc70481c0
References: <CGME20200609095139epcas1p17f9c213de6daf25fe848921bc70481c0@epcas1p1.samsung.com>
        <20200609095128.8112-1-jaewon31.kim@samsung.com>
        <20200610012112.GA239587@google.com> <5EE1F134.4090001@samsung.com>
        <20200612065523.GA92598@google.com> <5EE328CD.2060100@samsung.com>
        <20200612074040.GA98223@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020년 06월 12일 16:40, Minchan Kim wrote:
> On Fri, Jun 12, 2020 at 04:03:41PM +0900, Jaewon Kim wrote:
>>
>> On 2020년 06월 12일 15:55, Minchan Kim wrote:
>>> On Thu, Jun 11, 2020 at 05:54:12PM +0900, Jaewon Kim wrote:
>>>> On 2020년 06월 10일 10:21, Minchan Kim wrote:
>>>>> Hi Jaewon,
>>>>>
>>>>> On Tue, Jun 09, 2020 at 06:51:28PM +0900, Jaewon Kim wrote:
>>>>>> zone_watermark_fast was introduced by commit 48ee5f3696f6 ("mm,
>>>>>> page_alloc: shortcut watermark checks for order-0 pages"). The commit
>>>>>> simply checks if free pages is bigger than watermark without additional
>>>>>> calculation such like reducing watermark.
>>>>>>
>>>>>> It considered free cma pages but it did not consider highatomic
>>>>>> reserved. This may incur exhaustion of free pages except high order
>>>>>> atomic free pages.
>>>>>>
>>>>>> Assume that reserved_highatomic pageblock is bigger than watermark min,
>>>>>> and there are only few free pages except high order atomic free. Because
>>>>>> zone_watermark_fast passes the allocation without considering high order
>>>>>> atomic free, normal reclaimable allocation like GFP_HIGHUSER will
>>>>>> consume all the free pages. Then finally order-0 atomic allocation may
>>>>>> fail on allocation.
>>>>>>
>>>>>> This means watermark min is not protected against non-atomic allocation.
>>>>>> The order-0 atomic allocation with ALLOC_HARDER unwantedly can be
>>>>>> failed. Additionally the __GFP_MEMALLOC allocation with
>>>>>> ALLOC_NO_WATERMARKS also can be failed.
>>>>>>
>>>>>> To avoid the problem, zone_watermark_fast should consider highatomic
>>>>>> reserve. If the actual size of high atomic free is counted accurately
>>>>>> like cma free, we may use it. On this patch just use
>>>>>> nr_reserved_highatomic.
>>>>>>
>>>>>> This is trace log which shows GFP_HIGHUSER consumes free pages right
>>>>>> before ALLOC_NO_WATERMARKS.
>>>>>>
>>>>>>   <...>-22275 [006] ....   889.213383: mm_page_alloc: page=00000000d2be5665 pfn=970744 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>>>>>>   <...>-22275 [006] ....   889.213385: mm_page_alloc: page=000000004b2335c2 pfn=970745 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>>>>>>   <...>-22275 [006] ....   889.213387: mm_page_alloc: page=00000000017272e1 pfn=970278 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>>>>>>   <...>-22275 [006] ....   889.213389: mm_page_alloc: page=00000000c4be79fb pfn=970279 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>>>>>>   <...>-22275 [006] ....   889.213391: mm_page_alloc: page=00000000f8a51d4f pfn=970260 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>>>>>>   <...>-22275 [006] ....   889.213393: mm_page_alloc: page=000000006ba8f5ac pfn=970261 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>>>>>>   <...>-22275 [006] ....   889.213395: mm_page_alloc: page=00000000819f1cd3 pfn=970196 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>>>>>>   <...>-22275 [006] ....   889.213396: mm_page_alloc: page=00000000f6b72a64 pfn=970197 order=0 migratetype=0 nr_free=3650 gfp_flags=GFP_HIGHUSER|__GFP_ZERO
>>>>>> kswapd0-1207  [005] ...1   889.213398: mm_page_alloc: page= (null) pfn=0 order=0 migratetype=1 nr_free=3650 gfp_flags=GFP_NOWAIT|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_MOVABLE
>>>>>>
>>>>>> This is an example of ALLOC_HARDER allocation failure.
>>>>>>
>>>>>> <4>[ 6207.637280]  [3:  Binder:9343_3:22875] Binder:9343_3: page allocation failure: order:0, mode:0x480020(GFP_ATOMIC), nodemask=(null)
>>>>>> <4>[ 6207.637311]  [3:  Binder:9343_3:22875] Call trace:
>>>>>> <4>[ 6207.637346]  [3:  Binder:9343_3:22875] [<ffffff8008f40f8c>] dump_stack+0xb8/0xf0
>>>>>> <4>[ 6207.637356]  [3:  Binder:9343_3:22875] [<ffffff8008223320>] warn_alloc+0xd8/0x12c
>>>>>> <4>[ 6207.637365]  [3:  Binder:9343_3:22875] [<ffffff80082245e4>] __alloc_pages_nodemask+0x120c/0x1250
>>>>>> <4>[ 6207.637374]  [3:  Binder:9343_3:22875] [<ffffff800827f6e8>] new_slab+0x128/0x604
>>>>>> <4>[ 6207.637381]  [3:  Binder:9343_3:22875] [<ffffff800827b0cc>] ___slab_alloc+0x508/0x670
>>>>>> <4>[ 6207.637387]  [3:  Binder:9343_3:22875] [<ffffff800827ba00>] __kmalloc+0x2f8/0x310
>>>>>> <4>[ 6207.637396]  [3:  Binder:9343_3:22875] [<ffffff80084ac3e0>] context_struct_to_string+0x104/0x1cc
>>>>>> <4>[ 6207.637404]  [3:  Binder:9343_3:22875] [<ffffff80084ad8fc>] security_sid_to_context_core+0x74/0x144
>>>>>> <4>[ 6207.637412]  [3:  Binder:9343_3:22875] [<ffffff80084ad880>] security_sid_to_context+0x10/0x18
>>>>>> <4>[ 6207.637421]  [3:  Binder:9343_3:22875] [<ffffff800849bd80>] selinux_secid_to_secctx+0x20/0x28
>>>>>> <4>[ 6207.637430]  [3:  Binder:9343_3:22875] [<ffffff800849109c>] security_secid_to_secctx+0x3c/0x70
>>>>>> <4>[ 6207.637442]  [3:  Binder:9343_3:22875] [<ffffff8008bfe118>] binder_transaction+0xe68/0x454c
>>>>>> <4>[ 6207.637569]  [3:  Binder:9343_3:22875] Mem-Info:
>>>>>> <4>[ 6207.637595]  [3:  Binder:9343_3:22875] active_anon:102061 inactive_anon:81551 isolated_anon:0
>>>>>> <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  active_file:59102 inactive_file:68924 isolated_file:64
>>>>>> <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  unevictable:611 dirty:63 writeback:0 unstable:0
>>>>>> <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  slab_reclaimable:13324 slab_unreclaimable:44354
>>>>>> <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  mapped:83015 shmem:4858 pagetables:26316 bounce:0
>>>>>> <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  free:2727 free_pcp:1035 free_cma:178
>>>>>> <4>[ 6207.637616]  [3:  Binder:9343_3:22875] Node 0 active_anon:408244kB inactive_anon:326204kB active_file:236408kB inactive_file:275696kB unevictable:2444kB isolated(anon):0kB isolated(file):256kB mapped:332060kB dirty:252kB writeback:0kB shmem:19432kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
>>>>>> <4>[ 6207.637627]  [3:  Binder:9343_3:22875] Normal free:10908kB min:6192kB low:44388kB high:47060kB active_anon:409160kB inactive_anon:325924kB active_file:235820kB inactive_file:276628kB unevictable:2444kB writepending:252kB present:3076096kB managed:2673676kB mlocked:2444kB kernel_stack:62512kB pagetables:105264kB bounce:0kB free_pcp:4140kB local_pcp:40kB free_cma:712kB
>>>>>> <4>[ 6207.637632]  [3:  Binder:9343_3:22875] lowmem_reserve[]: 0 0
>>>>>> <4>[ 6207.637637]  [3:  Binder:9343_3:22875] Normal: 505*4kB (H) 357*8kB (H) 201*16kB (H) 65*32kB (H) 1*64kB (H) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 10236kB
>>>>>> <4>[ 6207.637655]  [3:  Binder:9343_3:22875] 138826 total pagecache pages
>>>>>> <4>[ 6207.637663]  [3:  Binder:9343_3:22875] 5460 pages in swap cache
>>>>>> <4>[ 6207.637668]  [3:  Binder:9343_3:22875] Swap cache stats: add 8273090, delete 8267506, find 1004381/4060142
>>>>>>
>>>>>> This is an example of ALLOC_NO_WATERMARKS allocation failure.
>>>>>>
>>>>>> <6>[  156.701551]  [4:        kswapd0: 1209] kswapd0 cpuset=/ mems_allowed=0
>>>>>> <4>[  156.701563]  [4:        kswapd0: 1209] CPU: 4 PID: 1209 Comm: kswapd0 Tainted: G        W       4.14.113-18113966 #1
>>>>>> <4>[  156.701572]  [4:        kswapd0: 1209] Call trace:
>>>>>> <4>[  156.701605]  [4:        kswapd0: 1209] [<0000000000000000>] dump_stack+0x68/0x90
>>>>>> <4>[  156.701612]  [4:        kswapd0: 1209] [<0000000000000000>] warn_alloc+0x104/0x198
>>>>>> <4>[  156.701617]  [4:        kswapd0: 1209] [<0000000000000000>] __alloc_pages_nodemask+0xdc0/0xdf0
>>>>>> <4>[  156.701623]  [4:        kswapd0: 1209] [<0000000000000000>] zs_malloc+0x148/0x3d0
>>>>>> <4>[  156.701630]  [4:        kswapd0: 1209] [<0000000000000000>] zram_bvec_rw+0x250/0x568
>>>>>> <4>[  156.701634]  [4:        kswapd0: 1209] [<0000000000000000>] zram_rw_page+0x8c/0xe0
>>>>>> <4>[  156.701640]  [4:        kswapd0: 1209] [<0000000000000000>] bdev_write_page+0x70/0xbc
>>>>>> <4>[  156.701645]  [4:        kswapd0: 1209] [<0000000000000000>] __swap_writepage+0x58/0x37c
>>>>>> <4>[  156.701649]  [4:        kswapd0: 1209] [<0000000000000000>] swap_writepage+0x40/0x4c
>>>>>> <4>[  156.701654]  [4:        kswapd0: 1209] [<0000000000000000>] shrink_page_list+0xc3c/0xf54
>>>>>> <4>[  156.701659]  [4:        kswapd0: 1209] [<0000000000000000>] shrink_inactive_list+0x2b0/0x61c
>>>>>> <4>[  156.701664]  [4:        kswapd0: 1209] [<0000000000000000>] shrink_node_memcg+0x23c/0x618
>>>>>> <4>[  156.701668]  [4:        kswapd0: 1209] [<0000000000000000>] shrink_node+0x1c8/0x304
>>>>>> <4>[  156.701673]  [4:        kswapd0: 1209] [<0000000000000000>] kswapd+0x680/0x7c4
>>>>>> <4>[  156.701679]  [4:        kswapd0: 1209] [<0000000000000000>] kthread+0x110/0x120
>>>>>> <4>[  156.701684]  [4:        kswapd0: 1209] [<0000000000000000>] ret_from_fork+0x10/0x18
>>>>>> <4>[  156.701689]  [4:        kswapd0: 1209] Mem-Info:
>>>>>> <4>[  156.701712]  [4:        kswapd0: 1209] active_anon:88690 inactive_anon:88630 isolated_anon:0
>>>>>> <4>[  156.701712]  [4:        kswapd0: 1209]  active_file:99173 inactive_file:169305 isolated_file:32
>>>>>> <4>[  156.701712]  [4:        kswapd0: 1209]  unevictable:48292 dirty:538 writeback:38 unstable:0
>>>>>> <4>[  156.701712]  [4:        kswapd0: 1209]  slab_reclaimable:15131 slab_unreclaimable:47762
>>>>>> <4>[  156.701712]  [4:        kswapd0: 1209]  mapped:274654 shmem:2824 pagetables:25088 bounce:0
>>>>>> <4>[  156.701712]  [4:        kswapd0: 1209]  free:2489 free_pcp:444 free_cma:3
>>>>>> <4>[  156.701728]  [4:        kswapd0: 1209] Node 0 active_anon:354760kB inactive_anon:354520kB active_file:396692kB inactive_file:677220kB unevictable:193168kB isolated(anon):0kB isolated(file):128kB mapped:1098616kB dirty:2152kB writeback:152kB shmem:11296kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
>>>>>> <4>[  156.701738]  [4:        kswapd0: 1209] Normal free:9956kB min:7428kB low:93440kB high:97032kB active_anon:355176kB inactive_anon:354580kB active_file:396196kB inactive_file:677284kB unevictable:193168kB writepending:2304kB present:4081664kB managed:3593324kB mlocked:193168kB kernel_stack:55008kB pagetables:100352kB bounce:0kB free_pcp:1776kB local_pcp:656kB free_cma:12kB
>>>>>> <4>[  156.701741]  [4:        kswapd0: 1209] lowmem_reserve[]: 0 0
>>>>>> <4>[  156.701747]  [4:        kswapd0: 1209] Normal: 196*4kB (H) 141*8kB (H) 109*16kB (H) 63*32kB (H) 20*64kB (H) 8*128kB (H) 2*256kB (H) 1*512kB (H) 0*1024kB 0*2048kB 0*4096kB = 9000kB
>>>>>>
>>>>>> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
>>>>>> Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
>>>>>> ---
>>>>>>  mm/page_alloc.c | 13 +++++++++++--
>>>>>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>> index 13cc653122b7..00869378d387 100644
>>>>>> --- a/mm/page_alloc.c
>>>>>> +++ b/mm/page_alloc.c
>>>>>> @@ -3553,6 +3553,11 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
>>>>>>  {
>>>>>>  	long free_pages = zone_page_state(z, NR_FREE_PAGES);
>>>>>>  	long cma_pages = 0;
>>>>>> +	long highatomic = 0;
>>>>>> +	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
>>>>>> +
>>>>>> +	if (likely(!alloc_harder))
>>>>>> +		highatomic = z->nr_reserved_highatomic;
>>>>>>  
>>>>>>  #ifdef CONFIG_CMA
>>>>>>  	/* If allocation can't use CMA areas don't use free CMA pages */
>>>>>> @@ -3567,8 +3572,12 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
>>>>>>  	 * the caller is !atomic then it'll uselessly search the free
>>>>>>  	 * list. That corner case is then slower but it is harmless.
>>>>>>  	 */
>>>>>> -	if (!order && (free_pages - cma_pages) > mark + z->lowmem_reserve[classzone_idx])
>>>>>> -		return true;
>>>>>> +	if (!order) {
>>>>>> +		long fast_free = free_pages - cma_pages - highatomic;
>>>>> With your change, it seems we share most code for getting free_pages 
>>>>> between zone_watermark_fast and __zone_watermark_ok. Only difference
>>>>> between them is min calculation. If so, can we share most code between
>>>>> them via introducing like __zone_watermark_free static inline function?
>>>>> So, we didn't miss one place in future if we change something.
>>>>>
>>>> Hello thank you for your comment.
>>>>
>>>> I tried to share some code.
>>>> Because __zone_watermark_ok gets free pages as argument,
>>>> I just could make a function calculating unusable free.
>>>>
>>>> static inline long __zone_watermark_unusable_free(struct zone *z,
>>>>                                                     unsigned int alloc_flags)
>>>>
>>>> on zone_watermark_fast
>>>> free_pages -= __zone_watermark_unusable_free(z, alloc_flags);
>>>>
>>>> on __zone_watermark_ok
>>>> free_pages -= __zone_watermark_unusable_free(z, alloc_flags);
>>> Don't you need order argument?
>> Yes I actually I also took a consideration for it.
>>
>> If I keep existing logic of zone_watermark_fast,
>> following code in __zone_watermark_ok is not needed for __zone_watermark_unusable_free
>>   free_pages -= (1 << order) - 1;
>>
>> But if __zone_watermark_unusable_free should return
>> all unusable free, the order size should be included.
>>
>> Seems not critical but I want to hear opensource opinion.
> I don't think it could make measurable regression and if we want to
> factor it out, it would be better to be self-contained. To me, it
> looks weird if we need one more logic to consider *order* after
> __zone_watermark_unusable_free. IMHO, if we couldn't make it neat,
> the open-code like as-is would be better.8idfdff
> Since I am not strong against of either way, up to you.
Than you for your opinion. I actually agree on you with that.
Let me include the order and share v2 patch.

Thank you
Jaewon Kim
>
> Thanks.
>
>

