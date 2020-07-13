Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C28C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C6A2076D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594655874;
	bh=yaIr3W3gRNyeiwvDjKU5N+IKZQj4ZrZ+IUKbWI+E60o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i7Txei2rEVb0Vx+5VFvzPqBlV2vSxTB6yGb36JgE31Ug7Tbj4HsxIMj6L4E3CiPmR
	 nBeAkFXFzEcnSejknqzJILzdNPPeW3zPZ+ybu+YFi2I2VZW5GOjCdgGFxYXE8YFLkd
	 PutSy8UTKrqG+jtFAYdLG09lmc8K2eowzVHpNXbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgGMP5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:57:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbgGMP5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:57:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D55FE2068F;
        Mon, 13 Jul 2020 15:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594655872;
        bh=yaIr3W3gRNyeiwvDjKU5N+IKZQj4ZrZ+IUKbWI+E60o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJ1fJ3vuXCvpwl6tcgdeYo4tlGvtfPRux44gveEKYvl3IWk4CHicfRtfCLpBRtoQU
         KoyR1iF6qU4nEtMY2hNBipSi2CGBHJ84s01SADiHpMRIIHJhNAa1M71YfuU33M2t3K
         RFSGyjA2mvNotQOghu16p04fvi5NhuyVGse6O7AA=
Date:   Mon, 13 Jul 2020 17:57:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai,
        Ofir Bitton <obitton@habana.ai>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH 1/3] habanalabs: implement dma-fence mechanism
Message-ID: <20200713155752.GC267581@kroah.com>
References: <20200713155424.24721-1-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713155424.24721-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 06:54:22PM +0300, Oded Gabbay wrote:
> From: Ofir Bitton <obitton@habana.ai>
> 
> Instead of using standard dma-fence mechanism designed for GPU's, we
> introduce our own implementation based on the former one. This
> implementation is much more sparse than the original, contains only
> mandatory functionality required by the driver.

Sad you can't use the in-kernel code for this, I really don't understand
what's wrong with using it as-is.

Daniel, why do we need/want duplicate code floating around in the tree
like this?

Copying code leads to errors, here's some documentation ones:

> --- /dev/null
> +++ b/drivers/misc/habanalabs/hl_dma_fence.c
> @@ -0,0 +1,338 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Fence mechanism for dma-buf and to allow for asynchronous dma access

Is that what this still does?

> + *
> + * Copyright (C) 2012 Canonical Ltd
> + * Copyright (C) 2012 Texas Instruments
> + *
> + * Authors:
> + * Rob Clark <robdclark@gmail.com>
> + * Maarten Lankhorst <maarten.lankhorst@canonical.com>
> + *
> + * The dma_fence module is a copy of dma-fence at drivers/dma-buf.

"The hl_dma_fence" module...

And is it a stand-alone module?  Or just a single file?

> + * This was done due to an explicit request by GPU developers who asked not
> + * to use the dma-buf module because we aren't part of DRM subsystem.

Why is dma-buf only for use for DRM?

If it is, should the symbol namespace be set to that to catch users that
want to use it for their own code?

> + * This copy was stripped from all extra features that habanalabs driver
> + * doesn't use, including the uapi interface dma-buf exposes.
> + * In addition, we removed the callbacks because the only usage is from inside
> + * habanalabs driver
> + */
> +
> +#include "hl_dma_fence.h"
> +#include "habanalabs.h"
> +#include <linux/slab.h>
> +#include <linux/export.h>
> +#include <linux/atomic.h>
> +#include <linux/sched/signal.h>
> +
> +/**
> + * DOC: DMA fences overview
> + *
> + * DMA fences, represented by &struct hl_dma_fence, are the kernel internal
> + * synchronization primitive for DMA operations like GPU rendering, video
> + * encoding/decoding, or displaying buffers on a screen.

I don't think this is correct anymore, right?  :(

> --- /dev/null
> +++ b/drivers/misc/habanalabs/hl_dma_fence.h
> @@ -0,0 +1,148 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Fence mechanism for dma-buf to allow for asynchronous dma access
> + *
> + * Copyright (C) 2012 Canonical Ltd
> + * Copyright (C) 2012 Texas Instruments
> + *
> + * Authors:
> + * Rob Clark <robdclark@gmail.com>
> + * Maarten Lankhorst <maarten.lankhorst@canonical.com>
> + *
> + * The dma_fence module is a copy of dma-fence at drivers/dma-buf.

Same comments here for the .h file.

thanks,

greg k-h
