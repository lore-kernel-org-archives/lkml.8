Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CE2C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 00:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142A82166E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 00:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbgBFAtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 19:49:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:26572 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbgBFAtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 19:49:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 16:49:45 -0800
X-IronPort-AV: E=Sophos;i="5.70,407,1574150400"; 
   d="scan'208";a="430340180"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 16:49:45 -0800
Date:   Wed, 5 Feb 2020 16:49:44 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Mark D Rustad <mrustad@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: [PATCH] x86/split_lock: Avoid runtime reads of the TEST_CTRL MSR
Message-ID: <20200206004944.GA11455@agluck-desk2.amr.corp.intel.com>
References: <4E95BFAA-A115-4159-AA4F-6AAB548C6E6C@gmail.com>
 <C3302B2F-177F-4C39-910E-EADBA9285DD0@intel.com>
 <8CC9FBA7-D464-4E58-8912-3E14A751D243@gmail.com>
 <20200126200535.GB30377@agluck-desk2.amr.corp.intel.com>
 <20200203204155.GE19638@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203204155.GE19638@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a context switch from a task that is detecting split locks
to one that is not (or vice versa) we need to update the TEST_CTRL
MSR. Currently this is done with the common sequence:
	read the MSR
	flip the bit
	write the MSR
in order to avoid changing the value of any reserved bits in the MSR.

Cache the value of the TEST_CTRL MSR when we read it during initialization
so we can avoid an expensive RDMSR instruction during context switch.

Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 5d92e381fd91..78de69c5887a 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1054,6 +1054,14 @@ static void __init split_lock_setup(void)
 	}
 }
 
+/*
+ * Soft copy of MSR_TEST_CTRL initialized when we first read the
+ * MSR. Used at runtime to avoid using rdmsr again just to collect
+ * the reserved bits in the MSR. We assume reserved bits are the
+ * same on all CPUs.
+ */
+static u64 test_ctrl_val;
+
 /*
  * Locking is not required at the moment because only bit 29 of this
  * MSR is implemented and locking would not prevent that the operation
@@ -1063,19 +1071,29 @@ static void __init split_lock_setup(void)
  * exist, there may be glitches in virtualization that leave a guest
  * with an incorrect view of real h/w capabilities.
  */
-static bool __sld_msr_set(bool on)
+static bool __sld_msr_init(void)
 {
-	u64 test_ctrl_val;
+	u64 val;
 
-	if (rdmsrl_safe(MSR_TEST_CTRL, &test_ctrl_val))
+	if (rdmsrl_safe(MSR_TEST_CTRL, &val))
 		return false;
+	test_ctrl_val = val;
+
+	val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
+
+	return !wrmsrl_safe(MSR_TEST_CTRL, val);
+}
+
+static void __sld_msr_set(bool on)
+{
+	u64 val = test_ctrl_val;
 
 	if (on)
-		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
+		val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
 	else
-		test_ctrl_val &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
+		val &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
 
-	return !wrmsrl_safe(MSR_TEST_CTRL, test_ctrl_val);
+	wrmsrl_safe(MSR_TEST_CTRL, val);
 }
 
 static void split_lock_init(void)
@@ -1083,7 +1101,7 @@ static void split_lock_init(void)
 	if (sld_state == sld_off)
 		return;
 
-	if (__sld_msr_set(true))
+	if (__sld_msr_init())
 		return;
 
 	/*
-- 
2.21.1

