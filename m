Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19C7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C876B20708
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgESFiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 01:38:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:18092 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgESFiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:38:20 -0400
IronPort-SDR: fEU5nqemBeJe6/Ent8Iu+1VqFNRKSJ3qMdIAbCBXl4pn16qKK2bJw86op3sRuNSzNLvlRqA60U
 clcWHx4MtNTg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 22:38:20 -0700
IronPort-SDR: lHa8Znfx1O88e98NTvU1zeVfkYqnk1fJelUbCQldmBTjbWNvDWJWmvQEK+jENbUVm+iJw15fF+
 ab5ZMKvPHxnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; 
   d="scan'208";a="288836546"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga004.fm.intel.com with ESMTP; 18 May 2020 22:38:16 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 2/5] soundwire: bus_type: introduce sdw_slave_type and sdw_master_type
Date:   Tue, 19 May 2020 01:43:19 +0800
Message-Id: <20200518174322.31561-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518174322.31561-1-yung-chuan.liao@linux.intel.com>
References: <20200518174322.31561-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

this is a preparatory patch before the introduction of the
sdw_master_type. The SoundWire slave support is slightly modified with
the use of a sdw_slave_type, and the uevent handling move to
slave.c (since it's not necessary for the master).

No functionality change other than moving code around.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus_type.c       | 19 +++++++++++++------
 drivers/soundwire/slave.c          |  8 +++++++-
 include/linux/soundwire/sdw_type.h |  9 ++++++++-
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 17f096dd6806..2c1a19caba51 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -33,13 +33,21 @@ sdw_get_device_id(struct sdw_slave *slave, struct sdw_driver *drv)
 
 static int sdw_bus_match(struct device *dev, struct device_driver *ddrv)
 {
-	struct sdw_slave *slave = dev_to_sdw_dev(dev);
-	struct sdw_driver *drv = drv_to_sdw_driver(ddrv);
+	struct sdw_slave *slave;
+	struct sdw_driver *drv;
+	int ret = 0;
+
+	if (is_sdw_slave(dev)) {
+		slave = dev_to_sdw_dev(dev);
+		drv = drv_to_sdw_driver(ddrv);
 
-	return !!sdw_get_device_id(slave, drv);
+		ret = !!sdw_get_device_id(slave, drv);
+	}
+	return ret;
 }
 
-int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size)
+static int sdw_slave_modalias(const struct sdw_slave *slave, char *buf,
+			      size_t size)
 {
 	/* modalias is sdw:m<mfg_id>p<part_id> */
 
@@ -47,7 +55,7 @@ int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size)
 			slave->id.mfg_id, slave->id.part_id);
 }
 
-static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
+int sdw_slave_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
 	char modalias[32];
@@ -63,7 +71,6 @@ static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
 struct bus_type sdw_bus_type = {
 	.name = "soundwire",
 	.match = sdw_bus_match,
-	.uevent = sdw_uevent,
 };
 EXPORT_SYMBOL_GPL(sdw_bus_type);
 
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index aace57fae7f8..ed068a004bd9 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -14,6 +14,12 @@ static void sdw_slave_release(struct device *dev)
 	kfree(slave);
 }
 
+struct device_type sdw_slave_type = {
+	.name =		"sdw_slave",
+	.release =	sdw_slave_release,
+	.uevent =	sdw_slave_uevent,
+};
+
 static int sdw_slave_add(struct sdw_bus *bus,
 			 struct sdw_slave_id *id, struct fwnode_handle *fwnode)
 {
@@ -41,9 +47,9 @@ static int sdw_slave_add(struct sdw_bus *bus,
 			     id->class_id, id->unique_id);
 	}
 
-	slave->dev.release = sdw_slave_release;
 	slave->dev.bus = &sdw_bus_type;
 	slave->dev.of_node = of_node_get(to_of_node(fwnode));
+	slave->dev.type = &sdw_slave_type;
 	slave->bus = bus;
 	slave->status = SDW_SLAVE_UNATTACHED;
 	init_completion(&slave->enumeration_complete);
diff --git a/include/linux/soundwire/sdw_type.h b/include/linux/soundwire/sdw_type.h
index aaa7f4267c14..52eb66cd11bc 100644
--- a/include/linux/soundwire/sdw_type.h
+++ b/include/linux/soundwire/sdw_type.h
@@ -5,6 +5,13 @@
 #define __SOUNDWIRE_TYPES_H
 
 extern struct bus_type sdw_bus_type;
+extern struct device_type sdw_slave_type;
+extern struct device_type sdw_master_type;
+
+static inline int is_sdw_slave(const struct device *dev)
+{
+	return dev->type == &sdw_slave_type;
+}
 
 #define drv_to_sdw_driver(_drv) container_of(_drv, struct sdw_driver, driver)
 
@@ -14,7 +21,7 @@ extern struct bus_type sdw_bus_type;
 int __sdw_register_driver(struct sdw_driver *drv, struct module *owner);
 void sdw_unregister_driver(struct sdw_driver *drv);
 
-int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
+int sdw_slave_uevent(struct device *dev, struct kobj_uevent_env *env);
 
 /**
  * module_sdw_driver() - Helper macro for registering a Soundwire driver
-- 
2.17.1

