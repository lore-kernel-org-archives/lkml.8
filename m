Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB2CC55196
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A2C620767
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1DfdRxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgDYHCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 03:02:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36147 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726117AbgDYHCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 03:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587798122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=MsffsW/Ybv32snRIiX79A6qL6RuUG9dFSSyzWZBtQSo=;
        b=d1DfdRxM2KzZmVuEV1g23Kp5u0gmsVqonAI6CTcBwtYOISMdccRs39oRb4OJ/7qiVW8rLd
        0KaCs0PWGQH0zSqxG1/8yNPtklRkfsNWOGxmmhlEupANak/5TmcfVhV9Tq6TsSaO1LQ++/
        USpI1PMPiI9oxx4lbIMbTpcDEDgjabU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-d_v5AaPbNJSYOT_En_BfeA-1; Sat, 25 Apr 2020 03:02:00 -0400
X-MC-Unique: d_v5AaPbNJSYOT_En_BfeA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 613F8835B40;
        Sat, 25 Apr 2020 07:01:59 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7D8E5D9C5;
        Sat, 25 Apr 2020 07:01:58 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     wei.huang2@amd.com, cavery@redhat.com, vkuznets@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Oliver Upton <oupton@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH v2 14/22] KVM: SVM: Split out architectural interrupt/NMI/SMI blocking checks
Date:   Sat, 25 Apr 2020 03:01:46 -0400
Message-Id: <20200425070154.251290-5-pbonzini@redhat.com>
In-Reply-To: <20200424172416.243870-1-pbonzini@redhat.com>
References: <20200424172416.243870-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the architectural (non-KVM specific) interrupt/NMI/SMI blocking checks
to a separate helper so that they can be used in a future patch by
svm_check_nested_events().

No functional change intended.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 51 +++++++++++++++++++++++++++++++++---------
 arch/x86/kvm/svm/svm.h |  3 +++
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 1f9577b281e6..4e284b62d384 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3062,22 +3062,33 @@ static void update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
 		set_cr_intercept(svm, INTERCEPT_CR8_WRITE);
 }
 
-static bool svm_nmi_allowed(struct kvm_vcpu *vcpu)
+bool svm_nmi_blocked(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb = svm->vmcb;
 	bool ret;
 
-	if (is_guest_mode(vcpu) && nested_exit_on_nmi(svm))
+	if (!gif_set(svm))
 		return true;
 
-	ret = !(vmcb->control.int_state & SVM_INTERRUPT_SHADOW_MASK) &&
-	      !(svm->vcpu.arch.hflags & HF_NMI_MASK);
-	ret = ret && gif_set(svm);
+	if (is_guest_mode(vcpu) && nested_exit_on_nmi(svm))
+		return false;
+
+	ret = (vmcb->control.int_state & SVM_INTERRUPT_SHADOW_MASK) ||
+	      (svm->vcpu.arch.hflags & HF_NMI_MASK);
 
 	return ret;
 }
 
+static bool svm_nmi_allowed(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	if (svm->nested.nested_run_pending)
+		return false;
+
+        return !svm_nmi_blocked(vcpu);
+}
+
 static bool svm_get_nmi_mask(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -3098,19 +3109,28 @@ static void svm_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked)
 	}
 }
 
-static bool svm_interrupt_allowed(struct kvm_vcpu *vcpu)
+bool svm_interrupt_blocked(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb = svm->vmcb;
 
 	if (!gif_set(svm) ||
 	     (vmcb->control.int_state & SVM_INTERRUPT_SHADOW_MASK))
-		return false;
+		return true;
 
 	if (is_guest_mode(vcpu) && (svm->vcpu.arch.hflags & HF_VINTR_MASK))
-		return !!(svm->vcpu.arch.hflags & HF_HIF_MASK);
+		return !(svm->vcpu.arch.hflags & HF_HIF_MASK);
 	else
-		return !!(kvm_get_rflags(vcpu) & X86_EFLAGS_IF);
+		return !(kvm_get_rflags(vcpu) & X86_EFLAGS_IF);
+}
+
+static bool svm_interrupt_allowed(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	if (svm->nested.nested_run_pending)
+		return false;
+
+        return !svm_interrupt_blocked(vcpu);
 }
 
 static void enable_irq_window(struct kvm_vcpu *vcpu)
@@ -3758,15 +3778,24 @@ static void svm_setup_mce(struct kvm_vcpu *vcpu)
 	vcpu->arch.mcg_cap &= 0x1ff;
 }
 
-static bool svm_smi_allowed(struct kvm_vcpu *vcpu)
+bool svm_smi_blocked(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	/* Per APM Vol.2 15.22.2 "Response to SMI" */
 	if (!gif_set(svm))
+		return true;
+
+	return is_smm(vcpu);
+}
+
+static bool svm_smi_allowed(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	if (svm->nested.nested_run_pending)
 		return false;
 
-	return !is_smm(vcpu);
+	return !svm_smi_blocked(vcpu);
 }
 
 static int svm_pre_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 4dc6d2b4b721..f6d604b72a4c 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -366,6 +366,9 @@ void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
 int svm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
 void svm_flush_tlb(struct kvm_vcpu *vcpu);
 void disable_nmi_singlestep(struct vcpu_svm *svm);
+bool svm_smi_blocked(struct kvm_vcpu *vcpu);
+bool svm_nmi_blocked(struct kvm_vcpu *vcpu);
+bool svm_interrupt_blocked(struct kvm_vcpu *vcpu);
 
 /* nested.c */
 
-- 
2.18.2


