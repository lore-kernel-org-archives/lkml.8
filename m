Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4768C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 16:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A424A2083E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 16:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgDKQEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 12:04:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55238 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgDKQEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 12:04:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jNIc6-0007WY-17; Sat, 11 Apr 2020 18:04:10 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4414D1C0051;
        Sat, 11 Apr 2020 18:04:09 +0200 (CEST)
Date:   Sat, 11 Apr 2020 16:04:08 -0000
From:   "tip-bot2 for Xiaoyao Li" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] KVM: VMX: Extend VMXs #AC interceptor to handle
 split lock #AC in guest
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200410115517.176308876@linutronix.de>
References: <20200410115517.176308876@linutronix.de>
MIME-Version: 1.0
Message-ID: <158662104885.28353.13755017568373064491.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e6f8b6c12f03818baacc5f504fe83fa5e20771d6
Gitweb:        https://git.kernel.org/tip/e6f8b6c12f03818baacc5f504fe83fa5e20771d6
Author:        Xiaoyao Li <xiaoyao.li@intel.com>
AuthorDate:    Fri, 10 Apr 2020 13:54:02 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 11 Apr 2020 16:42:41 +02:00

KVM: VMX: Extend VMXs #AC interceptor to handle split lock #AC in guest

Two types of #AC can be generated in Intel CPUs:
 1. legacy alignment check #AC
 2. split lock #AC

Reflect #AC back into the guest if the guest has legacy alignment checks
enabled or if split lock detection is disabled.

If the #AC is not a legacy one and split lock detection is enabled, then
invoke handle_guest_split_lock() which will either warn and disable split
lock detection for this task or force SIGBUS on it.

[ tglx: Switch it to handle_guest_split_lock() and rename the misnamed
  helper function. ]

Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lkml.kernel.org/r/20200410115517.176308876@linutronix.de
---
 arch/x86/kvm/vmx/vmx.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8959514..8305097 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4588,6 +4588,26 @@ static int handle_machine_check(struct kvm_vcpu *vcpu)
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
@@ -4653,9 +4673,6 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 		return handle_rmode_exception(vcpu, ex_no, error_code);
 
 	switch (ex_no) {
-	case AC_VECTOR:
-		kvm_queue_exception_e(vcpu, AC_VECTOR, error_code);
-		return 1;
 	case DB_VECTOR:
 		dr6 = vmcs_readl(EXIT_QUALIFICATION);
 		if (!(vcpu->guest_debug &
@@ -4684,6 +4701,20 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
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
