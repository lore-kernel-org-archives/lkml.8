Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82160C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FDFA20769
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgDJL4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:56:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54441 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgDJL4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:56:09 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jMsGR-0004cu-KI; Fri, 10 Apr 2020 13:56:03 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 2C311100BB6;
        Fri, 10 Apr 2020 13:56:03 +0200 (CEST)
Message-Id: <20200410115517.176308876@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 10 Apr 2020 13:54:02 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [patch 3/3] KVM: VMX: Extend VMXs #AC interceptor to handle split
 lock #AC in guest
References: <20200410115359.242241855@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoyao Li <xiaoyao.li@intel.com>

Two types of #AC can be generated in Intel CPUs:
 1. legacy alignment check #AC
 2. split lock #AC

Reflect #AC back into the guest if the guest has legacy alignment checks
enabled or if split lock detection is disabled.

If the #AC is not a legacy one and split lock detection is enabled, then
invoke handle_guest_split_lock() which will either warn and disable split
lock detection for this task or force SIGBUS on it.

[ tglx: Switch it to handle_guest_split_lock() and renamed the misnomed
  	helper function ]

Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kvm/vmx/vmx.c |   37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4592,6 +4592,26 @@ static int handle_machine_check(struct k
 	return 1;
 }
 
+/*
+ * If the host has split lock detection disabled, then #AC is
+ * unconditionally injected into the guest, which is the pre split lock
+ * detection behaviour.
+ *
+ * If the host has split lock detection enabled then #AC is
+ * only injected into the guest when:
+ *  - Guest CPL == 3 (user mode)
+ *  - Guest has #AC detection enabled in CR0
+ *  - Guest EFLAGS has AC bit set
+ */
+static inline bool guest_inject_ac(struct kvm_vcpu *vcpu)
+{
+	if (!boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
+		return true;
+
+	return vmx_get_cpl(vcpu) == 3 && kvm_read_cr0_bits(vcpu, X86_CR0_AM) &&
+	       (kvm_get_rflags(vcpu) & X86_EFLAGS_AC);
+}
+
 static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -4657,9 +4677,6 @@ static int handle_exception_nmi(struct k
 		return handle_rmode_exception(vcpu, ex_no, error_code);
 
 	switch (ex_no) {
-	case AC_VECTOR:
-		kvm_queue_exception_e(vcpu, AC_VECTOR, error_code);
-		return 1;
 	case DB_VECTOR:
 		dr6 = vmcs_readl(EXIT_QUALIFICATION);
 		if (!(vcpu->guest_debug &
@@ -4688,6 +4705,20 @@ static int handle_exception_nmi(struct k
 		kvm_run->debug.arch.pc = vmcs_readl(GUEST_CS_BASE) + rip;
 		kvm_run->debug.arch.exception = ex_no;
 		break;
+	case AC_VECTOR:
+		if (guest_inject_ac(vcpu)) {
+			kvm_queue_exception_e(vcpu, AC_VECTOR, error_code);
+			return 1;
+		}
+
+		/*
+		 * Handle split lock. Depending on detection mode this will
+		 * either warn and disable split lock detection for this
+		 * task or force SIGBUS on it.
+		 */
+		if (handle_guest_split_lock(kvm_rip_read(vcpu)))
+			return 1;
+		fallthrough;
 	default:
 		kvm_run->exit_reason = KVM_EXIT_EXCEPTION;
 		kvm_run->ex.exception = ex_no;

