Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385D7C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1780C24655
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgANTtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:49:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44790 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgANTtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:49:12 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irSBa-0005ay-FC; Tue, 14 Jan 2020 20:49:10 +0100
Message-Id: <20200114185947.890158673@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 19:52:50 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, John Stultz <john.stultz@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [patch 13/15] lib/vdso: Cleanup clock mode storage leftovers
References: <20200114185237.273005683@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all architectures are converted to use the generic storage the
helpers and conditionals can be removed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paulburton@kernel.org>
Cc: James Hogan <jhogan@kernel.org>
---
 arch/arm/mm/Kconfig                 |    1 -
 arch/arm64/Kconfig                  |    1 -
 arch/mips/Kconfig                   |    1 -
 arch/x86/Kconfig                    |    1 -
 include/asm-generic/vdso/vsyscall.h |    7 -------
 include/linux/clocksource.h         |    4 ++--
 kernel/time/vsyscall.c              |    5 -----
 lib/vdso/Kconfig                    |    3 ---
 lib/vdso/gettimeofday.c             |   17 +++++------------
 9 files changed, 7 insertions(+), 33 deletions(-)

--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -900,7 +900,6 @@ config VDSO
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_VDSO_32
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_CLOCK_MODE
 	help
 	  Place in the process address space an ELF shared object
 	  providing fast implementations of gettimeofday and
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -108,7 +108,6 @@ config ARM64
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_CLOCK_MODE
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_PCI
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -35,7 +35,6 @@ config MIPS
 	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_CLOCK_MODE
 	select GUP_GET_PTE_LOW_HIGH if CPU_MIPS32 && PHYS_ADDR_T_64BIT
 	select HANDLE_DOMAIN_IRQ
 	select HAVE_ARCH_COMPILER_H
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -123,7 +123,6 @@ config X86
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_CLOCK_MODE
 	select GENERIC_VDSO_TIME_NS
 	select GUP_GET_PTE_LOW_HIGH		if X86_PAE
 	select HARDLOCKUP_CHECK_TIMESTAMP	if X86_64
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -18,13 +18,6 @@ static __always_inline bool __arch_updat
 }
 #endif /* __arch_update_vdso_data */
 
-#ifndef __arch_get_clock_mode
-static __always_inline int __arch_get_clock_mode(struct timekeeper *tk)
-{
-	return 0;
-}
-#endif /* __arch_get_clock_mode */
-
 #ifndef __arch_update_vsyscall
 static __always_inline void __arch_update_vsyscall(struct vdso_data *vdata,
 						   struct timekeeper *tk)
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -24,13 +24,13 @@ struct clocksource;
 struct module;
 
 #if defined(CONFIG_ARCH_CLOCKSOURCE_DATA) || \
-    defined(CONFIG_GENERIC_VDSO_CLOCK_MODE)
+    defined(CONFIG_GENERIC_GETTIMEOFDAY)
 #include <asm/clocksource.h>
 #endif
 
 enum vdso_clock_mode {
 	VDSO_CLOCKMODE_NONE,
-#ifdef CONFIG_GENERIC_VDSO_CLOCK_MODE
+#ifdef CONFIG_GENERIC_GETTIMEOFDAY
 	VDSO_ARCH_CLOCKMODES,
 #endif
 	VDSO_CLOCKMODE_MAX,
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -77,14 +77,9 @@ void update_vsyscall(struct timekeeper *
 	/* copy vsyscall data */
 	vdso_write_begin(vdata);
 
-#ifdef CONFIG_GENERIC_VDSO_CLOCK_MODE
 	mode = tk->tkr_mono.clock->vdso_clock_mode;
 	vdata[CS_HRES_COARSE].clock_mode	= mode;
 	vdata[CS_RAW].clock_mode		= mode;
-#else
-	vdata[CS_HRES_COARSE].clock_mode	= __arch_get_clock_mode(tk);
-	vdata[CS_RAW].clock_mode		= __arch_get_clock_mode(tk);
-#endif
 
 	/* CLOCK_REALTIME also required for time() */
 	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME];
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -30,7 +30,4 @@ config GENERIC_VDSO_TIME_NS
 	  Selected by architectures which support time namespaces in the
 	  VDSO
 
-config GENERIC_VDSO_CLOCK_MODE
-	bool
-
 endif
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -65,16 +65,13 @@ static int do_hres_timens(const struct v
 
 	do {
 		seq = vdso_read_begin(vd);
-		if (IS_ENABLED(CONFIG_GENERIC_VDSO_CLOCK_MODE) &&
-		    vd->clock_mode == VDSO_CLOCKMODE_NONE)
+
+		if (unlikely(vd->clock_mode == VDSO_CLOCKMODE_NONE))
 			return -1;
+
 		cycles = __arch_get_hw_counter(vd->clock_mode);
 		ns = vdso_ts->nsec;
 		last = vd->cycle_last;
-		if (!IS_ENABLED(CONFIG_GENERIC_VDSO_CLOCK_MODE) &&
-		    unlikely((s64)cycles < 0))
-			return -1;
-
 		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
 		ns >>= vd->shift;
 		sec = vdso_ts->sec;
@@ -137,16 +134,12 @@ static __always_inline int do_hres(const
 		}
 		smp_rmb();
 
-		if (IS_ENABLED(CONFIG_GENERIC_VDSO_CLOCK_MODE) &&
-		    vd->clock_mode == VDSO_CLOCKMODE_NONE)
+		if (unlikely(vd->clock_mode == VDSO_CLOCKMODE_NONE))
 			return -1;
+
 		cycles = __arch_get_hw_counter(vd->clock_mode);
 		ns = vdso_ts->nsec;
 		last = vd->cycle_last;
-		if (!IS_ENABLED(CONFIG_GENERIC_VDSO_CLOCK_MODE) &&
-		    unlikely((s64)cycles < 0))
-			return -1;
-
 		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
 		ns >>= vd->shift;
 		sec = vdso_ts->sec;

