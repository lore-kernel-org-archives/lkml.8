Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97B8C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D89206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgHaSxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:53:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:15923 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727933AbgHaSxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:53:17 -0400
IronPort-SDR: YQotMRrKgT5p7LoSSuV6CGAbdfQgPxO2MP+OTE14f/WsrpSW93fYmDhQOoCIMngeH3nNvw5g5F
 spfBCCrFPl5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="154561046"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="154561046"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 11:53:00 -0700
IronPort-SDR: v90XZ5/SzbgtOohqJ6kjawuQeetkr4CUnEAwmttARTCgAcULGomwZBCi+TCm9OLy4XjjHvSy+w
 VbEVsOvztJ8A==
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="301148165"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.153])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 11:53:00 -0700
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     kyung.min.park@intel.com, tglx@linutronix.de, bp@alien8.de,
        tony.luck@intel.com, dave.hansen@intel.com, ricardo.neri@intel.com,
        hpa@zytor.com, gregkh@linuxfoundation.org, ak@linux.intel.com,
        ravi.v.shankar@intel.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v3] Documentation/x86: Add documentation for /proc/cpuinfo feature flags
Date:   Mon, 31 Aug 2020 11:35:00 -0700
Message-Id: <20200831183500.15481-1-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/cpuinfo shows features which the kernel supports. Some of these
flags are derived from CPUID, and others are derived from other sources,
including some that are entirely software-based. Currently, there is
not any documentation in the kernel about how /proc/cpuinfo flags are
generated and what it means when they are missing.

Add documentation for /proc/cpuinfo feature flags enumeration.
Document how and when x86 feature flags are used. Also discuss what
their presence or absence mean for the kernel and users.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Co-developed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
ChangeLog:
- Change from v2 to v3:
  1. Changed the CPUID custom tool to the one that will be in the kernel
     source as suggested by Borislav Petkov.
  2. Some change of wording as suggested by Borislav petkov.
- Change from v1 to v2:
  1. Removed patches of adding feature flags (TSXLDTRK, SERIALIZE) from this
     patchset.
  2. Removed the cover letter.
  3. Some change of wording in Documentation/x86/cpuinfo.rst as suggested by
     Borislav Petkov.
  4. Add the explanation of the feature flag usage for KVM as suggested by
     Tony Luck.
---
 Documentation/x86/cpuinfo.rst | 155 ++++++++++++++++++++++++++++++++++
 Documentation/x86/index.rst   |   1 +
 2 files changed, 156 insertions(+)
 create mode 100644 Documentation/x86/cpuinfo.rst

