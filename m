Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BAEC43446
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F42A2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgGPDmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 23:42:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:4816 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgGPDl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 23:41:26 -0400
IronPort-SDR: HYc92FVHkzdoU3kZkvURreaT/1L/oNnK78BOs+9CabgthWF7fYqS+Jl9Z7EXENygevI1Rea7Kz
 CDXxhPeizmSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="137442916"
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="137442916"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 20:41:25 -0700
IronPort-SDR: Hhg21qXorTqd7pdCJjQNZprUA6QK5YopRJWCrDf/myOsck9/q0ocyse/gMhkLgaQHewOfk63z7
 whqcIhKCuYxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="316905487"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by orsmga008.jf.intel.com with ESMTP; 15 Jul 2020 20:41:24 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] KVM: VXM: Remove temporary WARN on expected vs. actual EPTP level mismatch
Date:   Wed, 15 Jul 2020 20:41:19 -0700
Message-Id: <20200716034122.5998-7-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200716034122.5998-1-sean.j.christopherson@intel.com>
References: <20200716034122.5998-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the WARN in vmx_load_mmu_pgd() that was temporarily added to aid
bisection/debug in the event the current MMU's shadow root level didn't
match VMX's computed EPTP level.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 244053cff0a3a..da75878171cea 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3072,14 +3072,6 @@ static int vmx_get_tdp_level(struct kvm_vcpu *vcpu)
 	return 4;
 }
 
-static int get_ept_level(struct kvm_vcpu *vcpu)
-{
-	if (is_guest_mode(vcpu) && nested_cpu_has_ept(get_vmcs12(vcpu)))
-		return vmx_eptp_page_walk_level(nested_ept_get_eptp(vcpu));
-
-	return vmx_get_tdp_level(vcpu);
-}
-
 u64 construct_eptp(struct kvm_vcpu *vcpu, unsigned long root_hpa,
 		   int root_level)
 {
@@ -3104,8 +3096,6 @@ static void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, unsigned long pgd,
 	u64 eptp;
 
 	if (enable_ept) {
-		WARN_ON(pgd_level != get_ept_level(vcpu));
-
 		eptp = construct_eptp(vcpu, pgd, pgd_level);
 		vmcs_write64(EPT_POINTER, eptp);
 
-- 
2.26.0

