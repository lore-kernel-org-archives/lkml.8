Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B54C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA56F2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3hSr7OJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgEFLLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 07:11:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50703 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728278AbgEFLKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 07:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588763449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=+RdRe4V7IwgQkRUVtBHtkzWDMGu2ps3B9XGwHFcspaM=;
        b=B3hSr7OJJOxHHUSYQv3xb04WGyOSSMxy4+YwjfAd8XkcTHQSrQ+6+xboNB7DwlfvCoXcp0
        UzX2LthdxGs4uVDzOUz4XIMAmBdSrKbzie0ApEvZ4seBoDeBgft6Cq3saiGqj/qAIGEMYd
        dPuh5WN60MruA4dAXoJkBo53IWUdH/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-1n7geU-ENfu88gqG-gClxQ-1; Wed, 06 May 2020 07:10:48 -0400
X-MC-Unique: 1n7geU-ENfu88gqG-gClxQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E33BC107ACF2;
        Wed,  6 May 2020 11:10:46 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D7B95C1D4;
        Wed,  6 May 2020 11:10:46 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 7/9] KVM: x86: simplify dr6 accessors in kvm_x86_ops
Date:   Wed,  6 May 2020 07:10:32 -0400
Message-Id: <20200506111034.11756-8-pbonzini@redhat.com>
In-Reply-To: <20200506111034.11756-1-pbonzini@redhat.com>
References: <20200506111034.11756-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
index 8c247bcb037e..93f6f696d059 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1093,7 +1093,6 @@ struct kvm_x86_ops {
 	void (*set_idt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*get_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*set_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
-	u64 (*get_dr6)(struct kvm_vcpu *vcpu);
 	void (*set_dr6)(struct kvm_vcpu *vcpu, unsigned long value);
 	void (*sync_dirty_debug_regs)(struct kvm_vcpu *vcpu);
 	void (*set_dr7)(struct kvm_vcpu *vcpu, unsigned long value);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5627004e077e..f03bffafd9e6 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1672,11 +1672,6 @@ static void new_asid(struct vcpu_svm *svm, struct svm_cpu_data *sd)
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
@@ -3932,7 +3927,6 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.set_idt = svm_set_idt,
 	.get_gdt = svm_get_gdt,
 	.set_gdt = svm_set_gdt,
-	.get_dr6 = svm_get_dr6,
 	.set_dr6 = svm_set_dr6,
 	.set_dr7 = svm_set_dr7,
 	.sync_dirty_debug_regs = svm_sync_dirty_debug_regs,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2384a2dbec44..e2b71b0cdfce 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4965,15 +4965,6 @@ static int handle_dr(struct kvm_vcpu *vcpu)
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
@@ -7736,8 +7727,6 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.set_idt = vmx_set_idt,
 	.get_gdt = vmx_get_gdt,
 	.set_gdt = vmx_set_gdt,
-	.get_dr6 = vmx_get_dr6,
-	.set_dr6 = vmx_set_dr6,
 	.set_dr7 = vmx_set_dr7,
 	.sync_dirty_debug_regs = vmx_sync_dirty_debug_regs,
 	.cache_reg = vmx_cache_reg,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f7628555f036..f4254d716b10 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1050,7 +1050,8 @@ static void kvm_update_dr0123(struct kvm_vcpu *vcpu)
 
 static void kvm_update_dr6(struct kvm_vcpu *vcpu)
 {
-	if (!(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP))
+	if (!(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP) &&
+	    kvm_x86_ops.set_dr6)
 		kvm_x86_ops.set_dr6(vcpu, vcpu->arch.dr6);
 }
 
@@ -1129,10 +1130,7 @@ int kvm_get_dr(struct kvm_vcpu *vcpu, int dr, unsigned long *val)
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


