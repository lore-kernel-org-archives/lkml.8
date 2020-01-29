Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCF1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 23:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67247206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 23:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgA2Xsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 18:48:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:46688 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbgA2Xqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 18:46:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 15:46:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,379,1574150400"; 
   d="scan'208";a="309551706"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga001.jf.intel.com with ESMTP; 29 Jan 2020 15:46:43 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/26] KVM: x86: Move MSR_TSC_AUX existence checks into vendor code
Date:   Wed, 29 Jan 2020 15:46:19 -0800
Message-Id: <20200129234640.8147-6-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129234640.8147-1-sean.j.christopherson@intel.com>
References: <20200129234640.8147-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the MSR_TSC_AUX existence check into vendor code using the newly
introduced ->has_virtualized_msr() hook to help pave the way toward the
removal of ->rdtscp_supported().

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/svm.c     | 7 +++++++
 arch/x86/kvm/vmx/vmx.c | 7 +++++++
 arch/x86/kvm/x86.c     | 4 ----
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 1f9323fbad81..4c8427f57b71 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5987,6 +5987,13 @@ static bool svm_cpu_has_accelerated_tpr(void)
 
 static bool svm_has_virtualized_msr(u32 index)
 {
+	switch (index) {
+	case MSR_TSC_AUX:
+		return boot_cpu_has(X86_FEATURE_RDTSCP);
+	default:
+		break;
+	}
+
 	return true;
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 3f2c094434e8..9588914e941e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6276,6 +6276,13 @@ static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu,
 
 static bool vmx_has_virtualized_msr(u32 index)
 {
+	switch (index) {
+	case MSR_TSC_AUX:
+		return cpu_has_vmx_rdtscp();
+	default:
+		break;
+	}
+
 	return true;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 94f90fe1c0de..a8619c52ea86 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5241,10 +5241,6 @@ static void kvm_init_msr_list(void)
 			if (!kvm_mpx_supported())
 				continue;
 			break;
-		case MSR_TSC_AUX:
-			if (!kvm_x86_ops->rdtscp_supported())
-				continue;
-			break;
 		case MSR_IA32_RTIT_CTL:
 		case MSR_IA32_RTIT_STATUS:
 			if (!kvm_x86_ops->pt_supported())
-- 
2.24.1

