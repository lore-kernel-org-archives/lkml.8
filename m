Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC53AC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 00:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D56A20719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 00:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgCXALD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 20:11:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:27967 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbgCXALD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 20:11:03 -0400
IronPort-SDR: kthA3pRPe7AgE0SUK1QCaQkNkvwXmg3gZOG5xJrLljt9wGqWhI5N1XXIU8I7qQ4OG5savcsSF8
 HuJnP41uSqZQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:11:02 -0700
IronPort-SDR: o7Q8jiHtwpNBIgs6DkiSX7vQ6yTPDOWz5sCBFIqFRyOToLtJ+htwlqGuSn/6rLEn1lW073F0dk
 E9Xol9yACspQ==
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="238050189"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:11:01 -0700
Subject: [PATCH 04/12] device-dax: Kill dax_kmem_res
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, hch@lst.de,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        jmoyer@redhat.com
Date:   Mon, 23 Mar 2020 16:54:54 -0700
Message-ID: <158500769438.2088294.11339134986537700302.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several related issues around this unneeded attribute:

- The dax_kmem_res property allows the kmem driver to stash the adjusted
  resource range that was used for the hotplug operation, but that can be
  recalculated from the original base range.

- kmem is using an open coded release_resource() + kfree() when an
  idiomatic release_mem_region() is sufficient.

- The driver managed resource need only manage the busy flag. Other flags
  are of no concern to the kmem driver. In fact if kmem inherits some
  memory range that add_memory() rejects that is a memory-hotplug-core
  policy that the driver is in no position to override.

- The implementation trusts that failed remove_memory() results in the
  entire resource range remaining pinned busy. The driver need not make
  that layering violation assumption and just maintain the busy state in
  its local resource.

