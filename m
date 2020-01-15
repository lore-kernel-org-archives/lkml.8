Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F178C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 00:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D33824679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 00:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgAOAKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 19:10:02 -0500
Received: from mga01.intel.com ([192.55.52.88]:8662 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbgAOAJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 19:09:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 16:09:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,320,1574150400"; 
   d="scan'208";a="273468595"
Received: from emkilgox-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.0.151])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jan 2020 16:09:52 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 08/10] soundwire: bus: fix io error when processing alert event
Date:   Tue, 14 Jan 2020 18:08:42 -0600
Message-Id: <20200115000844.14695-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200115000844.14695-1-pierre-louis.bossart@linux.intel.com>
References: <20200115000844.14695-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@intel.com>

There are two types of io errors when processing alert event.

a) the Master detects an ALERT status for e.g. a jack event and
invokes the implementation-defined function in the Slave driver to
check the jack status. At this time the codec is just suspended, so io
registers can't be accessed.

b) when waking up from clock stop mode1 state, where the bus needs a
complete re-enumeration, Slave registers can't be accessed until the
enumeration is complete.

This patch resumes the Slave device and waits for initialization
complete when processing slave alert event, so that registers on the
Slave can be accessed without timeouts or io errors.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 33bb273454cf..23bc24c8e9d1 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -890,12 +890,19 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 
 	sdw_modify_slave_status(slave, SDW_SLAVE_ALERT);
 
+	ret = pm_runtime_get_sync(&slave->dev);
+	if (ret < 0 && ret != -EACCES) {
+		dev_err(&slave->dev, "Failed to resume device: %d\n", ret);
+		pm_runtime_put_noidle(slave->bus->dev);
+		return ret;
+	}
+
 	/* Read Instat 1, Instat 2 and Instat 3 registers */
 	ret = sdw_read(slave, SDW_SCP_INT1);
 	if (ret < 0) {
 		dev_err(slave->bus->dev,
 			"SDW_SCP_INT1 read failed:%d\n", ret);
-		return ret;
+		goto io_err;
 	}
 	buf = ret;
 
@@ -903,7 +910,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	if (ret < 0) {
 		dev_err(slave->bus->dev,
 			"SDW_SCP_INT2/3 read failed:%d\n", ret);
-		return ret;
+		goto io_err;
 	}
 
 	do {
@@ -983,7 +990,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		if (ret < 0) {
 			dev_err(slave->bus->dev,
 				"SDW_SCP_INT1 write failed:%d\n", ret);
-			return ret;
+			goto io_err;
 		}
 
 		/*
@@ -994,7 +1001,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		if (ret < 0) {
 			dev_err(slave->bus->dev,
 				"SDW_SCP_INT1 read failed:%d\n", ret);
-			return ret;
+			goto io_err;
 		}
 		_buf = ret;
 
@@ -1002,7 +1009,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		if (ret < 0) {
 			dev_err(slave->bus->dev,
 				"SDW_SCP_INT2/3 read failed:%d\n", ret);
-			return ret;
+			goto io_err;
 		}
 
 		/* Make sure no interrupts are pending */
@@ -1023,6 +1030,10 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	if (count == SDW_READ_INTR_CLEAR_RETRY)
 		dev_warn(slave->bus->dev, "Reached MAX_RETRY on alert read\n");
 
+io_err:
+	pm_runtime_mark_last_busy(&slave->dev);
+	pm_runtime_put_autosuspend(&slave->dev);
+
 	return ret;
 }
 
-- 
2.20.1

