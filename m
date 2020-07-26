Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8B0C433EA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 15:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F1C2073E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 15:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgGZPez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 11:34:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:17603 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbgGZPev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 11:34:51 -0400
IronPort-SDR: I4cUuhujIbUKnMZWeB0M3pfW4njTkT1TxWuy/8YVQjhshloH059qu9KlyxnLFYoEsqFFgDTRKc
 /yzOVUWPEUYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="150890969"
X-IronPort-AV: E=Sophos;i="5.75,399,1589266800"; 
   d="scan'208";a="150890969"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 08:34:51 -0700
IronPort-SDR: a9sLuA9zaKwf3PEAf9BVRYBYNSJCeYGKwJk3i5ecxeQv0ZRWZXOWSsPGhGurHksYyy4AU/53Tx
 7vXkDXbl0JGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,399,1589266800"; 
   d="scan'208";a="303177550"
Received: from sqa-gate.sh.intel.com (HELO clx-ap-likexu.tsp.org) ([10.239.48.212])
  by orsmga002.jf.intel.com with ESMTP; 26 Jul 2020 08:34:49 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Like Xu <like.xu@linux.intel.com>
Subject: [PATCH v13 03/10] KVM: vmx/pmu: Initialize vcpu perf_capabilities once in intel_pmu_init()
Date:   Sun, 26 Jul 2020 23:32:22 +0800
Message-Id: <20200726153229.27149-5-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200726153229.27149-1-like.xu@linux.intel.com>
References: <20200726153229.27149-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The guest hypervisor may configure MSR_IA32_PERF_CAPABILITIES to unmask
some vmx-supported bits in vcpu->arch.perf_capabilities, and the requested
value could affect the exposure of features in the intel_pmu_refresh().

Refactoring its initialization path clears the way for the above usage.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 6 +++---
 arch/x86/kvm/x86.c           | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index a886a47daebd..f8083ecf8c7b 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -327,7 +327,6 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
 	pmu->version = 0;
 	pmu->reserved_bits = 0xffffffff00200000ull;
-	vcpu->arch.perf_capabilities = 0;
 
 	entry = kvm_find_cpuid_entry(vcpu, 0xa, 0);
 	if (!entry)
@@ -340,8 +339,6 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 		return;
 
 	perf_get_x86_pmu_capability(&x86_pmu);
-	if (guest_cpuid_has(vcpu, X86_FEATURE_PDCM))
-		vcpu->arch.perf_capabilities = vmx_get_perf_capabilities();
 
 	pmu->nr_arch_gp_counters = min_t(int, eax.split.num_counters,
 					 x86_pmu.num_counters_gp);
@@ -401,6 +398,9 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
 		pmu->fixed_counters[i].idx = i + INTEL_PMC_IDX_FIXED;
 		pmu->fixed_counters[i].current_config = 0;
 	}
+
+	vcpu->arch.perf_capabilities = guest_cpuid_has(vcpu, X86_FEATURE_PDCM) ?
+		vmx_get_perf_capabilities() : 0;
 }
 
 static void intel_pmu_reset(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c79953b49c77..8a58d0355a99 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2871,7 +2871,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 
 		vcpu->arch.perf_capabilities = data;
-
+		kvm_pmu_refresh(vcpu);
 		return 0;
 		}
 	case MSR_EFER:
-- 
2.21.3

