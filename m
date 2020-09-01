Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABFEC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75DDC2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgIBDAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 23:00:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:23978 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgIBC7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 22:59:53 -0400
IronPort-SDR: tlreP8o93kX5fOzoDdhXKEVB2if0NEPzJ/v5gxPNYrEwV6rc7V+RT+IJK14dnSvya4zR2/RPOs
 jPVZ5UXOoywA==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="218860088"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="218860088"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 19:59:52 -0700
IronPort-SDR: UMzYjIsUnb2o8SYKVTxi1RMXUiG1vRX1qFZhpxXxuYTmPZOPWMmmZ/ds4oLNkfyl74/mYO1B2B
 wr0Sm5LEoibQ==
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="283588075"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 19:59:48 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 03/10] soundwire: intel: add multi-link support
Date:   Tue,  1 Sep 2020 23:05:49 +0800
Message-Id: <20200901150556.19432-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901150556.19432-1-yung-chuan.liao@linux.intel.com>
References: <20200901150556.19432-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The multi-link support is enabled with a hardware gsync signal
connecting all links. All commands and operations which typically are
handled on an SSP boundary will be deferred further and enabled across
all links with the 'syncGo' sequence.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 120 ++++++++++++++++++++++++++++++++++----
 1 file changed, 110 insertions(+), 10 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 94a659e65f86..259e3da98e42 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -34,6 +34,7 @@
 #define SDW_INTEL_MASTER_DISABLE_PM_RUNTIME		BIT(0)
 #define SDW_INTEL_MASTER_DISABLE_CLOCK_STOP		BIT(1)
 #define SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE	BIT(2)
+#define SDW_INTEL_MASTER_DISABLE_MULTI_LINK		BIT(3)
 
 static int md_flags;
 module_param_named(sdw_md_flags, md_flags, int, 0444);
@@ -555,6 +556,19 @@ static int intel_shim_sync_go_unlocked(struct sdw_intel *sdw)
 	return ret;
 }
 
+static int intel_shim_sync_go(struct sdw_intel *sdw)
+{
+	int ret;
+
+	mutex_lock(sdw->link_res->shim_lock);
+
+	ret = intel_shim_sync_go_unlocked(sdw);
+
+	mutex_unlock(sdw->link_res->shim_lock);
+
+	return ret;
+}
+
 /*
  * PDI routines
  */
@@ -1303,10 +1317,7 @@ static int intel_init(struct sdw_intel *sdw)
 
 	intel_shim_init(sdw, clock_stop);
 
-	if (clock_stop)
-		return 0;
-
-	return sdw_cdns_init(&sdw->cdns);
+	return 0;
 }
 
 /*
@@ -1372,6 +1383,7 @@ int intel_master_startup(struct platform_device *pdev)
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
 	int link_flags;
+	bool multi_link;
 	u32 clock_stop_quirks;
 	int ret;
 
@@ -1382,7 +1394,16 @@ int intel_master_startup(struct platform_device *pdev)
 		return 0;
 	}
 
-	/* Initialize shim, controller and Cadence IP */
+	link_flags = md_flags >> (bus->link_id * 8);
+	multi_link = !(link_flags & SDW_INTEL_MASTER_DISABLE_MULTI_LINK);
+	if (!multi_link) {
+		dev_dbg(dev, "Multi-link is disabled\n");
+		bus->multi_link = false;
+	} else {
+		bus->multi_link = true;
+	}
+
+	/* Initialize shim, controller */
 	ret = intel_init(sdw);
 	if (ret)
 		goto err_init;
@@ -1401,12 +1422,33 @@ int intel_master_startup(struct platform_device *pdev)
 		goto err_init;
 	}
 
+	/*
+	 * follow recommended programming flows to avoid timeouts when
+	 * gsync is enabled
+	 */
+	if (multi_link)
+		intel_shim_sync_arm(sdw);
+
+	ret = sdw_cdns_init(cdns);
+	if (ret < 0) {
+		dev_err(dev, "unable to initialize Cadence IP\n");
+		goto err_interrupt;
+	}
+
 	ret = sdw_cdns_exit_reset(cdns);
 	if (ret < 0) {
 		dev_err(dev, "unable to exit bus reset sequence\n");
 		goto err_interrupt;
 	}
 
