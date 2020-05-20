Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27189C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC751207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKsbjtWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgETRWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:22:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37480 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728209AbgETRW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589995344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=lqgKVLP3SP8cg1s97CF9uJwnyFVUFcqxn/d9nKhT/9k=;
        b=MKsbjtWRJF7gzrBpP5vVqSZO+8mUpajMraf9OisgOyP+XWh+8TyaGc5MctV4c/cXmW+4RO
        j6ufK4C5/uDnaC/sPT2eJ49D8JVOnhAldspWK1QSevyX2IHDMtVqkzbEwwebAbQXbiE+ti
        awGEzQDLYskSMdj0wZrBqDmJSF+Ec0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-jmPfhBa8NMKifqEFbtDKSw-1; Wed, 20 May 2020 13:22:20 -0400
X-MC-Unique: jmPfhBa8NMKifqEFbtDKSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88E5B87131F;
        Wed, 20 May 2020 17:22:11 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA0CC79C35;
        Wed, 20 May 2020 17:22:10 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 20/24] KVM: MMU: pass arbitrary CR0/CR4/EFER to kvm_init_shadow_mmu
Date:   Wed, 20 May 2020 13:21:41 -0400
Message-Id: <20200520172145.23284-21-pbonzini@redhat.com>
In-Reply-To: <20200520172145.23284-1-pbonzini@redhat.com>
References: <20200520172145.23284-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows fetching the registers from the hsave area when setting
up the NPT shadow MMU, and is needed for KVM_SET_NESTED_STATE (which
runs long after the CR0, CR4 and EFER values in vcpu have been switched
to hold L2 guest state).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu.h        |  2 +-
 arch/x86/kvm/mmu/mmu.c    | 14 +++++++++-----
 arch/x86/kvm/svm/nested.c |  5 ++++-
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 8a3b1bce722a..45c1ae872a34 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -57,7 +57,7 @@ void
 reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu, struct kvm_mmu *context);
 
 void kvm_init_mmu(struct kvm_vcpu *vcpu, bool reset_roots);
-void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu);
+void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu, u32 cr0, u32 cr4, u32 efer);
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     bool accessed_dirty, gpa_t new_eptp);
 bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d93cb3ad8f03..50ae99ee32df 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4954,7 +4954,7 @@ kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu, bool base_only)
 	return role;
 }
 
-void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu)
+void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu, u32 cr0, u32 cr4, u32 efer)
 {
 	struct kvm_mmu *context = vcpu->arch.mmu;
 	union kvm_mmu_role new_role =
@@ -4963,11 +4963,11 @@ void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu)
 	if (new_role.as_u64 == context->mmu_role.as_u64)
 		return;
 
-	if (!is_paging(vcpu))
+	if (!(cr0 & X86_CR0_PG))
 		nonpaging_init_context(vcpu, context);
-	else if (is_long_mode(vcpu))
+	else if (efer & EFER_LMA)
 		paging64_init_context(vcpu, context);
-	else if (is_pae(vcpu))
+	else if (cr4 & X86_CR4_PAE)
 		paging32E_init_context(vcpu, context);
 	else
 		paging32_init_context(vcpu, context);
@@ -5045,7 +5045,11 @@ static void init_kvm_softmmu(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mmu *context = vcpu->arch.mmu;
 
-	kvm_init_shadow_mmu(vcpu);
+	kvm_init_shadow_mmu(vcpu,
+			    kvm_read_cr0_bits(vcpu, X86_CR0_PG),
+			    kvm_read_cr4_bits(vcpu, X86_CR4_PAE),
+			    vcpu->arch.efer);
+
 	context->get_guest_pgd     = get_cr3;
 	context->get_pdptr         = kvm_pdptr_read;
 	context->inject_page_fault = kvm_inject_page_fault;
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index a4a9516ff8b5..19b6a7c954e8 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -80,10 +80,13 @@ static unsigned long nested_svm_get_tdp_cr3(struct kvm_vcpu *vcpu)
 
 static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct vmcb *hsave = svm->nested.hsave;
+
 	WARN_ON(mmu_is_nested(vcpu));
 
 	vcpu->arch.mmu = &vcpu->arch.guest_mmu;
-	kvm_init_shadow_mmu(vcpu);
+	kvm_init_shadow_mmu(vcpu, X86_CR0_PG, hsave->save.cr4, hsave->save.efer);
 	vcpu->arch.mmu->get_guest_pgd     = nested_svm_get_tdp_cr3;
 	vcpu->arch.mmu->get_pdptr         = nested_svm_get_tdp_pdptr;
 	vcpu->arch.mmu->inject_page_fault = nested_svm_inject_npf_exit;
-- 
2.18.2


