Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207A0C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E39216FD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgDXTh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:37:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:8203 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDXTh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:37:27 -0400
IronPort-SDR: SdOJPnpTvntEM0jrGj6bZRkaKXtTBFeH9kIUbQ4fvaJAbYGLjIUuRvOUwON9crC5HibicuyPqa
 1Ql2jfese6zw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 12:37:26 -0700
IronPort-SDR: fW+8+TLv2nJHw75Mi1krPiXI4zf5Z0RzRlicAZl+mx7v2CEibruOej+rLifue0XQUJxZvs2SNd
 iFQiFn7Vfr7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,313,1583222400"; 
   d="scan'208";a="403425644"
Received: from kmp-skylake-client-platform.sc.intel.com ([172.25.112.108])
  by orsmga004.jf.intel.com with ESMTP; 24 Apr 2020 12:37:23 -0700
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        gregkh@linuxfoundation.org, ak@linux.intel.com,
        tony.luck@intel.com, ashok.raj@intel.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, kyung.min.park@intel.com
Subject: [PATCH v4 2/3] x86/delay: Refactor delay_mwaitx() for TPAUSE support
Date:   Fri, 24 Apr 2020 12:37:55 -0700
Message-Id: <1587757076-30337-3-git-send-email-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587757076-30337-1-git-send-email-kyung.min.park@intel.com>
References: <1587757076-30337-1-git-send-email-kyung.min.park@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor code to make it easier to add a new model specific function to
delay for a number of cycles.

No functional change.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
 arch/x86/lib/delay.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index 887d52d..fe91dc1 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -34,6 +34,7 @@ static void delay_loop(u64 __loops);
  * during boot.
  */
 static void (*delay_fn)(u64) __ro_after_init = delay_loop;
+static void (*delay_halt_fn)(u64 start, u64 cycles) __ro_after_init;
 
 /* simple loop based delay: */
 static void delay_loop(u64 __loops)
@@ -100,9 +101,33 @@ static void delay_tsc(u64 cycles)
  * counts with TSC frequency. The input value is the number of TSC cycles
  * to wait. MWAITX will also exit when the timer expires.
  */
-static void delay_mwaitx(u64 cycles)
+static void delay_halt_mwaitx(u64 unused, u64 cycles)
 {
-	u64 start, end, delay;
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
@@ -114,21 +139,7 @@ static void delay_mwaitx(u64 cycles)
 	start = rdtsc_ordered();
 
 	for (;;) {
-		delay = min_t(u64, MWAITX_MAX_WAIT_CYCLES, cycles);
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
 
 		if (cycles <= end - start)
@@ -147,7 +158,8 @@ void __init use_tsc_delay(void)
 
 void use_mwaitx_delay(void)
 {
-	delay_fn = delay_mwaitx;
+	delay_halt_fn = delay_halt_mwaitx;
+	delay_fn = delay_halt;
 }
 
 int read_current_timer(unsigned long *timer_val)
-- 
2.7.4

