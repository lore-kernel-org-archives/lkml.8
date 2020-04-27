Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B929C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 04:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0996E206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 04:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dH4og7eA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgD0Eyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 00:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726231AbgD0Eyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 00:54:40 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7F5C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 21:54:38 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id l11so12679303lfc.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 21:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uLhiyNXw2c6Bh3+KsgO2YOgoBrKeaIdCbQ6AiJEyQKg=;
        b=dH4og7eAlOMMU9zjR7c8eKMWiq0zQDIlb2GK5JUi+qJAjaTf4YedK6qxVckF97ctx5
         bGBaeyT7ehGjDXEaCX92gHWiYMqnAUubFrHu0hoz3WspncTOpvQ4F7/X3w5wOVsoI7go
         OXVjRax5ecUCoM0aBlzesbwzg4KmPUA0ipv5jUruDQmbXTeukXf5y7WBtTNsWuktbExN
         /XjN09lzj1e0TaiFh00i48xhlkOurl0X8i6puThAwyi/YGCIm4Y0H4kAQYEoaAOxFWGL
         YCwosYJ1JgRriI9ryOukPusUIT40A/IGr0vxzU+K66172GMXmNKHyBsgNbhzUNW8XhYh
         kObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uLhiyNXw2c6Bh3+KsgO2YOgoBrKeaIdCbQ6AiJEyQKg=;
        b=Hq7gTBiQgHiSQGV5bijQT+QoHOoa1aYsZU3DEn3/xxjF5pcVOHYQku5GE6QQxTDdHJ
         SLTeUqYb+gg0QYwxMgdFPSrB1soXe6DvYfeMJLuQU0F+6kqPwaaNb3D5nN+b1IunQgxT
         clzrk1l0WLSoZ1lJu+GnEkl6saT0Outi61dUq//XVz8YEXVdLxdzp741rUiwJKEZHQax
         SMEFxb+qPSJ1vY59yiYelffSyREEb9z+hbDq39jNCq1QI+RNqLFi5OU2dY/Ftns7om7M
         f1EY1g2WTzRForhwYN5Ryi/TSIH4RED7FSxM9Xc/6av5FqNRkSpBZSgEOsAtSHrIOQR8
         F20g==
X-Gm-Message-State: AGi0PuYtojCqWieySNPo4JTkd43zHWdvzbHjS5QN2aOWStnCgIrZeqyC
        UJJzbYq7mF9wofDkhvo1sOOID4R7QowsGMkYiEMYARi8
X-Google-Smtp-Source: APiQypLz3rHzGtlDr1/6paHraXe63+Mx5MbGFXQ94F/6yIUtpJZ84R5fG+aGZyp75Dsp1Qm7jipKQPY0eZUsNTZQuc0=
X-Received: by 2002:ac2:5f63:: with SMTP id c3mr14190318lfc.15.1587963277244;
 Sun, 26 Apr 2020 21:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org> <CAD=FV=W5FujyJMoH-TdQXxAYBvBO=rhjNo1EAv7xJ=R8eeaXZQ@mail.gmail.com>
In-Reply-To: <CAD=FV=W5FujyJMoH-TdQXxAYBvBO=rhjNo1EAv7xJ=R8eeaXZQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 27 Apr 2020 10:24:25 +0530
Message-ID: <CAFA6WYNgmnX7BJ2nTpSNUpmFm2wcpp3v_Psy2EoPccJBhk4WYg@mail.gmail.com>
Subject: Re: [RFC Patch v1 0/4] arm64: Introduce new IPI as IPI_CALL_NMI_FUNC
To:     Doug Anderson <dianders@chromium.org>
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

On Sat, 25 Apr 2020 at 02:20, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Apr 24, 2020 at 4:11 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > With pseudo NMIs support available its possible to configure SGIs to be
> > triggered as pseudo NMIs running in NMI context. And kernel features
> > such as kgdb relies on NMI support to round up CPUs which are stuck in
> > hard lockup state with interrupts disabled.
> >
> > This patch-set adds support for IPI_CALL_NMI_FUNC which can be triggered
> > as a pseudo NMI which in turn is leveraged via kgdb to round up CPUs.
> >
> > After this patch-set we should be able to get a backtrace for a CPU
> > stuck in HARDLOCKUP. Have a look at an example below from a testcase run
> > on Developerbox:
> >
> > $ echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
> >
> > # Enter kdb via Magic SysRq
> >
> > [11]kdb> btc
> > btc: cpu status: Currently on cpu 11
> > Available cpus: 0-10(I), 11, 12(I), 13, 14-23(I)
> > <snip>
> > Stack traceback for pid 623
> > 0xffff00086a644600      623      622  1   13   R  0xffff00086a644fc0  bash
> > CPU: 13 PID: 623 Comm: bash Not tainted 5.7.0-rc2 #27
> > Hardware name: Socionext SynQuacer E-series DeveloperBox, BIOS build #73 Apr  6 2020
> > Call trace:
> >  dump_backtrace+0x0/0x198
> >  show_stack+0x18/0x28
> >  dump_stack+0xb8/0x100
> >  kgdb_cpu_enter+0x5c0/0x5f8
> >  kgdb_nmicallback+0xa0/0xa8
> >  handle_IPI+0x190/0x200
> >  gic_handle_irq+0x2b8/0x2d8
> >  el1_irq+0xcc/0x180
> >  lkdtm_HARDLOCKUP+0x8/0x18
> >  direct_entry+0x124/0x1c0
> >  full_proxy_write+0x60/0xb0
> >  __vfs_write+0x1c/0x48
> >  vfs_write+0xe4/0x1d0
> >  ksys_write+0x6c/0xf8
> >  __arm64_sys_write+0x1c/0x28
> >  el0_svc_common.constprop.0+0x74/0x1f0
> >  do_el0_svc+0x24/0x90
> >  el0_sync_handler+0x178/0x2b8
> >  el0_sync+0x158/0x180
> > <snip>
> >
> > Looking forward to your comments/feedback.
> >
> > Sumit Garg (4):
> >   arm64: smp: Introduce a new IPI as IPI_CALL_NMI_FUNC
> >   irqchip/gic-v3: Add support to handle SGI as pseudo NMI
> >   irqchip/gic-v3: Enable arch specific IPI as pseudo NMI
> >   arm64: kgdb: Round up cpus using IPI_CALL_NMI_FUNC
> >
> >  arch/arm64/include/asm/hardirq.h |  2 +-
> >  arch/arm64/include/asm/smp.h     |  1 +
> >  arch/arm64/kernel/kgdb.c         | 15 +++++++++++++++
> >  arch/arm64/kernel/smp.c          | 36 +++++++++++++++++++++++++++++++++++-
> >  drivers/irqchip/irq-gic-v3.c     | 36 +++++++++++++++++++++++++++++++-----
> >  5 files changed, 83 insertions(+), 7 deletions(-)
>
> This is amazing!
>
> * picked your patches back to my current 5.4 tree
> * turned on "CONFIG_ARM64_PSEUDO_NMI"
> * set the "irqchip.gicv3_pseudo_nmi=1" command line
>
> ...and bam I can trace on the locked up CPU instead of being left in the dark.
>
> I'm not sure I'm going to be too much use in actually doing the review
> of the code since I'm not really an expert at how SGIs work (it took
> me a while to realize that it must stand for software generated
> interrupts) nor the bowels of the GIC.  I tried to do what little
> review I could.
>
> In any case, I'll keep this in my local patch stack for now and keep
> testing it to make sure I don't notice any weird problems.

Thanks for your review and testing.

-Sumit

>
> -Doug
