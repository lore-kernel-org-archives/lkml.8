Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B206C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5297720738
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="HKghj+So"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgFAP4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgFAP4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:56:49 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299CFC05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 08:56:48 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f18so9549203qkh.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 08:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=S8Qvy+/UE9YUsxgqFdhQ9/Oks0dEcBg3u0ktuSB1aWQ=;
        b=HKghj+SoRXku+7iNGt3tonDA2yUKOrwEGfoGCl2h1CSqMx7rfRKQRinLQQOnABCvFj
         GKZzX1yDugQuVj4idGs/6sRfXP14CktFckDGTm4xYUqucKsXpUcEb+fMCixFBk6VL7yS
         /BhxLIey46Kfmg8nuW0cophr0n5IemIAOvEosUTFaf07FNBNL4jibYEl6MCKTk3dIlSs
         VxbHNMwWpihiEHxX2Aqorug9uDtNstX7ySL1xsC7wjTVR1AzXhLyBtjPBpXuCto5Nw5w
         JkKxWU+kfeoicifgwCbj8B1NomFJAFFn9mBK/fxPT67MZ4kkEapJgrmVksmy1JhZ7zx7
         2hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=S8Qvy+/UE9YUsxgqFdhQ9/Oks0dEcBg3u0ktuSB1aWQ=;
        b=tNTX0jgIbt0djOzzyLB0i7qSo2pr94C+SbCo7eV7dUgSzLQmoGP477B+lvJzaB4Mza
         GoI1Tq7b5h7yVGL26T0vwIqdAFLSdzdnxBsnU9KVwzfZ7adaTaQadsainhoZ/QFIdIF8
         FtZlxfv9G4FgXCrHteEFTRS6DrfaOXluXy97y4ebVvJYZJW2nqZ0snNFzIvrp4Hm9kdw
         /g7f4pQrwoUODp05boGBBpELEQ33wHA9TdfOGhcevI49GpyGBw3p32nIvLtuBWZRUnYh
         plKQtxQdE920N4PFrjKEVBD+Ls3ubkx5fT7o+Zh7icgaaPWlGNy0zBzkZpw9Ppv2PYcI
         s9QA==
X-Gm-Message-State: AOAM531QhRXI5t4ucqkKl+rzP7h4/wPFFocHnqWLBkGxAhmpWzSvOLvX
        k2IIorbxnHeuiS9BPKZrB6j4Wg==
X-Google-Smtp-Source: ABdhPJyPcOk7Pk8cRbO8oW58+QzceCI/0v8VQvUZVlfcX1wsNn/dDGgYF706DM4fb4f4yi6woF3gpQ==
X-Received: by 2002:a05:620a:526:: with SMTP id h6mr20241138qkh.338.1591027007243;
        Mon, 01 Jun 2020 08:56:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:d1fb])
        by smtp.gmail.com with ESMTPSA id w204sm15250387qka.41.2020.06.01.08.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 08:56:46 -0700 (PDT)
Date:   Mon, 1 Jun 2020 11:56:15 -0400
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
Message-ID: <20200601155615.GA131075@cmpxchg.org>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
 <20200520232525.798933-6-hannes@cmpxchg.org>
 <CAAmzW4MMLw=4BHRtt=g8BHpQLTaSmhG03Ct6WMjmDxVnOkNQYA@mail.gmail.com>
 <20200527134333.GF6781@cmpxchg.org>
 <CAAmzW4NW+cv7VnNApWKJr4r9=QKaufK3y5apyNXo-M-y=q0dgg@mail.gmail.com>
 <20200528170155.GA69521@cmpxchg.org>
 <CAAmzW4NEPZRWL5PBXEWwg9kBOL9fYUNqTTzh3WRDWbaSPLv=CQ@mail.gmail.com>
 <20200529151228.GA92892@cmpxchg.org>
 <CAAmzW4Pccc4UcBThhKyqbtY=kK83Fz7k4vYR4eJN4te2E25=_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4Pccc4UcBThhKyqbtY=kK83Fz7k4vYR4eJN4te2E25=_A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 03:14:24PM +0900, Joonsoo Kim wrote:
