Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CD0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 227BA2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJ0eb3L8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgEORmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:42:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58785 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726494AbgEORly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589564514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=8eXWyfVvTfwgxocNU4baj2GQMH1oLZpyjDe4vFpeDPQ=;
        b=ZJ0eb3L86lXMCYURCmExuKUYMzvzvJvN63ICG6ehSb95gIkz2H+bA6BxcsvqRY6uddFB6m
        /TJWYXhDG1ur4cNbk+TQjwira6VBudtIc2SZ+nXh8G+Sj2S9u4h9bOpQQfMD+kEGuR9Eu1
        h0TYYdfyuBkxKyqQl5NOuSbY/97hmoA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-UW2S2PzeNjGf4ztG6-k39g-1; Fri, 15 May 2020 13:41:49 -0400
X-MC-Unique: UW2S2PzeNjGf4ztG6-k39g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10B5219200C2;
        Fri, 15 May 2020 17:41:48 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69F6210002CD;
        Fri, 15 May 2020 17:41:47 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Cathy Avery <cavery@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH 2/7] KVM: SVM: extract load_nested_vmcb_control
Date:   Fri, 15 May 2020 13:41:39 -0400
Message-Id: <20200515174144.1727-3-pbonzini@redhat.com>
In-Reply-To: <20200515174144.1727-1-pbonzini@redhat.com>
References: <20200515174144.1727-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When restoring SVM nested state, the control state will be stored already
in svm->nested by KVM_SET_NESTED_STATE.  We will not need to fish it out of
L1's VMCB.  Pull everything into a separate function so that it is
documented which fields are needed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 45 ++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 22f75f66084f..e79acc852000 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -225,6 +225,27 @@ static bool nested_vmcb_checks(struct vmcb *vmcb)
 	return true;
 }
 
+static void load_nested_vmcb_control(struct vcpu_svm *svm, struct vmcb *nested_vmcb)
+{
+	if (kvm_get_rflags(&svm->vcpu) & X86_EFLAGS_IF)
+		svm->vcpu.arch.hflags |= HF_HIF_MASK;
+	else
+		svm->vcpu.arch.hflags &= ~HF_HIF_MASK;
+
+	svm->nested.nested_cr3 = nested_vmcb->control.nested_cr3;
+
+	svm->nested.vmcb_msrpm = nested_vmcb->control.msrpm_base_pa & ~0x0fffULL;
+	svm->nested.vmcb_iopm  = nested_vmcb->control.iopm_base_pa  & ~0x0fffULL;
+
+	/* cache intercepts */
+	svm->nested.intercept_cr         = nested_vmcb->control.intercept_cr;
+	svm->nested.intercept_dr         = nested_vmcb->control.intercept_dr;
+	svm->nested.intercept_exceptions = nested_vmcb->control.intercept_exceptions;
+	svm->nested.intercept            = nested_vmcb->control.intercept;
+
+	svm->vcpu.arch.tsc_offset += nested_vmcb->control.tsc_offset;
+}
+
 void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 			  struct vmcb *nested_vmcb)
 {
@@ -232,15 +253,11 @@ void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 		is_intercept(svm, INTERCEPT_VINTR) ||
 		is_intercept(svm, INTERCEPT_IRET);
 
-	if (kvm_get_rflags(&svm->vcpu) & X86_EFLAGS_IF)
-		svm->vcpu.arch.hflags |= HF_HIF_MASK;
-	else
-		svm->vcpu.arch.hflags &= ~HF_HIF_MASK;
+	svm->nested.vmcb = vmcb_gpa;
+	load_nested_vmcb_control(svm, nested_vmcb);
 
-	if (nested_vmcb->control.nested_ctl & SVM_NESTED_CTL_NP_ENABLE) {
-		svm->nested.nested_cr3 = nested_vmcb->control.nested_cr3;
+	if (nested_vmcb->control.nested_ctl & SVM_NESTED_CTL_NP_ENABLE)
 		nested_svm_init_mmu_context(&svm->vcpu);
-	}
 
 	/* Load the nested guest state */
 	svm->vmcb->save.es = nested_vmcb->save.es;
@@ -275,25 +292,15 @@ void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 	svm->vcpu.arch.dr6  = nested_vmcb->save.dr6;
 	svm->vmcb->save.cpl = nested_vmcb->save.cpl;
 
-	svm->nested.vmcb_msrpm = nested_vmcb->control.msrpm_base_pa & ~0x0fffULL;
-	svm->nested.vmcb_iopm  = nested_vmcb->control.iopm_base_pa  & ~0x0fffULL;
-
-	/* cache intercepts */
-	svm->nested.intercept_cr         = nested_vmcb->control.intercept_cr;
-	svm->nested.intercept_dr         = nested_vmcb->control.intercept_dr;
-	svm->nested.intercept_exceptions = nested_vmcb->control.intercept_exceptions;
-	svm->nested.intercept            = nested_vmcb->control.intercept;
-
 	svm_flush_tlb(&svm->vcpu);
-	svm->vmcb->control.int_ctl = nested_vmcb->control.int_ctl | V_INTR_MASKING_MASK;
 	if (nested_vmcb->control.int_ctl & V_INTR_MASKING_MASK)
 		svm->vcpu.arch.hflags |= HF_VINTR_MASK;
 	else
 		svm->vcpu.arch.hflags &= ~HF_VINTR_MASK;
 
-	svm->vcpu.arch.tsc_offset += nested_vmcb->control.tsc_offset;
 	svm->vmcb->control.tsc_offset = svm->vcpu.arch.tsc_offset;
 
+	svm->vmcb->control.int_ctl = nested_vmcb->control.int_ctl | V_INTR_MASKING_MASK;
 	svm->vmcb->control.virt_ext = nested_vmcb->control.virt_ext;
 	svm->vmcb->control.int_vector = nested_vmcb->control.int_vector;
 	svm->vmcb->control.int_state = nested_vmcb->control.int_state;
@@ -314,8 +321,6 @@ void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 	 */
 	recalc_intercepts(svm);
 
-	svm->nested.vmcb = vmcb_gpa;
-
 	/*
 	 * If L1 had a pending IRQ/NMI before executing VMRUN,
 	 * which wasn't delivered because it was disallowed (e.g.
-- 
2.18.2


