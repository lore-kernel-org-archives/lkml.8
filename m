Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14EAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 05:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD8D2072F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 05:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxwRIyfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgFCFku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 01:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCFku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 01:40:50 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCECC05BD43
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 22:40:48 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id q14so1061029qtr.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 22:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BGjC9hEQA1RR/riJGwSmJT9ELHQ3fhF1Tg4h6hxErB8=;
        b=RxwRIyfDNLvjYG+kEHCJcCiHEf2SAfoDGWZHb18yU/XycrDCxTGWC1FGHfOv63oioc
         depbopH7hI+U+cdOLFdEOAQ7pi84ZfaJD80GDS25Q7t+4cvHeCO/95lSGN0/eC6bGkj2
         xJaJiPI4AOh07/pM3Q9dn3y8bxc+5zf6kN/CGWEr2af4Yyo8Nd8vMj5JNXbx+sUtsuBR
         yvGWG8/3HBJkLC7jqK0qlBje1xaGZaOBCSxoFEOd94kxmNtp55SfBQoGRu9MlSWGwDkV
         5LSmBI0ylJ4QgzOQnRIIecDC4oRNOn5MVQGnfRFCUGRovDIPhdwLd74SXkk/VA5JQ4pY
         O14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BGjC9hEQA1RR/riJGwSmJT9ELHQ3fhF1Tg4h6hxErB8=;
        b=nHzaCwJCU3cD/0ThlExammgmekUCk1Wz1XOTdI76pzr1fo+ntQMl1olPCcVgzo7sbQ
         8qW9Y6fTlMKOk37chmhGIxeqnjmzGKWC4KhZJJePYUE5yDiYBkMrvrqKiIJA7vjLuq2h
         Xw1XCY8yp1Ee3DQAU/Ni5y7W5WnPy0dWyh5EMRnVoVQnyrmkBJwgsG28HqM3wrsD2Vfm
         XCIRyBvwaFYTs01uSglcV4Fgs347+WTwi+ogAODLfqssQTyNl0u7Q5ziEko9kr17K9HK
         Wue7v0Bs2b9tkCaghRadGeTzZaLJzLR3QDTyXMjTvoP2tbN+29xnfr4d3qtBXybOnoPz
         X4mQ==
X-Gm-Message-State: AOAM533isPCT4r3a4zYKNztQVoPJ+/Mcavks/ba9NZmPhqVMQ+ntJeu1
        agWNlrR9NuluI7DBUPQi+WbDf/dfHX8uZTJR6Qg=
X-Google-Smtp-Source: ABdhPJyWDX1lz6zBSzm27sfpv5XtJ+G6/lhPGhhnMNgZ//wPrXSdNqyKz9wWjZYbM1c3fufK8HFN/2gHAIBqvsXsIxU=
X-Received: by 2002:ac8:44da:: with SMTP id b26mr31368255qto.232.1591162847600;
 Tue, 02 Jun 2020 22:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200520232525.798933-6-hannes@cmpxchg.org> <CAAmzW4MMLw=4BHRtt=g8BHpQLTaSmhG03Ct6WMjmDxVnOkNQYA@mail.gmail.com>
 <20200527134333.GF6781@cmpxchg.org> <CAAmzW4NW+cv7VnNApWKJr4r9=QKaufK3y5apyNXo-M-y=q0dgg@mail.gmail.com>
 <20200528170155.GA69521@cmpxchg.org> <CAAmzW4NEPZRWL5PBXEWwg9kBOL9fYUNqTTzh3WRDWbaSPLv=CQ@mail.gmail.com>
 <20200529151228.GA92892@cmpxchg.org> <CAAmzW4Pccc4UcBThhKyqbtY=kK83Fz7k4vYR4eJN4te2E25=_A@mail.gmail.com>
 <20200601155615.GA131075@cmpxchg.org> <CAAmzW4NDVznjOsW1Vgg1P+0vSQarE1ziY=MN5S5f70pQiOPn-Q@mail.gmail.com>
 <20200602164726.GA225032@cmpxchg.org>
In-Reply-To: <20200602164726.GA225032@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 3 Jun 2020 14:40:40 +0900
Message-ID: <CAAmzW4P0HZw-K1jHogpCevDCfsSfm2SRSXYwUqznoDBNWa_NUQ@mail.gmail.com>
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

