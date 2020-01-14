Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117B1C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF74E207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbgANKRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:17:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42360 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732427AbgANKRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:17:04 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irJFr-0007gy-7Z; Tue, 14 Jan 2020 11:16:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E83481C001A;
        Tue, 14 Jan 2020 11:16:53 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:16:53 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/vmx: Introduce VMX_FEATURES_*
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191221044513.21680-10-sean.j.christopherson@intel.com>
References: <20191221044513.21680-10-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157899701373.1022.4823195651623101979.tip-bot2@tip-bot2>
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

Commit-ID:     159348784ff0654291f4c7607fc55e73da8e87e8
Gitweb:        https://git.kernel.org/tip/159348784ff0654291f4c7607fc55e73da8e87e8
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 20 Dec 2019 20:45:03 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Jan 2020 17:57:26 +01:00

x86/vmx: Introduce VMX_FEATURES_*

Add a VMX-specific variant of X86_FEATURE_* flags, which will eventually
supplant the synthetic VMX flags defined in cpufeatures word 8.  Use the
Intel-defined layouts for the major VMX execution controls so that their
word entries can be directly populated from their respective MSRs, and
so that the VMX_FEATURE_* flags can be used to define the existing bit
definitions in asm/vmx.h, i.e. force developers to define a VMX_FEATURE
flag when adding support for a new hardware feature.

