Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40724C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 23:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF9320857
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 23:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgDJX3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 19:29:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:5053 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgDJX3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 19:29:41 -0400
IronPort-SDR: vtQ67SjgbQBlqLjc8OxtvYUQyI+EhdlvhJluQWRM4QdLZREZqfU6ggXvMMf90SJtmITEUggQiv
 im25KlzFbGIw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 16:29:41 -0700
IronPort-SDR: st4Y59xMBXgn8EnCjZF7/8A/KeCfm2er/McFx3pJn9o/d12PaVrfzKlpQz/rc5XpXJ/vPASTzg
 JT9oCpnklNWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,368,1580803200"; 
   d="scan'208";a="399057324"
Received: from kmp-skylake-client-platform.sc.intel.com ([172.25.112.108])
  by orsmga004.jf.intel.com with ESMTP; 10 Apr 2020 16:29:40 -0700
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        gregkh@linuxfoundation.org, ak@linux.intel.com,
        tony.luck@intel.com, ashok.raj@intel.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, kyung.min.park@intel.com
Subject: [PATCH v3 3/3] x86/delay: Introduce TPAUSE delay
Date:   Fri, 10 Apr 2020 16:29:55 -0700
Message-Id: <1586561395-50914-4-git-send-email-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586561395-50914-1-git-send-email-kyung.min.park@intel.com>
References: <1586561395-50914-1-git-send-email-kyung.min.park@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPAUSE instructs the processor to enter an implementation-dependent
optimized state. The instruction execution wakes up when the time-stamp
counter reaches or exceeds the implicit EDX:EAX 64-bit input value.
The instruction execution also wakes up due to the expiration of
the operating system time-limit or by an external interrupt
or exceptions such as a debug exception or a machine check exception.

TPAUSE offers a choice of two lower power states:
 1. Light-weight power/performance optimized state C0.1
 2. Improved power/performance optimized state C0.2
This way, it can save power with low wake-up latency in comparison to
spinloop based delay. The selection between the two is governed by the
input register.

TPAUSE is available on processors with X86_FEATURE_WAITPKG.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
 arch/x86/include/asm/delay.h |  1 +
 arch/x86/include/asm/mwait.h | 16 ++++++++++++++++
 arch/x86/kernel/time.c       |  3 +++
 arch/x86/lib/delay.c         | 27 +++++++++++++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/arch/x86/include/asm/delay.h b/arch/x86/include/asm/delay.h
index bb91d7c..b57048f 100644
--- a/arch/x86/include/asm/delay.h
+++ b/arch/x86/include/asm/delay.h
@@ -5,6 +5,7 @@
 #include <asm-generic/delay.h>
 
 void __init use_tsc_delay(void);
+void __init use_tpause_delay(void);
 void use_mwaitx_delay(void);
 
 #endif /* _ASM_X86_DELAY_H */
diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index a43b35b..b00596b 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -22,6 +22,8 @@
 #define MWAITX_ECX_TIMER_ENABLE		BIT(1)
 #define MWAITX_MAX_WAIT_CYCLES		UINT_MAX
 #define MWAITX_DISABLE_CSTATES		0xf0
+#define TPAUSE_C01_STATE		1
+#define TPAUSE_C02_STATE		0
 
 u32 get_umwait_control_msr(void);
 
@@ -122,4 +124,18 @@ static inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
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
+	asm volatile(".byte 0x66, 0x0f, 0xae, 0xf1\t\n"
+		     :
+		     : "c"(ecx), "d"(edx), "a"(eax));
+}
+
 #endif /* _ASM_X86_MWAIT_H */
diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index 106e7f8..371a6b3 100644
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
diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index fe91dc1..65d15df 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -97,6 +97,27 @@ static void delay_tsc(u64 cycles)
 }
 
 /*
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
+/*
  * On some AMD platforms, MWAITX has a configurable 32-bit timer, that
  * counts with TSC frequency. The input value is the number of TSC cycles
  * to wait. MWAITX will also exit when the timer expires.
@@ -156,6 +177,12 @@ void __init use_tsc_delay(void)
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
 	delay_halt_fn = delay_halt_mwaitx;
-- 
2.7.4

