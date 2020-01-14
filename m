Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BF6C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF4224679
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbgANKRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:17:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42311 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbgANKQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:16:58 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irJFl-0007gj-M6; Tue, 14 Jan 2020 11:16:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5BD821C001A;
        Tue, 14 Jan 2020 11:16:53 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:16:53 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Print VMX flags in /proc/cpuinfo using VMX_FEATURES_*
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191221044513.21680-12-sean.j.christopherson@intel.com>
References: <20191221044513.21680-12-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157899701316.1022.2929211554023948298.tip-bot2@tip-bot2>
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

Commit-ID:     14442a159cf488c05bd5639c9fd5665385b9ab39
Gitweb:        https://git.kernel.org/tip/14442a159cf488c05bd5639c9fd5665385b9ab39
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 20 Dec 2019 20:45:05 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Jan 2020 18:36:02 +01:00

x86/cpu: Print VMX flags in /proc/cpuinfo using VMX_FEATURES_*

Add support for generating VMX feature names in capflags.c and use the
resulting x86_vmx_flags to print the VMX flags in /proc/cpuinfo.  Don't
print VMX flags if no bits are set in word 0, which holds Pin Controls.
Pin Control's INTR and NMI exiting are fundamental pillars of VMX, if
they are not supported then the CPU is broken, it does not actually
support VMX, or the kernel wasn't built with support for the target CPU.

Print the features in a dedicated "vmx flags" line to avoid polluting
the common "flags" and to avoid having to prefix all flags with "vmx_",
which results in horrendously long names.

Keep synthetic VMX flags in cpufeatures to preserve /proc/cpuinfo's ABI
for those flags.  This means that "flags" and "vmx flags" will have
duplicate entries for tpr_shadow (virtual_tpr), vnmi, ept, flexpriority,
vpid and ept_ad, but caps the pollution of "flags" at those six VMX
features.  The vendor-specific code that populates the synthetic flags
will be consolidated in a future patch to further minimize the lasting
damage.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20191221044513.21680-12-sean.j.christopherson@intel.com
---
 arch/x86/boot/mkcpustr.c          |  1 +
 arch/x86/kernel/cpu/Makefile      |  5 +++--
 arch/x86/kernel/cpu/mkcapflags.sh | 15 +++++++++++----
 arch/x86/kernel/cpu/proc.c        | 15 +++++++++++++++
 4 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/mkcpustr.c b/arch/x86/boot/mkcpustr.c
index 9caa10e..da0ccc5 100644
--- a/arch/x86/boot/mkcpustr.c
+++ b/arch/x86/boot/mkcpustr.c
@@ -15,6 +15,7 @@
 #include "../include/asm/required-features.h"
 #include "../include/asm/disabled-features.h"
 #include "../include/asm/cpufeatures.h"
+#include "../include/asm/vmxfeatures.h"
 #include "../kernel/cpu/capflags.c"
 
 int main(void)
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 57652c6..7dc4ad6 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -54,11 +54,12 @@ obj-$(CONFIG_ACRN_GUEST)		+= acrn.o
 
 ifdef CONFIG_X86_FEATURE_NAMES
 quiet_cmd_mkcapflags = MKCAP   $@
-      cmd_mkcapflags = $(CONFIG_SHELL) $(srctree)/$(src)/mkcapflags.sh $< $@
+      cmd_mkcapflags = $(CONFIG_SHELL) $(srctree)/$(src)/mkcapflags.sh $@ $^
 
 cpufeature = $(src)/../../include/asm/cpufeatures.h
+vmxfeature = $(src)/../../include/asm/vmxfeatures.h
 
-$(obj)/capflags.c: $(cpufeature) $(src)/mkcapflags.sh FORCE
+$(obj)/capflags.c: $(cpufeature) $(vmxfeature) $(src)/mkcapflags.sh FORCE
 	$(call if_changed,mkcapflags)
 endif
 targets += capflags.c
diff --git a/arch/x86/kernel/cpu/mkcapflags.sh b/arch/x86/kernel/cpu/mkcapflags.sh
index aed45b8..1db560e 100644
--- a/arch/x86/kernel/cpu/mkcapflags.sh
+++ b/arch/x86/kernel/cpu/mkcapflags.sh
@@ -6,8 +6,7 @@
 
 set -e
 
-IN=$1
-OUT=$2
+OUT=$1
 
 dump_array()
 {
@@ -15,6 +14,7 @@ dump_array()
 	SIZE=$2
 	PFX=$3
 	POSTFIX=$4
+	IN=$5
 
 	PFX_SZ=$(echo $PFX | wc -c)
 	TABS="$(printf '\t\t\t\t\t')"
@@ -57,11 +57,18 @@ trap 'rm "$OUT"' EXIT
 	echo "#endif"
 	echo ""
 
-	dump_array "x86_cap_flags" "NCAPINTS*32" "X86_FEATURE_" ""
+	dump_array "x86_cap_flags" "NCAPINTS*32" "X86_FEATURE_" "" $2
 	echo ""
 
-	dump_array "x86_bug_flags" "NBUGINTS*32" "X86_BUG_" "NCAPINTS*32"
+	dump_array "x86_bug_flags" "NBUGINTS*32" "X86_BUG_" "NCAPINTS*32" $2
+	echo ""
 
+	echo "#ifdef CONFIG_X86_VMX_FEATURE_NAMES"
+	echo "#ifndef _ASM_X86_VMXFEATURES_H"
+	echo "#include <asm/vmxfeatures.h>"
+	echo "#endif"
+	dump_array "x86_vmx_flags" "NVMXINTS*32" "VMX_FEATURE_" "" $3
+	echo "#endif /* CONFIG_X86_VMX_FEATURE_NAMES */"
 ) > $OUT
 
 trap - EXIT
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index cb2e498..4eec888 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -7,6 +7,10 @@
 
 #include "cpu.h"
 
+#ifdef CONFIG_X86_VMX_FEATURE_NAMES
+extern const char * const x86_vmx_flags[NVMXINTS*32];
+#endif
+
 /*
  *	Get CPU information for use by the procfs.
  */
@@ -102,6 +106,17 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		if (cpu_has(c, i) && x86_cap_flags[i] != NULL)
 			seq_printf(m, " %s", x86_cap_flags[i]);
 
+#ifdef CONFIG_X86_VMX_FEATURE_NAMES
+	if (cpu_has(c, X86_FEATURE_VMX) && c->vmx_capability[0]) {
+		seq_puts(m, "\nvmx flags\t:");
+		for (i = 0; i < 32*NVMXINTS; i++) {
+			if (test_bit(i, (unsigned long *)c->vmx_capability) &&
+			    x86_vmx_flags[i] != NULL)
+				seq_printf(m, " %s", x86_vmx_flags[i]);
+		}
+	}
+#endif
+
 	seq_puts(m, "\nbugs\t\t:");
 	for (i = 0; i < 32*NBUGINTS; i++) {
 		unsigned int bug_bit = 32*NCAPINTS + i;
