Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D8FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 185E5206BE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgETHNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 03:13:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:16407 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETHNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 03:13:52 -0400
IronPort-SDR: FAUmgj/DN/aY5NKI1u5vb8FEQ+XA3PHzGAHFrJz+6NWAbJGLbh7HlrEH+vb3oqdVptWtGLQb+2
 rPv36BWfRpAA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 00:13:50 -0700
IronPort-SDR: qA3IEWNqjHI7OIYh9BFQKtFbD5uw8LrgzS2UzRmoNj0KZPHVuiOzkz56HbvRrOd71mfJ0CyK0V
 CDv7hhENZdTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,413,1583222400"; 
   d="scan'208";a="253596943"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga007.fm.intel.com with ESMTP; 20 May 2020 00:13:47 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 2/2] soundwire: intel: transition to 3 steps initialization
Date:   Wed, 20 May 2020 03:19:03 +0800
Message-Id: <20200519191903.6557-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519191903.6557-1-yung-chuan.liao@linux.intel.com>
References: <20200519191903.6557-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Rather than a plain-vanilla init/exit, this patch provides 3 steps in
the initialization (ACPI scan, probe, startup) which makes it easier to
detect platform support for SoundWire, allocate required resources as
early as possible, and conversely help make the startup() callback
lighter-weight with only hardware register setup.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c      |  76 +++++-----
 drivers/soundwire/intel.h      |  15 ++
 drivers/soundwire/intel_init.c | 249 ++++++++++++++++++++++++++-------
 3 files changed, 250 insertions(+), 90 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 4cfdd074e310..48e5712fbdf9 100644
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
@@ -1083,20 +1072,18 @@ static int intel_init(struct sdw_intel *sdw)
 /*
  * probe and init
  */
-static int intel_probe(struct platform_device *pdev)
+static int intel_master_probe(struct platform_device *pdev)
 {
-	struct sdw_cdns_stream_config config;
+	struct device *dev = &pdev->dev;
 	struct sdw_intel *sdw;
 	int ret;
 
-	sdw = devm_kzalloc(&pdev->dev, sizeof(*sdw), GFP_KERNEL);
+	sdw = devm_kzalloc(dev, sizeof(*sdw), GFP_KERNEL);
 	if (!sdw)
 		return -ENOMEM;
 
 	sdw->instance = pdev->id;
-	sdw->link_res = dev_get_platdata(&pdev->dev);
-	sdw->cdns.dev = &pdev->dev;
-	sdw->cdns.registers = sdw->link_res->registers;
+	sdw->cdns.dev = dev;
 	sdw->cdns.instance = sdw->instance;
 	sdw->cdns.msg_count = 0;
 	sdw->cdns.bus.link_id = pdev->id;
@@ -1109,15 +1096,36 @@ static int intel_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sdw);
 
-	ret = sdw_bus_master_add(&sdw->cdns.bus, &pdev->dev, pdev->dev.fwnode);
+	ret = sdw_bus_master_add(&sdw->cdns.bus, dev, dev->fwnode);
 	if (ret) {
-		dev_err(&pdev->dev, "sdw_bus_master_add fail: %d\n", ret);
+		dev_err(dev, "sdw_bus_master_add fail: %d\n", ret);
 		return ret;
 	}
 
