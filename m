Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521BFC433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F9620674
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbgGVIcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:32:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:10111 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGVIcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:32:19 -0400
IronPort-SDR: NYudQbq3zMYmyb0vll5PkjPdfGBW+sLrcoa2ooHdccgEdUGV5ehQ8K3sDtQRxHMt8T80SKFlQb
 aPbTECwAe7DQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="147788034"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="147788034"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:32:18 -0700
IronPort-SDR: UynDFcqBvMsFLH3AwXoyMLHfh8XsB28DUuw0qgBPGnpQ+hflPASoEU+UzOGRlLgFGrXIA6UpOr
 6j1dGKXVk4Zg==
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="432303340"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:32:14 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 08/13] soundwire: intel: add CLK_STOP_TEARDOWN for pm_runtime suspend
Date:   Wed, 22 Jul 2020 04:37:18 +0800
Message-Id: <20200721203723.18305-9-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Now that we have options, add support for TEARDOWN mode (same
functionality as existing code)

All other modes will be added in follow-up patches.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c      | 82 +++++++++++++++++++++-------------
 drivers/soundwire/intel.h      |  2 +
 drivers/soundwire/intel_init.c |  1 +
 3 files changed, 54 insertions(+), 31 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 4a60456f060d..1954eb48b86c 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1549,6 +1549,7 @@ static int intel_suspend_runtime(struct device *dev)
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
+	u32 clock_stop_quirks;
 	int ret;
 
 	if (bus->prop.hw_disabled) {
@@ -1557,21 +1558,31 @@ static int intel_suspend_runtime(struct device *dev)
 		return 0;
 	}
 
-	ret = sdw_cdns_enable_interrupt(cdns, false);
-	if (ret < 0) {
-		dev_err(dev, "cannot disable interrupts on suspend\n");
-		return ret;
-	}
+	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
 
-	ret = intel_link_power_down(sdw);
-	if (ret) {
-		dev_err(dev, "Link power down failed: %d", ret);
-		return ret;
-	}
+	if (clock_stop_quirks & SDW_INTEL_CLK_STOP_TEARDOWN) {
+
+		ret = sdw_cdns_enable_interrupt(cdns, false);
+		if (ret < 0) {
+			dev_err(dev, "cannot disable interrupts on suspend\n");
+			return ret;
+		}
 
-	intel_shim_wake(sdw, false);
+		ret = intel_link_power_down(sdw);
+		if (ret) {
+			dev_err(dev, "Link power down failed: %d", ret);
+			return ret;
+		}
+
+		intel_shim_wake(sdw, false);
+
+	} else {
+		dev_err(dev, "%s clock_stop_quirks %x unsupported\n",
+			__func__, clock_stop_quirks);
+		ret = -EINVAL;
+	}
 
-	return 0;
+	return ret;
 }
 
 static int intel_resume(struct device *dev)
@@ -1648,6 +1659,7 @@ static int intel_resume_runtime(struct device *dev)
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
+	u32 clock_stop_quirks;
 	int ret;
 
 	if (bus->prop.hw_disabled) {
@@ -1656,28 +1668,36 @@ static int intel_resume_runtime(struct device *dev)
 		return 0;
 	}
 
-	ret = intel_init(sdw);
-	if (ret) {
-		dev_err(dev, "%s failed: %d", __func__, ret);
-		return ret;
-	}
+	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
 
-	/*
-	 * make sure all Slaves are tagged as UNATTACHED and provide
-	 * reason for reinitialization
-	 */
-	sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
+	if (clock_stop_quirks & SDW_INTEL_CLK_STOP_TEARDOWN) {
+		ret = intel_init(sdw);
+		if (ret) {
+			dev_err(dev, "%s failed: %d", __func__, ret);
+			return ret;
+		}
 
-	ret = sdw_cdns_enable_interrupt(cdns, true);
-	if (ret < 0) {
-		dev_err(dev, "cannot enable interrupts during resume\n");
-		return ret;
-	}
+		/*
+		 * make sure all Slaves are tagged as UNATTACHED and provide
+		 * reason for reinitialization
+		 */
+		sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
 
-	ret = sdw_cdns_exit_reset(cdns);
-	if (ret < 0) {
-		dev_err(dev, "unable to exit bus reset sequence during resume\n");
-		return ret;
+		ret = sdw_cdns_enable_interrupt(cdns, true);
+		if (ret < 0) {
+			dev_err(dev, "cannot enable interrupts during resume\n");
+			return ret;
+		}
+
+		ret = sdw_cdns_exit_reset(cdns);
+		if (ret < 0) {
+			dev_err(dev, "unable to exit bus reset sequence during resume\n");
+			return ret;
+		}
+	} else {
+		dev_err(dev, "%s clock_stop_quirks %x unsupported\n",
+			__func__, clock_stop_quirks);
+		ret = -EINVAL;
 	}
 
 	return ret;
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 4ea3d262d249..23daab9da329 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -17,6 +17,7 @@
  * @dev: device implementing hw_params and free callbacks
  * @shim_lock: mutex to handle access to shared SHIM registers
  * @shim_mask: global pointer to check SHIM register initialization
+ * @clock_stop_quirks: mask defining requested behavior on pm_suspend
  * @cdns: Cadence master descriptor
  * @list: used to walk-through all masters exposed by the same controller
  */
@@ -31,6 +32,7 @@ struct sdw_intel_link_res {
 	struct device *dev;
 	struct mutex *shim_lock; /* protect shared registers */
 	u32 *shim_mask;
+	u32 clock_stop_quirks;
 	struct sdw_cdns *cdns;
 	struct list_head list;
 };
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 6dacfec55d50..96c9af15c308 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -248,6 +248,7 @@ static struct sdw_intel_ctx
 		link->ops = res->ops;
 		link->dev = res->dev;
 
+		link->clock_stop_quirks = res->clock_stop_quirks;
 		link->shim_lock = &ctx->shim_lock;
 		link->shim_mask = &ctx->shim_mask;
 
-- 
2.17.1

