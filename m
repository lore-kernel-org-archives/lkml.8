Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5EBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5060C207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="AaqbSMqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHTFsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:48:22 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:37192 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726923AbgHTFsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:48:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597902495; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=e/gnTPvWUTbMq564VoLj5uTu8OHvCHvzXduEcgygO8U=; b=AaqbSMqvaYg4fGL+znWdpjXs4+DM0JTicBSl1ql281H7fdtuNSrqYiarWbeRC9yR1EcgBON8
 c6xWKc2tnOwM//wxLuvgkNbeQJjY1C1nMNMqvRS0PSBdTvW4Ob4MBi8UZwdoCFPWnsmM6qR8
 8paMi1FM/267RlI3v+zUX3aY/B4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f3e0e9e1384cb499ab647ca (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 Aug 2020 05:48:14
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E33D4C4339C; Thu, 20 Aug 2020 05:48:13 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 074EEC4344E;
        Thu, 20 Aug 2020 05:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 074EEC4344E
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Mian Yousaf Kaukab <ykaukab@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Kim Phillips <kim.phillips@arm.com>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>
Subject: [PATCH v9 05/24] coresight: export global symbols
Date:   Thu, 20 Aug 2020 13:46:59 +0800
Message-Id: <20200820054718.20115-6-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200820054718.20115-1-tingwei@codeaurora.org>
References: <20200820054718.20115-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mian Yousaf Kaukab <ykaukab@suse.de>

Export symbols used among coresight modules.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Tested-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 1 +
 drivers/hwtracing/coresight/coresight-sysfs.c    | 2 ++
 drivers/hwtracing/coresight/coresight-tmc-etr.c  | 6 ++++++
 drivers/hwtracing/coresight/coresight.c          | 8 ++++++++
 4 files changed, 17 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 1a3169e69bb1..dcb0592418ae 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -517,6 +517,7 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(etm_perf_symlink);
 
 static ssize_t etm_perf_sink_name_show(struct device *dev,
 				       struct device_attribute *dattr,
diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
index 82afeaf2ccc4..34d2a2d31d00 100644
--- a/drivers/hwtracing/coresight/coresight-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-sysfs.c
@@ -102,6 +102,7 @@ int coresight_add_sysfs_link(struct coresight_sysfs_link *info)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(coresight_add_sysfs_link);
 
 void coresight_remove_sysfs_link(struct coresight_sysfs_link *info)
 {
@@ -122,6 +123,7 @@ void coresight_remove_sysfs_link(struct coresight_sysfs_link *info)
 	info->orig->nr_links--;
 	info->target->nr_links--;
 }
+EXPORT_SYMBOL_GPL(coresight_remove_sysfs_link);
 
 /*
  * coresight_make_links: Make a link for a connection from a @orig
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index b29c2db94d96..ad991a37e2d2 100644
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
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index d515088cc47d..cd17aea6b50d 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -54,6 +54,7 @@ static struct list_head *stm_path;
  * it needs to look for another sync sequence.
  */
 const u32 coresight_barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff};
+EXPORT_SYMBOL_GPL(coresight_barrier_pkt);
 
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
 
 /* enable or disable an associated CTI device of the supplied CS device */
 static int
@@ -467,6 +472,7 @@ void coresight_disable_path(struct list_head *path)
 {
 	coresight_disable_path_from(path, NULL);
 }
+EXPORT_SYMBOL_GPL(coresight_disable_path);
 
 int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
 {
@@ -1376,6 +1382,7 @@ int coresight_timeout(void __iomem *addr, u32 offset, int position, int value)
 
 	return -EAGAIN;
 }
+EXPORT_SYMBOL_GPL(coresight_timeout);
 
 struct bus_type coresight_bustype = {
 	.name	= "coresight",
@@ -1552,6 +1559,7 @@ bool coresight_loses_context_with_cpu(struct device *dev)
 	return fwnode_property_present(dev_fwnode(dev),
 				       "arm,coresight-loses-context-with-cpu");
 }
+EXPORT_SYMBOL_GPL(coresight_loses_context_with_cpu);
 
 /*
  * coresight_alloc_device_name - Get an index for a given device in the
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

