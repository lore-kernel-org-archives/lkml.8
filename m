Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9518FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D58120773
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="panxh388"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgFSBU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 21:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgFSBUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:20:55 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1035C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:20:54 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id k11so8406581ejr.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+mCEUMGpp5uEDagLGIH08diwth5m6HcRon8RKEagLE=;
        b=panxh388JxJ72RQ5hZ7/NiWF9ZehHX75fOMrwirRvUTqd8vE4LfMlo5H3W4m4P9b7D
         6/Fa9XHxuZULb4BUGuaq3lxNHbGmJ61Z6lPpi2T7aZunkXi4kUFJKzlKtn0pcg004EQk
         AxlYypCbjl5cqkqtcf/jt0ewjkE1dKgA3usj4Ello0CmRXos+7osvfZPF+2/OQ1olfyI
         DqGhN5uFZ3CogXb1T6wAep8+qG78fLyfJsSmFD4ZFNtpcS2QDPp8IFWHYia8VuGqzAtS
         /9MvVkgLLd9U2fmhUeeEBPaXuYwpYS1eqjvVaU+iPmfAEPDPR4A5eU6KbHwUoqgvi6wf
         52JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+mCEUMGpp5uEDagLGIH08diwth5m6HcRon8RKEagLE=;
        b=PW9KY1ohfG8AYTElLhIzDPSTYvlAF7Pj8OAI1fecsALj8I4+zPAJxsDUS0dEutmEy3
         Sx6r29VjoIN2qtuuLGno488FePmhYYVeA0fw59Ne6Dem+uwxdx9X2jTUIbkbN0Guu4FL
         0eqUZThNAvfaYRzwccW38xINnTRDHbpBk0qoXHriVMnB7fwM4oG8WcE4iQ727MZseoFp
         u9EOc88zlDkY3qi1QV30fH83b32b6ZSHcOdKLxeRodKeULnW5Yc+uIY848jScKIOs+x+
         /g03QTE6oTM90L3G2eg6p+vyN5MkCBt6EUwNiQ4P+zyVKcFTLeSX3r1H5B8rJupMSDht
         tvIA==
X-Gm-Message-State: AOAM533XcR0ye0AiY20OP2pZpQK/a6ckQEUktjP+/6gAv0PiXyDTlif7
        ZWvDPa7dYOlebOx5ak/x8aSa5tl1uMRU9UCvo40=
X-Google-Smtp-Source: ABdhPJx7r2HJwq3Rancv83KNTAHcg2iKdnMhlFj53Az2RLaUqwL2RHrJ7Xt3jhJy6H68ZNpu8kwCZ0h0ktkLENbL7VU=
X-Received: by 2002:a17:906:5496:: with SMTP id r22mr1402476ejo.449.1592529653595;
 Thu, 18 Jun 2020 18:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200619001938.GA135965@carbon.dhcp.thefacebook.com>
 <CAHbLzkrDcn-GQOrAM=m7+2g5_J6obsz4K50Oqb-1RD5p1iWTPQ@mail.gmail.com> <20200619011449.GC135965@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200619011449.GC135965@carbon.dhcp.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 18 Jun 2020 18:20:37 -0700
