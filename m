Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B869C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB58C20715
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgBGN0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:26:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40792 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbgBGN0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:26:03 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j03da-0003gw-NS; Fri, 07 Feb 2020 14:25:38 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id EDC20100375;
        Fri,  7 Feb 2020 13:25:37 +0000 (GMT)
Message-Id: <20200207123847.339896630@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 07 Feb 2020 13:38:47 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, John Stultz <john.stultz@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andrei Vagin <avagin@gmail.com>
Subject: [patch V2 00/17] VDSO consolidation
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second version of the VDSO consolidation series. The first
version can be found here:

   https://lore.kernel.org/lkml/r/20200114185237.273005683@linutronix.de

The changes since V1:

    - Tiny optimization of x86/TSC (new)

    - Address review comments from V1 (bisectability, spelling ...)

    - Include the preparatory patches from Christophe which allow powerpc
      to be switched over.

This conflicts slightly with the ARM64 time namespace patch series, but
that's trivial to fix up.

Thanks,

	tglx

----
 arch/arm/Kconfig                            |    1 
 arch/arm/include/asm/clocksource.h          |    5 -
 arch/arm/include/asm/vdso/gettimeofday.h    |    6 +
 arch/arm/include/asm/vdso/vsyscall.h        |   35 -------
 arch/arm64/Kconfig                          |    1 
 arch/arm64/include/asm/clocksource.h        |    5 -
 arch/arm64/include/asm/vdso/vsyscall.h      |    9 -
 arch/mips/Kconfig                           |    1 
 arch/mips/include/asm/clocksource.h         |   18 ---
 arch/mips/include/asm/vdso/vsyscall.h       |    9 -
 arch/mips/kernel/csrc-r4k.c                 |    2 
 arch/x86/Kconfig                            |    1 
 arch/x86/entry/vdso/vma.c                   |    8 +
 arch/x86/include/asm/clocksource.h          |   23 +++-
 arch/x86/include/asm/mshyperv.h             |    4 
 arch/x86/include/asm/vdso/gettimeofday.h    |    6 -
 arch/x86/include/asm/vdso/vsyscall.h        |   15 ---
 arch/x86/include/asm/vgtod.h                |    6 -
 arch/x86/kernel/kvmclock.c                  |    9 +
 arch/x86/kernel/pvclock.c                   |    2 
 arch/x86/kernel/time.c                      |   12 --
 arch/x86/kernel/tsc.c                       |   32 ++++--
 arch/x86/kvm/trace.h                        |    4 
 arch/x86/kvm/x86.c                          |   22 ++--
 arch/x86/xen/time.c                         |   36 ++++---
 b/arch/mips/include/asm/vdso/gettimeofday.h |   29 ++----
 drivers/clocksource/arm_arch_timer.c        |    8 -
 drivers/clocksource/hyperv_timer.c          |    7 +
 drivers/clocksource/mips-gic-timer.c        |    8 -
 include/asm-generic/vdso/vsyscall.h         |   14 --
 include/linux/clocksource.h                 |  102 ++++++++++++---------
 include/vdso/datapage.h                     |    2 
 kernel/time/clocksource.c                   |    9 +
 kernel/time/namespace.c                     |    7 -
 kernel/time/vsyscall.c                      |   12 +-
 lib/vdso/gettimeofday.c                     |  133 +++++++++++++++++++++-------
 36 files changed, 317 insertions(+), 286 deletions(-)


