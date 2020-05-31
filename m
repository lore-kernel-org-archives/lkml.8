Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E83C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E31CA206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgFAGQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:16:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:41317 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgFAGQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:16:08 -0400
IronPort-SDR: RjdrcJHz2GCUTeLoevNTxrMVUHDPaJAp2p6gqxieNIbxcD1oqVwv59Q7fZ5s+06XEot9UFgXsK
 gYztuZ3Xl87w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 23:16:07 -0700
IronPort-SDR: kfqn6MPD4NgLvgSyd3XACkWx7ewpMlec/lxHYRkf0Gkri1F3/cwHDmskehf1pbiYduFB7QAmUD
 Dp51f0QULErg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="470208780"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2020 23:16:03 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 6/6] soundwire: intel: transition to 3 steps initialization
Date:   Mon,  1 Jun 2020 02:21:02 +0800
Message-Id: <20200531182102.27840-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200531182102.27840-1-yung-chuan.liao@linux.intel.com>
References: <20200531182102.27840-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Rather than a plain-vanilla init/exit, this patch provides 3 steps in
the initialization needed for driver selection, machine driver
selection and deal with power rail dependencies.

- ACPI scan: this step is done at a very early stage to detect the
presence of a SoundWire Controller and enabled links at the BIOS
level. This step may be called from the legacy HDaudio driver, which
will abort its probe to let the Sound Open Firmware (SOF) handle the
hardware.

- probe: this step allocates all the required memory and will add a
sdw_bus, which in turn will result in identifying all possible Slaves
listed below the Controller ACPI companion device. All the information
is reported to the parent PCI driver which will select the relevant
machine driver.

- startup: this last step starts the bus reset, which results in Slave
devices reporting as ATTACHED and being enumerated. This step is only
done during the card creation stage, after the DSP is powered to
account for internal power rail dependencies.

These 3 steps are already supported in the Sound Open firmware
drivers and upstream.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c      |  60 +++++---
 drivers/soundwire/intel.h      |   2 +
 drivers/soundwire/intel_init.c | 242 ++++++++++++++++++++++++++-------
 3 files changed, 237 insertions(+), 67 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index ef1196ea93a4..f966ac33cd3b 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1074,7 +1074,6 @@ static int intel_init(struct sdw_intel *sdw)
  */
 static int intel_master_probe(struct platform_device *pdev)
 {
-	struct sdw_cdns_stream_config config;
 	struct device *dev = &pdev->dev;
 	struct sdw_intel *sdw;
 	struct sdw_cdns *cdns;
@@ -1112,25 +1111,10 @@ static int intel_master_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (bus->prop.hw_disabled) {
+	if (bus->prop.hw_disabled)
 		dev_info(dev,
 			 "SoundWire master %d is disabled, will be ignored\n",
 			 bus->link_id);
-		return 0;
-	}
-
-	/* Initialize shim, controller and Cadence IP */
-	ret = intel_init(sdw);
-	if (ret)
-		goto err_init;
-
-	/* Read the PDI config and initialize cadence PDI */
-	intel_pdi_init(sdw, &config);
-	ret = sdw_cdns_pdi_init(cdns, config);
-	if (ret)
-		goto err_init;
-
-	intel_pdi_ch_update(sdw);
 
 	/* Acquire IRQ */
 	ret = request_threaded_irq(sdw->link_res->irq,
@@ -1142,6 +1126,42 @@ static int intel_master_probe(struct platform_device *pdev)
 		goto err_init;
 	}
 
+	return 0;
+
+err_init:
+	sdw_bus_master_delete(bus);
+	return ret;
+}
+
+int intel_master_startup(struct platform_device *pdev)
+{
+	struct sdw_cdns_stream_config config;
+	struct device *dev = &pdev->dev;
+	struct sdw_cdns *cdns = dev_get_drvdata(dev);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_bus *bus = &cdns->bus;
+	int ret;
+
+	if (bus->prop.hw_disabled) {
+		dev_info(dev,
+			 "SoundWire master %d is disabled, ignoring\n",
+			 sdw->instance);
+		return 0;
+	}
+
+	/* Initialize shim, controller and Cadence IP */
+	ret = intel_init(sdw);
+	if (ret)
+		goto err_init;
+
+	/* Read the PDI config and initialize cadence PDI */
+	intel_pdi_init(sdw, &config);
+	ret = sdw_cdns_pdi_init(cdns, config);
+	if (ret)
+		goto err_init;
+
+	intel_pdi_ch_update(sdw);
+
 	ret = sdw_cdns_enable_interrupt(cdns, true);
 	if (ret < 0) {
 		dev_err(dev, "cannot enable interrupts\n");
@@ -1168,9 +1188,7 @@ static int intel_master_probe(struct platform_device *pdev)
 
 err_interrupt:
 	sdw_cdns_enable_interrupt(cdns, false);
-	free_irq(sdw->link_res->irq, sdw);
 err_init:
-	sdw_bus_master_delete(bus);
 	return ret;
 }
 
@@ -1196,12 +1214,12 @@ static struct platform_driver sdw_intel_drv = {
 	.probe = intel_master_probe,
 	.remove = intel_master_remove,
 	.driver = {
-		.name = "int-sdw",
+		.name = "intel-sdw",
 	},
 };
 
 module_platform_driver(sdw_intel_drv);
 
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_ALIAS("platform:int-sdw");
+MODULE_ALIAS("platform:intel-sdw");
 MODULE_DESCRIPTION("Intel Soundwire Master Driver");
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 001968c362cd..1ff71eb4c219 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -38,4 +38,6 @@ struct sdw_intel {
 
 #define SDW_INTEL_QUIRK_MASK_BUS_DISABLE      BIT(1)
 
+int intel_master_startup(struct platform_device *pdev);
+
 #endif /* __SDW_INTEL_LOCAL_H */
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index ff1017e64abd..41c06e9bcecb 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -24,73 +24,146 @@
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
+		if (!(link_mask & BIT(i)))
+			continue;
+
 		if (link->pdev)
 			platform_device_unregister(link->pdev);
-		link++;
 	}
 
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
 	}
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
+	}
+
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
 