+	if (multi_link) {
+		ret = intel_shim_sync_go(sdw);
+		if (ret < 0) {
+			dev_err(dev, "sync go failed: %d\n", ret);
+			goto err_interrupt;
+		}
+	}
+
 	/* Register DAIs */
 	ret = intel_register_dai(sdw);
 	if (ret) {
@@ -1418,7 +1460,6 @@ int intel_master_startup(struct platform_device *pdev)
 	intel_debugfs_init(sdw);
 
 	/* Enable runtime PM */
-	link_flags = md_flags >> (bus->link_id * 8);
 	if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME)) {
 		pm_runtime_set_autosuspend_delay(dev,
 						 INTEL_MASTER_SUSPEND_DELAY_MS);
@@ -1654,6 +1695,7 @@ static int __maybe_unused intel_resume(struct device *dev)
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
 	int link_flags;
+	bool multi_link;
 	int ret;
 
 	if (bus->prop.hw_disabled) {
@@ -1662,6 +1704,9 @@ static int __maybe_unused intel_resume(struct device *dev)
 		return 0;
 	}
 
+	link_flags = md_flags >> (bus->link_id * 8);
+	multi_link = !(link_flags & SDW_INTEL_MASTER_DISABLE_MULTI_LINK);
+
 	if (pm_runtime_suspended(dev)) {
 		dev_dbg(dev, "%s: pm_runtime status was suspended, forcing active\n", __func__);
 
@@ -1672,6 +1717,7 @@ static int __maybe_unused intel_resume(struct device *dev)
 		pm_runtime_enable(dev);
 
 		link_flags = md_flags >> (bus->link_id * 8);
+
 		if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE))
 			pm_runtime_idle(dev);
 	}
@@ -1694,12 +1740,33 @@ static int __maybe_unused intel_resume(struct device *dev)
 		return ret;
 	}
 
+	/*
+	 * follow recommended programming flows to avoid timeouts when
+	 * gsync is enabled
+	 */
+	if (multi_link)
+		intel_shim_sync_arm(sdw);
+
+	ret = sdw_cdns_init(&sdw->cdns);
+	if (ret < 0) {
+		dev_err(dev, "unable to initialize Cadence IP during resume\n");
+		return ret;
+	}
+
 	ret = sdw_cdns_exit_reset(cdns);
 	if (ret < 0) {
 		dev_err(dev, "unable to exit bus reset sequence during resume\n");
 		return ret;
 	}
 
+	if (multi_link) {
+		ret = intel_shim_sync_go(sdw);
+		if (ret < 0) {
+			dev_err(dev, "sync go failed during resume\n");
+			return ret;
+		}
+	}
+
 	/*
 	 * after system resume, the pm_runtime suspend() may kick in
 	 * during the enumeration, before any children device force the
@@ -1722,6 +1789,8 @@ static int intel_resume_runtime(struct device *dev)
 	struct sdw_bus *bus = &cdns->bus;
 	u32 clock_stop_quirks;
 	bool clock_stop0;
+	int link_flags;
+	bool multi_link;
 	int status;
 	int ret;
 
@@ -1731,6 +1800,9 @@ static int intel_resume_runtime(struct device *dev)
 		return 0;
 	}
 
+	link_flags = md_flags >> (bus->link_id * 8);
+	multi_link = !(link_flags & SDW_INTEL_MASTER_DISABLE_MULTI_LINK);
+
 	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
 
 	if (clock_stop_quirks & SDW_INTEL_CLK_STOP_TEARDOWN) {
@@ -1752,11 +1824,32 @@ static int intel_resume_runtime(struct device *dev)
 			return ret;
 		}
 
+		/*
+		 * follow recommended programming flows to avoid
+		 * timeouts when gsync is enabled
+		 */
+		if (multi_link)
+			intel_shim_sync_arm(sdw);
+
+		ret = sdw_cdns_init(&sdw->cdns);
+		if (ret < 0) {
+			dev_err(dev, "unable to initialize Cadence IP during resume\n");
+			return ret;
+		}
+
 		ret = sdw_cdns_exit_reset(cdns);
 		if (ret < 0) {
 			dev_err(dev, "unable to exit bus reset sequence during resume\n");
 			return ret;
 		}
+
+		if (multi_link) {
+			ret = intel_shim_sync_go(sdw);
+			if (ret < 0) {
+				dev_err(dev, "sync go failed during resume\n");
+				return ret;
+			}
+		}
 	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) {
 		ret = intel_init(sdw);
 		if (ret) {
@@ -1773,11 +1866,18 @@ static int intel_resume_runtime(struct device *dev)
 		 */
 		clock_stop0 = sdw_cdns_is_clock_stop(&sdw->cdns);
 
-		/*
-		 * make sure all Slaves are tagged as UNATTACHED and
-		 * provide reason for reinitialization
-		 */
 		if (!clock_stop0) {
+
+			/*
+			 * Re-initialize the IP since it was powered-off
+			 */
+			sdw_cdns_init(&sdw->cdns);
+
+			/*
+			 * make sure all Slaves are tagged as UNATTACHED and
+			 * provide reason for reinitialization
+			 */
+
 			status = SDW_UNATTACH_REQUEST_MASTER_RESET;
 			sdw_clear_slave_status(bus, status);
 		}
-- 
2.17.1

