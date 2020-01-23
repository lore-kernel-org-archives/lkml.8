Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55372C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3730B21D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgAWTGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:06:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:45947 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbgAWTGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:06:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 11:06:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,354,1574150400"; 
   d="scan'208";a="216352271"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga007.jf.intel.com with ESMTP; 23 Jan 2020 11:06:01 -0800
Subject: [PATCH 2/5] x86/mpx: remove build infrastructure
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, peterz@infradead.org,
        luto@kernel.org, x86@kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 23 Jan 2020 11:05:00 -0800
References: <20200123190456.8E05ADE6@viggo.jf.intel.com>
In-Reply-To: <20200123190456.8E05ADE6@viggo.jf.intel.com>
Message-Id: <20200123190500.9119F8F4@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

MPX is being removed from the kernel due to a lack of support
in the toolchain going forward (gcc).

Remove the Kconfig option and the Makefile line.  This makes
arch/x86/mm/mpx.c and anything under an #ifdef for
X86_INTEL_MPX dead code.

Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/Kconfig     |   28 ----------------------------
 b/arch/x86/mm/Makefile |    1 -
 2 files changed, 29 deletions(-)

diff -puN arch/x86/Kconfig~mpx-remove-build arch/x86/Kconfig
--- a/arch/x86/Kconfig~mpx-remove-build	2020-01-23 10:41:04.863942440 -0800
+++ b/arch/x86/Kconfig	2020-01-23 10:41:04.869942440 -0800
@@ -1896,34 +1896,6 @@ config X86_INTEL_UMIP
 	  specific cases in protected and virtual-8086 modes. Emulated
 	  results are dummy.
 
-config X86_INTEL_MPX
-	prompt "Intel MPX (Memory Protection Extensions)"
-	def_bool n
-	# Note: only available in 64-bit mode due to VMA flags shortage
-	depends on CPU_SUP_INTEL && X86_64
-	select ARCH_USES_HIGH_VMA_FLAGS
-	---help---
-	  MPX provides hardware features that can be used in
-	  conjunction with compiler-instrumented code to check
-	  memory references.  It is designed to detect buffer
-	  overflow or underflow bugs.
-
-	  This option enables running applications which are
-	  instrumented or otherwise use MPX.  It does not use MPX
-	  itself inside the kernel or to protect the kernel
-	  against bad memory references.
-
-	  Enabling this option will make the kernel larger:
-	  ~8k of kernel text and 36 bytes of data on a 64-bit
-	  defconfig.  It adds a long to the 'mm_struct' which
-	  will increase the kernel memory overhead of each
-	  process and adds some branches to paths used during
-	  exec() and munmap().
-
-	  For details, see Documentation/x86/intel_mpx.rst
-
-	  If unsure, say N.
-
 config X86_INTEL_MEMORY_PROTECTION_KEYS
 	prompt "Intel Memory Protection Keys"
 	def_bool y
diff -puN arch/x86/mm/Makefile~mpx-remove-build arch/x86/mm/Makefile
--- a/arch/x86/mm/Makefile~mpx-remove-build	2020-01-23 10:41:04.865942440 -0800
+++ b/arch/x86/mm/Makefile	2020-01-23 10:41:04.870942440 -0800
@@ -45,7 +45,6 @@ obj-$(CONFIG_AMD_NUMA)		+= amdtopology.o
 obj-$(CONFIG_ACPI_NUMA)		+= srat.o
 obj-$(CONFIG_NUMA_EMU)		+= numa_emulation.o
 
-obj-$(CONFIG_X86_INTEL_MPX)			+= mpx.o
 obj-$(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)	+= pkeys.o
 obj-$(CONFIG_RANDOMIZE_MEMORY)			+= kaslr.o
 obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
_
