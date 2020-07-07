Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC364C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B04A520773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgGGF7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 01:59:43 -0400
Received: from foss.arm.com ([217.140.110.172]:49966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbgGGF7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 01:59:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6489531B;
        Mon,  6 Jul 2020 22:59:42 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.212.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B5C823F68F;
        Mon,  6 Jul 2020 22:59:37 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        Kaly Xin <Kaly.Xin@arm.com>, Jia He <justin.he@arm.com>
Subject: [RFC PATCH v2 2/3] device-dax: use fallback nid when numa_node is invalid
Date:   Tue,  7 Jul 2020 13:59:16 +0800
Message-Id: <20200707055917.143653-3-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200707055917.143653-1-justin.he@arm.com>
References: <20200707055917.143653-1-justin.he@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, numa_off is set unconditionally at the end of dummy_numa_init(),
even with a fake numa node. Then ACPI detects node id as NUMA_NO_NODE(-1) in
acpi_map_pxm_to_node() because it regards numa_off as turning off the numa
node. Hence dev_dax->target_node is NUMA_NO_NODE on arm64 with fake numa.

Without this patch, pmem can't be probed as a RAM device on arm64 if SRAT table
isn't present:
$ndctl create-namespace -fe namespace0.0 --mode=devdax --map=dev -s 1g -a 64K
kmem dax0.0: rejecting DAX region [mem 0x240400000-0x2bfffffff] with invalid node: -1
kmem: probe of dax0.0 failed with error -22

This fixes it by using fallback memory_add_physaddr_to_nid() as nid.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Jia He <justin.he@arm.com>
---
I noticed that on powerpc memory_add_physaddr_to_nid is not exported for module
driver. Set it to RFC due to this concern.

 drivers/dax/kmem.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 275aa5f87399..68e693ca6d59 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -28,20 +28,22 @@ int dev_dax_kmem_probe(struct device *dev)
 	resource_size_t kmem_end;
 	struct resource *new_res;
 	const char *new_res_name;
-	int numa_node;
+	int numa_node, new_node;
 	int rc;
 
 	/*
 	 * Ensure good NUMA information for the persistent memory.
-	 * Without this check, there is a risk that slow memory
-	 * could be mixed in a node with faster memory, causing
-	 * unavoidable performance issues.
+	 * Without this check, there is a risk but not fatal that slow
+	 * memory could be mixed in a node with faster memory, causing
+	 * unavoidable performance issues. Furthermore, fallback node
+	 * id can be used when numa_node is invalid.
 	 */
 	numa_node = dev_dax->target_node;
 	if (numa_node < 0) {
-		dev_warn(dev, "rejecting DAX region %pR with invalid node: %d\n",
-			 res, numa_node);
-		return -EINVAL;
+		new_node = memory_add_physaddr_to_nid(kmem_start);
+		dev_info(dev, "changing nid from %d to %d for DAX region %pR\n",
+			numa_node, new_node, res);
+		numa_node = new_node;
 	}
 
 	/* Hotplug starting at the beginning of the next block: */
@@ -100,6 +102,7 @@ static int dev_dax_kmem_remove(struct device *dev)
 	resource_size_t kmem_start = res->start;
 	resource_size_t kmem_size = resource_size(res);
 	const char *res_name = res->name;
+	int numa_node = dev_dax->target_node;
 	int rc;
 
 	/*
@@ -108,7 +111,10 @@ static int dev_dax_kmem_remove(struct device *dev)
 	 * there is no way to hotremove this memory until reboot because device
 	 * unbind will succeed even if we return failure.
 	 */
-	rc = remove_memory(dev_dax->target_node, kmem_start, kmem_size);
+	if (numa_node < 0)
+		numa_node = memory_add_physaddr_to_nid(kmem_start);
+
+	rc = remove_memory(numa_node, kmem_start, kmem_size);
 	if (rc) {
 		any_hotremove_failed = true;
 		dev_err(dev,
-- 
2.17.1

