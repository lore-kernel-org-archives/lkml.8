Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD24C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E1D2074B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgGRGjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:39:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:30319 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbgGRGjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:39:03 -0400
IronPort-SDR: vAUUUhivkyIFIZCdcpKX8RSmIRaFuHekJk/pcQBDh22zZxOKFEaKnQjF0+wWlg6cKzIoFmBqfP
 CH56wSB5rY9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="151079559"
X-IronPort-AV: E=Sophos;i="5.75,366,1589266800"; 
   d="scan'208";a="151079559"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 23:39:01 -0700
IronPort-SDR: HteSuF+3oaeppCghGDr2/OkcqL2D1fVRROdg5nzdrNT99ETRfwbDMhIiR+VxLK/apJNdVGm0v1
 JV77Sc1d/J3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,366,1589266800"; 
   d="scan'208";a="486690976"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jul 2020 23:39:01 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] KVM: nVMX: Read EXIT_QUAL and INTR_INFO only when needed for nested exit
Date:   Fri, 17 Jul 2020 23:38:54 -0700
Message-Id: <20200718063854.16017-8-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200718063854.16017-1-sean.j.christopherson@intel.com>
References: <20200718063854.16017-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read vmcs.EXIT_QUALIFICATION and vmcs.VM_EXIT_INTR_INFO only when the
VM-Exit is being reflected to L1 now that they are no longer passed
directly to the kvm_nested_vmexit tracepoint.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/nested.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index f437d99f4db09..cc5f0085989c7 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5909,9 +5909,6 @@ bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu)
 		goto reflect_vmexit;
 	}
 
-	exit_intr_info = vmx_get_intr_info(vcpu);
-	exit_qual = vmx_get_exit_qual(vcpu);
-
 	trace_kvm_nested_vmexit(exit_reason, vcpu, KVM_ISA_VMX);
 
 	/* If L0 (KVM) wants the exit, it trumps L1's desires. */
@@ -5928,12 +5925,14 @@ bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu)
 	 * need to be synthesized by querying the in-kernel LAPIC, but external
 	 * interrupts are never reflected to L1 so it's a non-issue.
 	 */
+	exit_intr_info = vmx_get_intr_info(vcpu);
 	if (is_exception_with_error_code(exit_intr_info)) {
 		struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 
 		vmcs12->vm_exit_intr_error_code =
 			vmcs_read32(VM_EXIT_INTR_ERROR_CODE);
 	}
+	exit_qual = vmx_get_exit_qual(vcpu);
 
 reflect_vmexit:
 	nested_vmx_vmexit(vcpu, exit_reason, exit_intr_info, exit_qual);
-- 
2.26.0

