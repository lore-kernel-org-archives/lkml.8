Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31B6C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B5D20679
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgBASw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:52:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:11279 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbgBASwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:52:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2020 10:52:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,390,1574150400"; 
   d="scan'208";a="248075556"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2020 10:52:26 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 42/61] KVM: x86: Add a helper to check kernel support when setting cpu cap
Date:   Sat,  1 Feb 2020 10:51:59 -0800
Message-Id: <20200201185218.24473-43-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200201185218.24473-1-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper, kvm_cpu_cap_check_and_set(), to query boot_cpu_has() as
part of setting a KVM cpu capability.  VMX in particular has a number of
features that are dependent on both a VMCS capability and kernel
support.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/cpuid.h   |  6 ++++++
 arch/x86/kvm/svm.c     |  3 +--
 arch/x86/kvm/vmx/vmx.c | 18 ++++++++----------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index c64283582d96..7b71ae0ca05e 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -274,4 +274,10 @@ static __always_inline void kvm_cpu_cap_set(unsigned x86_feature)
 	kvm_cpu_caps[x86_leaf] |= __feature_bit(x86_feature);
 }
 
+static __always_inline void kvm_cpu_cap_check_and_set(unsigned x86_feature)
+{
+	if (boot_cpu_has(x86_feature))
+		kvm_cpu_cap_set(x86_feature);
+}
+
 #endif
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 7cb05945162e..defb2c0dbf8a 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1362,8 +1362,7 @@ static __init void svm_set_cpu_caps(void)
 
 	/* CPUID 0x8000000A */
 	/* Support next_rip if host supports it */
-	if (boot_cpu_has(X86_FEATURE_NRIPS))
-		kvm_cpu_cap_set(X86_FEATURE_NRIPS);
+	kvm_cpu_cap_check_and_set(X86_FEATURE_NRIPS);
 
 	if (npt_enabled)
 		kvm_cpu_cap_set(X86_FEATURE_NPT);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cfd0ef314176..cecf59225136 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7118,18 +7118,16 @@ static __init void vmx_set_cpu_caps(void)
 		kvm_cpu_cap_set(X86_FEATURE_VMX);
 
 	/* CPUID 0x7 */
-	if (boot_cpu_has(X86_FEATURE_MPX) && kvm_mpx_supported())
-		kvm_cpu_cap_set(X86_FEATURE_MPX);
-	if (boot_cpu_has(X86_FEATURE_INVPCID) && cpu_has_vmx_invpcid())
-		kvm_cpu_cap_set(X86_FEATURE_INVPCID);
-	if (boot_cpu_has(X86_FEATURE_INTEL_PT) &&
-	    vmx_pt_mode_is_host_guest())
-		kvm_cpu_cap_set(X86_FEATURE_INTEL_PT);
+	if (kvm_mpx_supported())
+		kvm_cpu_cap_check_and_set(X86_FEATURE_MPX);
+	if (cpu_has_vmx_invpcid())
+		kvm_cpu_cap_check_and_set(X86_FEATURE_INVPCID);
+	if (vmx_pt_mode_is_host_guest())
+		kvm_cpu_cap_check_and_set(X86_FEATURE_INTEL_PT);
 
 	/* PKU is not yet implemented for shadow paging. */
-	if (enable_ept && boot_cpu_has(X86_FEATURE_PKU) &&
-	    boot_cpu_has(X86_FEATURE_OSPKE))
-		kvm_cpu_cap_set(X86_FEATURE_PKU);
+	if (enable_ept && boot_cpu_has(X86_FEATURE_OSPKE))
+		kvm_cpu_cap_check_and_set(X86_FEATURE_PKU);
 
 	/* CPUID 0xD.1 */
 	if (!vmx_xsaves_supported())
-- 
2.24.1

