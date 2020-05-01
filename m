Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5ADC47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D4D2071C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9WxwNF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgEAKwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 06:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728615AbgEAKws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 06:52:48 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315DEC08E859
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 03:52:48 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v26so7623239qto.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 03:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CKSWEhR47OrXn/8dOC2MOqQVcUKFbmXG90P7o5aVE8c=;
        b=V9WxwNF2rHyEYvnA0zGGt8w7B58qoUIf9ewJ5d1B8wOGtvxFNIAsipVA5Y9CRz61gK
         NaT8/XnkaR+L0+bCE0Hyx1LUvo/YXMQVK2GL/LpLChR2wN1+QwNE9lTEkkslIK6GqZXh
         oNLTdhuMVcfSDyEYzBnUNqmoLpYGQiIfl19++n+I8I3nE6CzjWNAiNnrYDZa68gibmcs
         dQSqWa1xywl9UbC0Y/SfwOOrRBY5PGOy3soSGH7Yk0YZyg79JzXeKIx5U5uDAnOAQ0Bp
         9MF2dlrjWkV051D393hydRx9YYhMfKWstNiauG7G8bFe7VeAz0iZx5nRJ8xiDDOOi6Dv
         cHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CKSWEhR47OrXn/8dOC2MOqQVcUKFbmXG90P7o5aVE8c=;
        b=dBAsMsHyU9caN22F3wYEBkKXfw+2gITghg4i3Ror96QqxYDK3PwuBiBl0dPBcCGpsS
         oe/U9cpl8Upaj4ar50hy9nbfu8peldnqXQX0eAppYDcwgpjc+Z4GCWsBraLBDjPerCZv
         PBODHcAICtkGWMwnz8xVJhHoqM+0D6F6DLYGx0mRM4pN1pE8l5nZv7K0t5K8jjz+/CFn
         OOMMf439k3qbMWG3PedpP9JQ94xcFJTm14TNjAEa+ok4lheGrhl99W7zB1fJAiLdR09w
         EvQmDBIkWOKMWVrOmKH99X0nER3TpsZFOz+KkiqI495ews0TTGuy1Rlxtar7tfdMxyeP
         IbWQ==
X-Gm-Message-State: AGi0PuZCcjgsrn2V9wXRsizw324fsR+dsSMZaPKJlEZEpQs0q/IpTTCz
        le9Kf/wRa/Odm9AtR/aGOafm4rXyWV0YW0YG+wiDnz3zvpM=
X-Google-Smtp-Source: APiQypKXjEL1RmHTSzXwlVnlyybCY6qyE6NYilstbhLWFeHgxL09NfX2tGRosNYxqEU3zw3qGm+peP0ETc3l5lTBCQI=
X-Received: by 2002:ac8:724b:: with SMTP id l11mr3265642qtp.35.1588330367309;
 Fri, 01 May 2020 03:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com> <20200429184711.9d603da097fdea80f574f1f1@linux-foundation.org>
In-Reply-To: <20200429184711.9d603da097fdea80f574f1f1@linux-foundation.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 1 May 2020 19:52:35 +0900
Message-ID: <CAAmzW4NC4LHXSoU8r6Jrh7WP8fouuaSkM--0gQVWf8G4wkDupg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] change the implementation of the PageHighMem()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
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
        Pavel Machek <pavel@ucw.cz>, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 4=EC=9B=94 30=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 10:47, =
