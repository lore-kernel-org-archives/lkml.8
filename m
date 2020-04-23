Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD0AC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8298E2077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587684162;
	bh=NyMvVPc26cHDJ5pBzO6gjZvfGZ7yw4HWPE+vaWF6wHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XEBnzBPv/EZGsb4/tm+xuMWI7xtWwqXLzsezVTP6ZJMiwQ5QBNamgHkfbnSg108V+
	 XFYTiHOVsFWuflx/yyVkXy9m0depehIBqovKlyKei5NEzSriLdN/AE9/vOuBrJP4Hh
	 09mhQW0Mtn812RodwCf+fkCz7YJ2q2qypWfJ1AzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgDWXWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729941AbgDWXWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:22:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE725214AF;
        Thu, 23 Apr 2020 23:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587684157;
        bh=NyMvVPc26cHDJ5pBzO6gjZvfGZ7yw4HWPE+vaWF6wHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oWUb6AnYwrUQhgkbMAUoqYVaQWMiYRxwyk2P6+Xhcl3yIbX6HDNEdTnjJ5kQLy0Jr
         a65PEhT/vRQS5kAoEKDGNFB54SEmvKfe/nNOFzHOCRZho4j39/p8xson4CiCDI7BG2
         Ov+CCiF1i8hwOH6PwAdadoNhcVOxKXVgA4xVP8mM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v10 18/18] Documentation/x86/64: Add documentation for GS/FS addressing mode
Date:   Thu, 23 Apr 2020 19:22:07 -0400
Message-Id: <20200423232207.5797-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423232207.5797-1-sashal@kernel.org>
References: <20200423232207.5797-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Explain how the GS/FS based addressing can be utilized in user space
applications along with the differences between the generic prctl() based
GS/FS base control and the FSGSBASE version available on newer CPUs.

Originally-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/x86/x86_64/fsgs.rst  | 199 +++++++++++++++++++++++++++++
 Documentation/x86/x86_64/index.rst |   1 +
 2 files changed, 200 insertions(+)
 create mode 100644 Documentation/x86/x86_64/fsgs.rst

