Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9179C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78B652072D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afVEGVeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgE2GsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 02:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgE2GsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 02:48:13 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1959FC03E969
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 23:48:13 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c12so1256802qkk.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 23:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eHKgjBe59Q+TYOKb0FCla/vxPoXJWRQ/V33x97t4mcs=;
        b=afVEGVeg9wVGNNJ2UiIKRuEMeZb8b1AOZrVXX/76qSbSPoVehetkWf9N/6b+zDkTzn
         mq7F8Xb/uxOzPoNDWlGM6XOLs+di0LdtE6Oc7YHRR6EqM/Bx+5sYpXQ1ilXA/np9k4Cz
         NGCNzk46ZUN9PwYPqdDwdOU3n5tv06geW8VR4UUiTA8Giqhy1NON5vdqq3afPu9ABEC7
         0CuhGPgohJifFlJN6b4SgkfVTuqqfX/iAO+7wIKfVaLrcoer56klAA+RNABUvmHxv/el
         YR2A7MhE1mw0eDDPBOCBFGwZX5TlyPWa6ZR66IKj0B/i6rA3nN7ob0UplpsiMYKs1lN8
         SfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eHKgjBe59Q+TYOKb0FCla/vxPoXJWRQ/V33x97t4mcs=;
        b=XHzW/Ph/uziRbvVFLQFHmuKgfgO+nFbLkNiOW8fx7uW+5g+IOIA1VUfhGNEVuiqwmS
         X+lmju1tWTeoV+rfXrhHiyIzUSns0recWUweF7OuDyErrYR9vvp4BjNoLve+t8KhbcEa
         2RgyBr3nxAqj8blL1drDleKOk9W/SWWbUJKP5vE6fTqECytNaj+FyfoFT/yU4hNRVMh9
         v7ICFjIRHaeZJlLQtZ8SHgBcdq0R25NYEwaif6sTYqAOO5Zg8389IWI4GjXMEUgLhqgM
         u7dy1yZYhnFZ3FPsl/4i8Her6BiLlwgSSZVHqSMelfy1WLvnvY1oGyoVYPQIl09UbmOu
         H2lw==
X-Gm-Message-State: AOAM532EG1PwBDUbsz3OTCsMB2b6i1LMikAvCk8hBkQ1HvIWQzi9eTxA
        TG/AILJUywrCto41U6DTDVf0C2qRPKXi6O1weYjLtGXN
X-Google-Smtp-Source: ABdhPJyequgrdR1/Cieoad1xAUqoY3cVxt6pF821tIdfJgow9zU4kZw3nlsbEX7glCMsrdPzzCrjQBpb4mD5wDojoJQ=
X-Received: by 2002:a37:d245:: with SMTP id f66mr6692945qkj.452.1590734891897;
 Thu, 28 May 2020 23:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200520232525.798933-1-hannes@cmpxchg.org> <20200520232525.798933-6-hannes@cmpxchg.org>
 <CAAmzW4MMLw=4BHRtt=g8BHpQLTaSmhG03Ct6WMjmDxVnOkNQYA@mail.gmail.com>
 <20200527134333.GF6781@cmpxchg.org> <CAAmzW4NW+cv7VnNApWKJr4r9=QKaufK3y5apyNXo-M-y=q0dgg@mail.gmail.com>
 <20200528170155.GA69521@cmpxchg.org>
In-Reply-To: <20200528170155.GA69521@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 29 May 2020 15:48:00 +0900
Message-ID: <CAAmzW4NEPZRWL5PBXEWwg9kBOL9fYUNqTTzh3WRDWbaSPLv=CQ@mail.gmail.com>
Subject: Re: [PATCH 05/14] mm: workingset: let cache workingset challenge anon
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 5=EC=9B=94 29=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 2:02, J=
ohannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, May 28, 2020 at 04:16:50PM +0900, Joonsoo Kim wrote:
> > 2020=EB=85=84 5=EC=9B=94 27=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 10:=
43, Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> > >
> > > On Wed, May 27, 2020 at 11:06:47AM +0900, Joonsoo Kim wrote:
> > > > 2020=EB=85=84 5=EC=9B=94 21=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84=
 8:26, Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
