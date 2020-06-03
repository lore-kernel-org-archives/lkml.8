Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0D6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E02E5206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgFCPJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgFCPI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:08:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB60C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 08:08:59 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jgV0i-0002R8-9M; Wed, 03 Jun 2020 17:08:56 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id B62E3FFC04;
        Wed,  3 Jun 2020 17:08:55 +0200 (CEST)
Date:   Wed, 03 Jun 2020 15:08:43 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/timers for v5.8
Message-ID: <159119692334.13122.14553226198669248718.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/timers branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-timers-2020-06-03

up to:  bd35c77e32e4: x86/tsc: Add tsc_early_khz command line parameter


X86 timer specific updates:

 - Add TPAUSE based delay which allows the CPU to enter an optimized power
   state while waiting for the delay to pass. The delay is based on TSC
   cycles.
   
 - Add tsc_early_khz command line parameter to workaround the problem that
   overclocked CPUs can report the wrong frequency via CPUID.16h which
   causes the refined calibration to fail because the delta to the initial
   frequency value is too big. With the parameter users can provide an
   halfways accurate initial value.

Thanks,

	tglx

------------------>
Krzysztof Piecuch (1):
      x86/tsc: Add tsc_early_khz command line parameter

Kyung Min Park (2):
      x86/delay: Refactor delay_mwaitx() for TPAUSE support
      x86/delay: Introduce TPAUSE delay

Thomas Gleixner (1):
      x86/delay: Preparatory code cleanup


 Documentation/admin-guide/kernel-parameters.txt |   6 ++
 arch/x86/Kconfig.assembler                      |   4 +
 arch/x86/include/asm/delay.h                    |   4 +-
 arch/x86/include/asm/mwait.h                    |  24 ++++-
 arch/x86/kernel/time.c                          |   3 +
 arch/x86/kernel/tsc.c                           |  12 ++-
 arch/x86/lib/delay.c                            | 114 ++++++++++++++++--------
 7 files changed, 128 insertions(+), 39 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7bc83f3d9bdf..409ee4ae467c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5067,6 +5067,12 @@
 			interruptions from clocksource watchdog are not
 			acceptable).
 
+	tsc_early_khz=  [X86] Skip early TSC calibration and use the given
+			value instead. Useful when the early TSC frequency discovery
+			procedure is not reliable, such as on overclocked systems
+			with CPUID.16h support and partial CPUID.15h support.
+			Format: <unsigned int>
+
 	tsx=		[X86] Control Transactional Synchronization
 			Extensions (TSX) feature in Intel processors that
 			support TSX control.
diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
index 13de0db38d4e..26b8c08e2fc4 100644
--- a/arch/x86/Kconfig.assembler
+++ b/arch/x86/Kconfig.assembler
@@ -15,3 +15,7 @@ config AS_SHA256_NI
 	def_bool $(as-instr,sha256msg1 %xmm0$(comma)%xmm1)
 	help
 	  Supported by binutils >= 2.24 and LLVM integrated assembler
+config AS_TPAUSE
+	def_bool $(as-instr,tpause %ecx)
+	help
+	  Supported by binutils >= 2.31.1 and LLVM integrated assembler >= V7
diff --git a/arch/x86/include/asm/delay.h b/arch/x86/include/asm/delay.h
index de9e7841f953..630891d25819 100644
--- a/arch/x86/include/asm/delay.h
+++ b/arch/x86/include/asm/delay.h
@@ -3,8 +3,10 @@
 #define _ASM_X86_DELAY_H
 
 #include <asm-generic/delay.h>
+#include <linux/init.h>
 
-void use_tsc_delay(void);
+void __init use_tsc_delay(void);
+void __init use_tpause_delay(void);
 void use_mwaitx_delay(void);
 
 #endif /* _ASM_X86_DELAY_H */
diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index b809f117f3f4..73d997aa2966 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -20,8 +20,10 @@
 
 #define MWAIT_ECX_INTERRUPT_BREAK	0x1
 #define MWAITX_ECX_TIMER_ENABLE		BIT(1)
-#define MWAITX_MAX_LOOPS		((u32)-1)
+#define MWAITX_MAX_WAIT_CYCLES		UINT_MAX
 #define MWAITX_DISABLE_CSTATES		0xf0
+#define TPAUSE_C01_STATE		1
+#define TPAUSE_C02_STATE		0
 
 u32 get_umwait_control_msr(void);
 
@@ -122,4 +124,24 @@ static inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
 	current_clr_polling();
 }
 
