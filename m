Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26957C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC24206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gXgfsJJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgGODnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 23:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbgGODnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 23:43:46 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A840EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:43:46 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id f23so766023iof.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L1MZa7I2FUiTYOmy499OnTCIjSLBqRD31P7fdisA5IE=;
        b=gXgfsJJ4MdMmnwG64cIsG2YaNVG8hFB09bzTK7A8ECgTeHPHJAszwFZTdL2HmdNeKn
         /FQ/fkWjzPV54P4Hk0AEYpO5EJGVUEka4WxBI4ByQd9Hx3pE0Q2QI54lF8YpXBjj3N2V
         txcmu7iZy9WrLC9w2AjMl6lIngNd24pEUxvuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1MZa7I2FUiTYOmy499OnTCIjSLBqRD31P7fdisA5IE=;
        b=JhoIdZwaqwq6m6gha1EYcyx+8MrqQwoOqQatG4qFpFyESKQhqii3uWw40cywfZalYL
         c4HKI6P2emubUCd+JK0cW2dqQsbMMNdogE7f2oecbGYDHA0jZi7LRGQjGBDi4tQPV5+d
         kDbZG7lxvhYXFOMDt9E1dQhQH3ELI1+wtzz+fnu3AmL83+p+5JjvNDKTD9uYcp+sMGcm
         k1OjNtDGR9Qu0GtfxVbaOHKfDsneFoEbCT1RvlE7/1K4gyWCzsqvdPV12Bikt3CB4WDI
         txNqaMX9G+K5tV/llU9J5PsW/3PCt49j1l36tugi3OsQb3poKxQ6o8mVwv79prrYC3P5
         IKgA==
X-Gm-Message-State: AOAM531Yg9i61kW2BQFxDCi5lujatPNZZlBQX5q+h1H5ZQzzTPhsy36V
        Hyi37ZLGkbdNfGav1RP6OsTe2U/mFXc=
X-Google-Smtp-Source: ABdhPJwnAvjZWqlmhS5PKGaZtJiz+RLny3pnr6Jc+dWDVlmBTqMx/2ESZV7YqEsRo9s3HbZUjsZEeQ==
X-Received: by 2002:a05:6638:d96:: with SMTP id l22mr9656226jaj.120.1594784625507;
        Tue, 14 Jul 2020 20:43:45 -0700 (PDT)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id d6sm484577ilq.27.2020.07.14.20.43.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 20:43:44 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id a11so795980ilk.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:43:43 -0700 (PDT)
X-Received: by 2002:a92:de42:: with SMTP id e2mr7643677ilr.189.1594784623009;
 Tue, 14 Jul 2020 20:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200713091211.2183368-1-tientzu@chromium.org> <8a7ce34e-87c0-d224-3974-34f1877fbb0e@arm.com>
In-Reply-To: <8a7ce34e-87c0-d224-3974-34f1877fbb0e@arm.com>
From:   Claire Chang <tientzu@chromium.org>
Date:   Wed, 15 Jul 2020 11:43:31 +0800
X-Gmail-Original-Message-ID: <CALiNf2_GdC1RSLyYSu+LWXHGQZiAL69zNuW0sowuCDdRWw4HJg@mail.gmail.com>
Message-ID: <CALiNf2_GdC1RSLyYSu+LWXHGQZiAL69zNuW0sowuCDdRWw4HJg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Bounced DMA support
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>, frowand.list@gmail.com,
        hch@lst.de, m.szyprowski@samsung.com, treding@nvidia.com,
        Greg KH <gregkh@linuxfoundation.org>, saravanak@google.com,
        suzuki.poulose@arm.com, dan.j.williams@intel.com,
        heikki.krogerus@linux.intel.com, bgolaszewski@baylibre.com,
        devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, tfiga@chromium.org,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 7:40 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-07-13 10:12, Claire Chang wrote:
