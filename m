Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6477EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36155206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn2tXoP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbgFPOKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgFPOKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:10:30 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F83C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:10:30 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m2so15999145otr.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=trGOg5UBBYYL7rUCjbNWbKu0eAZYMEFOByjiF7r4U4Y=;
        b=Mn2tXoP683XxX2HPt17iFXCiTrCWPtwbVZtJU0oc1tVKr0oNEb35PYSH1vaChXt7tk
         CCeK/Ddt11v6jywgu0p3vRN+SOYMQ5JWXWac6IbJpJ8dFbAHk/1jRNyxTXn8WEscoznv
         DLuWhxlqpMBfAf5ghfeTdg1O8sojjVuroocwy3YQFcVBl2x3B1mujemX5ajh2/Hd1xX3
         oVxWTa5o6D10VhKN7H1io9/HnRYc4SA4xXB0o6bLyCblgCfTcl9XQieua3Bc0vtXI6pO
         FleNaVGCGYT/KArsIc/vFTV5TIwOMBQlyZDqMnhTRbph1BJX2Ve/SS+xTmShX44P+zwV
         xhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=trGOg5UBBYYL7rUCjbNWbKu0eAZYMEFOByjiF7r4U4Y=;
        b=QUu16Kn6nOJl9kZ+5dyP5eLlkMK9IG+3cvCtP9OZp5tmaCsKqRiRxn204s78ZpVXkt
         u4xglXvEFG15fNhZ+2vcHxavEu6Kn3BQG2pf4VGPDGFRRfqIF933JWMjMhMYchbwc8CR
         RpGZbhmy48sUe3uDxTopZkx9aYEqC+Jb0f/pETi2XxubJkba/YDFPZvhhU1zydm+9yhx
         JUDcmLiausRWNNp4hR6pWKIUgtJ1oLnuL4MUJqxI7CmZv9BjTnrJR+7trAt5FmtKuKY3
         qZUxlpdENSosbxzEtt+I4f4x6DEUD2gxh6BlB4xJOQ/qeUVFqKawlha0v1iR+5gIu4Tf
         uj3g==
X-Gm-Message-State: AOAM533pRaOwC3sTL+gVhiFhM8YRMvkHl/ny4f7QXE+YsU6fLc9q9yb2
        FcXMi7l74KKh9uq0J2mHtJopie5t9u7nQofmKyWjlOq6DIU=
X-Google-Smtp-Source: ABdhPJxTI+38rRBKV16KM9ntW+34w6soJ7TmOAPg4p9wO1+NSKATdME0T5nQpvAD0XRNJjRKwofSyzqIfDpVOIN6cTU=
X-Received: by 2002:a9d:4b90:: with SMTP id k16mr2461901otf.69.1592316629231;
 Tue, 16 Jun 2020 07:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200616080413epcas1p4c8ff98e9a79c59fd9a43db6a9d507417@epcas1p4.samsung.com>
 <20200617020550.23159-1-jaewon31.kim@samsung.com> <8f809f31-47bb-9f48-1b7d-e0a3ae14e6b9@suse.cz>
In-Reply-To: <8f809f31-47bb-9f48-1b7d-e0a3ae14e6b9@suse.cz>
From:   Jaewon Kim <jaewon31.kim@gmail.com>
Date:   Tue, 16 Jun 2020 23:10:15 +0900
Message-ID: <CAJrd-UsQRyu91Z5J-03FGQYFXu222qr-no_8+tv1GZP0vivgaA@mail.gmail.com>
Subject: Re: [PATCH v3] page_alloc: consider highatomic reserve in wmartermark fast
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>, Baoquan He <bhe@redhat.com>,
        mgorman@techsingularity.net, minchan@kernel.org, mgorman@suse.de,
        hannes@cmpxchg.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ytk.lee@samsung.com, cmlaika.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 6=EC=9B=94 16=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 7:21, V=
lastimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 6/17/20 4:05 AM, Jaewon Kim wrote:
>
> Please fix typo "wmartermark" in subject.
Oops
Let me fix typo in next version as watermark
>
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
> > This is an example of ALLOC_HARDER allocation failure using v4.19 based
> > kernel.
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
>
> These are better to read after removing the timestamp and process info pa=
rt,
> i.e. "<4>[ 6207.637668]  [3:  Binder:9343_3:22875]" (also in the other ex=
amples
> below).
>
Good comment
Let me remove those timestamp and process info.
> > This is an example of ALLOC_NO_WATERMARKS allocation failure using v4.1=
4
> > based kernel.
> >
> > [ 4738.329298] kswapd0: page allocation failure: order:0, mode:0x140000=
a(GFP_NOIO|__GFP_HIGHMEM|__GFP_MOVABLE), nodemask=3D(null)
> > [ 4738.329325] kswapd0 cpuset=3D/ mems_allowed=3D0
> > [ 4738.329339] CPU: 4 PID: 1221 Comm: kswapd0 Not tainted 4.14.113-1877=
0262-userdebug #1
> > [ 4738.329350] Call trace:
> > [ 4738.329366] [<0000000000000000>] dump_backtrace+0x0/0x248
> > [ 4738.329377] [<0000000000000000>] show_stack+0x18/0x20
> > [ 4738.329390] [<0000000000000000>] __dump_stack+0x20/0x28
> > [ 4738.329398] [<0000000000000000>] dump_stack+0x68/0x90
> > [ 4738.329409] [<0000000000000000>] warn_alloc+0x104/0x198
> > [ 4738.329417] [<0000000000000000>] __alloc_pages_nodemask+0xdc0/0xdf0
> > [ 4738.329427] [<0000000000000000>] zs_malloc+0x148/0x3d0
> > [ 4738.329438] [<0000000000000000>] zram_bvec_rw+0x410/0x798
> > [ 4738.329446] [<0000000000000000>] zram_rw_page+0x88/0xdc
> > [ 4738.329455] [<0000000000000000>] bdev_write_page+0x70/0xbc
> > [ 4738.329463] [<0000000000000000>] __swap_writepage+0x58/0x37c
> > [ 4738.329469] [<0000000000000000>] swap_writepage+0x40/0x4c
> > [ 4738.329478] [<0000000000000000>] shrink_page_list+0xc30/0xf48
> > [ 4738.329486] [<0000000000000000>] shrink_inactive_list+0x2b0/0x61c
> > [ 4738.329494] [<0000000000000000>] shrink_node_memcg+0x23c/0x618
> > [ 4738.329501] [<0000000000000000>] shrink_node+0x1c8/0x304
> > [ 4738.329509] [<0000000000000000>] kswapd+0x680/0x7c4
> > [ 4738.329518] [<0000000000000000>] kthread+0x110/0x120
> > [ 4738.329527] [<0000000000000000>] ret_from_fork+0x10/0x18
> > [ 4738.329538] Mem-Info:
> > [ 4738.329574] active_anon:111826 inactive_anon:65557 isolated_anon:0\x=
0a active_file:44260 inactive_file:83422 isolated_file:0\x0a unevictable:41=
58 dirty:117 writeback:0 unstable:0\x0a            slab_reclaimable:13943 s=
lab_unreclaimable:43315\x0a mapped:102511 shmem:3299 pagetables:19566 bounc=
e:0\x0a free:3510 free_pcp:553 free_cma:0
> > [ 4738.329593] Node 0 active_anon:447304kB inactive_anon:262228kB activ=
e_file:177040kB inactive_file:333688kB unevictable:16632kB isolated(anon):0=
kB isolated(file):0kB mapped:410044kB d irty:468kB writeback:0kB shmem:1319=
6kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
> > [ 4738.329603] Normal free:14040kB min:7440kB low:94500kB high:98136kB =
reserved_highatomic:32768KB active_anon:447336kB inactive_anon:261668kB act=
ive_file:177572kB inactive_file:333768k           B unevictable:16632kB wri=
tepending:480kB present:4081664kB managed:3637088kB mlocked:16632kB kernel_=
stack:47072kB pagetables:78264kB bounce:0kB free_pcp:2280kB local_pcp:720kB=
 free_cma:0kB        [ 4738.329607] lowmem_reserve[]: 0 0
> > [ 4738.329615] Normal: 860*4kB (H) 453*8kB (H) 180*16kB (H) 26*32kB (H)=
 34*64kB (H) 6*128kB (H) 2*256kB (H) 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D=
 14232kB
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
> > Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
> > Suggested-by: Minchan Kim <minchan@kernel.org>
> > Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thank you for the Acked-by, let me add your Acked-by in next version.
>
> > ---
> > v3: change log in description to one having reserved_highatomic
> >     change comment in code
> > v2: factor out common part
> > v1: consider highatomic reserve
> > ---
> >  mm/page_alloc.c | 66 +++++++++++++++++++++++++++----------------------
> >  1 file changed, 36 insertions(+), 30 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 48eb0f1410d4..fe83f88ce188 100644
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
> > @@ -3582,25 +3591,22 @@ static inline bool zone_watermark_fast(struct z=
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
> > +     unusable_free =3D __zone_watermark_unusable_free(z, order, alloc_=
flags);
> >
> >       /*
> >        * Fast check for order-0 only. If this fails then the reserves
> > -      * need to be calculated. There is a corner case where the check
> > -      * passes but only the high-order atomic reserve are free. If
> > -      * the caller is !atomic then it'll uselessly search the free
> > -      * list. That corner case is then slower but it is harmless.
> > +      * need to be calculated.
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
> >
>
