Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40722C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280F5206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCLSpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:45:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:23446 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgCLSp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:45:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 11:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="416041250"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga005.jf.intel.com with ESMTP; 12 Mar 2020 11:45:23 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 09/10] KVM: VMX: Cache vmx->exit_reason in local u16 in vmx_handle_exit_irqoff()
Date:   Thu, 12 Mar 2020 11:45:20 -0700
Message-Id: <20200312184521.24579-10-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312184521.24579-1-sean.j.christopherson@intel.com>
References: <20200312184521.24579-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a u16 to hold the exit reason in vmx_handle_exit_irqoff(), as the
checks for INTR/NMI/WRMSR expect to encounter only the basic exit reason
in vmx->exit_reason.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d43e1d28bb58..910a7cadeaf7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6287,16 +6287,16 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu)
 STACK_FRAME_NON_STANDARD(handle_external_interrupt_irqoff);
 
 static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu,
-	enum exit_fastpath_completion *exit_fastpath)
+				   enum exit_fastpath_completion *exit_fastpath)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	u16 exit_reason = vmx->exit_reason;
 
-	if (vmx->exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT)
+	if (exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT)
 		handle_external_interrupt_irqoff(vcpu);
-	else if (vmx->exit_reason == EXIT_REASON_EXCEPTION_NMI)
+	else if (exit_reason == EXIT_REASON_EXCEPTION_NMI)
 		handle_exception_nmi_irqoff(vmx);
-	else if (!is_guest_mode(vcpu) &&
-		vmx->exit_reason == EXIT_REASON_MSR_WRITE)
+	else if (!is_guest_mode(vcpu) && exit_reason == EXIT_REASON_MSR_WRITE)
 		*exit_fastpath = handle_fastpath_set_msr_irqoff(vcpu);
 }
 
-- 
2.24.1

