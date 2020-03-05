Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E463C3F2CE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29C221741
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCEBeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:34:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:31873 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgCEBek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:34:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 17:34:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,516,1574150400"; 
   d="scan'208";a="234301747"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga008.fm.intel.com with ESMTP; 04 Mar 2020 17:34:39 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH v2 2/7] KVM: x86: Add helpers to perform CPUID-based guest vendor check
Date:   Wed,  4 Mar 2020 17:34:32 -0800
Message-Id: <20200305013437.8578-3-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305013437.8578-1-sean.j.christopherson@intel.com>
References: <20200305013437.8578-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helpers to provide CPUID-based guest vendor checks, i.e. to do the
ugly register comparisons.  Use the new helpers to check for an AMD
guest vendor in guest_cpuid_is_amd() as well as in the existing emulator
flows.

Using the new helpers fixes a _very_ theoretical bug where
guest_cpuid_is_amd() would get a false positive on a non-AMD virtual CPU
with a vendor string beginning with "Auth" due to the previous logic
only checking EBX.  It also fixes a marginally less theoretically bug
where guest_cpuid_is_amd() would incorrectly return false for a guest
CPU with "AMDisbetter!" as its vendor string.

Fixes: a0c0feb57992c ("KVM: x86: reserve bit 8 of non-leaf PDPEs and PML4Es in 64-bit mode on AMD")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/asm/kvm_emulate.h | 24 ++++++++++++++++++++
 arch/x86/kvm/cpuid.h               |  2 +-
 arch/x86/kvm/emulate.c             | 36 +++++++-----------------------
 3 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/kvm_emulate.h b/arch/x86/include/asm/kvm_emulate.h
index bf5f5e476f65..2754972c36e6 100644
--- a/arch/x86/include/asm/kvm_emulate.h
+++ b/arch/x86/include/asm/kvm_emulate.h
@@ -393,6 +393,30 @@ struct x86_emulate_ctxt {
 #define X86EMUL_CPUID_VENDOR_GenuineIntel_ecx 0x6c65746e
 #define X86EMUL_CPUID_VENDOR_GenuineIntel_edx 0x49656e69
 
+static inline bool is_guest_vendor_intel(u32 ebx, u32 ecx, u32 edx)
+{
+	return ebx == X86EMUL_CPUID_VENDOR_GenuineIntel_ebx &&
+	       ecx == X86EMUL_CPUID_VENDOR_GenuineIntel_ecx &&
+	       edx == X86EMUL_CPUID_VENDOR_GenuineIntel_edx;
+}
+
+static inline bool is_guest_vendor_amd(u32 ebx, u32 ecx, u32 edx)
+{
+	return (ebx == X86EMUL_CPUID_VENDOR_AuthenticAMD_ebx &&
+		ecx == X86EMUL_CPUID_VENDOR_AuthenticAMD_ecx &&
+		edx == X86EMUL_CPUID_VENDOR_AuthenticAMD_edx) ||
+	       (ebx == X86EMUL_CPUID_VENDOR_AMDisbetterI_ebx &&
+		ecx == X86EMUL_CPUID_VENDOR_AMDisbetterI_ecx &&
+		edx == X86EMUL_CPUID_VENDOR_AMDisbetterI_edx);
+}
+
+static inline bool is_guest_vendor_hygon(u32 ebx, u32 ecx, u32 edx)
+{
+	return ebx == X86EMUL_CPUID_VENDOR_HygonGenuine_ebx &&
+	       ecx == X86EMUL_CPUID_VENDOR_HygonGenuine_ecx &&
+	       edx == X86EMUL_CPUID_VENDOR_HygonGenuine_edx;
+}
+
 enum x86_intercept_stage {
 	X86_ICTP_NONE = 0,   /* Allow zero-init to not match anything */
 	X86_ICPT_PRE_EXCEPT,
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 7366c618aa04..13eb3e92c6a9 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -145,7 +145,7 @@ static inline bool guest_cpuid_is_amd(struct kvm_vcpu *vcpu)
 	struct kvm_cpuid_entry2 *best;
 
 	best = kvm_find_cpuid_entry(vcpu, 0, 0);
-	return best && best->ebx == X86EMUL_CPUID_VENDOR_AuthenticAMD_ebx;
+	return best && is_guest_vendor_amd(best->ebx, best->ecx, best->edx);
 }
 
 static inline int guest_cpuid_family(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index dd19fb3539e0..9cf303984fe5 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2712,9 +2712,7 @@ static bool vendor_intel(struct x86_emulate_ctxt *ctxt)
 
 	eax = ecx = 0;
 	ctxt->ops->get_cpuid(ctxt, &eax, &ebx, &ecx, &edx, false);
-	return ebx == X86EMUL_CPUID_VENDOR_GenuineIntel_ebx
-		&& ecx == X86EMUL_CPUID_VENDOR_GenuineIntel_ecx
-		&& edx == X86EMUL_CPUID_VENDOR_GenuineIntel_edx;
+	return is_guest_vendor_intel(ebx, ecx, edx);
 }
 
 static bool em_syscall_is_enabled(struct x86_emulate_ctxt *ctxt)
@@ -2733,34 +2731,16 @@ static bool em_syscall_is_enabled(struct x86_emulate_ctxt *ctxt)
 	ecx = 0x00000000;
 	ops->get_cpuid(ctxt, &eax, &ebx, &ecx, &edx, false);
 	/*
-	 * Intel ("GenuineIntel")
-	 * remark: Intel CPUs only support "syscall" in 64bit
-	 * longmode. Also an 64bit guest with a
-	 * 32bit compat-app running will #UD !! While this
-	 * behaviour can be fixed (by emulating) into AMD
-	 * response - CPUs of AMD can't behave like Intel.
+	 * remark: Intel CPUs only support "syscall" in 64bit longmode. Also a
+	 * 64bit guest with a 32bit compat-app running will #UD !! While this
+	 * behaviour can be fixed (by emulating) into AMD response - CPUs of
+	 * AMD can't behave like Intel.
 	 */
-	if (ebx == X86EMUL_CPUID_VENDOR_GenuineIntel_ebx &&
-	    ecx == X86EMUL_CPUID_VENDOR_GenuineIntel_ecx &&
-	    edx == X86EMUL_CPUID_VENDOR_GenuineIntel_edx)
+	if (is_guest_vendor_intel(ebx, ecx, edx))
 		return false;
 
-	/* AMD ("AuthenticAMD") */
-	if (ebx == X86EMUL_CPUID_VENDOR_AuthenticAMD_ebx &&
-	    ecx == X86EMUL_CPUID_VENDOR_AuthenticAMD_ecx &&
-	    edx == X86EMUL_CPUID_VENDOR_AuthenticAMD_edx)
-		return true;
-
-	/* AMD ("AMDisbetter!") */
-	if (ebx == X86EMUL_CPUID_VENDOR_AMDisbetterI_ebx &&
-	    ecx == X86EMUL_CPUID_VENDOR_AMDisbetterI_ecx &&
-	    edx == X86EMUL_CPUID_VENDOR_AMDisbetterI_edx)
-		return true;
-
-	/* Hygon ("HygonGenuine") */
-	if (ebx == X86EMUL_CPUID_VENDOR_HygonGenuine_ebx &&
-	    ecx == X86EMUL_CPUID_VENDOR_HygonGenuine_ecx &&
-	    edx == X86EMUL_CPUID_VENDOR_HygonGenuine_edx)
+	if (is_guest_vendor_amd(ebx, ecx, edx) ||
+	    is_guest_vendor_hygon(ebx, ecx, edx))
 		return true;
 
 	/*
-- 
2.24.1

