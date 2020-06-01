Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933C3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA792073E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J57JSJH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgFAGOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgFAGOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:14:30 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9607C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 23:14:30 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 205so8082995qkg.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 23:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0YgE1ujhzdZA7Dk0idL4tidoEAUBmdOzJLM22gBjBnM=;
        b=J57JSJH8zSwnSGDuxcetfioHSSD+zos4FgzHsDh/csTC5ZiNEhWQUk1x/JqdDZIc0p
         TswnP+LGJKSYsMevUiB/qZhO6C4Ch0OT2O6JAyAxQ/laC7e6PnSX+YH1/4xr7T4b4UpM
         br22cW0Hgqpe/cA0nOfiixsqHg/ykNuCoo/0mS1kXmoq9OxgqfDGM1bf+dm5jZGI30OV
         FYORzn0ntCBuA/YLhYDA4FGRTziC72WiGJSKLqQkbS/kWLQtRjlgrSTxwafXacbYBWq7
         WfWBLjDn0Gjmzz89RlLjGI6ntRFCjlXA9rtYvxCvUghnS9tMRlprKiTYjBsujOh4J4RS
         Vi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0YgE1ujhzdZA7Dk0idL4tidoEAUBmdOzJLM22gBjBnM=;
        b=DumPiAHd30RK5Uvh4hJ/I0XoPa9Jxxyl9TPzEYUUfB3DUBuGNW80cLGxm4f8US6BHV
         dXcq5ZD9SEK4eF9FYmle5LjEg8I3c1aAuWQDYGpcGSZoMQlS92EhQe8aWgtv4eAT9Ulq
         F3JPMY9aSO/1WjIVnkMfcl++JUH6zEyRJBb0sBEGp4mV1yQ/PBm1DKqtUIjydl6dHOu8
         l/KCjn4qvW7QW2zX5CVSEd81t8yt25sPjwGvEQrZEBNr1B0jPAS05C16axQNVNUrqBFm
         dgvf7g/aGIMcGoxXl5dQN2g38IAU2gbi9aKVaQu4tERauy2N4cxfuovgZhsSseEYygGF
         xzYQ==
X-Gm-Message-State: AOAM533mjmtZPwHwZXpWIqwElZCTSmAp3nqX6QinCi9D/5Dw73oC7N/+
        Qn0csp8VHVvZ/F1lHttHh9tfd3gzQFVOg2yf8Cg=
X-Google-Smtp-Source: ABdhPJygXZx3A1cibNCPgvBPrTbF9meX10wTJ49A38Ps2x34R9vocPkKzjnGQmgjm+F1+F68foA5uG6xXHR57XiPG/A=
X-Received: by 2002:a05:620a:164c:: with SMTP id c12mr16912002qko.343.1590992069584;
 Sun, 31 May 2020 23:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200520232525.798933-1-hannes@cmpxchg.org> <20200520232525.798933-6-hannes@cmpxchg.org>
 <CAAmzW4MMLw=4BHRtt=g8BHpQLTaSmhG03Ct6WMjmDxVnOkNQYA@mail.gmail.com>
 <20200527134333.GF6781@cmpxchg.org> <CAAmzW4NW+cv7VnNApWKJr4r9=QKaufK3y5apyNXo-M-y=q0dgg@mail.gmail.com>
 <20200528170155.GA69521@cmpxchg.org> <CAAmzW4NEPZRWL5PBXEWwg9kBOL9fYUNqTTzh3WRDWbaSPLv=CQ@mail.gmail.com>
 <20200529151228.GA92892@cmpxchg.org>
In-Reply-To: <20200529151228.GA92892@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 1 Jun 2020 15:14:24 +0900
Message-ID: <CAAmzW4Pccc4UcBThhKyqbtY=kK83Fz7k4vYR4eJN4te2E25=_A@mail.gmail.com>
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

