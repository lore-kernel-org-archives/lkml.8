Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B47C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 00:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A854120776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 00:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOOUxELT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgFSAqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 20:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgFSAqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 20:46:42 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B02EC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 17:46:42 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dr13so8361482ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 17:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khTQnDB+pnJbA7XUVQMTGTvHJSprz0VQhGe1/HksekA=;
        b=AOOUxELT6nV/XRS5C4l/vNlxYVPPiizwNasiPwhMmM5WSNG5+K63HbhiomBPhoWCsz
         DaJYk3xEe1NMSdwIregzPOqbhCAETIKbG5YoZ4YtVnFoyrSzlfmwtSPujM5IWdNFC5yS
         yIexh0IT+pudm/MBqFAAJIOZ3iXpWLuwd1DkmKlnDv0DPxzB7geL3AI8WWBiH0iI2JBE
         HUspXt82r6adoYzvz0fnZK4+GzXC9qGJUPhL9QEmszfHpaBcQgmSMxuaBxRgXxAMHiT1
         rmFymrWw8MvCoSXS1qdhkKfM8IupLZGDv9avC3xiH+w7TAhLn3W1pCVRmBYKsNXcxkrc
         Z5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khTQnDB+pnJbA7XUVQMTGTvHJSprz0VQhGe1/HksekA=;
        b=oFfBESG4F0bHK8VKfet4hoEFIjpRHqFJZgH3iiYA9Rr2s/Bfb/ewxODVpichflqN+f
         FAQynXKRvU0o5NDR8rP7oYp2OLh0vqDi6mbCm14hXij8mKEWnVCiyLrmaXnMfbBhsSwa
         Qcr2n65L4MbdFf3zJ4armFc4tyTs0Fd7MWsNw9FdRpCUshOrBE/lXe6KlJp4uAl0OAQ+
         VYub30/T+bdBerAtlITnsraOTM1aB281GjGXuOnm9UFbYF8Je0LI/CEApmyasydp131l
         /L+BwIz9ScyRLeSSRwDaVkNUNg+F+gK1CJdWymkd6Eq3DZrKXImYYoBCgFlvPm9vnqeT
         UY9w==
X-Gm-Message-State: AOAM531W1VIbFq/n1aeEGd47nS/UW5jSBjaNAgndQlKuqItrEnoZxoqa
        hs8hDB5Rmxc72qSu5LWdHetNa8Q8cgtcqNI0G9PVVg==
X-Google-Smtp-Source: ABdhPJzesmgPf04hG/iKR9dzfjzrLp4G7EQBLsNt1i/S4O+E1+h7PLe4OCaXFcJ58rHdlbxoTLeOZGbjQpr0c6Z+kbc=
X-Received: by 2002:a17:906:f913:: with SMTP id lc19mr1274217ejb.286.1592527600607;
 Thu, 18 Jun 2020 17:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200619001938.GA135965@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200619001938.GA135965@carbon.dhcp.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 18 Jun 2020 17:46:24 -0700
Message-ID: <CAHbLzkrDcn-GQOrAM=m7+2g5_J6obsz4K50Oqb-1RD5p1iWTPQ@mail.gmail.com>
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

