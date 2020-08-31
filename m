Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8331C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2BAE2151B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598856449;
	bh=4aWGNgBJAoBl8QYtMHd09gshebtS7Lgr8i8tu8FJl+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ep8qaIRzYaRoY2jGoad8d1dKP74DHruQXYwwWZKqGdj/MPuG+kdi3X5U0UiUQfbyI
	 hs4OIVLleSWzAV7PjFahh4GhcpfCFz9e4/Awlz0pZpigg8Xf5198SW5pvgnA3qsAfV
	 6Q0fhsM9+4bZ771wxxv2ZcD4+eVbSHEJgX3VdF5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgHaGr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:47:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgHaGrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 02:47:22 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EF5B208DB;
        Mon, 31 Aug 2020 06:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598856442;
        bh=4aWGNgBJAoBl8QYtMHd09gshebtS7Lgr8i8tu8FJl+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y7aR/1qbGDGINVnJAGUUaJmKKGEEbvywsT3prxYzuYju2Io/LF+83Bajiw7XrmKM9
         c0zNRhHO+DMV6/iLGtGPsbYvKILf3YPC+FoZuQsaOEEbHtgYtGFlSdJ5R3t2gnQohM
         KdJjXRmbbj0xXpB/fDr7ggSdBeETwSeE230j65zo=
From:   Mike Rapoport <rppt@kernel.org>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Mike Rapoport <rppt@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [RFC/RFT PATCH v3 1/1] arc: add sparsemem support
Date:   Mon, 31 Aug 2020 09:47:14 +0300
Message-Id: <20200831064714.16562-2-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831064714.16562-1-rppt@kernel.org>
References: <20200831064714.16562-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arc/Kconfig                 | 10 ++++++++++
 arch/arc/include/asm/sparsemem.h | 13 +++++++++++++
 arch/arc/mm/init.c               |  6 +++++-
 3 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100644 arch/arc/include/asm/sparsemem.h

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index ba00c4e1e1c2..2e3c02e9b657 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -48,6 +48,7 @@ config ARC
 	select PCI_SYSCALL if PCI
 	select PERF_USE_VMALLOC if ARC_CACHE_VIPT_ALIASING
 	select HAVE_ARCH_JUMP_LABEL if ISA_ARCV2 && !CPU_ENDIAN_BE32
+	select SPARSEMEM_STATIC if SPARSEMEM
 
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
@@ -67,8 +68,15 @@ config GENERIC_CSUM
 config ARCH_DISCONTIGMEM_ENABLE
 	def_bool n
 
+config ARCH_SPARSEMEM_ENABLE
+	def_bool n
+
 config ARCH_FLATMEM_ENABLE
 	def_bool y
+	depends on !HIGHMEM
+
+config ARCH_SELECT_MEMORY_MODEL
+	def_bool n
 
 config MMU
 	def_bool y
@@ -508,6 +516,8 @@ config LINUX_RAM_BASE
 config HIGHMEM
 	bool "High Memory Support"
 	select ARCH_DISCONTIGMEM_ENABLE
+	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_SELECT_MEMORY_MODEL
 	help
 	  With ARC 2G:2G address split, only upper 2G is directly addressable by
 	  kernel. Enable this to potentially allow access to rest of 2G and PAE
diff --git a/arch/arc/include/asm/sparsemem.h b/arch/arc/include/asm/sparsemem.h
new file mode 100644
index 000000000000..1156b9934c74
--- /dev/null
+++ b/arch/arc/include/asm/sparsemem.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARC_SPARSEMEM_H
+#define _ASM_ARC_SPARSEMEM_H
+
+#ifdef CONFIG_ARC_HAS_PAE40
+#define MAX_PHYSMEM_BITS	40
+#define SECTION_SIZE_BITS	32
+#else
+#define MAX_PHYSMEM_BITS	32
+#define SECTION_SIZE_BITS	27
+#endif
+
+#endif /* _ASM_ARC_SPARSEMEM_H */
diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index 3a35b82a718e..60e3808a4e19 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -153,7 +153,11 @@ void __init setup_arch_memory(void)
 	 * DISCONTIGMEM in turns requires multiple nodes. node 0 above is
 	 * populated with normal memory zone while node 1 only has highmem
 	 */
+#ifdef CONFIG_DISCONTIGMEM
 	node_set_online(1);
+#elif defined(CONFIG_SPARSEMEM)
+	sparse_init();
+#endif
 
 	min_high_pfn = PFN_DOWN(high_mem_start);
 	max_high_pfn = PFN_DOWN(high_mem_start + high_mem_sz);
@@ -162,7 +166,7 @@ void __init setup_arch_memory(void)
 
 	high_memory = (void *)(min_high_pfn << PAGE_SHIFT);
 	kmap_init();
-#endif
+#endif /* CONFIG_HIGHMEM */
 
 	free_area_init(max_zone_pfn);
 }
-- 
2.26.2

