Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74105C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 586BC20786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgHZJ0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:26:15 -0400
Received: from inva021.nxp.com ([92.121.34.21]:43304 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727991AbgHZJ0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:26:05 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 767372007C6;
        Wed, 26 Aug 2020 11:26:03 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 69D432007B4;
        Wed, 26 Aug 2020 11:26:03 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0D5772030A;
        Wed, 26 Aug 2020 11:26:03 +0200 (CEST)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, bharatb.linux@gmail.com,
        Bharat Bhushan <Bharat.Bhushan@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v4 03/13] bus/fsl-mc: add support for 'driver_override' in the mc-bus
Date:   Wed, 26 Aug 2020 12:25:17 +0300
Message-Id: <20200826092527.4992-4-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826092527.4992-1-diana.craciun@oss.nxp.com>
References: <20200826092527.4992-1-diana.craciun@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bharat Bhushan <Bharat.Bhushan@nxp.com>

This patch is required for vfio-fsl-mc meta driver to successfully bind
layerscape container devices for device passthrough. This patch adds
a mechanism to allow a layerscape device to specify a driver rather than
a layerscape driver provide a device match.

Example to allow a device (dprc.1) to specifically bind
with driver (vfio-fsl-mc):-
 - echo vfio-fsl-mc > /sys/bus/fsl-mc/devices/dprc.1/driver_override
 - echo dprc.1 > /sys/bus/fsl-mc/drivers/fsl_mc_dprc/unbind
 - echo dprc.1 > /sys/bus/fsl-mc/drivers/vfio-fsl-mc/bind

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---

The patche do not address the comment regarding moving driver_override
in the core code. I prefer not to tie these patches on that change and
address that separately.

 drivers/bus/fsl-mc/fsl-mc-bus.c | 54 +++++++++++++++++++++++++++++++++
 include/linux/fsl/mc.h          |  2 ++
 2 files changed, 56 insertions(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index b69794e7364d..9a884936e53e 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -3,6 +3,7 @@
  * Freescale Management Complex (MC) bus driver
  *
  * Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
+ * Copyright 2019-2020 NXP
  * Author: German Rivera <German.Rivera@freescale.com>
  *
  */
@@ -78,6 +79,12 @@ static int fsl_mc_bus_match(struct device *dev, struct device_driver *drv)
 	struct fsl_mc_driver *mc_drv = to_fsl_mc_driver(drv);
 	bool found = false;
 
+	/* When driver_override is set, only bind to the matching driver */
+	if (mc_dev->driver_override) {
+		found = !strcmp(mc_dev->driver_override, mc_drv->driver.name);
+		goto out;
+	}
+
 	if (!mc_drv->match_id_table)
 		goto out;
 
@@ -147,8 +154,52 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(modalias);
 
+static ssize_t driver_override_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
+	char *driver_override, *old = mc_dev->driver_override;
+	char *cp;
+
+	if (WARN_ON(dev->bus != &fsl_mc_bus_type))
+		return -EINVAL;
+
+	if (count >= (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	driver_override = kstrndup(buf, count, GFP_KERNEL);
+	if (!driver_override)
+		return -ENOMEM;
+
+	cp = strchr(driver_override, '\n');
+	if (cp)
+		*cp = '\0';
+
+	if (strlen(driver_override)) {
+		mc_dev->driver_override = driver_override;
+	} else {
+		kfree(driver_override);
+		mc_dev->driver_override = NULL;
+	}
+
+	kfree(old);
+
+	return count;
+}
+
+static ssize_t driver_override_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", mc_dev->driver_override);
+}
+static DEVICE_ATTR_RW(driver_override);
+
 static struct attribute *fsl_mc_dev_attrs[] = {
 	&dev_attr_modalias.attr,
+	&dev_attr_driver_override.attr,
 	NULL,
 };
 
@@ -748,6 +799,9 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_add);
  */
 void fsl_mc_device_remove(struct fsl_mc_device *mc_dev)
 {
+	kfree(mc_dev->driver_override);
+	mc_dev->driver_override = NULL;
+
 	/*
 	 * The device-specific remove callback will get invoked by device_del()
 	 */
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index a428c61ead6e..3b5f0c98636d 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -161,6 +161,7 @@ struct fsl_mc_obj_desc {
  * @regions: pointer to array of MMIO region entries
  * @irqs: pointer to array of pointers to interrupts allocated to this device
  * @resource: generic resource associated with this MC object device, if any.
+ * @driver_override: driver name to force a match
  *
  * Generic device object for MC object devices that are "attached" to a
  * MC bus.
@@ -194,6 +195,7 @@ struct fsl_mc_device {
 	struct fsl_mc_device_irq **irqs;
 	struct fsl_mc_resource *resource;
 	struct device_link *consumer_link;
+	char   *driver_override;
 };
 
 #define to_fsl_mc_device(_dev) \
-- 
2.17.1

