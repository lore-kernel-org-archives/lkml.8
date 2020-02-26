Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA0DC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1CB20656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgBZTLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:11:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:20002 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbgBZTLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:11:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 11:11:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; 
   d="scan'208";a="285072249"
Received: from kmp-skylake-client-platform.sc.intel.com ([172.25.112.108])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Feb 2020 11:11:40 -0800
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        gregkh@linuxfoundation.org, ak@linux.intel.com,
        tony.luck@intel.com, ashok.raj@intel.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com
Subject: [PATCH 1/2] x86/asm: Define a few helpers in delay_waitx()
Date:   Wed, 26 Feb 2020 11:10:57 -0800
Message-Id: <1582744258-42744-2-git-send-email-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582744258-42744-1-git-send-email-kyung.min.park@intel.com>
References: <1582744258-42744-1-git-send-email-kyung.min.park@intel.com>
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
 arch/x86/lib/delay.c | 58 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index c126571..6be29cf 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -90,9 +90,36 @@ static void delay_tsc(unsigned long __loops)
  * counts with TSC frequency. The input value is the loop of the
  * counter, it will exit when the timer expires.
  */
-static void delay_mwaitx(unsigned long __loops)
+static void mwaitx(u64 unused, u64 loops)
 {
-	u64 start, end, delay, loops = __loops;
+	u64 delay;
+
+	delay = min_t(u64, MWAITX_MAX_LOOPS, loops);
+	/*
+	 * Use cpu_tss_rw as a cacheline-aligned, seldomly
+	 * accessed per-cpu variable as the monitor target.
+	 */
+	__monitorx(raw_cpu_ptr(&cpu_tss_rw), 0, 0);
+
+	/*
+	 * AMD, like Intel, supports the EAX hint and EAX=0xf
+	 * means, do not enter any deep C-state and we use it
+	 * here in delay() to minimize wakeup latency.
+	 */
+	__mwaitx(MWAITX_DISABLE_CSTATES, delay, MWAITX_ECX_TIMER_ENABLE);
+}
+
+static void (*wait_func)(u64, u64);
+
+/*
+ * Call a vendor specific function to delay for a given
+ * amount of time. Because these functions may return
+ * earlier than requested, check for actual elapsed time
+ * and call again until done.
+ */
+static void delay_iterate(unsigned long __loops)
+{
+	u64 start, end, loops = __loops;
 
 	/*
 	 * Timer value of 0 causes MWAITX to wait indefinitely, unless there
@@ -104,20 +131,8 @@ static void delay_mwaitx(unsigned long __loops)
 	start = rdtsc_ordered();
 
 	for (;;) {
-		delay = min_t(u64, MWAITX_MAX_LOOPS, loops);
-
-		/*
-		 * Use cpu_tss_rw as a cacheline-aligned, seldomly
-		 * accessed per-cpu variable as the monitor target.
-		 */
-		__monitorx(raw_cpu_ptr(&cpu_tss_rw), 0, 0);
 
-		/*
-		 * AMD, like Intel's MWAIT version, supports the EAX hint and
-		 * EAX=0xf0 means, do not enter any deep C-state and we use it
-		 * here in delay() to minimize wakeup latency.
-		 */
-		__mwaitx(MWAITX_DISABLE_CSTATES, delay, MWAITX_ECX_TIMER_ENABLE);
+		wait_func(start, loops);
 
 		end = rdtsc_ordered();
 
@@ -134,22 +149,23 @@ static void delay_mwaitx(unsigned long __loops)
  * Since we calibrate only once at boot, this
  * function should be set once at boot and not changed
  */
-static void (*delay_fn)(unsigned long) = delay_loop;
+static void (*delay_platform)(unsigned long) = delay_loop;
 
 void use_tsc_delay(void)
 {
-	if (delay_fn == delay_loop)
-		delay_fn = delay_tsc;
+	if (delay_platform == delay_loop)
+		delay_platform = delay_tsc;
 }
 
 void use_mwaitx_delay(void)
 {
-	delay_fn = delay_mwaitx;
+	wait_func = mwaitx;
+	delay_platform = delay_iterate;
 }
 
 int read_current_timer(unsigned long *timer_val)
 {
-	if (delay_fn == delay_tsc) {
+	if (delay_platform == delay_tsc) {
 		*timer_val = rdtsc();
 		return 0;
 	}
@@ -158,7 +174,7 @@ int read_current_timer(unsigned long *timer_val)
 
 void __delay(unsigned long loops)
 {
-	delay_fn(loops);
+	delay_platform(loops);
 }
 EXPORT_SYMBOL(__delay);
 
-- 
2.7.4

