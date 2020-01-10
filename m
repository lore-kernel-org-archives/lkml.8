Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5877BC47409
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 03:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344512077B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 03:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbgAJDI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 22:08:57 -0500
Received: from foss.arm.com ([217.140.110.172]:39012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730952AbgAJDI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 22:08:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFC6E113E;
        Thu,  9 Jan 2020 19:08:56 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.42.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 670D23F703;
        Thu,  9 Jan 2020 19:08:49 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org
Cc:     mark.rutland@arm.com, david@redhat.com, cai@lca.pw,
        logang@deltatee.com, cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de, ard.biesheuvel@arm.com, steve.capper@arm.com,
        broonie@kernel.org, valentin.schneider@arm.com,
        Robin.Murphy@arm.com, steven.price@arm.com, suzuki.poulose@arm.com,
        ira.weiny@intel.com, Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH V11 2/5] mm/memblock: Introduce MEMBLOCK_BOOT flag
Date:   Fri, 10 Jan 2020 08:39:12 +0530
Message-Id: <1578625755-11792-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578625755-11792-1-git-send-email-anshuman.khandual@arm.com>
References: <1578625755-11792-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64 platform boot memory should never be hot removed due to certain
platform specific constraints. Hence the platform would like to override
earlier added arch call back arch_memory_removable() for this purpose. In
order to reject boot memory hot removal request, it needs to first track
them at runtime. In the future, there might be other platforms requiring
runtime boot memory enumeration. Hence lets expand the existing generic
memblock framework for this purpose rather then creating one just for
arm64 platforms.

This introduces a new memblock flag MEMBLOCK_BOOT along with helpers which
can be marked by given platform on all memory regions discovered during
boot.

Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/memblock.h | 10 ++++++++++
 mm/memblock.c            | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index b38bbef..fb04c87 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -31,12 +31,14 @@ extern unsigned long long max_possible_pfn;
  * @MEMBLOCK_HOTPLUG: hotpluggable region
  * @MEMBLOCK_MIRROR: mirrored region
  * @MEMBLOCK_NOMAP: don't add to kernel direct mapping
+ * @MEMBLOCK_BOOT: memory received from firmware during boot
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
 	MEMBLOCK_HOTPLUG	= 0x1,	/* hotpluggable region */
 	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
+	MEMBLOCK_BOOT		= 0x8,	/* memory received from firmware during boot */
 };
 
 /**
@@ -116,6 +118,8 @@ int memblock_reserve(phys_addr_t base, phys_addr_t size);
 void memblock_trim_memory(phys_addr_t align);
 bool memblock_overlaps_region(struct memblock_type *type,
 			      phys_addr_t base, phys_addr_t size);
+int memblock_mark_boot(phys_addr_t base, phys_addr_t size);
+int memblock_clear_boot(phys_addr_t base, phys_addr_t size);
 int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
@@ -216,6 +220,11 @@ static inline bool memblock_is_nomap(struct memblock_region *m)
 	return m->flags & MEMBLOCK_NOMAP;
 }
 
+static inline bool memblock_is_boot(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_BOOT;
+}
+
 #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
@@ -449,6 +458,7 @@ void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
 void memblock_mem_limit_remove_map(phys_addr_t limit);
 bool memblock_is_memory(phys_addr_t addr);
 bool memblock_is_map_memory(phys_addr_t addr);
+bool memblock_is_boot_memory(phys_addr_t addr);
 bool memblock_is_region_memory(phys_addr_t base, phys_addr_t size);
 bool memblock_is_reserved(phys_addr_t addr);
 bool memblock_is_region_reserved(phys_addr_t base, phys_addr_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index 4bc2c7d..e10207f 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -865,6 +865,30 @@ static int __init_memblock memblock_setclr_flag(phys_addr_t base,
 }
 
 /**
+ * memblock_mark_bootmem - Mark boot memory with flag MEMBLOCK_BOOT.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_mark_boot(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(base, size, 1, MEMBLOCK_BOOT);
+}
+
+/**
+ * memblock_clear_bootmem - Clear flag MEMBLOCK_BOOT for a specified region.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_clear_boot(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(base, size, 0, MEMBLOCK_BOOT);
+}
+
+/**
  * memblock_mark_hotplug - Mark hotpluggable memory with flag MEMBLOCK_HOTPLUG.
  * @base: the base phys addr of the region
  * @size: the size of the region
@@ -974,6 +998,10 @@ static bool should_skip_region(struct memblock_region *m, int nid, int flags)
 	if ((flags & MEMBLOCK_MIRROR) && !memblock_is_mirror(m))
 		return true;
 
+	/* if we want boot memory skip non-boot memory regions */
+	if ((flags & MEMBLOCK_BOOT) && !memblock_is_boot(m))
+		return true;
+
 	/* skip nomap memory unless we were asked for it explicitly */
 	if (!(flags & MEMBLOCK_NOMAP) && memblock_is_nomap(m))
 		return true;
@@ -1785,6 +1813,15 @@ bool __init_memblock memblock_is_map_memory(phys_addr_t addr)
 	return !memblock_is_nomap(&memblock.memory.regions[i]);
 }
 
+bool __init_memblock memblock_is_boot_memory(phys_addr_t addr)
+{
+	int i = memblock_search(&memblock.memory, addr);
+
+	if (i == -1)
+		return false;
+	return memblock_is_boot(&memblock.memory.regions[i]);
+}
+
 #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 int __init_memblock memblock_search_pfn_nid(unsigned long pfn,
 			 unsigned long *start_pfn, unsigned long *end_pfn)
-- 
2.7.4

