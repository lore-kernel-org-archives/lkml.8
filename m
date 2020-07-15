Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF141C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96AC8206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgGOH1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:27:22 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40164 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgGOH1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:27:21 -0400
Received: by mail-oi1-f193.google.com with SMTP id t198so1474639oie.7;
        Wed, 15 Jul 2020 00:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOG5hbXf9gCS3fAC+6osqlmvxreRnYDSVs3PZp8A2Sk=;
        b=hv7p5ghhPWVZXDqjylFDkqujCrOYgof6iXyymJIXx3A6UeFOBwtt0RGH2i7Xd6xahL
         9xzLw4gVOdzgHXS5b0ypviOG+1WBwpieui2Ax45GIpkJVscCxUCYk5hJmq5LDygxHl2A
         hXm0N2Ni7MtiupVCoBSylQZdGG+8ttow+VLnDSX6VysZie2iRKPeKVg6Z/fsB9WflilC
         62ASTboooaR3fzCKUXHC8wxFPbMBpHChvom5lkbNGLArD5AArobcvmTtkeIh2d93ZSvI
         eYJ/ACIKdYNWHI2dH6D+dR3kdN1gd+Fg6eJ5MhSo/cGj+LrJjh/j6ql+gJu+RUC1yPxD
         ovBw==
X-Gm-Message-State: AOAM533VeF1Wbq2sQZ68IER1rB+rkL4CBK+D1aXxR+S0gNl7D8L2hZPq
        D7wf64kk+WwIa4ERn+NyX/LJFy+mOHpRb79sWbVsGJD1ohM=
X-Google-Smtp-Source: ABdhPJwAch/u3YbK4xUzI/NXXwiBhJyutH5sGUCIrTLZjgDyBAQItkSdXa9uWzVCUnTwfy8dDIK13opWQ8gKuhO8N1M=
X-Received: by 2002:a05:6808:64a:: with SMTP id z10mr6792545oih.54.1594798040215;
 Wed, 15 Jul 2020 00:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200714121856.955680-1-hch@lst.de> <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
 <20200714155914.GA24404@brightrain.aerifal.cx> <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de>
 <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
In-Reply-To: <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Jul 2020 09:27:08 +0200
Message-ID: <CAMuHMdUre2-fRgLP8YiwjAKN6J=m1vGhPSMMUdpof7jPJfcWuw@mail.gmail.com>
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Wed, Jul 15, 2020 at 1:14 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> However, independent of Christoph's series, the kernels throws two backtraces during
> boot which I think should require a git bisect (unless I missed a configuration option
> as I trimmed down the kernel a bit to make sure it's not too big).
>
> See the traces below and let me know what you think.

> [    1.560000] sh-sci.1: ttySC1 at MMIO 0xffeb0000 (irq = 44, base_baud = 0) is a scif
> [    1.560000] BUG: spinlock bad magic on CPU#0, swapper/1
> [    1.560000]  lock: sci_ports+0x1d8/0xb10, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0

[PATCH v1] serial: core: Initialise spin lock before use in
uart_configure_port()
https://lore.kernel.org/r/20200706140036.75524-1-andriy.shevchenko@linux.intel.com

> [    1.560000] CPU: 0 PID: 1 Comm: swapper Not tainted 5.8.0-rc5-00026-g22b7a96ece82 #3
> [    1.560000] Stack: (0x9f445ce8 to 0x9f446000)
> [    1.560000] 5ce0:
> [    1.560000]
> [    1.560000]
> [    1.560000] 80260daa
> [    1.560000] 9f445cfc
> [    1.560000] 80048fd8
> [    1.560000] 8096c158
> [    1.560000] 805ab908
> [    1.560000] 8004449c

Any plans to take "[PATCH v2 0/9] sh: Modernize printing of kernel messages"?
https://lore.kernel.org/r/20200617143639.18315-1-geert+renesas@glider.be


> [    5.464000] WARNING: CPU: 0 PID: 1 at mm/slab.c:2589 cache_alloc_refill+0x216/0x6a0
> [    5.464000] Modules linked in:
> [    5.464000]
> [    5.464000] CPU: 0 PID: 1 Comm: swapper Not tainted 5.8.0-rc5-00026-g22b7a96ece82 #3
> [    5.464000] PC is at cache_alloc_refill+0x216/0x6a0
> [    5.464000] PR is at kmem_cache_alloc+0xd6/0x128
> [    5.464000] PC  : 800ec0d2 SP  : 9f445e68 SR  : 400080f0
> [    5.464000] TEA : c00c30d0
> [    5.464000] R0  : 8062724c R1  : 8000fee8 R2  : 9f403540 R3  : 00000100
> [    5.464000] R4  : 9f403500 R5  : 00000000 R6  : 8068d5b0 R7  : 007fffff
> [    5.464000] R8  : 0000000c R9  : 9f403500 R10 : 8096fc0c R11 : 80044410
> [    5.464000] R12 : 9f405060 R13 : 00000dc0 R14 : 9f445e68
> [    5.464000] MACH: 10623bba MACL: 00000cc0 GBR : 2957bd58 PR  : 800ec80a
> [    5.464000]
> [    5.464000] Call trace:
> [    5.464000]  [<(ptrval)>] _raw_spin_unlock_irqrestore+0x0/0x54
> [    5.464000]  [<(ptrval)>] _raw_spin_lock_irqsave+0x0/0x44
> [    5.464000]  [<(ptrval)>] kmem_cache_alloc+0xd6/0x128
> [    5.464000]  [<(ptrval)>] arch_local_irq_restore+0x0/0x2c
> [    5.464000]  [<(ptrval)>] __raw_spin_lock_init+0x0/0x1c
> [    5.464000]  [<(ptrval)>] pgd_alloc+0x10/0x24

Does commit 73c348f31b63d28d ("sh: Fix unneeded constructor in page
table allocation") in next-20200710 and later fix that?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
