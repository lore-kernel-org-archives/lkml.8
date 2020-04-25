Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04771C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F5B20857
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgrbJDpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgDYHCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 03:02:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21362 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726234AbgDYHCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 03:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587798125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=ASlviBxFLp+Z3Ulj6MCrDwXnWDa6GkiqlDL/SqVZeZg=;
        b=AgrbJDpuXg0RBVBAoJ1l4slD9/3Zhhq38OtHhfQQOd2RPTNVExCmluJtXnrkrs3bm3mfK3
        sxt4Hw5Ohp1giBDmlg9UQRpH4eYnusn6o2gVwEU2m0jD0bJYY4QqWhFsZGeaw/sKy9hMIM
        1Xq+dEbwJclVA6MFPCVkqc5hGHlLmCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-K5LGcn-VOBe4kFRGf0a0lQ-1; Sat, 25 Apr 2020 03:02:03 -0400
X-MC-Unique: K5LGcn-VOBe4kFRGf0a0lQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7515107ACF5;
        Sat, 25 Apr 2020 07:02:01 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27F955D9C5;
        Sat, 25 Apr 2020 07:02:01 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     wei.huang2@amd.com, cavery@redhat.com, vkuznets@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Oliver Upton <oupton@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH v2 17/22] KVM: nSVM: Report interrupts as allowed when in L2 and exit-on-interrupt is set
Date:   Sat, 25 Apr 2020 03:01:49 -0400
Message-Id: <20200425070154.251290-8-pbonzini@redhat.com>
In-Reply-To: <20200424172416.243870-1-pbonzini@redhat.com>
References: <20200424172416.243870-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Report interrupts as allowed when the vCPU is in L2 and L2 is being run with
exit-on-interrupts enabled and EFLAGS.IF=1 (either on the host or on the guest
according to VINTR).  Interrupts are always unblocked from L1's perspective
in this case.

While moving nested_exit_on_intr to svm.h, use INTERCEPT_INTR properly instead
of assuming it's zero (which it is of course).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c |  5 -----
 arch/x86/kvm/svm/svm.c    | 23 +++++++++++++++++------
 arch/x86/kvm/svm/svm.h    |  5 +++++
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 226d5a0d677b..a7a3d695405e 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -805,11 +805,6 @@ static void nested_svm_intr(struct vcpu_svm *svm)
 	nested_svm_vmexit(svm);
 }
 
-static bool nested_exit_on_intr(struct vcpu_svm *svm)
-{
-	return (svm->nested.intercept & 1ULL);
-}
-
 static int svm_check_nested_events(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4e284b62d384..0bbb2cd24eb7 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3114,14 +3114,25 @@ bool svm_interrupt_blocked(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb = svm->vmcb;
 
-	if (!gif_set(svm) ||
-	     (vmcb->control.int_state & SVM_INTERRUPT_SHADOW_MASK))
+	if (!gif_set(svm))
 		return true;
 
-	if (is_guest_mode(vcpu) && (svm->vcpu.arch.hflags & HF_VINTR_MASK))
-		return !(svm->vcpu.arch.hflags & HF_HIF_MASK);
-	else
-		return !(kvm_get_rflags(vcpu) & X86_EFLAGS_IF);
+	if (is_guest_mode(vcpu)) {
+		/* As long as interrupts are being delivered...  */
+		if ((svm->vcpu.arch.hflags & HF_VINTR_MASK)
+		    ? !(svm->vcpu.arch.hflags & HF_HIF_MASK)
+		    : !(kvm_get_rflags(vcpu) & X86_EFLAGS_IF))
+			return true;
+
+		/* ... vmexits aren't blocked by the interrupt shadow  */
+		if (nested_exit_on_intr(svm))
+			return false;
+	} else {
+		if (!(kvm_get_rflags(vcpu) & X86_EFLAGS_IF))
+			return true;
+	}
+
+	return (vmcb->control.int_state & SVM_INTERRUPT_SHADOW_MASK);
 }
 
 static bool svm_interrupt_allowed(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index f6d604b72a4c..5cc559ab862d 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -386,6 +386,11 @@ static inline bool nested_exit_on_smi(struct vcpu_svm *svm)
 	return (svm->nested.intercept & (1ULL << INTERCEPT_SMI));
 }
 
+static inline bool nested_exit_on_intr(struct vcpu_svm *svm)
+{
+	return (svm->nested.intercept & (1ULL << INTERCEPT_INTR));
+}
+
 static inline bool nested_exit_on_nmi(struct vcpu_svm *svm)
 {
 	return (svm->nested.intercept & (1ULL << INTERCEPT_NMI));
-- 
2.18.2


