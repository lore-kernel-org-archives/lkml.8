Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD019C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB99C208A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406504AbgE1T2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406311AbgE1T2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:28:23 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58BFC08C5C6;
        Thu, 28 May 2020 12:28:22 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeOCL-0007H2-5Y; Thu, 28 May 2020 21:28:13 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BC42F1C032F;
        Thu, 28 May 2020 21:28:12 +0200 (CEST)
Date:   Thu, 28 May 2020 19:28:12 -0000
From:   "tip-bot2 for Mike Rapoport" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm: Drop deprecated DISCONTIGMEM support for 32-bit
Cc:     Mike Rapoport <rppt@linux.ibm.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200223094322.15206-1-rppt@kernel.org>
References: <20200223094322.15206-1-rppt@kernel.org>
MIME-Version: 1.0
Message-ID: <159069409265.17951.5705837690464074589.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     431732651cc16caebcd334b7b7476bfe0c4a2903
Gitweb:        https://git.kernel.org/tip/431732651cc16caebcd334b7b7476bfe0c4a2903
Author:        Mike Rapoport <rppt@linux.ibm.com>
AuthorDate:    Sun, 23 Feb 2020 11:43:22 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 28 May 2020 18:34:30 +02:00

x86/mm: Drop deprecated DISCONTIGMEM support for 32-bit

The DISCONTIGMEM support was marked as deprecated in v5.2 and since there
were no complaints about it for almost 5 releases it can be completely
removed.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20200223094322.15206-1-rppt@kernel.org
---
 arch/x86/Kconfig                  |  9 +-------
 arch/x86/include/asm/mmzone_32.h  | 39 +------------------------------
 arch/x86/include/asm/pgtable_32.h |  3 +--
 arch/x86/mm/numa_32.c             | 34 +--------------------------
 4 files changed, 1 insertion(+), 84 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1d6104e..f0aa194 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1610,19 +1610,10 @@ config NODES_SHIFT
 	  Specify the maximum number of NUMA Nodes available on the target
 	  system.  Increases memory reserved to accommodate various tables.
 
-config ARCH_HAVE_MEMORY_PRESENT
-	def_bool y
-	depends on X86_32 && DISCONTIGMEM
-
 config ARCH_FLATMEM_ENABLE
 	def_bool y
 	depends on X86_32 && !NUMA
 
-config ARCH_DISCONTIGMEM_ENABLE
-	def_bool n
-	depends on NUMA && X86_32
-	depends on BROKEN
-
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	depends on X86_64 || NUMA || X86_32 || X86_32_NON_STANDARD
diff --git a/arch/x86/include/asm/mmzone_32.h b/arch/x86/include/asm/mmzone_32.h
index 73d8dd1..2d4515e 100644
--- a/arch/x86/include/asm/mmzone_32.h
+++ b/arch/x86/include/asm/mmzone_32.h
@@ -14,43 +14,4 @@ extern struct pglist_data *node_data[];
 #define NODE_DATA(nid)	(node_data[nid])
 #endif /* CONFIG_NUMA */
 
-#ifdef CONFIG_DISCONTIGMEM
-
-/*
- * generic node memory support, the following assumptions apply:
- *
- * 1) memory comes in 64Mb contiguous chunks which are either present or not
- * 2) we will not have more than 64Gb in total
- *
- * for now assume that 64Gb is max amount of RAM for whole system
- *    64Gb / 4096bytes/page = 16777216 pages
- */
-#define MAX_NR_PAGES 16777216
-#define MAX_SECTIONS 1024
-#define PAGES_PER_SECTION (MAX_NR_PAGES/MAX_SECTIONS)
-
-extern s8 physnode_map[];
-
-static inline int pfn_to_nid(unsigned long pfn)
-{
-#ifdef CONFIG_NUMA
-	return((int) physnode_map[(pfn) / PAGES_PER_SECTION]);
-#else
-	return 0;
-#endif
-}
-
-static inline int pfn_valid(int pfn)
-{
-	int nid = pfn_to_nid(pfn);
-
-	if (nid >= 0)
-		return (pfn < node_end_pfn(nid));
-	return 0;
-}
-
-#define early_pfn_valid(pfn)	pfn_valid((pfn))
-
-#endif /* CONFIG_DISCONTIGMEM */
-
 #endif /* _ASM_X86_MMZONE_32_H */
diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index 0dca7f7..be7b196 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -66,8 +66,7 @@ do {						\
 #endif /* !__ASSEMBLY__ */
 
 /*
- * kern_addr_valid() is (1) for FLATMEM and (0) for
- * SPARSEMEM and DISCONTIGMEM
+ * kern_addr_valid() is (1) for FLATMEM and (0) for SPARSEMEM
  */
 #ifdef CONFIG_FLATMEM
 #define kern_addr_valid(addr)	(1)
diff --git a/arch/x86/mm/numa_32.c b/arch/x86/mm/numa_32.c
index f2bd3d6..1045443 100644
--- a/arch/x86/mm/numa_32.c
+++ b/arch/x86/mm/numa_32.c
@@ -27,40 +27,6 @@
 
 #include "numa_internal.h"
 
-#ifdef CONFIG_DISCONTIGMEM
-/*
- * 4) physnode_map     - the mapping between a pfn and owning node
- * physnode_map keeps track of the physical memory layout of a generic
- * numa node on a 64Mb break (each element of the array will
- * represent 64Mb of memory and will be marked by the node id.  so,
- * if the first gig is on node 0, and the second gig is on node 1
- * physnode_map will contain:
- *
- *     physnode_map[0-15] = 0;
- *     physnode_map[16-31] = 1;
- *     physnode_map[32- ] = -1;
- */
-s8 physnode_map[MAX_SECTIONS] __read_mostly = { [0 ... (MAX_SECTIONS - 1)] = -1};
-EXPORT_SYMBOL(physnode_map);
-
-void memory_present(int nid, unsigned long start, unsigned long end)
-{
-	unsigned long pfn;
-
-	printk(KERN_INFO "Node: %d, start_pfn: %lx, end_pfn: %lx\n",
-			nid, start, end);
-	printk(KERN_DEBUG "  Setting physnode_map array to node %d for pfns:\n", nid);
-	printk(KERN_DEBUG "  ");
-	start = round_down(start, PAGES_PER_SECTION);
-	end = round_up(end, PAGES_PER_SECTION);
-	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION) {
-		physnode_map[pfn / PAGES_PER_SECTION] = nid;
-		printk(KERN_CONT "%lx ", pfn);
-	}
-	printk(KERN_CONT "\n");
-}
-#endif
-
 extern unsigned long highend_pfn, highstart_pfn;
 
 void __init initmem_init(void)