-	if (sdw->cdns.bus.prop.hw_disabled) {
-		dev_info(&pdev->dev, "SoundWire master %d is disabled, ignoring\n",
+	if (sdw->cdns.bus.prop.hw_disabled)
+		dev_info(dev,
+			 "SoundWire master %d is disabled, ignoring\n",
 			 sdw->cdns.bus.link_id);
+
+	/* set driver data, accessed by snd_soc_dai_set_drvdata() */
+	dev_set_drvdata(sdw->cdns.bus.dev, &sdw->cdns);
+
+	return 0;
+}
+
+int intel_master_startup(struct platform_device *pdev)
+{
+	struct sdw_cdns_stream_config config;
+	struct device *dev = &pdev->dev;
+	struct sdw_intel *sdw;
+	int ret;
+
+	sdw = platform_get_drvdata(pdev);
+
+	if (sdw->cdns.bus.prop.hw_disabled) {
+		dev_info(dev,
+			 "SoundWire master %d is disabled, ignoring\n",
+			 sdw->instance);
 		return 0;
 	}
 
@@ -1134,25 +1142,15 @@ static int intel_probe(struct platform_device *pdev)
 
 	intel_pdi_ch_update(sdw);
 
-	/* Acquire IRQ */
-	ret = request_threaded_irq(sdw->link_res->irq,
-				   sdw_cdns_irq, sdw_cdns_thread,
-				   IRQF_SHARED, KBUILD_MODNAME, &sdw->cdns);
-	if (ret < 0) {
-		dev_err(sdw->cdns.dev, "unable to grab IRQ %d, disabling device\n",
-			sdw->link_res->irq);
-		goto err_init;
-	}
-
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
 
@@ -1170,13 +1168,11 @@ static int intel_probe(struct platform_device *pdev)
 
 err_interrupt:
 	sdw_cdns_enable_interrupt(&sdw->cdns, false);
-	free_irq(sdw->link_res->irq, sdw);
 err_init:
-	sdw_bus_master_delete(&sdw->cdns.bus);
 	return ret;
 }
 
-static int intel_remove(struct platform_device *pdev)
+static int intel_master_remove(struct platform_device *pdev)
 {
 	struct sdw_intel *sdw;
 
@@ -1194,10 +1190,10 @@ static int intel_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver sdw_intel_drv = {
-	.probe = intel_probe,
-	.remove = intel_remove,
+	.probe = intel_master_probe,
+	.remove = intel_master_remove,
 	.driver = {
-		.name = "int-sdw",
+		.name = "intel-sdw",
 
 	},
 };
@@ -1205,5 +1201,5 @@ static struct platform_driver sdw_intel_drv = {
 module_platform_driver(sdw_intel_drv);
 
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_ALIAS("platform:int-sdw");
+MODULE_ALIAS("sdw:intel-sdw");
 MODULE_DESCRIPTION("Intel Soundwire Master Driver");
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 38b7c125fb10..0ac7d764f58c 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -15,6 +15,7 @@
  * @irq: Interrupt line
  * @ops: Shim callback ops
  * @dev: device implementing hw_params and free callbacks
+ * @clock_stop_quirks: mask defining requested behavior on pm_suspend
  */
 struct sdw_intel_link_res {
 	struct platform_device *pdev;
@@ -25,6 +26,20 @@ struct sdw_intel_link_res {
 	int irq;
 	const struct sdw_intel_ops *ops;
 	struct device *dev;
+	u32 clock_stop_quirks;
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
+int intel_master_startup(struct platform_device *pdev);
+
 #endif /* __SDW_INTEL_LOCAL_H */
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index d5d42795a48f..b918d58bd666 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/soundwire/sdw_intel.h>
+#include "cadence_master.h"
 #include "intel.h"
 
 #define SDW_LINK_TYPE		4 /* from Intel ACPI documentation */
@@ -23,22 +24,51 @@
 #define SDW_LINK_BASE		0x30000
 #define SDW_LINK_SIZE		0x10000
 
-static int link_mask;
-module_param_named(sdw_link_mask, link_mask, int, 0444);
+static int ctrl_link_mask;
+module_param_named(sdw_link_mask, ctrl_link_mask, int, 0444);
 MODULE_PARM_DESC(sdw_link_mask, "Intel link mask (one bit per link)");
 
-static int sdw_intel_cleanup_pdev(struct sdw_intel_ctx *ctx)
+static bool is_link_enabled(struct fwnode_handle *fw_node, int i)
+{
+	struct fwnode_handle *link;
+	char name[32];
+	u32 quirk_mask = 0;
+
+	/* Find master handle */
+	snprintf(name, sizeof(name),
+		 "mipi-sdw-link-%d-subproperties", i);
+
+	link = fwnode_get_named_child_node(fw_node, name);
+	if (!link)
+		return false;
+
+	fwnode_property_read_u32(link,
+				 "intel-quirk-mask",
+				 &quirk_mask);
+
+	if (quirk_mask & SDW_INTEL_QUIRK_MASK_BUS_DISABLE)
+		return false;
+
+	return true;
+}
+
+static int sdw_intel_cleanup(struct sdw_intel_ctx *ctx)
 {
 	struct sdw_intel_link_res *link = ctx->links;
+	u32 link_mask;
 	int i;
 
 	if (!link)
 		return 0;
 
-	for (i = 0; i < ctx->count; i++) {
+	link_mask = ctx->link_mask;
+
+	for (i = 0; i < ctx->count; i++, link++) {
+		if (link_mask && !(link_mask & BIT(i)))
+			continue;
+
 		if (link->pdev)
 			platform_device_unregister(link->pdev);
-		link++;
 	}
 
 	kfree(ctx->links);
@@ -47,52 +77,97 @@ static int sdw_intel_cleanup_pdev(struct sdw_intel_ctx *ctx)
 	return 0;
 }
 
-static struct sdw_intel_ctx
-*sdw_intel_add_controller(struct sdw_intel_res *res)
+static int
+sdw_intel_scan_controller(struct sdw_intel_acpi_info *info)
 {
-	struct platform_device_info pdevinfo;
-	struct platform_device *pdev;
-	struct sdw_intel_link_res *link;
-	struct sdw_intel_ctx *ctx;
 	struct acpi_device *adev;
 	int ret, i;
 	u8 count;
-	u32 caps;
 
-	if (acpi_bus_get_device(res->handle, &adev))
-		return NULL;
+	if (acpi_bus_get_device(info->handle, &adev))
+		return -EINVAL;
 
 	/* Found controller, find links supported */
 	count = 0;
 	ret = fwnode_property_read_u8_array(acpi_fwnode_handle(adev),
 					    "mipi-sdw-master-count", &count, 1);
 
-	/* Don't fail on error, continue and use hw value */
+	/*
+	 * In theory we could check the number of links supported in
+	 * hardware, but in that step we cannot assume SoundWire IP is
+	 * powered.
+	 *
+	 * In addition, if the BIOS doesn't even provide this
+	 * 'master-count' property then all the inits based on link
+	 * masks will fail as well.
+	 *
+	 * We will check the hardware capabilities in the startup() step
+	 */
+
 	if (ret) {
 		dev_err(&adev->dev,
 			"Failed to read mipi-sdw-master-count: %d\n", ret);
-		count = SDW_MAX_LINKS;
+		return -EINVAL;
 	}
 
-	/* Check SNDWLCAP.LCOUNT */
-	caps = ioread32(res->mmio_base + SDW_SHIM_BASE + SDW_SHIM_LCAP);
-	caps &= GENMASK(2, 0);
-
-	/* Check HW supported vs property value and use min of two */
-	count = min_t(u8, caps, count);
-
 	/* Check count is within bounds */
 	if (count > SDW_MAX_LINKS) {
 		dev_err(&adev->dev, "Link count %d exceeds max %d\n",
 			count, SDW_MAX_LINKS);
-		return NULL;
+		return -EINVAL;
 	}
 
 	if (!count) {
 		dev_warn(&adev->dev, "No SoundWire links detected\n");
-		return NULL;
+		return -EINVAL;
+	}
+	dev_dbg(&adev->dev, "ACPI reports %d SDW Link devices\n", count);
+
+	info->count = count;
+	info->link_mask = 0;
+
+	for (i = 0; i < count; i++) {
+		if (ctrl_link_mask && !(ctrl_link_mask & BIT(i))) {
+			dev_dbg(&adev->dev,
+				"Link %d masked, will not be enabled\n", i);
+			continue;
+		}
+
+		if (!is_link_enabled(acpi_fwnode_handle(adev), i)) {
+			dev_dbg(&adev->dev,
+				"Link %d not selected in firmware\n", i);
+			continue;
+		}
+
+		info->link_mask |= BIT(i);
 	}
 
+	return 0;
+}
+
+static struct sdw_intel_ctx
+*sdw_intel_probe_controller(struct sdw_intel_res *res)
+{
+	struct platform_device_info pdevinfo;
+	struct platform_device *pdev;
+	struct sdw_intel_link_res *link;
+	struct sdw_intel_ctx *ctx;
+	struct acpi_device *adev;
+	struct sdw_intel *sdw;
+	u32 link_mask;
+	int count;
+	int i;
+
+	if (!res)
+		return NULL;
+
+	if (acpi_bus_get_device(res->handle, &adev))
+		return NULL;
+
+	if (!res->count)
+		return NULL;
+
+	count = res->count;
 	dev_dbg(&adev->dev, "Creating %d SDW Link devices\n", count);
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
@@ -104,19 +179,22 @@ static struct sdw_intel_ctx
 	if (!ctx->links)
 		goto link_err;
 
+	ctx->count = count;
+	ctx->mmio_base = res->mmio_base;
+	ctx->link_mask = res->link_mask;
+	ctx->handle = res->handle;
+
 	link = ctx->links;
+	link_mask = ctx->link_mask;
 
 	/* Create SDW Master devices */
-	for (i = 0; i < count; i++) {
-		if (link_mask && !(link_mask & BIT(i))) {
-			dev_dbg(&adev->dev,
-				"Link %d masked, will not be enabled\n", i);
-			link++;
+	for (i = 0; i < count; i++, link++) {
+		if (link_mask && !(link_mask & BIT(i)))
 			continue;
-		}
 
+		link->mmio_base = res->mmio_base;
 		link->registers = res->mmio_base + SDW_LINK_BASE
-					+ (SDW_LINK_SIZE * i);
+			+ (SDW_LINK_SIZE * i);
 		link->shim = res->mmio_base + SDW_SHIM_BASE;
 		link->alh = res->mmio_base + SDW_ALH_BASE;
 
@@ -126,7 +204,7 @@ static struct sdw_intel_ctx
 		memset(&pdevinfo, 0, sizeof(pdevinfo));
 
 		pdevinfo.parent = res->parent;
-		pdevinfo.name = "int-sdw";
+		pdevinfo.name = "intel-sdw";
 		pdevinfo.id = i;
 		pdevinfo.fwnode = acpi_fwnode_handle(adev);
 
@@ -135,26 +213,68 @@ static struct sdw_intel_ctx
 			dev_err(&adev->dev,
 				"platform device creation failed: %ld\n",
 				PTR_ERR(pdev));
-			goto pdev_err;
+			goto err;
 		}
-
+		sdw = platform_get_drvdata(pdev);
+		sdw->link_res = link;
+		sdw->cdns.registers = sdw->link_res->registers;
 		link->pdev = pdev;
-		link++;
 	}
 
 	return ctx;
 
-pdev_err:
-	sdw_intel_cleanup_pdev(ctx);
+err:
+	ctx->count = i;
+	sdw_intel_cleanup(ctx);
 link_err:
 	kfree(ctx);
 	return NULL;
 }
 
+static int
+sdw_intel_startup_controller(struct sdw_intel_ctx *ctx)
+{
+	struct acpi_device *adev;
+	struct sdw_intel_link_res *link;
+	u32 caps;
+	u32 link_mask;
+	int i;
+
+	if (acpi_bus_get_device(ctx->handle, &adev))
+		return -EINVAL;
+
+	/* Check SNDWLCAP.LCOUNT */
+	caps = ioread32(ctx->mmio_base + SDW_SHIM_BASE + SDW_SHIM_LCAP);
+	caps &= GENMASK(2, 0);
+
+	/* Check HW supported vs property value */
+	if (caps < ctx->count) {
+		dev_err(&adev->dev,
+			"BIOS master count is larger than hardware capabilities\n");
+		return -EINVAL;
+	}
+
+	if (!ctx->links)
+		return -EINVAL;
+
+	link = ctx->links;
+	link_mask = ctx->link_mask;
+
+	/* Startup SDW Master devices */
+	for (i = 0; i < ctx->count; i++, link++) {
+		if (link_mask && !(link_mask & BIT(i)))
+			continue;
+
+		intel_master_startup(link->pdev);
+	}
+
+	return 0;
+}
+
 static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
 				     void *cdata, void **return_value)
 {
-	struct sdw_intel_res *res = cdata;
+	struct sdw_intel_acpi_info *info = cdata;
 	struct acpi_device *adev;
 	acpi_status status;
 	u64 adr;
@@ -168,7 +288,7 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
 		return AE_NOT_FOUND;
 	}
 
-	res->handle = handle;
+	info->handle = handle;
 
 	/*
 	 * On some Intel platforms, multiple children of the HDAS
@@ -185,36 +305,65 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
 }
 
 /**
- * sdw_intel_init() - SoundWire Intel init routine
+ * sdw_intel_acpi_scan() - SoundWire Intel init routine
  * @parent_handle: ACPI parent handle
- * @res: resource data
+ * @info: description of what firmware/DSDT tables expose
  *
- * This scans the namespace and creates SoundWire link controller devices
- * based on the info queried.
+ * This scans the namespace and queries firmware to figure out which
+ * links to enable. A follow-up use of sdw_intel_probe() and
+ * sdw_intel_startup() is required for creation of devices and bus
+ * startup
  */
-void *sdw_intel_init(acpi_handle *parent_handle, struct sdw_intel_res *res)
+int sdw_intel_acpi_scan(acpi_handle *parent_handle,
+			struct sdw_intel_acpi_info *info)
 {
 	acpi_status status;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
 				     parent_handle, 1,
 				     sdw_intel_acpi_cb,
-				     NULL, res, NULL);
+				     NULL, info, NULL);
 	if (ACPI_FAILURE(status))
-		return NULL;
+		return -ENODEV;
 
-	return sdw_intel_add_controller(res);
+	return sdw_intel_scan_controller(info);
 }
+EXPORT_SYMBOL(sdw_intel_acpi_scan);
 
+/**
+ * sdw_intel_probe() - SoundWire Intel probe routine
+ * @res: resource data
+ *
+ * This creates SoundWire Master and Slave devices below the controller.
+ * All the information necessary is stored in the context, and the res
+ * argument pointer can be freed after this step.
+ */
+struct sdw_intel_ctx
+*sdw_intel_probe(struct sdw_intel_res *res)
+{
+	return sdw_intel_probe_controller(res);
+}
+EXPORT_SYMBOL(sdw_intel_probe);
+
+/**
+ * sdw_intel_startup() - SoundWire Intel startup
+ * @ctx: SoundWire context allocated in the probe
+ *
+ */
+int sdw_intel_startup(struct sdw_intel_ctx *ctx)
+{
+	return sdw_intel_startup_controller(ctx);
+}
+EXPORT_SYMBOL(sdw_intel_startup);
 /**
  * sdw_intel_exit() - SoundWire Intel exit
- * @arg: callback context
+ * @ctx: SoundWire context allocated in the probe
  *
  * Delete the controller instances created and cleanup
  */
 void sdw_intel_exit(struct sdw_intel_ctx *ctx)
 {
-	sdw_intel_cleanup_pdev(ctx);
+	sdw_intel_cleanup(ctx);
 	kfree(ctx);
 }
 EXPORT_SYMBOL(sdw_intel_exit);
-- 
2.17.1

