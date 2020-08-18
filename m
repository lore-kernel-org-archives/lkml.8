Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A23BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 078A02076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgHROgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:36:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:33372 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727782AbgHROgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:36:00 -0400
IronPort-SDR: /IB+J/pI3uKRLLl5XM2o3Gu6g0zjpz5uKOsihL9ijLdmI43UPRfCZ4wO5KMfg8Ja3oRyD2toSk
 Ycw4uvlM7QNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154170594"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="154170594"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 07:35:58 -0700
IronPort-SDR: pYASlFNwMd+E6GmvVY2K0hPj6X6RBKwWRPIgbELDlzpSI8BP2Gv2bFjzeOhMIX99aZ3keJVKEq
 bIv23cQ8RUSw==
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="471830800"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 07:35:54 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 11/11] soundwire: intel: don't manage link power individually
Date:   Tue, 18 Aug 2020 10:41:20 +0800
Message-Id: <20200818024120.20721-12-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
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
index b82d02af3c4f..154aa7c0561a 100644
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

