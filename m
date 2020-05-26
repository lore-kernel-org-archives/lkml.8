Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7CDC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C51820723
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLNVPTWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389312AbgEZRX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:23:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27669 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389283AbgEZRXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590513831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oeV72J15QCPWiP3+Rx2xithsylBmfUbD49Cly0s95hU=;
        b=KLNVPTWL0HAZz1d9ef9N5dkSumzbU/lEnucONSjyD9qQQPQCOTwWXfLdOVPt9VSzCx7QP8
        SNXVZ12L05qpg4xtBdnLb15Rm4Yo6hmeYx0/q1CFxj6dpEPiZ/VOhQYjQl5/+NisX4F6p0
        QbcrkTipXjqZHvzeAYA4kL8IAsLkUGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-IWUXR7zvMOq5NNFD475dKg-1; Tue, 26 May 2020 13:23:50 -0400
X-MC-Unique: IWUXR7zvMOq5NNFD475dKg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1128F18A0760;
        Tue, 26 May 2020 17:23:49 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 552F45D9E8;
        Tue, 26 May 2020 17:23:48 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, mlevitsk@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH 22/28] KVM: nSVM: remove HF_VINTR_MASK
Date:   Tue, 26 May 2020 13:23:02 -0400
Message-Id: <20200526172308.111575-23-pbonzini@redhat.com>
In-Reply-To: <20200526172308.111575-1-pbonzini@redhat.com>
References: <20200526172308.111575-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the int_ctl field is stored in svm->nested.ctl.int_ctl, we can
use it instead of vcpu->arch.hflags to check whether L2 is running
in V_INTR_MASKING mode.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 1 -
 arch/x86/kvm/svm/nested.c       | 6 +-----
 arch/x86/kvm/svm/svm.c          | 2 +-
 arch/x86/kvm/svm/svm.h          | 4 +++-
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e6f2e1a2dab6..0dfc522f96cc 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1596,7 +1596,6 @@ enum {
 
 #define HF_GIF_MASK		(1 << 0)
 #define HF_HIF_MASK		(1 << 1)
-#define HF_VINTR_MASK		(1 << 2)
 #define HF_NMI_MASK		(1 << 3)
 #define HF_IRET_MASK		(1 << 4)
 #define HF_GUEST_MASK		(1 << 5) /* VCPU is in guest-mode */
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 9746ccbdfd2a..56d45fe6eb45 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -118,7 +118,7 @@ void recalc_intercepts(struct vcpu_svm *svm)
 	c->intercept_exceptions = h->intercept_exceptions;
 	c->intercept = h->intercept;
 
-	if (svm->vcpu.arch.hflags & HF_VINTR_MASK) {
+	if (g->int_ctl & V_INTR_MASKING_MASK) {
 		/* We only want the cr8 intercept bits of L1 */
 		c->intercept_cr &= ~(1U << INTERCEPT_CR8_READ);
 		c->intercept_cr &= ~(1U << INTERCEPT_CR8_WRITE);
@@ -338,10 +338,6 @@ static void nested_prepare_vmcb_control(struct vcpu_svm *svm)
 	kvm_mmu_reset_context(&svm->vcpu);
 
 	svm_flush_tlb(&svm->vcpu);
-	if (svm->nested.ctl.int_ctl & V_INTR_MASKING_MASK)
-		svm->vcpu.arch.hflags |= HF_VINTR_MASK;
-	else
-		svm->vcpu.arch.hflags &= ~HF_VINTR_MASK;
 
 	svm->vmcb->control.tsc_offset = svm->vcpu.arch.tsc_offset =
 		svm->vcpu.arch.l1_tsc_offset + svm->nested.ctl.tsc_offset;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index af5d4ae00cb4..d1a6e2f3db55 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3104,7 +3104,7 @@ bool svm_interrupt_blocked(struct kvm_vcpu *vcpu)
 
 	if (is_guest_mode(vcpu)) {
 		/* As long as interrupts are being delivered...  */
-		if ((svm->vcpu.arch.hflags & HF_VINTR_MASK)
+		if ((svm->nested.ctl.int_ctl & V_INTR_MASKING_MASK)
 		    ? !(svm->vcpu.arch.hflags & HF_HIF_MASK)
 		    : !(kvm_get_rflags(vcpu) & X86_EFLAGS_IF))
 			return true;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 10b7b55720a0..be8e830f83fa 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -367,7 +367,9 @@ void svm_set_gif(struct vcpu_svm *svm, bool value);
 
 static inline bool svm_nested_virtualize_tpr(struct kvm_vcpu *vcpu)
 {
-	return is_guest_mode(vcpu) && (vcpu->arch.hflags & HF_VINTR_MASK);
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	return is_guest_mode(vcpu) && (svm->nested.ctl.int_ctl & V_INTR_MASKING_MASK);
 }
 
 static inline bool nested_exit_on_smi(struct vcpu_svm *svm)
-- 
2.26.2


