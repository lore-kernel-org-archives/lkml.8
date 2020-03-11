Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE9BC4CECE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3015120739
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgCKWKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:10:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:59207 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729976AbgCKWKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:10:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 15:10:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,542,1574150400"; 
   d="scan'208";a="277550577"
Received: from fjan-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.25.157])
  by fmsmga002.fm.intel.com with ESMTP; 11 Mar 2020 15:10:43 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 3/7] soundwire: intel: add mutex to prevent concurrent access to SHIM registers
Date:   Wed, 11 Mar 2020 17:10:22 -0500
Message-Id: <20200311221026.18174-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
References: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the SHIM registers exposed fields that are link specific, and
in addition some of the power-related registers (SPA/CPA) take time to
be updated. Uncontrolled access leads to timeouts or errors.

Add a mutex, shared by all links, so that all accesses to such
registers are serialized, and follow a pattern of read-modify-write.

The mutex initialization is done at the higher layer since the same
mutex is used for all links.

GitHub issue: https://github.com/thesofproject/linux/issues/1555
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 37 +++++++++++++++++++++++++++++++------
 drivers/soundwire/intel.h |  2 ++
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 1a3b828b03a1..3c271a8044b8 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -286,6 +286,8 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 	int spa_mask, cpa_mask;
 	int link_control, ret;
 
+	mutex_lock(sdw->link_res->shim_lock);
+
 	/* Link power up sequence */
 	link_control = intel_readl(shim, SDW_SHIM_LCTL);
 	spa_mask = (SDW_SHIM_LCTL_SPA << link_id);
@@ -293,6 +295,8 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 	link_control |=  spa_mask;
 
 	ret = intel_set_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
+	mutex_unlock(sdw->link_res->shim_lock);
+
 	if (ret < 0)
 		return ret;
 
@@ -307,6 +311,8 @@ static int intel_shim_init(struct sdw_intel *sdw)
 	int sync_reg, ret;
 	u16 ioctl = 0, act = 0;
 
+	mutex_lock(sdw->link_res->shim_lock);
+
 	/* Initialize Shim */
 	ioctl |= SDW_SHIM_IOCTL_BKE;
 	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
@@ -351,6 +357,8 @@ static int intel_shim_init(struct sdw_intel *sdw)
 	sync_reg |= SDW_SHIM_SYNC_SYNCCPU;
 	ret = intel_clear_bit(shim, SDW_SHIM_SYNC, sync_reg,
 			      SDW_SHIM_SYNC_SYNCCPU);
+	mutex_unlock(sdw->link_res->shim_lock);
+
 	if (ret < 0)
 		dev_err(sdw->cdns.dev, "Failed to set sync period: %d\n", ret);
 
@@ -363,13 +371,15 @@ static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
 	unsigned int link_id = sdw->instance;
 	u16 wake_en, wake_sts;
 
+	mutex_lock(sdw->link_res->shim_lock);
+	wake_en = intel_readw(shim, SDW_SHIM_WAKEEN);
+
 	if (wake_enable) {
 		/* Enable the wakeup */
-		intel_writew(shim, SDW_SHIM_WAKEEN,
-			     (SDW_SHIM_WAKEEN_ENABLE << link_id));
+		wake_en |= (SDW_SHIM_WAKEEN_ENABLE << link_id);
+		intel_writew(shim, SDW_SHIM_WAKEEN, wake_en);
 	} else {
 		/* Disable the wake up interrupt */
-		wake_en = intel_readw(shim, SDW_SHIM_WAKEEN);
 		wake_en &= ~(SDW_SHIM_WAKEEN_ENABLE << link_id);
 		intel_writew(shim, SDW_SHIM_WAKEEN, wake_en);
 
@@ -378,6 +388,7 @@ static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
 		wake_sts |= (SDW_SHIM_WAKEEN_ENABLE << link_id);
 		intel_writew(shim, SDW_SHIM_WAKESTS_STATUS, wake_sts);
 	}
+	mutex_unlock(sdw->link_res->shim_lock);
 }
 
 static int intel_link_power_down(struct sdw_intel *sdw)
@@ -387,6 +398,8 @@ static int intel_link_power_down(struct sdw_intel *sdw)
 	void __iomem *shim = sdw->link_res->shim;
 	u16 ioctl;
 
+	mutex_lock(sdw->link_res->shim_lock);
+
 	/* Glue logic */
 	ioctl = intel_readw(shim, SDW_SHIM_IOCTL(link_id));
 	ioctl |= SDW_SHIM_IOCTL_BKE;
@@ -403,6 +416,8 @@ static int intel_link_power_down(struct sdw_intel *sdw)
 	link_control &=  spa_mask;
 
 	ret = intel_clear_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
+	mutex_unlock(sdw->link_res->shim_lock);
+
 	if (ret < 0)
 		return ret;
 
@@ -630,11 +645,15 @@ static int intel_pre_bank_switch(struct sdw_bus *bus)
 	if (!bus->multi_link)
 		return 0;
 
+	mutex_lock(sdw->link_res->shim_lock);
+
 	/* Read SYNC register */
 	sync_reg = intel_readl(shim, SDW_SHIM_SYNC);
 	sync_reg |= SDW_SHIM_SYNC_CMDSYNC << sdw->instance;
 	intel_writel(shim, SDW_SHIM_SYNC, sync_reg);
 
+	mutex_unlock(sdw->link_res->shim_lock);
+
 	return 0;
 }
 
@@ -649,6 +668,8 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
 	if (!bus->multi_link)
 		return 0;
 
+	mutex_lock(sdw->link_res->shim_lock);
+
 	/* Read SYNC register */
 	sync_reg = intel_readl(shim, SDW_SHIM_SYNC);
 
@@ -660,9 +681,10 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
 	 *
 	 * So, set the SYNCGO bit only if CMDSYNC bit is set for any Master.
 	 */
-	if (!(sync_reg & SDW_SHIM_SYNC_CMDSYNC_MASK))
-		return 0;
-
+	if (!(sync_reg & SDW_SHIM_SYNC_CMDSYNC_MASK)) {
+		ret = 0;
+		goto unlock;
+	}
 	/*
 	 * Set SyncGO bit to synchronously trigger a bank switch for
 	 * all the masters. A write to SYNCGO bit clears CMDSYNC bit for all
@@ -672,6 +694,9 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
 
 	ret = intel_clear_bit(shim, SDW_SHIM_SYNC, sync_reg,
 			      SDW_SHIM_SYNC_SYNCGO);
+unlock:
+	mutex_unlock(sdw->link_res->shim_lock);
+
 	if (ret < 0)
 		dev_err(sdw->cdns.dev, "Post bank switch failed: %d\n", ret);
 
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 38b7c125fb10..568c84a80d79 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -15,6 +15,7 @@
  * @irq: Interrupt line
  * @ops: Shim callback ops
  * @dev: device implementing hw_params and free callbacks
+ * @shim_lock: mutex to handle access to shared SHIM registers
  */
 struct sdw_intel_link_res {
 	struct platform_device *pdev;
@@ -25,6 +26,7 @@ struct sdw_intel_link_res {
 	int irq;
 	const struct sdw_intel_ops *ops;
 	struct device *dev;
+	struct mutex *shim_lock; /* protect shared registers */
 };
 
 #endif /* __SDW_INTEL_LOCAL_H */
-- 
2.20.1

