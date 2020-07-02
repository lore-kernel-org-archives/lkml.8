Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD11C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B19221E8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFHRBkvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgGBTW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:22:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31818 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726072AbgGBTW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 15:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593717747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wow0Ygu65peLja/h/OTF4fc7jwjBqgs+uK8UVoodCFw=;
        b=CFHRBkvVWPm4Z15JWbOvOmsFErwENDVi5yzNrQbhqpIK97fttnbgd6x56ATtmMkDAq+qQZ
        oDtBy1vxwviQtJiYV1iBElajW8qRApZUuVtc9zVkrkNpxcNZ3NN51d8V/OFDwW24Ko8N8j
        uFtoV1pWJQm4s44kIDQf8jDbeW1NB/0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-8wiLaduXNKCNbuMemedVyw-1; Thu, 02 Jul 2020 15:22:21 -0400
X-MC-Unique: 8wiLaduXNKCNbuMemedVyw-1
Received: by mail-qt1-f198.google.com with SMTP id z26so1585613qto.15
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 12:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wow0Ygu65peLja/h/OTF4fc7jwjBqgs+uK8UVoodCFw=;
        b=fc4wLKnqqwvQV46qytyoulm7yZcStep+PrCDUi3tIEIMsWBN0wSlcc2UXC0SBe8BgU
         XfGLkMpN2aNU6o1XQlaqXezXrn5taCdWn8Z0CbJkCOwZbPbUNflBJzf0HmRae9olZ+dq
         5uGPY5vSmKFH/1hBGfCbTWbDwXdpO0d1pCGUXwyXEzAJgi688oSRF7lx2rXFwYnWkQyu
         j0fqKs0MBMHM/PcKvbP4p4R2PFHfxtASsAniiy60XtdJbsGhP9eYIaOsVpi2q6VQEt/B
         ixMSCUwfC7PsPGutPKUxg3HsyRymvYdcl/VL249HKiNK6OqobzJ4f3gSsIIxX3fym7gw
         fUSw==
X-Gm-Message-State: AOAM5330ZSboWPhjTAx4E6UnnYK+lzvGrhaxJloe+IQXxI+NcUpDMW7Q
        XOEl35M3mJovcJjSvFDjXVntcVlSkfKRwnSKlbIDj4kic7Up7N8xjMezGNITbW7iMWhhucYydeb
        iYLLyoEsXNRID1ZuYsll7g9RxLW2zKqFpv/J+S5RO
X-Received: by 2002:ac8:429b:: with SMTP id o27mr21653197qtl.124.1593717740702;
        Thu, 02 Jul 2020 12:22:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxT/Yz66Mm2DZnNpTLY1kn5bds91N12gXuAl8xcrffYobR0MkCqmKoDHO8iv5NQ7rsNdb5NF+5YXp8MRlwfnAI=
X-Received: by 2002:ac8:429b:: with SMTP id o27mr21653164qtl.124.1593717740325;
 Thu, 02 Jul 2020 12:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <1593641660-13254-1-git-send-email-bhsharma@redhat.com>
 <1593641660-13254-3-git-send-email-bhsharma@redhat.com> <20200702075001.GA16113@willie-the-truck>
