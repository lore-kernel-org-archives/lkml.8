Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F30C47247
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CDE120787
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgEBEcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 00:32:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:55787 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727863AbgEBEck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 00:32:40 -0400
IronPort-SDR: 2o44l6aK9zr4CnuuiPN3+k+1pDpStJgPVSsh6M7subhMOswIY8sTfgYZUgEzWXI3CKts8X7Ryq
 0ndntOEUHsSw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 21:32:37 -0700
IronPort-SDR: GF0Rn/dAGktGCLIcqPKJ9Dth0ByeL3Jhi775UOTioMUXDOY6AGQdt733UVwrJXzw5bqYXuK2ou
 mhVY0EuOISsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,342,1583222400"; 
   d="scan'208";a="433516141"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by orsmga005.jf.intel.com with ESMTP; 01 May 2020 21:32:37 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] KVM: VMX: Move nested EPT out of kvm_x86_ops.get_tdp_level() hook
Date:   Fri,  1 May 2020 21:32:33 -0700
Message-Id: <20200502043234.12481-10-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200502043234.12481-1-sean.j.christopherson@intel.com>
References: <20200502043234.12481-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the "core" TDP level handling from the nested EPT path to make
it clear that kvm_x86_ops.get_tdp_level() is used if and only if nested
EPT is not in use (kvm_init_shadow_ept_mmu() calculates the level from
the passed in vmcs12->eptp).  Add a WARN_ON() to enforce that the
kvm_x86_ops hook is not called for nested EPT.

This sets the stage for snapshotting the non-"nested EPT" TDP page level
during kvm_cpuid_update() to avoid the retpoline associated with
kvm_x86_ops.get_tdp_level() when resetting the MMU, a relatively
frequent operation when running a nested guest.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d826ac541eed..c9c6e72e9660 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3006,15 +3006,23 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	vmx->emulation_required = emulation_required(vcpu);
 }
 
-static int get_ept_level(struct kvm_vcpu *vcpu)
+static int vmx_get_tdp_level(struct kvm_vcpu *vcpu)
 {
-	if (is_guest_mode(vcpu) && nested_cpu_has_ept(get_vmcs12(vcpu)))
-		return vmx_eptp_page_walk_level(nested_ept_get_eptp(vcpu));
+	WARN_ON(is_guest_mode(vcpu) && nested_cpu_has_ept(get_vmcs12(vcpu)));
+
 	if (cpu_has_vmx_ept_5levels() && (cpuid_maxphyaddr(vcpu) > 48))
 		return 5;
 	return 4;
 }
 
+static int get_ept_level(struct kvm_vcpu *vcpu)
+{
+	if (is_guest_mode(vcpu) && nested_cpu_has_ept(get_vmcs12(vcpu)))
+		return vmx_eptp_page_walk_level(nested_ept_get_eptp(vcpu));
+
+	return vmx_get_tdp_level(vcpu);
+}
+
 u64 construct_eptp(struct kvm_vcpu *vcpu, unsigned long root_hpa)
 {
 	u64 eptp = VMX_EPTP_MT_WB;
@@ -7832,7 +7840,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 
 	.set_tss_addr = vmx_set_tss_addr,
 	.set_identity_map_addr = vmx_set_identity_map_addr,
-	.get_tdp_level = get_ept_level,
+	.get_tdp_level = vmx_get_tdp_level,
 	.get_mt_mask = vmx_get_mt_mask,
 
 	.get_exit_info = vmx_get_exit_info,
-- 
2.26.0