> 2020년 5월 30일 (토) 오전 12:12, Johannes Weiner <hannes@cmpxchg.org>님이 작성:
> >
> > On Fri, May 29, 2020 at 03:48:00PM +0900, Joonsoo Kim wrote:
> > > 2020년 5월 29일 (금) 오전 2:02, Johannes Weiner <hannes@cmpxchg.org>님이 작성:
> > > > On Thu, May 28, 2020 at 04:16:50PM +0900, Joonsoo Kim wrote:
> > > > > 2020년 5월 27일 (수) 오후 10:43, Johannes Weiner <hannes@cmpxchg.org>님이 작성:
> > > > > > On Wed, May 27, 2020 at 11:06:47AM +0900, Joonsoo Kim wrote:
> > > > The only way they could get reclaimed is if their access distance ends
> > > > up bigger than the file cache. But if that's the case, then the
> > > > workingset is overcommitted, and none of the pages qualify for reclaim
> > > > protection. Picking a subset to protect against the rest is arbitrary.
> > >
> > > In the fixed example, although other file (500 MB) is repeatedly accessed,
> > > it's not workingset. If we have unified list (file + anon), access distance of
> > > Pn will be larger than whole memory size. Therefore, it's not overcommitted
> > > workingset and this patch wrongly try to activate it. As I said before,
> > > without considering inactive_age for anon list, this calculation can not be
> > > correct.
> >
> > You're right. If we don't take anon age into account, the activations
> > could be over-eager; however, so would counting IO cost and exerting
> > pressure on anon be, which means my previous patch to split these two
> > wouldn't fix fundamental the problem you're pointing out. We simply
> 
> Splitting would not fix the fundamental problem (over-eager) but it would
> greatly weaken the problem. Just counting IO cost doesn't break the
> active/inactive separation in file list. It does cause more scan on anon list
> but I think that it's endurable.

I think the split is a good idea.

The only thing I'm not sure yet is if we can get away without an
additional page flag if the active flag cannot be reused to denote
thrashing. I'll keep at it, maybe I can figure something out.

But I think it would be follow-up work.

> > have to take anon age into account for the refaults to be comparable.
> 
> Yes, taking anon age into account is also a good candidate to fix the problem.

Okay, good.

> > However, your example cannot have a completely silent stable state. As
> > we stop workingset aging, the refault distances will slowly increase
> > again. We will always have a bit of churn, and rightfully so, because
> > the workingset *could* go stale.
> >
> > That's the same situation in my cache-only example above. Anytime you
> > have a subset of pages that by itself could fit into memory, but can't
> > because of an established workingset, ongoing sampling is necessary.
> >
> > But the rate definitely needs to reduce as we detect that in-memory
> > pages are indeed hot. Otherwise we cause more churn than is required
> > for an appropriate rate of workingset sampling.
> >
> > How about the patch below? It looks correct, but I will have to re-run
> > my tests to make sure I / we are not missing anything.
> 
> Much better! It may solve my concern mostly.

Okay thanks for confirming. I'll send a proper version to Andrew.

> But, I still think that modified refault activation equation isn't
> safe. The next
> problem I found is related to the scan ratio limit patch ("limit the range of
> LRU type balancing") on this series. See the below example.
> 
> anon: Hot (X M)
> file: Hot (200 M) / dummy (200 M)
> P: 1200 M (3 parts, each one 400 M, P1, P2, P3)
> Access Pattern: A -> F(H) -> P1 -> A -> F(H) -> P2 -> ... ->
> 
> Without this patch, A and F(H) are kept on the memory and look like
> it's correct.
> 
> With this patch and below fix, refault equation for Pn would be:
> 
> Refault dist of Pn = 1200 (from file non-resident) + 1200 * anon scan
> ratio (from anon non-resident)
> anon + active file = X + 200
> 1200 + 1200 * anon scan ratio (0.5 ~ 2) < X + 200

That doesn't look quite right to me. The anon part of the refault
distance is driven by X, so the left-hand of this formula contains X
as well.

1000 file (1200M reuse distance, 200M in-core size) + F(H) reactivations + X * scan ratio < X + 1000

Activations persist as long as anon isn't fully scanned and it isn't
established yet that it's fully hot. Meaning, we optimistically assume
the refaulting pages can be workingset until we're proven wrong.

> According to the size of X, Pn's refault result would be different. Pn could
> be activated with large enough X and then F(H) could be evicted. In ideal
> case (unified list), for this example, Pn should not be activated in any X.

Yes. The active/iocost split would allow us to be smarter about it.

> This is a fundamental problem since we have two list type (file/anon) and
> scan ratio limit is required. Anyway, we need to take care of this reality and
> the way most safe is to count IO cost instead of doing activation in this
> 'non-resident dist < (active + anon list)' case.

Agreed here again.

> Again, for this patch, I'm not confident myself so please let me know if I'm
> wrong.

As far as this patch goes, I think it's important to look at the
bigger picture.

We need to have convergence first before being able to worry about
optimizing. Stable states are optimizations, but false stable states
are correctness problems.

For the longest time, we scanned active pages unconditionally during
page reclaim. This was always safe in the sense that it wouldn't get
stuck on a stale workingset, but it incurs unnecessary workingset
churn when reclaim is driven by use-once patterns.

We optimized the latter too aggressively, and as a result caused
situations where we indefinitely fail to cache the hottest
data. That's not really a workable trade-off.

With the active/iocost split you're suggesting, we can reasonably
optimize your example scenario. But we can't do it if the flipside
means complete failure to transition between in-memory sets.

So I think we should go ahead with this patch (with the anon age
recognition fixed, because that's a correctness issue), and follow it
up with the stable state optimization to shrink anon first.
