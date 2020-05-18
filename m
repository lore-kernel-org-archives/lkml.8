Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89916C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 697AE207D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgESFiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 01:38:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:18092 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgESFiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:38:25 -0400
IronPort-SDR: HKlnTcg0nKvREJ6/lB1/1Ey1Fu6RRAXrXjFv8NUXDqqv6elMBnRD1BL6RrozJqPLT2CeU8wf9D
 60Q/ZNfL6ayg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 22:38:24 -0700
IronPort-SDR: tBKYjLeBqzgaLsxqg4erk2WPHigFqqhPGPQD8amOevMp+6HwX2shKqEDBC+OhhfgBya8z+/HLb
 pbcFj3QHp8MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; 
   d="scan'208";a="288836565"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga004.fm.intel.com with ESMTP; 18 May 2020 22:38:20 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 3/5] soundwire: bus: add unique bus id
Date:   Tue, 19 May 2020 01:43:20 +0800
Message-Id: <20200518174322.31561-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518174322.31561-1-yung-chuan.liao@linux.intel.com>
References: <20200518174322.31561-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding an unique id for each bus.

Suggested-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c       | 20 ++++++++++++++++++++
 include/linux/soundwire/sdw.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 24064dbd74fa..2d24f183061d 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -9,6 +9,19 @@
 #include <linux/soundwire/sdw.h>
 #include "bus.h"
 
+static DEFINE_IDA(sdw_ida);
+
+static int sdw_get_id(struct sdw_bus *bus)
+{
+	int rc = ida_alloc(&sdw_ida, GFP_KERNEL);
+
+	if (rc < 0)
+		return rc;
+
+	bus->id = rc;
+	return 0;
+}
+
 /**
  * sdw_bus_master_add() - add a bus Master instance
  * @bus: bus instance
@@ -29,6 +42,12 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
 		return -ENODEV;
 	}
 
+	ret = sdw_get_id(bus);
+	if (ret) {
+		dev_err(bus->dev, "Failed to get bus id\n");
+		return ret;
+	}
+
 	if (!bus->ops) {
 		dev_err(bus->dev, "SoundWire Bus ops are not set\n");
 		return -EINVAL;
@@ -144,6 +163,7 @@ void sdw_bus_master_delete(struct sdw_bus *bus)
 	device_for_each_child(bus->dev, NULL, sdw_delete_slave);
 
 	sdw_bus_debugfs_exit(bus);
+	ida_free(&sdw_ida, bus->id);
 }
 EXPORT_SYMBOL(sdw_bus_master_delete);
 
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 2003e8c55538..a32cb26f1815 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -789,6 +789,7 @@ struct sdw_master_ops {
  * struct sdw_bus - SoundWire bus
  * @dev: Master linux device
  * @link_id: Link id number, can be 0 to N, unique for each Master
+ * @id: bus system-wide unique id
  * @slaves: list of Slaves on this bus
  * @assigned: Bitmap for Slave device numbers.
  * Bit set implies used number, bit clear implies unused number.
@@ -813,6 +814,7 @@ struct sdw_master_ops {
 struct sdw_bus {
 	struct device *dev;
 	unsigned int link_id;
+	int id;
 	struct list_head slaves;
 	DECLARE_BITMAP(assigned, SDW_MAX_DEVICES);
 	struct mutex bus_lock;
-- 
2.17.1

