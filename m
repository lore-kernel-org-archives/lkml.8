Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BBBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B5E720723
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+x1RqWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388765AbgEZRXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:23:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40959 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389247AbgEZRXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590513821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xlF8Z0cf4T+1GZUpDmhL6e1Zl/Rb2Ws3/nTkyWGvwaA=;
        b=N+x1RqWWvfcRZJJUiYR4BRbzByXoCLoQui9ad20C2qkMTQQQoaoXL5hfkeRSe2y49lGC4c
        3PQwOF9/I0V50uV/TQ0O3JvBQkW0aKm7sezJ80LJG1QPqGUHw2Ir0ubZH5Xc/ulgIe1P52
        PHq/TGXQq1hVEWy8UM+dQ9X8bKjenrE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-n7PfE3qPMdq3oNy49cTZhw-1; Tue, 26 May 2020 13:23:38 -0400
X-MC-Unique: n7PfE3qPMdq3oNy49cTZhw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD6DD1005512;
        Tue, 26 May 2020 17:23:36 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52A8A5C1BB;
        Tue, 26 May 2020 17:23:31 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, mlevitsk@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH 17/28] KVM: nSVM: synchronize VMCB controls updated by the processor on every vmexit
Date:   Tue, 26 May 2020 13:22:57 -0400
Message-Id: <20200526172308.111575-18-pbonzini@redhat.com>
In-Reply-To: <20200526172308.111575-1-pbonzini@redhat.com>
References: <20200526172308.111575-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The control state changes on every L2->L0 vmexit, and we will have to
serialize it in the nested state.  So keep it up to date in svm->nested.ctl
and just copy them back to the nested VMCB in nested_svm_vmexit.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 57 ++++++++++++++++++++++-----------------
 arch/x86/kvm/svm/svm.c    |  5 +++-
 arch/x86/kvm/svm/svm.h    |  1 +
 3 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 7f739f9a797c..4355286b2726 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -234,6 +234,34 @@ static void load_nested_vmcb_control(struct vcpu_svm *svm,
 	svm->nested.ctl.iopm_base_pa  &= ~0x0fffULL;
 }
 
+/*
+ * Synchronize fields that are written by the processor, so that
+ * they can be copied back into the nested_vmcb.
+ */
+void sync_nested_vmcb_control(struct vcpu_svm *svm)
+{
+	u32 mask;
+	svm->nested.ctl.event_inj      = svm->vmcb->control.event_inj;
+	svm->nested.ctl.event_inj_err  = svm->vmcb->control.event_inj_err;
+
+	/* Only a few fields of int_ctl are written by the processor.  */
+	mask = V_IRQ_MASK | V_TPR_MASK;
+	if (!(svm->nested.ctl.int_ctl & V_INTR_MASKING_MASK) &&
+	    is_intercept(svm, SVM_EXIT_VINTR)) {
+		/*
+		 * In order to request an interrupt window, L0 is usurping
+		 * svm->vmcb->control.int_ctl and possibly setting V_IRQ
+		 * even if it was clear in L1's VMCB.  Restoring it would be
+		 * wrong.  However, in this case V_IRQ will remain true until
+		 * interrupt_window_interception calls svm_clear_vintr and
+		 * restores int_ctl.  We can just leave it aside.
+		 */
+		mask &= ~V_IRQ_MASK;
+	}
+	svm->nested.ctl.int_ctl        &= ~mask;
+	svm->nested.ctl.int_ctl        |= svm->vmcb->control.int_ctl & mask;
+}
+
 static void nested_prepare_vmcb_save(struct vcpu_svm *svm, struct vmcb *nested_vmcb)
 {
 	/* Load the nested guest state */
@@ -471,6 +499,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	/* Exit Guest-Mode */
 	leave_guest_mode(&svm->vcpu);
 	svm->nested.vmcb = 0;
+	WARN_ON_ONCE(svm->nested.nested_run_pending);
 
 	/* in case we halted in L2 */
 	svm->vcpu.arch.mp_state = KVM_MP_STATE_RUNNABLE;
@@ -497,8 +526,6 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	nested_vmcb->save.dr6    = svm->vcpu.arch.dr6;
 	nested_vmcb->save.cpl    = vmcb->save.cpl;
 
-	nested_vmcb->control.int_ctl           = vmcb->control.int_ctl;
-	nested_vmcb->control.int_vector        = vmcb->control.int_vector;
 	nested_vmcb->control.int_state         = vmcb->control.int_state;
 	nested_vmcb->control.exit_code         = vmcb->control.exit_code;
 	nested_vmcb->control.exit_code_hi      = vmcb->control.exit_code_hi;
@@ -510,34 +537,16 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	if (svm->nrips_enabled)
 		nested_vmcb->control.next_rip  = vmcb->control.next_rip;
 
-	/*
-	 * If we emulate a VMRUN/#VMEXIT in the same host #vmexit cycle we have
-	 * to make sure that we do not lose injected events. So check event_inj
-	 * here and copy it to exit_int_info if it is valid.
-	 * Exit_int_info and event_inj can't be both valid because the case
-	 * below only happens on a VMRUN instruction intercept which has
-	 * no valid exit_int_info set.
-	 */
-	if (vmcb->control.event_inj & SVM_EVTINJ_VALID) {
-		struct vmcb_control_area *nc = &nested_vmcb->control;
-
-		nc->exit_int_info     = vmcb->control.event_inj;
-		nc->exit_int_info_err = vmcb->control.event_inj_err;
-	}
-
-	nested_vmcb->control.tlb_ctl           = 0;
-	nested_vmcb->control.event_inj         = 0;
-	nested_vmcb->control.event_inj_err     = 0;
+	nested_vmcb->control.int_ctl           = svm->nested.ctl.int_ctl;
+	nested_vmcb->control.tlb_ctl           = svm->nested.ctl.tlb_ctl;
+	nested_vmcb->control.event_inj         = svm->nested.ctl.event_inj;
+	nested_vmcb->control.event_inj_err     = svm->nested.ctl.event_inj_err;
 
 	nested_vmcb->control.pause_filter_count =
 		svm->vmcb->control.pause_filter_count;
 	nested_vmcb->control.pause_filter_thresh =
 		svm->vmcb->control.pause_filter_thresh;
 
-	/* We always set V_INTR_MASKING and remember the old value in hflags */
-	if (!(svm->vcpu.arch.hflags & HF_VINTR_MASK))
-		nested_vmcb->control.int_ctl &= ~V_INTR_MASKING_MASK;
-
 	/* Restore the original control entries */
 	copy_vmcb_control_area(&vmcb->control, &hsave->control);
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c213011a82e3..97dbd6f65831 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3427,7 +3427,10 @@ static fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
 	sync_cr8_to_lapic(vcpu);
 
 	svm->next_rip = 0;
-	svm->nested.nested_run_pending = 0;
+	if (is_guest_mode(&svm->vcpu)) {
+		sync_nested_vmcb_control(svm);
+		svm->nested.nested_run_pending = 0;
+	}
 
 	svm->vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index dd5418f20256..7e79f0af1204 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -394,6 +394,7 @@ int nested_svm_check_permissions(struct vcpu_svm *svm);
 int nested_svm_check_exception(struct vcpu_svm *svm, unsigned nr,
 			       bool has_error_code, u32 error_code);
 int nested_svm_exit_special(struct vcpu_svm *svm);
+void sync_nested_vmcb_control(struct vcpu_svm *svm);
 
 extern struct kvm_x86_nested_ops svm_nested_ops;
 
-- 
2.26.2


