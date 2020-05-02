Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA73AC47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA792184D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgEBEdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 00:33:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:55789 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgEBEci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 00:32:38 -0400
IronPort-SDR: 2dSyjpuev4NHOnYfXYwzlj942eApvlbQMYoWcDH9QJFQ68+VPuK+s00EHWVNawkiUVjHjI1S0x
 kK2PLW7vSHGQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 21:32:37 -0700
IronPort-SDR: lWUA5Fb1CHqS/CzeMRdFFjJat7n8GOmxhUXWKDuJsoql4LOYgSDp2pxIpEeMldZ0Fa0ZV0tqyy
 vv59G8X1XOHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,342,1583222400"; 
   d="scan'208";a="433516123"
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
Subject: [PATCH 04/10] KVM: x86: Split guts of kvm_update_dr7() to separate helper
Date:   Fri,  1 May 2020 21:32:28 -0700
Message-Id: <20200502043234.12481-5-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200502043234.12481-1-sean.j.christopherson@intel.com>
References: <20200502043234.12481-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the calculation of the effective DR7 into a separate helper,
__kvm_update_dr7(), and make the helper visible to vendor code.  It will
be used in a future patch to avoid the retpoline associated with
kvm_x86_ops.set_dr7() when stuffing DR7 during nested VMX transitions.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/x86.c | 11 +----------
 arch/x86/kvm/x86.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index eccbfcb6a4e5..8893c42eac9e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1076,16 +1076,7 @@ static void kvm_update_dr6(struct kvm_vcpu *vcpu)
 
 static void kvm_update_dr7(struct kvm_vcpu *vcpu)
 {
-	unsigned long dr7;
-
-	if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP)
-		dr7 = vcpu->arch.guest_debug_dr7;
-	else
-		dr7 = vcpu->arch.dr7;
-	kvm_x86_ops.set_dr7(vcpu, dr7);
-	vcpu->arch.switch_db_regs &= ~KVM_DEBUGREG_BP_ENABLED;
-	if (dr7 & DR7_BP_EN_MASK)
-		vcpu->arch.switch_db_regs |= KVM_DEBUGREG_BP_ENABLED;
+	kvm_x86_ops.set_dr7(vcpu, __kvm_update_dr7(vcpu));
 }
 
 static u64 kvm_dr6_fixed(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 7b5ed8ed628e..75010b22e379 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -236,6 +236,20 @@ static inline void kvm_register_writel(struct kvm_vcpu *vcpu,
 	return kvm_register_write(vcpu, reg, val);
 }
 
+static inline unsigned long __kvm_update_dr7(struct kvm_vcpu *vcpu)
+{
+	unsigned long dr7;
+
+	if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP)
+		dr7 = vcpu->arch.guest_debug_dr7;
+	else
+		dr7 = vcpu->arch.dr7;
+	vcpu->arch.switch_db_regs &= ~KVM_DEBUGREG_BP_ENABLED;
+	if (dr7 & DR7_BP_EN_MASK)
+		vcpu->arch.switch_db_regs |= KVM_DEBUGREG_BP_ENABLED;
+	return dr7;
+}
+
 static inline bool kvm_check_has_quirk(struct kvm *kvm, u64 quirk)
 {
 	return !(kvm->arch.disabled_quirks & quirk);
-- 
2.26.0

