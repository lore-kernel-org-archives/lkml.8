Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC73C2D0EF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 10:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 633B722240
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 10:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDRKy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 06:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725923AbgDRKy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 06:54:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F4DC061A0C;
        Sat, 18 Apr 2020 03:54:57 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jPl7c-0007eh-JE; Sat, 18 Apr 2020 12:54:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 256FE1C03A9;
        Sat, 18 Apr 2020 12:54:51 +0200 (CEST)
Date:   Sat, 18 Apr 2020 10:54:50 -0000
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/split_lock: Bits in IA32_CORE_CAPABILITIES are
 not architectural
Cc:     Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416205754.21177-3-tony.luck@intel.com>
References: <20200416205754.21177-3-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <158720729077.28353.13428455301119141580.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     48fd5b5ee714714f4cf9f9e1cba3b49b1fd40ed6
Gitweb:        https://git.kernel.org/tip/48fd5b5ee714714f4cf9f9e1cba3b49b1fd40ed6
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Thu, 16 Apr 2020 13:57:53 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 18 Apr 2020 12:48:44 +02:00

x86/split_lock: Bits in IA32_CORE_CAPABILITIES are not architectural

The Intel Software Developers' Manual erroneously listed bit 5 of the
IA32_CORE_CAPABILITIES register as an architectural feature. It is not.

Features enumerated by IA32_CORE_CAPABILITIES are model specific and
implementation details may vary in different cpu models. Thus it is only
safe to trust features after checking the CPU model.

Icelake client and server models are known to implement the split lock
detect feature even though they don't enumerate IA32_CORE_CAPABILITIES

[ tglx: Use switch() for readability and massage comments ]

Fixes: 6650cdd9a8cc ("x86/split_lock: Enable split lock detection by kernel")
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200416205754.21177-3-tony.luck@intel.com

---
 arch/x86/kernel/cpu/intel.c | 45 ++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index ec0d8c7..c23ad48 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1120,10 +1120,17 @@ void switch_to_sld(unsigned long tifn)
 }
 
 /*
- * The following processors have the split lock detection feature. But
- * since they don't have the IA32_CORE_CAPABILITIES MSR, the feature cannot
- * be enumerated. Enable it by family and model matching on these
- * processors.
+ * Bits in the IA32_CORE_CAPABILITIES are not architectural, so they should
+ * only be trusted if it is confirmed that a CPU model implements a
+ * specific feature at a particular bit position.
+ *
+ * The possible driver data field values:
+ *
+ * - 0: CPU models that are known to have the per-core split-lock detection
+ *	feature even though they do not enumerate IA32_CORE_CAPABILITIES.
+ *
+ * - 1: CPU models which may enumerate IA32_CORE_CAPABILITIES and if so use
+ *      bit 5 to enumerate the per-core split-lock detection feature.
  */
 static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		0),
@@ -1133,19 +1140,29 @@ static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 
 void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
 {
-	u64 ia32_core_caps = 0;
+	const struct x86_cpu_id *m;
+	u64 ia32_core_caps;
+
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return;
 
-	if (c->x86_vendor != X86_VENDOR_INTEL)
+	m = x86_match_cpu(split_lock_cpu_ids);
+	if (!m)
 		return;
-	if (cpu_has(c, X86_FEATURE_CORE_CAPABILITIES)) {
-		/* Enumerate features reported in IA32_CORE_CAPABILITIES MSR. */
+
+	switch (m->driver_data) {
+	case 0:
+		break;
+	case 1:
+		if (!cpu_has(c, X86_FEATURE_CORE_CAPABILITIES))
+			return;
 		rdmsrl(MSR_IA32_CORE_CAPS, ia32_core_caps);
-	} else if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
-		/* Enumerate split lock detection by family and model. */
-		if (x86_match_cpu(split_lock_cpu_ids))
-			ia32_core_caps |= MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT;
+		if (!(ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT))
+			return;
+		break;
+	default:
+		return;
 	}
 
-	if (ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT)
-		split_lock_setup();
+	split_lock_setup();
 }
