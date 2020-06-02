Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AE5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F18207D5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="iXfuwD/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgFBQsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBQsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:48:01 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251D0C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 09:48:01 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i16so4528988qtr.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 09:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yfHwoHEEV5QL/aPzxV6Lxt7b4KjqGfFRukmk4UWU4Eo=;
        b=iXfuwD/1eJMbgoibB0GhywAuIPYFweGOJWelKhOAL0/I9vM5xGnRGzX6FzWLb98DKC
         jNxNWkwac7/q27BL7HiSxewrHmRkel4MeEDY5UaCN1B7pVYZ69r3TwyFkpc3UpKm1DUh
         z9Dd9qrJHboOvjbUj2iXohU4nGSSQHQS72BbDx4aA3oA1EmwJfAen+iWl7L9edrUPTtQ
         iAMmcDcaHZMDdWwcMdwdYQN/ZuQXmvWVBgfJbT5k+NuaL8Tmsc021adF2NxttOIghuL8
         hQrT7ZvA4oxMSzRJ45QEtqya0KxYSfi7twccFGzk4m3hldkG2L2JMpNchWNsQQ/F90oo
         H/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yfHwoHEEV5QL/aPzxV6Lxt7b4KjqGfFRukmk4UWU4Eo=;
        b=Qc728XL6YnYUvn+Ddl+zv7sFU9gI/jPjuMqVb/1Nfh11j4wNZJPUSMBQVovy60ofjQ
         8M0/kSOF2RO5du3r6KTiVtw3bBO+LrmQbLExK+nK10r93qmcHXskJ7//yARcSuMQXgbc
         B5gysq++ofvJmSApxmfsE8a4be0VNICVCQBj3sPN4iKZ9JqYjiGryScIaPqkzuig7mcD
         ovKn3ZaXJxsqxgvkYka6Z437CbxmKRqRcviGYtQB7AMeTG8nxuQee4/br2fTNVozBasb
         82PMXlL4OenaxDF3dnJ9PBWIa9/q98RZifU2TSH0ilFYnoyM+woMnNic78MZHtvOJqmG
         cxCg==
X-Gm-Message-State: AOAM532ZC0F27wnHNdTEKcn5+D4SK6ZHs2auT84by28BHx6383iwBm51
        Ko3iPnfrR1RNC1xtXv5bGzgkSQ==
X-Google-Smtp-Source: ABdhPJwBUSMRhMSr3A93/eStB3AVK2wrSHs6QWoxrCs8SnoVfB8Brx+0QRrCn3tM5ktj3rbTD6rrlQ==
X-Received: by 2002:ac8:2c57:: with SMTP id e23mr19758537qta.231.1591116480146;
        Tue, 02 Jun 2020 09:48:00 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a7d7])
        by smtp.gmail.com with ESMTPSA id a188sm2757826qkg.11.2020.06.02.09.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 09:47:59 -0700 (PDT)
Date:   Tue, 2 Jun 2020 12:47:26 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH 05/14] mm: workingset: let cache workingset challenge anon
Message-ID: <20200602164726.GA225032@cmpxchg.org>
References: <20200520232525.798933-6-hannes@cmpxchg.org>
 <CAAmzW4MMLw=4BHRtt=g8BHpQLTaSmhG03Ct6WMjmDxVnOkNQYA@mail.gmail.com>
 <20200527134333.GF6781@cmpxchg.org>
 <CAAmzW4NW+cv7VnNApWKJr4r9=QKaufK3y5apyNXo-M-y=q0dgg@mail.gmail.com>
 <20200528170155.GA69521@cmpxchg.org>
 <CAAmzW4NEPZRWL5PBXEWwg9kBOL9fYUNqTTzh3WRDWbaSPLv=CQ@mail.gmail.com>
 <20200529151228.GA92892@cmpxchg.org>
 <CAAmzW4Pccc4UcBThhKyqbtY=kK83Fz7k4vYR4eJN4te2E25=_A@mail.gmail.com>
 <20200601155615.GA131075@cmpxchg.org>
 <CAAmzW4NDVznjOsW1Vgg1P+0vSQarE1ziY=MN5S5f70pQiOPn-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4NDVznjOsW1Vgg1P+0vSQarE1ziY=MN5S5f70pQiOPn-Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 11:34:17AM +0900, Joonsoo Kim wrote:
