Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D38C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A2820882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgJrpa05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDUGnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725831AbgDUGnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 02:43:39 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BBAC061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 23:43:38 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id l13so10770927qtr.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 23:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bj3IP9yKUKzLV9bYA43k4lnx/OmIzqwOuSm3Fw5P9lk=;
        b=NgJrpa05t8bNQnoB1pnjRHU9naYtq9BiF/JbfN2rZV2bYOwIhstSj9EGQT4b9RuHIb
         eaTWgcE7dh1WwB6vuRNq7rnE805fVum1PNBHodJEIepFr9y25ORiIxCW7WVOW59Jl2vv
         oSMFrpiaTHpFWX4zbIAXtzBtKLRd0xoJazB39TGbJjgsg4l/pX337Y0NOIiZprkkvhdc
         U1ESOItDrKkVUOzvg6N+uJSOO4B3UXRGjRlu2mbPqZ8RkbfmlukT5Fi8fb7+jWtLnoTj
         hNz4y/GafOsZiFcRS7BOAd3lryDZ1LWpbCsGZyzmx2pqYSlshrgLOjhqiELj0GFjsq+A
         oLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bj3IP9yKUKzLV9bYA43k4lnx/OmIzqwOuSm3Fw5P9lk=;
        b=izLamtHjUuOyC3AiiqKN3apouevc9L9j1HML9iIX0uki+gVcnwQcQjl530sqg4pSts
         Z/k9aDsCCTfV3Wdga6UNvWI1IOhSPauc15GMThlBEiujGk3QyTQO5C0wQJwZTFoDTvjF
         PQAkdiUDpRJ1yV2qJwicumQad5kDyy7hhYtE+FrRGPvDkYprPGTygk/rs42yBfGBJqtK
         VjO8T2+BIAK0N6tN44rqPoJxLdv37B32n5ay0ibNz0hTdcq82K7b9+RjgEUKCVMSZjp2
         qLbbEKMuIyKfZp+2WH6JTw588fGf+f3idt3GJEtd4fGZk90akVkynWpH07Rem8iQgy4A
         MZkA==
X-Gm-Message-State: AGi0PuYgmSmnB7rWScmBiGeuZv/KSd0l65eGvxP51KGPJf1poC+bhImU
        bK+NSOBiTlAjVHWTrFeuLvsFNYzx+/AAGwIYP5Y=
X-Google-Smtp-Source: APiQypKZGqSt1hIJMFGEiw90jd5DOVexhu22Ifz7g6bif/sGkp2QcCue3pF2LyPXlMPHIcd4PHQqSZS2xriM3qW5OG0=
X-Received: by 2002:ac8:2a70:: with SMTP id l45mr5743292qtl.232.1587451417781;
 Mon, 20 Apr 2020 23:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1587369582-3882-2-git-send-email-iamjoonsoo.kim@lge.com> <20200420112010.GA5820@bombadil.infradead.org>
 <2c45bab6-8c29-e227-56b8-307e8bee46c6@suse.cz>
In-Reply-To: <2c45bab6-8c29-e227-56b8-307e8bee46c6@suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Tue, 21 Apr 2020 15:43:26 +0900
Message-ID: <CAAmzW4PUHw4utuS3tzMDFWqjDwUu14z8u=kxJa4wVEfEynFr1g@mail.gmail.com>
Subject: Re: [PATCH 01/10] mm/page-flags: introduce PageHighMemZone()
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Matthew and Vlastimil.

2020=EB=85=84 4=EC=9B=94 20=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 8:37, V=
lastimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 4/20/20 1:20 PM, Matthew Wilcox wrote:
> > On Mon, Apr 20, 2020 at 04:59:33PM +0900, js1304@gmail.com wrote:
> >> ZONE_MOVABLE is special. It is considered as normal type zone on
> >> !CONFIG_HIGHMEM, but, it is considered as highmem type zone
> >> on CONFIG_HIGHMEM. Let's focus on later case. In later case, all pages
> >> on the ZONE_MOVABLE has no direct mapping until now.
> >>
> >> However, following patchset
> >> "mm/cma: manage the memory of the CMA area by using the ZONE_MOVABLE"
> >> , which is once merged and reverted, will be tried again and will brea=
k
> >> this assumption that all pages on the ZONE_MOVABLE has no direct mappi=
ng.
> >> Hence, the ZONE_MOVABLE which is considered as highmem type zone could
> >> have the both types of pages, direct mapped and not. Since
> >> the ZONE_MOVABLE could have both type of pages, __GFP_HIGHMEM is still
> >> required to allocate the memory from it. And, we conservatively need t=
o
> >> consider the ZONE_MOVABLE as highmem type zone.
> >
> > I don't understand why CMA allocating pages from ZONE_MOVABLE somehow
> > gives these pages a direct mapping.  Maybe you have a freaky layout in
> > the architecture that makes no sense and that's what needs to be fixed?
> >
> > My understanding of the zones is based on x86, and it looks like this
> > on a 32-bit system with 8GB of memory:
> >
> > ZONE_DMA      0-16MB
> > ZONE_NORMAL   16-896MB
> > ZONE_HIGHMEM  896-xMB
> > ZONE_MOVABLE  x-8192MB
> >
> > where x is a boot option used to partition the highmem between movable
> > and unmovable.
> >
> > Now, why would allocating the CMA from ZONE_NORMAL suddenly make these
> > pages part of the direct mapping?
>
> I assume the scenario is that ZONE_MOVABLE could extend into today's ZONE=
_NORMAL
> range, which is the range covered by direct mapping.
> At that point, testing page's zone stops being a reliable test of "does t=
his
> page have direct mapping"?

Correct explanation. Thanks, Vlastimil.

This patchset is a preparation for my future patchset "mm/cma: manage the m=
emory
of the CMA area by using the ZONE_MOVABLE" [1] to solve the many CMA proble=
ms.

CMA areas can be on the all the memory range, from ZONE_DMA to ZONE_HIGHMEM=
.
And, in my future patchset [1], all the CMA areas are managed through
the ZONE_MOVABLE
and the range of the ZONE_MOVABLE is extended to cover all the CMA
areas. In this
case, following scenario would be possible.

CMA area 1: 32MB size on the memory range 16MB~48MB (originally on the
ZONE_NORMAL)
CMA area 2: 32MB size on the memory range 896MB~928MB (originally on
the ZONE_HIGHMEM)

With my future patchset [1], ZONE_MOVABLE manages all the pages from
CMA area 1 and 2.
So, ZONE_MOVABLE has both direct mapped page and un-mapped page. Since one =
zone
has two types of pages, current PageHighMem() implemented by using
zone index could not
work correctly. So, I make this patchset to change the PagHighMem()
implementation.

> I don't know the exact motivation why that will happen but I can imagine =
two.
> 1) some CMA user needs the CMA allocations to be in direct mapping range
> 2) the amount of CMA memory reservation required is so high it won't fit =
in
> highmem range only.

The range of CMA area is highly depends on system architecture and
device. Each device
using CMA area would have different limitation for address range and
someone's limitation
could be low memory range.

Thanks.
