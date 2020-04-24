Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC95C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E46BD20857
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bsc5d75V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDXUuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgDXUuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:50:03 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC458C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:50:02 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id y10so10913808uao.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJeS5rPd5QBiW9yuQQoiyZe9LracJA5NUhevSqY2SM4=;
        b=bsc5d75VyY0RYx5b5HGauIU4/ycK/2kiMjAD0CfoKTcN53ZTdIJVwDYW3H4JgdAJdr
         z/35tht2bxPjxQCt1nVihs4TKy55nGR0COH1TpoOsnywIkxeRouKXN+OuGbl845D/ja2
         KdzPQW05FIvprL4bQUqxchFYnmRXLSndHvAzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJeS5rPd5QBiW9yuQQoiyZe9LracJA5NUhevSqY2SM4=;
        b=sNicRUQhrBYo6GvNUPpgxuj8hFxtZ2+c+LRWkby98qN8Ssi2JJ3MAmxpEBUY1Hp6ti
         Ty0cIT9Tn01IeWi/9HPpDA6H+BcxcR4QFnuPJw4DEQSuG4Y35G2p45+cQZ/GOQJbXuJC
         ZFdnhJ4pdvML3uBzHRxQx1n3sESROfnyT2ZPLb8IxFFvBkyO+DEODoQDovj3Jgr2ghkb
         m0dxsJYbPdZI0HHZlkhTDS3zBr+exSy+6Y9q+vPCbloMs0m+o2peBD8A8lp5j++F4eej
         Erl/D8335SWGy0Av34Ak615KNj1JgK1G+3BJRmy8PYcuuSqocI41MSwJXxBspvZVxIL5
         yLHw==
X-Gm-Message-State: AGi0PuaaBtZ5fu6KdLVd//n5kbIsVZGVShe6w7QT3jNP/o3WdrDBbh8S
        6gWis9EHzESMsT4Gh4KfLc0f1TtU6Dk=
X-Google-Smtp-Source: APiQypLNCm7iauTsM7JVvInNgWGvG3uRayO9e2op2hDvPPo1AsvrVi1bSFTWdqjzrmq7HEelbzMc/w==
X-Received: by 2002:a9f:3c0c:: with SMTP id u12mr2585800uah.18.1587761401165;
        Fri, 24 Apr 2020 13:50:01 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id i4sm1424519uap.11.2020.04.24.13.49.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 13:50:00 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id i22so10885266uak.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:49:59 -0700 (PDT)
X-Received: by 2002:a05:6102:4d:: with SMTP id k13mr9739534vsp.198.1587761399251;
 Fri, 24 Apr 2020 13:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Apr 2020 13:49:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W5FujyJMoH-TdQXxAYBvBO=rhjNo1EAv7xJ=R8eeaXZQ@mail.gmail.com>
Message-ID: <CAD=FV=W5FujyJMoH-TdQXxAYBvBO=rhjNo1EAv7xJ=R8eeaXZQ@mail.gmail.com>
Subject: Re: [RFC Patch v1 0/4] arm64: Introduce new IPI as IPI_CALL_NMI_FUNC
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, julien.thierry.kdev@gmail.com,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 24, 2020 at 4:11 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> With pseudo NMIs support available its possible to configure SGIs to be
> triggered as pseudo NMIs running in NMI context. And kernel features
> such as kgdb relies on NMI support to round up CPUs which are stuck in
> hard lockup state with interrupts disabled.
>
> This patch-set adds support for IPI_CALL_NMI_FUNC which can be triggered
> as a pseudo NMI which in turn is leveraged via kgdb to round up CPUs.
>
> After this patch-set we should be able to get a backtrace for a CPU
> stuck in HARDLOCKUP. Have a look at an example below from a testcase run
> on Developerbox:
>
> $ echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
>
> # Enter kdb via Magic SysRq
>
> [11]kdb> btc
> btc: cpu status: Currently on cpu 11
> Available cpus: 0-10(I), 11, 12(I), 13, 14-23(I)
> <snip>
> Stack traceback for pid 623
> 0xffff00086a644600      623      622  1   13   R  0xffff00086a644fc0  bash
> CPU: 13 PID: 623 Comm: bash Not tainted 5.7.0-rc2 #27
> Hardware name: Socionext SynQuacer E-series DeveloperBox, BIOS build #73 Apr  6 2020
> Call trace:
>  dump_backtrace+0x0/0x198
>  show_stack+0x18/0x28
>  dump_stack+0xb8/0x100
>  kgdb_cpu_enter+0x5c0/0x5f8
>  kgdb_nmicallback+0xa0/0xa8
>  handle_IPI+0x190/0x200
>  gic_handle_irq+0x2b8/0x2d8
>  el1_irq+0xcc/0x180
>  lkdtm_HARDLOCKUP+0x8/0x18
>  direct_entry+0x124/0x1c0
>  full_proxy_write+0x60/0xb0
>  __vfs_write+0x1c/0x48
>  vfs_write+0xe4/0x1d0
>  ksys_write+0x6c/0xf8
>  __arm64_sys_write+0x1c/0x28
>  el0_svc_common.constprop.0+0x74/0x1f0
>  do_el0_svc+0x24/0x90
>  el0_sync_handler+0x178/0x2b8
>  el0_sync+0x158/0x180
> <snip>
>
> Looking forward to your comments/feedback.
>
> Sumit Garg (4):
>   arm64: smp: Introduce a new IPI as IPI_CALL_NMI_FUNC
>   irqchip/gic-v3: Add support to handle SGI as pseudo NMI
>   irqchip/gic-v3: Enable arch specific IPI as pseudo NMI
>   arm64: kgdb: Round up cpus using IPI_CALL_NMI_FUNC
>
>  arch/arm64/include/asm/hardirq.h |  2 +-
>  arch/arm64/include/asm/smp.h     |  1 +
>  arch/arm64/kernel/kgdb.c         | 15 +++++++++++++++
>  arch/arm64/kernel/smp.c          | 36 +++++++++++++++++++++++++++++++++++-
>  drivers/irqchip/irq-gic-v3.c     | 36 +++++++++++++++++++++++++++++++-----
>  5 files changed, 83 insertions(+), 7 deletions(-)

This is amazing!

* picked your patches back to my current 5.4 tree
* turned on "CONFIG_ARM64_PSEUDO_NMI"
* set the "irqchip.gicv3_pseudo_nmi=1" command line

...and bam I can trace on the locked up CPU instead of being left in the dark.

I'm not sure I'm going to be too much use in actually doing the review
of the code since I'm not really an expert at how SGIs work (it took
me a while to realize that it must stand for software generated
interrupts) nor the bowels of the GIC.  I tried to do what little
review I could.

In any case, I'll keep this in my local patch stack for now and keep
testing it to make sure I don't notice any weird problems.

-Doug
