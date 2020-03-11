Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A267C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9385206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbgCKSly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:41:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:27194 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730929AbgCKSlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:41:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 11:41:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="441776240"
Received: from fjan-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.25.157])
  by fmsmga005.fm.intel.com with ESMTP; 11 Mar 2020 11:41:47 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Rander Wang <rander.wang@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 05/16] soundwire: cadence: add clock_stop/restart routines
Date:   Wed, 11 Mar 2020 13:41:17 -0500
Message-Id: <20200311184128.4212-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
References: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@intel.com>

Add support for clock stop and restart, with two configuration
parameters:

1) when entering the ClockStop mode, Slave-initiated wakes can be
prevented.

2) When exiting the ClockStop mode, the caller can request a Bus Reset
(either if all Slaves were configured in ClockStopMode1 or the Master
IP lost context and enumeration is required)

The code handles the case where no Slaves are present by configuring
the IP to treat COMMAND_IGNORED as success.

The exit_reset part can be dealt with in the caller, along with the
required syncArm/syncGo sequence in multi-link mode.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 161 ++++++++++++++++++++++++++++-
 drivers/soundwire/cadence_master.h |   2 +
 2 files changed, 162 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 4089c271305a..1ec537b2789f 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -225,12 +225,30 @@ static int cdns_clear_bit(struct sdw_cdns *cdns, int offset, u32 value)
 			return 0;
 
 		timeout--;
-		udelay(50);
+		usleep_range(50, 100);
 	} while (timeout != 0);
 
 	return -EAGAIN;
 }
 
