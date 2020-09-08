Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAFAC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 01:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF74721D20
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 01:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgIIBoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 21:44:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:58009 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgIIBoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 21:44:17 -0400
IronPort-SDR: xQ8/oXrNexe6NGKHzCgOeNBWRufhpoDjoirvnVfWtE8hAVjz++KEKyoRdbrFbdcNQ1sKXLszjd
 M4Pmp2KNQP0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="137770916"
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="137770916"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 18:39:32 -0700
IronPort-SDR: CNCav0sdvqVkacXFuqBMStN+WsSy4EYJ5LFzl93VlMdpGzzrVqSKrh6PNysfeV06e/inIGw5nE
 yDvjlm+zA+dA==
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="449018134"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 18:39:28 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 7/7] soundwire: cadence: add parity error injection through debugfs
Date:   Tue,  8 Sep 2020 21:45:21 +0800
Message-Id: <20200908134521.6781-8-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908134521.6781-1-yung-chuan.liao@linux.intel.com>
References: <20200908134521.6781-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The Cadence IP can inject errors, let's make use of this capability to
test Slave parity error checks.

See e.g. example log where both the master and slave detect the parity
error injected on a dummy read command.

cd /sys/kernel/debug/soundwire/master-1/intel-sdw/
echo 1 > cdns-parity-error-injection

[   44.756249] intel-master sdw-master-1: Parity error
[   44.756313] intel-master sdw-master-1: Msg NACK received
[   44.756366] intel-master sdw-master-1: Msg NACKed for Slave 15
[   44.756375] intel-master sdw-master-1: trf on Slave 15 failed:-5
[   44.756382] intel-master sdw-master-1: parity error injection, read: -5
[   44.756649] rt1308 sdw:1:25d:1308:0: Parity error detected

The code makes sure the Master device is resumed, hence the clock
restarted, before sending a parity error.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 86 ++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index ecf503fb23e1..13e565f93166 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/pm_runtime.h>
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/soundwire/sdw.h>
 #include <sound/pcm_params.h>
@@ -50,6 +51,9 @@ MODULE_PARM_DESC(cdns_mcp_int_mask, "Cadence MCP IntMask");
 #define CDNS_MCP_CONTROL_BLOCK_WAKEUP		BIT(0)
 
 #define CDNS_MCP_CMDCTRL			0x8
+
+#define CDNS_MCP_CMDCTRL_INSERT_PARITY_ERR	BIT(2)
+
 #define CDNS_MCP_SSPSTAT			0xC
 #define CDNS_MCP_FRAME_SHAPE			0x10
 #define CDNS_MCP_FRAME_SHAPE_INIT		0x14
@@ -366,6 +370,85 @@ static int cdns_hw_reset(void *data, u64 value)
 
 DEFINE_DEBUGFS_ATTRIBUTE(cdns_hw_reset_fops, NULL, cdns_hw_reset, "%llu\n");
 
+static int cdns_parity_error_injection(void *data, u64 value)
+{
+	struct sdw_cdns *cdns = data;
+	struct sdw_bus *bus;
+	int ret;
+
+	if (value != 1)
+		return -EINVAL;
+
+	bus = &cdns->bus;
+
+	/*
+	 * Resume Master device. If this results in a bus reset, the
+	 * Slave devices will re-attach and be re-enumerated.
+	 */
+	ret = pm_runtime_get_sync(bus->dev);
+	if (ret < 0 && ret != -EACCES) {
+		dev_err_ratelimited(cdns->dev,
+				    "pm_runtime_get_sync failed in %s, ret %d\n",
+				    __func__, ret);
+		pm_runtime_put_noidle(bus->dev);
+		return ret;
+	}
+
+	/*
+	 * wait long enough for Slave(s) to be in steady state. This
+	 * does not need to be super precise.
+	 */
+	msleep(200);
+
+	/*
+	 * Take the bus lock here to make sure that any bus transactions
+	 * will be queued while we inject a parity error on a dummy read
+	 */
+	mutex_lock(&bus->bus_lock);
+
+	/* program hardware to inject parity error */
+	cdns_updatel(cdns, CDNS_MCP_CMDCTRL,
+		     CDNS_MCP_CMDCTRL_INSERT_PARITY_ERR,
+		     CDNS_MCP_CMDCTRL_INSERT_PARITY_ERR);
+
+	/* commit changes */
+	cdns_updatel(cdns, CDNS_MCP_CONFIG_UPDATE,
+		     CDNS_MCP_CONFIG_UPDATE_BIT,
+		     CDNS_MCP_CONFIG_UPDATE_BIT);
+
+	/* do a broadcast dummy read to avoid bus clashes */
+	ret = sdw_bread_no_pm_unlocked(&cdns->bus, 0xf, SDW_SCP_DEVID_0);
+	dev_info(cdns->dev, "parity error injection, read: %d\n", ret);
+
+	/* program hardware to disable parity error */
+	cdns_updatel(cdns, CDNS_MCP_CMDCTRL,
+		     CDNS_MCP_CMDCTRL_INSERT_PARITY_ERR,
+		     0);
+
+	/* commit changes */
+	cdns_updatel(cdns, CDNS_MCP_CONFIG_UPDATE,
+		     CDNS_MCP_CONFIG_UPDATE_BIT,
+		     CDNS_MCP_CONFIG_UPDATE_BIT);
+
+	/* Continue bus operation with parity error injection disabled */
+	mutex_unlock(&bus->bus_lock);
+
+	/* Userspace changed the hardware state behind the kernel's back */
+	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+
+	/*
+	 * allow Master device to enter pm_runtime suspend. This may
+	 * also result in Slave devices suspending.
+	 */
+	pm_runtime_mark_last_busy(bus->dev);
+	pm_runtime_put_autosuspend(bus->dev);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(cdns_parity_error_fops, NULL,
+			 cdns_parity_error_injection, "%llu\n");
+
 /**
  * sdw_cdns_debugfs_init() - Cadence debugfs init
  * @cdns: Cadence instance
@@ -377,6 +460,9 @@ void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
 
 	debugfs_create_file("cdns-hw-reset", 0200, root, cdns,
 			    &cdns_hw_reset_fops);
+
+	debugfs_create_file("cdns-parity-error-injection", 0200, root, cdns,
+			    &cdns_parity_error_fops);
 }
 EXPORT_SYMBOL_GPL(sdw_cdns_debugfs_init);
 
-- 
2.17.1