+/*
+ * Caller can specify whether to enter C0.1 (low latency, less
+ * power saving) or C0.2 state (saves more power, but longer wakeup
+ * latency). This may be overridden by the IA32_UMWAIT_CONTROL MSR
+ * which can force requests for C0.2 to be downgraded to C0.1.
+ */
+static inline void __tpause(u32 ecx, u32 edx, u32 eax)
+{
+	/* "tpause %ecx, %edx, %eax;" */
+	#ifdef CONFIG_AS_TPAUSE
+	asm volatile("tpause %%ecx\n"
+		     :
+		     : "c"(ecx), "d"(edx), "a"(eax));
+	#else
+	asm volatile(".byte 0x66, 0x0f, 0xae, 0xf1\t\n"
+		     :
+		     : "c"(ecx), "d"(edx), "a"(eax));
+	#endif
+}
+
 #endif /* _ASM_X86_MWAIT_H */
diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index 106e7f87f534..371a6b348e44 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -103,6 +103,9 @@ static __init void x86_late_time_init(void)
 	 */
 	x86_init.irqs.intr_mode_init();
 	tsc_init();
+
+	if (static_cpu_has(X86_FEATURE_WAITPKG))
+		use_tpause_delay();
 }
 
 /*
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index fdd4c1078632..49d925043171 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -41,6 +41,7 @@ EXPORT_SYMBOL(tsc_khz);
  * TSC can be unstable due to cpufreq or due to unsynced TSCs
  */
 static int __read_mostly tsc_unstable;
+static unsigned int __initdata tsc_early_khz;
 
 static DEFINE_STATIC_KEY_FALSE(__use_tsc);
 
