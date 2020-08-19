Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE29DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9877C207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9P7Q8MB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHSQu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgHSQuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 12:50:54 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8A0C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 09:50:54 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id e11so13284388ils.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5MrhWijunOxFmEpPBfxi3nnE6h7nM/ESqf0MycrK1bc=;
        b=W9P7Q8MBYzAc+VHyoKcnaxdruKcc9ZSyiScd2J9v6cmWw9V53iCYL9xm13GYojtTkR
         O6m5ZuZ9sEndatn2ReAANkq9jfawHew8GkHaxJ7eCnNbboi2Rrr2dEhAGzjGMmiU0eoT
         Z8cmT1nhszZ5Ckk1v697ZJR/Q+V4CZtXY3FE3dU+Z7xU5ZX8wl9HYV/a6xtCQYb4uP5P
         mnIleeiKLLzpUzagPV4LUSGt3TjxNf950c8/KRfjdkpt8dxuVU9b+dxFWW9IRB3oVPjc
         EYqkKspt3S6ncXjxD8QGNeqVZ1flPjVKbPN35R7csKRwUoZQ6YrDEP4I5Q/DzmPV//qt
         zAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5MrhWijunOxFmEpPBfxi3nnE6h7nM/ESqf0MycrK1bc=;
        b=TdbtXiM+yE1YNeAVzaX5LRs+LXEoBgsTq+GfOVm45KpIoCxb5NsnsFJaKD3g6EBhH0
         wA08eHfXnNL9qKbZlXL00c9BBNH44V/1+W/xx0Ss0ovFyHX7tCtsXKYEWHyyVBrAfHP6
         IdM1hClhlKcwpCmL7JmxssbJ3dII30aGz+yOqfCQMevBsY3bPwqhYu9FAFAaTWD1aFKt
         nDX1VRiRwo0Np04/t1e5ECKFiVaSE9Tu+msKhl2Jj9b8phcO8uou408wRrQBLOfPGnP1
         Fu4RyehHayMZozWohQu0kphTSMK2FW09cofQOt90/t8peO1HSETIqmvQ5iB4b+4uGXRz
         fetw==
X-Gm-Message-State: AOAM530IBPmNzOCRX2LspzFriWttzy9VIxIsN5ijEEJn7Po1Ciz8h46X
        kOneUuV8HzunWlrgJEmsFkcYR15VEvhA3yLtEzg=
X-Google-Smtp-Source: ABdhPJzDxPAeWvgDmCjOAXYKMfFt0BmzaZvdHp9BeoKGX7wn8WeyKXgPImYKn2S0snSZja2ODcihfVN2edVUz2wHw/o=
X-Received: by 2002:a92:c8c1:: with SMTP id c1mr23266694ilq.42.1597855853425;
 Wed, 19 Aug 2020 09:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <1597816075-61091-1-git-send-email-alex.shi@linux.alibaba.com>
 <1597816075-61091-2-git-send-email-alex.shi@linux.alibaba.com>
 <715f1588-9cd5-b845-51a5-ca58549c4d28@arm.com> <a7376a9c-82e8-7dc1-b656-9c0516738801@linux.alibaba.com>
In-Reply-To: <a7376a9c-82e8-7dc1-b656-9c0516738801@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 19 Aug 2020 09:50:42 -0700
Message-ID: <CAKgT0UcXRB2HH4S+k=SmTz0Dgw9pKp=i4kT4U+yy8MFVC6_JWQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm/pageblock: remove false sharing in pageblock_flags
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 1:11 AM Alex Shi <alex.shi@linux.alibaba.com> wrote=
:
>
>
>
> =E5=9C=A8 2020/8/19 =E4=B8=8B=E5=8D=883:57, Anshuman Khandual =E5=86=99=
=E9=81=93:
> >
> >
> > On 08/19/2020 11:17 AM, Alex Shi wrote:
> >> Current pageblock_flags is only 4 bits, so it has to share a char size
> >> in cmpxchg when get set, the false sharing cause perf drop.
> >>
> >> If we incrase the bits up to 8, false sharing would gone in cmpxchg. a=
nd
> >> the only cost is half char per pageblock, which is half char per 128MB
> >> on x86, 4 chars in 1 GB.
> >
> > Agreed that increase in memory utilization is negligible here but does
> > this really improve performance ?
> >
>
> It's no doubt in theory. and it would had a bad impact according to
> commit e380bebe4771548  mm, compaction: keep migration source private to =
a single
>
> but I do have some problem in running thpscale/mmtest. I'd like to see if=
 anyone
> could give a try.
>
> BTW, I naturally hate the false sharing even it's in theory. Anyone who d=
oesn't? :)

You keep bringing up false sharing but you don't fix the false sharing
by doing this. You are still allowing the flags for multiple
pageblocks per cacheline so you still have false sharing even after
this.

What I believe you are attempting to address is the fact that multiple
pageblocks share a single long value and that long is being used with
a cmpxchg so you end up with multiple threads potentially all banging
on the same value and watching it change. However the field currently
consists of only 4 bits, 3 of them for migratetype and 1 for the skip
bit. In the case of the 3 bit portion a cmpxchg makes sense and is
usually protected by the zone lock so you would only have one thread
accessing it in most cases with the possible exception of a section
that spans multiple zones.

For the case such as the skip bit and MIGRATE_UNMOVABLE (0x0) where we
would be clearing or setting the entire mask maybe it would make more
sense to simply use an atomic_or or atomic_and depending on if you are
setting or clearing the flag? It would allow you to avoid the spinning
or having to read the word before performing the operation since you
would just be directly applying an AND or OR via a mask value.
