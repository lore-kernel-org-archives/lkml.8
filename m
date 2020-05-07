Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23081C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3C920838
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgEGONe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbgEGONb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:13:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A67FC05BD43;
        Thu,  7 May 2020 07:13:31 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWhHD-0002c5-RK; Thu, 07 May 2020 16:13:28 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 476A11C0451;
        Thu,  7 May 2020 16:13:27 +0200 (CEST)
Date:   Thu, 07 May 2020 14:13:27 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/timers] x86/delay: Preparatory code cleanup
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1587757076-30337-2-git-send-email-kyung.min.park@intel.com>
References: <1587757076-30337-2-git-send-email-kyung.min.park@intel.com>
MIME-Version: 1.0
Message-ID: <158886080725.8414.13575285074483659672.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/timers branch of tip:

Commit-ID:     e8824890249355656968d8846908a313fe231f11
Gitweb:        https://git.kernel.org/tip/e8824890249355656968d8846908a313fe231f11
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 24 Apr 2020 12:37:54 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 May 2020 16:06:19 +02:00

x86/delay: Preparatory code cleanup

The naming conventions in the delay code are confusing at best.

All delay variants use a loops argument and or variable which originates
from the original delay_loop() implementation. But all variants except
delay_loop() are based on TSC cycles.

Rename the argument to cycles and make it type u64 to avoid these weird
expansions to u64 in the functions.

Rename MWAITX_MAX_LOOPS to MWAITX_MAX_WAIT_CYCLES for the same reason
and fixup the comment of delay_mwaitx() as well.

Mark the delay_fn function pointer __ro_after_init and fixup the comment
for it.

No functional change and preparation for the upcoming TPAUSE based delay
variant.

[ Kyung Min Park: Added __init to use_tsc_delay() ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1587757076-30337-2-git-send-email-kyung.min.park@intel.com

---
 arch/x86/include/asm/delay.h |  3 +-
 arch/x86/include/asm/mwait.h |  2 +-
 arch/x86/lib/delay.c         | 45 ++++++++++++++++++-----------------
 3 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/delay.h b/arch/x86/include/asm/delay.h
index de9e784..9aa38de 100644
--- a/arch/x86/include/asm/delay.h
+++ b/arch/x86/include/asm/delay.h
@@ -3,8 +3,9 @@
 #define _ASM_X86_DELAY_H
 
 #include <asm-generic/delay.h>
+#include <linux/init.h>
 
-void use_tsc_delay(void);
+void __init use_tsc_delay(void);
 void use_mwaitx_delay(void);
 
 #endif /* _ASM_X86_DELAY_H */
diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index b809f11..a43b35b 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -20,7 +20,7 @@
 
 #define MWAIT_ECX_INTERRUPT_BREAK	0x1
 #define MWAITX_ECX_TIMER_ENABLE		BIT(1)
-#define MWAITX_MAX_LOOPS		((u32)-1)
+#define MWAITX_MAX_WAIT_CYCLES		UINT_MAX
 #define MWAITX_DISABLE_CSTATES		0xf0
 
 u32 get_umwait_control_msr(void);
diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index c126571..887d52d 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -27,9 +27,19 @@
 # include <asm/smp.h>
 #endif
 
+static void delay_loop(u64 __loops);
+
+/*
+ * Calibration and selection of the delay mechanism happens only once
+ * during boot.
+ */
+static void (*delay_fn)(u64) __ro_after_init = delay_loop;
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
@@ -49,9 +59,9 @@ static void delay_loop(unsigned long loops)
 }
 
 /* TSC based delay: */
-static void delay_tsc(unsigned long __loops)
+static void delay_tsc(u64 cycles)
 {
-	u64 bclock, now, loops = __loops;
+	u64 bclock, now;
 	int cpu;
 
 	preempt_disable();
@@ -59,7 +69,7 @@ static void delay_tsc(unsigned long __loops)
 	bclock = rdtsc_ordered();
 	for (;;) {
 		now = rdtsc_ordered();
-		if ((now - bclock) >= loops)
+		if ((now - bclock) >= cycles)
 			break;
 
 		/* Allow RT tasks to run */
@@ -77,7 +87,7 @@ static void delay_tsc(unsigned long __loops)
 		 * counter for this CPU.
 		 */
 		if (unlikely(cpu != smp_processor_id())) {
-			loops -= (now - bclock);
+			cycles -= (now - bclock);
 			cpu = smp_processor_id();
 			bclock = rdtsc_ordered();
 		}
@@ -87,24 +97,24 @@ static void delay_tsc(unsigned long __loops)
 
 /*
  * On some AMD platforms, MWAITX has a configurable 32-bit timer, that
- * counts with TSC frequency. The input value is the loop of the
- * counter, it will exit when the timer expires.
+ * counts with TSC frequency. The input value is the number of TSC cycles
+ * to wait. MWAITX will also exit when the timer expires.
  */
-static void delay_mwaitx(unsigned long __loops)
+static void delay_mwaitx(u64 cycles)
 {
-	u64 start, end, delay, loops = __loops;
+	u64 start, end, delay;
 
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
+		delay = min_t(u64, MWAITX_MAX_WAIT_CYCLES, cycles);
 
 		/*
 		 * Use cpu_tss_rw as a cacheline-aligned, seldomly
@@ -121,22 +131,15 @@ static void delay_mwaitx(unsigned long __loops)
 
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