@@ -59,6 +60,12 @@ struct cyc2ns {
 
 static DEFINE_PER_CPU_ALIGNED(struct cyc2ns, cyc2ns);
 
+static int __init tsc_early_khz_setup(char *buf)
+{
+	return kstrtouint(buf, 0, &tsc_early_khz);
+}
+early_param("tsc_early_khz", tsc_early_khz_setup);
+
 __always_inline void cyc2ns_read_begin(struct cyc2ns_data *data)
 {
 	int seq, idx;
@@ -1412,7 +1419,10 @@ static bool __init determine_cpu_tsc_frequencies(bool early)
 
 	if (early) {
 		cpu_khz = x86_platform.calibrate_cpu();
-		tsc_khz = x86_platform.calibrate_tsc();
+		if (tsc_early_khz)
+			tsc_khz = tsc_early_khz;
+		else
+			tsc_khz = x86_platform.calibrate_tsc();
 	} else {
 		/* We should not be here with non-native cpu calibration */
 		WARN_ON(x86_platform.calibrate_cpu != native_calibrate_cpu);
diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index c126571e5e2e..65d15df6212d 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -27,9 +27,20 @@
 # include <asm/smp.h>
 #endif
 
+static void delay_loop(u64 __loops);
+
+/*
+ * Calibration and selection of the delay mechanism happens only once
+ * during boot.
+ */
+static void (*delay_fn)(u64) __ro_after_init = delay_loop;
+static void (*delay_halt_fn)(u64 start, u64 cycles) __ro_after_init;
+
 /* simple loop based delay: */
-static void delay_loop(unsigned long loops)
+static void delay_loop(u64 __loops)
 {
+	unsigned long loops = (unsigned long)__loops;
+
 	asm volatile(
 		"	test %0,%0	\n"
 		"	jz 3f		\n"
@@ -49,9 +60,9 @@ static void delay_loop(unsigned long loops)
 }
 
 /* TSC based delay: */
-static void delay_tsc(unsigned long __loops)
+static void delay_tsc(u64 cycles)
 {
-	u64 bclock, now, loops = __loops;
+	u64 bclock, now;
 	int cpu;
 
 	preempt_disable();
@@ -59,7 +70,7 @@ static void delay_tsc(unsigned long __loops)
 	bclock = rdtsc_ordered();
 	for (;;) {
 		now = rdtsc_ordered();
-		if ((now - bclock) >= loops)
+		if ((now - bclock) >= cycles)
 			break;
 
 		/* Allow RT tasks to run */
@@ -77,7 +88,7 @@ static void delay_tsc(unsigned long __loops)
 		 * counter for this CPU.
 		 */
 		if (unlikely(cpu != smp_processor_id())) {
-			loops -= (now - bclock);
+			cycles -= (now - bclock);
 			cpu = smp_processor_id();
 			bclock = rdtsc_ordered();
 		}
@@ -85,66 +96,97 @@ static void delay_tsc(unsigned long __loops)
 	preempt_enable();
 }
 
+/*
+ * On Intel the TPAUSE instruction waits until any of:
+ * 1) the TSC counter exceeds the value provided in EDX:EAX
+ * 2) global timeout in IA32_UMWAIT_CONTROL is exceeded
+ * 3) an external interrupt occurs
+ */
+static void delay_halt_tpause(u64 start, u64 cycles)
+{
+	u64 until = start + cycles;
+	u32 eax, edx;
+
+	eax = lower_32_bits(until);
+	edx = upper_32_bits(until);
+
+	/*
+	 * Hard code the deeper (C0.2) sleep state because exit latency is
+	 * small compared to the "microseconds" that usleep() will delay.
+	 */
+	__tpause(TPAUSE_C02_STATE, edx, eax);
+}
+
 /*
  * On some AMD platforms, MWAITX has a configurable 32-bit timer, that
- * counts with TSC frequency. The input value is the loop of the
- * counter, it will exit when the timer expires.
+ * counts with TSC frequency. The input value is the number of TSC cycles
+ * to wait. MWAITX will also exit when the timer expires.
  */
-static void delay_mwaitx(unsigned long __loops)
+static void delay_halt_mwaitx(u64 unused, u64 cycles)
 {
-	u64 start, end, delay, loops = __loops;
+	u64 delay;
+
+	delay = min_t(u64, MWAITX_MAX_WAIT_CYCLES, cycles);
+	/*
+	 * Use cpu_tss_rw as a cacheline-aligned, seldomly accessed per-cpu
+	 * variable as the monitor target.
+	 */
+	 __monitorx(raw_cpu_ptr(&cpu_tss_rw), 0, 0);
+
+	/*
+	 * AMD, like Intel, supports the EAX hint and EAX=0xf means, do not
+	 * enter any deep C-state and we use it here in delay() to minimize
+	 * wakeup latency.
+	 */
+	__mwaitx(MWAITX_DISABLE_CSTATES, delay, MWAITX_ECX_TIMER_ENABLE);
+}
+
+/*
+ * Call a vendor specific function to delay for a given amount of time. Because
+ * these functions may return earlier than requested, check for actual elapsed
+ * time and call again until done.
+ */
+static void delay_halt(u64 __cycles)
+{
+	u64 start, end, cycles = __cycles;
 
 	/*
 	 * Timer value of 0 causes MWAITX to wait indefinitely, unless there
 	 * is a store on the memory monitored by MONITORX.
 	 */
-	if (loops == 0)
+	if (!cycles)
 		return;
 
 	start = rdtsc_ordered();
 
 	for (;;) {
-		delay = min_t(u64, MWAITX_MAX_LOOPS, loops);
-
-		/*
-		 * Use cpu_tss_rw as a cacheline-aligned, seldomly
-		 * accessed per-cpu variable as the monitor target.
-		 */
-		__monitorx(raw_cpu_ptr(&cpu_tss_rw), 0, 0);
-
-		/*
-		 * AMD, like Intel's MWAIT version, supports the EAX hint and
-		 * EAX=0xf0 means, do not enter any deep C-state and we use it
-		 * here in delay() to minimize wakeup latency.
-		 */
-		__mwaitx(MWAITX_DISABLE_CSTATES, delay, MWAITX_ECX_TIMER_ENABLE);
-
+		delay_halt_fn(start, cycles);
 		end = rdtsc_ordered();
 
-		if (loops <= end - start)
+		if (cycles <= end - start)
 			break;
 
-		loops -= end - start;
-
+		cycles -= end - start;
 		start = end;
 	}
 }
 
-/*
- * Since we calibrate only once at boot, this
- * function should be set once at boot and not changed
- */
-static void (*delay_fn)(unsigned long) = delay_loop;
-
-void use_tsc_delay(void)
+void __init use_tsc_delay(void)
 {
 	if (delay_fn == delay_loop)
 		delay_fn = delay_tsc;
 }
 
+void __init use_tpause_delay(void)
+{
+	delay_halt_fn = delay_halt_tpause;
+	delay_fn = delay_halt;
+}
+
 void use_mwaitx_delay(void)
 {
-	delay_fn = delay_mwaitx;
+	delay_halt_fn = delay_halt_mwaitx;
+	delay_fn = delay_halt;
 }
 
 int read_current_timer(unsigned long *timer_val)

