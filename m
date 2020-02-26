Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3572C4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FC920656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgBZTLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:11:42 -0500
Received: from mga11.intel.com ([192.55.52.93]:20002 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgBZTLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:11:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 11:11:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; 
   d="scan'208";a="285072252"
Received: from kmp-skylake-client-platform.sc.intel.com ([172.25.112.108])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Feb 2020 11:11:40 -0800
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        gregkh@linuxfoundation.org, ak@linux.intel.com,
        tony.luck@intel.com, ashok.raj@intel.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com
Subject: [PATCH 2/2] x86/asm/delay: Introduce TPAUSE delay
Date:   Wed, 26 Feb 2020 11:10:58 -0800
Message-Id: <1582744258-42744-3-git-send-email-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582744258-42744-1-git-send-email-kyung.min.park@intel.com>
References: <1582744258-42744-1-git-send-email-kyung.min.park@intel.com>
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
 arch/x86/include/asm/mwait.h | 17 +++++++++++++++++
 arch/x86/lib/delay.c         | 26 +++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 9d5252c..2067501 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -22,6 +22,8 @@
 #define MWAITX_ECX_TIMER_ENABLE		BIT(1)
 #define MWAITX_MAX_LOOPS		((u32)-1)
 #define MWAITX_DISABLE_CSTATES		0xf0
+#define TPAUSE_C01_STATE		1
+#define TPAUSE_C02_STATE		0
 
 static inline void __monitor(const void *eax, unsigned long ecx,
 			     unsigned long edx)
@@ -120,4 +122,19 @@ static inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
 	current_clr_polling();
 }
 
+/*
+ * Caller can specify whether to enter C0.1 (low latency, less
+ * power saving) or C0.2 state (saves more power, but longer wakeup
+ * latency). This may be overridden by the IA32_UMWAIT_CONTROL MSR
+ * which can force requests for C0.2 to be downgraded to C0.1.
+ */
+static inline void __tpause(unsigned int ecx, unsigned int edx,
+			    unsigned int eax)
+{
+	/* "tpause %ecx, %edx, %eax;" */
+	asm volatile(".byte 0x66, 0x0f, 0xae, 0xf1\t\n"
+		     :
+		     : "c"(ecx), "d"(edx), "a"(eax));
+}
+
 #endif /* _ASM_X86_MWAIT_H */
diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index 6be29cf..3553150 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -86,6 +86,26 @@ static void delay_tsc(unsigned long __loops)
 }
 
 /*
+ * On Intel the TPAUSE instruction waits until any of:
+ * 1) the TSC counter exceeds the value provided in EAX:EDX
+ * 2) global timeout in IA32_UMWAIT_CONTROL is exceeded
+ * 3) an external interrupt occurs
+ */
+static void tpause(u64 start, u64 cycles)
+{
+	u64 until = start + cycles;
+	unsigned int eax, edx;
+
+	eax = (unsigned int)(until & 0xffffffff);
+	edx = (unsigned int)(until >> 32);
+
+	/* Hard code the deeper (C0.2) sleep state because exit latency is
+	 * small compared to the "microseconds" that usleep() will delay.
+	 */
+	__tpause(TPAUSE_C02_STATE, edx, eax);
+}
+
+/*
  * On some AMD platforms, MWAITX has a configurable 32-bit timer, that
  * counts with TSC frequency. The input value is the loop of the
  * counter, it will exit when the timer expires.
@@ -153,8 +173,12 @@ static void (*delay_platform)(unsigned long) = delay_loop;
 
 void use_tsc_delay(void)
 {
-	if (delay_platform == delay_loop)
+	if (static_cpu_has(X86_FEATURE_WAITPKG)) {
+		wait_func = tpause;
+		delay_platform = delay_iterate;
+	} else if (delay_platform == delay_loop) {
 		delay_platform = delay_tsc;
+	}
 }
 
 void use_mwaitx_delay(void)
-- 
2.7.4

