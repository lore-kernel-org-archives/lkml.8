Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A574C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C9EF2063A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7t4t8R2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgHRU4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgHRU4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 16:56:11 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDC4C061343
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 13:56:10 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id u24so18020386oic.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 13:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVlaqaJEkLaogLxHkb59x+3913QcwhMo1tlZOm9AT0s=;
        b=F7t4t8R2e65gCr9vdIxnNuliGDt2ahdeDAfavI7tANLzu2aQ0/Dm9nm68MjGmfDIEn
         +INKamv7mBD5XwNAn5unHK7F4wcGpKBzLWiimwLuJuMjurd9FzQdSLd4A3XwNq4oZgON
         0mJ1mp3STPu72DoEU6s2oGDaAPZc1d9iqm6UukG6YQUqg1rxoULI89OmVCHGV1I5M6PW
         LehxdYwb6AkyftI67q/r18iiMmsk+U2qcn2C0MXIx9alBu+BWFFFFCArG9HhsRjc+0Ow
         eHMsfDTsciu66LcErJpINTzl2QMt9ciDVh42trJ4L0rc+/x0fLt7IxkYDBuYtyO6wsbj
         4YsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVlaqaJEkLaogLxHkb59x+3913QcwhMo1tlZOm9AT0s=;
        b=uSf5nT4mYyZCTBdwioPP8uk1m/pJ23GelfTSA8KwiIFW2bjHASpTr+hjJtMXgNQjnA
         wAdmGOPUnYmEnbzgQDa+8fTtU90N2XkHilifpdAvm+6fODJPbWyMPdbhWJmP+9V/NzDI
         FjilpIad3LgKuPmx+jDTBIufXPCaUeHhG2bYnrv7pzYImXKCgB2mGkxyf1SemavKJj0X
         UgpytkB1W6wKPEVhCu5Efu2eygYJn44aw3i+KzXWrbi0dQqj16q7KaVasb9MO/t36Iyp
         eplm/vAHo922YDEaiF2ZGkS0RL2E7Oq8s43cY/Aiv9BCDf1jiKQekeSLOPXJm1ur3RqJ
         6R4g==
X-Gm-Message-State: AOAM531xTofVQkmGufvrYbSGTKZzQE/5eeWZ4+ZvEGo4/FchEi37kvd8
        QPno1ziMdptrEr1jrb8naJleEvA52UXj0xQpfWfm1Q==
X-Google-Smtp-Source: ABdhPJwbu8MfbO3BaVc7WQtY8gCaYLyN64siinjCbEFyrvhEdhXeVpE86gO8wO6noTbeRWOhZomU5kKcgOZGItaZTUA=
X-Received: by 2002:aca:1117:: with SMTP id 23mr1367198oir.97.1597784170084;
 Tue, 18 Aug 2020 13:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200818074547epcas2p21e0c2442873d03800c7bc2c3e76405d6@epcas2p2.samsung.com>
 <20200818080415.7531-1-hyesoo.yu@samsung.com>
In-Reply-To: <20200818080415.7531-1-hyesoo.yu@samsung.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 18 Aug 2020 13:55:59 -0700
Message-ID: <CALAqxLWRLOqNrhhpjfqfztsWTib8SQQgeX3jJM+_ij_CvC6hiw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Chunk Heap Support on DMA-HEAP
To:     Hyesoo Yu <hyesoo.yu@samsung.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        iamjoonsoo.kim@lge.com, joaodias@google.com,
        linux-mm <linux-mm@kvack.org>,
        KyongHo Cho <pullip.cho@samsung.com>,
        Suren Baghdasaryan <surenb@google.com>, vbabka@suse.cz,
        "Andrew F. Davis" <afd@ti.com>,
        "(Exiting) Benjamin Gaignard" <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Christian Koenig <christian.koenig@amd.com>,
        linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:45 AM Hyesoo Yu <hyesoo.yu@samsung.com> wrote:
>
> These patch series to introduce a new dma heap, chunk heap.
> That heap is needed for special HW that requires bulk allocation of
> fixed high order pages. For example, 64MB dma-buf pages are made up
> to fixed order-4 pages * 1024.
>
> The chunk heap uses alloc_pages_bulk to allocate high order page.
> https://lore.kernel.org/linux-mm/20200814173131.2803002-1-minchan@kernel.org
>
> The chunk heap is registered by device tree with alignment and memory node
> of contiguous memory allocator(CMA). Alignment defines chunk page size.
> For example, alignment 0x1_0000 means chunk page size is 64KB.
> The phandle to memory node indicates contiguous memory allocator(CMA).
> If device node doesn't have cma, the registration of chunk heap fails.
>
> The patchset includes the following:
>  - export dma-heap API to register kernel module dma heap.
>  - add chunk heap implementation.
>  - document of device tree to register chunk heap
>
> Hyesoo Yu (3):
>   dma-buf: add missing EXPORT_SYMBOL_GPL() for dma heaps
>   dma-buf: heaps: add chunk heap to dmabuf heaps
>   dma-heap: Devicetree binding for chunk heap

Hey! Thanks so much for sending this out! I'm really excited to see
these heaps be submitted and reviewed on the list!

The first general concern I have with your series is that it adds a dt
binding for the chunk heap, which we've gotten a fair amount of
pushback on.

A possible alternative might be something like what Kunihiko Hayashi
proposed for non-default CMA heaps:
  https://lore.kernel.org/lkml/1594948208-4739-1-git-send-email-hayashi.kunihiko@socionext.com/

This approach would insteal allow a driver to register a CMA area with
the chunk heap implementation.

However, (and this was the catch Kunihiko Hayashi's patch) this
requires that the driver also be upstream, as we need an in-tree user
of such code.

Also, it might be good to provide some further rationale on why this
heap is beneficial over the existing CMA heap?  In general focusing
the commit messages more on the why we might want the patch, rather
than what the patch does, is helpful.

"Special hardware" that doesn't have upstream drivers isn't very
compelling for most maintainers.

That said, I'm very excited to see these sorts of submissions, as I
know lots of vendors have historically had very custom out of tree ION
heaps, and I think it would be a great benefit to the community to
better understand the experience vendors have in optimizing
performance on their devices, so we can create good common solutions
upstream. So I look forward to your insights on future revisions of
this patch series!

thanks
-john
