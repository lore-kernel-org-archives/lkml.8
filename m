Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFB9C33CA5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A072467D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgAJSAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 13:00:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59270 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbgAJR7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:59:22 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyZ5-00029a-SB; Fri, 10 Jan 2020 18:59:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 901BC1C2D6A;
        Fri, 10 Jan 2020 18:59:19 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:59:19 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Rename <asm/pat.h> => <asm/memtype.h>
Cc:     Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157867915945.30329.7243348158702094251.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     eb243d1d28663c9b92010973a6a3ffa947f682ba
Gitweb:        https://git.kernel.org/tip/eb243d1d28663c9b92010973a6a3ffa947f682ba
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 20 Nov 2019 15:33:57 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2019 10:12:55 +01:00

x86/mm/pat: Rename <asm/pat.h> => <asm/memtype.h>

pat.h is a file whose main purpose is to provide the memtype_*() APIs.

PAT is the low level hardware mechanism - but the high level abstraction
is memtype.

So name the header <memtype.h> as well - this goes hand in hand with memtype.c
and memtype_interval.c.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/memtype.h     | 27 +++++++++++++++++++++++++++
 arch/x86/include/asm/mtrr.h        |  2 +-
 arch/x86/include/asm/pat.h         | 27 ---------------------------
 arch/x86/include/asm/pci.h         |  2 +-
 arch/x86/kernel/cpu/common.c       |  2 +-
 arch/x86/kernel/cpu/mtrr/generic.c |  2 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c    |  2 +-
 arch/x86/kernel/cpu/scattered.c    |  2 +-
 arch/x86/kernel/cpu/topology.c     |  2 +-
 arch/x86/kernel/x86_init.c         |  2 +-
 arch/x86/kvm/mmu/mmu.c             |  2 +-
 arch/x86/mm/iomap_32.c             |  2 +-
 arch/x86/mm/ioremap.c              |  2 +-
 arch/x86/mm/pat/memtype.c          |  2 +-
 arch/x86/mm/pat/memtype_interval.c |  2 +-
 arch/x86/mm/pat/set_memory.c       |  2 +-
 arch/x86/pci/i386.c                |  2 +-
 arch/x86/xen/mmu_pv.c              |  2 +-
 drivers/infiniband/hw/mlx5/main.c  |  2 +-
 drivers/media/pci/ivtv/ivtvfb.c    |  2 +-
 20 files changed, 45 insertions(+), 45 deletions(-)
 create mode 100644 arch/x86/include/asm/memtype.h
 delete mode 100644 arch/x86/include/asm/pat.h

diff --git a/arch/x86/include/asm/memtype.h b/arch/x86/include/asm/memtype.h
new file mode 100644
index 0000000..ec18e38
--- /dev/null
+++ b/arch/x86/include/asm/memtype.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_MEMTYPE_H
+#define _ASM_X86_MEMTYPE_H
+
+#include <linux/types.h>
+#include <asm/pgtable_types.h>
+
+bool pat_enabled(void);
+void pat_disable(const char *reason);
+extern void pat_init(void);
+extern void init_cache_modes(void);
+
+extern int memtype_reserve(u64 start, u64 end,
+		enum page_cache_mode req_pcm, enum page_cache_mode *ret_pcm);
+extern int memtype_free(u64 start, u64 end);
+
+extern int memtype_kernel_map_sync(u64 base, unsigned long size,
+		enum page_cache_mode pcm);
+
+int memtype_reserve_io(resource_size_t start, resource_size_t end,
+			enum page_cache_mode *pcm);
+
+void memtype_free_io(resource_size_t start, resource_size_t end);
+
+bool pat_pfn_immune_to_uc_mtrr(unsigned long pfn);
+
+#endif /* _ASM_X86_MEMTYPE_H */
diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 3337d22..829df26 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -24,7 +24,7 @@
 #define _ASM_X86_MTRR_H
 
 #include <uapi/asm/mtrr.h>
-#include <asm/pat.h>
+#include <asm/memtype.h>
 
 
 /*
diff --git a/arch/x86/include/asm/pat.h b/arch/x86/include/asm/pat.h
deleted file mode 100644
index 4a9a97d..0000000
--- a/arch/x86/include/asm/pat.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_PAT_H
-#define _ASM_X86_PAT_H
-
-#include <linux/types.h>
-#include <asm/pgtable_types.h>
-
-bool pat_enabled(void);
-void pat_disable(const char *reason);
-extern void pat_init(void);
-extern void init_cache_modes(void);
-
-extern int memtype_reserve(u64 start, u64 end,
-		enum page_cache_mode req_pcm, enum page_cache_mode *ret_pcm);
-extern int memtype_free(u64 start, u64 end);
-
-extern int memtype_kernel_map_sync(u64 base, unsigned long size,
-		enum page_cache_mode pcm);
-
-int memtype_reserve_io(resource_size_t start, resource_size_t end,
-			enum page_cache_mode *pcm);
-
-void memtype_free_io(resource_size_t start, resource_size_t end);
-
-bool pat_pfn_immune_to_uc_mtrr(unsigned long pfn);
-
-#endif /* _ASM_X86_PAT_H */
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 90d0731..c1fdd43 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -9,7 +9,7 @@
 #include <linux/scatterlist.h>
 #include <linux/numa.h>
 #include <asm/io.h>