2020=EB=85=84 5=EC=9B=94 30=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 12:12, =
Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, May 29, 2020 at 03:48:00PM +0900, Joonsoo Kim wrote:
> > 2020=EB=85=84 5=EC=9B=94 29=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 2:0=
2, Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> > > On Thu, May 28, 2020 at 04:16:50PM +0900, Joonsoo Kim wrote:
> > > > 2020=EB=85=84 5=EC=9B=94 27=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84=
 10:43, Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
> > > > > On Wed, May 27, 2020 at 11:06:47AM +0900, Joonsoo Kim wrote:
> > > *It would require another page flag to tell whether a refaulting cach=
e
> > > page has challenged the anon set once (transitioning) or repeatedly
> > > (thrashing), as we currently use the active state for that. If we
> > > would repurpose PG_workingset to tell the first from the second
> > > refault, we'd need a new flag to mark a page for memstall accounting.
> >
> > I don't understand why a new flag is needed. Whenever we found that
> > challenge is needed (dist < active + anon), we need to add up IO cost.
>
> It sounds like this was cleared up later on in the email.
>
> > > > It could cause thrashing for your patch.
> > > > Without the patch, current logic try to
> > > > find most hottest file pages that are fit into the current file lis=
t
> > > > size and protect them
> > > > successfully. Assume that access distance of 50 MB hot file pages i=
s 60 MB
> > > > which is less than whole file list size but larger than inactive li=
st
> > > > size. Without
> > > > your patch, 50 MB (hot) pages are not evicted at all. All these hot
> > > > pages will be
> > > > protected from the 100MB low access frequency pages. 100 MB low acc=
ess
> > > > frequency pages will be refaulted repeatedely but it's correct beha=
viour.
> > >
> > > Hm, something doesn't quite add up. Why is the 50M hot set evicted
> > > with my patch?
> >
> > Thanks for kind explanation. I read all and I found that I was confused=
 before.
> > Please let me correct the example.
> >
> > Environment:
> > anon: 500 MB (hot) / 500 MB (hot)
> > file: 50 MB (so hot) / 50 MB (dummy)
> >
> > I will call 50 MB file hot pages as F(H).
> > Let's assume that periodical access to other file (500 MB) is started. =
That
> > file consists of 5 parts and each one is 100 MB. I will call it P1, P2,=
 ..., P5.
> >
> > Problem will occur on following access pattern.
> >
> > F(H) -> P1 -> F(H) -> P2 -> ... -> F(H) -> P5 -> F(H) -> P1 -> ...
> >
> > With this access pattern, access distance of F(H) and Pn is:
> >
> > F(H) =3D 150 MB
> > Pn =3D 750 MB
> >
> > Without your patch, F(H) is kept on the memory since deactivation would=
 not
> > happen. However, with your patch, deactivation happens since Pn's refau=
lt
> > distance is less than 'active file + anon'. In the end, F(H) would be f=
inally
> > evicted.
>
> Okay, this example makes sense to me.
>
> I do think P needs to challenge the workingset - at first. P could
> easily fit into memory by itself if anon and active_file were cold, so
> we need to challenge them to find out that they're hot. As you can
> see, if anon and F(H) were completely unused, the current behavior
> would be incorrect.
>
> The current behavior would do the same in a cache-only example:
>
>         anon =3D 1G (unreclaimable)
>         file =3D 500M (hot) / 300M (dummy)
>
>         P =3D 400M
>
>         F(H) -> P1 -> F(H) -> P2 ...
>
> If F(H) is already active, the first P refaults would have a distance
> of 100M, thereby challenging F(H). As F(H) reactivates, its size will
> be reflected in the refault distances, pushing them beyond the size of
> memory that is available to the cache: 600M refault distance > 500M
> active cache, or 900M access distance > 800M cache space.

Hmm... It seems that the current behavior (before your patch) for this
example has no problem. It causes deactivation but doesn't cause eviction
so there is no workingset thrashing.

