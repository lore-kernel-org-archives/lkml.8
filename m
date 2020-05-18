Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F355C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16EC20708
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgESFiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 01:38:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:18092 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgESFiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:38:16 -0400
IronPort-SDR: 1cjhvs2hT1EzayGrgg37qVtdd8q60GV+KFNLHmL94HQT9rwYzLRdASQWiVo9ihozQAR+efhRkl
 B15TDFf5itsw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 22:38:16 -0700
IronPort-SDR: 8gbm3icMEhLPi5zTRTnqryuE5r2gIqf2LgKOQL0ER5E1Lugb0ZTh2M1S22dFkapwFEVXSHQQ3r
 aJgiq/UhelUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; 
   d="scan'208";a="288836523"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga004.fm.intel.com with ESMTP; 18 May 2020 22:38:07 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 1/5] soundwire: bus: rename sdw_bus_master_add/delete, add arguments
Date:   Tue, 19 May 2020 01:43:18 +0800
Message-Id: <20200518174322.31561-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518174322.31561-1-yung-chuan.liao@linux.intel.com>
References: <20200518174322.31561-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

In preparation for future extensions, rename functions to use
sdw_bus_master prefix and add a parent and fwnode argument to
sdw_bus_master_add to help with device registration in follow-up
patches.

No functionality change, just renames and additional arguments.

The Intel code is currently unused, the two additional arguments are
only needed for compilation.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 Documentation/driver-api/soundwire/summary.rst |  7 ++++---
 drivers/soundwire/bus.c                        | 15 +++++++++------
 drivers/soundwire/intel.c                      |  8 ++++----
 drivers/soundwire/qcom.c                       |  6 +++---
 include/linux/soundwire/sdw.h                  |  5 +++--
 5 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/Documentation/driver-api/soundwire/summary.rst b/Documentation/driver-api/soundwire/summary.rst
index 8193125a2bfb..01dcb954f6d7 100644
--- a/Documentation/driver-api/soundwire/summary.rst
+++ b/Documentation/driver-api/soundwire/summary.rst
@@ -101,10 +101,11 @@ Following is the Bus API to register the SoundWire Bus:
 
 .. code-block:: c
 
-	int sdw_add_bus_master(struct sdw_bus *bus)
+	int sdw_bus_master_add(struct sdw_bus *bus,
+				struct device *parent,
+				struct fwnode_handle)
 	{
-		if (!bus->dev)
-			return -ENODEV;
+		sdw_master_device_add(bus, parent, fwnode);
 
 		mutex_init(&bus->lock);
 		INIT_LIST_HEAD(&bus->slaves);
diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 32de017f08d5..24064dbd74fa 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -10,13 +10,16 @@
 #include "bus.h"
 
 /**
- * sdw_add_bus_master() - add a bus Master instance
+ * sdw_bus_master_add() - add a bus Master instance
  * @bus: bus instance
+ * @parent: parent device
+ * @fwnode: firmware node handle
  *
  * Initializes the bus instance, read properties and create child
  * devices.
  */
-int sdw_add_bus_master(struct sdw_bus *bus)
+int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
+		       struct fwnode_handle *fwnode)
 {
 	struct sdw_master_prop *prop = NULL;
 	int ret;
@@ -107,7 +110,7 @@ int sdw_add_bus_master(struct sdw_bus *bus)
 
 	return 0;
 }
-EXPORT_SYMBOL(sdw_add_bus_master);
+EXPORT_SYMBOL(sdw_bus_master_add);
 
 static int sdw_delete_slave(struct device *dev, void *data)
 {
@@ -131,18 +134,18 @@ static int sdw_delete_slave(struct device *dev, void *data)
 }
 
 /**
- * sdw_delete_bus_master() - delete the bus master instance
+ * sdw_bus_master_delete() - delete the bus master instance
  * @bus: bus to be deleted
  *
  * Remove the instance, delete the child devices.
  */
-void sdw_delete_bus_master(struct sdw_bus *bus)
+void sdw_bus_master_delete(struct sdw_bus *bus)
 {
 	device_for_each_child(bus->dev, NULL, sdw_delete_slave);
 
 	sdw_bus_debugfs_exit(bus);
 }
-EXPORT_SYMBOL(sdw_delete_bus_master);
+EXPORT_SYMBOL(sdw_bus_master_delete);
 
 /*
  * SDW IO Calls
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 3c83e76c6bf9..210459390046 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1110,9 +1110,9 @@ static int intel_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sdw);
 
-	ret = sdw_add_bus_master(&sdw->cdns.bus);
+	ret = sdw_bus_master_add(&sdw->cdns.bus, &pdev->dev, pdev->dev.fwnode);
 	if (ret) {
-		dev_err(&pdev->dev, "sdw_add_bus_master fail: %d\n", ret);
+		dev_err(&pdev->dev, "sdw_bus_master_add fail: %d\n", ret);
 		return ret;
 	}
 
@@ -1173,7 +1173,7 @@ static int intel_probe(struct platform_device *pdev)
 	sdw_cdns_enable_interrupt(&sdw->cdns, false);
 	free_irq(sdw->link_res->irq, sdw);
 err_init:
-	sdw_delete_bus_master(&sdw->cdns.bus);
+	sdw_bus_master_delete(&sdw->cdns.bus);
 	return ret;
 }
 
@@ -1189,7 +1189,7 @@ static int intel_remove(struct platform_device *pdev)
 		free_irq(sdw->link_res->irq, sdw);
 		snd_soc_unregister_component(sdw->cdns.dev);
 	}
-	sdw_delete_bus_master(&sdw->cdns.bus);
+	sdw_bus_master_delete(&sdw->cdns.bus);
 
 	return 0;
 }
diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index e08a17c13f92..401811d6627e 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -821,7 +821,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	ret = sdw_add_bus_master(&ctrl->bus);
+	ret = sdw_bus_master_add(&ctrl->bus, dev, dev->fwnode);
 	if (ret) {
 		dev_err(dev, "Failed to register Soundwire controller (%d)\n",
 			ret);
@@ -840,7 +840,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	return 0;
 
 err_master_add:
-	sdw_delete_bus_master(&ctrl->bus);
+	sdw_bus_master_delete(&ctrl->bus);
 err_clk:
 	clk_disable_unprepare(ctrl->hclk);
 err_init:
@@ -851,7 +851,7 @@ static int qcom_swrm_remove(struct platform_device *pdev)
 {
 	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(&pdev->dev);
 
-	sdw_delete_bus_master(&ctrl->bus);
+	sdw_bus_master_delete(&ctrl->bus);
 	clk_disable_unprepare(ctrl->hclk);
 
 	return 0;
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 00f5826092e3..2003e8c55538 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -832,8 +832,9 @@ struct sdw_bus {
 	bool multi_link;
 };
 
-int sdw_add_bus_master(struct sdw_bus *bus);
-void sdw_delete_bus_master(struct sdw_bus *bus);
+int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
+		       struct fwnode_handle *fwnode);
+void sdw_bus_master_delete(struct sdw_bus *bus);
 
 /**
  * sdw_port_config: Master or Slave Port configuration
-- 
2.17.1

