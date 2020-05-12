Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32524C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11297206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgELOsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:48:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:35628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgELOsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:48:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 24BEEAC58;
        Tue, 12 May 2020 14:48:43 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     swarren@wwwdotorg.org, robh+dt@kernel.org, robin.murphy@arm.com
Cc:     devicetree@vger.kernel.org, talho@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, afaerber@suse.de,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH 1/4] misc: sram: add support for remapping reserved regions only
Date:   Tue, 12 May 2020 16:48:00 +0200
Message-Id: <20200512144803.24344-1-ykaukab@suse.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SRAM kernel users may be interested in SRAM’s reserved regions
only, though a bigger SRAM is available on the platform. Add an
optional flag 'reserved-only' which allows to ioremap reserved regions
only. Rest of SRAM is not remapped. ioremap type is selected depending
upon no-memory-wc as usual.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
*Tested only on Jetson TX2. Jetson AGX Xavier is untested.*

 drivers/misc/sram.c | 73 ++++++++++++++++++++++++++++++++++-----------
 drivers/misc/sram.h |  3 ++
 2 files changed, 58 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index 6c1a23cb3e8c..44e459f39e22 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -97,7 +97,7 @@ static int sram_add_partition(struct sram_dev *sram, struct sram_reserve *block,
 	struct sram_partition *part = &sram->partition[sram->partitions];
 
 	mutex_init(&part->lock);
-	part->base = sram->virt_base + block->start;
+	part->base = block->virt_start;
 
 	if (block->pool) {
 		ret = sram_add_pool(sram, block, start, part);
@@ -153,6 +153,25 @@ static int sram_reserve_cmp(void *priv, struct list_head *a,
 	return ra->start - rb->start;
 }
 
+static int sram_remap_resource(struct sram_dev *sram,
+		struct resource *res, void __iomem **virt)
+{
+	void __iomem *addr;
+
+	if (sram->no_memory_wc)
+		addr = devm_ioremap_resource(sram->dev, res);
+	else
+		addr = devm_ioremap_resource_wc(sram->dev, res);
+
+	if (IS_ERR(addr)) {
+		dev_err(sram->dev, "could not map SRAM region\n");
+		return PTR_ERR(addr);
+	}
+
+	*virt = addr;
+	return 0;
+}
+
 static int sram_reserve_regions(struct sram_dev *sram, struct resource *res)
 {
 	struct device_node *np = sram->dev->of_node, *child;
@@ -239,6 +258,16 @@ static int sram_reserve_regions(struct sram_dev *sram, struct resource *res)
 				block->start, block->start + block->size);
 		}
 
+		/* ioremap reserved block as whole sram is not remapped */
+		if (sram->reserved_only) {
+			ret = sram_remap_resource(sram, &child_res,
+					&block->virt_start);
+			if (ret)
+				goto err_chunks;
+		} else {
+			block->virt_start = sram->virt_base + block->start;
+		}
+
 		block++;
 	}
 	child = NULL;
@@ -282,8 +311,11 @@ static int sram_reserve_regions(struct sram_dev *sram, struct resource *res)
 			}
 		}
 
-		/* current start is in a reserved block, so continue after it */
-		if (block->start == cur_start) {
+		/*
+		 * Current start is in a reserved block, so continue after it.
+		 * Or if only using reserved blocks
+		 */
+		if (block->start == cur_start || sram->reserved_only) {
 			cur_start = block->start + block->size;
 			continue;
 		}
@@ -342,6 +374,7 @@ static int sram_probe(struct platform_device *pdev)
 	struct sram_dev *sram;
 	int ret;
 	int (*init_func)(void);
+	struct resource *res;
 
 	sram = devm_kzalloc(&pdev->dev, sizeof(*sram), GFP_KERNEL);
 	if (!sram)
@@ -349,19 +382,22 @@ static int sram_probe(struct platform_device *pdev)
 
 	sram->dev = &pdev->dev;
 
-	if (of_property_read_bool(pdev->dev.of_node, "no-memory-wc"))
-		sram->virt_base = devm_platform_ioremap_resource(pdev, 0);
-	else
-		sram->virt_base = devm_platform_ioremap_resource_wc(pdev, 0);
-	if (IS_ERR(sram->virt_base)) {
-		dev_err(&pdev->dev, "could not map SRAM registers\n");
-		return PTR_ERR(sram->virt_base);
-	}
+	sram->no_memory_wc =
+		of_property_read_bool(pdev->dev.of_node, "no-memory-wc");
+	sram->reserved_only =
+		of_property_read_bool(pdev->dev.of_node, "reserved-only");
 
-	sram->pool = devm_gen_pool_create(sram->dev, ilog2(SRAM_GRANULARITY),
-					  NUMA_NO_NODE, NULL);
-	if (IS_ERR(sram->pool))
-		return PTR_ERR(sram->pool);
+	if (!sram->reserved_only) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		ret = sram_remap_resource(sram, res, &sram->virt_base);
+		if (ret)
+			return ret;
+
+		sram->pool = devm_gen_pool_create(sram->dev,
+				ilog2(SRAM_GRANULARITY), NUMA_NO_NODE, NULL);
+		if (IS_ERR(sram->pool))
+			return PTR_ERR(sram->pool);
+	}
 
 	sram->clk = devm_clk_get(sram->dev, NULL);
 	if (IS_ERR(sram->clk))
@@ -383,8 +419,9 @@ static int sram_probe(struct platform_device *pdev)
 			goto err_free_partitions;
 	}
 
-	dev_dbg(sram->dev, "SRAM pool: %zu KiB @ 0x%p\n",
-		gen_pool_size(sram->pool) / 1024, sram->virt_base);
+	if (sram->pool)
+		dev_dbg(sram->dev, "SRAM pool: %zu KiB @ 0x%p\n",
+			gen_pool_size(sram->pool) / 1024, sram->virt_base);
 
 	return 0;
 
@@ -403,7 +440,7 @@ static int sram_remove(struct platform_device *pdev)
 
 	sram_free_partitions(sram);
 
-	if (gen_pool_avail(sram->pool) < gen_pool_size(sram->pool))
+	if (sram->pool && gen_pool_avail(sram->pool) < gen_pool_size(sram->pool))
 		dev_err(sram->dev, "removed while SRAM allocated\n");
 
 	if (sram->clk)
diff --git a/drivers/misc/sram.h b/drivers/misc/sram.h
index 9c1d21ff7347..a485fa29458b 100644
--- a/drivers/misc/sram.h
+++ b/drivers/misc/sram.h
@@ -23,6 +23,8 @@ struct sram_dev {
 
 	struct sram_partition *partition;
 	u32 partitions;
+	bool no_memory_wc;
+	bool reserved_only;
 };
 
 struct sram_reserve {
@@ -33,6 +35,7 @@ struct sram_reserve {
 	bool pool;
 	bool protect_exec;
 	const char *label;
+	void __iomem *virt_start;
 };
 
 #ifdef CONFIG_SRAM_EXEC
-- 
2.25.0

