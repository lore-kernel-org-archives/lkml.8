Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB9CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 320D5207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y07ojxM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgFPORd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:17:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43563 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728716AbgFPORb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592317048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5U79kuIEnYZOM70CXAnAxUaWje17186nlnT5EaRCkcY=;
        b=Y07ojxM1Pp99UAOL5Q1+FmHWA9KbChD5dOemJouSw9OaX7+QTRxk02AiYT5FQfVUKZ613e
        KLKHcAugUo7PdUm3dVIID8LFdpyLik6DKiWn0YAlMTrsMqYxAFlQ0BsBChhb1gCuMNcdqk
        8hnrPORQQBEB7uYbP0YNAKTC1kNpqeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-pGmEWh4tNOuNJJ3pS5vacA-1; Tue, 16 Jun 2020 10:17:24 -0400
X-MC-Unique: pGmEWh4tNOuNJJ3pS5vacA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EA8A8730EE;
        Tue, 16 Jun 2020 14:17:22 +0000 (UTC)
Received: from localhost (ovpn-12-37.pek2.redhat.com [10.72.12.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 152D719C71;
        Tue, 16 Jun 2020 14:17:20 +0000 (UTC)
Date:   Tue, 16 Jun 2020 22:17:17 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        =?utf-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
Cc:     Jaewon Kim <jaewon31.kim@gmail.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?7J207Jqp7YOd?= <ytk.lee@samsung.com>,
        =?utf-8?B?6rmA7LKg66+8?= <cmlaika.kim@samsung.com>
Subject: Re: (2) [PATCH v2] page_alloc: consider highatomic reserve in
 wmartermark fast
Message-ID: <20200616141717.GN20367@MiWiFi-R3L-srv>
References: <26a6a2c2-56e6-1a34-84ac-8ff9f74c34ce@suse.cz>
 <20200613025102.12880-1-jaewon31.kim@samsung.com>
 <20200613094228.GB3346@MiWiFi-R3L-srv>
 <CAJrd-Ut=QcK5FQP2TUm6==mowoVK_QVCB7x=LL4iUnZxBLYAmA@mail.gmail.com>
 <20200613231736.GJ20367@MiWiFi-R3L-srv>
 <CGME20200612085027epcas1p46383a7eda792eabbd1e74cd08fe988c9@epcms1p1>
 <20200616073002epcms1p12a14cc85b0aebf8ba88bedee7495b34f@epcms1p1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616073002epcms1p12a14cc85b0aebf8ba88bedee7495b34f@epcms1p1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/16/20 at 04:30pm, 김재원 wrote:
> >>> > > <4>[ 6207.637627]  [3:  Binder:9343_3:22875] Normal free:10908kB min:6192kB low:44388kB high:47060kB active_anon:409160kB inactive_anon:325924kB active_file:235820kB inactive_file:276628kB unevictable:2444kB writepending:252kB present:3076096kB managed:2673676kB mlocked:2444kB kernel_stack:62512kB pagetables:105264kB bounce:0kB free_pcp:4140kB local_pcp:40kB free_cma:712kB
> >> 
> >> Checked this mem info, wondering why there's no 'reserved_highatomic'
> >> printing in all these examples.
> > 
> >Yeah, it better be printed, especially after it's included in watermark
> >calculation, so we're less confused by reports of allocation failure where
> >watermarks are seemingly ok.
> > 
> 
> 
> Hello Vlastimil and Baoquan
> 
> The log in previous mail was captured from kernel based on v4.14.
> After adding the reserved_highatomic log, I finally got a new log below
> Let me change description in next patch.
> 
> There seems be reserved_highatomic:32768KB and actually 14232kB free.
> 
> [ 4738.329298] kswapd0: page allocation failure: order:0, mode:0x140000a(GFP_NOIO|__GFP_HIGHMEM|__GFP_MOVABLE), nodemask=(null)
> [ 4738.329325] kswapd0 cpuset=/ mems_allowed=0
> [ 4738.329339] CPU: 4 PID: 1221 Comm: kswapd0 Not tainted 4.14.113-18770262-userdebug #1
> [ 4738.329350] Call trace: 
> [ 4738.329366] [<0000000000000000>] dump_backtrace+0x0/0x248
> [ 4738.329377] [<0000000000000000>] show_stack+0x18/0x20
> [ 4738.329390] [<0000000000000000>] __dump_stack+0x20/0x28
> [ 4738.329398] [<0000000000000000>] dump_stack+0x68/0x90
> [ 4738.329409] [<0000000000000000>] warn_alloc+0x104/0x198
> [ 4738.329417] [<0000000000000000>] __alloc_pages_nodemask+0xdc0/0xdf0
> [ 4738.329427] [<0000000000000000>] zs_malloc+0x148/0x3d0
> [ 4738.329438] [<0000000000000000>] zram_bvec_rw+0x410/0x798
> [ 4738.329446] [<0000000000000000>] zram_rw_page+0x88/0xdc
> [ 4738.329455] [<0000000000000000>] bdev_write_page+0x70/0xbc
> [ 4738.329463] [<0000000000000000>] __swap_writepage+0x58/0x37c
> [ 4738.329469] [<0000000000000000>] swap_writepage+0x40/0x4c
> [ 4738.329478] [<0000000000000000>] shrink_page_list+0xc30/0xf48
> [ 4738.329486] [<0000000000000000>] shrink_inactive_list+0x2b0/0x61c
> [ 4738.329494] [<0000000000000000>] shrink_node_memcg+0x23c/0x618
> [ 4738.329501] [<0000000000000000>] shrink_node+0x1c8/0x304
> [ 4738.329509] [<0000000000000000>] kswapd+0x680/0x7c4
> [ 4738.329518] [<0000000000000000>] kthread+0x110/0x120
> [ 4738.329527] [<0000000000000000>] ret_from_fork+0x10/0x18
> [ 4738.329538] Mem-Info:
> [ 4738.329574] active_anon:111826 inactive_anon:65557 isolated_anon:0\x0a active_file:44260 inactive_file:83422 isolated_file:0\x0a unevictable:4158 dirty:117 writeback:0 unstable:0\x0a            slab_reclaimable:13943 slab_unreclaimable:43315\x0a mapped:102511 shmem:3299 pagetables:19566 bounce:0\x0a free:3510 free_pcp:553 free_cma:0
> [ 4738.329593] Node 0 active_anon:447304kB inactive_anon:262228kB active_file:177040kB inactive_file:333688kB unevictable:16632kB isolated(anon):0kB isolated(file):0kB mapped:410044kB d           irty:468kB writeback:0kB shmem:13196kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
> [ 4738.329603] Normal free:14040kB min:7440kB low:94500kB high:98136kB reserved_highatomic:32768KB active_anon:447336kB inactive_anon:261668kB active_file:177572kB inactive_file:333768k           B unevictable:16632kB writepending:480kB present:4081664kB managed:3637088kB mlocked:16632kB kernel_stack:47072kB pagetables:78264kB bounce:0kB free_pcp:2280kB local_pcp:720kB free_cma:0kB        [ 4738.329607] lowmem_reserve[]: 0 0
> [ 4738.329615] Normal: 860*4kB (H) 453*8kB (H) 180*16kB (H) 26*32kB (H) 34*64kB (H) 6*128kB (H) 2*256kB (H) 0*512kB 0*1024kB 0*2048kB 0*4096kB = 14232kB
> 
> 
> >...
> > 
> >>> > >       /*
> >>> > >        * Fast check for order-0 only. If this fails then the reserves
> >>> > > @@ -3598,9 +3604,12 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
> >>> > >        * the caller is !atomic then it'll uselessly search the free
> >>> > >        * list. That corner case is then slower but it is harmless.
> >>> >
> >>> > Do we need remove or adjust the code comment at this place? So Mel have
> >>> > foreseen the corner case, just reclaiming to unreserve the highatomic
> >>> > might be ignored.
> >>> >
> >>> 
> >>> Hello thank you for your comment.
> >>> 
> >>> My previous mail to Vlastimil Babka seems to have html.
> >>> Let me put  again here because I also think the comment should be changed.
> >>> I'd like to hear opinions from the open source community.
> >> 
> >> Yeah, your replying mail to Vlastimil looks a little messy on format, I
> >> didn't scroll down to check.
> >> 
> >>> 
> >>> Additionally actually I think we need accurate counting of highatomic
> >>> free after this patch.
> >>> 
> >>> ----------------------------------------------------------------------------------------
> >>> 
> >>> As Mel also agreed with me in v1 mail thread, this highatomic reserved should
> >>> be considered even in watermark fast.
> >>> 
> >>> The comment, I think, may need to be changed. Prior to this patch, non
> >>> highatomic
> >>> allocation may do useless search, but it also can take ALL non highatomic free.
> >>> 
> >>> With this patch, non highatomic allocation will NOT do useless search. Rather,
> >>> it may be required direct reclamation even when there are some non
> >>> high atomic free.
> >>> 
> >>> i.e)
> >>> In following situation, watermark check fails (9MB - 8MB < 4MB) though there are
> >>> enough free (9MB - 4MB > 4MB). If this is really matter, we need to
> >>> count highatomic
> >>> free accurately.
> >> 
> >> Seems to make sense. We only use zone->nr_reserved_highatomic to account
> >> the reserved highatomic, don't track how much have been used for
> >> highatomic allocation. But not sure if this will happen often, or just a
> >> very rare case, whether taking that into account will impact anything.
> > 
> >Unfortunately there's a problem when trying to account free pages of a migrate
> >type exactly, as e.g. during reserve_highatomic_pageblock(), some pages might be
> >in pcplist of other cpu with other migratetype, and once they are freed, the
> >buddy merging will merge the different migratetypes and distort the accounting.

Yeah, the migratetype could have been cached in page->index before we
finish the reserve_highatomic_pageblock(). Seems we take a very coarse
grained way to do the highatomic reservation and accounting. When I went
through the related code, found out we call
reserve_highatomic_pageblock() if below condition is met. So what if
order is 1, and all other pages on the page block have been used? Do we
possibly have this kind of extreme case?

From Jaewon's captured information, we can see that the available free
highatomic is even less than half the zone->nr_reserved_highatomic.
Should we at least limit the reservation to the case with a bigger
order. E.g 1/2 of pageblock_nr_pages? Please correct me if I am wrong or
miss anyting.

"reserved_highatomic:32768KB and actually 14232kB free."

get_page_from_freelist
{
	...
			if (unlikely(order && (alloc_flags & ALLOC_HARDER)))
                                reserve_highatomic_pageblock(page, zone, order);
	...
}
> >Fixing this for all migratetypes would have performance overhead, so we only do
> >that for MIGRATE_ISOLATE which is not that frequent (and it took a while to
> >eliminate all corner cases), and CMA which doesn't change pageblocks dynamically.
> 
> AFAIK we do not account free cma in pcp either. But yes accurate check could be 
> overhead. For example, __mod_zone_freepage_state should account highatomic free 
> as cma free. And we may see some incorrect accounting issue.
> 
> > 
> >So either we live with the possible overreclaim due to inaccurate counting per
> >your example above, or we instead let order-0 atomic allocations use highatomic
> >reserves.
> >
> 
> Additionally regarding existing Mel's comment, let me remove some of it if you
> don't mind.
> 
>         /*
>          * Fast check for order-0 only. If this fails then the reserves
> -        * need to be calculated. There is a corner case where the check
> -        * passes but only the high-order atomic reserve are free. If
> -        * the caller is !atomic then it'll uselessly search the free
> -        * list. That corner case is then slower but it is harmless.
> +        * need to be calculated.
>          */
> 
> I will prepare v3 patch.
> Thank you again.
> 

