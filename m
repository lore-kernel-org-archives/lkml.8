Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF03C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4B02176D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbgAQOji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:39:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:57462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbgAQOjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:39:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3F424AAC2;
        Fri, 17 Jan 2020 14:39:06 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org
Cc:     linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com,
        suzuki.poulose@arm.com, alexander.shishkin@linux.intel.com,
        Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH RFC 10/15] coresight: export global symbols
Date:   Fri, 17 Jan 2020 15:40:05 +0100
Message-Id: <20200117144010.11149-11-ykaukab@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200117144010.11149-1-ykaukab@suse.de>
References: <20200117144010.11149-1-ykaukab@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export symbols used among coresight modules.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 drivers/hwtracing/coresight/coresight-bus.c      | 8 ++++++++
 drivers/hwtracing/coresight/coresight-etm-perf.c | 1 +
 drivers/hwtracing/coresight/coresight-tmc-etr.c  | 6 ++++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-bus.c b/drivers/hwtracing/coresight/coresight-bus.c
index c2eaeeea98cd..aef99c3f7362 100644
--- a/drivers/hwtracing/coresight/coresight-bus.c
+++ b/drivers/hwtracing/coresight/coresight-bus.c
@@ -54,6 +54,7 @@ static struct list_head *stm_path;
  * it needs to look for another sync sequence.
  */
 const u32 barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff};
+EXPORT_SYMBOL_GPL(barrier_pkt);
 
 static int coresight_id_match(struct device *dev, void *data)
 {
@@ -179,6 +180,7 @@ int coresight_claim_device_unlocked(void __iomem *base)
 	coresight_clear_claim_tags(base);
 	return -EBUSY;
 }
+EXPORT_SYMBOL_GPL(coresight_claim_device_unlocked);
 
 int coresight_claim_device(void __iomem *base)
 {
@@ -190,6 +192,7 @@ int coresight_claim_device(void __iomem *base)
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(coresight_claim_device);
 
 /*
  * coresight_disclaim_device_unlocked : Clear the claim tags for the device.
@@ -208,6 +211,7 @@ void coresight_disclaim_device_unlocked(void __iomem *base)
 		 */
 		WARN_ON_ONCE(1);
 }
+EXPORT_SYMBOL_GPL(coresight_disclaim_device_unlocked);
 
 void coresight_disclaim_device(void __iomem *base)
 {
@@ -215,6 +219,7 @@ void coresight_disclaim_device(void __iomem *base)
 	coresight_disclaim_device_unlocked(base);
 	CS_LOCK(base);
 }
+EXPORT_SYMBOL_GPL(coresight_disclaim_device);
 
 static int coresight_enable_sink(struct coresight_device *csdev,
 				 u32 mode, void *data)
@@ -408,6 +413,7 @@ void coresight_disable_path(struct list_head *path)
 {
 	coresight_disable_path_from(path, NULL);
 }
+EXPORT_SYMBOL_GPL(coresight_disable_path);
 
 int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
 {
@@ -1141,6 +1147,7 @@ int coresight_timeout(void __iomem *addr, u32 offset, int position, int value)
 
 	return -EAGAIN;
 }
+EXPORT_SYMBOL_GPL(coresight_timeout);
 
 /*
  * coresight_release_platform_data: Release references to the devices connected
@@ -1286,6 +1293,7 @@ bool coresight_loses_context_with_cpu(struct device *dev)
 	return fwnode_property_present(dev_fwnode(dev),
 				       "arm,coresight-loses-context-with-cpu");
 }
+EXPORT_SYMBOL_GPL(coresight_loses_context_with_cpu);
 
 /*
  * coresight_alloc_device_name - Get an index for a given device in the
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 1bd71c2f6802..3df09166a17a 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -506,6 +506,7 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(etm_perf_symlink);
 
 static ssize_t etm_perf_sink_name_show(struct device *dev,
 				       struct device_attribute *dattr,
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 5b2a515af1ae..abd18430dcd7 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -255,6 +255,7 @@ void tmc_free_sg_table(struct tmc_sg_table *sg_table)
 	tmc_free_table_pages(sg_table);
 	tmc_free_data_pages(sg_table);
 }
+EXPORT_SYMBOL_GPL(tmc_free_sg_table);
 
 /*
  * Alloc pages for the table. Since this will be used by the device,
@@ -340,6 +341,7 @@ struct tmc_sg_table *tmc_alloc_sg_table(struct device *dev,
 
 	return sg_table;
 }
+EXPORT_SYMBOL_GPL(tmc_alloc_sg_table);
 
 /*
  * tmc_sg_table_sync_data_range: Sync the data buffer written
@@ -360,6 +362,7 @@ void tmc_sg_table_sync_data_range(struct tmc_sg_table *table,
 					PAGE_SIZE, DMA_FROM_DEVICE);
 	}
 }
+EXPORT_SYMBOL_GPL(tmc_sg_table_sync_data_range);
 
 /* tmc_sg_sync_table: Sync the page table */
 void tmc_sg_table_sync_table(struct tmc_sg_table *sg_table)
@@ -372,6 +375,7 @@ void tmc_sg_table_sync_table(struct tmc_sg_table *sg_table)
 		dma_sync_single_for_device(real_dev, table_pages->daddrs[i],
 					   PAGE_SIZE, DMA_TO_DEVICE);
 }
+EXPORT_SYMBOL_GPL(tmc_sg_table_sync_table);
 
 /*
  * tmc_sg_table_get_data: Get the buffer pointer for data @offset
@@ -401,6 +405,7 @@ ssize_t tmc_sg_table_get_data(struct tmc_sg_table *sg_table,
 		*bufpp = page_address(data_pages->pages[pg_idx]) + pg_offset;
 	return len;
 }
+EXPORT_SYMBOL_GPL(tmc_sg_table_get_data);
 
 #ifdef ETR_SG_DEBUG
 /* Map a dma address to virtual address */
@@ -766,6 +771,7 @@ tmc_etr_get_catu_device(struct tmc_drvdata *drvdata)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(tmc_etr_get_catu_device);
 
 static inline int tmc_etr_enable_catu(struct tmc_drvdata *drvdata,
 				      struct etr_buf *etr_buf)
-- 
2.16.4