> 2020년 6월 2일 (화) 오전 12:56, Johannes Weiner <hannes@cmpxchg.org>님이 작성:
> > On Mon, Jun 01, 2020 at 03:14:24PM +0900, Joonsoo Kim wrote:
> > > But, I still think that modified refault activation equation isn't
> > > safe. The next
> > > problem I found is related to the scan ratio limit patch ("limit the range of
> > > LRU type balancing") on this series. See the below example.
> > >
> > > anon: Hot (X M)
> > > file: Hot (200 M) / dummy (200 M)
> > > P: 1200 M (3 parts, each one 400 M, P1, P2, P3)
> > > Access Pattern: A -> F(H) -> P1 -> A -> F(H) -> P2 -> ... ->
> > >
> > > Without this patch, A and F(H) are kept on the memory and look like
> > > it's correct.
> > >
> > > With this patch and below fix, refault equation for Pn would be:
> > >
> > > Refault dist of Pn = 1200 (from file non-resident) + 1200 * anon scan
> > > ratio (from anon non-resident)
> > > anon + active file = X + 200
> > > 1200 + 1200 * anon scan ratio (0.5 ~ 2) < X + 200
> >
> > That doesn't look quite right to me. The anon part of the refault
> > distance is driven by X, so the left-hand of this formula contains X
> > as well.
> >
> > 1000 file (1200M reuse distance, 200M in-core size) + F(H) reactivations + X * scan ratio < X + 1000
> 
> As I said before, there is no X on left-hand of this formula. To
> access all Pn and
> re-access P1, we need 1200M file list scan and reclaim. More scan isn't needed.
> With your patch "limit the range of LRU type balancing", scan ratio
> between file/anon
> list is limited to 0.5 ~ 2.0, so, maximum anon scan would be 1200 M *
> 2.0, that is,
> 2400 M and not bounded by X. That means that file list cannot be
> stable with some X.

Oh, no X on the left because you're talking about the number of pages
scanned until the first refaults, which is fixed - so why are we still
interpreting the refault distance against a variable anon size X?

Well, that's misleading. We compare against anon because part of the
cache is already encoded in the refault distance. What we're really
checking is access distance against total amount of available RAM.

Consider this. We want to activate pages where

	access_distance <= RAM

and our measure of access distance is:

	access_distance = refault_distance + inactive_file

So the comparison becomes:

	refault_distance + inactive_file < RAM

which we simplify to:

	refault_distance < active_file + anon

There is a certain threshold for X simply because there is a certain
threshold for RAM beyond which we need to start activating. X cannot
be arbitrary, it must be X + cache filling up memory - after all we
have page reclaim evicting pages.

Again, this isn't new. In the current code, we activate when:

	refault_distance < active_file

which is

	access_distance <= RAM - anon

You can see, whether things are stable or not always depends on the
existing workingset size. It's just a proxy for how much total RAM we
have potentially available to the refaulting page.

> If my lastly found example is a correct example (your confirm is required),
> it is also related to the correctness issue since cold pages causes
> eviction of the hot pages repeatedly.

I think your example is correct, but it benefits from the VM
arbitrarily making an assumption that has a 50/50 shot of being true.

You and I know which pages are hot and which are cold because you
designed the example.

All the VM sees is this:

- We have an established workingset that has previously shown an
  access distance <= RAM and therefor was activated.

- We now have another set that also appears to have an access distance
  <= RAM. The only way to know for sure, however, is sample the
  established workingset and compare the relative access frequencies.

Currently, we just assume the incoming pages are colder. Clearly
that's beneficial when it's true. Clearly that can be totally wrong.

We must allow a fair comparison between these two sets.

For cache, that's already the case - that's why I brought up the
cache-only example: if refault distances are 50M and you have 60M of
active cache, we activate all refaults and force an even competition
between the established workingset and the new pages.

Whether we can protect active file when anon needs to shrink first and
can't (the activate/iocost split) that's a different question. But I'm
no longer so sure after looking into it further.

First, we would need two different refault distances: either we
consider anon age and need to compare to active_file + anon, or we
don't and compare to active_file only. We cannot mix willy nilly,
because the metrics wouldn't be comparable. We don't have the space to
store two different eviction timestamps, nor could we afford to cut
the precision in half.

Second, the additional page flag required to implement it.

Third, it's somewhat moot because we still have the same behavior when
active_file would need to shrink and can't. There can't be a stable
state as long as refault distances <= active_file.

> In this case, they (without patch, with patch) all have some correctness
> issue so we need to judge which one is better in terms of overall impact.
> I don't have strong opinion about it so it's up to you to decide the way to go.

If my patch was simply changing the default assumption on which pages
are hot and which are cold, I would agree with you - the pros would be
equal to the cons, one way wouldn't be more correct than the other.

But that isn't what my patch is doing. What it does is get rid of the
assumption, to actually sample and compare the access frequencies when
there isn't enough data to make an informed decision.

That's a net improvement.
