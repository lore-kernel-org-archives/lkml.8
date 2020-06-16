Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF124C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B259920767
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MQ+1yvny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgFPHaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:30:11 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:19475 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgFPHaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:30:10 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200616073005epoutp04ebf8110dc493dff353dd35151f8321e9~Y9bAjU9PC0585105851epoutp04h
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:30:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200616073005epoutp04ebf8110dc493dff353dd35151f8321e9~Y9bAjU9PC0585105851epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592292605;
        bh=bA2MSjL/P5v5zE2Kh0X2IBWzO9xX+XwU6TbmtBop//U=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=MQ+1yvnyKrPxRnzZ3STcA1r7P7DIlDN5l3P++bF4hbzKwBhFvJRnpNd7/Bffc4ukA
         9l65iyTAGOOdiGF/Hmx2e8vXrJImD7F1TuIeEFcEGDPekKAlb4pSBQovxO/ECpTvYG
         AGQKULyYRd9skInc3F2uxmfJuX6avdcsTjgOhGzc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200616073003epcas1p1c0f64d389d9d7c0f5365dcbbf8008846~Y9a-bO9IK2467524675epcas1p1i;
        Tue, 16 Jun 2020 07:30:03 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.161]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49mKbZ6X3VzMqYkn; Tue, 16 Jun
        2020 07:30:02 +0000 (GMT)
X-AuditID: b6c32a38-2cdff70000006fa5-2b-5ee874fadf22
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.54.28581.AF478EE5; Tue, 16 Jun 2020 16:30:02 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v2] page_alloc: consider highatomic reserve in
 wmartermark fast
Reply-To: jaewon31.kim@samsung.com
From:   =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
To:     Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
        Jaewon Kim <jaewon31.kim@gmail.com>
CC:     =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?7J207Jqp7YOd?= <ytk.lee@samsung.com>,
        =?UTF-8?B?6rmA7LKg66+8?= <cmlaika.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <26a6a2c2-56e6-1a34-84ac-8ff9f74c34ce@suse.cz>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200616073002epcms1p12a14cc85b0aebf8ba88bedee7495b34f@epcms1p1>
Date:   Tue, 16 Jun 2020 16:30:02 +0900
X-CMS-MailID: 20200616073002epcms1p12a14cc85b0aebf8ba88bedee7495b34f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmge6vkhdxBhO6jC3mrF/DZnH+wS82
        i5XzzrFZrN7ka9G9eSajRe/7V0wWl3fNYbO4t+Y/q8Xkd88YLXYs3cdksezre3aL2Y19jBaP
        13M78HocfvOe2WPnrLvsHptWdbJ5bPo0id3jxIzfLB7v911l8+jbsorR48yCI+wem09Xe2z9
        ZefxeZNcAHdUjk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4Cu
        W2YO0PlKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAJDgwK94sTc4tK8dL3k/Fwr
        QwMDI1OgyoScjPO3VrIWnPCreDttP3MD43anLkZODgkBE4l/X66xdTFycQgJ7GCUWLz0PXsX
        IwcHr4CgxN8dwiA1wgIREh8aOllAbCEBJYmzP66wQ8StJfYvmsEEYrMJWEpsvzmREcQWEciQ
        uLxlFTvITGaBb8wSqyc0MEMs45WY0f6UBcKWlti+fCsjyC5OoEGz2/0gwqISN1e/ZYex3x+b
        zwhhi0i03jsLNUZQ4sHP3VBxKYnL+zaxgIyREKiX2HA7D2SthEADo0THyS+sEHF9iT8n+UHK
        eQV8JT49XMYGEmYRUJVoOC0FMcVFYs7HdawgNrOAvMT2t3OYQUqYBTQl1u/ShyhRlNj5ey4j
        RAmfxLuvPawwP+2Y94QJwlaTaHn2FSouI/H33zMo20Ni3tXbTJBAvsAksfRJP9sERoVZiHCe
        hWTzLITNCxiZVzGKpRYU56anFhsWmCBH7SZGcELWstjBOPftB71DjEwcjIcYJTiYlUR4o21f
        xAnxpiRWVqUW5ccXleakFh9iNAV6eSKzlGhyPjAn5JXEG5oaGRsbW5iYmZuZGiuJ8560uhAn
        JJCeWJKanZpakFoE08fEwSnVwKQp95tv2eWjJu/DWVk1F1fclHWY4lD3ym5WZ9SJWoZ7Rok7
        hR9c/WHiP3OZdalH3d6CFf8cHq/Urtvyi6fsjtrtUz36L6y3zDNRdNDR4GZay/zz6bXNnJtv
        X3sZJMcj2h1YH/UgL5h77qPDcoECE0Sbuy7Mm3h9sUoAx6EI6R6jaLl7dyVXH5nXxt/IZeOj
        va4tcu+BAyr95j8/1elOPFzxd3VX9cHlRX9OHU9ZetLWVnO3iYDH/EuhcrGyx6dFF/frB66+
        cjiohfcl82+mvn3L017NsLl6bPOm1oX7bnI+Kf48o1lpM8vp4C0L9vFEmX7bttxee62r3sdp
        rps4F/EIlwkw6K7ef0+OzSbYhVOJpTgj0VCLuag4EQBa+wEtUQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200612085027epcas1p46383a7eda792eabbd1e74cd08fe988c9