Message-ID: <CAHbLzkpOHXd-H=rMGoi-WvoBsFDvy1up_mfeoYJgW2kq04hzaA@mail.gmail.com>
Subject: Re: kernel BUG at mm/huge_memory.c:2613!
To:     Roman Gushchin <guro@fb.com>
Cc:     iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richardw.yang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 6:15 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, Jun 18, 2020 at 05:46:24PM -0700, Yang Shi wrote:
> > On Thu, Jun 18, 2020 at 5:19 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > Hi!
> > >
> > > I was consistently hitting a VM_BUG_ON_PAGE() in split_huge_page_to_list()
> > > when running vanilla 5.8-rc1 on my desktop. It was happening on every boot
> > > during the system start. I haven't seen this issue on 5.7.
> > >
> > > It looks like split_huge_page() expects the page to be locked,
> > > but it hasn't been changed from 5.7. I do not see any suspicious
> > > commits around the call side either.
> > >
> > > I've tried the following patch:
> > >
> > > --
> > > From 4af38fbf06a9354fadf22a78f1a42dfbb24fbc3a Mon Sep 17 00:00:00 2001
> > > From: Roman Gushchin <guro@fb.com>
> > > Date: Thu, 18 Jun 2020 16:33:47 -0700
> > > Subject: [PATCH] iommu/dma: lock page before calling split_huge_page()
> > >
> > > split_huge_page() expects a locked page. The following stacktrace
> > > is generated if debug is on. Fix this by locking the page before
> > > passing it to split_huge_page().
> > >
> > > [   24.861385] page:ffffef044fb1fa00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 head:ffffef044fb1fa00 order:2 compound_mapcount:0 compound_pincount:0
> > > [   24.861389] flags: 0x17ffffc0010000(head)
> > > [   24.861393] raw: 0017ffffc0010000 dead000000000100 dead000000000122 0000000000000000
> > > [   24.861395] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> > > [   24.861396] page dumped because: VM_BUG_ON_PAGE(!PageLocked(head))
> > > [   24.861411] ------------[ cut here ]------------
> > > [   24.861413] kernel BUG at mm/huge_memory.c:2613!
> > > [   24.861428] invalid opcode: 0000 [#1] SMP NOPTI
> > > [   24.861432] CPU: 10 PID: 1505 Comm: pulseaudio Not tainted 5.8.0-rc1+ #689
> > > [   24.861433] Hardware name: Gigabyte Technology Co., Ltd. AB350-Gaming/AB350-Gaming-CF, BIOS F25 01/16/2019
> > > [   24.861441] RIP: 0010:split_huge_page_to_list+0x731/0xae0
> > > [   24.861444] Code: 44 00 00 8b 47 34 85 c0 0f 84 b4 02 00 00 f0 ff 4f 34 75 c2 e8 e0 12 f7 ff eb bb 48 c7 c6 d0 16 39 ba 4c 89 c7 e8 ef 85 f9 ff <0f> 0b 48 c7 44 24 10 ff ff ff ff 31 db e9 bb fa ff ff 48 8b 7c 24
> > > [   24.861446] RSP: 0018:ffffc1030254bb50 EFLAGS: 00010286
> > > [   24.861449] RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff9b54cee98d08
> > > [   24.861451] RDX: 00000000ffffffd8 RSI: 0000000000000000 RDI: ffff9b54cee98d00
> > > [   24.861452] RBP: ffffef044fb1fa00 R08: 0000000000000547 R09: 0000000000000003
> > > [   24.861454] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9b54df37f188
> > > [   24.861455] R13: ffff9b54df355000 R14: ffffef044fb1fa00 R15: ffffef044fb1fa00
> > > [   24.861458] FS:  00007fd2dc132880(0000) GS:ffff9b54cee80000(0000) knlGS:0000000000000000
> > > [   24.861460] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [   24.861461] CR2: 00007fd2cb100000 CR3: 00000003feb16000 CR4: 00000000003406e0
> > > [   24.861464] Call Trace:
> > > [   24.861473]  ? __mod_lruvec_state+0x41/0xf0
> > > [   24.861478]  ? __alloc_pages_nodemask+0x15c/0x320
> > > [   24.861483]  iommu_dma_alloc+0x316/0x580
> > > [   24.861496]  snd_dma_alloc_pages+0xdf/0x160 [snd_pcm]
> > > [   24.861508]  snd_dma_alloc_pages_fallback+0x5d/0x80 [snd_pcm]
> > > [   24.861516]  snd_malloc_sgbuf_pages+0x166/0x380 [snd_pcm]
> > > [   24.861523]  ? snd_pcm_hw_refine+0x29d/0x310 [snd_pcm]
> > > [   24.861529]  ? _cond_resched+0x16/0x40
> > > [   24.861535]  snd_dma_alloc_pages+0x64/0x160 [snd_pcm]
> > > [   24.861542]  snd_pcm_lib_malloc_pages+0x136/0x1d0 [snd_pcm]
> > > [   24.861550]  ? snd_pcm_lib_ioctl+0x167/0x210 [snd_pcm]
> > > [   24.861556]  snd_pcm_hw_params+0x3c0/0x490 [snd_pcm]
> > > [   24.861563]  snd_pcm_common_ioctl+0x1c5/0x1110 [snd_pcm]
> > > [   24.861571]  ? snd_pcm_info_user+0x64/0x80 [snd_pcm]
> > > [   24.861578]  snd_pcm_ioctl+0x23/0x30 [snd_pcm]
> > > [   24.861583]  ksys_ioctl+0x82/0xc0
> > > [   24.861587]  __x64_sys_ioctl+0x16/0x20
> > > [   24.861593]  do_syscall_64+0x4d/0x90
> > > [   24.861597]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > ---
> > >  drivers/iommu/dma-iommu.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > > index 4959f5df21bd..31e4e305d8d5 100644
> > > --- a/drivers/iommu/dma-iommu.c
> > > +++ b/drivers/iommu/dma-iommu.c
> > > @@ -24,6 +24,7 @@
> > >  #include <linux/scatterlist.h>
> > >  #include <linux/vmalloc.h>
> > >  #include <linux/crash_dump.h>
> > > +#include <linux/pagemap.h>
> > >
> > >  struct iommu_dma_msi_page {
> > >         struct list_head        list;
> > > @@ -549,8 +550,15 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
> > >                         if (!PageCompound(page)) {
> > >                                 split_page(page, order);
> > >                                 break;
> > > -                       } else if (!split_huge_page(page)) {
> > > -                               break;
> > > +                       } else {
> > > +                               int err;
> > > +
> > > +                               lock_page(page);
> > > +                               err = split_huge_page(page);
> > > +                               unlock_page(page);
> >
> > Yes, THP split does need the page locked, in addition it needs the
> > caller hold a pin on the page too (refcount bump).
> >
> > But, I don't get how the code could even really work by a quick look.
> > Actually split_huge_page() assumes the passed in THP is user THP (anon
> > or file cache) and the order is PMD order However, it looks the iommu
> > driver just wants to allocate a bunch of base pages by allocating a
> > huge page (could by any order if I read the code correctly) then split
> > them to base pages. I don't think this is the correct approach IMO.
> > Anyway I'm not iommu expert, if I miss anything please feel free to
> > let me know.
>
> I agree. The whole
>
>         page = alloc_pages_node(nid, alloc_flags, order);
>         if (!page)
>                 continue;
>         if (!order)
>                 break;
>         if (!PageCompound(page)) {
>                 split_page(page, order);
>                 break;
>         } else if (!split_huge_page(page)) {
>                 break;
>         }
>
> looks very suspicious to me.
> My wild guess is that gfp flags changed somewhere above, so we hit
> the branch which was never hit before.

It seems so. The page flag has PG_head set then hit the branch, but
the order is 2. I guess __GFP_COMP is set in gfp flag somewhere.