In-Reply-To: <20200702075001.GA16113@willie-the-truck>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Fri, 3 Jul 2020 00:52:08 +0530
Message-ID: <CACi5LpPn4QUjC692G=5UxLchpi+ZL+xFCcxqLbFvgvvcso28ww@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: Allocate crashkernel always in ZONE_DMA
To:     Will Deacon <will@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Thu, Jul 2, 2020 at 1:20 PM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Jul 02, 2020 at 03:44:20AM +0530, Bhupesh Sharma wrote:
> > commit bff3b04460a8 ("arm64: mm: reserve CMA and crashkernel in
> > ZONE_DMA32") allocates crashkernel for arm64 in the ZONE_DMA32.
> >
> > However as reported by Prabhakar, this breaks kdump kernel booting in
> > ThunderX2 like arm64 systems. I have noticed this on another ampere
> > arm64 machine. The OOM log in the kdump kernel looks like this:
> >
> >   [    0.240552] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
> >   [    0.247713] swapper/0: page allocation failure: order:1, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0
> >   <..snip..>
> >   [    0.274706] Call trace:
> >   [    0.277170]  dump_backtrace+0x0/0x208
> >   [    0.280863]  show_stack+0x1c/0x28
> >   [    0.284207]  dump_stack+0xc4/0x10c
> >   [    0.287638]  warn_alloc+0x104/0x170
> >   [    0.291156]  __alloc_pages_slowpath.constprop.106+0xb08/0xb48
> >   [    0.296958]  __alloc_pages_nodemask+0x2ac/0x2f8
> >   [    0.301530]  alloc_page_interleave+0x20/0x90
> >   [    0.305839]  alloc_pages_current+0xdc/0xf8
> >   [    0.309972]  atomic_pool_expand+0x60/0x210
> >   [    0.314108]  __dma_atomic_pool_init+0x50/0xa4
> >   [    0.318504]  dma_atomic_pool_init+0xac/0x158
> >   [    0.322813]  do_one_initcall+0x50/0x218
> >   [    0.326684]  kernel_init_freeable+0x22c/0x2d0
> >   [    0.331083]  kernel_init+0x18/0x110
> >   [    0.334600]  ret_from_fork+0x10/0x18
> >
> > This patch limits the crashkernel allocation to the first 1GB of
> > the RAM accessible (ZONE_DMA), as otherwise we might run into OOM
> > issues when crashkernel is executed, as it might have been originally
> > allocated from either a ZONE_DMA32 memory or mixture of memory chunks
> > belonging to both ZONE_DMA and ZONE_DMA32.
>
> How does this interact with this ongoing series:
>
> https://lore.kernel.org/r/20200628083458.40066-1-chenzhou10@huawei.com
>
> (patch 4, in particular)

Many thanks for having a look at this patchset. I was not aware that
Chen had sent out a new version.
I had noted in the v9 review of the high/low range allocation
<https://lists.gt.net/linux/kernel/3726052#3726052> that I was working
on a generic solution (irrespective of the crashkernel, low and high
range allocation) which resulted in this patchset.

The issue is two-fold: OOPs in memcfg layer (PATCH 1/2, which has been
Acked-by memcfg maintainer) and OOM in the kdump kernel due to
crashkernel allocation in ZONE_DMA32 regions(s) which is addressed by
this PATCH.

I will have a closer look at the v10 patchset Chen shared, but seems
it needs some rework as per Dave's review comments which he shared
today.
IMO, in the meanwhile this patchset  can be used to fix the existing
kdump issue with upstream kernel.

> > Fixes: bff3b04460a8 ("arm64: mm: reserve CMA and crashkernel in ZONE_DMA32")
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: cgroups@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: kexec@lists.infradead.org
> > Reported-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> > ---
> >  arch/arm64/mm/init.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 1e93cfc7c47a..02ae4d623802 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -91,8 +91,15 @@ static void __init reserve_crashkernel(void)
> >       crash_size = PAGE_ALIGN(crash_size);
> >
> >       if (crash_base == 0) {
> > -             /* Current arm64 boot protocol requires 2MB alignment */
> > -             crash_base = memblock_find_in_range(0, arm64_dma32_phys_limit,
> > +             /* Current arm64 boot protocol requires 2MB alignment.
> > +              * Also limit the crashkernel allocation to the first
> > +              * 1GB of the RAM accessible (ZONE_DMA), as otherwise we
> > +              * might run into OOM issues when crashkernel is executed,
> > +              * as it might have been originally allocated from
> > +              * either a ZONE_DMA32 memory or mixture of memory
> > +              * chunks belonging to both ZONE_DMA and ZONE_DMA32.
> > +              */
>
> This comment needs help. Why does putting the crashkernel in ZONE_DMA
> prevent "OOM issues"?

Sure, I can work on adding more details in the comment so that it
explains the potential OOM issue(s) better.

Thanks,
Bhupesh

