Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D43C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D03206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgFAGPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:15:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:41317 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgFAGPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:15:46 -0400
IronPort-SDR: NXeK3HFjaGu2feMzkTtSz7cBrre+wC6GHEdRxu5QpYQMWsGjShAdeMYgXTPhrajUXRy6bHKMhA
 QKciChJ8NOOA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 23:15:45 -0700
IronPort-SDR: UywREoZ1+NkUAFu3l4vKAZuCfj+ThWtbjZotFveJk5UsnJ1TxsBLIcIgcbSiGROlECLI74MSOR
 c0N3zg9YjXtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="470208635"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2020 23:15:41 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 1/6] soundwire: intel: cleanups for indirections/logs
Date:   Mon,  1 Jun 2020 02:20:57 +0800
Message-Id: <20200531182102.27840-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200531182102.27840-1-yung-chuan.liao@linux.intel.com>
References: <20200531182102.27840-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The code can be simplified a bit to have a more consistent use of
'dev' and 'bus', as well as move definitions around. This will help
make the major changes in follow-up patches easier to review.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c      | 68 +++++++++++++++++-----------------
 drivers/soundwire/intel.h      | 11 ++++++
 drivers/soundwire/intel_init.c |  1 +
 3 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 1eda63f488f5..10e55c708694 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -92,23 +92,12 @@
 #define SDW_ALH_STRMZCFG_DMAT		GENMASK(7, 0)
 #define SDW_ALH_STRMZCFG_CHN		GENMASK(19, 16)
 
-#define SDW_INTEL_QUIRK_MASK_BUS_DISABLE	BIT(1)
-
 enum intel_pdi_type {
 	INTEL_PDI_IN = 0,
 	INTEL_PDI_OUT = 1,
 	INTEL_PDI_BD = 2,
 };
 
-struct sdw_intel {
-	struct sdw_cdns cdns;
-	int instance;
-	struct sdw_intel_link_res *link_res;
-#ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs;
-#endif
-};
-
 #define cdns_to_intel(_cdns) container_of(_cdns, struct sdw_intel, cdns)
 
 /*
@@ -1083,41 +1072,47 @@ static int intel_init(struct sdw_intel *sdw)
 /*
  * probe and init
  */