- The "Hot-remove not yet implemented." comment is stale as of commit
  9f960da72b25 ("device-dax: "Hotremove" persistent memory that is used
  like normal RAM")

Cc: David Hildenbrand <david@redhat.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/dax-private.h |    2 -
 drivers/dax/kmem.c        |  104 +++++++++++++++++++--------------------------
 2 files changed, 43 insertions(+), 63 deletions(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 22d43095559a..12a2dbc43b40 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -42,7 +42,6 @@ struct dax_region {
  * @dev - device core
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
  * @range: resource range for the instance
- * @dax_mem_res: physical address range of hotadded DAX memory
  */
 struct dev_dax {
 	struct dax_region *region;
@@ -51,7 +50,6 @@ struct dev_dax {
 	struct device dev;
 	struct dev_pagemap *pgmap;
 	struct range range;
-	struct resource *dax_kmem_res;
 };
 
 static inline u64 range_len(struct range *range)
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 111e4c06ff49..2bb7fa0951ef 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -14,15 +14,23 @@
 #include "dax-private.h"
 #include "bus.h"
 
+static struct range dax_kmem_range(struct dev_dax *dev_dax)
+{
+	struct range range;
+
+	/* memory-block align the hotplug range */
+	range.start = ALIGN(dev_dax->range.start, memory_block_size_bytes());
+	range.end = ALIGN_DOWN(dev_dax->range.end + 1,
+			memory_block_size_bytes()) - 1;
+	return range;
+}
+
 int dev_dax_kmem_probe(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
-	struct range *range = &dev_dax->range;
-	resource_size_t kmem_start;
-	resource_size_t kmem_size;
-	resource_size_t kmem_end;
-	struct resource *new_res;
-	int numa_node;
+	struct range range = dax_kmem_range(dev_dax);
+	int numa_node = dev_dax->target_node;
+	struct resource *res;
 	int rc;
 
 	/*
@@ -31,95 +39,69 @@ int dev_dax_kmem_probe(struct device *dev)
 	 * could be mixed in a node with faster memory, causing
 	 * unavoidable performance issues.
 	 */
-	numa_node = dev_dax->target_node;
 	if (numa_node < 0) {
 		dev_warn(dev, "rejecting DAX region with invalid node: %d\n",
 				numa_node);
 		return -EINVAL;
 	}
 
-	/* Hotplug starting at the beginning of the next block: */
-	kmem_start = ALIGN(range->start, memory_block_size_bytes());
-
-	kmem_size = range_len(range);
-	/* Adjust the size down to compensate for moving up kmem_start: */
-	kmem_size -= kmem_start - range->start;
-	/* Align the size down to cover only complete blocks: */
-	kmem_size &= ~(memory_block_size_bytes() - 1);
-	kmem_end = kmem_start + kmem_size;
-
-	/* Region is permanently reserved.  Hot-remove not yet implemented. */
-	new_res = request_mem_region(kmem_start, kmem_size, dev_name(dev));
-	if (!new_res) {
-		dev_warn(dev, "could not reserve region [%pa-%pa]\n",
-			 &kmem_start, &kmem_end);
+	res = request_mem_region(range.start, range_len(&range), dev_name(dev));
+	if (!res) {
+		dev_warn(dev, "could not reserve region [%#llx-%#llx]\n",
+				range.start, range.end);
 		return -EBUSY;
 	}
 
-	/*
-	 * Set flags appropriate for System RAM.  Leave ..._BUSY clear
-	 * so that add_memory() can add a child resource.  Do not
-	 * inherit flags from the parent since it may set new flags
-	 * unknown to us that will break add_memory() below.
-	 */
-	new_res->flags = IORESOURCE_SYSTEM_RAM;
-	new_res->name = dev_name(dev);
-
-	rc = add_memory(numa_node, new_res->start, resource_size(new_res));
+	/* Temporarily clear busy to allow add_memory() to claim it */
+	res->flags &= ~IORESOURCE_BUSY;
+	rc = add_memory(numa_node, range.start, range_len(&range));
+	res->flags |= IORESOURCE_BUSY;
 	if (rc) {
-		release_resource(new_res);
-		kfree(new_res);
+		release_mem_region(range.start, range_len(&range));
 		return rc;
 	}
-	dev_dax->dax_kmem_res = new_res;
 
 	return 0;
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-static int dev_dax_kmem_remove(struct device *dev)
+static void dax_kmem_release(struct dev_dax *dev_dax)
 {
-	struct dev_dax *dev_dax = to_dev_dax(dev);
-	struct resource *res = dev_dax->dax_kmem_res;
-	resource_size_t kmem_start = res->start;
-	resource_size_t kmem_size = resource_size(res);
+	struct range range = dax_kmem_range(dev_dax);
 	int rc;
 
 	/*
 	 * We have one shot for removing memory, if some memory blocks were not
 	 * offline prior to calling this function remove_memory() will fail, and
 	 * there is no way to hotremove this memory until reboot because device
-	 * unbind will succeed even if we return failure.
+	 * unbind will proceed regardless of the remove_memory result.
 	 */
-	rc = remove_memory(dev_dax->target_node, kmem_start, kmem_size);
-	if (rc) {
-		dev_err(dev,
-			"DAX region %pR cannot be hotremoved until the next reboot\n",
-			res);
-		return rc;
+	rc = remove_memory(dev_dax->target_node, range.start, range_len(&range));
+	if (rc == 0) {
+		release_mem_region(range.start, range_len(&range));
+		return;
 	}
-
-	/* Release and free dax resources */
-	release_resource(res);
-	kfree(res);
-	dev_dax->dax_kmem_res = NULL;
-
-	return 0;
+	dev_err(&dev_dax->dev, "%#llx-%#llx cannot be hotremoved until the next reboot\n",
+			range.start, range.end);
 }
 #else
-static int dev_dax_kmem_remove(struct device *dev)
+static void dax_kmem_release(struct dev_dax *dev_dax)
 {
 	/*
-	 * Without hotremove purposely leak the request_mem_region() for the
-	 * device-dax range and return '0' to ->remove() attempts. The removal
-	 * of the device from the driver always succeeds, but the region is
-	 * permanently pinned as reserved by the unreleased
-	 * request_mem_region().
+	 * Without hotremove purposely leak the request_mem_region() for
+	 * the device-dax range attempts. The removal of the device from
+	 * the driver always succeeds, but the region is permanently
+	 * pinned as reserved by the unreleased request_mem_region().
 	 */
-	return 0;
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
+static int dev_dax_kmem_remove(struct device *dev)
+{
+	dax_kmem_release(to_dev_dax(dev));
+	return 0;
+}
+
 static struct dax_device_driver device_dax_kmem_driver = {
 	.drv = {
 		.probe = dev_dax_kmem_probe,