References: <26a6a2c2-56e6-1a34-84ac-8ff9f74c34ce@suse.cz>
        <20200613025102.12880-1-jaewon31.kim@samsung.com>
        <20200613094228.GB3346@MiWiFi-R3L-srv>
        <CAJrd-Ut=QcK5FQP2TUm6==mowoVK_QVCB7x=LL4iUnZxBLYAmA@mail.gmail.com>
        <20200613231736.GJ20367@MiWiFi-R3L-srv>
        <CGME20200612085027epcas1p46383a7eda792eabbd1e74cd08fe988c9@epcms1p1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 6/14/20 1:17 AM, Baoquan He wrote:
>> On 06/13/20 at 10:08pm, Jaewon Kim wrote:
>> ...
>>> > > This is an example of ALLOC_HARDER allocation failure.
>>> > >
>>> > > <4>[ 6207.637280]  [3:  Binder:9343_3:22875] Binder:9343_3: page allocation failure: order:0, mode:0x480020(GFP_ATOMIC), nodemask=(null)
>>> > > <4>[ 6207.637311]  [3:  Binder:9343_3:22875] Call trace:
>>> > > <4>[ 6207.637346]  [3:  Binder:9343_3:22875] [<ffffff8008f40f8c>] dump_stack+0xb8/0xf0
>>> > > <4>[ 6207.637356]  [3:  Binder:9343_3:22875] [<ffffff8008223320>] warn_alloc+0xd8/0x12c
>>> > > <4>[ 6207.637365]  [3:  Binder:9343_3:22875] [<ffffff80082245e4>] __alloc_pages_nodemask+0x120c/0x1250
>>> > > <4>[ 6207.637374]  [3:  Binder:9343_3:22875] [<ffffff800827f6e8>] new_slab+0x128/0x604
>>> > > <4>[ 6207.637381]  [3:  Binder:9343_3:22875] [<ffffff800827b0cc>] ___slab_alloc+0x508/0x670
>>> > > <4>[ 6207.637387]  [3:  Binder:9343_3:22875] [<ffffff800827ba00>] __kmalloc+0x2f8/0x310
>>> > > <4>[ 6207.637396]  [3:  Binder:9343_3:22875] [<ffffff80084ac3e0>] context_struct_to_string+0x104/0x1cc
>>> > > <4>[ 6207.637404]  [3:  Binder:9343_3:22875] [<ffffff80084ad8fc>] security_sid_to_context_core+0x74/0x144
>>> > > <4>[ 6207.637412]  [3:  Binder:9343_3:22875] [<ffffff80084ad880>] security_sid_to_context+0x10/0x18
>>> > > <4>[ 6207.637421]  [3:  Binder:9343_3:22875] [<ffffff800849bd80>] selinux_secid_to_secctx+0x20/0x28
>>> > > <4>[ 6207.637430]  [3:  Binder:9343_3:22875] [<ffffff800849109c>] security_secid_to_secctx+0x3c/0x70
>>> > > <4>[ 6207.637442]  [3:  Binder:9343_3:22875] [<ffffff8008bfe118>] binder_transaction+0xe68/0x454c
>>> > > <4>[ 6207.637569]  [3:  Binder:9343_3:22875] Mem-Info:
>>> > > <4>[ 6207.637595]  [3:  Binder:9343_3:22875] active_anon:102061 inactive_anon:81551 isolated_anon:0
>>> > > <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  active_file:59102 inactive_file:68924 isolated_file:64
>>> > > <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  unevictable:611 dirty:63 writeback:0 unstable:0
>>> > > <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  slab_reclaimable:13324 slab_unreclaimable:44354
>>> > > <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  mapped:83015 shmem:4858 pagetables:26316 bounce:0
>>> > > <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  free:2727 free_pcp:1035 free_cma:178
>>> > > <4>[ 6207.637616]  [3:  Binder:9343_3:22875] Node 0 active_anon:408244kB inactive_anon:326204kB active_file:236408kB inactive_file:275696kB unevictable:2444kB isolated(anon):0kB isolated(file):256kB mapped:332060kB dirty:252kB writeback:0kB shmem:19432kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
>>> > > <4>[ 6207.637627]  [3:  Binder:9343_3:22875] Normal free:10908kB min:6192kB low:44388kB high:47060kB active_anon:409160kB inactive_anon:325924kB active_file:235820kB inactive_file:276628kB unevictable:2444kB writepending:252kB present:3076096kB managed:2673676kB mlocked:2444kB kernel_stack:62512kB pagetables:105264kB bounce:0kB free_pcp:4140kB local_pcp:40kB free_cma:712kB
>> 
>> Checked this mem info, wondering why there's no 'reserved_highatomic'
>> printing in all these examples.
> 
>Yeah, it better be printed, especially after it's included in watermark
>calculation, so we're less confused by reports of allocation failure where
>watermarks are seemingly ok.
> 


