Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88879C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D95206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9Y/1Yow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394004AbgFSPlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:41:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20681 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393866AbgFSPkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592581203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tVRPCFY21ubrTOvxf4j2vFglhRKZ9hHO+8Y6VHRuBL4=;
        b=i9Y/1YowGwFGPhqJwUVZmXxCJnYY9r7E+oEbxPV6NFxBXQmUDbzVuFj5ZphxBDMW7H1Nzo
        TrPwdhIrXRdgkCy/1fqdxj9ON+jomCL++xsJQtWbJbIOcomtpyIQdq2IX+oIgzakm15DKC
        xmHuVFhyZtmi1dmox1MTgvGVHz2+SIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-5GQGJmfBPC6tPmnOMHOUhw-1; Fri, 19 Jun 2020 11:39:58 -0400
X-MC-Unique: 5GQGJmfBPC6tPmnOMHOUhw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C84A1800EBB;
        Fri, 19 Jun 2020 15:39:56 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-254.ams2.redhat.com [10.36.112.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F12060BF4;
        Fri, 19 Jun 2020 15:39:54 +0000 (UTC)
From:   Mohammed Gamal <mgamal@redhat.com>
To:     kvm@vger.kernel.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, thomas.lendacky@amd.com,
        babu.moger@amd.com
Subject: [PATCH v2 06/11] KVM: VMX: introduce vmx_need_pf_intercept
Date:   Fri, 19 Jun 2020 17:39:20 +0200
Message-Id: <20200619153925.79106-7-mgamal@redhat.com>
In-Reply-To: <20200619153925.79106-1-mgamal@redhat.com>
References: <20200619153925.79106-1-mgamal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 28 +++++++++++++++++-----------
 arch/x86/kvm/vmx/vmx.c    |  2 +-
 arch/x86/kvm/vmx/vmx.h    |  5 +++++
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index d1af20b050a8..328411919518 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2433,22 +2433,28 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 
 	/*
 	 * Whether page-faults are trapped is determined by a combination of
-	 * 3 settings: PFEC_MASK, PFEC_MATCH and EXCEPTION_BITMAP.PF.
-	 * If enable_ept, L0 doesn't care about page faults and we should
-	 * set all of these to L1's desires. However, if !enable_ept, L0 does
-	 * care about (at least some) page faults, and because it is not easy
-	 * (if at all possible?) to merge L0 and L1's desires, we simply ask
-	 * to exit on each and every L2 page fault. This is done by setting
-	 * MASK=MATCH=0 and (see below) EB.PF=1.
+	 * 3 settings: PFEC_MASK, PFEC_MATCH and EXCEPTION_BITMAP.PF.  If L0
+	 * doesn't care about page faults then we should set all of these to
+	 * L1's desires. However, if L0 does care about (some) page faults, it
+	 * is not easy (if at all possible?) to merge L0 and L1's desires, we
+	 * simply ask to exit on each and every L2 page fault. This is done by
+	 * setting MASK=MATCH=0 and (see below) EB.PF=1.
 	 * Note that below we don't need special code to set EB.PF beyond the
 	 * "or"ing of the EB of vmcs01 and vmcs12, because when enable_ept,
 	 * vmcs01's EB.PF is 0 so the "or" will take vmcs12's value, and when
 	 * !enable_ept, EB.PF is 1, so the "or" will always be 1.
 	 */
-	vmcs_write32(PAGE_FAULT_ERROR_CODE_MASK,
-		enable_ept ? vmcs12->page_fault_error_code_mask : 0);
-	vmcs_write32(PAGE_FAULT_ERROR_CODE_MATCH,
-		enable_ept ? vmcs12->page_fault_error_code_match : 0);
+	if (vmx_need_pf_intercept(&vmx->vcpu)) {
+		/*
+		 * TODO: if both L0 and L1 need the same MASK and MATCH,
+		 * go ahead and use it?
+		 */
+		vmcs_write32(PAGE_FAULT_ERROR_CODE_MASK, 0);
+		vmcs_write32(PAGE_FAULT_ERROR_CODE_MATCH, 0);
+	} else {
+		vmcs_write32(PAGE_FAULT_ERROR_CODE_MASK, vmcs12->page_fault_error_code_mask);
+		vmcs_write32(PAGE_FAULT_ERROR_CODE_MATCH, vmcs12->page_fault_error_code_match);
+	}
 
 	if (cpu_has_vmx_apicv()) {
 		vmcs_write64(EOI_EXIT_BITMAP0, vmcs12->eoi_exit_bitmap0);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f82c42ac87f9..46d522ee5cb1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -783,7 +783,7 @@ void update_exception_bitmap(struct kvm_vcpu *vcpu)
 		eb |= 1u << BP_VECTOR;
 	if (to_vmx(vcpu)->rmode.vm86_active)
 		eb = ~0;
-	if (enable_ept)
+	if (!vmx_need_pf_intercept(vcpu))
 		eb &= ~(1u << PF_VECTOR);
 
 	/* When we are running a nested L2 guest and L1 specified for it a
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 8a83b5edc820..5e2da15fe94f 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -552,6 +552,11 @@ static inline bool vmx_has_waitpkg(struct vcpu_vmx *vmx)
 		SECONDARY_EXEC_ENABLE_USR_WAIT_PAUSE;
 }
 
+static inline bool vmx_need_pf_intercept(struct kvm_vcpu *vcpu)
+{
+	return !enable_ept;
+}
+
 void dump_vmcs(void);
 
 #endif /* __KVM_X86_VMX_H */
-- 
2.26.2

