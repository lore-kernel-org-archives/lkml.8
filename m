Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14F6C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41BE20704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LEHQF3KM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgDXRYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:24:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22928 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728775AbgDXRYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587749081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=M5zmmJBcB8NXxnUPKEdXOI3rlhBgtaPigdqzfMYvM/0=;
        b=LEHQF3KMR1mIbLO/Yo/f90RjN1YFx9RpDPX+dO3IoS+qFic1WXkRI/frqOHr/Ro0EKsFSm
        mFeYnzpfgl7ytf4INh07yqYQLVCJ6MJ9fNS+/kfXTitzvt7RSwmC7uwZBbamgvSMbUWW7w
        W2/OTgk070O1cPou6OqKtP2qnOIlA2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-wvJvkwPlMP-TwkNyySnKEA-1; Fri, 24 Apr 2020 13:24:37 -0400
X-MC-Unique: wvJvkwPlMP-TwkNyySnKEA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F7B41018856;
        Fri, 24 Apr 2020 17:24:27 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 589F61FDE1;
        Fri, 24 Apr 2020 17:24:26 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     wei.huang2@amd.com, cavery@redhat.com, vkuznets@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Oliver Upton <oupton@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH v2 08/22] KVM: x86: Make return for {interrupt_nmi,smi}_allowed() a bool instead of int
Date:   Fri, 24 Apr 2020 13:24:02 -0400
Message-Id: <20200424172416.243870-9-pbonzini@redhat.com>
In-Reply-To: <20200424172416.243870-1-pbonzini@redhat.com>
References: <20200424172416.243870-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Return an actual bool for kvm_x86_ops' {interrupt_nmi}_allowed() hook to
better reflect the return semantics, and to avoid creating an even
bigger mess when the related VMX code is refactored in upcoming patches.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Message-Id: <20200423022550.15113-5-sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  6 +++---
 arch/x86/kvm/svm/svm.c          | 16 ++++++++--------
 arch/x86/kvm/vmx/vmx.c          | 14 +++++++-------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 372e6ea4af32..efaddc68a694 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1139,8 +1139,8 @@ struct kvm_x86_ops {
 	void (*set_nmi)(struct kvm_vcpu *vcpu);
 	void (*queue_exception)(struct kvm_vcpu *vcpu);
 	void (*cancel_injection)(struct kvm_vcpu *vcpu);
-	int (*interrupt_allowed)(struct kvm_vcpu *vcpu);
-	int (*nmi_allowed)(struct kvm_vcpu *vcpu);
+	bool (*interrupt_allowed)(struct kvm_vcpu *vcpu);
+	bool (*nmi_allowed)(struct kvm_vcpu *vcpu);
 	bool (*get_nmi_mask)(struct kvm_vcpu *vcpu);
 	void (*set_nmi_mask)(struct kvm_vcpu *vcpu, bool masked);
 	void (*enable_nmi_window)(struct kvm_vcpu *vcpu);
@@ -1238,7 +1238,7 @@ struct kvm_x86_ops {
 
 	void (*setup_mce)(struct kvm_vcpu *vcpu);
 
-	int (*smi_allowed)(struct kvm_vcpu *vcpu);
+	bool (*smi_allowed)(struct kvm_vcpu *vcpu);
 	int (*pre_enter_smm)(struct kvm_vcpu *vcpu, char *smstate);
 	int (*pre_leave_smm)(struct kvm_vcpu *vcpu, const char *smstate);
 	int (*enable_smi_window)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 8e732eb0b5c9..cdee634e961d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3062,11 +3062,11 @@ static void update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
 		set_cr_intercept(svm, INTERCEPT_CR8_WRITE);
 }
 
-static int svm_nmi_allowed(struct kvm_vcpu *vcpu)
+static bool svm_nmi_allowed(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb = svm->vmcb;
-	int ret;
+	bool ret;
 
 	ret = !(vmcb->control.int_state & SVM_INTERRUPT_SHADOW_MASK) &&
 	      !(svm->vcpu.arch.hflags & HF_NMI_MASK);
@@ -3095,14 +3095,14 @@ static void svm_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked)
 	}
 }
 
-static int svm_interrupt_allowed(struct kvm_vcpu *vcpu)
+static bool svm_interrupt_allowed(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb = svm->vmcb;
 
 	if (!gif_set(svm) ||
 	     (vmcb->control.int_state & SVM_INTERRUPT_SHADOW_MASK))
-		return 0;
+		return false;
 
 	if (is_guest_mode(vcpu) && (svm->vcpu.arch.hflags & HF_VINTR_MASK))
 		return !!(svm->vcpu.arch.hflags & HF_HIF_MASK);
@@ -3755,23 +3755,23 @@ static void svm_setup_mce(struct kvm_vcpu *vcpu)
 	vcpu->arch.mcg_cap &= 0x1ff;
 }
 
-static int svm_smi_allowed(struct kvm_vcpu *vcpu)
+static bool svm_smi_allowed(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	/* Per APM Vol.2 15.22.2 "Response to SMI" */
 	if (!gif_set(svm))
-		return 0;
+		return false;
 
 	if (is_guest_mode(&svm->vcpu) &&
 	    svm->nested.intercept & (1ULL << INTERCEPT_SMI)) {
 		/* TODO: Might need to set exit_info_1 and exit_info_2 here */
 		svm->vmcb->control.exit_code = SVM_EXIT_SMI;
 		svm->nested.exit_required = true;
-		return 0;
+		return false;
 	}
 
-	return 1;
+	return true;
 }
 
 static int svm_pre_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 455cd2c8dbce..c98194f04b04 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4511,21 +4511,21 @@ void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked)
 	}
 }
 
-static int vmx_nmi_allowed(struct kvm_vcpu *vcpu)
+static bool vmx_nmi_allowed(struct kvm_vcpu *vcpu)
 {
 	if (to_vmx(vcpu)->nested.nested_run_pending)
-		return 0;
+		return false;
 
 	if (!enable_vnmi &&
 	    to_vmx(vcpu)->loaded_vmcs->soft_vnmi_blocked)
-		return 0;
+		return false;
 
 	return	!(vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) &
 		  (GUEST_INTR_STATE_MOV_SS | GUEST_INTR_STATE_STI
 		   | GUEST_INTR_STATE_NMI));
 }
 
-static int vmx_interrupt_allowed(struct kvm_vcpu *vcpu)
+static bool vmx_interrupt_allowed(struct kvm_vcpu *vcpu)
 {
 	if (to_vmx(vcpu)->nested.nested_run_pending)
 		return false;
@@ -7675,12 +7675,12 @@ static void vmx_setup_mce(struct kvm_vcpu *vcpu)
 			~FEAT_CTL_LMCE_ENABLED;
 }
 
-static int vmx_smi_allowed(struct kvm_vcpu *vcpu)
+static bool vmx_smi_allowed(struct kvm_vcpu *vcpu)
 {
 	/* we need a nested vmexit to enter SMM, postpone if run is pending */
 	if (to_vmx(vcpu)->nested.nested_run_pending)
-		return 0;
-	return 1;
+		return false;
+	return true;
 }
 
 static int vmx_pre_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
-- 
2.18.2


