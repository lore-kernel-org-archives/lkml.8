Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A522C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 306AE20776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgE2I4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:56:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:5099 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgE2I4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:56:01 -0400
IronPort-SDR: kA6+ORW2VlqJ5wvk/whkhT/tBMWnRuIlHU2htTBgsxPi8g/gF+IEx7eOW3YWtSV0zN7w4p4fcq
 V2QLdVdGszcw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 01:55:59 -0700
IronPort-SDR: /04mFCxKP1dbnyDmCO+YsOYJu9JkvBMIRQFu0YVhl5jMESSoT+KaX6NdzdImXTFko/nf57KJR5
 y+LbB6Q71geQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,448,1583222400"; 
   d="scan'208";a="311188349"
Received: from lxy-dell.sh.intel.com ([10.239.159.21])
  by FMSMGA003.fm.intel.com with ESMTP; 29 May 2020 01:55:57 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 5/6] KVM: X86: Move kvm_x86_ops.cpuid_update() into kvm_update_state_based_on_cpuid()
Date:   Fri, 29 May 2020 16:55:44 +0800
Message-Id: <20200529085545.29242-6-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200529085545.29242-1-xiaoyao.li@intel.com>
References: <20200529085545.29242-1-xiaoyao.li@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_x86_ops.cpuid_update() is used to update vmx/svm settings based on
updated CPUID settings. So it's supposed to be called after CPUIDs are
fully updated, i.e., kvm_update_cpuid(), not in the middle stage.

Put it in kvm_update_state_based_on_cpuid() to make it clear that it's
to update vmx/svm specific states based on CPUID.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Should we rename kvm_x86_ops.cpuid_update to something like
kvm_x86_ops.update_state_based_on_cpuid?

cpuid_update is really confusing especially when kvm_x86_ops.update_cpuid()
is needed someday.
---
 arch/x86/kvm/cpuid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index a4a2072f5253..5d4da8970940 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -136,6 +136,8 @@ void kvm_update_state_based_on_cpuid(struct kvm_vcpu *vcpu)
 		vcpu->arch.guest_supported_xcr0 =
 			(best->eax | ((u64)best->edx << 32)) & supported_xcr0;
 
+	kvm_x86_ops.cpuid_update(vcpu);
+
 	/* Note, maxphyaddr must be updated before tdp_level. */
 	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
 	vcpu->arch.tdp_level = kvm_x86_ops.get_tdp_level(vcpu);
@@ -227,7 +229,6 @@ int kvm_vcpu_ioctl_set_cpuid(struct kvm_vcpu *vcpu,
 
 	cpuid_fix_nx_cap(vcpu);
 	kvm_apic_set_version(vcpu);
-	kvm_x86_ops.cpuid_update(vcpu);
 	kvm_update_cpuid(vcpu);
 	kvm_update_state_based_on_cpuid(vcpu);
 
@@ -257,7 +258,6 @@ int kvm_vcpu_ioctl_set_cpuid2(struct kvm_vcpu *vcpu,
 	}
 
 	kvm_apic_set_version(vcpu);
-	kvm_x86_ops.cpuid_update(vcpu);
 	kvm_update_cpuid(vcpu);
 	kvm_update_state_based_on_cpuid(vcpu);
 out:
-- 
2.18.2

