Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF51C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF5462075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imhUTXuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgETRX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:23:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33056 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727978AbgETRWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589995323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=CsggIm2JXx6N5X0Cx+mQFusEbTz4B2QIzPuOWDri1WQ=;
        b=imhUTXuRektDUdLI2HeE4uyYfO02jnxdmNversg7J3a9+CNChhZZ8QB07R3GpxPQD/rztC
        hA4IBbXBGB2jPBPFgoDoLvUsG8hvKw3sU/fvONnBLsuEErpm5kOBAjs80o5JHhSOsvs4bm
        RK4vuyEa4yR26G+4VJGdNhLi0SGiBY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-aGEeDlfdNjC4vW6vRD9REA-1; Wed, 20 May 2020 13:21:58 -0400
X-MC-Unique: aGEeDlfdNjC4vW6vRD9REA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 595381085939;
        Wed, 20 May 2020 17:21:53 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C680682A33;
        Wed, 20 May 2020 17:21:52 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 07/24] KVM: nSVM: extract load_nested_vmcb_control
Date:   Wed, 20 May 2020 13:21:28 -0400
Message-Id: <20200520172145.23284-8-pbonzini@redhat.com>
In-Reply-To: <20200520172145.23284-1-pbonzini@redhat.com>
References: <20200520172145.23284-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When restoring SVM nested state, the control state cache in svm->nested
will have to be filled, but the save state will not have to be moved
into svm->vmcb.  Therefore, pull the code that handles the control area
into a separate function.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 083f11d5e3fa..b1d0d0519664 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -228,6 +228,23 @@ static bool nested_vmcb_checks(struct vmcb *vmcb)
 	return true;
 }
 
+static void load_nested_vmcb_control(struct vcpu_svm *svm,
+				     struct vmcb_control_area *control)
+{
+	svm->nested.nested_cr3 = control->nested_cr3;
+
+	svm->nested.vmcb_msrpm = control->msrpm_base_pa & ~0x0fffULL;
+	svm->nested.vmcb_iopm  = control->iopm_base_pa  & ~0x0fffULL;
+
+	/* cache intercepts */
+	svm->nested.intercept_cr         = control->intercept_cr;
+	svm->nested.intercept_dr         = control->intercept_dr;
+	svm->nested.intercept_exceptions = control->intercept_exceptions;
+	svm->nested.intercept            = control->intercept;
+
+	svm->vcpu.arch.tsc_offset += control->tsc_offset;
+}
+
 void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 			  struct vmcb *nested_vmcb)
 {
@@ -235,15 +252,16 @@ void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 		is_intercept(svm, INTERCEPT_VINTR) ||
 		is_intercept(svm, INTERCEPT_IRET);
 
+	svm->nested.vmcb = vmcb_gpa;
 	if (kvm_get_rflags(&svm->vcpu) & X86_EFLAGS_IF)
 		svm->vcpu.arch.hflags |= HF_HIF_MASK;
 	else
 		svm->vcpu.arch.hflags &= ~HF_HIF_MASK;
 
-	if (nested_vmcb->control.nested_ctl & SVM_NESTED_CTL_NP_ENABLE) {
-		svm->nested.nested_cr3 = nested_vmcb->control.nested_cr3;
+	load_nested_vmcb_control(svm, &nested_vmcb->control);
+
+	if (nested_vmcb->control.nested_ctl & SVM_NESTED_CTL_NP_ENABLE)
 		nested_svm_init_mmu_context(&svm->vcpu);
-	}
 
 	/* Load the nested guest state */
 	svm->vmcb->save.es = nested_vmcb->save.es;
@@ -278,25 +296,15 @@ void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
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
@@ -317,8 +325,6 @@ void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 	 */
 	recalc_intercepts(svm);
 
-	svm->nested.vmcb = vmcb_gpa;
-
 	/*
 	 * If L1 had a pending IRQ/NMI before executing VMRUN,
 	 * which wasn't delivered because it was disallowed (e.g.
-- 
2.18.2