-static int intel_probe(struct platform_device *pdev)
+static int intel_master_probe(struct platform_device *pdev)
 {
 	struct sdw_cdns_stream_config config;
+	struct device *dev = &pdev->dev;
 	struct sdw_intel *sdw;
+	struct sdw_bus *bus;
 	int ret;
 
-	sdw = devm_kzalloc(&pdev->dev, sizeof(*sdw), GFP_KERNEL);
+	sdw = devm_kzalloc(dev, sizeof(*sdw), GFP_KERNEL);
 	if (!sdw)
 		return -ENOMEM;
 
+	bus = &sdw->cdns.bus;
+
 	sdw->instance = pdev->id;
-	sdw->link_res = dev_get_platdata(&pdev->dev);
-	sdw->cdns.dev = &pdev->dev;
+	sdw->link_res = dev_get_platdata(dev);
+	sdw->cdns.dev = dev;
 	sdw->cdns.registers = sdw->link_res->registers;
 	sdw->cdns.instance = sdw->instance;
 	sdw->cdns.msg_count = 0;
-	sdw->cdns.bus.link_id = pdev->id;
+	bus->link_id = pdev->id;
 
 	sdw_cdns_probe(&sdw->cdns);
 
 	/* Set property read ops */
 	sdw_intel_ops.read_prop = intel_prop_read;
-	sdw->cdns.bus.ops = &sdw_intel_ops;
+	bus->ops = &sdw_intel_ops;
 
+	/* set driver data, accessed by snd_soc_dai_get_drvdata() */
 	platform_set_drvdata(pdev, sdw);
 
-	ret = sdw_bus_master_add(&sdw->cdns.bus, &pdev->dev, pdev->dev.fwnode);
+	ret = sdw_bus_master_add(bus, dev, dev->fwnode);
 	if (ret) {
-		dev_err(&pdev->dev, "sdw_bus_master_add fail: %d\n", ret);
+		dev_err(dev, "sdw_bus_master_add fail: %d\n", ret);
 		return ret;
 	}
 
-	if (sdw->cdns.bus.prop.hw_disabled) {
-		dev_info(&pdev->dev, "SoundWire master %d is disabled, ignoring\n",
-			 sdw->cdns.bus.link_id);
+	if (bus->prop.hw_disabled) {
+		dev_info(dev,
+			 "SoundWire master %d is disabled, will be ignored\n",
+			 bus->link_id);
 		return 0;
 	}
 
@@ -1139,28 +1134,28 @@ static int intel_probe(struct platform_device *pdev)
 				   sdw_cdns_irq, sdw_cdns_thread,
 				   IRQF_SHARED, KBUILD_MODNAME, &sdw->cdns);
 	if (ret < 0) {
-		dev_err(sdw->cdns.dev, "unable to grab IRQ %d, disabling device\n",
+		dev_err(dev, "unable to grab IRQ %d, disabling device\n",
 			sdw->link_res->irq);
 		goto err_init;
 	}
 
 	ret = sdw_cdns_enable_interrupt(&sdw->cdns, true);
 	if (ret < 0) {
-		dev_err(sdw->cdns.dev, "cannot enable interrupts\n");
+		dev_err(dev, "cannot enable interrupts\n");
 		goto err_init;
 	}
 
 	ret = sdw_cdns_exit_reset(&sdw->cdns);
 	if (ret < 0) {
-		dev_err(sdw->cdns.dev, "unable to exit bus reset sequence\n");
+		dev_err(dev, "unable to exit bus reset sequence\n");
 		goto err_interrupt;
 	}
 
 	/* Register DAIs */
 	ret = intel_register_dai(sdw);
 	if (ret) {
-		dev_err(sdw->cdns.dev, "DAI registration failed: %d\n", ret);
-		snd_soc_unregister_component(sdw->cdns.dev);
+		dev_err(dev, "DAI registration failed: %d\n", ret);
+		snd_soc_unregister_component(dev);
 		goto err_interrupt;
 	}
 
@@ -1172,33 +1167,36 @@ static int intel_probe(struct platform_device *pdev)
 	sdw_cdns_enable_interrupt(&sdw->cdns, false);
 	free_irq(sdw->link_res->irq, sdw);
 err_init:
-	sdw_bus_master_delete(&sdw->cdns.bus);
+	sdw_bus_master_delete(bus);
 	return ret;
 }
 
-static int intel_remove(struct platform_device *pdev)
+static int intel_master_remove(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct sdw_intel *sdw;
+	struct sdw_bus *bus;
 
 	sdw = platform_get_drvdata(pdev);
 
-	if (!sdw->cdns.bus.prop.hw_disabled) {
+	bus = &sdw->cdns.bus;
+
+	if (!bus->prop.hw_disabled) {
 		intel_debugfs_exit(sdw);
 		sdw_cdns_enable_interrupt(&sdw->cdns, false);
 		free_irq(sdw->link_res->irq, sdw);
-		snd_soc_unregister_component(sdw->cdns.dev);
+		snd_soc_unregister_component(dev);
 	}
-	sdw_bus_master_delete(&sdw->cdns.bus);
+	sdw_bus_master_delete(bus);
 
 	return 0;
 }
 
 static struct platform_driver sdw_intel_drv = {
-	.probe = intel_probe,
-	.remove = intel_remove,
+	.probe = intel_master_probe,
+	.remove = intel_master_remove,
 	.driver = {
 		.name = "int-sdw",
-
 	},
 };
 
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 7b4af8018e1a..001968c362cd 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -27,4 +27,15 @@ struct sdw_intel_link_res {
 	struct device *dev;
 };
 
+struct sdw_intel {
+	struct sdw_cdns cdns;
+	int instance;
+	struct sdw_intel_link_res *link_res;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs;
+#endif
+};
+
+#define SDW_INTEL_QUIRK_MASK_BUS_DISABLE      BIT(1)
+
 #endif /* __SDW_INTEL_LOCAL_H */
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 947345d5c960..de0405359db5 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/soundwire/sdw_intel.h>
+#include "cadence_master.h"
 #include "intel.h"
 
 #define SDW_LINK_TYPE		4 /* from Intel ACPI documentation */
-- 
2.17.1

