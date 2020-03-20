Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A7CC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 04:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48582071C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 04:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgCTENk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 00:13:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:24678 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgCTENk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 00:13:40 -0400
IronPort-SDR: OO6+9lypHaCruljyP9wzfkfo9utR+CweNy43OI1oBhkhwif1gpkYfNBhSUqqynrMtc7DsY8/L+
 Y172kelJ1FmA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 21:13:40 -0700
IronPort-SDR: zfCQ6rsfjTisTMrOsRO6JR9sAeh+zg76FwUjQb11I/t3FkvxATNIJ5fuTPYL80iHEO8Epdi373
 8pRofmeJ7puw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,283,1580803200"; 
   d="scan'208";a="280306863"
Received: from kmp-skylake-client-platform.sc.intel.com ([172.25.112.108])
  by fmsmga002.fm.intel.com with ESMTP; 19 Mar 2020 21:13:38 -0700
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        gregkh@linuxfoundation.org, ak@linux.intel.com,
        tony.luck@intel.com, ashok.raj@intel.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, kyung.min.park@intel.com
Subject: [PATCH v2 2/2] x86/delay: Introduce TPAUSE delay
Date:   Thu, 19 Mar 2020 21:13:24 -0700
Message-Id: <1584677604-32707-3-git-send-email-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584677604-32707-1-git-send-email-kyung.min.park@intel.com>
References: <1584677604-32707-1-git-send-email-kyung.min.park@intel.com>
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
 arch/x86/lib/delay.c         | 27 ++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index aaf6643..fd59db0 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -22,6 +22,8 @@
 #define MWAITX_ECX_TIMER_ENABLE		BIT(1)
 #define MWAITX_MAX_WAIT_CYCLES		UINT_MAX
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
index e6db855..5f11f0a 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -97,6 +97,27 @@ static void delay_tsc(u64 cycles)
 }
 
 /*
+ * On Intel the TPAUSE instruction waits until any of:
+ * 1) the TSC counter exceeds the value provided in EAX:EDX
+ * 2) global timeout in IA32_UMWAIT_CONTROL is exceeded
+ * 3) an external interrupt occurs
+ */
+static void delay_halt_tpause(u64 start, u64 cycles)
+{
+	u64 until = start + cycles;
+	unsigned int eax, edx;
+
+	eax = (unsigned int)(until & 0xffffffff);
+	edx = (unsigned int)(until >> 32);
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
@@ -152,8 +173,12 @@ static void delay_halt(u64 __cycles)
 
 void use_tsc_delay(void)
 {
-	if (delay_fn == delay_loop)
+	if (static_cpu_has(X86_FEATURE_WAITPKG)) {
+		delay_halt_fn = delay_halt_tpause;
+		delay_fn = delay_halt;
+	} else if (delay_fn == delay_loop) {
 		delay_fn = delay_tsc;
+	}
 }
 
 void use_mwaitx_delay(void)
-- 
2.7.4