On Thu, Jun 18, 2020 at 5:19 PM Roman Gushchin <guro@fb.com> wrote:
>
> Hi!
>
> I was consistently hitting a VM_BUG_ON_PAGE() in split_huge_page_to_list()
> when running vanilla 5.8-rc1 on my desktop. It was happening on every boot
> during the system start. I haven't seen this issue on 5.7.
>
> It looks like split_huge_page() expects the page to be locked,
> but it hasn't been changed from 5.7. I do not see any suspicious
> commits around the call side either.
>
> I've tried the following patch:
>
> --
> From 4af38fbf06a9354fadf22a78f1a42dfbb24fbc3a Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <guro@fb.com>
> Date: Thu, 18 Jun 2020 16:33:47 -0700
> Subject: [PATCH] iommu/dma: lock page before calling split_huge_page()
>
> split_huge_page() expects a locked page. The following stacktrace
> is generated if debug is on. Fix this by locking the page before
> passing it to split_huge_page().
>
> [   24.861385] page:ffffef044fb1fa00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 head:ffffef044fb1fa00 order:2 compound_mapcount:0 compound_pincount:0
> [   24.861389] flags: 0x17ffffc0010000(head)
> [   24.861393] raw: 0017ffffc0010000 dead000000000100 dead000000000122 0000000000000000
> [   24.861395] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> [   24.861396] page dumped because: VM_BUG_ON_PAGE(!PageLocked(head))
> [   24.861411] ------------[ cut here ]------------
> [   24.861413] kernel BUG at mm/huge_memory.c:2613!
> [   24.861428] invalid opcode: 0000 [#1] SMP NOPTI
> [   24.861432] CPU: 10 PID: 1505 Comm: pulseaudio Not tainted 5.8.0-rc1+ #689
> [   24.861433] Hardware name: Gigabyte Technology Co., Ltd. AB350-Gaming/AB350-Gaming-CF, BIOS F25 01/16/2019
> [   24.861441] RIP: 0010:split_huge_page_to_list+0x731/0xae0
> [   24.861444] Code: 44 00 00 8b 47 34 85 c0 0f 84 b4 02 00 00 f0 ff 4f 34 75 c2 e8 e0 12 f7 ff eb bb 48 c7 c6 d0 16 39 ba 4c 89 c7 e8 ef 85 f9 ff <0f> 0b 48 c7 44 24 10 ff ff ff ff 31 db e9 bb fa ff ff 48 8b 7c 24
> [   24.861446] RSP: 0018:ffffc1030254bb50 EFLAGS: 00010286
> [   24.861449] RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff9b54cee98d08
> [   24.861451] RDX: 00000000ffffffd8 RSI: 0000000000000000 RDI: ffff9b54cee98d00
> [   24.861452] RBP: ffffef044fb1fa00 R08: 0000000000000547 R09: 0000000000000003
> [   24.861454] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9b54df37f188
> [   24.861455] R13: ffff9b54df355000 R14: ffffef044fb1fa00 R15: ffffef044fb1fa00
> [   24.861458] FS:  00007fd2dc132880(0000) GS:ffff9b54cee80000(0000) knlGS:0000000000000000
> [   24.861460] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   24.861461] CR2: 00007fd2cb100000 CR3: 00000003feb16000 CR4: 00000000003406e0
> [   24.861464] Call Trace:
> [   24.861473]  ? __mod_lruvec_state+0x41/0xf0
> [   24.861478]  ? __alloc_pages_nodemask+0x15c/0x320
> [   24.861483]  iommu_dma_alloc+0x316/0x580
> [   24.861496]  snd_dma_alloc_pages+0xdf/0x160 [snd_pcm]
> [   24.861508]  snd_dma_alloc_pages_fallback+0x5d/0x80 [snd_pcm]
> [   24.861516]  snd_malloc_sgbuf_pages+0x166/0x380 [snd_pcm]
> [   24.861523]  ? snd_pcm_hw_refine+0x29d/0x310 [snd_pcm]
> [   24.861529]  ? _cond_resched+0x16/0x40
> [   24.861535]  snd_dma_alloc_pages+0x64/0x160 [snd_pcm]
> [   24.861542]  snd_pcm_lib_malloc_pages+0x136/0x1d0 [snd_pcm]
> [   24.861550]  ? snd_pcm_lib_ioctl+0x167/0x210 [snd_pcm]
> [   24.861556]  snd_pcm_hw_params+0x3c0/0x490 [snd_pcm]
> [   24.861563]  snd_pcm_common_ioctl+0x1c5/0x1110 [snd_pcm]
> [   24.861571]  ? snd_pcm_info_user+0x64/0x80 [snd_pcm]
> [   24.861578]  snd_pcm_ioctl+0x23/0x30 [snd_pcm]
> [   24.861583]  ksys_ioctl+0x82/0xc0
> [   24.861587]  __x64_sys_ioctl+0x16/0x20
> [   24.861593]  do_syscall_64+0x4d/0x90
> [   24.861597]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  drivers/iommu/dma-iommu.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 4959f5df21bd..31e4e305d8d5 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -24,6 +24,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/vmalloc.h>
>  #include <linux/crash_dump.h>
> +#include <linux/pagemap.h>
>
>  struct iommu_dma_msi_page {
>         struct list_head        list;
> @@ -549,8 +550,15 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>                         if (!PageCompound(page)) {
>                                 split_page(page, order);
>                                 break;
> -                       } else if (!split_huge_page(page)) {
> -                               break;
> +                       } else {
> +                               int err;
> +
> +                               lock_page(page);
> +                               err = split_huge_page(page);
> +                               unlock_page(page);

Yes, THP split does need the page locked, in addition it needs the
caller hold a pin on the page too (refcount bump).

But, I don't get how the code could even really work by a quick look.
Actually split_huge_page() assumes the passed in THP is user THP (anon
or file cache) and the order is PMD order However, it looks the iommu
driver just wants to allocate a bunch of base pages by allocating a
huge page (could by any order if I read the code correctly) then split
them to base pages. I don't think this is the correct approach IMO.
Anyway I'm not iommu expert, if I miss anything please feel free to
let me know.

> +
> +                               if (!err)
> +                                       break;
>                         }
>                         __free_pages(page, order);
>                 }
> --
> 2.26.2
>
>
> --
>
> But applying it made the kernel panic somewhere else:
>
> [   25.148419] BUG: unable to handle page fault for address: ffffb1a9c2429000
> [   25.148424] #PF: supervisor write access in kernel mode
> [   25.148426] #PF: error_code(0x000b) - reserved bit violation
> [   25.148427] PGD 40d14e067 P4D 40d14e067 PUD 40d14f067 PMD 3e9938067 PTE 8000112400b4b163
> [   25.148433] Oops: 000b [#1] SMP NOPTI
> [   25.148436] CPU: 10 PID: 1504 Comm: pulseaudio Not tainted 5.8.0-rc1+ #690
> [   25.148438] Hardware name: Gigabyte Technology Co., Ltd. AB350-Gaming/AB350-Gaming-CF, BIOS F25 01/16/2019
> [   25.148445] RIP: 0010:__memset+0x24/0x30
> [   25.148448] Code: cc cc cc cc cc cc 0f 1f 44 00 00 49 89 f9 48 89 d1 83 e2 07 48 c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 <f3> 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 f3
> [   25.148450] RSP: 0018:ffffb1a9c2497e08 EFLAGS: 00010216
> [   25.148453] RAX: 0000000000000000 RBX: ffffa089ab428000 RCX: 00000000000008a0
> [   25.148454] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffb1a9c2429000
> [   25.148456] RBP: ffffa089b0036c00 R08: ffffa089c84c56e8 R09: ffffb1a9c2429000
> [   25.148457] R10: ffffb1a9c2429000 R11: ffffa089ae3c1800 R12: 0000000000000000
> [   25.148458] R13: ffffa089aa828600 R14: ffffffffc0f82880 R15: ffffa089c5121200
> [   25.148461] FS:  00007f533f679880(0000) GS:ffffa089cee80000(0000) knlGS:0000000000000000
> [   25.148463] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   25.148464] CR2: ffffb1a9c2429000 CR3: 0000000405f42000 CR4: 00000000003406e0
> [   25.148466] Call Trace:
> [   25.148479]  snd_pcm_hw_params+0x3fd/0x490 [snd_pcm]
> [   25.148488]  snd_pcm_common_ioctl+0x1c5/0x1110 [snd_pcm]
> [   25.148496]  ? snd_pcm_info_user+0x64/0x80 [snd_pcm]
> [   25.148504]  snd_pcm_ioctl+0x23/0x30 [snd_pcm]
>
>
> Any ideas? Is it a known issue?
> It might be that some changes revealed one or more old bugs.
>
> Does the proposed patch look sane?
>
> Thanks!
>
