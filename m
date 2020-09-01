Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9EEC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F63206CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgIBDAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 23:00:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:24029 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726966AbgIBDAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 23:00:21 -0400
IronPort-SDR: uwnbqLgIRCpWWQFuNRkglyB1cirRp51lOnmXDqJJZG7sqQsYY4uE4vTRvALmaOPKLpqb+g57d+
 Jf/OmoxIAeiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="218860157"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="218860157"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 20:00:18 -0700
IronPort-SDR: trsBgqnVY6Pv7wRnW6OJ7NaOEQqGaLZFqcK0tCR278Unvo6FHTEtr7ZWh75jb73MzQGLyXTj8X
 mRw+AFIxarAA==
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="283588268"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 20:00:15 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 10/10] soundwire: intel: don't manage link power individually
Date:   Tue,  1 Sep 2020 23:05:56 +0800
Message-Id: <20200901150556.19432-11-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901150556.19432-1-yung-chuan.liao@linux.intel.com>
References: <20200901150556.19432-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Each link has separate power controls, but experimental results show
we need to use an all-or-none approach to the link power management.

This change has marginal power impacts, the DSP needs to be powered
anyways before SoundWire links can be powered, and even when powered a
link can be in clock-stopped mode.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 70 +++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 24 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 97c8cfc54ddd..710f5eba936b 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -63,7 +63,9 @@ MODULE_PARM_DESC(sdw_md_flags, "SoundWire Intel Master device flags (0x0 all off
 #define SDW_SHIM_WAKESTS		0x192
 
 #define SDW_SHIM_LCTL_SPA		BIT(0)
+#define SDW_SHIM_LCTL_SPA_MASK		GENMASK(3, 0)
 #define SDW_SHIM_LCTL_CPA		BIT(8)
+#define SDW_SHIM_LCTL_CPA_MASK		GENMASK(11, 8)
 
 #define SDW_SHIM_SYNC_SYNCPRD_VAL_24	(24000 / SDW_CADENCE_GSYNC_KHZ - 1)
 #define SDW_SHIM_SYNC_SYNCPRD_VAL_38_4	(38400 / SDW_CADENCE_GSYNC_KHZ - 1)
@@ -295,8 +297,8 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 	u32 *shim_mask = sdw->link_res->shim_mask;
 	struct sdw_bus *bus = &sdw->cdns.bus;
 	struct sdw_master_prop *prop = &bus->prop;
-	int spa_mask, cpa_mask;
-	int link_control;
+	u32 spa_mask, cpa_mask;
+	u32 link_control;
 	int ret = 0;
 	u32 syncprd;
 	u32 sync_reg;
@@ -319,6 +321,8 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 		syncprd = SDW_SHIM_SYNC_SYNCPRD_VAL_24;
 
 	if (!*shim_mask) {
+		dev_dbg(sdw->cdns.dev, "%s: powering up all links\n", __func__);
+
 		/* we first need to program the SyncPRD/CPU registers */
 		dev_dbg(sdw->cdns.dev,
 			"%s: first link up, programming SYNCPRD\n", __func__);
@@ -331,21 +335,24 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 		/* Set SyncCPU bit */
 		sync_reg |= SDW_SHIM_SYNC_SYNCCPU;
 		intel_writel(shim, SDW_SHIM_SYNC, sync_reg);
-	}
 
-	/* Link power up sequence */
-	link_control = intel_readl(shim, SDW_SHIM_LCTL);
-	spa_mask = (SDW_SHIM_LCTL_SPA << link_id);
-	cpa_mask = (SDW_SHIM_LCTL_CPA << link_id);
-	link_control |=  spa_mask;
+		/* Link power up sequence */
+		link_control = intel_readl(shim, SDW_SHIM_LCTL);
 
-	ret = intel_set_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
-	if (ret < 0) {
-		dev_err(sdw->cdns.dev, "Failed to power up link: %d\n", ret);
-		goto out;
-	}
+		/* only power-up enabled links */
+		spa_mask = sdw->link_res->link_mask <<
+			SDW_REG_SHIFT(SDW_SHIM_LCTL_SPA_MASK);
+		cpa_mask = sdw->link_res->link_mask <<
+			SDW_REG_SHIFT(SDW_SHIM_LCTL_CPA_MASK);
+
+		link_control |=  spa_mask;
+
+		ret = intel_set_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
+		if (ret < 0) {
+			dev_err(sdw->cdns.dev, "Failed to power up link: %d\n", ret);
+			goto out;
+		}
 
-	if (!*shim_mask) {
 		/* SyncCPU will change once link is active */
 		ret = intel_wait_bit(shim, SDW_SHIM_SYNC,
 				     SDW_SHIM_SYNC_SYNCCPU, 0);
@@ -483,7 +490,7 @@ static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
 
 static int intel_link_power_down(struct sdw_intel *sdw)
 {
-	int link_control, spa_mask, cpa_mask;
+	u32 link_control, spa_mask, cpa_mask;
 	unsigned int link_id = sdw->instance;
 	void __iomem *shim = sdw->link_res->shim;
 	u32 *shim_mask = sdw->link_res->shim_mask;
@@ -493,24 +500,39 @@ static int intel_link_power_down(struct sdw_intel *sdw)
 
 	intel_shim_master_ip_to_glue(sdw);
 
-	/* Link power down sequence */
-	link_control = intel_readl(shim, SDW_SHIM_LCTL);
-	spa_mask = ~(SDW_SHIM_LCTL_SPA << link_id);
-	cpa_mask = (SDW_SHIM_LCTL_CPA << link_id);
-	link_control &=  spa_mask;
-
-	ret = intel_clear_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
-
 	if (!(*shim_mask & BIT(link_id)))
 		dev_err(sdw->cdns.dev,
 			"%s: Unbalanced power-up/down calls\n", __func__);
 
 	*shim_mask &= ~BIT(link_id);
 
+	if (!*shim_mask) {
+
+		dev_dbg(sdw->cdns.dev, "%s: powering down all links\n", __func__);
+
+		/* Link power down sequence */
+		link_control = intel_readl(shim, SDW_SHIM_LCTL);
+
+		/* only power-down enabled links */
+		spa_mask = (~sdw->link_res->link_mask) <<
+			SDW_REG_SHIFT(SDW_SHIM_LCTL_SPA_MASK);
+		cpa_mask = sdw->link_res->link_mask <<
+			SDW_REG_SHIFT(SDW_SHIM_LCTL_CPA_MASK);
+
+		link_control &=  spa_mask;
+
+		ret = intel_clear_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
+	}
+
+	link_control = intel_readl(shim, SDW_SHIM_LCTL);
+
 	mutex_unlock(sdw->link_res->shim_lock);
 
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(sdw->cdns.dev, "%s: could not power down link\n", __func__);
+
 		return ret;
+	}
 
 	sdw->cdns.link_up = false;
 	return 0;
-- 
2.17.1

