Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846D4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ABCE21532
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgFQSYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:24:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:18901 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbgFQSYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:24:20 -0400
IronPort-SDR: e2TiEWcWcIfEpX005uIgES8rAZM5Rdqe41tR/5M4N6Oos7gaktUBcZ6O7CNhrAGoeIurN4ZGgx
 KPSpI45uhKBw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 11:24:16 -0700
IronPort-SDR: EZWEJzCiWACBvFcti6uSZ7f7N2wsYu3A1KDnpv8aOYj2DKr6gKMLIAA2UMmkOmCF7Gj0IUDWh1
 KKKr6Oy7N81Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="308874167"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga008.jf.intel.com with ESMTP; 17 Jun 2020 11:24:16 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "H Peter Anvin" <hpa@zytor.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        "Christoph Hellwig" <hch@infradeed.org>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, iommu@lists.linux-foundation.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 06/13] x86/fpu/xstate: Add supervisor PASID state for ENQCMD feature
Date:   Wed, 17 Jun 2020 11:23:46 -0700
Message-Id: <1592418233-17762-7-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1592418233-17762-1-git-send-email-fenghua.yu@intel.com>
References: <1592418233-17762-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

ENQCMD instruction reads PASID from IA32_PASID MSR. The MSR is stored
in the task's supervisor FPU PASID state and is context switched by
XSAVES/XRSTORS.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Modify the commit message (Thomas)

 arch/x86/include/asm/fpu/types.h  | 10 ++++++++++
 arch/x86/include/asm/fpu/xstate.h |  2 +-
 arch/x86/kernel/fpu/xstate.c      |  4 ++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index f098f6cab94b..00f8efd4c07d 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -114,6 +114,7 @@ enum xfeature {
 	XFEATURE_Hi16_ZMM,
 	XFEATURE_PT_UNIMPLEMENTED_SO_FAR,
 	XFEATURE_PKRU,
+	XFEATURE_PASID,
 
 	XFEATURE_MAX,
 };
@@ -128,6 +129,7 @@ enum xfeature {
 #define XFEATURE_MASK_Hi16_ZMM		(1 << XFEATURE_Hi16_ZMM)
 #define XFEATURE_MASK_PT		(1 << XFEATURE_PT_UNIMPLEMENTED_SO_FAR)
 #define XFEATURE_MASK_PKRU		(1 << XFEATURE_PKRU)
+#define XFEATURE_MASK_PASID		(1 << XFEATURE_PASID)
 
 #define XFEATURE_MASK_FPSSE		(XFEATURE_MASK_FP | XFEATURE_MASK_SSE)
 #define XFEATURE_MASK_AVX512		(XFEATURE_MASK_OPMASK \
@@ -229,6 +231,14 @@ struct pkru_state {
 	u32				pad;
 } __packed;
 
+/*
+ * State component 10 is supervisor state used for context-switching the
+ * PASID state.
+ */
+struct ia32_pasid_state {
+	u64 pasid;
+} __packed;
+
 struct xstate_header {
 	u64				xfeatures;
 	u64				xcomp_bv;
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 422d8369012a..ab9833c57aaa 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -33,7 +33,7 @@
 				      XFEATURE_MASK_BNDCSR)
 
 /* All currently supported supervisor features */
-#define XFEATURE_MASK_SUPERVISOR_SUPPORTED (0)
+#define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID)
 
 /*
  * Unsupported supervisor features. When a supervisor feature in this mask is
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index bda2e5eaca0e..31629e43383c 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -37,6 +37,7 @@ static const char *xfeature_names[] =
 	"AVX-512 ZMM_Hi256"		,
 	"Processor Trace (unused)"	,
 	"Protection Keys User registers",
+	"PASID state",
 	"unknown xstate feature"	,
 };
 
@@ -51,6 +52,7 @@ static short xsave_cpuid_features[] __initdata = {
 	X86_FEATURE_AVX512F,
 	X86_FEATURE_INTEL_PT,
 	X86_FEATURE_PKU,
+	X86_FEATURE_ENQCMD,
 };
 
 /*
@@ -316,6 +318,7 @@ static void __init print_xstate_features(void)
 	print_xstate_feature(XFEATURE_MASK_ZMM_Hi256);
 	print_xstate_feature(XFEATURE_MASK_Hi16_ZMM);
 	print_xstate_feature(XFEATURE_MASK_PKRU);
+	print_xstate_feature(XFEATURE_MASK_PASID);
 }
 
 /*
@@ -590,6 +593,7 @@ static void check_xstate_against_struct(int nr)
 	XCHECK_SZ(sz, nr, XFEATURE_ZMM_Hi256, struct avx_512_zmm_uppers_state);
 	XCHECK_SZ(sz, nr, XFEATURE_Hi16_ZMM,  struct avx_512_hi16_state);
 	XCHECK_SZ(sz, nr, XFEATURE_PKRU,      struct pkru_state);
+	XCHECK_SZ(sz, nr, XFEATURE_PASID,     struct ia32_pasid_state);
 
 	/*
 	 * Make *SURE* to add any feature numbers in below if
-- 
2.19.1