> > > > >
> > > > > We activate cache refaults with reuse distances in pages smaller =
than
> > > > > the size of the total cache. This allows new pages with competiti=
ve
> > > > > access frequencies to establish themselves, as well as challenge =
and
> > > > > potentially displace pages on the active list that have gone cold=
.
> > > > >
> > > > > However, that assumes that active cache can only replace other ac=
tive
> > > > > cache in a competition for the hottest memory. This is not a grea=
t
> > > > > default assumption. The page cache might be thrashing while there=
 are
> > > > > enough completely cold and unused anonymous pages sitting around =
that
> > > > > we'd only have to write to swap once to stop all IO from the cach=
e.
> > > > >
> > > > > Activate cache refaults when their reuse distance in pages is sma=
ller
> > > > > than the total userspace workingset, including anonymous pages.
> > > >
> > > > Hmm... I'm not sure the correctness of this change.
> > > >
> > > > IIUC, this patch leads to more activations in the file list and mor=
e activations
> > > > here will challenge the anon list since rotation ratio for the file
> > > > list will be increased.
> > >
> > > Yes.
> > >
> > > > However, this change breaks active/inactive concept of the file lis=
t.
> > > > active/inactive
> > > > separation is implemented by in-list refault distance. anon list si=
ze has
> > > > no direct connection with refault distance of the file list so usin=
g
> > > > anon list size
> > > > to detect workingset for file page breaks the concept.
> > >
> > > This is intentional, because there IS a connection: they both take up
> > > space in RAM, and they both cost IO to bring back once reclaimed.
> >
> > I know that. This is the reason that I said 'no direct connection'. The=
 anon
> > list size is directly related the *possible* file list size. But,
> > active/inactive
> > separation in one list is firstly based on *current* list size rather t=
han
> > the possible list size. Adding anon list size to detect workingset mean=
s
> > to use the possible list size and I think that it's wrong.
>
> Hm so you're saying we should try to grow the page cache, but maintain
> an inactive/active balance within the cache based on its current size
> in case growing is not possible.
>
> I think it would be implementable*, but I'm not quite convinced that
> it's worth distinguishing. We're talking about an overcommitted
> workingset and thereby an inherently unstable state that may thrash
> purely based on timing differences anyway. See below.

I think that this patch wrongly judge the overcommitted workingset.
See below new example in this reply.

> *It would require another page flag to tell whether a refaulting cache
> page has challenged the anon set once (transitioning) or repeatedly
> (thrashing), as we currently use the active state for that. If we
> would repurpose PG_workingset to tell the first from the second
> refault, we'd need a new flag to mark a page for memstall accounting.

I don't understand why a new flag is needed. Whenever we found that
challenge is needed (dist < active + anon), we need to add up IO cost.

> > > When file is refaulting, it means we need to make more space for
> > > cache. That space can come from stale active file pages. But what if
> > > active cache is all hot, and meanwhile there are cold anon pages that
> > > we could swap out once and then serve everything from RAM?
> > >
> > > When file is refaulting, we should find the coldest data that is
> > > taking up RAM and kick it out. It doesn't matter whether it's file or
> > > anon: the goal is to free up RAM with the least amount of IO risk.
> >
> > I understand your purpose and agree with it. We need to find a solution=
.
> > To achieve your goal, my suggestion is:
> >
> > - refault distance < active file, then do activation and add up IO cost
> > - refault distance < active file + anon list, then add up IO cost
> >
> > This doesn't break workingset detection on file list and challenge
> > the anon list as the same degree as you did.
>
> Unfortunately, it doesn't challenge the anon set. We'll stay in cache
> trimming mode where the IO cost balance doesn't have any effect.

Ah... I missed that. I think that we can avoid cache trimming mode easily.
Like as WORKINGSET_REFAULT, we need to snapshot
WORKINGSET_EXPAND. And, if we find a change to it, we can skip
cache trimming mode.

