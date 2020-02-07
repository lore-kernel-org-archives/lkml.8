Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FE4C352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0B821775
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbgBGN0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:26:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40802 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbgBGN0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:26:08 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j03dh-0003jJ-Um; Fri, 07 Feb 2020 14:25:46 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 21ADE105CFB;
        Fri,  7 Feb 2020 13:25:38 +0000 (GMT)
Message-Id: <20200207124403.363235229@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 07 Feb 2020 13:38:58 +0100
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
Subject: [patch V2 11/17] ARM/arm64: vdso: Use common vdso clock mode storage
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

Convert ARM/ARM64 to the generic VDSO clock mode storage. This needs to
happen in one go as they share the clocksource driver.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/arm/Kconfig                       |    1 -
 arch/arm/include/asm/clocksource.h     |    5 ++---
 arch/arm/include/asm/vdso/vsyscall.h   |   21 ---------------------
 arch/arm/mm/Kconfig                    |    1 +
 arch/arm64/Kconfig                     |    2 +-
 arch/arm64/include/asm/clocksource.h   |    5 ++---
 arch/arm64/include/asm/vdso/vsyscall.h |    9 ---------
 drivers/clocksource/arm_arch_timer.c   |    8 ++++----
 8 files changed, 10 insertions(+), 42 deletions(-)

--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -3,7 +3,6 @@ config ARM
 	bool
 	default y
 	select ARCH_32BIT_OFF_T
-	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
--- a/arch/arm/include/asm/clocksource.h
+++ b/arch/arm/include/asm/clocksource.h
@@ -1,8 +1,7 @@
 #ifndef _ASM_CLOCKSOURCE_H
 #define _ASM_CLOCKSOURCE_H
 
-struct arch_clocksource_data {
-	bool vdso_direct;	/* Usable for direct VDSO access? */
-};
+#define VDSO_ARCH_CLOCKMODES	\
+	VDSO_CLOCKMODE_ARCHTIMER
 
 #endif
--- a/arch/arm/include/asm/vdso/vsyscall.h
+++ b/arch/arm/include/asm/vdso/vsyscall.h
@@ -11,18 +11,6 @@
 extern struct vdso_data *vdso_data;
 extern bool cntvct_ok;
 
-static __always_inline
-bool tk_is_cntvct(const struct timekeeper *tk)
-{
-	if (!IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
-		return false;
-
-	if (!tk->tkr_mono.clock->archdata.vdso_direct)
-		return false;
-
-	return true;
-}
-
 /*
  * Update the vDSO data page to keep in sync with kernel timekeeping.
  */
@@ -41,15 +29,6 @@ bool __arm_update_vdso_data(void)
 #define __arch_update_vdso_data __arm_update_vdso_data
 
 static __always_inline
-int __arm_get_clock_mode(struct timekeeper *tk)
-{
-	u32 __tk_is_cntvct = tk_is_cntvct(tk);
-
-	return __tk_is_cntvct;
-}
-#define __arch_get_clock_mode __arm_get_clock_mode
-
-static __always_inline
 void __arm_sync_vdso_data(struct vdso_data *vdata)
 {
 	flush_dcache_page(virt_to_page(vdata));
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -900,6 +900,7 @@ config VDSO
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_VDSO_32
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_VDSO_CLOCK_MODE
 	help
 	  Place in the process address space an ELF shared object
 	  providing fast implementations of gettimeofday and
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -9,7 +9,6 @@ config ARM64
 	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_SPCR_TABLE if ACPI
 	select ACPI_PPTT if ACPI
-	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_DMA_PREP_COHERENT
@@ -110,6 +109,7 @@ config ARM64
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_VDSO_CLOCK_MODE
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_PCI
--- a/arch/arm64/include/asm/clocksource.h
+++ b/arch/arm64/include/asm/clocksource.h
@@ -2,8 +2,7 @@
 #ifndef _ASM_CLOCKSOURCE_H
 #define _ASM_CLOCKSOURCE_H
 
-struct arch_clocksource_data {
-	bool vdso_direct;	/* Usable for direct VDSO access? */
-};
+#define VDSO_ARCH_CLOCKMODES	\
+	VDSO_CLOCKMODE_ARCHTIMER
 
 #endif
--- a/arch/arm64/include/asm/vdso/vsyscall.h
+++ b/arch/arm64/include/asm/vdso/vsyscall.h
@@ -22,15 +22,6 @@ struct vdso_data *__arm64_get_k_vdso_dat
 #define __arch_get_k_vdso_data __arm64_get_k_vdso_data
 
 static __always_inline
-int __arm64_get_clock_mode(struct timekeeper *tk)
-{
-	u32 use_syscall = !tk->tkr_mono.clock->archdata.vdso_direct;
-
-	return use_syscall;
-}
-#define __arch_get_clock_mode __arm64_get_clock_mode
-
-static __always_inline
 void __arm64_update_vsyscall(struct vdso_data *vdata, struct timekeeper *tk)
 {
 	vdata[CS_HRES_COARSE].mask	= VDSO_PRECISION_MASK;
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -69,7 +69,7 @@ static enum arch_timer_ppi_nr arch_timer
 static bool arch_timer_c3stop;
 static bool arch_timer_mem_use_virtual;
 static bool arch_counter_suspend_stop;
-static bool vdso_default = true;
+static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
 
 static cpumask_t evtstrm_available = CPU_MASK_NONE;
 static bool evtstrm_enable = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
@@ -560,8 +560,8 @@ void arch_timer_enable_workaround(const
 	 * change both the default value and the vdso itself.
 	 */
 	if (wa->read_cntvct_el0) {
-		clocksource_counter.archdata.vdso_direct = false;
-		vdso_default = false;
+		clocksource_counter.vdso_clock_mode = VDSO_CLOCKMODE_NONE;
+		vdso_default = VDSO_CLOCKMODE_NONE;
 	}
 }
 
@@ -979,7 +979,7 @@ static void __init arch_counter_register
 		}
 
 		arch_timer_read_counter = rd;
-		clocksource_counter.archdata.vdso_direct = vdso_default;
+		clocksource_counter.vdso_clock_mode = vdso_default;
 	} else {
 		arch_timer_read_counter = arch_counter_get_cntvct_mem;
 	}

