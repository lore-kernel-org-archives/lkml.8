Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982A6C83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C4A21775
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgD3Gqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 02:46:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:56943 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbgD3Gqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 02:46:45 -0400
IronPort-SDR: Qs5iCpL99XcBR8z4yEoVGWJBEXGlj5jWO+AYMwan0FVIw3yT12cq6OB8z4+7tunM8JriOOFYj9
 tJGKuuLf0+Xg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 23:46:45 -0700
IronPort-SDR: sWE2BURnu8GLHMTvnWamUpSzLF+VZi1DlhV/vvPMm0TWLYsDzgmnT+cBoQN30/PGxHZBXdE62Q
 RSHMjAoe9P/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; 
   d="scan'208";a="249662792"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga008.fm.intel.com with ESMTP; 29 Apr 2020 23:46:41 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 3/3] soundwire: bus_type: add sdw_master_device support
Date:   Thu, 30 Apr 2020 02:51:45 +0800
Message-Id: <20200429185145.12891-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429185145.12891-1-yung-chuan.liao@linux.intel.com>
References: <20200429185145.12891-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

In the existing SoundWire code, Master Devices are not explicitly
represented - only SoundWire Slave Devices are exposed (the use of
capital letters follows the SoundWire specification conventions).

The SoundWire Master Device provides the clock, synchronization
information and command/control channels. When multiple links are
supported, a Controller may expose more than one Master Device; they
are typically embedded inside a larger audio cluster (be it in an
SOC/chipset or an external audio codec), and we need to describe it
using the Linux device and driver model.

This transition will avoid abusing platform devices and allow for
better sysfs support without the reference count issues mentioned in
the initial reviews.

The sdw_master_device addition is done with minimal internal plumbing
and not exposed externally. The existing API based on
sdw_bus_master_add() and sdw_bus_master_delete() will deal with the
sdw_master_device life cycle, which minimizes changes to existing
drivers.

Note that the Intel code will be modified in follow-up patches (no
impact on any platform since the connection with ASoC is not supported
upstream so far).

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/Makefile    |  2 +-
 drivers/soundwire/bus.c       | 12 ++++--
 drivers/soundwire/bus.h       |  3 ++
 drivers/soundwire/master.c    | 79 +++++++++++++++++++++++++++++++++++
 drivers/soundwire/qcom.c      |  1 -
 include/linux/soundwire/sdw.h | 17 +++++++-
 6 files changed, 108 insertions(+), 6 deletions(-)
 create mode 100644 drivers/soundwire/master.c

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index e2cdff990e9f..7319918e0aec 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -4,7 +4,7 @@
 #
 
 #Bus Objs
-soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
+soundwire-bus-objs := bus_type.o bus.o master.o slave.o mipi_disco.o stream.o
 obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
 
 ifdef CONFIG_DEBUG_FS
diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 18024ff770f8..7eb1e6efd567 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -24,9 +24,14 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
 	struct sdw_master_prop *prop = NULL;
 	int ret;
 
