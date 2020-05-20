Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46E4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7894D207D4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5qwtdQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgETRWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:22:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45909 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728020AbgETRWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589995328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=O5C/wpSFG+A10gW4g2b6rirce6pktuJyF39GSqi1oN0=;
        b=R5qwtdQ/FjOHHw3Gturrk4+6+oTqps5ssRpnQfEHNBNjbWU9RzPsUDyh7PUXf722tr6Rhz
        OjirQoqH9C20w0cDZcIOonjBYFTK6iTJCvDbjcEMfdo9FDI6/Wo2qnWrCXQuQ7jtQgJkQE
        zXnOKWsyTNaipqlmBbcM5zcddqjPa1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-s9k8H_HhOjmzYZiuQVsb3g-1; Wed, 20 May 2020 13:22:06 -0400
X-MC-Unique: s9k8H_HhOjmzYZiuQVsb3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E58E5835BB8;
        Wed, 20 May 2020 17:22:04 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBF3670461;
        Wed, 20 May 2020 17:22:03 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 15/24] KVM: nSVM: remove HF_HIF_MASK
Date:   Wed, 20 May 2020 13:21:36 -0400
Message-Id: <20200520172145.23284-16-pbonzini@redhat.com>
In-Reply-To: <20200520172145.23284-1-pbonzini@redhat.com>
References: <20200520172145.23284-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The L1 flags can be found in the save area of svm->nested.hsave, fish
it from there so that there is one fewer thing to migrate.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 1 -
 arch/x86/kvm/svm/nested.c       | 5 -----
 arch/x86/kvm/svm/svm.c          | 2 +-
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f1c4cb2d0541..019dafaddc1f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1593,7 +1593,6 @@ enum {
 };
 
 #define HF_GIF_MASK		(1 << 0)
-#define HF_HIF_MASK		(1 << 1)
 #define HF_NMI_MASK		(1 << 3)
 #define HF_IRET_MASK		(1 << 4)
 #define HF_GUEST_MASK		(1 << 5) /* VCPU is in guest-mode */
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 9e4d24acadd7..cbe96a08b080 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -310,11 +310,6 @@ void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 		is_intercept(svm, INTERCEPT_IRET);
 
 	svm->nested.vmcb = vmcb_gpa;
-	if (kvm_get_rflags(&svm->vcpu) & X86_EFLAGS_IF)
-		svm->vcpu.arch.hflags |= HF_HIF_MASK;
-	else
-		svm->vcpu.arch.hflags &= ~HF_HIF_MASK;
-
 	load_nested_vmcb_control(svm, &nested_vmcb->control);
 	nested_prepare_vmcb_save(svm, nested_vmcb);
 	nested_prepare_vmcb_control(svm);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 10c80c13b679..6a19cb3e3b1f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3081,7 +3081,7 @@ bool svm_interrupt_blocked(struct kvm_vcpu *vcpu)
 	if (is_guest_mode(vcpu)) {
 		/* As long as interrupts are being delivered...  */
 		if ((svm->nested.ctl.int_ctl & V_INTR_MASKING_MASK)
-		    ? !(svm->vcpu.arch.hflags & HF_HIF_MASK)
+		    ? !(svm->nested.hsave->save.rflags & X86_EFLAGS_IF)
 		    : !(kvm_get_rflags(vcpu) & X86_EFLAGS_IF))
 			return true;
 
-- 
2.18.2


