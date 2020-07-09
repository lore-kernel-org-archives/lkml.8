Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF97C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2ED320786
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594302265;
	bh=KWLKUQZ1jRMvThE8wuD9eO8Q9wMcE9HKK2fJnQpGhbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XK6MhYn2sWIhhMUDiXQ7HmPp3Ou6M8dlX1a6OvJz4ySL328TNdG/wxa4w78ytQyOG
	 AhwLxLWu+4j81Xm5v6n9uZv+wYdX+tW2nElaa8Czfnv1A5gis24cMKR3hqofBeH+m4
	 WBqI5skSpb63xo8Kcblfyyi4Fj2pk8x2CGtq27AQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGINoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgGINoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:44:21 -0400
Received: from hump.s81c.com (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48F92207BB;
        Thu,  9 Jul 2020 13:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594302261;
        bh=KWLKUQZ1jRMvThE8wuD9eO8Q9wMcE9HKK2fJnQpGhbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JSMwAEJnnf6L1MMk4Z3QAcBVV1WuTyo0PWk2LcirjKvWuYI26+Ol6sLp1Ieueu1/R
         e8FOZZhpqO6LrRrKeJxN/vV8yz9OQOPb5MMt0baL4/Xew/d6mVR70gmTcRRj0OLlXQ
         sdmcNqQrvuF2uLl6n14a4GShZ/0tJw1iIeUhCaZ8=
From:   Mike Rapoport <rppt@kernel.org>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Mike Rapoport <rppt@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [RFC/RFT PATCH v2 1/1] arc: add sparsemem support
Date:   Thu,  9 Jul 2020 16:44:12 +0300
Message-Id: <20200709134412.1464453-2-rppt@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200709134412.1464453-1-rppt@kernel.org>
References: <20200709134412.1464453-1-rppt@kernel.org>
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
 arch/arc/mm/init.c               |  7 ++++++-
 3 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 arch/arc/include/asm/sparsemem.h

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 197896cfbd23..a3e4f9cc2fe7 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -49,6 +49,7 @@ config ARC
 	select PCI_SYSCALL if PCI
 	select PERF_USE_VMALLOC if ARC_CACHE_VIPT_ALIASING
 	select HAVE_ARCH_JUMP_LABEL if ISA_ARCV2 && !CPU_ENDIAN_BE32
+	select SPARSEMEM_STATIC if SPARSEMEM
 
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
@@ -68,8 +69,15 @@ config GENERIC_CSUM
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
@@ -509,6 +517,8 @@ config LINUX_RAM_BASE
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
index 000000000000..b23bedd9d6f0
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
+#define SECTION_SIZE_BITS	31
+#endif
+
+#endif /* _ASM_ARC_SPARSEMEM_H */
diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index e7bdc2ac1c87..eee8794aa172 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -153,7 +153,12 @@ void __init setup_arch_memory(void)
 	 * DISCONTIGMEM in turns requires multiple nodes. node 0 above is
 	 * populated with normal memory zone while node 1 only has highmem
 	 */
+#ifdef CONFIG_DISCONTIGMEM
 	node_set_online(1);
+#elif defined(CONFIG_SPARSEMEM)
+	memblocks_present();
+	sparse_init();
+#endif
 
 	min_high_pfn = PFN_DOWN(high_mem_start);
 	max_high_pfn = PFN_DOWN(high_mem_start + high_mem_sz);
@@ -162,7 +167,7 @@ void __init setup_arch_memory(void)
 
 	high_memory = (void *)(min_high_pfn << PAGE_SHIFT);
 	kmap_init();
-#endif
+#endif /* CONFIG_HIGHMEM */
 
 	free_area_init(max_zone_pfn);
 }
-- 
2.26.2

