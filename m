Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCD8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 02:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8CC62067C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 02:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgHSCBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 22:01:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:3722 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbgHSCBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 22:01:08 -0400
IronPort-SDR: l/rXcacGhSKmBfkoYR+ediUY0p1SbbxeBJQVykJuJwy7clDjzvFLVXZB2v1P+yDPvpuH8l7itJ
 rRBLVxmG1cjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="152449477"
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="152449477"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 19:01:07 -0700
IronPort-SDR: SIAdkWuIIxsqZe7/XmKD4G1JW/5hilC1/KKHBGsR64o3mDAWXgaBfCEO3k4qW0n/cStSf/QsC5
 DB0OSGc1aAsg==
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="279565140"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 19:01:03 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 6/7] soundwire: bus: export broadcast read/write capability for tests
Date:   Tue, 18 Aug 2020 22:06:55 +0800
Message-Id: <20200818140656.29014-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
References: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Provide prototype and export symbol to enable tests. The bus lock is
handled externally to avoid conflicts e.g. between kernel-generated
traffic and test traffic.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 56 +++++++++++++++++++++++++++++++++++------
 drivers/soundwire/bus.h |  4 +++
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 869290a8db40..2e08e8f8b9aa 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -255,6 +255,21 @@ static int sdw_reset_page(struct sdw_bus *bus, u16 dev_num)
 	return ret;
 }
 
+static int sdw_transfer_unlocked(struct sdw_bus *bus, struct sdw_msg *msg)
+{
+	int ret;
+
+	ret = do_transfer(bus, msg);
+	if (ret != 0 && ret != -ENODATA)
+		dev_err(bus->dev, "trf on Slave %d failed:%d\n",
+			msg->dev_num, ret);
+
+	if (msg->page)
+		sdw_reset_page(bus, msg->dev_num);
+
+	return ret;
+}
+
 /**
  * sdw_transfer() - Synchronous transfer message to a SDW Slave device
  * @bus: SDW bus
@@ -266,13 +281,7 @@ int sdw_transfer(struct sdw_bus *bus, struct sdw_msg *msg)
 
 	mutex_lock(&bus->msg_lock);
 
-	ret = do_transfer(bus, msg);
-	if (ret != 0 && ret != -ENODATA)
-		dev_err(bus->dev, "trf on Slave %d failed:%d\n",
-			msg->dev_num, ret);
-
-	if (msg->page)
-		sdw_reset_page(bus, msg->dev_num);
+	ret = sdw_transfer_unlocked(bus, msg);
 
 	mutex_unlock(&bus->msg_lock);
 
@@ -428,6 +437,39 @@ sdw_bwrite_no_pm(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 value)
 	return sdw_transfer(bus, &msg);
 }
 
+int sdw_bread_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr)
+{
+	struct sdw_msg msg;
+	u8 buf;
+	int ret;
+
+	ret = sdw_fill_msg(&msg, NULL, addr, 1, dev_num,
+			   SDW_MSG_FLAG_READ, &buf);
+	if (ret)
+		return ret;
+
+	ret = sdw_transfer_unlocked(bus, &msg);
+	if (ret < 0)
+		return ret;
+
+	return buf;
+}
+EXPORT_SYMBOL(sdw_bread_no_pm_unlocked);
+
+int sdw_bwrite_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 value)
+{
+	struct sdw_msg msg;
+	int ret;
+
+	ret = sdw_fill_msg(&msg, NULL, addr, 1, dev_num,
+			   SDW_MSG_FLAG_WRITE, &value);
+	if (ret)
+		return ret;
+
+	return sdw_transfer_unlocked(bus, &msg);
+}
+EXPORT_SYMBOL(sdw_bwrite_no_pm_unlocked);
+
 static int
 sdw_read_no_pm(struct sdw_slave *slave, u32 addr)
 {
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 82484f741168..c53345fbc4c7 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -168,6 +168,10 @@ sdw_update(struct sdw_slave *slave, u32 addr, u8 mask, u8 val)
 	return sdw_write(slave, addr, tmp);
 }
 
+/* broadcast read/write for tests */
+int sdw_bread_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr);
+int sdw_bwrite_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 value);
+
 /*
  * At the moment we only track Master-initiated hw_reset.
  * Additional fields can be added as needed
-- 
2.17.1

