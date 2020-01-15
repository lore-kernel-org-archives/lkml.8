Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8917C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 00:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C325C24679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 00:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgAOAJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 19:09:50 -0500
Received: from mga01.intel.com ([192.55.52.88]:8608 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728656AbgAOAJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 19:09:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 16:09:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,320,1574150400"; 
   d="scan'208";a="273468560"
Received: from emkilgox-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.0.151])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jan 2020 16:09:42 -0800
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
Subject: [PATCH 04/10] soundwire: bus: add PM/no-PM versions of read/write functions
Date:   Tue, 14 Jan 2020 18:08:38 -0600
Message-Id: <20200115000844.14695-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200115000844.14695-1-pierre-louis.bossart@linux.intel.com>
References: <20200115000844.14695-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for pm_runtime with the appropriate error checks for
sdw_write/read functions, e.g. when pm_runtime is not supported.

Also expose internal functions without pm_runtime support, which are
required to perform any sort of suspend/resume operation, as well as
any enumeration tasks.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c | 68 +++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 16 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index ea04cf5f5bdc..c525b9b50453 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -317,6 +317,46 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
 	return 0;
 }
 
+/*
+ * Read/Write IO functions.
+ * no_pm versions can only be called by the bus, e.g. while enumerating or
+ * handling suspend-resume sequences.
+ * all clients need to use the pm versions
+ */
+
+static int
+sdw_nread_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
+{
+	struct sdw_msg msg;
+	int ret;
+
+	ret = sdw_fill_msg(&msg, slave, addr, count,
+			   slave->dev_num, SDW_MSG_FLAG_READ, val);
+	if (ret < 0)
+		return ret;
+
+	return sdw_transfer(slave->bus, &msg);
+}
+
+static int
+sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
+{
+	struct sdw_msg msg;
+	int ret;
+
+	ret = sdw_fill_msg(&msg, slave, addr, count,
+			   slave->dev_num, SDW_MSG_FLAG_WRITE, val);
+	if (ret < 0)
+		return ret;
+
+	return sdw_transfer(slave->bus, &msg);
+}
+
+static int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value)
+{
+	return sdw_nwrite_no_pm(slave, addr, 1, &value);
+}
+
 /**
  * sdw_nread() - Read "n" contiguous SDW Slave registers
  * @slave: SDW Slave
@@ -326,19 +366,17 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
  */
 int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 {
-	struct sdw_msg msg;
 	int ret;
 
-	ret = sdw_fill_msg(&msg, slave, addr, count,
-			   slave->dev_num, SDW_MSG_FLAG_READ, val);
-	if (ret < 0)
-		return ret;
-
 	ret = pm_runtime_get_sync(slave->bus->dev);
-	if (ret < 0)
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_noidle(slave->bus->dev);
 		return ret;
+	}
+
+	ret = sdw_nread_no_pm(slave, addr, count, val);
 
-	ret = sdw_transfer(slave->bus, &msg);
+	pm_runtime_mark_last_busy(slave->bus->dev);
 	pm_runtime_put(slave->bus->dev);
 
 	return ret;
@@ -354,19 +392,17 @@ EXPORT_SYMBOL(sdw_nread);
  */
 int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 {
-	struct sdw_msg msg;
 	int ret;
 
-	ret = sdw_fill_msg(&msg, slave, addr, count,
-			   slave->dev_num, SDW_MSG_FLAG_WRITE, val);
-	if (ret < 0)
-		return ret;
-
 	ret = pm_runtime_get_sync(slave->bus->dev);
-	if (ret < 0)
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_noidle(slave->bus->dev);
 		return ret;
+	}
+
+	ret = sdw_nwrite_no_pm(slave, addr, count, val);
 
-	ret = sdw_transfer(slave->bus, &msg);
+	pm_runtime_mark_last_busy(slave->bus->dev);
 	pm_runtime_put(slave->bus->dev);
 
 	return ret;
-- 
2.20.1

