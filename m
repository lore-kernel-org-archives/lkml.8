Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FB0C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A6812084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411528AbgDOR4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:56:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:26433 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441032AbgDORza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:55:30 -0400
IronPort-SDR: BFn1YAZO4IqQUMloHBQXbS18qj3GpH6YPDI0hBnc+jZUWtq4nISoAIdc1wBM7CgHYWTISiTenl
 e1EfvN8Ub5Eg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 10:55:23 -0700
IronPort-SDR: DqDlhOgSgoyTgj6cZKb/jEtN1G/76lrC9RF2WmxjVS6l1yE9CE6uIBgSYYhT/6StFGrsSXAllv
 1eyKxqbER6Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; 
   d="scan'208";a="332567361"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga001.jf.intel.com with ESMTP; 15 Apr 2020 10:55:23 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v2 09/10] KVM: nVMX: Rename exit_reason to vm_exit_reason for nested VM-Exit
Date:   Wed, 15 Apr 2020 10:55:18 -0700
Message-Id: <20200415175519.14230-10-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415175519.14230-1-sean.j.christopherson@intel.com>
References: <20200415175519.14230-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "vm_exit_reason" for code related to injecting a nested VM-Exit to
VM-Exits to make it clear that nested_vmx_vmexit() expects the full exit
eason, not just the basic exit reason.  The basic exit reason (bits 15:0
of vmcs.VM_EXIT_REASON) is colloquially referred to as simply "exit
reason".

Note, other flows, e.g. vmx_handle_exit(), are intentionally left as is.
A future patch will convert vmx->exit_reason to a union + bit-field, and
the exempted flows will interact with the unionized of "exit_reason".

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---

I also explored making nested_vmx_vmexit() a wrapper to e.g.
__nested_vmx_vmexit(), with the inner function taking the union, but that
just added a bunch of conversion code without providing true value.

 arch/x86/kvm/vmx/nested.c | 29 +++++++++++++++--------------
 arch/x86/kvm/vmx/nested.h |  2 +-
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 23d84d063197..6f303ccd478d 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -328,19 +328,19 @@ static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	u32 exit_reason;
+	u32 vm_exit_reason;
 	unsigned long exit_qualification = vcpu->arch.exit_qualification;
 
 	if (vmx->nested.pml_full) {
-		exit_reason = EXIT_REASON_PML_FULL;
+		vm_exit_reason = EXIT_REASON_PML_FULL;
 		vmx->nested.pml_full = false;
 		exit_qualification &= INTR_INFO_UNBLOCK_NMI;
 	} else if (fault->error_code & PFERR_RSVD_MASK)
-		exit_reason = EXIT_REASON_EPT_MISCONFIG;
+		vm_exit_reason = EXIT_REASON_EPT_MISCONFIG;
 	else
-		exit_reason = EXIT_REASON_EPT_VIOLATION;
+		vm_exit_reason = EXIT_REASON_EPT_VIOLATION;
 
-	nested_vmx_vmexit(vcpu, exit_reason, 0, exit_qualification);
+	nested_vmx_vmexit(vcpu, vm_exit_reason, 0, exit_qualification);
 	vmcs12->guest_physical_address = fault->address;
 }
 
@@ -4002,11 +4002,11 @@ static void sync_vmcs02_to_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
  * which already writes to vmcs12 directly.
  */
 static void prepare_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
-			   u32 exit_reason, u32 exit_intr_info,
+			   u32 vm_exit_reason, u32 exit_intr_info,
 			   unsigned long exit_qualification)
 {
 	/* update exit information fields: */
-	vmcs12->vm_exit_reason = exit_reason;
+	vmcs12->vm_exit_reason = vm_exit_reason;
 	vmcs12->exit_qualification = exit_qualification;
 	vmcs12->vm_exit_intr_info = exit_intr_info;
 
@@ -4318,7 +4318,7 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
  * and modify vmcs12 to make it see what it would expect to see there if
  * L2 was its real guest. Must only be called when in L2 (is_guest_mode())
  */
-void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
+void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		       u32 exit_intr_info, unsigned long exit_qualification)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -4342,9 +4342,9 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
 	if (likely(!vmx->fail)) {
 		sync_vmcs02_to_vmcs12(vcpu, vmcs12);
 
-		if (exit_reason != -1)
-			prepare_vmcs12(vcpu, vmcs12, exit_reason, exit_intr_info,
-				       exit_qualification);
+		if (vm_exit_reason != -1)
+			prepare_vmcs12(vcpu, vmcs12, vm_exit_reason,
+				       exit_intr_info, exit_qualification);
 
 		/*
 		 * Must happen outside of sync_vmcs02_to_vmcs12() as it will
@@ -4399,14 +4399,15 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
 		kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
 	}
 
-	if ((exit_reason != -1) && (enable_shadow_vmcs || vmx->nested.hv_evmcs))
+	if ((vm_exit_reason != -1) &&
+	    (enable_shadow_vmcs || vmx->nested.hv_evmcs))
 		vmx->nested.need_vmcs12_to_shadow_sync = true;
 
 	/* in case we halted in L2 */
 	vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
 
 	if (likely(!vmx->fail)) {
-		if ((u16)exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT &&
+		if ((u16)vm_exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT &&
 		    nested_exit_intr_ack_set(vcpu)) {
 			int irq = kvm_cpu_get_interrupt(vcpu);
 			WARN_ON(irq < 0);
@@ -4414,7 +4415,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
 				INTR_INFO_VALID_MASK | INTR_TYPE_EXT_INTR;
 		}
 
-		if (exit_reason != -1)
+		if (vm_exit_reason != -1)
 			trace_kvm_nested_vmexit_inject(vmcs12->vm_exit_reason,
 						       vmcs12->exit_qualification,
 						       vmcs12->idt_vectoring_info_field,
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index 61cafee13ece..1514ff4db77f 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -26,7 +26,7 @@ void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu);
 enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 						     bool from_vmentry);
 bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu);
-void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
+void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		       u32 exit_intr_info, unsigned long exit_qualification);
 void nested_sync_vmcs12_to_shadow(struct kvm_vcpu *vcpu);
 int vmx_set_vmx_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 data);
-- 
2.26.0

