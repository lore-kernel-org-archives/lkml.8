Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A0DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE5E207D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DgLq9OSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgESUfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:35:03 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:35274 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727924AbgESUfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:35:01 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 2758430D7A9;
        Tue, 19 May 2020 13:33:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 2758430D7A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1589920417;
        bh=ql15htmxWd+skJX12piE6V7RFns3X98Jlpcjg0U7D7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DgLq9OSUu4NoxecsafkoWouuM8+BkMmsFkWG/0w0Ad1IDjT5AHoKibOOA5tgHnGlo
         zbRy0GMUaK3dzx04Onsl5dPmvPVBdXNRff0X0TQDU90DPF3luT1SBreCfdBj/92Wxy
         1roMWrSiJpgofWsTg5Uh0CWY/TywvkiOTDNMknYc=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id D3D82140069;
        Tue, 19 May 2020 13:34:57 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     james.quinlan@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), linux-kernel@vger.kernel.org (open list),
        iommu@lists.linux-foundation.org (open list:DMA MAPPING HELPERS)
Subject: [PATCH 09/15] device core: Add ability to handle multiple dma offsets
Date:   Tue, 19 May 2020 16:34:07 -0400
Message-Id: <20200519203419.12369-10-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519203419.12369-1-james.quinlan@broadcom.com>
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device variable 'dma_pfn_offset' is used to do a single
linear map between cpu addrs and dma addrs.  The variable
'dma_map' is added to struct device to point to an array
of multiple offsets which is required for some devices.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/of/address.c        | 50 ++++++++++++++++++++++++++++++++++---
 include/linux/device.h      |  9 ++++++-
 include/linux/dma-mapping.h | 44 ++++++++++++++++++++++++++++++++
 kernel/dma/Kconfig          | 12 +++++++++
 4 files changed, 111 insertions(+), 4 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 96d8cfb14a60..7dfff618af6a 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -947,6 +947,8 @@ int of_dma_get_range(struct device *dev, struct device_node *np, u64 *dma_addr,
 	struct of_range_parser parser;
 	struct of_range range;
 	u64 dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
+	bool dma_multi_pfn_offset = false;
+	int num_ranges = 0;
 
 	while (node) {
 		ranges = of_get_property(node, "dma-ranges", &len);
@@ -977,10 +979,18 @@ int of_dma_get_range(struct device *dev, struct device_node *np, u64 *dma_addr,
 		pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
 			 range.bus_addr, range.cpu_addr, range.size);
 
+		num_ranges++;
 		if (dma_offset && range.cpu_addr - range.bus_addr != dma_offset) {
-			pr_warn("Can't handle multiple dma-ranges with different offsets on node(%pOF)\n", node);
-			/* Don't error out as we'd break some existing DTs */
-			continue;
+			dma_multi_pfn_offset = true;
+			if (!IS_ENABLED(CONFIG_DMA_PFN_OFFSET_MAP)) {
+				pr_warn("Can't handle multiple dma-ranges with different offsets on node(%pOF)\n", node);
+				/*
+				 * Don't error out as we'd break some
+				 * existing DTs that are using configs
+				 * w/o CONFIG_DMA_PFN_OFFSET_MAP set.
+				 */
+				continue;
+			}
 		}
 		dma_offset = range.cpu_addr - range.bus_addr;
 
@@ -991,6 +1001,40 @@ int of_dma_get_range(struct device *dev, struct device_node *np, u64 *dma_addr,
 			dma_end = range.bus_addr + range.size;
 	}
 
+#ifdef CONFIG_DMA_PFN_OFFSET_MAP
+	if (dma_multi_pfn_offset) {
+		size_t r_size = (num_ranges + 1)
+			* sizeof(struct dma_pfn_offset_region);
+		struct dma_pfn_offset_region *r;
+
+		if (!dev)
+			return -EINVAL;
+
+		dma_offset = 0;
+		r = devm_kcalloc(dev, 1, r_size, GFP_KERNEL);
+		if (!r)
+			return -ENOMEM;
+		dev->dma_offset_map = (const void *) r;
+		of_dma_range_parser_init(&parser, node);
+
+		/*
+		 * Record all info for DMA ranges array.  We could
+		 * just use the of_range struct, but if we did that it
+		 * would require more calculations for phys_to_dma and
+		 * dma_to_phys conversions.
+		 */
+		for_each_of_range(&parser, &range) {
+			r->cpu_beg = range.cpu_addr;
+			r->cpu_end = r->cpu_beg + range.size;
+			r->dma_beg = range.bus_addr;
+			r->dma_end = r->dma_beg + range.size;
+			r->pfn_offset = PFN_DOWN(range.cpu_addr)
+				- PFN_DOWN(range.bus_addr);
+			r++;
+		}
+	}
+#endif
+
 	if (dma_start >= dma_end) {
 		ret = -EINVAL;
 		pr_debug("Invalid DMA ranges configuration on node(%pOF)\n",
diff --git a/include/linux/device.h b/include/linux/device.h
index ac8e37cd716a..6cd916860b5f 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -493,6 +493,8 @@ struct dev_links_info {
  * @bus_dma_limit: Limit of an upstream bridge or bus which imposes a smaller
  *		DMA limit than the device itself supports.
  * @dma_pfn_offset: offset of DMA memory range relatively of RAM
+ * @dma_map:	Like dma_pfn_offset but used when there are multiple
+ *		pfn offsets for multiple dma-ranges.
  * @dma_parms:	A low level driver may set these to teach IOMMU code about
  * 		segment limitations.
  * @dma_pools:	Dma pools (if dma'ble device).
@@ -578,7 +580,12 @@ struct device {
 					     allocations such descriptors. */
 	u64		bus_dma_limit;	/* upstream dma constraint */
 	unsigned long	dma_pfn_offset;
-
+#ifdef CONFIG_DMA_PFN_OFFSET_MAP
+	const void *dma_offset_map;	/* Like dma_pfn_offset, but for
+					 * the unlikely case of multiple
+					 * offsets. If non-null, dma_pfn_offset
+					 * will be 0. */
+#endif
 	struct device_dma_parameters *dma_parms;
 
 	struct list_head	dma_pools;	/* dma pools (if dma'ble) */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 330ad58fbf4d..288d8089faf7 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -256,6 +256,38 @@ static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
 size_t dma_direct_max_mapping_size(struct device *dev);
 
 #ifdef CONFIG_HAS_DMA
+#ifdef CONFIG_DMA_PFN_OFFSET_MAP
+struct dma_pfn_offset_region {
+	phys_addr_t	cpu_beg;
+	phys_addr_t	cpu_end;
+	dma_addr_t	dma_beg;
+	dma_addr_t	dma_end;
+	unsigned long	pfn_offset;
+};
+
+static inline unsigned long dma_pfn_offset_frm_dma_addr(const void *arr,
+							dma_addr_t dma_addr)
+{
+	const struct dma_pfn_offset_region *m;
+
+	for (m = arr; m->cpu_end; m++)
+		if (dma_addr >= m->dma_beg && dma_addr < m->dma_end)
+			return m->pfn_offset;
+	return 0;
+}
+
+static inline unsigned long dma_pfn_offset_frm_phys_addr(const void *arr,
+							 phys_addr_t paddr)
+{
+	const struct dma_pfn_offset_region *m;
+
+	for (m = arr; m->cpu_end; m++)
+		if (paddr >= m->cpu_beg && paddr < m->cpu_end)
+			return m->pfn_offset;
+	return 0;
+}
+#endif /* CONFIG_DMA_PFN_OFFSET_MAP */
+
 #include <asm/dma-mapping.h>
 
 static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
@@ -575,6 +607,18 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
 {
 	return 0;
 }
+#ifdef CONFIG_DMA_PFN_OFFSET_MAP
+static inline unsigned long dma_pfn_offset_frm_dma_addr(const void *arr,
+							dma_addr_t dma_addr)
+{
+	return 0;
+}
+static inline unsigned long dma_pfn_offset_frm_phys_addr(const void *arr,
+							 phys_addr_t paddr)
+{
+	return 0;
+}
+#endif /* CONFIG_DMA_PFN_OFFSET_MAP */
 #endif /* CONFIG_HAS_DMA */
 
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 4c103a24e380..b4c3de521bf9 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -195,3 +195,15 @@ config DMA_API_DEBUG_SG
 	  is technically out-of-spec.
 
 	  If unsure, say N.
+
+config DMA_PFN_OFFSET_MAP
+	bool "Uses a DMA range map to calculate PFN offset"
+	default n
+	help
+	  Some devices have a dma-range that gets converted to
+	  a dev->dma_pfn_offset value.  This option is for the
+	  atypical case of there being multiple dma-ranges requiring
+	  multiple pfn offsets, which are selected from when
+	  converting to phys to dma and vice versa.
+
+	  If unsure, say N.
-- 
2.17.1

