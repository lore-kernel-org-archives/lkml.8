Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B71C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 13:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD7420739
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 13:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY4rYboi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgFMNJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 09:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgFMNJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 09:09:01 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673BFC03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 06:09:00 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id a21so11419303oic.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 06:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ezJrO4bl+Zo1dB3FFNTKbbxPSw5WftRmcQBu9IAFtFM=;
        b=WY4rYboiD3sPO0NGduWmxIzOdet8efA4CJHFzYuTAdCnPuYAd8RduFbXbJskIS+z/v
         ixoDZd1+42rdILEUakcqC+Rt1UE7rc3F+VwCbQasuH9c63XjkLxp+AoW8KqkiKFYBnnu
         0gJtzxgI9sgxB0fSjgmuVeYbYvU1l5KT+ndKU3q3LAqmFc4ER6A7RaJaKWjZGA5tjJ8G
         PsKYDt6ns4t9dzCXOw0tqn3+/ClauPsTUB0MEIc4TdCbZh7tNz7fCPhoV0gUDgCP7EXF
         Ony+hE91EE+pojefUUU3b2galAqlWE5CMfrVmD77qDseYq/LcT++seFi4ktFAj6FPLAM
         DDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ezJrO4bl+Zo1dB3FFNTKbbxPSw5WftRmcQBu9IAFtFM=;
        b=TvMEzFhpnDT3T46/XtzmORLret9Lg+XeVGiXYRVSnmsUU9r/qtfNsMSuvuJVz+ODoS
         NwC/SdjA4GzJ1FFAk1NbB06wFh1s3S6fXmoYNhas3NvH8/m8maMLDawjpWaXyNbo7h1Y
         nJyuxzsBRxHG+Jk0fGpfROvZnuSWZc0LJipVdmWbWAiQZaHBaggrtMdXznN/rmKmN/wE
         6iZCZzGsc3zbg7J0o9r0AMoNY8eb7Buf16tBw1pOfkShP3VpKMNNdjoIKy2QAKsj5sza
         hfuJglspNnVo4/KMBdWdF/dbnH3mH1v6JqOIqJTxGuaFaNAT9ZoD1YcTRY9nod5e8i4F
         7mbg==
X-Gm-Message-State: AOAM530IkB6kXmhmu+fLv16YNeUybb9nrSKnKgEfBz5Y+dtTg36jQ7Z/
        HPuJIU9YQTRMSBZ+9dWY4T1ryTinWQCI5CjXQy0=
X-Google-Smtp-Source: ABdhPJxsuKpyZo/pEru8e1BkK1qDn2QHnGc6fbaS+VUjlp11YJMWl1BTjb+53dtAi3U0oZ9etLPrNKwd1emsGXmO4cQ=
X-Received: by 2002:aca:5310:: with SMTP id h16mr2587961oib.163.1592053736360;
 Sat, 13 Jun 2020 06:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200612085027epcas1p46383a7eda792eabbd1e74cd08fe988c9@epcas1p4.samsung.com>
 <20200613025102.12880-1-jaewon31.kim@samsung.com> <20200613094228.GB3346@MiWiFi-R3L-srv>
In-Reply-To: <20200613094228.GB3346@MiWiFi-R3L-srv>
From:   Jaewon Kim <jaewon31.kim@gmail.com>
Date:   Sat, 13 Jun 2020 22:08:42 +0900
Message-ID: <CAJrd-Ut=QcK5FQP2TUm6==mowoVK_QVCB7x=LL4iUnZxBLYAmA@mail.gmail.com>
Subject: Re: [PATCH v2] page_alloc: consider highatomic reserve in wmartermark fast
To:     Baoquan He <bhe@redhat.com>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>, mgorman@techsingularity.net,
        minchan@kernel.org, mgorman@suse.de, hannes@cmpxchg.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ytk.lee@samsung.com,
        cmlaika.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 6=EC=9B=94 13=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 6:42, B=
