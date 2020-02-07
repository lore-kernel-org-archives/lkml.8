Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E42FC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDD721775
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgBGNZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:25:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40713 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgBGNZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:25:54 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j03db-0003hD-Vt; Fri, 07 Feb 2020 14:25:40 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 1580D103093;
        Fri,  7 Feb 2020 13:25:38 +0000 (GMT)
Message-Id: <20200207124402.934519777@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 07 Feb 2020 13:38:54 +0100
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
Subject: [patch V2 07/17] x86/vdso: Move VDSO clocksource state tracking to callback
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

All architectures which use the generic VDSO code have their own storage
for the VDSO clock mode. That's pointless and just requires duplicate code.

X86 abuses the function which retrieves the architecture specific clock
mode storage to mark the clocksource as used in the VDSO. That's silly
because this is invoked on every tick when the VDSO data is updated.

Move this functionality to the clocksource::enable() callback so it gets
invoked once when the clocksource is installed. This allows to make the
clock mode storage generic.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>  (Hyper-V parts)
Acked-by: Juergen Gross <jgross@suse.com> (Xen parts)

---
 arch/x86/entry/vdso/vma.c            |    4 ++++
 arch/x86/include/asm/clocksource.h   |   12 ++++++++++++
 arch/x86/include/asm/mshyperv.h      |    2 ++
 arch/x86/include/asm/vdso/vsyscall.h |   10 +---------
 arch/x86/include/asm/vgtod.h         |    6 ------
 arch/x86/kernel/kvmclock.c           |    7 +++++++
 arch/x86/kernel/tsc.c                |   32 ++++++++++++++++++++------------
 arch/x86/xen/time.c                  |   17 ++++++++++++-----
 drivers/clocksource/hyperv_timer.c   |    7 +++++++
 9 files changed, 65 insertions(+), 32 deletions(-)

--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -38,6 +38,8 @@ struct vdso_data *arch_get_vdso_data(voi
 }
 #undef EMIT_VVAR
 
+unsigned int vclocks_used __read_mostly;
+
 #if defined(CONFIG_X86_64)
 unsigned int __read_mostly vdso64_enabled = 1;
 #endif
