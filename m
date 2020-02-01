Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5560C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA3A20679
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgBASyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:54:03 -0500
Received: from mga02.intel.com ([134.134.136.20]:11286 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbgBASwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:52:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2020 10:52:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,390,1574150400"; 
   d="scan'208";a="248075592"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2020 10:52:26 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 54/61] KVM: x86: Check for Intel PT MSR virtualization using KVM cpu caps
Date:   Sat,  1 Feb 2020 10:52:11 -0800
Message-Id: <20200201185218.24473-55-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200201185218.24473-1-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_cpu_cap_has() to check for Intel PT when processing the list of
virtualized MSRs to pave the way toward removing ->pt_supported().

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/x86.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e4353c03269c..9d38dcdbb613 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5251,23 +5251,23 @@ static void kvm_init_msr_list(void)
 			break;
 		case MSR_IA32_RTIT_CTL:
 		case MSR_IA32_RTIT_STATUS:
-			if (!kvm_x86_ops->pt_supported())
+			if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT))
 				continue;
 			break;
 		case MSR_IA32_RTIT_CR3_MATCH:
-			if (!kvm_x86_ops->pt_supported() ||
+			if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT) ||
 			    !intel_pt_validate_hw_cap(PT_CAP_cr3_filtering))
 				continue;
 			break;
 		case MSR_IA32_RTIT_OUTPUT_BASE:
 		case MSR_IA32_RTIT_OUTPUT_MASK:
-			if (!kvm_x86_ops->pt_supported() ||
+			if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT) ||
 				(!intel_pt_validate_hw_cap(PT_CAP_topa_output) &&
 				 !intel_pt_validate_hw_cap(PT_CAP_single_range_output)))
 				continue;
 			break;
 		case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B: {
-			if (!kvm_x86_ops->pt_supported() ||
+			if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT) ||
 				msrs_to_save_all[i] - MSR_IA32_RTIT_ADDR0_A >=
 				intel_pt_validate_hw_cap(PT_CAP_num_address_ranges) * 2)
 				continue;
-- 
2.24.1

