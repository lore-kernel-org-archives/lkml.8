Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B074C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEADC20721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1Z0Z9P6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgEDP4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:56:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50738 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729469AbgEDP4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588607763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=TRIAnDu96msMatDFNvcw7+xZFCfw7JXhqubNXWJ3YOs=;
        b=D1Z0Z9P61hAcSS5US6jktyzb0eBMQTWRRjh90U4lOh7+rJjJJ8M+AiBXvYko/cUYQ4tRu6
        +yPfnubgmF3caXLqSsrKgczeTIGNyUX5/cgiwisAC44Cv9zpZJYTKg8k4DC2Xjc+3lNrT6
        +HH6c+gpNWNVPP/QKWPtVV7tqMVY9TM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-tC6UxxlvP_CU6out0Yq5jA-1; Mon, 04 May 2020 11:56:02 -0400
X-MC-Unique: tC6UxxlvP_CU6out0Yq5jA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E80121899521;
        Mon,  4 May 2020 15:56:00 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 791B86FF1A;
        Mon,  4 May 2020 15:56:00 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 3/3] KVM: x86: simplify dr6 accessors in kvm_x86_ops
Date:   Mon,  4 May 2020 11:55:58 -0400
Message-Id: <20200504155558.401468-4-pbonzini@redhat.com>
In-Reply-To: <20200504155558.401468-1-pbonzini@redhat.com>
References: <20200504155558.401468-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_x86_ops.set_dr6 is only ever called with vcpu->arch.dr6 as the
second argument, and for both SVM and VMX the VMCB value is kept
synchronized with vcpu->arch.dr6 on #DB; we can therefore remove the
read accessor.

For the write accessor we can avoid the retpoline penalty on Intel
by accepting a NULL value and just skipping the call in that case.

Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/svm/svm.c          |  6 ------
 arch/x86/kvm/vmx/vmx.c          | 11 -----------
 arch/x86/kvm/x86.c              |  8 +++-----
 4 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 90840593cd6c..e218d907ba46 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1100,7 +1100,6 @@ struct kvm_x86_ops {
 	void (*set_idt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*get_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*set_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
-	u64 (*get_dr6)(struct kvm_vcpu *vcpu);
 	void (*set_dr6)(struct kvm_vcpu *vcpu, unsigned long value);
 	void (*sync_dirty_debug_regs)(struct kvm_vcpu *vcpu);
 	void (*set_dr7)(struct kvm_vcpu *vcpu, unsigned long value);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 6b65c75b6816..d8bc1b78a3c6 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1652,11 +1652,6 @@ static void new_asid(struct vcpu_svm *svm, struct svm_cpu_data *sd)
 	mark_dirty(svm->vmcb, VMCB_ASID);
 }
 
-static u64 svm_get_dr6(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.dr6;
-}
-
 static void svm_set_dr6(struct kvm_vcpu *vcpu, unsigned long value)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -3996,7 +3991,6 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.set_idt = svm_set_idt,
 	.get_gdt = svm_get_gdt,
 	.set_gdt = svm_set_gdt,
-	.get_dr6 = svm_get_dr6,
 	.set_dr6 = svm_set_dr6,
 	.set_dr7 = svm_set_dr7,
 	.sync_dirty_debug_regs = svm_sync_dirty_debug_regs,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index fce11f2c4c55..82042b7028a9 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5023,15 +5023,6 @@ static int handle_dr(struct kvm_vcpu *vcpu)
 	return kvm_skip_emulated_instruction(vcpu);
 }
 
-static u64 vmx_get_dr6(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.dr6;
-}
-
-static void vmx_set_dr6(struct kvm_vcpu *vcpu, unsigned long val)
-{
-}
-
 static void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
 {
 	get_debugreg(vcpu->arch.db[0], 0);
@@ -7812,8 +7803,6 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.set_idt = vmx_set_idt,
 	.get_gdt = vmx_get_gdt,
 	.set_gdt = vmx_set_gdt,
-	.get_dr6 = vmx_get_dr6,
-	.set_dr6 = vmx_set_dr6,
 	.set_dr7 = vmx_set_dr7,
 	.sync_dirty_debug_regs = vmx_sync_dirty_debug_regs,
 	.cache_reg = vmx_cache_reg,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8ec356ac1e6e..0ba83748cd53 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1069,7 +1069,8 @@ static void kvm_update_dr0123(struct kvm_vcpu *vcpu)
 
 static void kvm_update_dr6(struct kvm_vcpu *vcpu)
 {
-	if (!(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP))
+	if (!(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP) &&
+	    kvm_x86_ops.set_dr6)
 		kvm_x86_ops.set_dr6(vcpu, vcpu->arch.dr6);
 }
 
@@ -1148,10 +1149,7 @@ int kvm_get_dr(struct kvm_vcpu *vcpu, int dr, unsigned long *val)
 	case 4:
 		/* fall through */
 	case 6:
-		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP)
-			*val = vcpu->arch.dr6;
-		else
-			*val = kvm_x86_ops.get_dr6(vcpu);
+		*val = vcpu->arch.dr6;
 		break;
 	case 5:
 		/* fall through */
-- 
2.18.2

