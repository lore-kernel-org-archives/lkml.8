Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA58AC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE9D20767
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504775AbgDNTax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:30:53 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:55329 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504780AbgDNTaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:30:07 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MQuwR-1jaLEZ0i2h-00NwtH for <linux-kernel@vger.kernel.org>; Tue, 14 Apr
 2020 21:30:04 +0200
Received: by mail-qk1-f172.google.com with SMTP id s63so10483733qke.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:30:04 -0700 (PDT)
X-Gm-Message-State: AGi0Pub4pMjp5p2ppQ6UuhWsUgfnW/U2f029O279AsmsgkBrx6Fy8usM
        JdnMiEIJBHbt6G6jdP0Mw+/yF5yT1K2LNPb0rIU=
X-Google-Smtp-Source: APiQypITiUtB+6fwOLBsAbHscEX27ZziBUO1YtED1jtCdBFATrhYqphhXhWEGAUqYD652cM9cUGS42BS5oByWuiE2bw=
X-Received: by 2002:a37:ba47:: with SMTP id k68mr11683991qkf.394.1586892602983;
 Tue, 14 Apr 2020 12:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200331093241.3728-1-tesheng@andestech.com> <CAK8P3a3LokurC0n9XiwtPQh9ZgQcswMKY4b+TEsQh1VgYDNeWA@mail.gmail.com>
 <20200408035118.GA1451@andestech.com> <CAK8P3a1JS3_2fWrhNTZx0eTWjJa-GTb4AscTPqydpSP5EB15Yw@mail.gmail.com>
 <20200414151748.GA5624@afzalpc>
In-Reply-To: <20200414151748.GA5624@afzalpc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Apr 2020 21:29:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0JW9x-Wk9Ec3+zLjPHbWAvPQx8MF-xe-PnWUgEjRAuTg@mail.gmail.com>
Message-ID: <CAK8P3a0JW9x-Wk9Ec3+zLjPHbWAvPQx8MF-xe-PnWUgEjRAuTg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Highmem support for 32-bit RISC-V
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Alan Kao <alankao@andestech.com>,
        Eric Lin <tesheng@andestech.com>, Gary Guo <gary@garyguo.net>,
        alex@ghiti.fr, David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>, atish.patra@wdc.com,
        yash.shah@sifive.com, Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greentime Hu <green.hu@gmail.com>, zong.li@sifive.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Df43qj2SA4S2VfPKp8EoZz7iC7KYLvuevpOVE9X1GwCJIlxOtjL
 5WQw0WxGih7qczlKYVakdqMW9lNwr/mRzPGWz7SMShqo+Q15LT1n9VSOOW8bZY9potVaKB3
 6k243y/o71F95TujfYuFin/0KS7HHgEnhNpUkwgMl5qJ6boX+Vqgb1IQzi5GnM1F1OSKL6r
 wTTuZuVwwK38nThXtvOLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p7Mmpv5kuDE=:fgZEshYEnBtw4EEttDHdka
 qh+2tN/a2FLYxjGLFedVhXCyhOcfZr0WX4gayZ3wm8LQIPWV6Vr7Jbk0sPSbDYHLgXGayduY3
 u3BUvHqNv1P0qj965m4JrEEPdnT1Gz8pBbhuHlf+wX3GNGHgTE31NRTOH/gYk+DgM/2UBQfiw
 hhGAPpa+yscuRaUm3csBqmxYlHUG5shWpycCvRi0Yr93Z3ubOH7PN09YXILeJNgr274vgpZfZ
 seWfejrRRdgmDBpDCBUitJ/2jLkTxh3gD9KDADGdPybzfOh+McyH+6Jkp8z882gl/0kTaUM7i
 pmHTLgJJf7jcj7ewukzM/aKoaB89KE7A7b1dyb/ZiJ5tdSFLj2Y/CulgpC8/Unk9E7JgRv3rk
 YvV7WJZ7aoMvv7U5+CBDLtJhHWcRjfRogiJQItEpv+vL0IRgIoaCZgl7Ntl1Nbxdh0D8XwKIX
 Q9HNIzkJJqO+RdipmSEXNcn0YBhkaameqYI22TRMglhSvhYoWKqBRCRSVUPvLtVkd+DXUl/zi
 owdOmR3+Twu/1f30Kdw0oX79rKh0tRXS8jy5RrqjEwIsnpFgb/X1KEV7ST1zriw11GF88ov4I
 mw9G6PAsp9azclU2AjxDEBI7o1eZUPuj08wOMcpIXcPP+tR6Y/1LQ2/QMeI8T1Ordb8mYEVL1
 GHoe+qbOR1f7JSAAUUZoRoWvyVYlGqIuMV60WA1XJRIVXGNzMjWOwTkpYDWlqSsd1G6SmXjXJ
 t32MvRQXZeZpCiZpvS+jWJYFkqaOzNxdEH6Ldp0Terxhfb0S75PMO9pjwL65jLF8YNjJjNoH3
 913Wli7tWmf+B4BLz7Gu+lEcKvGq+FMjlPr3tI/68pHtAX9xDI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 5:17 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
>
> + rmk
>
> Hi Arnd,
>
> On Wed, Apr 08, 2020 at 04:40:17PM +0200, Arnd Bergmann wrote:
>
> > No code yet, so far not much more than the ideas that I listed. We
> > are currently looking for someone interested in doing the work
> > or maybe sponsoring it if they have a strong interest.
>
> If no one have yet taken it up, i am interested in doing the work, i
> will sponsor myself :). i will proceed at a slow pace without derailing
> my other things normal.
>
> To keep expectations realistic: i have not yet taken task of this
> complexity, it is more of a learning for me. My familiarity with Linux
> at the ARM architecture level is mostly on no-MMU (Cortex-M), have not
> worked so far seriously on MMU Linux at the ARM architectural level,
> though used to go through ARM ARM v7-AR at times.

Thanks for offering to help, it's very much appreciated. Let me know how
it goes and if you have any more detailed questions.

> i have a few 32-bit ARM Cortex-A (A5, A8 & A9) boards, maximum RAM 1G,
> none have LPAE, seems i have to buy one for this purpose.

I would recommend starting in a qemu emulated system on a PC host,
you can just set it to emulate a Cortex-A15 or A7, and you can attach
gdb to the qemu instance to see where it crashes (which it inevitably
will).

You can also start by changing the functions in asm/uaccess.h to
use the linear kernel mapping and memcpy(), like the version in
arch/um/kernel/skas/uaccess.c does. This is slow, but will work on
regardless of whether user space is mapped, and you can do a
generic implementation that works on any architecture and put that
into include/asm-generic/uaccess.h.

A second step after that could be to unmap user space when entering
the kernel, without any change in the memory layout, this is still
mostly hardware independent and could easily be done in qemu
or any 32-bit ARM CPU.

Another thing to try early is to move the vmlinux virtual address
from the linear mapping into vmalloc space. This does not require
LPAE either, but it only works on relatively modern platforms that
don't have conflicting fixed mappings there.

If you get that far, I'll happily buy you a Raspberry Pi 4 with 4GB
for further experiments ;-)
That one can run both 64-bit and 32-bit kernels (with LPAE),
so you'd be able to test the limits and not rely on qemu to find
all bugs such as missing TLB flushes or barriers.

        Arnd
