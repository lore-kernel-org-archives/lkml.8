Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F3CC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38C962192A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgEBEdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 00:33:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:55783 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbgEBEci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 00:32:38 -0400
IronPort-SDR: +onDbf2vLzHJynDicW9Y7sNBbS67eiWPeOZoOKIdH/FnervwXu1ezCWQYeQbk4gYf2W++G9w4a
 88Tek1BgldCw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 21:32:37 -0700
IronPort-SDR: QutYqXqyBV1wcl0CDrUf5G3U2HC0G/VXMJtzu05q63l0LFZAagyKaFM1hLTmk0RQzKNo0LhQkb
 NP8MSz4qGAHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,342,1583222400"; 
   d="scan'208";a="433516126"
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
Subject: [PATCH 05/10] KVM: nVMX: Avoid retpoline when writing DR7 during nested transitions
Date:   Fri,  1 May 2020 21:32:29 -0700
Message-Id: <20200502043234.12481-6-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200502043234.12481-1-sean.j.christopherson@intel.com>
References: <20200502043234.12481-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper, nested_vmx_set_dr7(), to handle updating DR7 during nested
transitions to avoid bouncing through kvm_update_dr7() and its
potentially retpolined kvm_x86_ops.set_dr7() call.  The duplicated code
to adjust the architectural DR7 is minor, and losing the WARN_ON() when
refreshing DR7 from vmcs01 is really no loss at all.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/nested.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1f2f41e821f9..3b4f1408b4e1 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2116,6 +2116,12 @@ static void vmx_start_preemption_timer(struct kvm_vcpu *vcpu)
 		      ns_to_ktime(preemption_timeout), HRTIMER_MODE_REL);
 }
 
+static void nested_vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
+{
+	vcpu->arch.dr7 = (val & DR7_VOLATILE) | DR7_FIXED_1;
+	vmcs_writel(GUEST_DR7, __kvm_update_dr7(vcpu));
+}
+
 static u64 nested_vmx_calc_efer(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 {
 	if (vmx->nested.nested_run_pending &&
@@ -2487,10 +2493,10 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 
 	if (vmx->nested.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS)) {
-		kvm_set_dr(vcpu, 7, vmcs12->guest_dr7);
+		nested_vmx_set_dr7(vcpu, vmcs12->guest_dr7);
 		vmcs_write64(GUEST_IA32_DEBUGCTL, vmcs12->guest_ia32_debugctl);
 	} else {
-		kvm_set_dr(vcpu, 7, vcpu->arch.dr7);
+		nested_vmx_set_dr7(vcpu, vcpu->arch.dr7);
 		vmcs_write64(GUEST_IA32_DEBUGCTL, vmx->nested.vmcs01_debugctl);
 	}
 	if (kvm_mpx_supported() && (!vmx->nested.nested_run_pending ||
@@ -4176,7 +4182,7 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 	};
 	vmx_set_segment(vcpu, &seg, VCPU_SREG_TR);
 
-	kvm_set_dr(vcpu, 7, 0x400);
+	nested_vmx_set_dr7(vcpu, 0x400);
 	vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
 
 	if (cpu_has_vmx_msr_bitmap())
@@ -4228,9 +4234,9 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
 		 * nested VMENTER (not worth adding a variable in nested_vmx).
 		 */
 		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP)
-			kvm_set_dr(vcpu, 7, DR7_FIXED_1);
+			nested_vmx_set_dr7(vcpu, DR7_FIXED_1);
 		else
-			WARN_ON(kvm_set_dr(vcpu, 7, vmcs_readl(GUEST_DR7)));
+			nested_vmx_set_dr7(vcpu, vmcs_readl(GUEST_DR7));
 	}
 
 	/*
-- 
2.26.0

