Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0448C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 23:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9164820792
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 23:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewWw2NEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgFMXRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 19:17:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24742 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726258AbgFMXRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 19:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592090264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ApR2mFs8WmdfbD3QAWWQrCCU456172MJbwZdqjigw+Y=;
        b=ewWw2NEwlGxlXp9dY9FukpXpJ1VELmIcIHzex0i1u6IF3VV3sERIOrym94kfQ9yJcQYRKL
        32zcXvJGkU7EMCBILIbxIX8rAFtM6Bd3rz4gIgiHUFpT/BXVMYl6NsHbZyVI1hZPemP8IR
        5+AYO0yDw/dpPUx+ln8YoqyjQiSaTVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-GrSBK3moOrSlFNIqC3nakQ-1; Sat, 13 Jun 2020 19:17:42 -0400
X-MC-Unique: GrSBK3moOrSlFNIqC3nakQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BE5B1883600;
        Sat, 13 Jun 2020 23:17:40 +0000 (UTC)
Received: from localhost (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CEDF360BF1;
        Sat, 13 Jun 2020 23:17:38 +0000 (UTC)
Date:   Sun, 14 Jun 2020 07:17:36 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jaewon Kim <jaewon31.kim@gmail.com>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>, mgorman@techsingularity.net,
        minchan@kernel.org, mgorman@suse.de, hannes@cmpxchg.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ytk.lee@samsung.com,
        cmlaika.kim@samsung.com
Subject: Re: [PATCH v2] page_alloc: consider highatomic reserve in
 wmartermark fast
Message-ID: <20200613231736.GJ20367@MiWiFi-R3L-srv>
References: <CGME20200612085027epcas1p46383a7eda792eabbd1e74cd08fe988c9@epcas1p4.samsung.com>
 <20200613025102.12880-1-jaewon31.kim@samsung.com>
 <20200613094228.GB3346@MiWiFi-R3L-srv>
 <CAJrd-Ut=QcK5FQP2TUm6==mowoVK_QVCB7x=LL4iUnZxBLYAmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJrd-Ut=QcK5FQP2TUm6==mowoVK_QVCB7x=LL4iUnZxBLYAmA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/20 at 10:08pm, Jaewon Kim wrote:
...
> > > This is an example of ALLOC_HARDER allocation failure.
> > >
> > > <4>[ 6207.637280]  [3:  Binder:9343_3:22875] Binder:9343_3: page allocation failure: order:0, mode:0x480020(GFP_ATOMIC), nodemask=(null)
> > > <4>[ 6207.637311]  [3:  Binder:9343_3:22875] Call trace:
> > > <4>[ 6207.637346]  [3:  Binder:9343_3:22875] [<ffffff8008f40f8c>] dump_stack+0xb8/0xf0
> > > <4>[ 6207.637356]  [3:  Binder:9343_3:22875] [<ffffff8008223320>] warn_alloc+0xd8/0x12c
> > > <4>[ 6207.637365]  [3:  Binder:9343_3:22875] [<ffffff80082245e4>] __alloc_pages_nodemask+0x120c/0x1250
> > > <4>[ 6207.637374]  [3:  Binder:9343_3:22875] [<ffffff800827f6e8>] new_slab+0x128/0x604
> > > <4>[ 6207.637381]  [3:  Binder:9343_3:22875] [<ffffff800827b0cc>] ___slab_alloc+0x508/0x670
> > > <4>[ 6207.637387]  [3:  Binder:9343_3:22875] [<ffffff800827ba00>] __kmalloc+0x2f8/0x310
> > > <4>[ 6207.637396]  [3:  Binder:9343_3:22875] [<ffffff80084ac3e0>] context_struct_to_string+0x104/0x1cc
> > > <4>[ 6207.637404]  [3:  Binder:9343_3:22875] [<ffffff80084ad8fc>] security_sid_to_context_core+0x74/0x144
> > > <4>[ 6207.637412]  [3:  Binder:9343_3:22875] [<ffffff80084ad880>] security_sid_to_context+0x10/0x18
> > > <4>[ 6207.637421]  [3:  Binder:9343_3:22875] [<ffffff800849bd80>] selinux_secid_to_secctx+0x20/0x28
> > > <4>[ 6207.637430]  [3:  Binder:9343_3:22875] [<ffffff800849109c>] security_secid_to_secctx+0x3c/0x70
> > > <4>[ 6207.637442]  [3:  Binder:9343_3:22875] [<ffffff8008bfe118>] binder_transaction+0xe68/0x454c
> > > <4>[ 6207.637569]  [3:  Binder:9343_3:22875] Mem-Info:
> > > <4>[ 6207.637595]  [3:  Binder:9343_3:22875] active_anon:102061 inactive_anon:81551 isolated_anon:0
> > > <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  active_file:59102 inactive_file:68924 isolated_file:64
> > > <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  unevictable:611 dirty:63 writeback:0 unstable:0
> > > <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  slab_reclaimable:13324 slab_unreclaimable:44354
> > > <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  mapped:83015 shmem:4858 pagetables:26316 bounce:0
> > > <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  free:2727 free_pcp:1035 free_cma:178
> > > <4>[ 6207.637616]  [3:  Binder:9343_3:22875] Node 0 active_anon:408244kB inactive_anon:326204kB active_file:236408kB inactive_file:275696kB unevictable:2444kB isolated(anon):0kB isolated(file):256kB mapped:332060kB dirty:252kB writeback:0kB shmem:19432kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
> > > <4>[ 6207.637627]  [3:  Binder:9343_3:22875] Normal free:10908kB min:6192kB low:44388kB high:47060kB active_anon:409160kB inactive_anon:325924kB active_file:235820kB inactive_file:276628kB unevictable:2444kB writepending:252kB present:3076096kB managed:2673676kB mlocked:2444kB kernel_stack:62512kB pagetables:105264kB bounce:0kB free_pcp:4140kB local_pcp:40kB free_cma:712kB

Checked this mem info, wondering why there's no 'reserved_highatomic'
printing in all these examples.

> > > <4>[ 6207.637632]  [3:  Binder:9343_3:22875] lowmem_reserve[]: 0 0
> > > <4>[ 6207.637637]  [3:  Binder:9343_3:22875] Normal: 505*4kB (H) 357*8kB (H) 201*16kB (H) 65*32kB (H) 1*64kB (H) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 10236kB
> > > <4>[ 6207.637655]  [3:  Binder:9343_3:22875] 138826 total pagecache pages
> > > <4>[ 6207.637663]  [3:  Binder:9343_3:22875] 5460 pages in swap cache
> > > <4>[ 6207.637668]  [3:  Binder:9343_3:22875] Swap cache stats: add 8273090, delete 8267506, find 1004381/4060142
> > >
...
> > >  mm/page_alloc.c | 61 ++++++++++++++++++++++++++++---------------------
> > >  1 file changed, 35 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 48eb0f1410d4..c2177e056f19 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -3487,6 +3487,29 @@ static noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
> > >  }
> > >  ALLOW_ERROR_INJECTION(should_fail_alloc_page, TRUE);
> > >
> > > +static inline long __zone_watermark_unusable_free(struct zone *z,
> > > +                             unsigned int order, unsigned int alloc_flags)
> > > +{
> > > +     const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
> > > +     long unusable_free = (1 << order) - 1;
> > > +
> > > +     /*
> > > +      * If the caller does not have rights to ALLOC_HARDER then subtract
> > > +      * the high-atomic reserves. This will over-estimate the size of the
> > > +      * atomic reserve but it avoids a search.
> > > +      */
> > > +     if (likely(!alloc_harder))
> > > +             unusable_free += z->nr_reserved_highatomic;
> > > +
> > > +#ifdef CONFIG_CMA
> > > +     /* If allocation can't use CMA areas don't use free CMA pages */
> > > +     if (!(alloc_flags & ALLOC_CMA))
> > > +             unusable_free += zone_page_state(z, NR_FREE_CMA_PAGES);
> > > +#endif
> > > +
> > > +     return unusable_free;
> > > +}
> > > +
> > >  /*
> > >   * Return true if free base pages are above 'mark'. For high-order checks it
> > >   * will return true of the order-0 watermark is reached and there is at least
> > > @@ -3502,19 +3525,12 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
> > >       const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
> > >
> > >       /* free_pages may go negative - that's OK */
> > > -     free_pages -= (1 << order) - 1;
> > > +     free_pages -= __zone_watermark_unusable_free(z, order, alloc_flags);
> > >
> > >       if (alloc_flags & ALLOC_HIGH)
> > >               min -= min / 2;
> > >
> > > -     /*
> > > -      * If the caller does not have rights to ALLOC_HARDER then subtract
> > > -      * the high-atomic reserves. This will over-estimate the size of the
> > > -      * atomic reserve but it avoids a search.
> > > -      */
> > > -     if (likely(!alloc_harder)) {
> > > -             free_pages -= z->nr_reserved_highatomic;
> > > -     } else {
> > > +     if (unlikely(alloc_harder)) {
> > >               /*
> > >                * OOM victims can try even harder than normal ALLOC_HARDER
> > >                * users on the grounds that it's definitely going to be in
> > > @@ -3527,13 +3543,6 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
> > >                       min -= min / 4;
> > >       }
> > >
> > > -
> > > -#ifdef CONFIG_CMA
> > > -     /* If allocation can't use CMA areas don't use free CMA pages */
> > > -     if (!(alloc_flags & ALLOC_CMA))
> > > -             free_pages -= zone_page_state(z, NR_FREE_CMA_PAGES);
> > > -#endif
> > > -
> > >       /*
> > >        * Check watermarks for an order-0 allocation request. If these
> > >        * are not met, then a high-order request also cannot go ahead
> > > @@ -3582,14 +3591,11 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
> > >                               unsigned long mark, int highest_zoneidx,
> > >                               unsigned int alloc_flags)
> > >  {
> > > -     long free_pages = zone_page_state(z, NR_FREE_PAGES);
> > > -     long cma_pages = 0;
> > > +     long free_pages;
> > > +     long unusable_free;
> > >
> > > -#ifdef CONFIG_CMA
> > > -     /* If allocation can't use CMA areas don't use free CMA pages */
> > > -     if (!(alloc_flags & ALLOC_CMA))
> > > -             cma_pages = zone_page_state(z, NR_FREE_CMA_PAGES);
> > > -#endif
> > > +     free_pages = zone_page_state(z, NR_FREE_PAGES);
> > > +     unusable_free =  __zone_watermark_unusable_free(z, order, alloc_flags);
> > >
> > >       /*
> > >        * Fast check for order-0 only. If this fails then the reserves
> > > @@ -3598,9 +3604,12 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
> > >        * the caller is !atomic then it'll uselessly search the free
> > >        * list. That corner case is then slower but it is harmless.
> >
> > Do we need remove or adjust the code comment at this place? So Mel have
> > foreseen the corner case, just reclaiming to unreserve the highatomic
> > might be ignored.
> >
> 
> Hello thank you for your comment.
> 
> My previous mail to Vlastimil Babka seems to have html.
> Let me put  again here because I also think the comment should be changed.
> I'd like to hear opinions from the open source community.

Yeah, your replying mail to Vlastimil looks a little messy on format, I
didn't scroll down to check.

> 
> Additionally actually I think we need accurate counting of highatomic
> free after this patch.
> 
> ----------------------------------------------------------------------------------------
> 
> As Mel also agreed with me in v1 mail thread, this highatomic reserved should
> be considered even in watermark fast.
> 
> The comment, I think, may need to be changed. Prior to this patch, non
> highatomic
> allocation may do useless search, but it also can take ALL non highatomic free.
> 
> With this patch, non highatomic allocation will NOT do useless search. Rather,
> it may be required direct reclamation even when there are some non
> high atomic free.
> 
> i.e)
> In following situation, watermark check fails (9MB - 8MB < 4MB) though there are
> enough free (9MB - 4MB > 4MB). If this is really matter, we need to
> count highatomic
> free accurately.

Seems to make sense. We only use zone->nr_reserved_highatomic to account
the reserved highatomic, don't track how much have been used for
highatomic allocation. But not sure if this will happen often, or just a
very rare case, whether taking that into account will impact anything.

> 
> min : 4MB,
> highatomic reserved : 8MB
> Total free : 9MB
>   actual highatomic free : 4MB
>   non highatomic free : 5MB
> 
> > >        */
> > > -     if (!order && (free_pages - cma_pages) >
> > > -                             mark + z->lowmem_reserve[highest_zoneidx])
> > > -             return true;
> > > +     if (!order) {
> > > +             long fast_free = free_pages - unusable_free;
> > > +
> > > +             if (fast_free > mark + z->lowmem_reserve[highest_zoneidx])
> > > +                     return true;
> > > +     }
> > >
> > >       return __zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
> > >                                       free_pages);
> > > --
> > > 2.17.1
> > >
> > >
> >
> 

