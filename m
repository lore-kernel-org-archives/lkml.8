Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1ECC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A9852075D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="buAoDH03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgGMSeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 14:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgGMSeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 14:34:24 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6E3C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 11:34:24 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id w1so5329ooj.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 11:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZrG1wsAq75xfqZ11asvAsoCGleasUI5GMuK6EKtW4Gc=;
        b=buAoDH03jDeUkM8GIzotcWgkDDUE7qEXlJJ3oU63qJKjMiatqgjfp7k3zYvOW/Ds4i
         H+KHJk7xPUxALL2YV3NRvtYHPav+ocOdsAVByFgP9w8WKQwtDUKk9fpeJPMWYzUG7rA5
         dtOMtFIxXUBwJnlz25ulam2zueVPaN4ylRlUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZrG1wsAq75xfqZ11asvAsoCGleasUI5GMuK6EKtW4Gc=;
        b=qjwwI1+Np7nadGzQWHVRgMqBUZPq87eVJf/KDY0LGPrEZAkjZJhIHLahHsg3Dq49+9
         bGJR5COSbV3y3F2SR3GAomzVEYsAu07lBHhhGjHxEtf2E9JPpd09fBAR0ORF4bDWXgmv
         trnuJti2M6O+oNb/Iyc/b18TpVeXivKgFmGc8e+xBhWE+PKd+C70ZX98G4JIHsjU2n4s
         prhs5nBR1YPCUAeSgplHTJcl51O9a+BLttBY7F+Vz/iWmDz5+zhEa1sqYINRIBJ68wne
         ce8F1X/HKD9eSS2OQgiPMJ5jgLDaugsDo8g4afzlqTtXafEYTfZ05K6mZwqqRqMga22e
         c50w==
X-Gm-Message-State: AOAM532LjfL1OwSnCzImC9dzEaqQljG945dJuRaohluROiyPynERE+1X
        Fy0JFPNmi5Tn2/fl2VjEhams0pXNW1p1c5wBqM45jQ==
X-Google-Smtp-Source: ABdhPJy2rc5iPPPfYmFY5mzAlRBktV2hfFty9WA/ayKRUvPrkhlrVZZif6Y9GtMF4kCwzMT88RmB0iJyzYwmJFEwGyU=
X-Received: by 2002:a4a:9653:: with SMTP id r19mr1161521ooi.85.1594665263951;
 Mon, 13 Jul 2020 11:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200713155424.24721-1-oded.gabbay@gmail.com> <20200713155752.GC267581@kroah.com>
In-Reply-To: <20200713155752.GC267581@kroah.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 13 Jul 2020 20:34:12 +0200
Message-ID: <CAKMK7uH=Ch4ce-9D5e-RvVwq_oK6Doqtq5QbvpmQ8uPWkMCi2w@mail.gmail.com>
Subject: Re: [PATCH 1/3] habanalabs: implement dma-fence mechanism
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 5:57 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 13, 2020 at 06:54:22PM +0300, Oded Gabbay wrote:
> > From: Ofir Bitton <obitton@habana.ai>
> >
> > Instead of using standard dma-fence mechanism designed for GPU's, we
> > introduce our own implementation based on the former one. This
> > implementation is much more sparse than the original, contains only
> > mandatory functionality required by the driver.
>
> Sad you can't use the in-kernel code for this, I really don't understand
> what's wrong with using it as-is.
>
> Daniel, why do we need/want duplicate code floating around in the tree
> like this?

The rules around dma-fence are ridiculously strict, and it only makes
sense to inflict that upon you if you actually want to participate in
the cross driver uapi built up around dma-buf and dma-fence.

I've recently started some lockdep annotations to better enforce these
rules (and document them), and it's finding tons of subtle bugs even
in drivers/gpu (and I only just started with annotating drivers:

https://lore.kernel.org/dri-devel/20200707201229.472834-1-daniel.vetter@ffwll.ch/

You really don't want to deal with this if you don't have to. If
drivers/gpu folks (who created this) aren't good enough to understand
it, maybe it's not a good idea to sprinkle this all over the tree. And
fundamentally all this is is a slightly fancier struct completion. Use
that one instead, or a wait_queue.

I discussed this a bit with Oded, and he thinks it's easier to
copypaste and simplify, but given that all other drivers seem to get
by perfectly well with completion or wait_queue, I'm not sure that's a
solid case.

Also adding Jason Gunthorpe, who very much suggested this should be
limited to dma-buf/gpu related usage only.

> Copying code leads to errors, here's some documentation ones:

Yeah except here reusing code without understanding what it does and
how it should be used leads to error :-) At least given by the
drivers/gpu track record, I'm pretty sure sprinkling my new dma_fence
lockdep annotations would lead to lots of splats.

Cheers, Daniel

>
> > --- /dev/null
> > +++ b/drivers/misc/habanalabs/hl_dma_fence.c
> > @@ -0,0 +1,338 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Fence mechanism for dma-buf and to allow for asynchronous dma access
>
> Is that what this still does?
>
> > + *
> > + * Copyright (C) 2012 Canonical Ltd
> > + * Copyright (C) 2012 Texas Instruments
> > + *
> > + * Authors:
> > + * Rob Clark <robdclark@gmail.com>
> > + * Maarten Lankhorst <maarten.lankhorst@canonical.com>
> > + *
> > + * The dma_fence module is a copy of dma-fence at drivers/dma-buf.
>
> "The hl_dma_fence" module...
>
> And is it a stand-alone module?  Or just a single file?
>
> > + * This was done due to an explicit request by GPU developers who asked not
> > + * to use the dma-buf module because we aren't part of DRM subsystem.
>
> Why is dma-buf only for use for DRM?
>
> If it is, should the symbol namespace be set to that to catch users that
> want to use it for their own code?
>
> > + * This copy was stripped from all extra features that habanalabs driver
> > + * doesn't use, including the uapi interface dma-buf exposes.
> > + * In addition, we removed the callbacks because the only usage is from inside
> > + * habanalabs driver
> > + */
> > +
> > +#include "hl_dma_fence.h"
> > +#include "habanalabs.h"
> > +#include <linux/slab.h>
> > +#include <linux/export.h>
> > +#include <linux/atomic.h>
> > +#include <linux/sched/signal.h>
> > +
> > +/**
> > + * DOC: DMA fences overview
> > + *
> > + * DMA fences, represented by &struct hl_dma_fence, are the kernel internal
> > + * synchronization primitive for DMA operations like GPU rendering, video
> > + * encoding/decoding, or displaying buffers on a screen.
>
> I don't think this is correct anymore, right?  :(
>
> > --- /dev/null
> > +++ b/drivers/misc/habanalabs/hl_dma_fence.h
> > @@ -0,0 +1,148 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Fence mechanism for dma-buf to allow for asynchronous dma access
> > + *
> > + * Copyright (C) 2012 Canonical Ltd
> > + * Copyright (C) 2012 Texas Instruments
> > + *
> > + * Authors:
> > + * Rob Clark <robdclark@gmail.com>
> > + * Maarten Lankhorst <maarten.lankhorst@canonical.com>
> > + *
> > + * The dma_fence module is a copy of dma-fence at drivers/dma-buf.
>
> Same comments here for the .h file.
>
> thanks,
>
> greg k-h



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
