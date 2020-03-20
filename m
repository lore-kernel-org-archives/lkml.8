Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC20FC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF4720658
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgCTVao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:30:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:20436 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727317AbgCTV2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 17:28:54 -0400
IronPort-SDR: mlv0KY3UB9YxvVCIC9z2/Fs2oFLDL/5JiSYRMzeWqAM+ay8jd/E/nrFglTH14XsaJkGWzgR6l3
 lPKKr86lCKQg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 14:28:53 -0700
IronPort-SDR: 7/TjMl4UEej1Qz++390btM17irVTFZ9KGXa0n9JyNeuPuonfDfkhE1kDoqq0G7CndDeR4mB+1w
 vzfHaymHVrFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,286,1580803200"; 
   d="scan'208";a="269224471"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga004.fm.intel.com with ESMTP; 20 Mar 2020 14:28:52 -0700
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
Subject: [PATCH v3 19/37] KVM: nVMX: Move nested_get_vpid02() to vmx/nested.h
Date:   Fri, 20 Mar 2020 14:28:15 -0700
Message-Id: <20200320212833.3507-20-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200320212833.3507-1-sean.j.christopherson@intel.com>
References: <20200320212833.3507-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move nested_get_vpid02() to vmx/nested.h so that a future patch can
reference it from vmx.c to implement context-specific TLB flushing.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/nested.c | 7 -------
 arch/x86/kvm/vmx/nested.h | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 0c71db6fec5a..77819d890088 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1154,13 +1154,6 @@ static bool nested_has_guest_tlb_tag(struct kvm_vcpu *vcpu)
 	       (nested_cpu_has_vpid(vmcs12) && to_vmx(vcpu)->nested.vpid02);
 }
 
-static u16 nested_get_vpid02(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-
-	return vmx->nested.vpid02 ? vmx->nested.vpid02 : vmx->vpid;
-}
-
 static bool is_bitwise_subset(u64 superset, u64 subset, u64 mask)
 {
 	superset &= mask;
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index 21d36652f213..debc5eeb5757 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -60,6 +60,13 @@ static inline int vmx_has_valid_vmcs12(struct kvm_vcpu *vcpu)
 		vmx->nested.hv_evmcs;
 }
 
+static inline u16 nested_get_vpid02(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+
+	return vmx->nested.vpid02 ? vmx->nested.vpid02 : vmx->vpid;
+}
+
 static inline unsigned long nested_ept_get_eptp(struct kvm_vcpu *vcpu)
 {
 	/* return the page table to be shadowed - in our case, EPT12 */
-- 
2.24.1