+	count = res->count;
 	dev_dbg(&adev->dev, "Creating %d SDW Link devices\n", count);
 
 	ctx = devm_kzalloc(&adev->dev, sizeof(*ctx), GFP_KERNEL);
@@ -103,19 +176,25 @@ static struct sdw_intel_ctx
 	if (!ctx->links)
 		return NULL;
 
+	ctx->count = count;
+	ctx->mmio_base = res->mmio_base;
+	ctx->link_mask = res->link_mask;
+	ctx->handle = res->handle;
+
 	link = ctx->links;
+	link_mask = ctx->link_mask;
 
 	/* Create SDW Master devices */
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < count; i++, link++) {
 		if (!(link_mask & BIT(i))) {
 			dev_dbg(&adev->dev,
 				"Link %d masked, will not be enabled\n", i);
-			link++;
 			continue;
 		}
 
+		link->mmio_base = res->mmio_base;
 		link->registers = res->mmio_base + SDW_LINK_BASE
-					+ (SDW_LINK_SIZE * i);
+			+ (SDW_LINK_SIZE * i);
 		link->shim = res->mmio_base + SDW_SHIM_BASE;
 		link->alh = res->mmio_base + SDW_ALH_BASE;
 
@@ -125,7 +204,7 @@ static struct sdw_intel_ctx
 		memset(&pdevinfo, 0, sizeof(pdevinfo));
 
 		pdevinfo.parent = res->parent;
-		pdevinfo.name = "int-sdw";
+		pdevinfo.name = "intel-sdw";
 		pdevinfo.id = i;
 		pdevinfo.fwnode = acpi_fwnode_handle(adev);
 		pdevinfo.data = link;
@@ -136,25 +215,63 @@ static struct sdw_intel_ctx
 			dev_err(&adev->dev,
 				"platform device creation failed: %ld\n",
 				PTR_ERR(pdev));
-			goto pdev_err;
+			goto err;
 		}
-
 		link->pdev = pdev;
-		link++;
 	}
 
 	return ctx;
 
-pdev_err:
+err:
 	ctx->count = i;
-	sdw_intel_cleanup_pdev(ctx);
+	sdw_intel_cleanup(ctx);
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
+		if (!(link_mask & BIT(i)))
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
@@ -168,7 +285,7 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
 		return AE_NOT_FOUND;
 	}
 
-	res->handle = handle;
+	info->handle = handle;
 
 	/*
 	 * On some Intel platforms, multiple children of the HDAS
@@ -185,36 +302,69 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
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
+ * This registers a platform device for each Master handled by the controller,
+ * and SoundWire Master and Slave devices will be created by the platform
+ * device probe. All the information necessary is stored in the context, and
+ * the res argument pointer can be freed after this step.
+ * This function will be called after sdw_intel_acpi_scan() by SOF probe.
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
+ * Startup Intel SoundWire controller. This function will be called after
+ * Intel Audio DSP is powered up.
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
 }
 EXPORT_SYMBOL(sdw_intel_exit);
 
-- 
2.17.1

