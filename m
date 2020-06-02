Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EABBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 02:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0BCB206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 02:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFKWs76d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgFBCeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 22:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgFBCeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 22:34:23 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406D7C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 19:34:23 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g28so10459642qkl.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 19:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WIV812zXdt1sSNO21HBL8cR2iY4avQ4bfEsobtUNfCM=;
        b=cFKWs76db7QYS3TDdaWNc4V2cCDKOVhKW6Mya5Z6lI0jqEdEbjKD7MCzoE6a6qp8cT
         nGSlPo+VgqvwNLi5iJ/+oAmtnBl1D8aMVa1vZsXhB+OwPVk6B60yA3cP4QCgFVzUcdxC
         p9zeA6Hm2sPP/EmLCupJj0dPHow+inE7kLTsnO5CqWSSKxejDWH5mdlSAb1Fda8oB90H
         Zb44vhn9fSWPdzVwsNEic+sU13jS/9XZvNPJ7zq8X5bsDJlX9HTBM8PRH8k0GuO2tG0i
         TPB5rmgr6CgE07F/4Vs4/EGjTD0J/WvsgWRZwlqGCfOv6AmyJGGa68hWiUaaZIPaAGVq
         jPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WIV812zXdt1sSNO21HBL8cR2iY4avQ4bfEsobtUNfCM=;
        b=q2c0H7rKI/TBUsZ/TZP5bTXcEITp6/abmviswSDeKWHPdjZLDFUqX+R/tdzzeluedX
         ttJmI+hgRAZ8B7tk9GSLtI1p2rs2T5a7UodeQ249wjwGLMzP/mdRiJUPXIJAxUQa+Z3A
         FCCb8rYiMHyYQjcPPWkehOxdAI2W+dcwKPxAbHH5ezLtsOPBHphOUgt2L5JDuhMOySW/
         vIdNm+RVy9nwO/7KJo6Z/4wggsfS/az85VnR3JRRh3tUwNmMwUO3hfNwzgcjWMTTiZ1o
         fu4q5ErCWiie7lq/HKajG+UCU524ic0Rq9t1Ao/FZbvkjjoo6lTHOtTxwt0RsOdkxCBT
         Mzfg==
X-Gm-Message-State: AOAM533eQ4laRyQp/FLXXQfC018DdfEHPLTtPyOxQRVxBI6+Agb0Sl1c
        xgbRWv7iCiF6d11viaHOkPcpSd53ngQgg/1BytI=
X-Google-Smtp-Source: ABdhPJw9+5hNfnvvSMNcTloFXeduRgAnxY7dVQ+MrEu5zMcyrl36HQroBoKPx8+xID0m7vPttHPDe7pPHxF6rMuRI/Q=
X-Received: by 2002:a05:620a:164c:: with SMTP id c12mr20956489qko.343.1591065262176;
 Mon, 01 Jun 2020 19:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200520232525.798933-1-hannes@cmpxchg.org> <20200520232525.798933-6-hannes@cmpxchg.org>
 <CAAmzW4MMLw=4BHRtt=g8BHpQLTaSmhG03Ct6WMjmDxVnOkNQYA@mail.gmail.com>
 <20200527134333.GF6781@cmpxchg.org> <CAAmzW4NW+cv7VnNApWKJr4r9=QKaufK3y5apyNXo-M-y=q0dgg@mail.gmail.com>
 <20200528170155.GA69521@cmpxchg.org> <CAAmzW4NEPZRWL5PBXEWwg9kBOL9fYUNqTTzh3WRDWbaSPLv=CQ@mail.gmail.com>
 <20200529151228.GA92892@cmpxchg.org> <CAAmzW4Pccc4UcBThhKyqbtY=kK83Fz7k4vYR4eJN4te2E25=_A@mail.gmail.com>
 <20200601155615.GA131075@cmpxchg.org>
In-Reply-To: <20200601155615.GA131075@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Tue, 2 Jun 2020 11:34:17 +0900
Message-ID: <CAAmzW4NDVznjOsW1Vgg1P+0vSQarE1ziY=MN5S5f70pQiOPn-Q@mail.gmail.com>
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

2020=EB=85=84 6=EC=9B=94 2=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 12:56, J=
ohannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, Jun 01, 2020 at 03:14:24PM +0900, Joonsoo Kim wrote:
> > 2020=EB=85=84 5=EC=9B=94 30=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 12:=
12, Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> > >
> > > On Fri, May 29, 2020 at 03:48:00PM +0900, Joonsoo Kim wrote:
> > > > 2020=EB=85=84 5=EC=9B=94 29=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84=
 2:02, Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
> > > > > On Thu, May 28, 2020 at 04:16:50PM +0900, Joonsoo Kim wrote:
> > > > > > 2020=EB=85=84 5=EC=9B=94 27=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=
=9B=84 10:43, Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=
=91=EC=84=B1:
> > > > > > > On Wed, May 27, 2020 at 11:06:47AM +0900, Joonsoo Kim wrote:
> > > > > The only way they could get reclaimed is if their access distance=
 ends
