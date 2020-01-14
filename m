Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2001FC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E8B20678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731484AbgANKRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:17:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42324 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731450AbgANKRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:17:00 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irJFk-0007f9-Ob; Tue, 14 Jan 2020 11:16:52 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 64F361C03A9;
        Tue, 14 Jan 2020 11:16:52 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:16:52 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] KVM: VMX: Drop initialization of IA32_FEAT_CTL MSR
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Jim Mattson <jmattson@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191221044513.21680-15-sean.j.christopherson@intel.com>
References: <20191221044513.21680-15-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157899701222.1022.11353387553218939268.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     21bd3467a58ea51ccc0b1d9bcb86dadf1640a002
Gitweb:        https://git.kernel.org/tip/21bd3467a58ea51ccc0b1d9bcb86dadf1640a002
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 20 Dec 2019 20:45:08 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Jan 2020 19:04:37 +01:00

KVM: VMX: Drop initialization of IA32_FEAT_CTL MSR

Remove KVM's code to initialize IA32_FEAT_CTL MSR when KVM is loaded now
that the MSR is initialized during boot on all CPUs that support VMX,
i.e. on all CPUs that can possibly load kvm_intel.

Note, don't WARN if IA32_FEAT_CTL is unlocked, even though the MSR is
unconditionally locked by init_ia32_feat_ctl().  KVM isn't tied directly
to a CPU vendor detection, whereas init_ia32_feat_ctl() is invoked if
and only if the CPU vendor is recognized and known to support VMX.  As a
result, vmx_disabled_by_bios() may be reached without going through
init_ia32_feat_ctl() and thus without locking IA32_FEAT_CTL.  This quirk
will be eliminated in a future patch.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jim Mattson <jmattson@google.com>
Link: https://lkml.kernel.org/r/20191221044513.21680-15-sean.j.christopherson@intel.com
---
 arch/x86/kvm/vmx/vmx.c | 48 ++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 91b2517..a026334 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2207,24 +2207,26 @@ static __init int vmx_disabled_by_bios(void)
 	u64 msr;
 
 	rdmsrl(MSR_IA32_FEAT_CTL, msr);
-	if (msr & FEAT_CTL_LOCKED) {
-		/* launched w/ TXT and VMX disabled */
-		if (!(msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX)
-			&& tboot_enabled())
-			return 1;
-		/* launched w/o TXT and VMX only enabled w/ TXT */
-		if (!(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX)
-			&& (msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX)
-			&& !tboot_enabled()) {
-			printk(KERN_WARNING "kvm: disable TXT in the BIOS or "
-				"activate TXT before enabling KVM\n");
-			return 1;
-		}
-		/* launched w/o TXT and VMX disabled */
-		if (!(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX)
-			&& !tboot_enabled())
-			return 1;
+
+	if (unlikely(!(msr & FEAT_CTL_LOCKED)))
+		return 1;
+
+	/* launched w/ TXT and VMX disabled */
+	if (!(msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX) &&
+	    tboot_enabled())
+		return 1;
+	/* launched w/o TXT and VMX only enabled w/ TXT */
+	if (!(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX) &&
+	    (msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX) &&
+	    !tboot_enabled()) {
+		pr_warn("kvm: disable TXT in the BIOS or "
+			"activate TXT before enabling KVM\n");
+		return 1;
 	}
+	/* launched w/o TXT and VMX disabled */
+	if (!(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX) &&
+	    !tboot_enabled())
+		return 1;
 
 	return 0;
 }
@@ -2241,7 +2243,6 @@ static int hardware_enable(void)
 {
 	int cpu = raw_smp_processor_id();
 	u64 phys_addr = __pa(per_cpu(vmxarea, cpu));
-	u64 old, test_bits;
 
 	if (cr4_read_shadow() & X86_CR4_VMXE)
 		return -EBUSY;
@@ -2269,17 +2270,6 @@ static int hardware_enable(void)
 	 */
 	crash_enable_local_vmclear(cpu);
 
-	rdmsrl(MSR_IA32_FEAT_CTL, old);
-
-	test_bits = FEAT_CTL_LOCKED;
-	test_bits |= FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX;
-	if (tboot_enabled())
-		test_bits |= FEAT_CTL_VMX_ENABLED_INSIDE_SMX;
-
-	if ((old & test_bits) != test_bits) {
-		/* enable and lock */
-		wrmsrl(MSR_IA32_FEAT_CTL, old | test_bits);
-	}
 	kvm_cpu_vmxon(phys_addr);
 	if (enable_ept)
 		ept_sync_global();