> However, I agree with your observation about the anon age below. When
> we start aging the anon set, we have to reflect that in the refault
> distances. Once we know that the 1G anon pages are indeed hotter than
> the pages in P, there is no reason to keep churning the workingset.

Okay.

> > > The only way they could get reclaimed is if their access distance end=
s
> > > up bigger than the file cache. But if that's the case, then the
> > > workingset is overcommitted, and none of the pages qualify for reclai=
m
> > > protection. Picking a subset to protect against the rest is arbitrary=
.
> >
> > In the fixed example, although other file (500 MB) is repeatedly access=
ed,
> > it's not workingset. If we have unified list (file + anon), access dist=
ance of
> > Pn will be larger than whole memory size. Therefore, it's not overcommi=
tted
> > workingset and this patch wrongly try to activate it. As I said before,
> > without considering inactive_age for anon list, this calculation can no=
t be
> > correct.
>
> You're right. If we don't take anon age into account, the activations
> could be over-eager; however, so would counting IO cost and exerting
> pressure on anon be, which means my previous patch to split these two
> wouldn't fix fundamental the problem you're pointing out. We simply

Splitting would not fix the fundamental problem (over-eager) but it would
greatly weaken the problem. Just counting IO cost doesn't break the
active/inactive separation in file list. It does cause more scan on anon li=
st
but I think that it's endurable.

> have to take anon age into account for the refaults to be comparable.

Yes, taking anon age into account is also a good candidate to fix the probl=
em.

> Once we do that, in your example, we would see activations in the
> beginning in order to challenge the combined workingset (active_file +
> anon) - which is legitimate as long as we don't know it's hot. And as
> the anon pages are scanned and rotated (and the challenged F(h)
> reactivated), the refault distances increase accordingly to reflect
> the size of the hot pages sampled, which will correctly put P's
> distances beyond the size of available memory.

Okay.

> However, your example cannot have a completely silent stable state. As
> we stop workingset aging, the refault distances will slowly increase
> again. We will always have a bit of churn, and rightfully so, because
> the workingset *could* go stale.
>
> That's the same situation in my cache-only example above. Anytime you
> have a subset of pages that by itself could fit into memory, but can't
> because of an established workingset, ongoing sampling is necessary.
>
> But the rate definitely needs to reduce as we detect that in-memory
> pages are indeed hot. Otherwise we cause more churn than is required
> for an appropriate rate of workingset sampling.
>
> How about the patch below? It looks correct, but I will have to re-run
> my tests to make sure I / we are not missing anything.

Much better! It may solve my concern mostly.

But, I still think that modified refault activation equation isn't
safe. The next
problem I found is related to the scan ratio limit patch ("limit the range =
of
LRU type balancing") on this series. See the below example.

anon: Hot (X M)
file: Hot (200 M) / dummy (200 M)
P: 1200 M (3 parts, each one 400 M, P1, P2, P3)
Access Pattern: A -> F(H) -> P1 -> A -> F(H) -> P2 -> ... ->

Without this patch, A and F(H) are kept on the memory and look like
it's correct.

With this patch and below fix, refault equation for Pn would be:

Refault dist of Pn =3D 1200 (from file non-resident) + 1200 * anon scan
ratio (from anon non-resident)
anon + active file =3D X + 200
1200 + 1200 * anon scan ratio (0.5 ~ 2) < X + 200

According to the size of X, Pn's refault result would be different. Pn coul=
d
be activated with large enough X and then F(H) could be evicted. In ideal
case (unified list), for this example, Pn should not be activated in any X.

This is a fundamental problem since we have two list type (file/anon) and
scan ratio limit is required. Anyway, we need to take care of this reality =
and
the way most safe is to count IO cost instead of doing activation in this
'non-resident dist < (active + anon list)' case.

Again, for this patch, I'm not confident myself so please let me know if I'=
m
wrong.

Thanks.
