Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C8AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDCBE2078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgFIItM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 04:49:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:44000 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbgFIItJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:49:09 -0400
IronPort-SDR: 1/dOh2lAYY5iYw16DLslSodYoRbqyAlYlAzGR68rTO+ZYW+QCPbZaX9ei6d7qRCdFFp0PaRvmz
 UHBNoKnx4IFQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 01:49:05 -0700
IronPort-SDR: c/pu5iXOQJBKDdH0B1f+WcWAWHrY798dGB08yhusPRw/ffX3C126nXcV/+wK1bozSpGZ76vUYO
 0z3hIIDHnyTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="473001917"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jun 2020 01:49:00 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 3/4] soundwire: extend SDW_SLAVE_ENTRY
Date:   Tue,  9 Jun 2020 04:54:35 +0800
Message-Id: <20200608205436.2402-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608205436.2402-1-yung-chuan.liao@linux.intel.com>
References: <20200608205436.2402-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The SoundWire 1.2 specification adds new capabilities that were not
present in previous version, such as the class ID.

To enable support for class drivers, and well as drivers that address
a specific version, all fields of the sdw_device_id structure need to
be exposed. For SoundWire 1.0 and 1.1 devices, a wildcard is used so
class and version information are ignored.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus_type.c      | 13 +++++++++----
 include/linux/mod_devicetable.h   |  2 ++
 include/linux/soundwire/sdw.h     | 11 +++++++----
 scripts/mod/devicetable-offsets.c |  2 ++
 scripts/mod/file2alias.c          |  6 +++++-
 5 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index c8d948c09d9d..6fba55898cf0 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -24,7 +24,11 @@ sdw_get_device_id(struct sdw_slave *slave, struct sdw_driver *drv)
 
 	for (id = drv->id_table; id && id->mfg_id; id++)
 		if (slave->id.mfg_id == id->mfg_id &&
-		    slave->id.part_id == id->part_id)
+		    slave->id.part_id == id->part_id  &&
+		    (!id->sdw_version ||
+		     slave->id.sdw_version == id->sdw_version) &&
+		    (!id->class_id ||
+		     slave->id.class_id == id->class_id))
 			return id;
 
 	return NULL;
@@ -47,10 +51,11 @@ static int sdw_bus_match(struct device *dev, struct device_driver *ddrv)
 
 int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size)
 {
-	/* modalias is sdw:m<mfg_id>p<part_id> */
+	/* modalias is sdw:m<mfg_id>p<part_id>v<version>c<class_id> */
 
-	return snprintf(buf, size, "sdw:m%04Xp%04X\n",
-			slave->id.mfg_id, slave->id.part_id);
+	return snprintf(buf, size, "sdw:m%04Xp%04Xv%02Xc%02X\n",
+			slave->id.mfg_id, slave->id.part_id,
+			slave->id.sdw_version, slave->id.class_id);
 }
 
 int sdw_slave_uevent(struct device *dev, struct kobj_uevent_env *env)
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 4c2ddd0941a7..a4969b13477b 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -251,6 +251,8 @@ struct hda_device_id {
 struct sdw_device_id {
 	__u16 mfg_id;
 	__u16 part_id;
+	__u8  sdw_version;
+	__u8  class_id;
 	kernel_ulong_t driver_data;
 };
 
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 9c27a32df9bb..64c9314cb903 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -426,8 +426,7 @@ int sdw_slave_read_prop(struct sdw_slave *slave);
  * struct sdw_slave_id - Slave ID
  * @mfg_id: MIPI Manufacturer ID
  * @part_id: Device Part ID
- * @class_id: MIPI Class ID, unused now.
- * Currently a placeholder in MIPI SoundWire Spec
+ * @class_id: MIPI Class ID (defined starting with SoundWire 1.2 spec)
  * @unique_id: Device unique ID
  * @sdw_version: SDW version implemented
  *
@@ -659,10 +658,14 @@ struct sdw_driver {
 	struct device_driver driver;
 };
 
-#define SDW_SLAVE_ENTRY(_mfg_id, _part_id, _drv_data) \
-	{ .mfg_id = (_mfg_id), .part_id = (_part_id), \
+#define SDW_SLAVE_ENTRY_EXT(_mfg_id, _part_id, _version, _c_id, _drv_data) \
+	{ .mfg_id = (_mfg_id), .part_id = (_part_id),		\
+	  .sdw_version = (_version), .class_id = (_c_id),	\
 	  .driver_data = (unsigned long)(_drv_data) }
 
+#define SDW_SLAVE_ENTRY(_mfg_id, _part_id, _drv_data)	\
+	SDW_SLAVE_ENTRY_EXT((_mfg_id), (_part_id), 0, 0, (_drv_data))
+
 int sdw_handle_slave_status(struct sdw_bus *bus,
 			enum sdw_slave_status status[]);
 
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 010be8ba2116..27007c18e754 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -216,6 +216,8 @@ int main(void)
 	DEVID(sdw_device_id);
 	DEVID_FIELD(sdw_device_id, mfg_id);
 	DEVID_FIELD(sdw_device_id, part_id);
+	DEVID_FIELD(sdw_device_id, sdw_version);
+	DEVID_FIELD(sdw_device_id, class_id);
 
 	DEVID(fsl_mc_device_id);
 	DEVID_FIELD(fsl_mc_device_id, vendor);
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 02d5d79da284..330eb599e64a 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1256,15 +1256,19 @@ static int do_hda_entry(const char *filename, void *symval, char *alias)
 	return 1;
 }
 
-/* Looks like: sdw:mNpN */
+/* Looks like: sdw:mNpNvNcN */
 static int do_sdw_entry(const char *filename, void *symval, char *alias)
 {
 	DEF_FIELD(symval, sdw_device_id, mfg_id);
 	DEF_FIELD(symval, sdw_device_id, part_id);
+	DEF_FIELD(symval, sdw_device_id, sdw_version);
+	DEF_FIELD(symval, sdw_device_id, class_id);
 
 	strcpy(alias, "sdw:");
 	ADD(alias, "m", mfg_id != 0, mfg_id);
 	ADD(alias, "p", part_id != 0, part_id);
+	ADD(alias, "v", sdw_version != 0, sdw_version);
+	ADD(alias, "c", class_id != 0, class_id);
 
 	add_wildcard(alias);
 	return 1;
-- 
2.17.1

