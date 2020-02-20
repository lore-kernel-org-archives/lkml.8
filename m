Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D42BC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8C7208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgBTUog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:44:36 -0500
Received: from mga12.intel.com ([192.55.52.136]:13654 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729029AbgBTUn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:43:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 12:43:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,465,1574150400"; 
   d="scan'208";a="349237098"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2020 12:43:58 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] KVM: VMX: Handle INVVPID fallback logic in vpid_sync_vcpu_addr()
Date:   Thu, 20 Feb 2020 12:43:49 -0800
Message-Id: <20200220204356.8837-4-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220204356.8837-1-sean.j.christopherson@intel.com>
References: <20200220204356.8837-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Directly invoke vpid_sync_context() to do a global INVVPID when the
individual address variant is not supported instead of deferring such
behavior to the caller.  This allows for additional consolidation of
code as the logic is basically identical to the emulation of the
individual address variant in handle_invvpid().

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/ops.h | 12 +++++-------
 arch/x86/kvm/vmx/vmx.c |  3 +--
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx/ops.h b/arch/x86/kvm/vmx/ops.h
index a2b0689e65e3..612df1bdb26b 100644
--- a/arch/x86/kvm/vmx/ops.h
+++ b/arch/x86/kvm/vmx/ops.h
@@ -276,17 +276,15 @@ static inline void vpid_sync_context(int vpid)
 		vpid_sync_vcpu_global();
 }
 
-static inline bool vpid_sync_vcpu_addr(int vpid, gva_t addr)
+static inline void vpid_sync_vcpu_addr(int vpid, gva_t addr)
 {
 	if (vpid == 0)
-		return true;
+		return;
 
-	if (cpu_has_vmx_invvpid_individual_addr()) {
+	if (cpu_has_vmx_invvpid_individual_addr())
 		__invvpid(VMX_VPID_EXTENT_INDIVIDUAL_ADDR, vpid, addr);
-		return true;
-	}
-
-	return false;
+	else
+		vpid_sync_context(vpid);
 }
 
 static inline void ept_sync_global(void)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9a6664886f2e..349a6e054e0e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2826,8 +2826,7 @@ static void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
 {
 	int vpid = to_vmx(vcpu)->vpid;
 
-	if (!vpid_sync_vcpu_addr(vpid, addr))
-		vpid_sync_context(vpid);
+	vpid_sync_vcpu_addr(vpid, addr);
 
 	/*
 	 * If VPIDs are not supported or enabled, then the above is a no-op.
-- 
2.24.1