Hello Vlastimil and Baoquan

The log in previous mail was captured from kernel based on v4.14.
After adding the reserved_highatomic log, I finally got a new log below
Let me change description in next patch.

There seems be reserved_highatomic:32768KB and actually 14232kB free.

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
[ 4738.329593] Node 0 active_anon:447304kB inactive_anon:262228kB active_file:177040kB inactive_file:333688kB unevictable:16632kB isolated(anon):0kB isolated(file):0kB mapped:410044kB d           irty:468kB writeback:0kB shmem:13196kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
[ 4738.329603] Normal free:14040kB min:7440kB low:94500kB high:98136kB reserved_highatomic:32768KB active_anon:447336kB inactive_anon:261668kB active_file:177572kB inactive_file:333768k           B unevictable:16632kB writepending:480kB present:4081664kB managed:3637088kB mlocked:16632kB kernel_stack:47072kB pagetables:78264kB bounce:0kB free_pcp:2280kB local_pcp:720kB free_cma:0kB        [ 4738.329607] lowmem_reserve[]: 0 0
[ 4738.329615] Normal: 860*4kB (H) 453*8kB (H) 180*16kB (H) 26*32kB (H) 34*64kB (H) 6*128kB (H) 2*256kB (H) 0*512kB 0*1024kB 0*2048kB 0*4096kB = 14232kB


>...
> 
>>> > >       /*
>>> > >        * Fast check for order-0 only. If this fails then the reserves
>>> > > @@ -3598,9 +3604,12 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
>>> > >        * the caller is !atomic then it'll uselessly search the free
>>> > >        * list. That corner case is then slower but it is harmless.
>>> >
>>> > Do we need remove or adjust the code comment at this place? So Mel have
>>> > foreseen the corner case, just reclaiming to unreserve the highatomic
>>> > might be ignored.
>>> >
>>> 
>>> Hello thank you for your comment.
>>> 
>>> My previous mail to Vlastimil Babka seems to have html.
>>> Let me put  again here because I also think the comment should be changed.
>>> I'd like to hear opinions from the open source community.
>> 
>> Yeah, your replying mail to Vlastimil looks a little messy on format, I
>> didn't scroll down to check.
>> 
>>> 
>>> Additionally actually I think we need accurate counting of highatomic
>>> free after this patch.
>>> 
>>> ----------------------------------------------------------------------------------------
>>> 
>>> As Mel also agreed with me in v1 mail thread, this highatomic reserved should
>>> be considered even in watermark fast.
>>> 
>>> The comment, I think, may need to be changed. Prior to this patch, non
>>> highatomic
>>> allocation may do useless search, but it also can take ALL non highatomic free.
>>> 
>>> With this patch, non highatomic allocation will NOT do useless search. Rather,
>>> it may be required direct reclamation even when there are some non
>>> high atomic free.
>>> 
>>> i.e)
>>> In following situation, watermark check fails (9MB - 8MB < 4MB) though there are
>>> enough free (9MB - 4MB > 4MB). If this is really matter, we need to
>>> count highatomic
>>> free accurately.
>> 
>> Seems to make sense. We only use zone->nr_reserved_highatomic to account
>> the reserved highatomic, don't track how much have been used for
>> highatomic allocation. But not sure if this will happen often, or just a
>> very rare case, whether taking that into account will impact anything.
> 
>Unfortunately there's a problem when trying to account free pages of a migrate
>type exactly, as e.g. during reserve_highatomic_pageblock(), some pages might be
>in pcplist of other cpu with other migratetype, and once they are freed, the
>buddy merging will merge the different migratetypes and distort the accounting.
>Fixing this for all migratetypes would have performance overhead, so we only do
>that for MIGRATE_ISOLATE which is not that frequent (and it took a while to
>eliminate all corner cases), and CMA which doesn't change pageblocks dynamically.

AFAIK we do not account free cma in pcp either. But yes accurate check could be 
overhead. For example, __mod_zone_freepage_state should account highatomic free 
as cma free. And we may see some incorrect accounting issue.

> 
>So either we live with the possible overreclaim due to inaccurate counting per
>your example above, or we instead let order-0 atomic allocations use highatomic
>reserves.
>

Additionally regarding existing Mel's comment, let me remove some of it if you
don't mind.

        /*
         * Fast check for order-0 only. If this fails then the reserves
-        * need to be calculated. There is a corner case where the check
-        * passes but only the high-order atomic reserve are free. If
-        * the caller is !atomic then it'll uselessly search the free
-        * list. That corner case is then slower but it is harmless.
+        * need to be calculated.
         */

I will prepare v3 patch.
Thank you again.
