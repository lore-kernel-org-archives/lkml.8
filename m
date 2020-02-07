Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19036C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8605217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgBGN0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:26:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40801 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbgBGN0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:26:07 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j03di-0003m2-Lm; Fri, 07 Feb 2020 14:25:46 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 25A60105CFC;
        Fri,  7 Feb 2020 13:25:38 +0000 (GMT)
Message-Id: <20200207124403.470699892@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 07 Feb 2020 13:38:59 +0100
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
Subject: [patch V2 12/17] lib/vdso: Cleanup clock mode storage leftovers
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

Now that all architectures are converted to use the generic storage the
helpers and conditionals can be removed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/arm/mm/Kconfig                 |    1 -
 arch/arm64/Kconfig                  |    1 -
 arch/mips/Kconfig                   |    1 -
 arch/x86/Kconfig                    |    1 -
 include/asm-generic/vdso/vsyscall.h |    7 -------
 include/linux/clocksource.h         |    4 ++--
 kernel/time/vsyscall.c              |    4 ----
 lib/vdso/Kconfig                    |    3 ---
 lib/vdso/gettimeofday.c             |   17 +++++------------
 9 files changed, 7 insertions(+), 32 deletions(-)

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
@@ -109,7 +109,6 @@ config ARM64
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
@@ -124,7 +124,6 @@ config X86
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
@@ -77,11 +77,7 @@ void update_vsyscall(struct timekeeper *
 	/* copy vsyscall data */
 	vdso_write_begin(vdata);
 
-#ifdef CONFIG_GENERIC_VDSO_CLOCK_MODE
 	clock_mode = tk->tkr_mono.clock->vdso_clock_mode;
-#else
-	clock_mode = __arch_get_clock_mode(tk);
-#endif
 	vdata[CS_HRES_COARSE].clock_mode	= clock_mode;
 	vdata[CS_RAW].clock_mode		= clock_mode;
 
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