-	if (!bus->dev) {
-		pr_err("SoundWire bus has no device\n");
-		return -ENODEV;
+	if (!bus)
+		return -EINVAL;
+
+	ret = sdw_master_device_add(bus, parent, fwnode);
+	if (ret) {
+		dev_err(parent, "Failed to add master device at link %d\n",
+			bus->link_id);
+		return ret;
 	}
 
 	if (!bus->ops) {
@@ -142,6 +147,7 @@ static int sdw_delete_slave(struct device *dev, void *data)
 void sdw_bus_master_delete(struct sdw_bus *bus)
 {
 	device_for_each_child(bus->dev, NULL, sdw_delete_slave);
+	sdw_master_device_del(bus);
 
 	sdw_bus_debugfs_exit(bus);
 }
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 204204a26db8..93ab0234a491 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -19,6 +19,9 @@ static inline int sdw_acpi_find_slaves(struct sdw_bus *bus)
 int sdw_of_find_slaves(struct sdw_bus *bus);
 void sdw_extract_slave_id(struct sdw_bus *bus,
 			  u64 addr, struct sdw_slave_id *id);
+int sdw_master_device_add(struct sdw_bus *bus, struct device *parent,
+			  struct fwnode_handle *fwnode);
+int sdw_master_device_del(struct sdw_bus *bus);
 
 #ifdef CONFIG_DEBUG_FS
 void sdw_bus_debugfs_init(struct sdw_bus *bus);
diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
new file mode 100644
index 000000000000..2eeb2d7f56e0
--- /dev/null
+++ b/drivers/soundwire/master.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2019-2020 Intel Corporation.
+
+#include <linux/device.h>
+#include <linux/acpi.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_type.h>
+#include "bus.h"
+
+/* nothing to free but this function is mandatory */
+static void sdw_master_device_release(struct device *dev)
+{
+}
+
+struct device_type sdw_master_type = {
+	.name =		"soundwire_master",
+	.release =	sdw_master_device_release,
+};
+
+/**
+ * sdw_master_device_add() - create a Linux Master Device representation.
+ * @bus: SDW bus instance
+ * @parent: parent device
+ * @fwnode: firmware node handle
+ */
+int sdw_master_device_add(struct sdw_bus *bus, struct device *parent,
+			  struct fwnode_handle *fwnode)
+{
+	struct sdw_master_device *md;
+	int ret;
+
+	if (!bus)
+		return -EINVAL;
+
+	/*
+	 * Unlike traditional devices, there's no allocation here since the
+	 * sdw_master_device is embedded in the bus structure.
+	 */
+	md = &bus->md;
+	md->dev.bus = &sdw_bus_type;
+	md->dev.type = &sdw_master_type;
+	md->dev.parent = parent;
+	md->dev.of_node = parent->of_node;
+	md->dev.fwnode = fwnode;
+	md->dev.dma_mask = parent->dma_mask;
+
+	dev_set_name(&md->dev, "sdw-master-%d", bus->link_id);
+
+	ret = device_register(&md->dev);
+	if (ret) {
+		dev_err(parent, "Failed to add master: ret %d\n", ret);
+		/*
+		 * On err, don't free but drop ref as this will be freed
+		 * when release method is invoked.
+		 */
+		put_device(&md->dev);
+		goto device_register_err;
+	}
+
+	/* add shortcuts to improve code readability/compactness */
+	md->bus = bus;
+	bus->dev = &md->dev;
+
+device_register_err:
+	return ret;
+}
+
+/**
+ * sdw_master_device_del() - delete a Linux Master Device representation.
+ * @bus: bus handle
+ *
+ * This function is the dual of sdw_master_device_add()
+ */
+int sdw_master_device_del(struct sdw_bus *bus)
+{
+	device_unregister(bus->dev);
+
+	return 0;
+}
diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 401811d6627e..1c335ab1cd3f 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -784,7 +784,6 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	mutex_init(&ctrl->port_lock);
 	INIT_WORK(&ctrl->slave_work, qcom_swrm_slave_wq);
 
-	ctrl->bus.dev = dev;
 	ctrl->bus.ops = &qcom_swrm_ops;
 	ctrl->bus.port_ops = &qcom_swrm_port_ops;
 	ctrl->bus.compute_params = &qcom_swrm_compute_params;
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 2003e8c55538..071adf2b463f 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -632,6 +632,19 @@ struct sdw_slave {
 
 #define dev_to_sdw_dev(_dev) container_of(_dev, struct sdw_slave, dev)
 
+/**
+ * struct sdw_master_device - SoundWire 'Master Device' representation
+ * @dev: Linux device for this Master
+ * @bus: Bus handle shortcut to improve readability (same as container_of)
+ */
+struct sdw_master_device {
+	struct device dev;
+	struct sdw_bus *bus;
+};
+
+#define dev_to_sdw_master_device(d)	\
+	container_of(d, struct sdw_master_device, dev)
+
 struct sdw_driver {
 	const char *name;
 
@@ -787,7 +800,8 @@ struct sdw_master_ops {
 
 /**
  * struct sdw_bus - SoundWire bus
- * @dev: Master linux device
+ * @dev: shortcut to &md->dev to improve readability
+ * @md: Master device
  * @link_id: Link id number, can be 0 to N, unique for each Master
  * @slaves: list of Slaves on this bus
  * @assigned: Bitmap for Slave device numbers.
@@ -812,6 +826,7 @@ struct sdw_master_ops {
  */
 struct sdw_bus {
 	struct device *dev;
+	struct sdw_master_device md;
 	unsigned int link_id;
 	struct list_head slaves;
 	DECLARE_BITMAP(assigned, SDW_MAX_DEVICES);
-- 
2.17.1