-#include <asm/pat.h>
+#include <asm/memtype.h>
 #include <asm/x86_init.h>
 
 struct pci_sysdata {
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2e4d902..9d6a35a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -49,7 +49,7 @@
 #include <asm/cpu.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
-#include <asm/pat.h>
+#include <asm/memtype.h>
 #include <asm/microcode.h>
 #include <asm/microcode_intel.h>
 #include <asm/intel-family.h>
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index aa5c064..51b9190 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -15,7 +15,7 @@
 #include <asm/tlbflush.h>
 #include <asm/mtrr.h>
 #include <asm/msr.h>
-#include <asm/pat.h>
+#include <asm/memtype.h>
 
 #include "mtrr.h"
 
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 507039c..6a80f36 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -52,7 +52,7 @@
 #include <asm/e820/api.h>
 #include <asm/mtrr.h>
 #include <asm/msr.h>
-#include <asm/pat.h>
+#include <asm/memtype.h>
 
 #include "mtrr.h"
 
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index adf9b71..62b137c 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -4,7 +4,7 @@
  */
 #include <linux/cpu.h>
 
-#include <asm/pat.h>
+#include <asm/memtype.h>
 #include <asm/apic.h>
 #include <asm/processor.h>
 
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index ee48c3f..d3a0791 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -7,7 +7,7 @@
 
 #include <linux/cpu.h>
 #include <asm/apic.h>
-#include <asm/pat.h>
+#include <asm/memtype.h>
 #include <asm/processor.h>
 
 #include "cpu.h"
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index ce89430..23e25f3 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -20,7 +20,7 @@
 #include <asm/irq.h>
 #include <asm/io_apic.h>
 #include <asm/hpet.h>
-#include <asm/pat.h>
+#include <asm/memtype.h>
 #include <asm/tsc.h>
 #include <asm/iommu.h>
 #include <asm/mach_traps.h>
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6f92b40..a32b847 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -40,7 +40,7 @@
 #include <linux/kthread.h>
 
 #include <asm/page.h>
-#include <asm/pat.h>
+#include <asm/memtype.h>
 #include <asm/cmpxchg.h>
 #include <asm/e820/api.h>
 #include <asm/io.h>
diff --git a/arch/x86/mm/iomap_32.c b/arch/x86/mm/iomap_32.c
index 4a0762e..f60398a 100644
--- a/arch/x86/mm/iomap_32.c
+++ b/arch/x86/mm/iomap_32.c
@@ -4,7 +4,7 @@
  */
 
 #include <asm/iomap.h>
-#include <asm/pat.h>
+#include <asm/memtype.h>
 #include <linux/export.h>
 #include <linux/highmem.h>
 
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index e49de6c..44e4beb 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -24,7 +24,7 @@
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 #include <asm/pgalloc.h>
-#include <asm/pat.h>
+#include <asm/memtype.h>
 #include <asm/setup.h>
 
 #include "physaddr.h"
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 7ed3735..394be86 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -52,7 +52,7 @@
 #include <asm/mtrr.h>
 #include <asm/page.h>
 #include <asm/msr.h>
-#include <asm/pat.h>
+#include <asm/memtype.h>
 #include <asm/io.h>
 
 #include "memtype.h"
diff --git a/arch/x86/mm/pat/memtype_interval.c b/arch/x86/mm/pat/memtype_interval.c
index a7fbbdd..a07e488 100644
--- a/arch/x86/mm/pat/memtype_interval.c
+++ b/arch/x86/mm/pat/memtype_interval.c
@@ -16,7 +16,7 @@
 #include <linux/gfp.h>
 
 #include <asm/pgtable.h>
-#include <asm/pat.h>
+#include <asm/memtype.h>
 
 #include "memtype.h"
 
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 3e5e98b..d4ab493 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -24,7 +24,7 @@
 #include <linux/uaccess.h>
 #include <asm/pgalloc.h>
 #include <asm/proto.h>
-#include <asm/pat.h>
+#include <asm/memtype.h>
 #include <asm/set_memory.h>
 
 #include "../mm_internal.h"
diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index 9df652d..fa855bb 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -34,7 +34,7 @@
 #include <linux/errno.h>
 #include <linux/memblock.h>
 
-#include <asm/pat.h>
+#include <asm/memtype.h>
 #include <asm/e820/api.h>
 #include <asm/pci_x86.h>
 #include <asm/io_apic.h>
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index c8dbee6..bbba8b1 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -67,7 +67,7 @@
 #include <asm/linkage.h>
 #include <asm/page.h>
 #include <asm/init.h>
-#include <asm/pat.h>
+#include <asm/memtype.h>
 #include <asm/smp.h>
 #include <asm/tlb.h>
 
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 5110035..c0c2c56 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -40,7 +40,7 @@
 #include <linux/slab.h>
 #include <linux/bitmap.h>
 #if defined(CONFIG_X86)
-#include <asm/pat.h>
+#include <asm/memtype.h>
 #endif
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
diff --git a/drivers/media/pci/ivtv/ivtvfb.c b/drivers/media/pci/ivtv/ivtvfb.c
index 95a56cc..1daf9e0 100644
--- a/drivers/media/pci/ivtv/ivtvfb.c
+++ b/drivers/media/pci/ivtv/ivtvfb.c
@@ -37,7 +37,7 @@
 #include <linux/ivtvfb.h>
 
 #ifdef CONFIG_X86_64
-#include <asm/pat.h>
+#include <asm/memtype.h>
 #endif
 
 /* card parameters */