diff --git a/Documentation/x86/x86_64/fsgs.rst b/Documentation/x86/x86_64/fsgs.rst
new file mode 100644
index 0000000000000..50960e09e1f66
--- /dev/null
+++ b/Documentation/x86/x86_64/fsgs.rst
@@ -0,0 +1,199 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Using FS and GS segments in user space applications
+===================================================
+
+The x86 architecture supports segmentation. Instructions which access
+memory can use segment register based addressing mode. The following
+notation is used to address a byte within a segment:
+
+  Segment-register:Byte-address
+
+The segment base address is added to the Byte-address to compute the
+resulting virtual address which is accessed. This allows to access multiple
+instances of data with the identical Byte-address, i.e. the same code. The
+selection of a particular instance is purely based on the base-address in
+the segment register.
+
+In 32-bit mode the CPU provides 6 segments, which also support segment
+limits. The limits can be used to enforce address space protections.
+
+In 64-bit mode the CS/SS/DS/ES segments are ignored and the base address is
+always 0 to provide a full 64bit address space. The FS and GS segments are
+still functional in 64-bit mode.
+
+Common FS and GS usage
+------------------------------
+
+The FS segment is commonly used to address Thread Local Storage (TLS). FS
+is usually managed by runtime code or a threading library. Variables
+declared with the '__thread' storage class specifier are instantiated per
+thread and the compiler emits the FS: address prefix for accesses to these
+variables. Each thread has its own FS base address so common code can be
+used without complex address offset calculations to access the per thread
+instances. Applications should not use FS for other purposes when they use
+runtimes or threading libraries which manage the per thread FS.
+
+The GS segment has no common use and can be used freely by
+applications. GCC and Clang support GS based addressing via address space
+identifiers.
+
+Reading and writing the FS/GS base address
+------------------------------------------
+
+There exist two mechanisms to read and write the FS/GS base address:
+
+ - the arch_prctl() system call
+
+ - the FSGSBASE instruction family
+
+Accessing FS/GS base with arch_prctl()
+--------------------------------------
+
+ The arch_prctl(2) based mechanism is available on all 64-bit CPUs and all
+ kernel versions.
+
+ Reading the base:
+
+   arch_prctl(ARCH_GET_FS, &fsbase);
+   arch_prctl(ARCH_GET_GS, &gsbase);
+
+ Writing the base:
+
+   arch_prctl(ARCH_SET_FS, fsbase);
+   arch_prctl(ARCH_SET_GS, gsbase);
+
+ The ARCH_SET_GS prctl may be disabled depending on kernel configuration
+ and security settings.
+
+Accessing FS/GS base with the FSGSBASE instructions
+---------------------------------------------------
+
+ With the Ivy Bridge CPU generation Intel introduced a new set of
+ instructions to access the FS and GS base registers directly from user
+ space. These instructions are also supported on AMD Family 17H CPUs. The
+ following instructions are available:
+
+  =============== ===========================
+  RDFSBASE %reg   Read the FS base register
+  RDGSBASE %reg   Read the GS base register
+  WRFSBASE %reg   Write the FS base register
+  WRGSBASE %reg   Write the GS base register
+  =============== ===========================
+
+ The instructions avoid the overhead of the arch_prctl() syscall and allow
+ more flexible usage of the FS/GS addressing modes in user space
+ applications. This does not prevent conflicts between threading libraries
+ and runtimes which utilize FS and applications which want to use it for
+ their own purpose.
+
+FSGSBASE instructions enablement
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ The instructions are enumerated in CPUID leaf 7, bit 0 of EBX. If
+ available /proc/cpuinfo shows 'fsgsbase' in the flag entry of the CPUs.
+
+ The availability of the instructions does not enable them
+ automatically. The kernel has to enable them explicitly in CR4. The
+ reason for this is that older kernels make assumptions about the values in
+ the GS register and enforce them when GS base is set via
+ arch_prctl(). Allowing user space to write arbitrary values to GS base
+ would violate these assumptions and cause malfunction.
+
+ On kernels which do not enable FSGSBASE the execution of the FSGSBASE
+ instructions will fault with a #UD exception.
+
+ The kernel provides reliable information about the enabled state in the
+ ELF AUX vector. If the HWCAP2_FSGSBASE bit is set in the AUX vector, the
+ kernel has FSGSBASE instructions enabled and applications can use them.
+ The following code example shows how this detection works::
+
+   #include <sys/auxv.h>
+   #include <elf.h>
+
+   /* Will be eventually in asm/hwcap.h */
+   #ifndef HWCAP2_FSGSBASE
+   #define HWCAP2_FSGSBASE        (1 << 1)
+   #endif
+
+   ....
+
+   unsigned val = getauxval(AT_HWCAP2);
+
+   if (val & HWCAP2_FSGSBASE)
+        printf("FSGSBASE enabled\n");
+
+FSGSBASE instructions compiler support
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+GCC version 4.6.4 and newer provide instrinsics for the FSGSBASE
+instructions. Clang 5 supports them as well.
+
+  =================== ===========================
+  _readfsbase_u64()   Read the FS base register
+  _readfsbase_u64()   Read the GS base register
+  _writefsbase_u64()  Write the FS base register
+  _writegsbase_u64()  Write the GS base register
+  =================== ===========================
+
+To utilize these instrinsics <immintrin.h> must be included in the source
+code and the compiler option -mfsgsbase has to be added.
+
+Compiler support for FS/GS based addressing
+-------------------------------------------
+
+GCC version 6 and newer provide support for FS/GS based addressing via
+Named Address Spaces. GCC implements the following address space
+identifiers for x86:
+
+  ========= ====================================
+  __seg_fs  Variable is addressed relative to FS
+  __seg_gs  Variable is addressed relative to GS
+  ========= ====================================
+
+The preprocessor symbols __SEG_FS and __SEG_GS are defined when these
+address spaces are supported. Code which implements fallback modes should
+check whether these symbols are defined. Usage example::
+
+  #ifdef __SEG_GS
+
+  long data0 = 0;
+  long data1 = 1;
+
+  long __seg_gs *ptr;
+
+  /* Check whether FSGSBASE is enabled by the kernel (HWCAP2_FSGSBASE) */
+  ....
+
+  /* Set GS base to point to data0 */
+  _writegsbase_u64(&data0);
+
+  /* Access offset 0 of GS */
+  ptr = 0;
+  printf("data0 = %ld\n", *ptr);
+
+  /* Set GS base to point to data1 */
+  _writegsbase_u64(&data1);
+  /* ptr still addresses offset 0! */
+  printf("data1 = %ld\n", *ptr);
+
+
+Clang does not provide the GCC address space identifiers, but it provides
+address spaces via an attribute based mechanism in Clang 2.6 and newer
+versions:
+
+ ==================================== =====================================
+  __attribute__((address_space(256))  Variable is addressed relative to GS
+  __attribute__((address_space(257))  Variable is addressed relative to FS
+ ==================================== =====================================
+
+FS/GS based addressing with inline assembly
+-------------------------------------------
+
+In case the compiler does not support address spaces, inline assembly can
+be used for FS/GS based addressing mode::
+
+	mov %fs:offset, %reg
+	mov %gs:offset, %reg
+
+	mov %reg, %fs:offset
+	mov %reg, %gs:offset
diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index d6eaaa5a35fcd..a56070fc8e77a 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -14,3 +14,4 @@ x86_64 Support
    fake-numa-for-cpusets
    cpu-hotplug-spec
    machinecheck
+   fsgs
-- 
2.20.1

