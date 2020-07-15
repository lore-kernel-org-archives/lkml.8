Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB62C433FB
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E25F20657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YEe2issc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgGOJEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730475AbgGOJEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:04:51 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53603C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:04:51 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id o3so1308002ilo.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q4dxg/x+C61ezLjqHNaCCzjzXw07QWDdBXsi9fVkAUU=;
        b=YEe2issca20y2/l73T3sa81rOD0zgi1OUm8I/tbIAEmNaSjKhPdRRwJBKafc2gc3jk
         xDQYds+jIMarrr7rQWr59jGk4zxqH1Wu2H5gqoNbIV8k/iPjTfSnbsRa7W3NEOcMK3up
         2LgACIRQucnwj+gcTH6lQJtscwwtIK86qjmEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q4dxg/x+C61ezLjqHNaCCzjzXw07QWDdBXsi9fVkAUU=;
        b=MbDHgLfgofs/+wBH7Ap43JftKaVLo5FgvTH3IGIB1A/mn3N/2bjnc0yjiEaR96yCBx
         ZySqn08nwISCpeeOSxCvEF827IACJ9I58CqaO21y5a7YXXGGjQLP4dQAD3r0aVN+3mdK
         W4PrOW0GZhJfiZZ3fR4dlGbFXPM7pm0ZR13jHhMQ2teU9hT8ujv5Z3gu989+IE++nSXH
         XWyDJRE74V3dVD+VGJT6Qv+K/NeLD73tfXjOyBJA7jvAgFowUZQIIRqvVgirnQMtCxIX
         J4Y22wiZ9maM3nL9dS294vnTWznPrygtiMmY/GPw2tuc0oiqJ83T7Wmaj+sqtf8V72Ui
         EcdQ==
X-Gm-Message-State: AOAM533j+nfKpV+Sy9pQPBMTbwVT8lTBOSCQKzbui1vcWM60VrSDC/J4
        6Bm1DDtx5lMPW3Ba5SfYCTFRUenmPng=
X-Google-Smtp-Source: ABdhPJxrlHdiHSw4qIAQozA6QPaLfo4sO39kilXZXIAzNFNdnarBA3GONzBTywg63aHdEirQDHzWOQ==
X-Received: by 2002:a05:6e02:487:: with SMTP id b7mr9294174ils.100.1594803889939;
        Wed, 15 Jul 2020 02:04:49 -0700 (PDT)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com. [209.85.166.182])
        by smtp.gmail.com with ESMTPSA id t11sm818572ils.3.2020.07.15.02.04.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 02:04:48 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id a11so1360556ilk.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:04:48 -0700 (PDT)
X-Received: by 2002:a92:de42:: with SMTP id e2mr8593960ilr.189.1594803887732;
 Wed, 15 Jul 2020 02:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200713091211.2183368-1-tientzu@chromium.org>
 <20200713091211.2183368-2-tientzu@chromium.org> <4a2451f9-57d8-2e83-e1d6-f144f37173c0@arm.com>
 <20200714110141.GD16178@lst.de> <CALiNf2-9b5LMjv+KCqFJ9oz2FocT6oQ1zVY_MBaFgNG1DQxZ=Q@mail.gmail.com>
In-Reply-To: <CALiNf2-9b5LMjv+KCqFJ9oz2FocT6oQ1zVY_MBaFgNG1DQxZ=Q@mail.gmail.com>
From:   Claire Chang <tientzu@chromium.org>
Date:   Wed, 15 Jul 2020 17:04:36 +0800
X-Gmail-Original-Message-ID: <CALiNf28LVobHKLuXAf7P7Avi6n1oU+tbbFJ55ZPanJuq8Q1Ysg@mail.gmail.com>
Message-ID: <CALiNf28LVobHKLuXAf7P7Avi6n1oU+tbbFJ55ZPanJuq8Q1Ysg@mail.gmail.com>
Subject: Re: [PATCH 1/4] dma-mapping: Add bounced DMA ops
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>, frowand.list@gmail.com,
        m.szyprowski@samsung.com, treding@nvidia.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>, suzuki.poulose@arm.com,
        dan.j.williams@intel.com, heikki.krogerus@linux.intel.com,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, tfiga@chromium.org,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 11:46 AM Claire Chang <tientzu@chromium.org> wrote:
>
> On Tue, Jul 14, 2020 at 7:01 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Mon, Jul 13, 2020 at 12:55:43PM +0100, Robin Murphy wrote:
> > > On 2020-07-13 10:12, Claire Chang wrote:
> > >> The bounced DMA ops provide an implementation of DMA ops that bounce
> > >> streaming DMA in and out of a specially allocated region. Only the
> > >> operations relevant to streaming DMA are supported.
> > >
> > > I think there are too many implicit assumptions here - apparently that
> > > coherent allocations will always be intercepted by
> > > dma_*_from_dev_coherent(), and that calling into dma-direct won't actually
> > > bounce things a second time beyond where you thought they were going,
> > > manage coherency for a different address, and make it all go subtly wrong.
> > > Consider "swiotlb=force", for instance...
If I understand it correctly, reusing SWIOTLB won't prevent the
coherent allocations
from always being intercepted by dma_*_from_dev_coherent(), right?
Since we can't bounce the coherent memory, we still need to rely on
dma_*_from_dev_coherent() and a reserved-memory region for coherent DMA to
restrict the device DMA access.

As for calling into dma-direct, in this version, I use set_dma_ops to set the
dma_bounced_ops, so I just bypass dma-direct and SWIOTLB. "swiotlb=force"
won't bounce things a second time and the data will still be bounced
to the region
set in dts.
Besides, I did a quick search and found that only two *-iommu.c directly use
dma_direct_map_page.
https://elixir.bootlin.com/linux/latest/C/ident/dma_direct_map_page
Since bounced DMA is to mitigate the lack of DMA access control on systems
without an IOMMU (see patch#4, only call of_dma_set_bounce_buffer for the
devices not behind an IOMMU), can we assume no one will use dma-direct?
(I understand that if we build bounced DMA on top of SWIOTLB, we don't need
to worry about this.)

> > >
> > > Again, plumbing this straight into dma-direct so that SWIOTLB can simply
> > > target a different buffer and always bounce regardless of masks would seem
> > > a far better option.
> >
> > I haven't really had time to read through the details, but I agree that
> > any bouncing scheme should reuse the swiotlb code and not invent a
> > parallel infrastructure.
> Thanks for the feedback. I'll try to reuse SWIOTLB.
My current plan is to first change the buffers management logic in SWIOTLB to
use gen_pool like this patch (i.e., gen_pool_dma_alloc, gen_pool_free, ect), and
then make SWIOTLB use the device's private pool for regular DMA to/from system
memory if possible.
Does this sound right?

Thanks!
