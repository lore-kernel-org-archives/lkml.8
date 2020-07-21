Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DF5C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C00DF20674
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgGVIbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:31:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:10111 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGVIbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:31:53 -0400
IronPort-SDR: 0ilCVOPhrSOiyDwUspTOemy7D1ujcByssW8+tRdK2jlzhEe0LpWkypNW566GpLmEJBZ6WWnLWW
 hBwqi7tLvCaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="147787966"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="147787966"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:31:52 -0700
IronPort-SDR: T9kjE+N/BxN1DflpG+8SDXD2P7B2ZVLMGvy22XL7f9apfTIiR4r7JMMRqc8Jq54J5Ictim07/h
 CyhXy8j7804g==
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="432303183"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:31:48 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 02/13] soundwire: intel: add pm_runtime support
Date:   Wed, 22 Jul 2020 04:37:12 +0800
Message-Id: <20200721203723.18305-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Add basic hooks in DAI .startup and .shutdown callbacks.

The SoundWire IP should be powered between those two calls. The power
dependencies between SoundWire and DSP are handled with the
parent/child relationship, before the SoundWire master device becomes
active the parent device will become active and power-up the shared
rails.

For now the strategy is to rely on complete enumeration when the
device becomes active, so the code is a copy/paste of the sequence for
system suspend/resume. In future patches, the strategy will optionally
be to rely on clock stop if the enumeration time is prohibitive or
when the devices connected to a link can signal a wake.

A module parameter is added to make integration of new Slave devices
easier, to e.g. keep the device active or prevent clock-stop.

Note that we need to we have to disable runtime pm before device
unregister, otherwise we will see "Failed to power up link: -11" error
on module remove test.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c      | 112 +++++++++++++++++++++++++++++++--
 drivers/soundwire/intel_init.c |   4 +-
 2 files changed, 111 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index eb628f255cf5..ed7163ae5f7a 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -22,6 +22,22 @@
 #include "bus.h"
 #include "intel.h"
 
+#define INTEL_MASTER_SUSPEND_DELAY_MS	3000
+
+/*
+ * debug/config flags for the Intel SoundWire Master.
+ *
+ * Since we may have multiple masters active, we can have up to 8
+ * flags reused in each byte, with master0 using the ls-byte, etc.
+ */
+
+#define SDW_INTEL_MASTER_DISABLE_PM_RUNTIME BIT(0)
+#define SDW_INTEL_MASTER_DISABLE_CLOCK_STOP BIT(1)
+
+static int md_flags;
+module_param_named(sdw_md_flags, md_flags, int, 0444);
+MODULE_PARM_DESC(sdw_md_flags, "SoundWire Intel Master device flags (0x0 all off)");
+
 /* Intel SHIM Registers Definition */
 #define SDW_SHIM_LCAP			0x0
 #define SDW_SHIM_LCTL			0x4
@@ -807,10 +823,17 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
 static int intel_startup(struct snd_pcm_substream *substream,
 			 struct snd_soc_dai *dai)
 {
-	/*
-	 * TODO: add pm_runtime support here, the startup callback
-	 * will make sure the IP is 'active'
-	 */
+	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
+	int ret;
+
+	ret = pm_runtime_get_sync(cdns->dev);
+	if (ret < 0 && ret != -EACCES) {
+		dev_err_ratelimited(cdns->dev,
+				    "pm_runtime_get_sync failed in %s, ret %d\n",
+				    __func__, ret);
+		pm_runtime_put_noidle(cdns->dev);
+		return ret;
+	}
 	return 0;
 }
 
@@ -985,7 +1008,10 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 static void intel_shutdown(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
+	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 
+	pm_runtime_mark_last_busy(cdns->dev);
+	pm_runtime_put_autosuspend(cdns->dev);
 }
 
 static int intel_pcm_set_sdw_stream(struct snd_soc_dai *dai,
@@ -1269,6 +1295,7 @@ int intel_master_startup(struct platform_device *pdev)
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
+	int link_flags;
 	int ret;
 
 	if (bus->prop.hw_disabled) {
@@ -1313,6 +1340,18 @@ int intel_master_startup(struct platform_device *pdev)
 
 	intel_debugfs_init(sdw);
 
+	/* Enable runtime PM */
+	link_flags = md_flags >> (bus->link_id * 8);
+	if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME)) {
+		pm_runtime_set_autosuspend_delay(dev,
+						 INTEL_MASTER_SUSPEND_DELAY_MS);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_mark_last_busy(dev);
+
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+	}
+
 	return 0;
 
 err_interrupt:
@@ -1411,6 +1450,36 @@ static int intel_suspend(struct device *dev)
 	return 0;
 }
 
+static int intel_suspend_runtime(struct device *dev)
+{
+	struct sdw_cdns *cdns = dev_get_drvdata(dev);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_bus *bus = &cdns->bus;
+	int ret;
+
+	if (bus->prop.hw_disabled) {
+		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n",
+			bus->link_id);
+		return 0;
+	}
+
+	ret = sdw_cdns_enable_interrupt(cdns, false);
+	if (ret < 0) {
+		dev_err(dev, "cannot disable interrupts on suspend\n");
+		return ret;
+	}
+
+	ret = intel_link_power_down(sdw);
+	if (ret) {
+		dev_err(dev, "Link power down failed: %d", ret);
+		return ret;
+	}
+
+	intel_shim_wake(sdw, false);
+
+	return 0;
+}
+
 static int intel_resume(struct device *dev)
 {
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
@@ -1445,10 +1514,45 @@ static int intel_resume(struct device *dev)
 	return ret;
 }
 
+static int intel_resume_runtime(struct device *dev)
+{
+	struct sdw_cdns *cdns = dev_get_drvdata(dev);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_bus *bus = &cdns->bus;
+	int ret;
+
+	if (bus->prop.hw_disabled) {
+		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n",
+			bus->link_id);
+		return 0;
+	}
+
+	ret = intel_init(sdw);
+	if (ret) {
+		dev_err(dev, "%s failed: %d", __func__, ret);
+		return ret;
+	}
+
+	ret = sdw_cdns_enable_interrupt(cdns, true);
+	if (ret < 0) {
+		dev_err(dev, "cannot enable interrupts during resume\n");
+		return ret;
+	}
+
+	ret = sdw_cdns_exit_reset(cdns);
+	if (ret < 0) {
+		dev_err(dev, "unable to exit bus reset sequence during resume\n");
+		return ret;
+	}
+
+	return ret;
+}
+
 #endif
 
 static const struct dev_pm_ops intel_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
+	SET_RUNTIME_PM_OPS(intel_suspend_runtime, intel_resume_runtime, NULL)
 };
 
 static struct platform_driver sdw_intel_drv = {
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 047252a91c9e..6dacfec55d50 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -68,8 +68,10 @@ static int sdw_intel_cleanup(struct sdw_intel_ctx *ctx)
 		if (!(link_mask & BIT(i)))
 			continue;
 
-		if (link->pdev)
+		if (link->pdev) {
+			pm_runtime_disable(&link->pdev->dev);
 			platform_device_unregister(link->pdev);
+		}
 	}
 
 	return 0;
-- 
2.17.1