+static int cdns_set_wait(struct sdw_cdns *cdns, int offset, u32 mask, u32 value)
+{
+	int timeout = 10;
+	u32 reg_read;
+
+	/* Wait for bit to be set */
+	do {
+		reg_read = readl(cdns->registers + offset);
+		if ((reg_read & mask) == value)
+			return 0;
+
+		timeout--;
+		usleep_range(50, 100);
+	} while (timeout != 0);
+
+	return -ETIMEDOUT;
+}
+
 /*
  * all changes to the MCP_CONFIG, MCP_CONTROL, MCP_CMDCTRL and MCP_PHYCTRL
  * need to be confirmed with a write to MCP_CONFIG_UPDATE
@@ -1231,6 +1249,147 @@ bool sdw_cdns_is_clock_stop(struct sdw_cdns *cdns)
 }
 EXPORT_SYMBOL(sdw_cdns_is_clock_stop);
 
+/**
+ * sdw_cdns_clock_stop: Cadence clock stop configuration routine
+ *
+ * @cdns: Cadence instance
+ * @block_wake: prevent wakes if required by the platform
+ */
+int sdw_cdns_clock_stop(struct sdw_cdns *cdns, bool block_wake)
+{
+	bool slave_present = false;
+	struct sdw_slave *slave;
+	u32 status;
+	int ret;
+
+	/* Check suspend status */
+	status = cdns_readl(cdns, CDNS_MCP_STAT);
+	if (status & CDNS_MCP_STAT_CLK_STOP) {
+		dev_dbg(cdns->dev, "Clock is already stopped\n");
+		return 1;
+	}
+
+	/*
+	 * For specific platforms, it is required to be able to put
+	 * master into a state in which it ignores wake-up trials
+	 * in clock stop state
+	 */
+	if (block_wake)
+		cdns_updatel(cdns, CDNS_MCP_CONTROL,
+			     CDNS_MCP_CONTROL_BLOCK_WAKEUP,
+			     CDNS_MCP_CONTROL_BLOCK_WAKEUP);
+
+	list_for_each_entry(slave, &cdns->bus.slaves, node) {
+		if (slave->status == SDW_SLAVE_ATTACHED ||
+		    slave->status == SDW_SLAVE_ALERT) {
+			slave_present = true;
+			break;
+		}
+	}
+
+	/*
+	 * This CMD_ACCEPT should be used when there are no devices
+	 * attached on the link when entering clock stop mode. If this is
+	 * not set and there is a broadcast write then the command ignored
+	 * will be treated as a failure
+	 */
+	if (!slave_present)
+		cdns_updatel(cdns, CDNS_MCP_CONTROL,
+			     CDNS_MCP_CONTROL_CMD_ACCEPT,
+			     CDNS_MCP_CONTROL_CMD_ACCEPT);
+	else
+		cdns_updatel(cdns, CDNS_MCP_CONTROL,
+			     CDNS_MCP_CONTROL_CMD_ACCEPT, 0);
+
+	/* commit changes */
+	ret = cdns_config_update(cdns);
+	if (ret < 0) {
+		dev_err(cdns->dev, "%s: config_update failed\n", __func__);
+		return ret;
+	}
+
+	/* Prepare slaves for clock stop */
+	ret = sdw_bus_prep_clk_stop(&cdns->bus);
+	if (ret < 0) {
+		dev_err(cdns->dev, "prepare clock stop failed %d", ret);
+		return ret;
+	}
+
+	/*
+	 * Enter clock stop mode and only report errors if there are
+	 * Slave devices present (ALERT or ATTACHED)
+	 */
+	ret = sdw_bus_clk_stop(&cdns->bus);
+	if (ret < 0 && slave_present && ret != -ENODATA) {
+		dev_err(cdns->dev, "bus clock stop failed %d", ret);
+		return ret;
+	}
+
+	ret = cdns_set_wait(cdns, CDNS_MCP_STAT,
+			    CDNS_MCP_STAT_CLK_STOP,
+			    CDNS_MCP_STAT_CLK_STOP);
+	if (ret < 0)
+		dev_err(cdns->dev, "Clock stop failed %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL(sdw_cdns_clock_stop);
+
+/**
+ * sdw_cdns_clock_restart: Cadence PM clock restart configuration routine
+ *
+ * @cdns: Cadence instance
+ * @bus_reset: context may be lost while in low power modes and the bus
+ * may require a Severe Reset and re-enumeration after a wake.
+ */
+int sdw_cdns_clock_restart(struct sdw_cdns *cdns, bool bus_reset)
+{
+	int ret;
+
+	ret = cdns_clear_bit(cdns, CDNS_MCP_CONTROL,
+			     CDNS_MCP_CONTROL_CLK_STOP_CLR);
+	if (ret < 0) {
+		dev_err(cdns->dev, "Couldn't exit from clock stop\n");
+		return ret;
+	}
+
+	ret = cdns_set_wait(cdns, CDNS_MCP_STAT, CDNS_MCP_STAT_CLK_STOP, 0);
+	if (ret < 0) {
+		dev_err(cdns->dev, "clock stop exit failed %d\n", ret);
+		return ret;
+	}
+
+	cdns_updatel(cdns, CDNS_MCP_CONTROL,
+		     CDNS_MCP_CONTROL_BLOCK_WAKEUP, 0);
+
+	/*
+	 * clear CMD_ACCEPT so that the command ignored
+	 * will be treated as a failure during a broadcast write
+	 */
+	cdns_updatel(cdns, CDNS_MCP_CONTROL, CDNS_MCP_CONTROL_CMD_ACCEPT, 0);
+
+	if (!bus_reset) {
+
+		/* enable bus operations with clock and data */
+		cdns_updatel(cdns, CDNS_MCP_CONFIG,
+			     CDNS_MCP_CONFIG_OP,
+			     CDNS_MCP_CONFIG_OP_NORMAL);
+
+		ret = cdns_config_update(cdns);
+		if (ret < 0) {
+			dev_err(cdns->dev, "%s: config_update failed\n", __func__);
+			return ret;
+		}
+
+		ret = sdw_bus_exit_clk_stop(&cdns->bus);
+		if (ret < 0)
+			dev_err(cdns->dev, "bus failed to exit clock stop %d\n", ret);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(sdw_cdns_clock_restart);
+
 /**
  * sdw_cdns_probe() - Cadence probe routine
  * @cdns: Cadence instance
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 691faa386889..e8fa5c7e09f4 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -145,6 +145,8 @@ int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
 int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state);
 
 bool sdw_cdns_is_clock_stop(struct sdw_cdns *cdns);
+int sdw_cdns_clock_stop(struct sdw_cdns *cdns, bool block_wake);
+int sdw_cdns_clock_restart(struct sdw_cdns *cdns, bool bus_reset);
 
 #ifdef CONFIG_DEBUG_FS
 void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
-- 
2.20.1

