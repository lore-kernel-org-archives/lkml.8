Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C7BC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912E724670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgANTtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:49:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44691 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANTtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:49:02 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irSBO-0005Z9-37; Tue, 14 Jan 2020 20:48:58 +0100
Message-Id: <20200114185237.273005683@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 19:52:37 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, John Stultz <john.stultz@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [patch 00/15] lib/vdso: Bugfix and consolidation
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent discussions about changes in the VDSO to support PPC
triggered this consolidation series which in turn unearthed a subtle
bug affecting ARM.

The bug affects only ARM 32bit systems which lack a VDSO capable
timer. The absence of the ARM architected timer causes the VDSO update
code to terminate early. As a result the parts of the VDSO data which
is usable without a VDSO capable clocksource are not updated either,
but the VDSO code uses them, i.e. it uses stale data and will serve
that forever. The fix is to make only the parts of the update
conditional which are related to te high resolution interfaces.

The rest of the series is addressing the following points:

 - Allow architectures to compile out the high resolution parts of the
   VDSO library when they know at compile time that no VDSO capable
   clocksource will be available.

 - Move the storage of the VDSO clockmode into generic code and remove
   all the redundant copies of the storage and the handling of it from
   the architectures. 

   This allows to remove the check for a valid clocksource at runtime
   from the clock readout function and make it generic by checking
   for a clock mode != NONE in the generic code. This generates better
   code on PPC and does not affect x86/arm performance.

Thanks,

       tglx

8<----------
 arch/arm/Kconfig                            |    1 
 arch/arm/include/asm/clocksource.h          |    5 -
 arch/arm/include/asm/vdso/gettimeofday.h    |    6 +
 arch/arm/include/asm/vdso/vsyscall.h        |   35 ---------
 arch/arm64/Kconfig                          |    1 
 arch/arm64/include/asm/clocksource.h        |    5 -
 arch/arm64/include/asm/vdso/vsyscall.h      |    9 --
 arch/mips/Kconfig                           |    1 
 arch/mips/include/asm/clocksource.h         |   18 ----
 arch/mips/include/asm/vdso/vsyscall.h       |    9 --
 arch/mips/kernel/csrc-r4k.c                 |    2 
 arch/x86/Kconfig                            |    1 
 arch/x86/entry/vdso/vma.c                   |    8 +-
 arch/x86/include/asm/clocksource.h          |   23 ++++--
 arch/x86/include/asm/mshyperv.h             |    4 -
 arch/x86/include/asm/vdso/gettimeofday.h    |    6 -
 arch/x86/include/asm/vdso/vsyscall.h        |   15 ----
 arch/x86/include/asm/vgtod.h                |    6 -
 arch/x86/kernel/kvmclock.c                  |    9 ++
 arch/x86/kernel/pvclock.c                   |    2 
 arch/x86/kernel/time.c                      |   12 ---
 arch/x86/kernel/tsc.c                       |   32 +++++---
 arch/x86/kvm/trace.h                        |    4 -
 arch/x86/kvm/x86.c                          |   22 +++---
 arch/x86/xen/time.c                         |   36 ++++++---
 b/arch/mips/include/asm/vdso/gettimeofday.h |   29 +++----
 b/include/asm-generic/vdso/vsyscall.h       |   14 ---
 drivers/clocksource/arm_arch_timer.c        |    8 +-
 drivers/clocksource/hyperv_timer.c          |    7 +
 drivers/clocksource/mips-gic-timer.c        |    8 +-
 include/linux/clocksource.h                 |  102 ++++++++++++++++------------
 include/vdso/datapage.h                     |    2 
 kernel/time/clocksource.c                   |    9 ++
 kernel/time/namespace.c                     |    7 +
 kernel/time/vsyscall.c                      |   43 +++++------
 lib/vdso/gettimeofday.c                     |   43 +++++++----
 36 files changed, 259 insertions(+), 285 deletions(-)


