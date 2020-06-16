Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8984C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1BBD208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULCoQQ9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732810AbgFPQIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732189AbgFPPqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:46:20 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A74C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 08:46:18 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id 18so4178605ooy.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7thiHFBoey/tZKQDBy04EAI+ipYMI2AjZYar5AlNAzY=;
        b=ULCoQQ9JVYmvAV1pJjfhaqd7QAO6TZSnFUakFVnMeONmKbPZIrBb7DgHPAbGSiVnWZ
         EIlYfFs3qmwnZDJ6vjYjh8tZDNVNUPd5klI4ChItQ6G1bfbIGd3vPsey89VpssKeMMVw
         gEld5tGwl7Qu3ILHMyw+U6uEkB3cgRoMTYiXldnKNd/3qI2bPHofCEBt59U6JtlECTHK
         MCPTA8eJ5eGLRMlqOWhTOcEMo8rrZh7tFO/afh9vDJA5etJPl1UKuPA4WISP1Re+oZ0J
         GTJlkI7OuRESNQg9bLo7vbN2NPirMKPafOERd4psj4ov3DW5CmdcV7wvrKD/4fQBpImd
         fL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7thiHFBoey/tZKQDBy04EAI+ipYMI2AjZYar5AlNAzY=;
        b=Cgkv4xPvUSp3OnpAhzm/MEWv0qirDvgko0Goky83UfsFZOKjoa1Wj0sEniLFmq7eBN
         o+AKzSuiFnYTnzn8wjWZxa7IpBN6DBF1iOjkZ5GNfBSc0yp6sfs8ZdT1g1ZgcfWR/7G8
         2/UogHPyUL82Dh+GR4hHAbPEl9ucgLGRmxWB6qboBTUaue7tZgFwbr45clonF9QSYph9
         r0H8JLL3zsLicHqpMFo7WmU/aJP4NfWFtqiSLSNCyalaIHS19japWHoN5YprzWgpGcXJ
         HFgi92vVJOLuo3shQf2DWYI4DFT+FYxzBs3bkBOZYB/vYPpC+alWC3S7iOYPouptKiOA
         q3EA==
X-Gm-Message-State: AOAM533WGAy9Jn+EKKK1TLPCG6mEtmJle6BAxNK1Lsy5UUnZAU51ma9Q
        dyPiFExUdaV0xZ9hzeRuoA2Bjw4hSCc9H+aqXdk=
X-Google-Smtp-Source: ABdhPJxpgx/SGljD+8y21egV89WdkpdMB89Hck9Arnku8DIFFxJ0fAUjOjIUnnZYEDYrT750xnYhOmv6Ox4IqwaO4aE=
X-Received: by 2002:a4a:e89a:: with SMTP id g26mr2985657ooe.14.1592322377421;
 Tue, 16 Jun 2020 08:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <26a6a2c2-56e6-1a34-84ac-8ff9f74c34ce@suse.cz> <20200613025102.12880-1-jaewon31.kim@samsung.com>
 <20200613094228.GB3346@MiWiFi-R3L-srv> <CAJrd-Ut=QcK5FQP2TUm6==mowoVK_QVCB7x=LL4iUnZxBLYAmA@mail.gmail.com>
 <20200613231736.GJ20367@MiWiFi-R3L-srv> <CGME20200612085027epcas1p46383a7eda792eabbd1e74cd08fe988c9@epcms1p1>
 <20200616073002epcms1p12a14cc85b0aebf8ba88bedee7495b34f@epcms1p1> <20200616141717.GN20367@MiWiFi-R3L-srv>
In-Reply-To: <20200616141717.GN20367@MiWiFi-R3L-srv>
From:   Jaewon Kim <jaewon31.kim@gmail.com>
Date:   Wed, 17 Jun 2020 00:46:02 +0900
Message-ID: <CAJrd-UuWas4ctJZVd76fiENaDJY6O1EMBisFfdVws09YLQwmrQ@mail.gmail.com>
Subject: Re: (2) [PATCH v2] page_alloc: consider highatomic reserve in
 wmartermark fast
To:     Baoquan He <bhe@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?7J207Jqp7YOd?= <ytk.lee@samsung.com>,
        =?UTF-8?B?6rmA7LKg66+8?= <cmlaika.kim@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.,

