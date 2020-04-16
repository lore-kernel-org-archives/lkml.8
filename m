Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFADCC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A892C221F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgDPU6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:58:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:8859 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729012AbgDPU55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 16:57:57 -0400
IronPort-SDR: KiJEieGJJa24VSYdCiQ71BxDbrWjFpws0gLDiTc3RlK9OFDd7mwHC0phQ1rV3BO19cOBP/fNCo
 mv5okODdH5wg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 13:57:55 -0700
IronPort-SDR: SiTv9itpIBddNvXV5KHfJyX7Leym+1Msa2FGTVGLUdVkYpsa2RfDxFvvHIDoXE5lWodijpDNON
 AMxs2wu36GkQ==
X-IronPort-AV: E=Sophos;i="5.72,392,1580803200"; 
   d="scan'208";a="427982530"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 13:57:55 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 2/3] x86/split_lock: Bits in IA32_CORE_CAPABILITIES are not architectural
Date:   Thu, 16 Apr 2020 13:57:53 -0700
Message-Id: <20200416205754.21177-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200416205754.21177-1-tony.luck@intel.com>
References: <20200416205754.21177-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel Software Developers' Manual erroneously listed bit 5 of the
IA32_CORE_CAPABILITIES register as an architectural feature. It is not.

Features enumerated by IA32_CORE_CAPABILITIES are model specific and
implementation details may vary in different cpu models. Thus it is only
safe to trust features after checking the CPU model.

Icelake client and server models are known to implement the split lock
detect feature even though they don't enumerate IA32_CORE_CAPABILITIES

Fixes: 6650cdd9a8cc ("x86/split_lock: Enable split lock detection by kernel")
Cc: <stable@vger.kernel.org>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 6119deb32660..3b43b2c91054 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1120,10 +1120,12 @@ void switch_to_sld(unsigned long tifn)
 }
 
 /*
- * The following processors have the split lock detection feature. But
- * since they don't have the IA32_CORE_CAPABILITIES MSR, the feature cannot
- * be enumerated. Enable it by family and model matching on these
- * processors.
+ * Bits in the IA32_CORE_CAPABILITIES are not architectural, so they
+ * should only be trusted if you know you are on a model that implements
+ * them.
+ * The driver_data field is set to zero to indicate CPU models like
+ * Icelake that are known to have the split-lock feature even though
+ * they do not enumerate IA32_CORE_CAPABILITIES.
  */
 static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,           0),
@@ -1133,19 +1135,21 @@ static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 
 void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
 {
-	u64 ia32_core_caps = 0;
+	const struct x86_cpu_id *m;
+	u64 ia32_core_caps;
 
-	if (c->x86_vendor != X86_VENDOR_INTEL)
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		return;
-	if (cpu_has(c, X86_FEATURE_CORE_CAPABILITIES)) {
-		/* Enumerate features reported in IA32_CORE_CAPABILITIES MSR. */
+
+	m = x86_match_cpu(split_lock_cpu_ids);
+	if (!m)
+		return;
+
+	if (m->driver_data && cpu_has(c, X86_FEATURE_CORE_CAPABILITIES)) {
 		rdmsrl(MSR_IA32_CORE_CAPS, ia32_core_caps);
-	} else if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
-		/* Enumerate split lock detection by family and model. */
-		if (x86_match_cpu(split_lock_cpu_ids))
-			ia32_core_caps |= MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT;
+		if (!(ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT))
+			return;
 	}
 
-	if (ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT)
-		split_lock_setup();
+	split_lock_setup();
 }
-- 
2.21.1

