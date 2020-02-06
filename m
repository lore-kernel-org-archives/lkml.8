Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA89C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8EE20658
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgBFWIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 17:08:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:64211 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727919AbgBFWIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 17:08:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 14:08:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,411,1574150400"; 
   d="scan'208";a="404625091"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga005.jf.intel.com with ESMTP; 06 Feb 2020 14:08:37 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] KVM: nVMX: Rename nested_ept_get_cr3() to nested_ept_get_eptp()
Date:   Thu,  6 Feb 2020 14:08:33 -0800
Message-Id: <20200206220836.22743-5-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206220836.22743-1-sean.j.christopherson@intel.com>
References: <20200206220836.22743-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the accessor for vmcs12.EPTP to use "eptp" instead of "cr3".  The
accessor has no relation to cr3 whatsoever, other than it being assigned
to the also poorly named kvm_mmu->get_cr3() hook.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/nested.c | 4 ++--
 arch/x86/kvm/vmx/nested.h | 4 ++--
 arch/x86/kvm/vmx/vmx.c    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 11f98ee10ac5..51621947b5b7 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -353,9 +353,9 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 			to_vmx(vcpu)->nested.msrs.ept_caps &
 			VMX_EPT_EXECUTE_ONLY_BIT,
 			nested_ept_ad_enabled(vcpu),
-			nested_ept_get_cr3(vcpu));
+			nested_ept_get_eptp(vcpu));
 	vcpu->arch.mmu->set_cr3           = vmx_set_cr3;
-	vcpu->arch.mmu->get_cr3           = nested_ept_get_cr3;
+	vcpu->arch.mmu->get_cr3           = nested_ept_get_eptp;
 	vcpu->arch.mmu->inject_page_fault = nested_ept_inject_page_fault;
 	vcpu->arch.mmu->get_pdptr         = kvm_pdptr_read;
 
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index fc874d4ead0f..9d1c2fc81221 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -59,7 +59,7 @@ static inline int vmx_has_valid_vmcs12(struct kvm_vcpu *vcpu)
 		vmx->nested.hv_evmcs;
 }
 
-static inline unsigned long nested_ept_get_cr3(struct kvm_vcpu *vcpu)
+static inline unsigned long nested_ept_get_eptp(struct kvm_vcpu *vcpu)
 {
 	/* return the page table to be shadowed - in our case, EPT12 */
 	return get_vmcs12(vcpu)->ept_pointer;
@@ -67,7 +67,7 @@ static inline unsigned long nested_ept_get_cr3(struct kvm_vcpu *vcpu)
 
 static inline bool nested_ept_ad_enabled(struct kvm_vcpu *vcpu)
 {
-	return nested_ept_get_cr3(vcpu) & VMX_EPTP_AD_ENABLE_BIT;
+	return nested_ept_get_eptp(vcpu) & VMX_EPTP_AD_ENABLE_BIT;
 }
 
 /*
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index da70ef12266c..a15e9ab03638 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2971,7 +2971,7 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 static int get_ept_level(struct kvm_vcpu *vcpu)
 {
 	if (is_guest_mode(vcpu) && nested_cpu_has_ept(get_vmcs12(vcpu)))
-		return vmx_eptp_page_walk_level(nested_ept_get_cr3(vcpu));
+		return vmx_eptp_page_walk_level(nested_ept_get_eptp(vcpu));
 	if (cpu_has_vmx_ept_5levels() && (cpuid_maxphyaddr(vcpu) > 48))
 		return 5;
 	return 4;
-- 
2.24.1

