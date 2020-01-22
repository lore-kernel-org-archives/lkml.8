Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DCDC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 03:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7CA2467A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 03:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgAVDVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 22:21:06 -0500
Received: from mga14.intel.com ([192.55.52.115]:5875 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbgAVDVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 22:21:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 19:21:04 -0800
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="307405652"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 19:21:03 -0800
Subject: [PATCH v4 5/6] x86/numa: Provide a range-to-target_node lookup
 facility
From:   Dan Williams <dan.j.williams@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        kbuild test robot <lkp@intel.com>, vishal.l.verma@intel.com,
        hch@lst.de, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, x86@kernel.org
Date:   Tue, 21 Jan 2020 19:05:01 -0800
Message-ID: <157966230092.2508551.3905721944859436879.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DEV_DAX_KMEM facility is a generic mechanism to allow device-dax
instances, fronting performance-differentiated-memory like pmem, to be
added to the System RAM pool. The numa node for that hot-added memory is
derived from the device-dax instance's 'target_node' attribute.

Recall that the 'target_node' is the ACPI-PXM-to-node translation for
memory when it comes online whereas the 'numa_node' attribute of the
device represents the closest online cpu node.

Presently useful target_node information from the ACPI SRAT is discarded
with the expectation that "Reserved" memory will never be onlined. Now,
DEV_DAX_KMEM violates that assumption, there is a need to retain the
translation. Move, rather than discard, numa_memblk data to a secondary
array that memory_add_physaddr_to_target_node() may consider at a later
point in time.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/numa.c   |   68 +++++++++++++++++++++++++++++++++++++++++++-------
 include/linux/numa.h |    8 +++++-
 mm/mempolicy.c       |    5 ++++
 3 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 5289d9d6799a..f2c8fca36f28 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -26,6 +26,7 @@ struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
 EXPORT_SYMBOL(node_data);
 
 static struct numa_meminfo numa_meminfo __initdata_numa;
+static struct numa_meminfo numa_reserved_meminfo __initdata_numa;
 
 static int numa_distance_cnt;
 static u8 *numa_distance;
@@ -164,6 +165,26 @@ void __init numa_remove_memblk_from(int idx, struct numa_meminfo *mi)
 		(mi->nr_blks - idx) * sizeof(mi->blk[0]));
 }
 
+/**
+ * numa_move_memblk - Move one numa_memblk from one numa_meminfo to another
+ * @dst: numa_meminfo to move block to
+ * @idx: Index of memblk to remove
+ * @src: numa_meminfo to remove memblk from
+ *
+ * If @dst is non-NULL add it at the @dst->nr_blks index and increment
+ * @dst->nr_blks, then remove it from @src.
+ */
+static void __init numa_move_memblk(struct numa_meminfo *dst, int idx,
+		struct numa_meminfo *src)
+{
+	if (dst) {
+		memcpy(&dst->blk[dst->nr_blks], &src->blk[idx],
+				sizeof(struct numa_memblk));
+		dst->nr_blks++;
+	}
+	numa_remove_memblk_from(idx, src);
+}
+
 /**
  * numa_add_memblk - Add one numa_memblk to numa_meminfo
  * @nid: NUMA node ID of the new memblk
@@ -233,14 +254,19 @@ int __init numa_cleanup_meminfo(struct numa_meminfo *mi)
 	for (i = 0; i < mi->nr_blks; i++) {
 		struct numa_memblk *bi = &mi->blk[i];
 
-		/* make sure all blocks are inside the limits */
+		/* move / save reserved memory ranges */
+		if (!memblock_overlaps_region(&memblock.memory,
+					bi->start, bi->end - bi->start)) {
+			numa_move_memblk(&numa_reserved_meminfo, i--, mi);
+			continue;
+		}
+
+		/* make sure all non-reserved blocks are inside the limits */
 		bi->start = max(bi->start, low);
 		bi->end = min(bi->end, high);
 
-		/* and there's no empty or non-exist block */
-		if (bi->start >= bi->end ||
-		    !memblock_overlaps_region(&memblock.memory,
-			bi->start, bi->end - bi->start))
+		/* and there's no empty block */
+		if (bi->start >= bi->end)
 			numa_remove_memblk_from(i--, mi);
 	}
 
@@ -877,16 +903,38 @@ EXPORT_SYMBOL(cpumask_of_node);
 
 #endif	/* !CONFIG_DEBUG_PER_CPU_MAPS */
 
-#ifdef CONFIG_MEMORY_HOTPLUG
-int memory_add_physaddr_to_nid(u64 start)
+#ifdef CONFIG_KEEP_NUMA
+static int meminfo_to_nid(struct numa_meminfo *mi, u64 start)
 {
-	struct numa_meminfo *mi = &numa_meminfo;
-	int nid = mi->blk[0].nid;
 	int i;
 
 	for (i = 0; i < mi->nr_blks; i++)
 		if (mi->blk[i].start <= start && mi->blk[i].end > start)
-			nid = mi->blk[i].nid;
+			return mi->blk[i].nid;
+	return NUMA_NO_NODE;
+}
+
+int phys_to_target_node(phys_addr_t start)
+{
+	int nid = meminfo_to_nid(&numa_meminfo, start);
+
+	/*
+	 * Prefer online nodes, but if reserved memory might be
+	 * hot-added continue the search with reserved ranges.
+	 */
+	if (nid != NUMA_NO_NODE)
+		return nid;
+
+	return meminfo_to_nid(&numa_reserved_meminfo, start);
+}
+EXPORT_SYMBOL_GPL(phys_to_target_node);
+
+int memory_add_physaddr_to_nid(u64 start)
+{
+	int nid = meminfo_to_nid(&numa_meminfo, start);
+
+	if (nid == NUMA_NO_NODE)
+		nid = numa_meminfo.blk[0].nid;
 	return nid;
 }
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
diff --git a/include/linux/numa.h b/include/linux/numa.h
index c005ed6b807b..cad0ab165619 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_NUMA_H
 #define _LINUX_NUMA_H
-
+#include <linux/types.h>
 
 #ifdef CONFIG_NODES_SHIFT
 #define NODES_SHIFT     CONFIG_NODES_SHIFT
@@ -21,11 +21,17 @@
 
 #ifdef CONFIG_NUMA
 int numa_map_to_online_node(int node);
+int phys_to_target_node(phys_addr_t addr);
 #else
 static inline int numa_map_to_online_node(int node)
 {
 	return NUMA_NO_NODE;
 }
+
+static inline int phys_to_target_node(phys_addr_t addr)
+{
+	return NUMA_NO_NODE;
+}
 #endif
 
 #endif /* _LINUX_NUMA_H */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index bcb012645809..ed376d57e527 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3011,3 +3011,8 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 		p += scnprintf(p, buffer + maxlen - p, ":%*pbl",
 			       nodemask_pr_args(&nodes));
 }
+
+__weak int phys_to_target_node(phys_addr_t addr)
+{
+	return NUMA_NO_NODE;
+}

