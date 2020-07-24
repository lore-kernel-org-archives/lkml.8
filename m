Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A776AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE2E20737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgGXFFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 01:05:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:1853 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgGXFFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 01:05:32 -0400
IronPort-SDR: ulgF0eLWHsqtxFc/lqPNoIJBqxXu7sRnKZ7dg/XNX/vrWTmxQ5/353Ouf0ErkWQpIncI65pajn
 thdbY209HaFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="149850550"
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="149850550"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 22:05:31 -0700
IronPort-SDR: FxIvEMr0VQstUo688TaoH7q9kyNYHCyZJgcCSuv1J8SKcwm2cz5knGFhZivT5JLVpbetc4YIXy
 liasXZaTbPdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="302553164"
Received: from itopinsk-mobl1.ccr.corp.intel.com (HELO localhost) ([10.249.36.179])
  by orsmga002.jf.intel.com with ESMTP; 23 Jul 2020 22:05:24 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-mm@kvack.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Omar Sandoval <osandov@fb.com>,
        Brian Gerst <brgerst@gmail.com>,
        Marco Elver <elver@google.com>, Babu Moger <Babu.Moger@amd.com>
Subject: [PATCH v5 3/6] arch/x86: Implement text_alloc() and text_free()
Date:   Fri, 24 Jul 2020 08:04:57 +0300
Message-Id: <20200724050501.1723315-4-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724050501.1723315-1-jarkko.sakkinen@linux.intel.com>
References: <20200724050501.1723315-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement text_alloc() and text_free() with with the vmalloc API. These can
be used to allocate pages for trampoline code without relying on the module
loader code.

Cc: linux-mm@kvack.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/Kconfig             |  3 +++
 arch/x86/kernel/Makefile     |  1 +
 arch/x86/kernel/text_alloc.c | 41 ++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100644 arch/x86/kernel/text_alloc.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0dea7fdd7a00..a4ee5d1300f6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2035,6 +2035,9 @@ config KEXEC_FILE
 config ARCH_HAS_KEXEC_PURGATORY
 	def_bool KEXEC_FILE
 
+config ARCH_HAS_TEXT_ALLOC
+	def_bool y
+
 config KEXEC_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
 	depends on KEXEC_FILE
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index e77261db2391..fa1415424ae3 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -68,6 +68,7 @@ obj-y			+= tsc.o tsc_msr.o io_delay.o rtc.o
 obj-y			+= pci-iommu_table.o
 obj-y			+= resource.o
 obj-y			+= irqflags.o
+obj-y			+= text_alloc.o
 
 obj-y				+= process.o
 obj-y				+= fpu/
diff --git a/arch/x86/kernel/text_alloc.c b/arch/x86/kernel/text_alloc.c
new file mode 100644
index 000000000000..f31c2d82c258
--- /dev/null
+++ b/arch/x86/kernel/text_alloc.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Kernel module help for x86.
+ *  Copyright (C) 2001 Rusty Russell.
+ */
+
+#include <linux/kasan.h>
+#include <linux/mm.h>
+#include <linux/moduleloader.h>
+#include <linux/vmalloc.h>
+#include <asm/setup.h>
+
+void *text_alloc(unsigned long size)
+{
+	void *p;
+
+	if (PAGE_ALIGN(size) > MODULES_LEN)
+		return NULL;
+
+	p = __vmalloc_node_range(size, MODULE_ALIGN, MODULES_VADDR, MODULES_END,
+				 GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,
+				 __builtin_return_address(0));
+
+	if (p && (kasan_module_alloc(p, size) < 0)) {
+		vfree(p);
+		return NULL;
+	}
+
+	return p;
+}
+
+void text_free(void *region)
+{
+	/*
+	 * This memory may be RO, and freeing RO memory in an interrupt is not
+	 * supported by vmalloc.
+	 */
+	lockdep_assert_irqs_enabled();
+
+	vfree(region);
+}
-- 
2.25.1