Andrew Morton <akpm@linux-foundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> On Wed, 29 Apr 2020 12:26:33 +0900 js1304@gmail.com wrote:
>
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > Changes on v2
> > - add "acked-by", "reviewed-by" tags
> > - replace PageHighMem() with use open-code, instead of using
> > new PageHighMemZone() macro. Related file is "include/linux/migrate.h"
> >
> > Hello,
> >
> > This patchset separates two use cases of PageHighMem() by introducing
> > PageHighMemZone() macro. And, it changes the implementation of
> > PageHighMem() to reflect the actual meaning of this macro. This patchse=
t
> > is a preparation step for the patchset,
> > "mm/cma: manage the memory of the CMA area by using the ZONE_MOVABLE" [=
1].
> >
> > PageHighMem() is used for two different cases. One is to check if there
> > is a direct mapping for this page or not. The other is to check the
> > zone of this page, that is, weather it is the highmem type zone or not.
> >
> > Until now, both the cases are the perfectly same thing. So, implementat=
ion
> > of the PageHighMem() uses the one case that checks if the zone of the p=
age
> > is the highmem type zone or not.
> >
> > "#define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))"
> >
> > ZONE_MOVABLE is special. It is considered as normal type zone on
> > !CONFIG_HIGHMEM, but, it is considered as highmem type zone
> > on CONFIG_HIGHMEM. Let's focus on later case. In later case, all pages
> > on the ZONE_MOVABLE has no direct mapping until now.
> >
> > However, following patchset
> > "mm/cma: manage the memory of the CMA area by using the ZONE_MOVABLE"
> > , which is once merged and reverted, will be tried again and will break
> > this assumption that all pages on the ZONE_MOVABLE has no direct mappin=
g.
> > Hence, the ZONE_MOVABLE which is considered as highmem type zone could
> > have the both types of pages, direct mapped and not. Since
> > the ZONE_MOVABLE could have both type of pages, __GFP_HIGHMEM is still
> > required to allocate the memory from it. And, we conservatively need to
> > consider the ZONE_MOVABLE as highmem type zone.
> >
> > Even in this situation, PageHighMem() for the pages on the ZONE_MOVABLE
> > when it is called for checking the direct mapping should return correct
> > result. Current implementation of PageHighMem() just returns TRUE
> > if the zone of the page is on a highmem type zone. So, it could be wron=
g
> > if the page on the MOVABLE_ZONE is actually direct mapped.
> >
> > To solve this potential problem, this patch introduces a new
> > PageHighMemZone() macro. In following patches, two use cases of
> > PageHighMem() are separated by calling proper macro, PageHighMem() and
> > PageHighMemZone(). Then, implementation of PageHighMem() will be change=
d
> > as just checking if the direct mapping exists or not, regardless of
> > the zone of the page.
> >
> > Note that there are some rules to determine the proper macro.
> >
> > 1. If PageHighMem() is called for checking if the direct mapping exists
> > or not, use PageHighMem().
> > 2. If PageHighMem() is used to predict the previous gfp_flags for
> > this page, use PageHighMemZone(). The zone of the page is related to
> > the gfp_flags.
> > 3. If purpose of calling PageHighMem() is to count highmem page and
> > to interact with the system by using this count, use PageHighMemZone().
> > This counter is usually used to calculate the available memory for an
> > kernel allocation and pages on the highmem zone cannot be available
> > for an kernel allocation.
> > 4. Otherwise, use PageHighMemZone(). It's safe since it's implementatio=
n
> > is just copy of the previous PageHighMem() implementation and won't
> > be changed.
>
> hm, this won't improve maintainability :(
>
> - Everyone will need to remember when to use PageHighMem() and when
>   to use PageHighMemZone().  If they get it wrong, they're unlikely to
>   notice any problem in their runtime testing, correct?
>
> - New code will pop up which gets it wrong and nobody will notice for
>   a long time.

Hmm... I think that it's not that hard to decide correct macro. If we renam=
e
PageHighMem() with PageDirectMapped(), they, PageDirectMapped() and
PageHighMemZone(), are self-explanation macro. There would be no
confusion to use.

> So I guess we need to be pretty confident that the series "mm/cma:
> manage the memory of the CMA area by using the ZONE_MOVABLE" will be
> useful and merged before proceeding with this, yes?

Yes and my assumption is that we (MM) have agreed with usefulness of
CMA series.

> On the other hand, this whole series is a no-op until [10/10]
> (correct?) so it can be effectively reverted with a single line change,

Correct!

> with later cleanups which revert the other 9 patches.
>
> So I think I'd like to take another look at "mm/cma: manage the memory
> of the CMA area by using the ZONE_MOVABLE" before figuring out what to
> do here.  Mainly to answer the question "is the new feature valuable
> enough to justify the maintainability impact".  So please do take some
> care in explaining the end-user benefit when preparing the new version
> of that patchset.

So, do you mean to send the new version of CMA patchset with more
explanation before merging this patchset? If yes, I can do. But, I'm not su=
re
that it's worth doing. Problems of CMA are still not solved although
the utilization problem will be partially solved by Roman's "mm,page_alloc,=
cma:
conditionally prefer cma pageblocks for movable allocations" patch
in this (v5.7) release. Rationale that we agree with CMA patchset is still
remained.

Anyway, if you mean that, I will send the CMA patchset with more explanatio=
n.

Thanks.
