Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCBAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19977208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJZtZL/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgE1HQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgE1HQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:16:57 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3D1C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:16:57 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w3so2197036qkb.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zzl4su2mdO7fmSVguQi0T6DsJTTX2cv4yJqucwUaIW0=;
        b=mJZtZL/JvyjyGWTqw8WosDhS5gHoHQ3M8z7OwToE8YV2LLXieRp5hBzkg7YydYcZ7v
         QoDc1VuLnBN+HZAu94clTZcFX6DjTwePFiS+YgzqRzot5y2ii12lTgjJal48lwrYna8L
         IxZZM3L0cVTi2KYHFWX/nH+PQcFVr11SwKEmWOwZTiByw1CIJ2gGHqR4arVOJ55ygMwy
         sayI01DDf2QNg1EAQk1t0x05yt9sySHsbnKySIg9k4QUZoRSXPP0wJSpjIRk1sZZDM6j
         +XB/MGWqinpcHywUkmZF0OgAq88KWftWlfce5EKEr7SQmRGlrgXKEDisbGk9KkXQgP9F
         5Ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zzl4su2mdO7fmSVguQi0T6DsJTTX2cv4yJqucwUaIW0=;
        b=XGR68SSQnx7VO/vrCosrnaLi/PGkd3Y1TulZT/PzIJHLDs5GP2OEPMCOiR6BrlHcrk
         rt/hpbaslXiicQAplvlIwBTblA1xoQAKnPP/mi7gX0Wd4szUPMYcuNyGXO3quPZVc3lA
         7diXq0llIij2dMXdT6sSJlw8z1k2itbBgKCvtqH7dA+E6Y27/Azzn3EF1ymfe04bI/vS
         l/RMIitdfHNrvfPRo6lgO4PjHQkbJib+ZofcO4PK5jRnVwuJ0+iVWX3yt29KiyL9sU/q
         4h83nOL82l78UiSETtDFH2HGWmg3XUbX+sqqhFZUHywPxEHNpQ81OvoiEYliZSDML7lV
         SmLg==
X-Gm-Message-State: AOAM531i/V1sWAT8McMigDXMaasb6sDmZ+kh2v5g8XFnEolQofIGGhPM
        3IrHEEuFY4GB6OUJoq1Hl1FYO2U2kFTa1Crq8QA=
X-Google-Smtp-Source: ABdhPJzG3LsiAe//fHH/9xAJZzt8bpn4NUEb6jvsxNjOdzzHPahFIoslDeMlzVF7oTwWiEbsBgqOdpr8JGwRd86ogR4=
X-Received: by 2002:a37:7745:: with SMTP id s66mr1471793qkc.429.1590650216701;
 Thu, 28 May 2020 00:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200520232525.798933-1-hannes@cmpxchg.org> <20200520232525.798933-6-hannes@cmpxchg.org>
 <CAAmzW4MMLw=4BHRtt=g8BHpQLTaSmhG03Ct6WMjmDxVnOkNQYA@mail.gmail.com> <20200527134333.GF6781@cmpxchg.org>
In-Reply-To: <20200527134333.GF6781@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 28 May 2020 16:16:50 +0900
Message-ID: <CAAmzW4NW+cv7VnNApWKJr4r9=QKaufK3y5apyNXo-M-y=q0dgg@mail.gmail.com>
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

2020=EB=85=84 5=EC=9B=94 27=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 10:43, =
Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, May 27, 2020 at 11:06:47AM +0900, Joonsoo Kim wrote:
> > 2020=EB=85=84 5=EC=9B=94 21=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 8:2=
6, Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> > >
> > > We activate cache refaults with reuse distances in pages smaller than
> > > the size of the total cache. This allows new pages with competitive
> > > access frequencies to establish themselves, as well as challenge and
> > > potentially displace pages on the active list that have gone cold.
> > >
> > > However, that assumes that active cache can only replace other active
> > > cache in a competition for the hottest memory. This is not a great
> > > default assumption. The page cache might be thrashing while there are
> > > enough completely cold and unused anonymous pages sitting around that
> > > we'd only have to write to swap once to stop all IO from the cache.
> > >
> > > Activate cache refaults when their reuse distance in pages is smaller
> > > than the total userspace workingset, including anonymous pages.
> >
> > Hmm... I'm not sure the correctness of this change.
> >
> > IIUC, this patch leads to more activations in the file list and more ac=
tivations
> > here will challenge the anon list since rotation ratio for the file
> > list will be increased.
>
> Yes.
>
> > However, this change breaks active/inactive concept of the file list.
> > active/inactive
> > separation is implemented by in-list refault distance. anon list size h=
as
> > no direct connection with refault distance of the file list so using
> > anon list size
> > to detect workingset for file page breaks the concept.
>
> This is intentional, because there IS a connection: they both take up
> space in RAM, and they both cost IO to bring back once reclaimed.