> We would need to
>
>   1. activate on distance < active file
>   2. force reclaim to scan anon when distance < active file + anon
>   3. record thrashing and IO cost when distance < active file + anon
>      and it's the second refault of the page.
>
> Something like this, where vmscan would scan anon when
> WORKINGSET_RESTORE or WORKINGSET_EXPAND events are occuring:
>
> diff --git a/mm/workingset.c b/mm/workingset.c
> index d481ea452eeb..41dde6274fff 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -275,9 +275,9 @@ void *workingset_eviction(struct page *page, struct m=
em_cgroup *target_memcg)
>  void workingset_refault(struct page *page, void *shadow)
>  {
>         struct mem_cgroup *eviction_memcg;
> +       unsigned long active_file, anon;
>         struct lruvec *eviction_lruvec;
>         unsigned long refault_distance;
> -       unsigned long workingset_size;
>         struct pglist_data *pgdat;
>         struct mem_cgroup *memcg;
>         unsigned long eviction;
> @@ -330,7 +330,7 @@ void workingset_refault(struct page *page, void *shad=
ow)
>         refault_distance =3D (refault - eviction) & EVICTION_MASK;
>
>         /*
> -        * The activation decision for this page is made at the level
> +        * The distance decisions for this page is made at the level
>          * where the eviction occurred, as that is where the LRU order
>          * during page reclaim is being determined.
>          *
> @@ -344,32 +344,52 @@ void workingset_refault(struct page *page, void *sh=
adow)
>
>         /*
>          * Compare the distance to the existing workingset size. We
> -        * don't activate pages that couldn't stay resident even if
> -        * all the memory was available to the page cache. Whether
> -        * cache can compete with anon or not depends on having swap.
> +        * ignore pages that couldn't stay resident even if all the
> +        * memory was available to the page cache. Whether cache can
> +        * compete with anon or not depends on having swap.
>          */
> -       workingset_size =3D lruvec_page_state(eviction_lruvec, NR_ACTIVE_=
FILE);
> +       active_file =3D lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE=
);
> +       anon =3D 0;
>         if (mem_cgroup_get_nr_swap_pages(memcg) > 0) {
> -               workingset_size +=3D lruvec_page_state(eviction_lruvec,
> -                                                    NR_INACTIVE_ANON);
> -               workingset_size +=3D lruvec_page_state(eviction_lruvec,
> -                                                    NR_ACTIVE_ANON);
> +               anon +=3D lruvec_page_state(eviction_lruvec, NR_INACTIVE_=
ANON);
> +               anon +=3D lruvec_page_state(eviction_lruvec, NR_ACTIVE_AN=
ON);
>         }
> -       if (refault_distance > workingset_size)
> -               goto out;
>
> -       SetPageActive(page);
> -       advance_inactive_age(memcg, pgdat);
> -       inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE);
> +       if (refault_distance > active_file + anon)
> +               goto out;
>
> -       /* Page was active prior to eviction */
> +       /*
> +        * Page has already challenged the workingset before, and it's
> +        * refaulting again: we're not transitioning out old cache,
> +        * we're thrashing and need to grow. Record the IO to tip the
> +        * reclaim balance and mark the page for memstall detection.
> +        */
>         if (workingset) {
> -               SetPageWorkingset(page);
> +               inc_lruvec_state(lruvec, WORKINGSET_RESTORE);
> +
>                 /* XXX: Move to lru_cache_add() when it supports new vs p=
utback */
>                 spin_lock_irq(&page_pgdat(page)->lru_lock);
>                 lru_note_cost_page(page);
>                 spin_unlock_irq(&page_pgdat(page)->lru_lock);
> -               inc_lruvec_state(lruvec, WORKINGSET_RESTORE);
> +
> +               SetPageThrashing(page);
> +       }
> +
> +       SetPageWorkingset(page);
> +
> +       /*
> +        * Activate right away if page can compete with the existing
> +        * active set given the *current* size of the page cache.
> +        *
> +        * Otherwise, the page cache needs to grow to house this
> +        * page. Tell reclaim to rebalance against anonymous memory.
> +        */
> +       if (refault_distance <=3D active_file) {
> +               SetPageActive(page);
> +               advance_inactive_age(memcg, pgdat);
> +               inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE);
> +       } else {
> +               inc_lruvec_state(lruvec, WORKINGSET_EXPAND);
>         }
>  out:
>         rcu_read_unlock();
>
> > > Remember that the file/anon split, and the inactive/active split, are
> > > there to optimize reclaim. It doesn't mean that these memory pools ar=
e
> > > independent from each other.
> > >
> > > The file list is split in two because of use-once cache. The anon and
> > > file lists are split because of different IO patterns, because we may
> > > not have swap etc. But once we are out of use-once cache, have swap
> > > space available, and have corrected for the different cost of IO,
> > > there needs to be a relative order between all pages in the system to
> > > find the optimal candidates to reclaim.
> > >
> > > > My suspicion is started by this counter example.
> > > >
> > > > Environment:
> > > > anon: 500 MB (so hot) / 500 MB (so hot)
> > > > file: 50 MB (hot) / 50 MB (cold)
> > > >
> > > > Think about the situation that there is periodical access to other =
file (100 MB)
> > > > with low frequency (refault distance is 500 MB)
> > > >
> > > > Without your change, this periodical access doesn't make thrashing =
for cached
> > > > active file page since refault distance of periodical access is lar=
ger
> > > > than the size of
> > > > the active file list. However, with your change, it causes thrashin=
g
> > > > on the file list.
> > >
> > > It doesn't cause thrashing. It causes scanning because that 100M file
> > > IS thrashing: with or without my patch, that refault IO is occuring.
> >
> > It could cause thrashing for your patch.
> > Without the patch, current logic try to
> > find most hottest file pages that are fit into the current file list
> > size and protect them
> > successfully. Assume that access distance of 50 MB hot file pages is 60=
 MB
