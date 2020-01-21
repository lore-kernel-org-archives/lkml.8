Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AB2C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE780206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJ5Ozt/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgAURWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:22:03 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36177 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAURWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:22:03 -0500
Received: by mail-ot1-f66.google.com with SMTP id m2so3663634otq.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 09:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lnnBSB/7F1DqkynwG4soN8UnncCnmRgHmiv4BugYM2Q=;
        b=aJ5Ozt/WoQVqWBg9nszl7nn+QO8qzJ7/0SYJdKIz39o4evxGwkmBpJzx0F02Z6n4TJ
         sA0EU/u73T/YZ8Hd3xsyhAu7nO6kP6arcnO8C4t1Aa4hRaprAC7PZ7M+AX2wNMLW1IDl
         Kga1/wlYwkF7ClEuvlfyBYX0EprNOCvkIXyuakIjFrgGQROA0adWbDS3wbyiRHxOjajA
         eQUnWDQ6kY5KdiLjBsd8Jd1lGJSaQ8t6y9z08JXrAruSFBYukOSxRj0wR9gBTLIXRD/J
         CzkExcAGMl3vty7AL/ANv0XP7ZgQcJsA4z3i7RcoSTTg+Yr2Y9WapiUc6KSpEtqjXKLd
         TvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lnnBSB/7F1DqkynwG4soN8UnncCnmRgHmiv4BugYM2Q=;
        b=pLtTI301KaYe6nXB8ezCz8mSe30HeawqHk0OrisrS7kxZrkTvPl5EXHgobVCThhoP9
         07GNTlLkXY57IRSr9JL6p7vBKbNtv+5p3PPjg7/MiXxm4hOv5JR8eVfXNjX1CqcyaopW
         Ovnp7FI2P/9qAs/Ckbc9ffCo+Oa+zn/NusQvPbJRisWXdUANmiYGv7CAAY3O9pF5RuTv
         eSqCsa35xoCL/+VyvUm6wocEbScEhsam8nxtdxJ3jpHbXg1n+eM5OPNlmuaRuro8FY0t
         1hNWD5p1Z35GEMfSgroUSByxSHGS2p0QL8+2ZjAivk8ZQicx/lLhtqDmiLeGO5cqYVtN
         0Pjw==
X-Gm-Message-State: APjAAAX4MK8J1JDBeLL5vXZgEwKksN/8VmxrjGWKZ+fjFVOCGsj2lMTC
        4A/zGmCZFD+VBJrUogECnXi3Kc4SHn5hq6GUbOQ=
X-Google-Smtp-Source: APXvYqxhSdmxZTm2RkROSVHhkFHYy/2nkaycOk6cWKNZai7VHc/dUdyL6kgV25LWnepB+Y6eUl58p7ECVzy8LpTzV9c=
X-Received: by 2002:a9d:53c4:: with SMTP id i4mr4630029oth.48.1579627322449;
 Tue, 21 Jan 2020 09:22:02 -0800 (PST)
MIME-Version: 1.0
References: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
 <20191218043951.10534-2-xiyou.wangcong@gmail.com> <db1c7741-e280-7930-1659-2ca43e8aac15@arm.com>
In-Reply-To: <db1c7741-e280-7930-1659-2ca43e8aac15@arm.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 21 Jan 2020 09:21:50 -0800
Message-ID: <CAM_iQpUmRKfiQ-P3G-PkRuumXqxN4TPuZtuqoT3+AFjhnkSwQQ@mail.gmail.com>
Subject: Re: [Patch v3 1/3] iommu: avoid unnecessary magazine allocations
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 3:11 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 18/12/2019 4:39 am, Cong Wang wrote:
> > The IOVA cache algorithm implemented in IOMMU code does not
> > exactly match the original algorithm described in the paper
> > "Magazines and Vmem: Extending the Slab Allocator to Many
> > CPUs and Arbitrary Resources".
> >
> > Particularly, it doesn't need to free the loaded empty magazine
> > when trying to put it back to global depot. To make it work, we
> > have to pre-allocate magazines in the depot and only recycle them
> > when all of them are full.
> >
> > Before this patch, rcache->depot[] contains either full or
> > freed entries, after this patch, it contains either full or
> > empty (but allocated) entries.
>
> How much additional memory overhead does this impose (particularly on
> systems that may have many domains mostly used for large, long-term
> mappings)? I'm wary that trying to micro-optimise for the "churn network
> packets as fast as possible" case may penalise every other case,
> potentially quite badly. Lower-end embedded systems are using IOMMUs in
> front of their GPUs, video codecs, etc. precisely because they *don't*
> have much memory to spare (and thus need to scrape together large
> buffers out of whatever pages they can find).

The calculation is not complicated: 32 * 6 * 129 * 8 = 198144 bytes,
which is roughly 192K, per domain.

>
> But on the other hand, if we were to go down this route, then why is
> there any dynamic allocation/freeing left at all? Once both the depot
> and the rcaches are preallocated, then AFAICS it would make more sense
> to rework the overflow case in __iova_rcache_insert() to just free the
> IOVAs and swap the empty mag around rather than destroying and
> recreating it entirely.

It's due to the algorithm requires a swap(), which can't be done with
statically allocated magzine. I had the same thought initially but gave it
up quickly when realized this.

If you are suggesting to change the algorithm, it is not a goal of this
patchset. I do have plan to search for a better algorithm as the IOMMU
performance still sucks (comparing to no IOMMU) after this patchset,
but once again, I do not want to change it in this patchset.

(My ultimate goal is to find a spinlock-free algorithm, otherwise there is
no way to make it close to no-IOMMU performance.)

>
> Perhaps there's a reasonable compromise wherein we don't preallocate,
> but still 'free' empty magazines back to the depot, such that busy
> domains will quickly reach a steady-state. In fact, having now dug up
> the paper at this point of writing this reply, that appears to be what
> fig. 3.1b describes anyway - I don't see any mention of preallocating
> the depot.

That paper missed a lot of things, it doesn't even recommend a size
of a depot or percpu cache. For implementation, we still have to
think about those details, including whether to preallocate memory.

Thanks.
