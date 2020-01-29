Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AB9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 23:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE08206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 23:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgA2Xsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 18:48:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:46690 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgA2Xqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 18:46:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 15:46:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,379,1574150400"; 
   d="scan'208";a="309551698"
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
Subject: [PATCH 02/26] KVM: x86: Take an unsigned 32-bit int for has_emulated_msr()'s index
Date:   Wed, 29 Jan 2020 15:46:16 -0800
Message-Id: <20200129234640.8147-3-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129234640.8147-1-sean.j.christopherson@intel.com>
References: <20200129234640.8147-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take a u32 for the index in has_emulated_msr() to match hardware, which
treats MSR indices as unsigned 32-bit values.  Functionally, taking a
signed int doesn't cause problems with the current code base, but could
theoretically cause problems with 32-bit KVM, e.g. if the index were
checked via a less-than statement, which would evaluate incorrectly for
MSR indices with bit 31 set.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 arch/x86/kvm/svm.c              | 2 +-
 arch/x86/kvm/vmx/vmx.c          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 77d206a93658..5c2ad3fa0980 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1050,7 +1050,7 @@ struct kvm_x86_ops {
 	int (*hardware_setup)(void);               /* __init */
 	void (*hardware_unsetup)(void);            /* __exit */
 	bool (*cpu_has_accelerated_tpr)(void);
-	bool (*has_emulated_msr)(int index);
+	bool (*has_emulated_msr)(u32 index);
 	void (*cpuid_update)(struct kvm_vcpu *vcpu);
 
 	struct kvm *(*vm_alloc)(void);
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index bf0556588ad0..a7b944a3a0e2 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5985,7 +5985,7 @@ static bool svm_cpu_has_accelerated_tpr(void)
 	return false;
 }
 
-static bool svm_has_emulated_msr(int index)
+static bool svm_has_emulated_msr(u32 index)
 {
 	switch (index) {
 	case MSR_IA32_MCG_EXT_CTL:
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 1419c53aed16..f5bb1ad2e9fa 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6274,7 +6274,7 @@ static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu,
 		*exit_fastpath = handle_fastpath_set_msr_irqoff(vcpu);
 }
 
-static bool vmx_has_emulated_msr(int index)
+static bool vmx_has_emulated_msr(u32 index)
 {
 	switch (index) {
 	case MSR_IA32_SMBASE:
-- 
2.24.1

