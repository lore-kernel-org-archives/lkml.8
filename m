Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB906C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C050A21775
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgBGN0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:26:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40751 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgBGNZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:25:55 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j03df-0003jI-Sc; Fri, 07 Feb 2020 14:25:44 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 1D9AC105CFA;
        Fri,  7 Feb 2020 13:25:38 +0000 (GMT)
Message-Id: <20200207124403.244684017@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 07 Feb 2020 13:38:57 +0100
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
Subject: [patch V2 10/17] mips: vdso: Use generic VDSO clock mode storage
References: <20200207123847.339896630@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Switch to the generic VDSO clock mode storage.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/mips/Kconfig                         |    2 +-
 arch/mips/include/asm/clocksource.h       |   18 +++---------------
 arch/mips/include/asm/vdso/gettimeofday.h |   24 ++++++------------------
 arch/mips/include/asm/vdso/vsyscall.h     |    9 ---------
 arch/mips/kernel/csrc-r4k.c               |    2 +-
 drivers/clocksource/mips-gic-timer.c      |    8 ++++----
 6 files changed, 15 insertions(+), 48 deletions(-)

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,7 +4,6 @@ config MIPS
 	default y
 	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
-	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_PTE_SPECIAL if !(32BIT && CPU_HAS_RIXI)
@@ -38,6 +37,7 @@ config MIPS
 	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_VDSO_CLOCK_MODE
 	select GUP_GET_PTE_LOW_HIGH if CPU_MIPS32 && PHYS_ADDR_T_64BIT
 	select HANDLE_DOMAIN_IRQ
 	select HAVE_ARCH_COMPILER_H
--- a/arch/mips/include/asm/clocksource.h
+++ b/arch/mips/include/asm/clocksource.h
@@ -3,23 +3,11 @@
  * Copyright (C) 2015 Imagination Technologies
  * Author: Alex Smith <alex.smith@imgtec.com>
  */
-
 #ifndef __ASM_CLOCKSOURCE_H
 #define __ASM_CLOCKSOURCE_H
 
-#include <linux/types.h>
-
-/* VDSO clocksources. */
-#define VDSO_CLOCK_NONE		0	/* No suitable clocksource. */
-#define VDSO_CLOCK_R4K		1	/* Use the coprocessor 0 count. */
-#define VDSO_CLOCK_GIC		2	/* Use the GIC. */
-
-/**
- * struct arch_clocksource_data - Architecture-specific clocksource information.
- * @vdso_clock_mode: Method the VDSO should use to access the clocksource.
- */
-struct arch_clocksource_data {
-	u8 vdso_clock_mode;
-};
+#define VDSO_ARCH_CLOCKMODES	\
+	VDSO_CLOCKMDOE_R4K,	\
+	VDSO_CLOCKMODE_GIC
 
 #endif /* __ASM_CLOCKSOURCE_H */
--- a/arch/mips/include/asm/vdso/gettimeofday.h
+++ b/arch/mips/include/asm/vdso/gettimeofday.h
@@ -175,28 +175,16 @@ static __always_inline u64 read_gic_coun
 
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
 {
-#ifdef CONFIG_CLKSRC_MIPS_GIC
-	const struct vdso_data *data = get_vdso_data();
-#endif
-	u64 cycle_now;
-
-	switch (clock_mode) {
 #ifdef CONFIG_CSRC_R4K
-	case VDSO_CLOCK_R4K:
-		cycle_now = read_r4k_count();
-		break;
+	if (clock_mode == VDSO_CLOCKMODE_R4K)
+		return read_r4k_count();
 #endif
 #ifdef CONFIG_CLKSRC_MIPS_GIC
-	case VDSO_CLOCK_GIC:
-		cycle_now = read_gic_count(data);
-		break;
+	if (clock_mode == VDSO_CLOCKMODE_GIC)
+		return read_gic_count(get_vdso_data());
 #endif
-	default:
-		cycle_now = __VDSO_USE_SYSCALL;
-		break;
-	}
-
-	return cycle_now;
+	/* Keep GCC happy */
+	return U64_MAX;
 }
 
 static inline bool mips_vdso_hres_capable(void)
--- a/arch/mips/include/asm/vdso/vsyscall.h
+++ b/arch/mips/include/asm/vdso/vsyscall.h
@@ -19,15 +19,6 @@ struct vdso_data *__mips_get_k_vdso_data
 }
 #define __arch_get_k_vdso_data __mips_get_k_vdso_data
 
-static __always_inline
-int __mips_get_clock_mode(struct timekeeper *tk)
-{
-	u32 clock_mode = tk->tkr_mono.clock->archdata.vdso_clock_mode;
-
-	return clock_mode;
-}
-#define __arch_get_clock_mode __mips_get_clock_mode
-
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
 
--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -78,7 +78,7 @@ int __init init_r4k_clocksource(void)
 	 * by the VDSO (HWREna is configured by configure_hwrena()).
 	 */
 	if (cpu_has_mips_r2_r6 && rdhwr_count_usable())
-		clocksource_mips.archdata.vdso_clock_mode = VDSO_CLOCK_R4K;
+		clocksource_mips.vdso_clock_mode = VDSO_CLOCKMODE_R4K;
 
 	clocksource_register_hz(&clocksource_mips, mips_hpt_frequency);
 
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -155,10 +155,10 @@ static u64 gic_hpt_read(struct clocksour
 }
 
 static struct clocksource gic_clocksource = {
-	.name		= "GIC",
-	.read		= gic_hpt_read,
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-	.archdata	= { .vdso_clock_mode = VDSO_CLOCK_GIC },
+	.name			= "GIC",
+	.read			= gic_hpt_read,
+	.flags			= CLOCK_SOURCE_IS_CONTINUOUS,
+	.vdso_clock_mode	= VDSO_CLOCKMODE_GIC,
 };
 
 static int __init __gic_clocksource_init(void)

