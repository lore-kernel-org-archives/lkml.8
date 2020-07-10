Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF93C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9307F207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zqc4TqDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgGJOMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:12:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20808 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727861AbgGJOMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594390328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kJ/JziJt1YuU460LMs6g6+REDy7/ZU1qE5RQxXXNeeA=;
        b=Zqc4TqDz43WIPpOFfi8RkIiB9Ve6lIHsLJTnZHYIJtNqz+naNAri2KTtDVqoLrhjv25KqU
        WN40yqenEXA4vrZl2qpa36p5s+2Fzvv4B7enjFryzzL1pNwvX/p/YjfzgQ4hDSAaFJL45s
        3XqET+o7dYc0anVfQj01qPw0XK/tTiM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-DkLM4h1kN6WaeiJ5MQ8dLw-1; Fri, 10 Jul 2020 10:12:05 -0400
X-MC-Unique: DkLM4h1kN6WaeiJ5MQ8dLw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09306102C7F3;
        Fri, 10 Jul 2020 14:12:04 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E80F974F44;
        Fri, 10 Jul 2020 14:12:01 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/9] KVM: nSVM: split kvm_init_shadow_npt_mmu() from kvm_init_shadow_mmu()
Date:   Fri, 10 Jul 2020 16:11:49 +0200
Message-Id: <20200710141157.1640173-2-vkuznets@redhat.com>
In-Reply-To: <20200710141157.1640173-1-vkuznets@redhat.com>
References: <20200710141157.1640173-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preparatory change for moving kvm_mmu_new_pgd() from
nested_prepare_vmcb_save() to nested_svm_init_mmu_context() split
kvm_init_shadow_npt_mmu() from kvm_init_shadow_mmu(). This also makes
the code look more like nVMX (kvm_init_shadow_ept_mmu()).

No functional change intended.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/mmu.h        |  3 ++-
 arch/x86/kvm/mmu/mmu.c    | 31 ++++++++++++++++++++++++-------
 arch/x86/kvm/svm/nested.c |  3 ++-
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 444bb9c54548..94378ef1df54 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -57,7 +57,8 @@ void
 reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu, struct kvm_mmu *context);
 
 void kvm_init_mmu(struct kvm_vcpu *vcpu, bool reset_roots);
-void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu, u32 cr0, u32 cr4, u32 efer);
+void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, u32 cr0, u32 cr4, u32 efer,
+			     gpa_t nested_cr3);
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     bool accessed_dirty, gpa_t new_eptp);
 bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 2da46b4e11b5..93f18e5fa8b5 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4952,14 +4952,10 @@ kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu, bool base_only)
 	return role;
 }
 
-void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu, u32 cr0, u32 cr4, u32 efer)
+static void shadow_mmu_init_context(struct kvm_vcpu *vcpu, u32 cr0, u32 cr4,
+				    u32 efer, union kvm_mmu_role new_role)
 {
 	struct kvm_mmu *context = vcpu->arch.mmu;
-	union kvm_mmu_role new_role =
-		kvm_calc_shadow_mmu_root_page_role(vcpu, false);
-
-	if (new_role.as_u64 == context->mmu_role.as_u64)
-		return;
 
 	if (!(cr0 & X86_CR0_PG))
 		nonpaging_init_context(vcpu, context);
@@ -4973,7 +4969,28 @@ void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu, u32 cr0, u32 cr4, u32 efer)
 	context->mmu_role.as_u64 = new_role.as_u64;
 	reset_shadow_zero_bits_mask(vcpu, context);
 }
-EXPORT_SYMBOL_GPL(kvm_init_shadow_mmu);
+
+static void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu, u32 cr0, u32 cr4, u32 efer)
+{
+	struct kvm_mmu *context = vcpu->arch.mmu;
+	union kvm_mmu_role new_role =
+		kvm_calc_shadow_mmu_root_page_role(vcpu, false);
+
+	if (new_role.as_u64 != context->mmu_role.as_u64)
+		shadow_mmu_init_context(vcpu, cr0, cr4, efer, new_role);
+}
+
+void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, u32 cr0, u32 cr4, u32 efer,
+			     gpa_t nested_cr3)
+{
+	struct kvm_mmu *context = vcpu->arch.mmu;
+	union kvm_mmu_role new_role =
+		kvm_calc_shadow_mmu_root_page_role(vcpu, false);
+
+	if (new_role.as_u64 != context->mmu_role.as_u64)
+		shadow_mmu_init_context(vcpu, cr0, cr4, efer, new_role);
+}
+EXPORT_SYMBOL_GPL(kvm_init_shadow_npt_mmu);
 
 static union kvm_mmu_role
 kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 6bceafb19108..e424bce13e6c 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -87,7 +87,8 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 	WARN_ON(mmu_is_nested(vcpu));
 
 	vcpu->arch.mmu = &vcpu->arch.guest_mmu;
-	kvm_init_shadow_mmu(vcpu, X86_CR0_PG, hsave->save.cr4, hsave->save.efer);
+	kvm_init_shadow_npt_mmu(vcpu, X86_CR0_PG, hsave->save.cr4, hsave->save.efer,
+				svm->nested.ctl.nested_cr3);
 	vcpu->arch.mmu->get_guest_pgd     = nested_svm_get_tdp_cr3;
 	vcpu->arch.mmu->get_pdptr         = nested_svm_get_tdp_pdptr;
 	vcpu->arch.mmu->inject_page_fault = nested_svm_inject_npf_exit;
-- 
2.25.4