aoquan He <bhe@redhat.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 06/13/20 at 11:51am, Jaewon Kim wrote:
> > zone_watermark_fast was introduced by commit 48ee5f3696f6 ("mm,
> > page_alloc: shortcut watermark checks for order-0 pages"). The commit
> > simply checks if free pages is bigger than watermark without additional
> > calculation such like reducing watermark.
> >
> > It considered free cma pages but it did not consider highatomic
> > reserved. This may incur exhaustion of free pages except high order
> > atomic free pages.
> >
> > Assume that reserved_highatomic pageblock is bigger than watermark min,
> > and there are only few free pages except high order atomic free. Becaus=
e
> > zone_watermark_fast passes the allocation without considering high orde=
r
> > atomic free, normal reclaimable allocation like GFP_HIGHUSER will
> > consume all the free pages. Then finally order-0 atomic allocation may
> > fail on allocation.
> >
> > This means watermark min is not protected against non-atomic allocation=
.
> > The order-0 atomic allocation with ALLOC_HARDER unwantedly can be
> > failed. Additionally the __GFP_MEMALLOC allocation with
> > ALLOC_NO_WATERMARKS also can be failed.
> >
> > To avoid the problem, zone_watermark_fast should consider highatomic
> > reserve. If the actual size of high atomic free is counted accurately
> > like cma free, we may use it. On this patch just use
> > nr_reserved_highatomic. Additionally introduce
> > __zone_watermark_unusable_free to factor out common parts between
> > zone_watermark_fast and __zone_watermark_ok.
> >
> > This is trace log which shows GFP_HIGHUSER consumes free pages right
> > before ALLOC_NO_WATERMARKS.
> >
> >   <...>-22275 [006] ....   889.213383: mm_page_alloc: page=3D00000000d2=
be5665 pfn=3D970744 order=3D0 migratetype=3D0 nr_free=3D3650 gfp_flags=3DGF=
P_HIGHUSER|__GFP_ZERO
> >   <...>-22275 [006] ....   889.213385: mm_page_alloc: page=3D000000004b=
2335c2 pfn=3D970745 order=3D0 migratetype=3D0 nr_free=3D3650 gfp_flags=3DGF=
P_HIGHUSER|__GFP_ZERO
> >   <...>-22275 [006] ....   889.213387: mm_page_alloc: page=3D0000000001=
7272e1 pfn=3D970278 order=3D0 migratetype=3D0 nr_free=3D3650 gfp_flags=3DGF=
P_HIGHUSER|__GFP_ZERO
> >   <...>-22275 [006] ....   889.213389: mm_page_alloc: page=3D00000000c4=
be79fb pfn=3D970279 order=3D0 migratetype=3D0 nr_free=3D3650 gfp_flags=3DGF=
P_HIGHUSER|__GFP_ZERO
> >   <...>-22275 [006] ....   889.213391: mm_page_alloc: page=3D00000000f8=
a51d4f pfn=3D970260 order=3D0 migratetype=3D0 nr_free=3D3650 gfp_flags=3DGF=
P_HIGHUSER|__GFP_ZERO
> >   <...>-22275 [006] ....   889.213393: mm_page_alloc: page=3D000000006b=
a8f5ac pfn=3D970261 order=3D0 migratetype=3D0 nr_free=3D3650 gfp_flags=3DGF=
P_HIGHUSER|__GFP_ZERO
> >   <...>-22275 [006] ....   889.213395: mm_page_alloc: page=3D0000000081=
9f1cd3 pfn=3D970196 order=3D0 migratetype=3D0 nr_free=3D3650 gfp_flags=3DGF=
P_HIGHUSER|__GFP_ZERO
> >   <...>-22275 [006] ....   889.213396: mm_page_alloc: page=3D00000000f6=
b72a64 pfn=3D970197 order=3D0 migratetype=3D0 nr_free=3D3650 gfp_flags=3DGF=
P_HIGHUSER|__GFP_ZERO
> > kswapd0-1207  [005] ...1   889.213398: mm_page_alloc: page=3D (null) pf=
n=3D0 order=3D0 migratetype=3D1 nr_free=3D3650 gfp_flags=3DGFP_NOWAIT|__GFP=
_HIGHMEM|__GFP_NOWARN|__GFP_MOVABLE
> >
> > This is an example of ALLOC_HARDER allocation failure.
> >
> > <4>[ 6207.637280]  [3:  Binder:9343_3:22875] Binder:9343_3: page alloca=
tion failure: order:0, mode:0x480020(GFP_ATOMIC), nodemask=3D(null)
> > <4>[ 6207.637311]  [3:  Binder:9343_3:22875] Call trace:
> > <4>[ 6207.637346]  [3:  Binder:9343_3:22875] [<ffffff8008f40f8c>] dump_=
stack+0xb8/0xf0
> > <4>[ 6207.637356]  [3:  Binder:9343_3:22875] [<ffffff8008223320>] warn_=
alloc+0xd8/0x12c
> > <4>[ 6207.637365]  [3:  Binder:9343_3:22875] [<ffffff80082245e4>] __all=
oc_pages_nodemask+0x120c/0x1250
> > <4>[ 6207.637374]  [3:  Binder:9343_3:22875] [<ffffff800827f6e8>] new_s=
lab+0x128/0x604
> > <4>[ 6207.637381]  [3:  Binder:9343_3:22875] [<ffffff800827b0cc>] ___sl=
ab_alloc+0x508/0x670
> > <4>[ 6207.637387]  [3:  Binder:9343_3:22875] [<ffffff800827ba00>] __kma=
lloc+0x2f8/0x310
> > <4>[ 6207.637396]  [3:  Binder:9343_3:22875] [<ffffff80084ac3e0>] conte=
xt_struct_to_string+0x104/0x1cc
> > <4>[ 6207.637404]  [3:  Binder:9343_3:22875] [<ffffff80084ad8fc>] secur=
ity_sid_to_context_core+0x74/0x144
> > <4>[ 6207.637412]  [3:  Binder:9343_3:22875] [<ffffff80084ad880>] secur=
ity_sid_to_context+0x10/0x18
> > <4>[ 6207.637421]  [3:  Binder:9343_3:22875] [<ffffff800849bd80>] selin=
ux_secid_to_secctx+0x20/0x28
> > <4>[ 6207.637430]  [3:  Binder:9343_3:22875] [<ffffff800849109c>] secur=
ity_secid_to_secctx+0x3c/0x70
> > <4>[ 6207.637442]  [3:  Binder:9343_3:22875] [<ffffff8008bfe118>] binde=
r_transaction+0xe68/0x454c
> > <4>[ 6207.637569]  [3:  Binder:9343_3:22875] Mem-Info:
> > <4>[ 6207.637595]  [3:  Binder:9343_3:22875] active_anon:102061 inactiv=
e_anon:81551 isolated_anon:0
> > <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  active_file:59102 inactiv=
e_file:68924 isolated_file:64
> > <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  unevictable:611 dirty:63 =
writeback:0 unstable:0
> > <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  slab_reclaimable:13324 sl=
ab_unreclaimable:44354
> > <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  mapped:83015 shmem:4858 p=
agetables:26316 bounce:0
> > <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  free:2727 free_pcp:1035 f=
ree_cma:178
> > <4>[ 6207.637616]  [3:  Binder:9343_3:22875] Node 0 active_anon:408244k=
B inactive_anon:326204kB active_file:236408kB inactive_file:275696kB unevic=
table:2444kB isolated(anon):0kB isolated(file):256kB mapped:332060kB dirty:=
252kB writeback:0kB shmem:19432kB writeback_tmp:0kB unstable:0kB all_unrecl=
aimable? no
> > <4>[ 6207.637627]  [3:  Binder:9343_3:22875] Normal free:10908kB min:61=
92kB low:44388kB high:47060kB active_anon:409160kB inactive_anon:325924kB a=
ctive_file:235820kB inactive_file:276628kB unevictable:2444kB writepending:=
252kB present:3076096kB managed:2673676kB mlocked:2444kB kernel_stack:62512=
kB pagetables:105264kB bounce:0kB free_pcp:4140kB local_pcp:40kB free_cma:7=
12kB
> > <4>[ 6207.637632]  [3:  Binder:9343_3:22875] lowmem_reserve[]: 0 0
> > <4>[ 6207.637637]  [3:  Binder:9343_3:22875] Normal: 505*4kB (H) 357*8k=
B (H) 201*16kB (H) 65*32kB (H) 1*64kB (H) 0*128kB 0*256kB 0*512kB 0*1024kB =
0*2048kB 0*4096kB =3D 10236kB
> > <4>[ 6207.637655]  [3:  Binder:9343_3:22875] 138826 total pagecache pag=
es
> > <4>[ 6207.637663]  [3:  Binder:9343_3:22875] 5460 pages in swap cache
> > <4>[ 6207.637668]  [3:  Binder:9343_3:22875] Swap cache stats: add 8273=
090, delete 8267506, find 1004381/4060142
> >
> > This is an example of ALLOC_NO_WATERMARKS allocation failure.
> >
> > <6>[  156.701551]  [4:        kswapd0: 1209] kswapd0 cpuset=3D/ mems_al=
lowed=3D0
> > <4>[  156.701563]  [4:        kswapd0: 1209] CPU: 4 PID: 1209 Comm: ksw=
apd0 Tainted: G        W       4.14.113-18113966 #1
> > <4>[  156.701572]  [4:        kswapd0: 1209] Call trace:
> > <4>[  156.701605]  [4:        kswapd0: 1209] [<0000000000000000>] dump_=
stack+0x68/0x90
> > <4>[  156.701612]  [4:        kswapd0: 1209] [<0000000000000000>] warn_=
alloc+0x104/0x198
> > <4>[  156.701617]  [4:        kswapd0: 1209] [<0000000000000000>] __all=
oc_pages_nodemask+0xdc0/0xdf0
> > <4>[  156.701623]  [4:        kswapd0: 1209] [<0000000000000000>] zs_ma=
lloc+0x148/0x3d0
> > <4>[  156.701630]  [4:        kswapd0: 1209] [<0000000000000000>] zram_=
bvec_rw+0x250/0x568
> > <4>[  156.701634]  [4:        kswapd0: 1209] [<0000000000000000>] zram_=
rw_page+0x8c/0xe0
> > <4>[  156.701640]  [4:        kswapd0: 1209] [<0000000000000000>] bdev_=
write_page+0x70/0xbc
> > <4>[  156.701645]  [4:        kswapd0: 1209] [<0000000000000000>] __swa=
p_writepage+0x58/0x37c
> > <4>[  156.701649]  [4:        kswapd0: 1209] [<0000000000000000>] swap_=
writepage+0x40/0x4c
> > <4>[  156.701654]  [4:        kswapd0: 1209] [<0000000000000000>] shrin=
k_page_list+0xc3c/0xf54
> > <4>[  156.701659]  [4:        kswapd0: 1209] [<0000000000000000>] shrin=
k_inactive_list+0x2b0/0x61c
> > <4>[  156.701664]  [4:        kswapd0: 1209] [<0000000000000000>] shrin=
k_node_memcg+0x23c/0x618
> > <4>[  156.701668]  [4:        kswapd0: 1209] [<0000000000000000>] shrin=
k_node+0x1c8/0x304
> > <4>[  156.701673]  [4:        kswapd0: 1209] [<0000000000000000>] kswap=
d+0x680/0x7c4
> > <4>[  156.701679]  [4:        kswapd0: 1209] [<0000000000000000>] kthre=
ad+0x110/0x120
> > <4>[  156.701684]  [4:        kswapd0: 1209] [<0000000000000000>] ret_f=
rom_fork+0x10/0x18
> > <4>[  156.701689]  [4:        kswapd0: 1209] Mem-Info:
> > <4>[  156.701712]  [4:        kswapd0: 1209] active_anon:88690 inactive=
_anon:88630 isolated_anon:0
> > <4>[  156.701712]  [4:        kswapd0: 1209]  active_file:99173 inactiv=
e_file:169305 isolated_file:32
> > <4>[  156.701712]  [4:        kswapd0: 1209]  unevictable:48292 dirty:5=
38 writeback:38 unstable:0
> > <4>[  156.701712]  [4:        kswapd0: 1209]  slab_reclaimable:15131 sl=
ab_unreclaimable:47762
> > <4>[  156.701712]  [4:        kswapd0: 1209]  mapped:274654 shmem:2824 =
pagetables:25088 bounce:0
> > <4>[  156.701712]  [4:        kswapd0: 1209]  free:2489 free_pcp:444 fr=
ee_cma:3
> > <4>[  156.701728]  [4:        kswapd0: 1209] Node 0 active_anon:354760k=
B inactive_anon:354520kB active_file:396692kB inactive_file:677220kB unevic=
table:193168kB isolated(anon):0kB isolated(file):128kB mapped:1098616kB dir=
ty:2152kB writeback:152kB shmem:11296kB writeback_tmp:0kB unstable:0kB all_=
unreclaimable? no
> > <4>[  156.701738]  [4:        kswapd0: 1209] Normal free:9956kB min:742=
8kB low:93440kB high:97032kB active_anon:355176kB inactive_anon:354580kB ac=
tive_file:396196kB inactive_file:677284kB unevictable:193168kB writepending=
:2304kB present:4081664kB managed:3593324kB mlocked:193168kB kernel_stack:5=
5008kB pagetables:100352kB bounce:0kB free_pcp:1776kB local_pcp:656kB free_=
cma:12kB
> > <4>[  156.701741]  [4:        kswapd0: 1209] lowmem_reserve[]: 0 0
> > <4>[  156.701747]  [4:        kswapd0: 1209] Normal: 196*4kB (H) 141*8k=
B (H) 109*16kB (H) 63*32kB (H) 20*64kB (H) 8*128kB (H) 2*256kB (H) 1*512kB =
(H) 0*1024kB 0*2048kB 0*4096kB =3D 9000kB
> >
> > Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
> > Suggested-by: Minchan Kim <minchan@kernel.org>
> > Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> > ---
> > v2: factor out common part
> > v1: consider highatomic reserve
> > ---
> >  mm/page_alloc.c | 61 ++++++++++++++++++++++++++++---------------------
> >  1 file changed, 35 insertions(+), 26 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 48eb0f1410d4..c2177e056f19 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3487,6 +3487,29 @@ static noinline bool should_fail_alloc_page(gfp_=
t gfp_mask, unsigned int order)
> >  }
> >  ALLOW_ERROR_INJECTION(should_fail_alloc_page, TRUE);
> >
> > +static inline long __zone_watermark_unusable_free(struct zone *z,
> > +                             unsigned int order, unsigned int alloc_fl=
ags)
> > +{
> > +     const bool alloc_harder =3D (alloc_flags & (ALLOC_HARDER|ALLOC_OO=
M));
> > +     long unusable_free =3D (1 << order) - 1;
> > +
> > +     /*
> > +      * If the caller does not have rights to ALLOC_HARDER then subtra=
ct
> > +      * the high-atomic reserves. This will over-estimate the size of =
the
> > +      * atomic reserve but it avoids a search.
> > +      */
> > +     if (likely(!alloc_harder))
> > +             unusable_free +=3D z->nr_reserved_highatomic;
> > +
> > +#ifdef CONFIG_CMA
> > +     /* If allocation can't use CMA areas don't use free CMA pages */
> > +     if (!(alloc_flags & ALLOC_CMA))
> > +             unusable_free +=3D zone_page_state(z, NR_FREE_CMA_PAGES);
> > +#endif
> > +
> > +     return unusable_free;
> > +}
> > +
> >  /*
> >   * Return true if free base pages are above 'mark'. For high-order che=
cks it
> >   * will return true of the order-0 watermark is reached and there is a=
t least
> > @@ -3502,19 +3525,12 @@ bool __zone_watermark_ok(struct zone *z, unsign=
ed int order, unsigned long mark,
> >       const bool alloc_harder =3D (alloc_flags & (ALLOC_HARDER|ALLOC_OO=
M));
> >
> >       /* free_pages may go negative - that's OK */
> > -     free_pages -=3D (1 << order) - 1;
> > +     free_pages -=3D __zone_watermark_unusable_free(z, order, alloc_fl=
ags);
> >
> >       if (alloc_flags & ALLOC_HIGH)
> >               min -=3D min / 2;
> >
> > -     /*
> > -      * If the caller does not have rights to ALLOC_HARDER then subtra=
ct
> > -      * the high-atomic reserves. This will over-estimate the size of =
the
> > -      * atomic reserve but it avoids a search.
> > -      */
> > -     if (likely(!alloc_harder)) {
> > -             free_pages -=3D z->nr_reserved_highatomic;
> > -     } else {
> > +     if (unlikely(alloc_harder)) {
> >               /*
> >                * OOM victims can try even harder than normal ALLOC_HARD=
ER
> >                * users on the grounds that it's definitely going to be =
in
> > @@ -3527,13 +3543,6 @@ bool __zone_watermark_ok(struct zone *z, unsigne=
d int order, unsigned long mark,
> >                       min -=3D min / 4;
> >       }
> >
> > -
> > -#ifdef CONFIG_CMA
> > -     /* If allocation can't use CMA areas don't use free CMA pages */
> > -     if (!(alloc_flags & ALLOC_CMA))
> > -             free_pages -=3D zone_page_state(z, NR_FREE_CMA_PAGES);
> > -#endif
> > -
> >       /*
> >        * Check watermarks for an order-0 allocation request. If these
> >        * are not met, then a high-order request also cannot go ahead
> > @@ -3582,14 +3591,11 @@ static inline bool zone_watermark_fast(struct z=
one *z, unsigned int order,
> >                               unsigned long mark, int highest_zoneidx,
> >                               unsigned int alloc_flags)
> >  {
> > -     long free_pages =3D zone_page_state(z, NR_FREE_PAGES);
> > -     long cma_pages =3D 0;
> > +     long free_pages;
> > +     long unusable_free;
> >
> > -#ifdef CONFIG_CMA
> > -     /* If allocation can't use CMA areas don't use free CMA pages */
> > -     if (!(alloc_flags & ALLOC_CMA))
> > -             cma_pages =3D zone_page_state(z, NR_FREE_CMA_PAGES);
> > -#endif
> > +     free_pages =3D zone_page_state(z, NR_FREE_PAGES);
> > +     unusable_free =3D  __zone_watermark_unusable_free(z, order, alloc=
_flags);
> >
> >       /*
> >        * Fast check for order-0 only. If this fails then the reserves
> > @@ -3598,9 +3604,12 @@ static inline bool zone_watermark_fast(struct zo=
ne *z, unsigned int order,
> >        * the caller is !atomic then it'll uselessly search the free
> >        * list. That corner case is then slower but it is harmless.
>
> Do we need remove or adjust the code comment at this place? So Mel have
> foreseen the corner case, just reclaiming to unreserve the highatomic
> might be ignored.
>

Hello thank you for your comment.

My previous mail to Vlastimil Babka seems to have html.
Let me put  again here because I also think the comment should be changed.
I'd like to hear opinions from the open source community.

Additionally actually I think we need accurate counting of highatomic
free after this patch.

---------------------------------------------------------------------------=
-------------

As Mel also agreed with me in v1 mail thread, this highatomic reserved shou=
ld
be considered even in watermark fast.

The comment, I think, may need to be changed. Prior to this patch, non
highatomic
allocation may do useless search, but it also can take ALL non highatomic f=
ree.

With this patch, non highatomic allocation will NOT do useless search. Rath=
er,
it may be required direct reclamation even when there are some non
high atomic free.

i.e)
In following situation, watermark check fails (9MB - 8MB < 4MB) though ther=
e are
enough free (9MB - 4MB > 4MB). If this is really matter, we need to
count highatomic
free accurately.

min : 4MB,
highatomic reserved : 8MB
Total free : 9MB
  actual highatomic free : 4MB
  non highatomic free : 5MB

> >        */
> > -     if (!order && (free_pages - cma_pages) >
> > -                             mark + z->lowmem_reserve[highest_zoneidx]=
)
> > -             return true;
> > +     if (!order) {
> > +             long fast_free =3D free_pages - unusable_free;
> > +
> > +             if (fast_free > mark + z->lowmem_reserve[highest_zoneidx]=
)
> > +                     return true;
> > +     }
> >
> >       return __zone_watermark_ok(z, order, mark, highest_zoneidx, alloc=
_flags,
> >                                       free_pages);
> > --
> > 2.17.1
> >
> >
>