The majority of Intel's (and compatible CPU's) VMX capabilities are
enumerated via MSRs and not CPUID, i.e. querying /proc/cpuinfo doesn't
naturally provide any insight into the virtualization capabilities of
VMX enabled CPUs.  Commit

  e38e05a85828d ("x86: extended "flags" to show virtualization HW feature
		 in /proc/cpuinfo")

attempted to address the issue by synthesizing select VMX features into
a Linux-defined word in cpufeatures.

Lack of reporting of VMX capabilities via /proc/cpuinfo is problematic
because there is no sane way for a user to query the capabilities of
their platform, e.g. when trying to find a platform to test a feature or
debug an issue that has a hardware dependency.  Lack of reporting is
especially problematic when the user isn't familiar with VMX, e.g. the
format of the MSRs is non-standard, existence of some MSRs is reported
by bits in other MSRs, several "features" from KVM's point of view are
enumerated as 3+ distinct features by hardware, etc...

The synthetic cpufeatures approach has several flaws:

  - The set of synthesized VMX flags has become extremely stale with
    respect to the full set of VMX features, e.g. only one new flag
    (EPT A/D) has been added in the the decade since the introduction of
    the synthetic VMX features.  Failure to keep the VMX flags up to
    date is likely due to the lack of a mechanism that forces developers
    to consider whether or not a new feature is worth reporting.

  - The synthetic flags may incorrectly be misinterpreted as affecting
    kernel behavior, i.e. KVM, the kernel's sole consumer of VMX,
    completely ignores the synthetic flags.

  - New CPU vendors that support VMX have duplicated the hideous code
    that propagates VMX features from MSRs to cpufeatures.  Bringing the
    synthetic VMX flags up to date would exacerbate the copy+paste
    trainwreck.

Define separate VMX_FEATURE flags to set the stage for enumerating VMX
capabilities outside of the cpu_has() framework, and for adding
functional usage of VMX_FEATURE_* to help ensure the features reported
via /proc/cpuinfo is up to date with respect to kernel recognition of
VMX capabilities.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20191221044513.21680-10-sean.j.christopherson@intel.com
---
 MAINTAINERS                        |  2 +-
 arch/x86/include/asm/processor.h   |  1 +-
 arch/x86/include/asm/vmxfeatures.h | 81 +++++++++++++++++++++++++++++-
 3 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/vmxfeatures.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bd5847e..2b38d50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9128,7 +9128,7 @@ F:	arch/x86/include/uapi/asm/svm.h
 F:	arch/x86/include/asm/kvm*
 F:	arch/x86/include/asm/pvclock-abi.h
 F:	arch/x86/include/asm/svm.h
-F:	arch/x86/include/asm/vmx.h
+F:	arch/x86/include/asm/vmx*.h
 F:	arch/x86/kernel/kvm.c
 F:	arch/x86/kernel/kvmclock.c
 
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 7c071f8..b49b88b 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -25,6 +25,7 @@ struct vm86;
 #include <asm/special_insns.h>
 #include <asm/fpu/types.h>
 #include <asm/unwind_hints.h>
+#include <asm/vmxfeatures.h>
 
 #include <linux/personality.h>
 #include <linux/cache.h>
diff --git a/arch/x86/include/asm/vmxfeatures.h b/arch/x86/include/asm/vmxfeatures.h
new file mode 100644
index 0000000..4c743ba
--- /dev/null
+++ b/arch/x86/include/asm/vmxfeatures.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_VMXFEATURES_H
+#define _ASM_X86_VMXFEATURES_H
+
+/*
+ * Note: If the comment begins with a quoted string, that string is used
+ * in /proc/cpuinfo instead of the macro name.  If the string is "",
+ * this feature bit is not displayed in /proc/cpuinfo at all.
+ */
+
+/* Pin-Based VM-Execution Controls, EPT/VPID, APIC and VM-Functions, word 0 */
+#define VMX_FEATURE_INTR_EXITING	( 0*32+  0) /* "" VM-Exit on vectored interrupts */
+#define VMX_FEATURE_NMI_EXITING		( 0*32+  3) /* "" VM-Exit on NMIs */
+#define VMX_FEATURE_VIRTUAL_NMIS	( 0*32+  5) /* "vnmi" NMI virtualization */
+#define VMX_FEATURE_PREEMPTION_TIMER	( 0*32+  6) /* VMX Preemption Timer */
+#define VMX_FEATURE_POSTED_INTR		( 0*32+  7) /* Posted Interrupts */
+
+/* EPT/VPID features, scattered to bits 16-23 */
+#define VMX_FEATURE_INVVPID		( 0*32+ 16) /* INVVPID is supported */
+#define VMX_FEATURE_EPT_EXECUTE_ONLY	( 0*32+ 17) /* "ept_x_only" EPT entries can be execute only */
+#define VMX_FEATURE_EPT_AD		( 0*32+ 18) /* EPT Accessed/Dirty bits */
+#define VMX_FEATURE_EPT_1GB		( 0*32+ 19) /* 1GB EPT pages */
+
+/* Aggregated APIC features 24-27 */
+#define VMX_FEATURE_FLEXPRIORITY	( 0*32+ 24) /* TPR shadow + virt APIC */
+#define VMX_FEATURE_APICV	        ( 0*32+ 25) /* TPR shadow + APIC reg virt + virt intr delivery + posted interrupts */
+
+/* VM-Functions, shifted to bits 28-31 */
+#define VMX_FEATURE_EPTP_SWITCHING	( 0*32+ 28) /* EPTP switching (in guest) */
+
+/* Primary Processor-Based VM-Execution Controls, word 1 */
+#define VMX_FEATURE_VIRTUAL_INTR_PENDING ( 1*32+  2) /* "" VM-Exit if INTRs are unblocked in guest */
+#define VMX_FEATURE_TSC_OFFSETTING	( 1*32+  3) /* "tsc_offset" Offset hardware TSC when read in guest */
+#define VMX_FEATURE_HLT_EXITING		( 1*32+  7) /* "" VM-Exit on HLT */
+#define VMX_FEATURE_INVLPG_EXITING	( 1*32+  9) /* "" VM-Exit on INVLPG */
+#define VMX_FEATURE_MWAIT_EXITING	( 1*32+ 10) /* "" VM-Exit on MWAIT */
+#define VMX_FEATURE_RDPMC_EXITING	( 1*32+ 11) /* "" VM-Exit on RDPMC */
+#define VMX_FEATURE_RDTSC_EXITING	( 1*32+ 12) /* "" VM-Exit on RDTSC */
+#define VMX_FEATURE_CR3_LOAD_EXITING	( 1*32+ 15) /* "" VM-Exit on writes to CR3 */
+#define VMX_FEATURE_CR3_STORE_EXITING	( 1*32+ 16) /* "" VM-Exit on reads from CR3 */
+#define VMX_FEATURE_CR8_LOAD_EXITING	( 1*32+ 19) /* "" VM-Exit on writes to CR8 */
+#define VMX_FEATURE_CR8_STORE_EXITING	( 1*32+ 20) /* "" VM-Exit on reads from CR8 */
+#define VMX_FEATURE_VIRTUAL_TPR		( 1*32+ 21) /* "vtpr" TPR virtualization, a.k.a. TPR shadow */
+#define VMX_FEATURE_VIRTUAL_NMI_PENDING	( 1*32+ 22) /* "" VM-Exit if NMIs are unblocked in guest */
+#define VMX_FEATURE_MOV_DR_EXITING	( 1*32+ 23) /* "" VM-Exit on accesses to debug registers */
+#define VMX_FEATURE_UNCOND_IO_EXITING	( 1*32+ 24) /* "" VM-Exit on *all* IN{S} and OUT{S}*/
+#define VMX_FEATURE_USE_IO_BITMAPS	( 1*32+ 25) /* "" VM-Exit based on I/O port */
+#define VMX_FEATURE_MONITOR_TRAP_FLAG	( 1*32+ 27) /* "mtf" VMX single-step VM-Exits */
+#define VMX_FEATURE_USE_MSR_BITMAPS	( 1*32+ 28) /* "" VM-Exit based on MSR index */
+#define VMX_FEATURE_MONITOR_EXITING	( 1*32+ 29) /* "" VM-Exit on MONITOR (MWAIT's accomplice) */
+#define VMX_FEATURE_PAUSE_EXITING	( 1*32+ 30) /* "" VM-Exit on PAUSE (unconditionally) */
+#define VMX_FEATURE_SEC_CONTROLS	( 1*32+ 31) /* "" Enable Secondary VM-Execution Controls */
+
+/* Secondary Processor-Based VM-Execution Controls, word 2 */
+#define VMX_FEATURE_VIRT_APIC_ACCESSES	( 2*32+  0) /* "vapic" Virtualize memory mapped APIC accesses */
+#define VMX_FEATURE_EPT			( 2*32+  1) /* Extended Page Tables, a.k.a. Two-Dimensional Paging */
+#define VMX_FEATURE_DESC_EXITING	( 2*32+  2) /* "" VM-Exit on {S,L}*DT instructions */
+#define VMX_FEATURE_RDTSCP		( 2*32+  3) /* "" Enable RDTSCP in guest */
+#define VMX_FEATURE_VIRTUAL_X2APIC	( 2*32+  4) /* "" Virtualize X2APIC for the guest */
+#define VMX_FEATURE_VPID		( 2*32+  5) /* Virtual Processor ID (TLB ASID modifier) */
+#define VMX_FEATURE_WBINVD_EXITING	( 2*32+  6) /* "" VM-Exit on WBINVD */
+#define VMX_FEATURE_UNRESTRICTED_GUEST	( 2*32+  7) /* Allow Big Real Mode and other "invalid" states */
+#define VMX_FEATURE_APIC_REGISTER_VIRT	( 2*32+  8) /* "vapic_reg" Hardware emulation of reads to the virtual-APIC */
+#define VMX_FEATURE_VIRT_INTR_DELIVERY	( 2*32+  9) /* "vid" Evaluation and delivery of pending virtual interrupts */
+#define VMX_FEATURE_PAUSE_LOOP_EXITING	( 2*32+ 10) /* "ple" Conditionally VM-Exit on PAUSE at CPL0 */
+#define VMX_FEATURE_RDRAND_EXITING	( 2*32+ 11) /* "" VM-Exit on RDRAND*/
+#define VMX_FEATURE_INVPCID		( 2*32+ 12) /* "" Enable INVPCID in guest */
+#define VMX_FEATURE_VMFUNC		( 2*32+ 13) /* "" Enable VM-Functions (leaf dependent) */
+#define VMX_FEATURE_SHADOW_VMCS		( 2*32+ 14) /* VMREAD/VMWRITE in guest can access shadow VMCS */
+#define VMX_FEATURE_ENCLS_EXITING	( 2*32+ 15) /* "" VM-Exit on ENCLS (leaf dependent) */
+#define VMX_FEATURE_RDSEED_EXITING	( 2*32+ 16) /* "" VM-Exit on RDSEED */
+#define VMX_FEATURE_PAGE_MOD_LOGGING	( 2*32+ 17) /* "pml" Log dirty pages into buffer */
+#define VMX_FEATURE_EPT_VIOLATION_VE	( 2*32+ 18) /* "" Conditionally reflect EPT violations as #VE exceptions */
+#define VMX_FEATURE_PT_CONCEAL_VMX	( 2*32+ 19) /* "" Suppress VMX indicators in Processor Trace */
+#define VMX_FEATURE_XSAVES		( 2*32+ 20) /* "" Enable XSAVES and XRSTORS in guest */
+#define VMX_FEATURE_MODE_BASED_EPT_EXEC	( 2*32+ 22) /* "ept_mode_based_exec" Enable separate EPT EXEC bits for supervisor vs. user */
+#define VMX_FEATURE_PT_USE_GPA		( 2*32+ 24) /* "" Processor Trace logs GPAs */
+#define VMX_FEATURE_TSC_SCALING		( 2*32+ 25) /* Scale hardware TSC when read in guest */
+#define VMX_FEATURE_ENCLV_EXITING	( 2*32+ 28) /* "" VM-Exit on ENCLV (leaf dependent) */
+
+#endif /* _ASM_X86_VMXFEATURES_H */
