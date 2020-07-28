Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FECC433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5487206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gO5pbAQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbgG1OiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 10:38:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50800 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730391AbgG1Oh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595947078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tcz6xJruSZd06J4JeQP6Z/txJOVAN8x8GJXEVJsFQok=;
        b=gO5pbAQO0vY/sWlkUjHUFUIFm/2EujtSVP0VLnZcEUYohv1s4Uc6vdHT9w1YRVc3hs4685
        bUdrhNd3gHeYYUPH35jy10F1ltHiyqoSvKOpf4FLNvdcdD4YGoKYr2+ro8rUMVkh4IYyAT
        UH6GU8tCeYIREXAumMlM010gNTOkO98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-zVbRciGGMe-6k7_0wCjbQw-1; Tue, 28 Jul 2020 10:37:57 -0400
X-MC-Unique: zVbRciGGMe-6k7_0wCjbQw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5F981005504;
        Tue, 28 Jul 2020 14:37:55 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B69E7BD60;
        Tue, 28 Jul 2020 14:37:52 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Xu <peterx@redhat.com>, Michael Tsirkin <mst@redhat.com>,
        Julia Suvorova <jsuvorov@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] KVM: x86: move kvm_vcpu_gfn_to_memslot() out of try_async_pf()
Date:   Tue, 28 Jul 2020 16:37:39 +0200
Message-Id: <20200728143741.2718593-2-vkuznets@redhat.com>
In-Reply-To: <20200728143741.2718593-1-vkuznets@redhat.com>
References: <20200728143741.2718593-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change intended. Slot flags will need to be analyzed
prior to try_async_pf() when KVM_MEM_PCI_HOLE is implemented.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c         | 14 ++++++++------
 arch/x86/kvm/mmu/paging_tmpl.h |  7 +++++--
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 77810ce66bdb..8597e8102636 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4041,11 +4041,10 @@ static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 				  kvm_vcpu_gfn_to_hva(vcpu, gfn), &arch);
 }
 
-static bool try_async_pf(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
-			 gpa_t cr2_or_gpa, kvm_pfn_t *pfn, bool write,
-			 bool *writable)
+static bool try_async_pf(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
+			 bool prefault, gfn_t gfn, gpa_t cr2_or_gpa,
+			 kvm_pfn_t *pfn, bool write, bool *writable)
 {
-	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 	bool async;
 
 	/* Don't expose private memslots to L2. */
@@ -4081,7 +4080,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	bool exec = error_code & PFERR_FETCH_MASK;
 	bool lpage_disallowed = exec && is_nx_huge_page_enabled();
 	bool map_writable;
-
+	struct kvm_memory_slot *slot;
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	unsigned long mmu_seq;
 	kvm_pfn_t pfn;
@@ -4103,7 +4102,10 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	mmu_seq = vcpu->kvm->mmu_notifier_seq;
 	smp_rmb();
 
-	if (try_async_pf(vcpu, prefault, gfn, gpa, &pfn, write, &map_writable))
+	slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
+
+	if (try_async_pf(vcpu, slot, prefault, gfn, gpa, &pfn, write,
+			 &map_writable))
 		return RET_PF_RETRY;
 
 	if (handle_abnormal_pfn(vcpu, is_tdp ? 0 : gpa, gfn, pfn, ACC_ALL, &r))
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 0172a949f6a7..5c6a895f67c3 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -779,6 +779,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
 	int write_fault = error_code & PFERR_WRITE_MASK;
 	int user_fault = error_code & PFERR_USER_MASK;
 	struct guest_walker walker;
+	struct kvm_memory_slot *slot;
 	int r;
 	kvm_pfn_t pfn;
 	unsigned long mmu_seq;
@@ -833,8 +834,10 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
 	mmu_seq = vcpu->kvm->mmu_notifier_seq;
 	smp_rmb();
 
-	if (try_async_pf(vcpu, prefault, walker.gfn, addr, &pfn, write_fault,
-			 &map_writable))
+	slot = kvm_vcpu_gfn_to_memslot(vcpu, walker.gfn);
+
+	if (try_async_pf(vcpu, slot, prefault, walker.gfn, addr, &pfn,
+			 write_fault, &map_writable))
 		return RET_PF_RETRY;
 
 	if (handle_abnormal_pfn(vcpu, addr, walker.gfn, pfn, walker.pte_access, &r))
-- 
2.25.4

