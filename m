Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1394C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89DA620723
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMMjgtcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389545AbgEZRZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:25:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51294 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389179AbgEZRXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590513803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r6PjKzkk2yRHO0Y6YwX+jWBfjJzVTcuDe7WydGv1u40=;
        b=iMMjgtcb1XgsLv2cxt96wKrivyUDIc08MFZzVNSUyhhpFeo52QGFO3QyYy78qjnryKO0BS
        HRdwT7ixRnUd0gOrd7jtbh/Ugw+Hk1H/OvbLinKtTiOjzlBUdalbh9Oz6s2GbSuptOsUY9
        RXZu84qOl8Zp+qpIaR5TU5wtrGbgmCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-dHBjXw6tMmGnJOfkVVMvOg-1; Tue, 26 May 2020 13:23:20 -0400
X-MC-Unique: dHBjXw6tMmGnJOfkVVMvOg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B82B8108BD11;
        Tue, 26 May 2020 17:23:19 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF4915C1D6;
        Tue, 26 May 2020 17:23:16 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, mlevitsk@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH 11/28] KVM: nSVM: move MMU setup to nested_prepare_vmcb_control
Date:   Tue, 26 May 2020 13:22:51 -0400
Message-Id: <20200526172308.111575-12-pbonzini@redhat.com>
In-Reply-To: <20200526172308.111575-1-pbonzini@redhat.com>
References: <20200526172308.111575-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everything that is needed during nested state restore is now part of
nested_prepare_vmcb_control.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index af7c9ce8c5ad..7fbd7aaa4ce0 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -247,9 +247,6 @@ static void load_nested_vmcb_control(struct vcpu_svm *svm,
 
 static void nested_prepare_vmcb_save(struct vcpu_svm *svm, struct vmcb *nested_vmcb)
 {
-	if (nested_vmcb->control.nested_ctl & SVM_NESTED_CTL_NP_ENABLE)
-		nested_svm_init_mmu_context(&svm->vcpu);
-
 	/* Load the nested guest state */
 	svm->vmcb->save.es = nested_vmcb->save.es;
 	svm->vmcb->save.cs = nested_vmcb->save.cs;
@@ -263,9 +260,6 @@ static void nested_prepare_vmcb_save(struct vcpu_svm *svm, struct vmcb *nested_v
 	svm_set_cr4(&svm->vcpu, nested_vmcb->save.cr4);
 	(void)kvm_set_cr3(&svm->vcpu, nested_vmcb->save.cr3);
 
-	/* Guest paging mode is active - reset mmu */
-	kvm_mmu_reset_context(&svm->vcpu);
-
 	svm->vmcb->save.cr2 = svm->vcpu.arch.cr2 = nested_vmcb->save.cr2;
 	kvm_rax_write(&svm->vcpu, nested_vmcb->save.rax);
 	kvm_rsp_write(&svm->vcpu, nested_vmcb->save.rsp);
@@ -282,6 +276,12 @@ static void nested_prepare_vmcb_save(struct vcpu_svm *svm, struct vmcb *nested_v
 
 static void nested_prepare_vmcb_control(struct vcpu_svm *svm, struct vmcb *nested_vmcb)
 {
+	if (nested_vmcb->control.nested_ctl & SVM_NESTED_CTL_NP_ENABLE)
+		nested_svm_init_mmu_context(&svm->vcpu);
+
+	/* Guest paging mode is active - reset mmu */
+	kvm_mmu_reset_context(&svm->vcpu);
+
 	svm_flush_tlb(&svm->vcpu);
 	if (nested_vmcb->control.int_ctl & V_INTR_MASKING_MASK)
 		svm->vcpu.arch.hflags |= HF_VINTR_MASK;
-- 
2.26.2


