Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16781C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F123D20578
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgGOIHK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:07:10 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34005 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgGOIHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:07:08 -0400
Received: by mail-oi1-f195.google.com with SMTP id e4so1578399oib.1;
        Wed, 15 Jul 2020 01:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o4+cKSE1t0Fpalcp0cttipzWha9ZgmeHwOg9WyBcAjE=;
        b=mEAAykT+uaaMePOnjtUhc9j/K9D1l/F1aW5dhKURyQonYfvr3JII5HAR3RV7oAM210
         oOYxv6h0kkV980AnH4BkLR2BcDhqcH0wMhy3/LwfhDM+lhxgN4PJ1eSk32J7iyuDwv2s
         h40nf8NYI5zvvDS9fm5y9/VPjvfaStyFPqOxuAdM4bmV/XaHZnmjYtnMa7nY6hkXdfBt
         SicIEBu4oISRY9zNcqFK10rEG2ikpoY1YpNdKqQFgaNRC7LCoSXh1Xu938YZynPRbFNS
         sfR+FgwdeaQI23qqGzwgGbD8MeUx54Alyqu7cOEeq8y117L9D9BQAOW/PrVrahJY423n
         RsZQ==
X-Gm-Message-State: AOAM5305jRzSnqF50Y8HIbxGEq3syc2RFKcddpSyRMyKU6K7aBp7uhFO
        A5sPRKOe/oi3r9WnYyuWvFz38+DX5I97pcMrp5k=
X-Google-Smtp-Source: ABdhPJwWoYOOZbBiuLLuZQ72HHWDYBfBiAVlhzGZ76HXOtyK/rt9Jk+VJcMxJ52P8PF5pQ72K4Cc0AEE/bhqysrl0y0=
X-Received: by 2002:a05:6808:64a:: with SMTP id z10mr6876052oih.54.1594800427676;
 Wed, 15 Jul 2020 01:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200714121856.955680-1-hch@lst.de> <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
 <20200714155914.GA24404@brightrain.aerifal.cx> <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de>
 <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
 <CAMuHMdUre2-fRgLP8YiwjAKN6J=m1vGhPSMMUdpof7jPJfcWuw@mail.gmail.com> <47673a8f-cda1-4915-df20-068acfc49892@physik.fu-berlin.de>
In-Reply-To: <47673a8f-cda1-4915-df20-068acfc49892@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Jul 2020 10:06:56 +0200
Message-ID: <CAMuHMdWP6h+6uTq--wpP7xtSRRMScqM617a9w=p_bV=w90yVtw@mail.gmail.com>
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Wed, Jul 15, 2020 at 9:37 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 7/15/20 9:27 AM, Geert Uytterhoeven wrote:
> > On Wed, Jul 15, 2020 at 1:14 AM John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> >> However, independent of Christoph's series, the kernels throws two backtraces during
> >> boot which I think should require a git bisect (unless I missed a configuration option
> >> as I trimmed down the kernel a bit to make sure it's not too big).
> >>
> >> See the traces below and let me know what you think.
> >
> >> [    1.560000] sh-sci.1: ttySC1 at MMIO 0xffeb0000 (irq = 44, base_baud = 0) is a scif
> >> [    1.560000] BUG: spinlock bad magic on CPU#0, swapper/1
> >> [    1.560000]  lock: sci_ports+0x1d8/0xb10, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> >
> > [PATCH v1] serial: core: Initialise spin lock before use in
> > uart_configure_port()
> > https://lore.kernel.org/r/20200706140036.75524-1-andriy.shevchenko@linux.intel.com
> Yes, this patch fixes this particular problem.
>
> There is just a typo in the code which causes a build problem but it's fixed by replacing
> "uport" with "port":

Oops, there's a v2 fixing that:
https://lore.kernel.org/linux-serial/20200706143548.63985-1-andriy.shevchenko@linux.intel.com/

>   CC      kernel/module.o
> drivers/tty/serial/serial_core.c: In function ‘uart_configure_port’:
> drivers/tty/serial/serial_core.c:2385:33: error: ‘uport’ undeclared (first use in this function); did you mean ‘port’?
>  2385 |    uart_any_port_spin_lock_init(uport);
>       |                                 ^~~~~
>       |                                 port
> drivers/tty/serial/serial_core.c:2385:33: note: each undeclared identifier is reported only once for each function it appears in
> make[3]: *** [scripts/Makefile.build:280: drivers/tty/serial/serial_core.o] Error 1
> make[2]: *** [scripts/Makefile.build:497: drivers/tty/serial] Error 2
> make[1]: *** [scripts/Makefile.build:497: drivers/tty] Error 2
> make[1]: *** Waiting for unfinished jobs....
>   AR      drivers/base/firmware_loader/built-in.a
>
> Will test the other changes in a minute.
>
> Can we include the serial fix?

Please be patient. I expect this to be fixed soon through the tty tree.

Note that linux-next already has an alternative fix (f38278e9b810b06a
("serial: sh-sci: Initialize spinlock for uart console")), which is
planned to be reverted once the real fix has been applied.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