@@ -445,6 +447,8 @@ static __init int vdso_setup(char *s)
 
 static int __init init_vdso(void)
 {
+	BUILD_BUG_ON(VCLOCK_MAX >= 32);
+
 	init_vdso_image(&vdso_image_64);
 
 #ifdef CONFIG_X86_X32_ABI
--- a/arch/x86/include/asm/clocksource.h
+++ b/arch/x86/include/asm/clocksource.h
@@ -14,4 +14,16 @@ struct arch_clocksource_data {
 	int vclock_mode;
 };
 
+extern unsigned int vclocks_used;
+
+static inline bool vclock_was_used(int vclock)
+{
+	return READ_ONCE(vclocks_used) & (1U << vclock);
+}
+
+static inline void vclocks_set_used(unsigned int which)
+{
+	WRITE_ONCE(vclocks_used, READ_ONCE(vclocks_used) | (1 << which));
+}
+
 #endif /* _ASM_X86_CLOCKSOURCE_H */
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -47,6 +47,8 @@ typedef int (*hyperv_fill_flush_list_fun
 	wrmsrl(HV_X64_MSR_REFERENCE_TSC, val)
 #define hv_set_clocksource_vdso(val) \
 	((val).archdata.vclock_mode = VCLOCK_HVCLOCK)
+#define hv_enable_vdso_clocksource() \
+	vclocks_set_used(VCLOCK_HVCLOCK);
 #define hv_get_raw_timer() rdtsc_ordered()
 
 void hyperv_callback_vector(void);
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -10,8 +10,6 @@
 #include <asm/vgtod.h>
 #include <asm/vvar.h>
 
-int vclocks_used __read_mostly;
-
 DEFINE_VVAR(struct vdso_data, _vdso_data);
 /*
  * Update the vDSO data page to keep in sync with kernel timekeeping.
@@ -26,13 +24,7 @@ struct vdso_data *__x86_get_k_vdso_data(
 static __always_inline
 int __x86_get_clock_mode(struct timekeeper *tk)
 {
-	int vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;
-
-	/* Mark the new vclock used. */
-	BUILD_BUG_ON(VCLOCK_MAX >= 32);
-	WRITE_ONCE(vclocks_used, READ_ONCE(vclocks_used) | (1 << vclock_mode));
-
-	return vclock_mode;
+	return tk->tkr_mono.clock->archdata.vclock_mode;
 }
 #define __arch_get_clock_mode __x86_get_clock_mode
 
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -15,10 +15,4 @@ typedef u64 gtod_long_t;
 typedef unsigned long gtod_long_t;
 #endif
 
-extern int vclocks_used;
-static inline bool vclock_was_used(int vclock)
-{
-	return READ_ONCE(vclocks_used) & (1 << vclock);
-}
-
 #endif /* _ASM_X86_VGTOD_H */
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -159,12 +159,19 @@ bool kvm_check_and_clear_guest_paused(vo
 	return ret;
 }
 
+static int kvm_cs_enable(struct clocksource *cs)
+{
+	vclocks_set_used(VCLOCK_PVCLOCK);
+	return 0;
+}
+
 struct clocksource kvm_clock = {
 	.name	= "kvm-clock",
 	.read	= kvm_clock_get_cycles,
 	.rating	= 400,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+	.enable	= kvm_cs_enable,
 };
 EXPORT_SYMBOL_GPL(kvm_clock);
 
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1108,17 +1108,24 @@ static void tsc_cs_tick_stable(struct cl
 		sched_clock_tick_stable();
 }
 
+static int tsc_cs_enable(struct clocksource *cs)
+{
+	vclocks_set_used(VCLOCK_TSC);
+	return 0;
+}
+
 /*
  * .mask MUST be CLOCKSOURCE_MASK(64). See comment above read_tsc()
  */
 static struct clocksource clocksource_tsc_early = {
-	.name                   = "tsc-early",
-	.rating                 = 299,
-	.read                   = read_tsc,
-	.mask                   = CLOCKSOURCE_MASK(64),
-	.flags                  = CLOCK_SOURCE_IS_CONTINUOUS |
+	.name			= "tsc-early",
+	.rating			= 299,
+	.read			= read_tsc,
+	.mask			= CLOCKSOURCE_MASK(64),
+	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
 				  CLOCK_SOURCE_MUST_VERIFY,
-	.archdata               = { .vclock_mode = VCLOCK_TSC },
+	.archdata		= { .vclock_mode = VCLOCK_TSC },
+	.enable			= tsc_cs_enable,
 	.resume			= tsc_resume,
 	.mark_unstable		= tsc_cs_mark_unstable,
 	.tick_stable		= tsc_cs_tick_stable,
@@ -1131,14 +1138,15 @@ static struct clocksource clocksource_ts
  * been found good.
  */
 static struct clocksource clocksource_tsc = {
-	.name                   = "tsc",
-	.rating                 = 300,
-	.read                   = read_tsc,
-	.mask                   = CLOCKSOURCE_MASK(64),
-	.flags                  = CLOCK_SOURCE_IS_CONTINUOUS |
+	.name			= "tsc",
+	.rating			= 300,
+	.read			= read_tsc,
+	.mask			= CLOCKSOURCE_MASK(64),
+	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
 				  CLOCK_SOURCE_VALID_FOR_HRES |
 				  CLOCK_SOURCE_MUST_VERIFY,
-	.archdata               = { .vclock_mode = VCLOCK_TSC },
+	.archdata		= { .vclock_mode = VCLOCK_TSC },
+	.enable			= tsc_cs_enable,
 	.resume			= tsc_resume,
 	.mark_unstable		= tsc_cs_mark_unstable,
 	.tick_stable		= tsc_cs_tick_stable,
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -145,12 +145,19 @@ static struct notifier_block xen_pvclock
 	.notifier_call = xen_pvclock_gtod_notify,
 };
 
+static int xen_cs_enable(struct clocksource *cs)
+{
+	vclocks_set_used(VCLOCK_PVCLOCK);
+	return 0;
+}
+
 static struct clocksource xen_clocksource __read_mostly = {
-	.name = "xen",
-	.rating = 400,
-	.read = xen_clocksource_get_cycles,
-	.mask = ~0,
-	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
+	.name	= "xen",
+	.rating	= 400,
+	.read	= xen_clocksource_get_cycles,
+	.mask	= CLOCKSOURCE_MASK(64),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+	.enable = xen_cs_enable,
 };
 
 /*
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -369,6 +369,12 @@ static void resume_hv_clock_tsc(struct c
 	hv_set_reference_tsc(tsc_msr);
 }
 
+static int hv_cs_enable(struct clocksource *cs)
+{
+	hv_enable_vdso_clocksource();
+	return 0;
+}
+
 static struct clocksource hyperv_cs_tsc = {
 	.name	= "hyperv_clocksource_tsc_page",
 	.rating	= 250,
@@ -377,6 +383,7 @@ static struct clocksource hyperv_cs_tsc
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 	.suspend= suspend_hv_clock_tsc,
 	.resume	= resume_hv_clock_tsc,
+	.enable = hv_cs_enable,
 };
 
 static u64 notrace read_hv_clock_msr(void)