2020=EB=85=84 6=EC=9B=94 16=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 11:17, =
Baoquan He <bhe@redhat.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 06/16/20 at 04:30pm, =EA=B9=80=EC=9E=AC=EC=9B=90 wrote:
> > >>> > > <4>[ 6207.637627]  [3:  Binder:9343_3:22875] Normal free:10908k=
B min:6192kB low:44388kB high:47060kB active_anon:409160kB inactive_anon:32=
5924kB active_file:235820kB inactive_file:276628kB unevictable:2444kB write=
pending:252kB present:3076096kB managed:2673676kB mlocked:2444kB kernel_sta=
ck:62512kB pagetables:105264kB bounce:0kB free_pcp:4140kB local_pcp:40kB fr=
ee_cma:712kB
> > >>
> > >> Checked this mem info, wondering why there's no 'reserved_highatomic=
'
> > >> printing in all these examples.
> > >
> > >Yeah, it better be printed, especially after it's included in watermar=
k
> > >calculation, so we're less confused by reports of allocation failure w=
here
> > >watermarks are seemingly ok.
> > >
> >
> >
> > Hello Vlastimil and Baoquan
> >
> > The log in previous mail was captured from kernel based on v4.14.
> > After adding the reserved_highatomic log, I finally got a new log below
> > Let me change description in next patch.
> >
> > There seems be reserved_highatomic:32768KB and actually 14232kB free.
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
kB isolated(file):0kB mapped:410044kB d           irty:468kB writeback:0kB =
shmem:13196kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
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
> >
> > >...
> > >
> > >>> > >       /*
> > >>> > >        * Fast check for order-0 only. If this fails then the re=
serves
> > >>> > > @@ -3598,9 +3604,12 @@ static inline bool zone_watermark_fast(s=
truct zone *z, unsigned int order,
> > >>> > >        * the caller is !atomic then it'll uselessly search the =
free
> > >>> > >        * list. That corner case is then slower but it is harmle=
ss.
> > >>> >
> > >>> > Do we need remove or adjust the code comment at this place? So Me=
l have
> > >>> > foreseen the corner case, just reclaiming to unreserve the highat=
omic
> > >>> > might be ignored.
> > >>> >
> > >>>
> > >>> Hello thank you for your comment.
> > >>>
> > >>> My previous mail to Vlastimil Babka seems to have html.
> > >>> Let me put  again here because I also think the comment should be c=
hanged.
> > >>> I'd like to hear opinions from the open source community.
> > >>
> > >> Yeah, your replying mail to Vlastimil looks a little messy on format=
, I
> > >> didn't scroll down to check.
> > >>
> > >>>
> > >>> Additionally actually I think we need accurate counting of highatom=
ic
> > >>> free after this patch.
> > >>>
> > >>> -------------------------------------------------------------------=
---------------------
> > >>>
> > >>> As Mel also agreed with me in v1 mail thread, this highatomic reser=
ved should
> > >>> be considered even in watermark fast.
> > >>>
> > >>> The comment, I think, may need to be changed. Prior to this patch, =
non
> > >>> highatomic
> > >>> allocation may do useless search, but it also can take ALL non high=
atomic free.
> > >>>
> > >>> With this patch, non highatomic allocation will NOT do useless sear=
ch. Rather,
> > >>> it may be required direct reclamation even when there are some non
> > >>> high atomic free.
> > >>>
> > >>> i.e)
> > >>> In following situation, watermark check fails (9MB - 8MB < 4MB) tho=
ugh there are
> > >>> enough free (9MB - 4MB > 4MB). If this is really matter, we need to
> > >>> count highatomic
> > >>> free accurately.
> > >>
> > >> Seems to make sense. We only use zone->nr_reserved_highatomic to acc=
ount
> > >> the reserved highatomic, don't track how much have been used for
> > >> highatomic allocation. But not sure if this will happen often, or ju=
st a
> > >> very rare case, whether taking that into account will impact anythin=
g.
> > >
> > >Unfortunately there's a problem when trying to account free pages of a=
 migrate
> > >type exactly, as e.g. during reserve_highatomic_pageblock(), some page=
s might be
> > >in pcplist of other cpu with other migratetype, and once they are free=
d, the
> > >buddy merging will merge the different migratetypes and distort the ac=
counting.
>
> Yeah, the migratetype could have been cached in page->index before we
> finish the reserve_highatomic_pageblock(). Seems we take a very coarse
> grained way to do the highatomic reservation and accounting. When I went
> through the related code, found out we call
> reserve_highatomic_pageblock() if below condition is met. So what if
> order is 1, and all other pages on the page block have been used? Do we
> possibly have this kind of extreme case?

If I correctly understand your question, yes I think so.
If a hight-order free page was allocated on ALLOC_HARDER context, and the p=
age
was the last order-1, then zone->nr_reserved_highatomic will be increased b=
y
pageblock_nr_pages even though there was actually no free page moved to the
highatomic free page list.

The highatomic logic, I think, was originally designed to reserve in
that coarse grained
way to mitigate highatomic allocation failure.

>
> From Jaewon's captured information, we can see that the available free
> highatomic is even less than half the zone->nr_reserved_highatomic.
> Should we at least limit the reservation to the case with a bigger
> order. E.g 1/2 of pageblock_nr_pages? Please correct me if I am wrong or
> miss anyting.
>

I do not know well, but I think high-order lower than 1/2 of pageblock_nr_p=
ages
also should be considered. i.e) a system using huge order-3 atomic allocati=
on
in a short time.

> "reserved_highatomic:32768KB and actually 14232kB free."

I think this unwanted case might happen by freed pages. The pages allocated
for non-high-atomic also would be freed back into highatomic free
list. But I guess
there was sudden huge use of highatomic and partially freed.

>
> get_page_from_freelist
> {
>         ...
>                         if (unlikely(order && (alloc_flags & ALLOC_HARDER=
)))
>                                 reserve_highatomic_pageblock(page, zone, =
order);
>         ...
> }
> > >Fixing this for all migratetypes would have performance overhead, so w=
e only do
> > >that for MIGRATE_ISOLATE which is not that frequent (and it took a whi=
le to
> > >eliminate all corner cases), and CMA which doesn't change pageblocks d=
ynamically.
> >
> > AFAIK we do not account free cma in pcp either. But yes accurate check =
could be
> > overhead. For example, __mod_zone_freepage_state should account highato=
mic free
> > as cma free. And we may see some incorrect accounting issue.
> >
> > >
> > >So either we live with the possible overreclaim due to inaccurate coun=
ting per
> > >your example above, or we instead let order-0 atomic allocations use h=
ighatomic
> > >reserves.
> > >
> >
> > Additionally regarding existing Mel's comment, let me remove some of it=
 if you
> > don't mind.
> >
> >         /*
> >          * Fast check for order-0 only. If this fails then the reserves
> > -        * need to be calculated. There is a corner case where the chec=
k
> > -        * passes but only the high-order atomic reserve are free. If
> > -        * the caller is !atomic then it'll uselessly search the free
> > -        * list. That corner case is then slower but it is harmless.
> > +        * need to be calculated.
> >          */
> >
> > I will prepare v3 patch.
> > Thank you again.
> >
>