diff --git a/Documentation/x86/cpuinfo.rst b/Documentation/x86/cpuinfo.rst
new file mode 100644
index 000000000000..5d54c39a063f
--- /dev/null
+++ b/Documentation/x86/cpuinfo.rst
@@ -0,0 +1,155 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+x86 Feature Flags
+=================
+
+Introduction
+============
+
+On x86, flags appearing in /proc/cpuinfo have an X86_FEATURE definition
+in arch/x86/include/asm/cpufeatures.h. If the kernel cares about a feature
+or KVM want to expose the feature to a KVM guest, it can and should have
+an X86_FEATURE_* defined. These flags represent hardware features as
+well as software features.
+
+If users want to know if a feature is available on a given system, they
+try to find the flag in /proc/cpuinfo. If a given flag is present, it
+means that the kernel supports it and is currently making it available.
+If such flag represents a hardware feature, it also means that the
+hardware supports it.
+
+If the expected flag does not appear in /proc/cpuinfo, things are murkier.
+Users need to find out the reason why the flag is missing and find the way
+how to enable it, which is not always easy. There are several factors that
+can explain missing flags: the expected feature failed to enable, the feature
+is missing in hardware, platform firmware did not enable it, the feature is
+disabled at build or run time, an old kernel is in use, or the kernel does
+not support the feature and thus has not enabled it. In general, /proc/cpuinfo
+shows features which the kernel supports. For a full list of CPUID flags
+which the CPU supports, use tools/arch/x86/kcpuid.
+
+How are feature flags created?
+==============================
+
+a: Feature flags can be derived from the contents of CPUID leaves.
+------------------------------------------------------------------
+These feature definitions are organized mirroring the layout of CPUID
+leaves and grouped in words with offsets as mapped in enum cpuid_leafs
+in cpufeatures.h (see arch/x86/include/asm/cpufeatures.h for details).
+If a feature is defined with a X86_FEATURE_<name> definition in
+cpufeatures.h, and if it is detected at run time, the flags will be
+displayed accordingly in /proc/cpuinfo. For example, the flag "avx2"
+comes from X86_FEATURE_AVX2 in cpufeatures.h.
+
+b: Flags can be from scattered CPUID-based features.
+----------------------------------------------------
+Hardware features enumerated in sparsely populated CPUID leaves get
+software-defined values. Still, CPUID needs to be queried to determine
+if a given feature is present. This is done in init_scattered_cpuid_features().
+For instance, X86_FEATURE_CQM_LLC is defined as 11*32 + 0 and its presence is
+checked at runtime in the respective CPUID leaf [EAX=f, ECX=0] bit EDX[1].
+
+The intent of scattering CPUID leaves is to not bloat struct
+cpuinfo_x86.x86_capability[] unnecessarily. For instance, the CPUID leaf
+[EAX=7, ECX=0] has 30 features and is dense, but the CPUID leaf [EAX=7, EAX=1]
+has only one feature and would waste 31 bits of space in the x86_capability[]
+array. Since there is a struct cpuinfo_x86 for each possible CPU, the wasted
+memory is not trivial.
+
+c: Flags can be created synthetically under certain conditions for hardware features.
+-------------------------------------------------------------------------------------
+Examples of conditions include whether certain features are present in
+MSR_IA32_CORE_CAPS or specific CPU models are identified. If the needed
+conditions are met, the features are enabled by the set_cpu_cap or
+setup_force_cpu_cap macros. For example, if bit 5 is set in MSR_IA32_CORE_CAPS,
+the feature X86_FEATURE_SPLIT_LOCK_DETECT will be enabled and
+"split_lock_detect" will be displayed. The flag "ring3mwait" will be
+displayed only when running on INTEL_FAM6_XEON_PHI_[KNL|KNM] processors.
+
+d: Flags can represent purely software features.
+------------------------------------------------
+These flags do not represent hardware features. Instead, they represent a
+software feature implemented in the kernel. For example, Kernel Page Table
+Isolation is purely software feature and its feature flag X86_FEATURE_PTI is
+also defined in cpufeatures.h.
+
+Naming of Flags
+===============
+
+The script arch/x86/kernel/cpu/mkcapflags.sh processes the
+#define X86_FEATURE_<name> from cpufeatures.h and generates the
+x86_cap/bug_flags[] arrays in kernel/cpu/capflags.c. The names in the
+resulting x86_cap/bug_flags[] are used to populate /proc/cpuinfo. The naming
+of flags in the x86_cap/bug_flags[] are as follows:
+
+a: The name of the flag is from the string in X86_FEATURE_<name> by default.
+----------------------------------------------------------------------------
+By default, the flag <name> in /proc/cpuinfo is extracted from the respective
+X86_FEATURE_<name> in cpufeatures.h. For example, the flag "avx2" is from
+X86_FEATURE_AVX2.
+
+b: The naming can be overridden.
+--------------------------------
+If the comment on the line for the #define X86_FEATURE_* starts with a
+double-quote character (""), the string inside the double-quote characters
+will be the name of the flags. For example, the flag "sse4_1" comes from
+the comment "sse4_1" following the X86_FEATURE_XMM4_1 definition.
+
+There are situations in which overriding the displayed name of the flag is
+needed. For instance, /proc/cpuinfo is a userspace interface and must remain
+constant. If, for some reason, the naming of X86_FEATURE_<name> changes, one
+shall override the new naming with the name already used in /proc/cpuinfo.
+
+c: The naming override can be "", which means it will not appear in /proc/cpuinfo.
+----------------------------------------------------------------------------------
+The feature shall be omitted from /proc/cpuinfo if it does not make sense for
+the feature to be exposed to userspace. For example, X86_FEATURE_ALWAYS is
+defined in cpufeatures.h but that flag is an internal kernel feature used
+in the alternative runtime patching functionality. So, its name is overridden
+with "". Its flag will not appear in /proc/cpuinfo.
+
+Flags are missing when one or more of these happen
+==================================================
+
+a: The hardware does not enumerate support for it.
+--------------------------------------------------
+For example, when a new kernel is running on old hardware or the feature is
+not enabled by boot firmware. Even if the hardware is new, there might be a
+problem enabling the feature at run time, the flag will not be displayed.
+
+b: The kernel does not know about the flag.
+-------------------------------------------
+For example, when an old kernel is running on new hardware.
+
+c: The kernel disabled support for it at compile-time.
+------------------------------------------------------
+For example, if 5-level-paging is not enabled when building (i.e.,
+CONFIG_X86_5LEVEL is not selected) the flag "la57" will not show up [#f1]_.
+Even though the feature will still be detected via CPUID, the kernel disables
+it by clearing via setup_clear_cpu_cap(X86_FEATURE_LA57).
+
+d: The feature is disabled at boot-time.
+----------------------------------------
+A feature can be disabled either using a command-line parameter or because
+it failed to be enabled. The command-line parameter clearcpuid= can be used
+to disable features using the feature number as defined in
+/arch/x86/include/asm/cpufeatures.h. For instance, User Mode Instruction
+Protection can be disabled using clearcpuid=514. The number 514 is calculated
+from #define X86_FEATURE_UMIP (16*32 + 2).
+
+In addition, there exists a variety of custom command-line parameters that
+disable specific features. The list of parameters includes, but is not limited
+to, nofsgsbase, nosmap, and nosmep. 5-level paging can also be disabled using
+"no5lvl". SMAP and SMEP are disabled with the aforementioned parameters,
+respectively.
+
+e: The feature was known to be non-functional.
+----------------------------------------------
+The feature was known to be non-functional because a dependency was
+missing at runtime. For example, AVX flags will not show up if XSAVE feature
+is disabled since they depend on XSAVE feature. Another example would be broken
+CPUs and them missing microcode patches. Due to that, the kernel decides not to
+enable a feature.
+
+.. [#f1] 5-level paging uses linear address of 57 bits.
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 265d9e9a093b..d5adb0ab8668 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -9,6 +9,7 @@ x86-specific Documentation
    :numbered:
 
    boot
+   cpuinfo
    topology
    exception-tables
    kernel-stacks
-- 
2.17.1