> > This series implements mitigations for lack of DMA access control on
> > systems without an IOMMU, which could result in the DMA accessing the
> > system memory at unexpected times and/or unexpected addresses, possibly
> > leading to data leakage or corruption.
> >
> > For example, we plan to use the PCI-e bus for Wi-Fi and that PCI-e bus
> > is not behind an IOMMU. As PCI-e, by design, gives the device full
> > access to system memory, a vulnerability in the Wi-Fi firmware could
> > easily escalate to a full system exploit (remote wifi exploits: [1a],
> > [1b] that shows a full chain of exploits; [2], [3]).
> >
> > To mitigate the security concerns, we introduce bounced DMA. The bounced
> > DMA ops provide an implementation of DMA ops that bounce streaming DMA
> > in and out of a specially allocated region. The feature on its own
> > provides a basic level of protection against the DMA overwriting buffer
> > contents at unexpected times. However, to protect against general data
> > leakage and system memory corruption, the system needs to provide a way
> > to restrict the DMA to a predefined memory region (this is usually done
> > at firmware level, e.g. in ATF on some ARM platforms).
>
> More to the point, this seems to need some fairly special interconnect
> hardware too. On typical systems that just stick a TZASC directly in
> front of the memory controller it would be hard to block DMA access
> without also blocking CPU access. With something like Arm TZC-400 I
> guess you could set up a "secure" region for most of DRAM that allows NS
> accesses by NSAID from the CPUs, then similar regions for the pools with
> NSAID access for both the respective device and the CPUs, but by that
> point you've probably used up most of the available regions before even
> considering what the firmware and TEE might want for actual Secure memory.
>
> In short, I don't foresee this being used by very many systems.
We're going to use this on MTK SoC with MPU (memory protection unit) to
restrict the DMA access for PCI-e Wi-Fi.
>
> That said,, although the motivation is different, it appears to end up
> being almost exactly the same end result as the POWER secure
> virtualisation thingy (essentially: constrain DMA to a specific portion
> of RAM). The more code can be shared with that, the better.
Could you share a bit more about the POWER secure virtualisation thingy?
>
> > Currently, 32-bit architectures are not supported because of the need to
> > handle HIGHMEM, which increases code complexity and adds more
> > performance penalty for such platforms. Also, bounced DMA can not be
> > enabled on devices behind an IOMMU, as those require an IOMMU-aware
> > implementation of DMA ops and do not require this kind of mitigation
> > anyway.
>
> Note that we do actually have the notion of bounced DMA with IOMMUs
> already (to avoid leakage of unrelated data in the same page). I think
> it's only implemented for intel-iommu so far, but shouldn't take much
> work to generalise to iommu-dma if anyone wanted to. That's already done
> a bunch of work to generalise the SWIOTLB routines to be more reusable,
> so building on top of that would be highly preferable.
Yes, I'm aware of that and I'll try to put this on top of SWIOTLB.
>
> Thirdly, the concept of device-private bounce buffers does in fact
> already exist to some degree too - there are various USB, crypto and
> other devices that can only DMA to a local SRAM buffer (not to mention
> subsystems doing their own bouncing for the sake of alignment/block
> merging/etc.). Again, a slightly more generalised solution that makes
> this a first-class notion for dma-direct itself and could help supplant
> some of those hacks would be really really good.
>
> Robin.
>
> > [1a] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_4.html
> > [1b] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_11.html
> > [2] https://blade.tencent.com/en/advisories/qualpwn/
> > [3] https://www.bleepingcomputer.com/news/security/vulnerabilities-found-in-highly-popular-firmware-for-wifi-chips/
> >
> >
> > Claire Chang (4):
> >    dma-mapping: Add bounced DMA ops
> >    dma-mapping: Add bounced DMA pool
> >    dt-bindings: of: Add plumbing for bounced DMA pool
> >    of: Add plumbing for bounced DMA pool
> >
> >   .../reserved-memory/reserved-memory.txt       |  36 +++
> >   drivers/of/address.c                          |  37 +++
> >   drivers/of/device.c                           |   3 +
> >   drivers/of/of_private.h                       |   6 +
> >   include/linux/device.h                        |   3 +
> >   include/linux/dma-mapping.h                   |   1 +
> >   kernel/dma/Kconfig                            |  17 +
> >   kernel/dma/Makefile                           |   1 +
> >   kernel/dma/bounced.c                          | 304 ++++++++++++++++++
> >   9 files changed, 408 insertions(+)
> >   create mode 100644 kernel/dma/bounced.c
> >
