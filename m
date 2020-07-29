Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F79C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD2A22B49
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgG2Dfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:35:37 -0400
Received: from foss.arm.com ([217.140.110.172]:44600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgG2Dfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 23:35:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CA4631B;
        Tue, 28 Jul 2020 20:35:36 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.212.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A161E3F66E;
        Tue, 28 Jul 2020 20:35:28 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        Wei Yang <richardw.yang@linux.intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, Kaly Xin <Kaly.Xin@arm.com>,
        Jia He <justin.he@arm.com>
Subject: [RFC PATCH 3/6] mm/memory_hotplug: allow pmem kmem not to align with memory_block_size
Date:   Wed, 29 Jul 2020 11:34:21 +0800
Message-Id: <20200729033424.2629-4-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729033424.2629-1-justin.he@arm.com>
References: <20200729033424.2629-1-justin.he@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dax pmem is probed as RAM device on arm64, previously, kmem_start in
dev_dax_kmem_probe() should be aligned with 1G memblock size on arm64 due
to SECTION_SIZE_BITS(30).

There will be some meta data at the beginning/end of the iomem space, e.g.
namespace info and nvdimm label:
240000000-33fdfffff : Persistent Memory
  240000000-2403fffff : namespace0.0
  280000000-2bfffffff : dax0.0
    280000000-2bfffffff : System RAM

Hence it makes the whole kmem space not aligned with memory_block_size for
both start addr and end addr. Hence there is a big gap when kmem is added
into memory block which causes big memory space wasting.

This changes it by relaxing the alignment check for dax pmem kmem in the
path of online/offline memory blocks.

Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/base/memory.c | 16 ++++++++++++++++
 mm/memory_hotplug.c   | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 4a1691664c6c..3d2a94f3b1d9 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -334,6 +334,22 @@ static ssize_t valid_zones_show(struct device *dev,
 	 * online nodes otherwise the page_zone is not reliable
 	 */
 	if (mem->state == MEM_ONLINE) {
+#ifdef CONFIG_ZONE_DEVICE
+		struct resource res;
+		int ret;
+
+		/* adjust start_pfn for dax pmem kmem */
+		ret = find_next_iomem_res(start_pfn << PAGE_SHIFT,
+					((start_pfn + nr_pages) << PAGE_SHIFT) - 1,
+					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+					IORES_DESC_PERSISTENT_MEMORY,
+					false, &res);
+		if (!ret && PFN_UP(res.start) > start_pfn) {
+			nr_pages -= PFN_UP(res.start) - start_pfn;
+			start_pfn = PFN_UP(res.start);
+		}
+#endif
+
 		/*
 		 * The block contains more than one zone can not be offlined.
 		 * This can happen e.g. for ZONE_DMA and ZONE_DMA32
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a53103dc292b..25745f67b680 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -999,6 +999,20 @@ int try_online_node(int nid)
 
 static int check_hotplug_memory_range(u64 start, u64 size)
 {
+#ifdef CONFIG_ZONE_DEVICE
+	struct resource res;
+	int ret;
+
+	/* Allow pmem kmem not to align with block size */
+	ret = find_next_iomem_res(start, start + size - 1,
+				IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+				IORES_DESC_PERSISTENT_MEMORY,
+				false, &res);
+	if (!ret) {
+		return 0;
+	}
+#endif
+
 	/* memory range must be block size aligned */
 	if (!size || !IS_ALIGNED(start, memory_block_size_bytes()) ||
 	    !IS_ALIGNED(size, memory_block_size_bytes())) {
@@ -1481,19 +1495,42 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	mem_hotplug_begin();
 
 	/*
-	 * Don't allow to offline memory blocks that contain holes.
+	 * Don't allow to offline memory blocks that contain holes except
+	 * for pmem.
 	 * Consequently, memory blocks with holes can never get onlined
 	 * via the hotplug path - online_pages() - as hotplugged memory has
 	 * no holes. This way, we e.g., don't have to worry about marking
 	 * memory holes PG_reserved, don't need pfn_valid() checks, and can
 	 * avoid using walk_system_ram_range() later.
+	 * When dax pmem is used as RAM (kmem), holes at the beginning is
+	 * allowed.
 	 */
 	walk_system_ram_range(start_pfn, end_pfn - start_pfn, &nr_pages,
 			      count_system_ram_pages_cb);
 	if (nr_pages != end_pfn - start_pfn) {
+#ifdef CONFIG_ZONE_DEVICE
+		struct resource res;
+
+		/* Allow pmem kmem not to align with block size */
+		ret = find_next_iomem_res(start_pfn << PAGE_SHIFT,
+					(end_pfn << PAGE_SHIFT) - 1,
+					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+					IORES_DESC_PERSISTENT_MEMORY,
+					false, &res);
+		if (ret) {
+			ret = -EINVAL;
+			reason = "memory holes";
+			goto failed_removal;
+		}
+
+		/* adjust start_pfn for dax pmem kmem */
+		start_pfn = PFN_UP(res.start);
+		end_pfn = PFN_DOWN(res.end + 1);
+#else
 		ret = -EINVAL;
 		reason = "memory holes";
 		goto failed_removal;
+#endif
 	}
 
 	/* This makes hotplug much easier...and readable.
-- 
2.17.1

