Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FAEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 157D120659
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbgFHMZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:25:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40922 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbgFHMZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:25:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id t25so15072368oij.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 05:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tAGHOxBD5U35L+Ym8KTN1WsWz5xETmW1JZ5ES9tNCwg=;
        b=Ww2XVg+b/Ahw5+7UzsxS4RffswtYxDGrQLyVdNPklAGPUQ09QD67gEPnFYY2c87+J9
         fQQBR6ujxsW+axGc4CsVPj8Vp5Lta4UX3Z/xmCrqzSS74BkOGkl+vpxJ9k2YnHdQvVks
         TO9atxhxQPV44KjLpWTZv3H/bomDkc98/t4GDEYN9/b+oNkKhxGaVotR3VA6/M55yk6E
         UHwj5rv22aUonNmqH4zkXC+IfsnwK+xrpVxnEnumW+gK4qjtPjMtaeE0qsEmUdWVjB5W
         nOMIQNEErSMlSHL0YjIC/GVtuqzs8pUnCQjsL9MhI09f8Kvm+SVGpLfdN88Y6H8kN4Ky
         hGMg==
X-Gm-Message-State: AOAM531xI+fP3LI2Wj1vWbhS6+1cXgv0TkV/LfAEhgtt0xJ4otgR88mv
        uVSjO5iykKj6RV+oElZc9qlDhmLLJjh6173F16KJ7RLh
X-Google-Smtp-Source: ABdhPJx2QuTZJlEyepsOlHlVT9XLDhjjIIeM7RFdPcPPbYEzN+LJuzI+N+F93TZ5wJhjAEdyn47WZ+CGkufrLca/zog=
X-Received: by 2002:aca:4255:: with SMTP id p82mr9919971oia.153.1591619114741;
 Mon, 08 Jun 2020 05:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200608085231.8924-1-geert@linux-m68k.org> <92b53a24-2f1f-2add-6bea-eeda7317520f@arm.com>
In-Reply-To: <92b53a24-2f1f-2add-6bea-eeda7317520f@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Jun 2020 14:25:03 +0200
Message-ID: <CAMuHMdXxT5ZgcK5r0MWOk7vWVj63gmr6k3zgACe2Lew7Q4KC9w@mail.gmail.com>
Subject: Re: [PATCH] dma-pool: Fix too large DMA pools on medium systems
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        David Rientjes <rientjes@google.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Mon, Jun 8, 2020 at 2:04 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2020-06-08 09:52, Geert Uytterhoeven wrote:
> > On systems with at least 32 MiB, but less than 32 GiB of RAM, the DMA
> > memory pools are much larger than intended (e.g. 2 MiB instead of 128
> > KiB on a 256 MiB system).
> >
> > Fix this by correcting the calculation of the number of GiBs of RAM in
> > the system.
> >
> > Fixes: 1d659236fb43c4d2 ("dma-pool: scale the default DMA coherent pool size with memory capacity")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

> > --- a/kernel/dma/pool.c
> > +++ b/kernel/dma/pool.c
> > @@ -175,8 +175,8 @@ static int __init dma_atomic_pool_init(void)
> >        * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
> >        */
> >       if (!atomic_pool_size) {
> > -             atomic_pool_size = max(totalram_pages() >> PAGE_SHIFT, 1UL) *
> > -                                     SZ_128K;
> > +             unsigned long gigs = totalram_pages() >> (30 - PAGE_SHIFT);
> > +             atomic_pool_size = max(gigs, 1UL) * SZ_128K;
> >               atomic_pool_size = min_t(size_t, atomic_pool_size,
> >                                        1 << (PAGE_SHIFT + MAX_ORDER-1));
> >       }
>
> Nit: although this probably is right, it seems even less readable than

">> (x - PAGE_SHIFT)" is a commonly used construct in the kernel.

> the broken version (where at least some at-a-glance 'dimensional
> analysis' flags up "(number of pages) >> PAGE_SHIFT" as rather
> suspicious). How about a something a little more self-explanatory, e.g.:
>
>         unsigned long pages = totalram_pages() * SZ_128K / SZ_1GB;

That multiplication will overflow on 32-bit systems (perhaps even on
large 64-bit systems; any 47-bit addressing?).

        unsigned long pages = totalram_pages() / (SZ_1GB / SZ_128K);

>         atomic_pool_size = min(pages, MAX_ORDER_NR_PAGES) << PAGE_SHIFT;
>         atomic_pool_size = max_t(size_t, atomic_pool_size, SZ_128K);

I agree this part is an improvement.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
