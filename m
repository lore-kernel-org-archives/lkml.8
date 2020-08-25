Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42380C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26CB6204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgHYCux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:50:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:37715 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgHYCus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:50:48 -0400
IronPort-SDR: QLYeLUn7fOCPwD2nOa9Vh8cV5J31PDXqmqjC77xy5hDmXt5Iwutpv8rVF4WfXuiQOy+4DftZRC
 4DA8R+Oy+jgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="143690756"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="143690756"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 19:50:47 -0700
IronPort-SDR: KYAhnWgxFOCaJoDJUxYxCgJDJS5/P4c2DlQRajKstXV1X/gMPbx1kC+RVA7pS4EmsNz6fWaFx0
 hBJx2lHYeIyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="312409734"
Received: from shsi6026.sh.intel.com ([10.239.147.135])
  by orsmga002.jf.intel.com with ESMTP; 24 Aug 2020 19:50:43 -0700
From:   shuo.a.liu@intel.com
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        Yin Fengwei <fengwei.yin@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH 03/17] x86/acrn: Introduce an API to check if a VM is privileged
Date:   Tue, 25 Aug 2020 10:45:03 +0800
Message-Id: <20200825024516.16766-4-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825024516.16766-1-shuo.a.liu@intel.com>
References: <20200825024516.16766-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yin Fengwei <fengwei.yin@intel.com>

ACRN Hypervisor reports hypervisor features via CPUID leaf 0x40000001
which is similar to KVM. A VM can check if it's the privileged VM using
the feature bits. The Service VM is the only privileged VM by design.

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Fengwei Yin <fengwei.yin@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/include/asm/acrn.h |  9 +++++++++
 arch/x86/kernel/cpu/acrn.c  | 19 ++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
index ff259b69cde7..a2d4aea3a80d 100644
--- a/arch/x86/include/asm/acrn.h
+++ b/arch/x86/include/asm/acrn.h
@@ -2,7 +2,16 @@
 #ifndef _ASM_X86_ACRN_H
 #define _ASM_X86_ACRN_H
 
+/*
+ * This CPUID returns feature bitmaps in EAX.
+ * Guest VM uses this to detect the appropriate feature bit.
+ */
+#define	ACRN_CPUID_FEATURES		0x40000001
+/* Bit 0 indicates whether guest VM is privileged */
+#define	ACRN_FEATURE_PRIVILEGED_VM	BIT(0)
+
 void acrn_setup_intr_handler(void (*handler)(void));
 void acrn_remove_intr_handler(void);
+bool acrn_is_privileged_vm(void);
 
 #endif /* _ASM_X86_ACRN_H */
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index bd1d7e759a0f..6f0a00cbbf7e 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -21,9 +21,26 @@
 #include <asm/idtentry.h>
 #include <asm/irq_regs.h>
 
+static u32 acrn_cpuid_base(void)
+{
+	static u32 acrn_cpuid_base;
+
+	if (!acrn_cpuid_base && boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		acrn_cpuid_base = hypervisor_cpuid_base("ACRNACRNACRN", 0);
+
+	return acrn_cpuid_base;
+}
+
+bool acrn_is_privileged_vm(void)
+{
+	return cpuid_eax(acrn_cpuid_base() | ACRN_CPUID_FEATURES) &
+			 ACRN_FEATURE_PRIVILEGED_VM;
+}
+EXPORT_SYMBOL_GPL(acrn_is_privileged_vm);
+
 static u32 __init acrn_detect(void)
 {
-	return hypervisor_cpuid_base("ACRNACRNACRN", 0);
+	return acrn_cpuid_base();
 }
 
 static void __init acrn_init_platform(void)
-- 
2.28.0