2020=EB=85=84 6=EC=9B=94 3=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 1:48, Jo=
hannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Jun 02, 2020 at 11:34:17AM +0900, Joonsoo Kim wrote:
> > 2020=EB=85=84 6=EC=9B=94 2=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 12:5=
6, Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> > > On Mon, Jun 01, 2020 at 03:14:24PM +0900, Joonsoo Kim wrote:
> > > > But, I still think that modified refault activation equation isn't
> > > > safe. The next
> > > > problem I found is related to the scan ratio limit patch ("limit th=
e range of
> > > > LRU type balancing") on this series. See the below example.
> > > >
> > > > anon: Hot (X M)
> > > > file: Hot (200 M) / dummy (200 M)
> > > > P: 1200 M (3 parts, each one 400 M, P1, P2, P3)
> > > > Access Pattern: A -> F(H) -> P1 -> A -> F(H) -> P2 -> ... ->
> > > >
> > > > Without this patch, A and F(H) are kept on the memory and look like
> > > > it's correct.
> > > >
> > > > With this patch and below fix, refault equation for Pn would be:
> > > >
> > > > Refault dist of Pn =3D 1200 (from file non-resident) + 1200 * anon =
scan
> > > > ratio (from anon non-resident)
> > > > anon + active file =3D X + 200
> > > > 1200 + 1200 * anon scan ratio (0.5 ~ 2) < X + 200
> > >
> > > That doesn't look quite right to me. The anon part of the refault
> > > distance is driven by X, so the left-hand of this formula contains X
> > > as well.
> > >
> > > 1000 file (1200M reuse distance, 200M in-core size) + F(H) reactivati=
ons + X * scan ratio < X + 1000
> >
> > As I said before, there is no X on left-hand of this formula. To
> > access all Pn and
> > re-access P1, we need 1200M file list scan and reclaim. More scan isn't=
 needed.
> > With your patch "limit the range of LRU type balancing", scan ratio
> > between file/anon
> > list is limited to 0.5 ~ 2.0, so, maximum anon scan would be 1200 M *
> > 2.0, that is,
> > 2400 M and not bounded by X. That means that file list cannot be
> > stable with some X.
>
> Oh, no X on the left because you're talking about the number of pages
> scanned until the first refaults, which is fixed - so why are we still
> interpreting the refault distance against a variable anon size X?

Looks like I was confused again. Your formula is correct and mine is
wrong. My mistake is I thought that your patch "limit the range of LRU
type balancing"
which makes scan *ratio* 2:1 leads to actual scan *count* ratio
between anon/file to 2:1.
But, now I realized that 2:1 is just scan ratio and actual scan
*count* ratio could be far
larger with certain list size. It would be X * scan ratio in above example =
so my
explanation is wrong and you are right.

Sorry for making a trouble.

> Well, that's misleading. We compare against anon because part of the
> cache is already encoded in the refault distance. What we're really
> checking is access distance against total amount of available RAM.
>
> Consider this. We want to activate pages where
>
>         access_distance <=3D RAM
>
> and our measure of access distance is:
>
>         access_distance =3D refault_distance + inactive_file
>
> So the comparison becomes:
>
>         refault_distance + inactive_file < RAM
>
> which we simplify to:
>
>         refault_distance < active_file + anon
>
> There is a certain threshold for X simply because there is a certain
> threshold for RAM beyond which we need to start activating. X cannot
> be arbitrary, it must be X + cache filling up memory - after all we
> have page reclaim evicting pages.
>
> Again, this isn't new. In the current code, we activate when:
>
>         refault_distance < active_file
>
> which is
>
>         access_distance <=3D RAM - anon
>
> You can see, whether things are stable or not always depends on the
> existing workingset size. It's just a proxy for how much total RAM we
> have potentially available to the refaulting page.
>
> > If my lastly found example is a correct example (your confirm is requir=
ed),
> > it is also related to the correctness issue since cold pages causes
> > eviction of the hot pages repeatedly.
>
> I think your example is correct, but it benefits from the VM
> arbitrarily making an assumption that has a 50/50 shot of being true.
>
> You and I know which pages are hot and which are cold because you
> designed the example.
>
> All the VM sees is this:
>
> - We have an established workingset that has previously shown an
>   access distance <=3D RAM and therefor was activated.
>
> - We now have another set that also appears to have an access distance
>   <=3D RAM. The only way to know for sure, however, is sample the
>   established workingset and compare the relative access frequencies.
>
> Currently, we just assume the incoming pages are colder. Clearly
> that's beneficial when it's true. Clearly that can be totally wrong.
>
> We must allow a fair comparison between these two sets.
>
> For cache, that's already the case - that's why I brought up the
> cache-only example: if refault distances are 50M and you have 60M of
> active cache, we activate all refaults and force an even competition
> between the established workingset and the new pages.
>
> Whether we can protect active file when anon needs to shrink first and
> can't (the activate/iocost split) that's a different question. But I'm
> no longer so sure after looking into it further.
>
> First, we would need two different refault distances: either we
> consider anon age and need to compare to active_file + anon, or we
> don't and compare to active_file only. We cannot mix willy nilly,
> because the metrics wouldn't be comparable. We don't have the space to
> store two different eviction timestamps, nor could we afford to cut
> the precision in half.
>
> Second, the additional page flag required to implement it.
>
> Third, it's somewhat moot because we still have the same behavior when
> active_file would need to shrink and can't. There can't be a stable
> state as long as refault distances <=3D active_file.
>
> > In this case, they (without patch, with patch) all have some correctnes=
s
> > issue so we need to judge which one is better in terms of overall impac=
t.
> > I don't have strong opinion about it so it's up to you to decide the wa=
y to go.
>
> If my patch was simply changing the default assumption on which pages
> are hot and which are cold, I would agree with you - the pros would be
> equal to the cons, one way wouldn't be more correct than the other.
>
> But that isn't what my patch is doing. What it does is get rid of the
> assumption, to actually sample and compare the access frequencies when
> there isn't enough data to make an informed decision.
>
> That's a net improvement.

Okay. Now I think that this patch has a net improvement.

Acked-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Thanks.
