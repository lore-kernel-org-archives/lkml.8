Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D09C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0378A20658
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgCTVaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:30:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:20439 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727463AbgCTV27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 17:28:59 -0400
IronPort-SDR: cYgQYESna8R7YKcx92fzef3/0HgnD3Ok61uPdogyxb1CoxBvgaWGKYzS5soSKA8UFiHD6VSQN6
 1ReGy+RHND5Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 14:28:56 -0700
IronPort-SDR: BQuvdgm1FGjBAIk6IHCUyydsGAsPnr0KzjlI3XRWAjFzSumfIClbBPQPHEvCMsM4Li364afgW0
 B52BglrbGrLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,286,1580803200"; 
   d="scan'208";a="269224498"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga004.fm.intel.com with ESMTP; 20 Mar 2020 14:28:56 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v3 26/37] KVM: nVMX: Selectively use TLB_FLUSH_CURRENT for nested VM-Enter/VM-Exit
Date:   Fri, 20 Mar 2020 14:28:22 -0700
Message-Id: <20200320212833.3507-27-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200320212833.3507-1-sean.j.christopherson@intel.com>
References: <20200320212833.3507-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flush only the current context, as opposed to all contexts, when
requesting a TLB flush to handle the scenario where a L1 does not expect
a TLB flush, but one is required because L1 and L2 shared an ASID.  This
occurs if EPT is disabled (no per-EPTP tag), VPID is enabled (hardware
doesn't flush unconditionally) and vmcs02 does not have its own VPID due
to exhaustion of available VPIDs.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/nested.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b9fa2f89b564..e630d656b211 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1174,8 +1174,8 @@ static void nested_vmx_transition_tlb_flush(struct kvm_vcpu *vcpu,
 	 *
 	 * If VPID is enabled and used by vmc12, but L2 does not have a unique
 	 * TLB tag (ASID), i.e. EPT is disabled and KVM was unable to allocate
-	 * a VPID for L2, flush the TLB as the effective ASID is common to both
-	 * L1 and L2.
+	 * a VPID for L2, flush the current context as the effective ASID is
+	 * common to both L1 and L2.
 	 *
 	 * Defer the flush so that it runs after vmcs02.EPTP has been set by
 	 * KVM_REQ_LOAD_MMU_PGD (if nested EPT is enabled) and to avoid
@@ -1187,8 +1187,10 @@ static void nested_vmx_transition_tlb_flush(struct kvm_vcpu *vcpu,
 	 * mapping between vpid02 and vpid12, vpid02 is per-vCPU and reused for
 	 * all nested vCPUs.
 	 */
-	if (!nested_cpu_has_vpid(vmcs12) || !nested_has_guest_tlb_tag(vcpu)) {
+	if (!nested_cpu_has_vpid(vmcs12)) {
 		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
+	} else if (!nested_has_guest_tlb_tag(vcpu)) {
+		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 	} else if (is_vmenter &&
 		   vmcs12->virtual_processor_id != vmx->nested.last_vpid) {
 		vmx->nested.last_vpid = vmcs12->virtual_processor_id;
-- 
2.24.1