> > which is less than whole file list size but larger than inactive list
> > size. Without
> > your patch, 50 MB (hot) pages are not evicted at all. All these hot
> > pages will be
> > protected from the 100MB low access frequency pages. 100 MB low access
> > frequency pages will be refaulted repeatedely but it's correct behaviou=
r.
>
> Hm, something doesn't quite add up. Why is the 50M hot set evicted
> with my patch?

Thanks for kind explanation. I read all and I found that I was confused bef=
ore.
Please let me correct the example.

Environment:
anon: 500 MB (hot) / 500 MB (hot)
file: 50 MB (so hot) / 50 MB (dummy)

I will call 50 MB file hot pages as F(H).
Let's assume that periodical access to other file (500 MB) is started. That
file consists of 5 parts and each one is 100 MB. I will call it P1, P2, ...=
, P5.

Problem will occur on following access pattern.

F(H) -> P1 -> F(H) -> P2 -> ... -> F(H) -> P5 -> F(H) -> P1 -> ...

With this access pattern, access distance of F(H) and Pn is:

F(H) =3D 150 MB
Pn =3D 750 MB

Without your patch, F(H) is kept on the memory since deactivation would not
happen. However, with your patch, deactivation happens since Pn's refault
distance is less than 'active file + anon'. In the end, F(H) would be final=
ly
evicted.

> With a 60M access distance and a 100M page cache, they might get
> deactivated, but then activated back to the head of the active list on
> their next access. They should get scanned but not actually reclaimed.

Sorry about the wrong example. I fixed the example in the above phrase.

> The only way they could get reclaimed is if their access distance ends
> up bigger than the file cache. But if that's the case, then the
> workingset is overcommitted, and none of the pages qualify for reclaim
> protection. Picking a subset to protect against the rest is arbitrary.

In the fixed example, although other file (500 MB) is repeatedly accessed,
it's not workingset. If we have unified list (file + anon), access distance=
 of
Pn will be larger than whole memory size. Therefore, it's not overcommitted
workingset and this patch wrongly try to activate it. As I said before,
without considering inactive_age for anon list, this calculation can not be
correct.

> For example, if you started out with 50M of free space and an empty
> cache and started accessing the 50M and 100M files simultaneously,
> with the access distances you specified, none of them would get
> activated. You would have the same behavior with or without my patch.

It's not good example for my case. The purpose of active/inactive separatio=
n
is to protect previous hot pages until new evidence is found. If accessing
50M and 100M files simultaneously on 100M free space, all of them are
not activated. However, if 50M is in active list and then access to 50M and
100M happens simultaneously, we need to protect previous 50M. My example
is started with 50M in active list. So, it should be protected until
new evidence
is found. Pn is not new evidence.

> > However, with your patch, 50 MB (hot) file pages are deactivated due to=
 newly
> > added file pages with low access frequency. And, then, since access dis=
tance of
> > 50 MB (hot) pages is larger than inactive list size, they could not
> > get a second chance
> > and finally could be evicted.
>
> Ah okay, that's a different concern. We DO get two references, but we
> fail to detect them properly.

As I said before, I was confused here. Your following explanation is correc=
t
and I understand it. Please focus on my fixed example.

Thanks.