> > > > > up bigger than the file cache. But if that's the case, then the
> > > > > workingset is overcommitted, and none of the pages qualify for re=
claim
> > > > > protection. Picking a subset to protect against the rest is arbit=
rary.
> > > >
> > > > In the fixed example, although other file (500 MB) is repeatedly ac=
cessed,
> > > > it's not workingset. If we have unified list (file + anon), access =
distance of
> > > > Pn will be larger than whole memory size. Therefore, it's not overc=
ommitted
> > > > workingset and this patch wrongly try to activate it. As I said bef=
ore,
> > > > without considering inactive_age for anon list, this calculation ca=
n not be
> > > > correct.
> > >
> > > You're right. If we don't take anon age into account, the activations
> > > could be over-eager; however, so would counting IO cost and exerting
> > > pressure on anon be, which means my previous patch to split these two
> > > wouldn't fix fundamental the problem you're pointing out. We simply
> >
> > Splitting would not fix the fundamental problem (over-eager) but it wou=
ld
> > greatly weaken the problem. Just counting IO cost doesn't break the
> > active/inactive separation in file list. It does cause more scan on ano=
n list
> > but I think that it's endurable.
>
> I think the split is a good idea.
>
> The only thing I'm not sure yet is if we can get away without an
> additional page flag if the active flag cannot be reused to denote
> thrashing. I'll keep at it, maybe I can figure something out.
>
> But I think it would be follow-up work.
>
> > > have to take anon age into account for the refaults to be comparable.
> >
> > Yes, taking anon age into account is also a good candidate to fix the p=
roblem.
>
> Okay, good.
>
> > > However, your example cannot have a completely silent stable state. A=
s
> > > we stop workingset aging, the refault distances will slowly increase
> > > again. We will always have a bit of churn, and rightfully so, because
> > > the workingset *could* go stale.
> > >
> > > That's the same situation in my cache-only example above. Anytime you
> > > have a subset of pages that by itself could fit into memory, but can'=
t
> > > because of an established workingset, ongoing sampling is necessary.
> > >
> > > But the rate definitely needs to reduce as we detect that in-memory
> > > pages are indeed hot. Otherwise we cause more churn than is required
> > > for an appropriate rate of workingset sampling.
> > >
> > > How about the patch below? It looks correct, but I will have to re-ru=
n
> > > my tests to make sure I / we are not missing anything.
> >
> > Much better! It may solve my concern mostly.
>
> Okay thanks for confirming. I'll send a proper version to Andrew.

Okay.

> > But, I still think that modified refault activation equation isn't
> > safe. The next
> > problem I found is related to the scan ratio limit patch ("limit the ra=
nge of
> > LRU type balancing") on this series. See the below example.
> >
> > anon: Hot (X M)
> > file: Hot (200 M) / dummy (200 M)
> > P: 1200 M (3 parts, each one 400 M, P1, P2, P3)
> > Access Pattern: A -> F(H) -> P1 -> A -> F(H) -> P2 -> ... ->
> >
> > Without this patch, A and F(H) are kept on the memory and look like
> > it's correct.
> >
> > With this patch and below fix, refault equation for Pn would be:
> >
> > Refault dist of Pn =3D 1200 (from file non-resident) + 1200 * anon scan
> > ratio (from anon non-resident)
> > anon + active file =3D X + 200
> > 1200 + 1200 * anon scan ratio (0.5 ~ 2) < X + 200
>
> That doesn't look quite right to me. The anon part of the refault
> distance is driven by X, so the left-hand of this formula contains X
> as well.
>
> 1000 file (1200M reuse distance, 200M in-core size) + F(H) reactivations =
+ X * scan ratio < X + 1000

As I said before, there is no X on left-hand of this formula. To
access all Pn and
re-access P1, we need 1200M file list scan and reclaim. More scan isn't nee=
ded.
With your patch "limit the range of LRU type balancing", scan ratio
between file/anon
list is limited to 0.5 ~ 2.0, so, maximum anon scan would be 1200 M *
2.0, that is,
2400 M and not bounded by X. That means that file list cannot be
stable with some X.

> Activations persist as long as anon isn't fully scanned and it isn't
> established yet that it's fully hot. Meaning, we optimistically assume
> the refaulting pages can be workingset until we're proven wrong.
>
> > According to the size of X, Pn's refault result would be different. Pn =
could
> > be activated with large enough X and then F(H) could be evicted. In ide=
al
> > case (unified list), for this example, Pn should not be activated in an=
y X.
>
> Yes. The active/iocost split would allow us to be smarter about it.
>
> > This is a fundamental problem since we have two list type (file/anon) a=
nd
> > scan ratio limit is required. Anyway, we need to take care of this real=
ity and
> > the way most safe is to count IO cost instead of doing activation in th=
is
> > 'non-resident dist < (active + anon list)' case.
>
> Agreed here again.
>
> > Again, for this patch, I'm not confident myself so please let me know i=
f I'm
> > wrong.
>
> As far as this patch goes, I think it's important to look at the
> bigger picture.
>
> We need to have convergence first before being able to worry about
> optimizing. Stable states are optimizations, but false stable states
> are correctness problems.
>
> For the longest time, we scanned active pages unconditionally during
> page reclaim. This was always safe in the sense that it wouldn't get
> stuck on a stale workingset, but it incurs unnecessary workingset
> churn when reclaim is driven by use-once patterns.
>
> We optimized the latter too aggressively, and as a result caused
> situations where we indefinitely fail to cache the hottest
> data. That's not really a workable trade-off.
>
> With the active/iocost split you're suggesting, we can reasonably
> optimize your example scenario. But we can't do it if the flipside
> means complete failure to transition between in-memory sets.
>
> So I think we should go ahead with this patch (with the anon age
> recognition fixed, because that's a correctness issue), and follow it
> up with the stable state optimization to shrink anon first.

If my lastly found example is a correct example (your confirm is required),
it is also related to the correctness issue since cold pages causes
eviction of the hot pages repeatedly.

In this case, they (without patch, with patch) all have some correctness
issue so we need to judge which one is better in terms of overall impact.
I don't have strong opinion about it so it's up to you to decide the way to=
 go.

Thanks.
