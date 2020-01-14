Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6A3C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0704924679
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732843AbgANKRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:17:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42379 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbgANKRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:17:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irJFt-0007ii-VP; Tue, 14 Jan 2020 11:17:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7914A1C192F;
        Tue, 14 Jan 2020 11:16:55 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:16:55 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] tools/x86: Sync msr-index.h from kernel sources
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191221044513.21680-4-sean.j.christopherson@intel.com>
References: <20191221044513.21680-4-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157899701534.1022.6972553968681887646.tip-bot2@tip-bot2>
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

Commit-ID:     f6505c88bff01e41b21a1f125edd1ace5330f164
Gitweb:        https://git.kernel.org/tip/f6505c88bff01e41b21a1f125edd1ace5330f164
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 20 Dec 2019 20:44:57 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Jan 2020 17:42:57 +01:00

tools/x86: Sync msr-index.h from kernel sources

Sync msr-index.h to pull in recent renames of the IA32_FEATURE_CONTROL
MSR definitions.  Update KVM's VMX selftest and turbostat accordingly.
Keep the full name in turbostat's output to avoid breaking someone's
workflow, e.g. if a script is looking for the full name.

While using the renamed defines is by no means necessary, do the sync
now to avoid leaving a landmine that will get stepped on the next time
msr-index.h needs to be refreshed for some other reason.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20191221044513.21680-4-sean.j.christopherson@intel.com
---
 tools/arch/x86/include/asm/msr-index.h       | 14 ++++++++------
 tools/power/x86/turbostat/turbostat.c        |  4 ++--
 tools/testing/selftests/kvm/lib/x86_64/vmx.c |  8 ++++----
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 20ce682..f4c5c88 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -540,7 +540,14 @@
 #define MSR_IA32_EBL_CR_POWERON		0x0000002a
 #define MSR_EBC_FREQUENCY_ID		0x0000002c
 #define MSR_SMI_COUNT			0x00000034
-#define MSR_IA32_FEATURE_CONTROL        0x0000003a
+
+/* Referred to as IA32_FEATURE_CONTROL in Intel's SDM. */
+#define MSR_IA32_FEAT_CTL		0x0000003a
+#define FEAT_CTL_LOCKED				BIT(0)
+#define FEAT_CTL_VMX_ENABLED_INSIDE_SMX		BIT(1)
+#define FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX	BIT(2)
+#define FEAT_CTL_LMCE_ENABLED			BIT(20)
+
 #define MSR_IA32_TSC_ADJUST             0x0000003b
 #define MSR_IA32_BNDCFGS		0x00000d90
 
@@ -548,11 +555,6 @@
 
 #define MSR_IA32_XSS			0x00000da0
 
-#define FEATURE_CONTROL_LOCKED				(1<<0)
-#define FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX	(1<<1)
-#define FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX	(1<<2)
-#define FEATURE_CONTROL_LMCE				(1<<20)
-
 #define MSR_IA32_APICBASE		0x0000001b
 #define MSR_IA32_APICBASE_BSP		(1<<8)
 #define MSR_IA32_APICBASE_ENABLE	(1<<11)
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5d0fddd..31c1ca0 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4499,10 +4499,10 @@ void decode_feature_control_msr(void)
 {
 	unsigned long long msr;
 
-	if (!get_msr(base_cpu, MSR_IA32_FEATURE_CONTROL, &msr))
+	if (!get_msr(base_cpu, MSR_IA32_FEAT_CTL, &msr))
 		fprintf(outf, "cpu%d: MSR_IA32_FEATURE_CONTROL: 0x%08llx (%sLocked %s)\n",
 			base_cpu, msr,
-			msr & FEATURE_CONTROL_LOCKED ? "" : "UN-",
+			msr & FEAT_CTL_LOCKED ? "" : "UN-",
 			msr & (1 << 18) ? "SGX" : "");
 }
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/vmx.c b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
index f6ec97b..85064ba 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
@@ -157,11 +157,11 @@ bool prepare_for_vmx_operation(struct vmx_pages *vmx)
 	 *  Bit 2: Enables VMXON outside of SMX operation. If clear, VMXON
 	 *    outside of SMX causes a #GP.
 	 */
-	required = FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
-	required |= FEATURE_CONTROL_LOCKED;
-	feature_control = rdmsr(MSR_IA32_FEATURE_CONTROL);
+	required = FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX;
+	required |= FEAT_CTL_LOCKED;
+	feature_control = rdmsr(MSR_IA32_FEAT_CTL);
 	if ((feature_control & required) != required)
-		wrmsr(MSR_IA32_FEATURE_CONTROL, feature_control | required);
+		wrmsr(MSR_IA32_FEAT_CTL, feature_control | required);
 
 	/* Enter VMX root operation. */
 	*(uint32_t *)(vmx->vmxon) = vmcs_revision();
