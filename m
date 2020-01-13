Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8735C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DF9207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgAMW45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 17:56:57 -0500
Received: from mga03.intel.com ([134.134.136.65]:59925 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728833AbgAMW45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:56:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 14:56:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,430,1571727600"; 
   d="scan'208";a="304974676"
Received: from pboliset-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.152.72])
  by orsmga001.jf.intel.com with ESMTP; 13 Jan 2020 14:56:55 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH] soundwire: bus: fix device number leak on errors
Date:   Mon, 13 Jan 2020 16:56:37 -0600
Message-Id: <20200113225637.17313-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the programming of the dev_number fails due to an IO error, a new
device_number will be assigned, resulting in a leak.

Make sure we only assign a device_number once per Slave device.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c       | 37 ++++++++++++++++++++++-------------
 include/linux/soundwire/sdw.h |  4 +++-
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index be5d437058ed..8f973e70e6f7 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -456,26 +456,35 @@ static int sdw_get_device_num(struct sdw_slave *slave)
 static int sdw_assign_device_num(struct sdw_slave *slave)
 {
 	int ret, dev_num;
+	bool new_device = false;
 
 	/* check first if device number is assigned, if so reuse that */
 	if (!slave->dev_num) {
-		mutex_lock(&slave->bus->bus_lock);
-		dev_num = sdw_get_device_num(slave);
-		mutex_unlock(&slave->bus->bus_lock);
-		if (dev_num < 0) {
-			dev_err(slave->bus->dev, "Get dev_num failed: %d\n",
-				dev_num);
-			return dev_num;
+		if (!slave->dev_num_sticky) {
+			mutex_lock(&slave->bus->bus_lock);
+			dev_num = sdw_get_device_num(slave);
+			mutex_unlock(&slave->bus->bus_lock);
+			if (dev_num < 0) {
+				dev_err(slave->bus->dev, "Get dev_num failed: %d\n",
+					dev_num);
+				return dev_num;
+			}
+			slave->dev_num = dev_num;
+			slave->dev_num_sticky = dev_num;
+			new_device = true;
+		} else {
+			slave->dev_num = slave->dev_num_sticky;
 		}
-	} else {
+	}
+
+	if (!new_device)
 		dev_info(slave->bus->dev,
-			 "Slave already registered dev_num:%d\n",
+			 "Slave already registered, reusing dev_num:%d\n",
 			 slave->dev_num);
 
-		/* Clear the slave->dev_num to transfer message on device 0 */
-		dev_num = slave->dev_num;
-		slave->dev_num = 0;
-	}
+	/* Clear the slave->dev_num to transfer message on device 0 */
+	dev_num = slave->dev_num;
+	slave->dev_num = 0;
 
 	ret = sdw_write(slave, SDW_SCP_DEVNUMBER, dev_num);
 	if (ret < 0) {
@@ -485,7 +494,7 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
 	}
 
 	/* After xfer of msg, restore dev_num */
-	slave->dev_num = dev_num;
+	slave->dev_num = slave->dev_num_sticky;
 
 	return 0;
 }
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index b7c9eca4332a..b451bb622335 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -546,7 +546,8 @@ struct sdw_slave_ops {
  * @debugfs: Slave debugfs
  * @node: node for bus list
  * @port_ready: Port ready completion flag for each Slave port
- * @dev_num: Device Number assigned by Bus
+ * @dev_num: Current Device Number, values can be 0 or dev_num_sticky
+ * @dev_num_sticky: one-time static Device Number assigned by Bus
  * @probed: boolean tracking driver state
  * @probe_complete: completion utility to control potential races
  * on startup between driver probe/initialization and SoundWire
@@ -575,6 +576,7 @@ struct sdw_slave {
 	struct list_head node;
 	struct completion *port_ready;
 	u16 dev_num;
+	u16 dev_num_sticky;
 	bool probed;
 	struct completion probe_complete;
 	struct completion enumeration_complete;
-- 
2.20.1