I know that. This is the reason that I said 'no direct connection'. The ano=
n
list size is directly related the *possible* file list size. But,
active/inactive
separation in one list is firstly based on *current* list size rather than
the possible list size. Adding anon list size to detect workingset means
to use the possible list size and I think that it's wrong.

> When file is refaulting, it means we need to make more space for
> cache. That space can come from stale active file pages. But what if
> active cache is all hot, and meanwhile there are cold anon pages that
> we could swap out once and then serve everything from RAM?
>
> When file is refaulting, we should find the coldest data that is
> taking up RAM and kick it out. It doesn't matter whether it's file or
> anon: the goal is to free up RAM with the least amount of IO risk.

I understand your purpose and agree with it. We need to find a solution.
To achieve your goal, my suggestion is:

- refault distance < active file, then do activation and add up IO cost
- refault distance < active file + anon list, then add up IO cost

This doesn't break workingset detection on file list and challenge
the anon list as the same degree as you did.

> Remember that the file/anon split, and the inactive/active split, are
> there to optimize reclaim. It doesn't mean that these memory pools are
> independent from each other.
>
> The file list is split in two because of use-once cache. The anon and
> file lists are split because of different IO patterns, because we may
> not have swap etc. But once we are out of use-once cache, have swap
> space available, and have corrected for the different cost of IO,
> there needs to be a relative order between all pages in the system to
> find the optimal candidates to reclaim.
>
> > My suspicion is started by this counter example.
> >
> > Environment:
> > anon: 500 MB (so hot) / 500 MB (so hot)
> > file: 50 MB (hot) / 50 MB (cold)
> >
> > Think about the situation that there is periodical access to other file=
 (100 MB)
> > with low frequency (refault distance is 500 MB)
> >
> > Without your change, this periodical access doesn't make thrashing for =
cached
> > active file page since refault distance of periodical access is larger
> > than the size of
> > the active file list. However, with your change, it causes thrashing
> > on the file list.
>
> It doesn't cause thrashing. It causes scanning because that 100M file
> IS thrashing: with or without my patch, that refault IO is occuring.

It could cause thrashing for your patch. Without the patch, current logic t=
ry to
find most hottest file pages that are fit into the current file list
size and protect them
successfully. Assume that access distance of 50 MB hot file pages is 60 MB
which is less than whole file list size but larger than inactive list
size. Without
your patch, 50 MB (hot) pages are not evicted at all. All these hot
pages will be
protected from the 100MB low access frequency pages. 100 MB low access
frequency pages will be refaulted repeatedely but it's correct behaviour.

However, with your patch, 50 MB (hot) file pages are deactivated due to new=
ly
added file pages with low access frequency. And, then, since access distanc=
e of
50 MB (hot) pages is larger than inactive list size, they could not
get a second chance
and finally could be evicted. I think that this is a thrashing since
low access frequency
pages that are not fit for current file list size pushes out the high
access frequency
pages that are fit for current file list size and it would happen
again and again.

Maybe, logic can be corrected if the patch considers inactive age of
anon list but
I think that my above suggestion would be enough.

> What this patch acknowledges is that the 100M file COULD fit fully
> into memory, and not require any IO to serve, IFF 100M of the active
> file or anon pages were cold and could be reclaimed or swapped out.
>
> In your example, the anon set is hot. We'll scan it slowly (at the
> rate of IO from the other file) and rotate the pages that are in use -
> which would be all of them. Likewise for the file - there will be some
> deactivations, but mark_page_accessed() or the second chance algorithm
> in page_check_references() for mapped will keep the hottest pages active.
> In a slightly modified example, 400M of the anon set is hot and 100M
> cold. Without my patch, we would never look for them and the second
> file would be IO-bound forever. After my patch, we would scan anon,
> eventually find the cold pages, swap them out, and then serve the
> entire workingset from memory.

Again, I agree with your goal. What I don't agree is the implementation
to achieve the goal.

Thanks.
