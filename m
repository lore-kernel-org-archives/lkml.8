Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1C6C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C062074B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbgCKWKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:10:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:59207 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729976AbgCKWKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:10:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 15:10:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,542,1574150400"; 
   d="scan'208";a="277550609"
Received: from fjan-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.25.157])
  by fmsmga002.fm.intel.com with ESMTP; 11 Mar 2020 15:10:49 -0700
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
Subject: [PATCH 5/7] soundwire: intel: follow documentation sequences for SHIM registers
Date:   Wed, 11 Mar 2020 17:10:24 -0500
Message-Id: <20200311221026.18174-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
References: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@intel.com>

Somehow the existing code is not aligned with the steps described in
the documentation, refactor code and make sure the register
programming sequences are correct.

This includes making sure SHIM_SYNC is programmed only once, before
the first link is powered on.

Note that the SYNCPRD value is tied only to the XTAL value and not the
current bus frequency or the frame rate.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 186 ++++++++++++++++++++++++++++----------
 1 file changed, 139 insertions(+), 47 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 3c271a8044b8..9c6514fe1284 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -46,7 +46,8 @@
 #define SDW_SHIM_LCTL_SPA		BIT(0)
 #define SDW_SHIM_LCTL_CPA		BIT(8)
 
-#define SDW_SHIM_SYNC_SYNCPRD_VAL	0x176F
+#define SDW_SHIM_SYNC_SYNCPRD_VAL_24	(24000 / SDW_CADENCE_GSYNC_KHZ - 1)
+#define SDW_SHIM_SYNC_SYNCPRD_VAL_38_4	(38400 / SDW_CADENCE_GSYNC_KHZ - 1)
 #define SDW_SHIM_SYNC_SYNCPRD		GENMASK(14, 0)
 #define SDW_SHIM_SYNC_SYNCCPU		BIT(15)
 #define SDW_SHIM_SYNC_CMDSYNC_MASK	GENMASK(19, 16)
@@ -283,11 +284,48 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 {
 	unsigned int link_id = sdw->instance;
 	void __iomem *shim = sdw->link_res->shim;
+	u32 *shim_mask = sdw->link_res->shim_mask;
+	struct sdw_bus *bus = &sdw->cdns.bus;
+	struct sdw_master_prop *prop = &bus->prop;
 	int spa_mask, cpa_mask;
-	int link_control, ret;
+	int link_control;
+	int ret = 0;
+	u32 syncprd;
+	u32 sync_reg;
 
 	mutex_lock(sdw->link_res->shim_lock);
 
+	/*
+	 * The hardware relies on an internal counter,
+	 * typically 4kHz, to generate the SoundWire SSP -
+	 * which defines a 'safe' synchronization point
+	 * between commands and audio transport and allows for
+	 * multi link synchronization. The SYNCPRD value is
+	 * only dependent on the oscillator clock provided to
+	 * the IP, so adjust based on _DSD properties reported
+	 * in DSDT tables. The values reported are based on
+	 * either 24MHz (CNL/CML) or 38.4 MHz (ICL/TGL+).
+	 */
+	if (prop->mclk_freq % 6000000)
+		syncprd = SDW_SHIM_SYNC_SYNCPRD_VAL_38_4;
+	else
+		syncprd = SDW_SHIM_SYNC_SYNCPRD_VAL_24;
+
+	if (!*shim_mask) {
+		/* we first need to program the SyncPRD/CPU registers */
+		dev_dbg(sdw->cdns.dev,
+			"%s: first link up, programming SYNCPRD\n", __func__);
+
+		/* set SyncPRD period */
+		sync_reg = intel_readl(shim, SDW_SHIM_SYNC);
+		sync_reg |= (syncprd <<
+			     SDW_REG_SHIFT(SDW_SHIM_SYNC_SYNCPRD));
+
+		/* Set SyncCPU bit */
+		sync_reg |= SDW_SHIM_SYNC_SYNCCPU;
+		intel_writel(shim, SDW_SHIM_SYNC, sync_reg);
+	}
+
 	/* Link power up sequence */
 	link_control = intel_readl(shim, SDW_SHIM_LCTL);
 	spa_mask = (SDW_SHIM_LCTL_SPA << link_id);
@@ -295,73 +333,118 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 	link_control |=  spa_mask;
 
 	ret = intel_set_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
-	mutex_unlock(sdw->link_res->shim_lock);
+	if (ret < 0) {
+		dev_err(sdw->cdns.dev, "Failed to power up link: %d\n", ret);
+		goto out;
+	}
 
-	if (ret < 0)
-		return ret;
+	if (!*shim_mask) {
+		/* SyncCPU will change once link is active */
+		ret = intel_wait_bit(shim, SDW_SHIM_SYNC,
+				     SDW_SHIM_SYNC_SYNCCPU, 0);
+		if (ret < 0) {
+			dev_err(sdw->cdns.dev,
+				"Failed to set SHIM_SYNC: %d\n", ret);
+			goto out;
+		}
+	}
+
+	*shim_mask |= BIT(link_id);
 
 	sdw->cdns.link_up = true;
-	return 0;
+out:
+	mutex_unlock(sdw->link_res->shim_lock);
+
+	return ret;
 }
 
-static int intel_shim_init(struct sdw_intel *sdw)
+/* this needs to be called with shim_lock */
+static void intel_shim_glue_to_master_ip(struct sdw_intel *sdw)
 {
 	void __iomem *shim = sdw->link_res->shim;
 	unsigned int link_id = sdw->instance;
-	int sync_reg, ret;
-	u16 ioctl = 0, act = 0;
-
-	mutex_lock(sdw->link_res->shim_lock);
-
-	/* Initialize Shim */
-	ioctl |= SDW_SHIM_IOCTL_BKE;
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
-
-	ioctl |= SDW_SHIM_IOCTL_WPDD;
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
-
-	ioctl |= SDW_SHIM_IOCTL_DO;
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
-
-	ioctl |= SDW_SHIM_IOCTL_DOE;
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	u16 ioctl;
 
 	/* Switch to MIP from Glue logic */
 	ioctl = intel_readw(shim,  SDW_SHIM_IOCTL(link_id));
 
 	ioctl &= ~(SDW_SHIM_IOCTL_DOE);
 	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
 
 	ioctl &= ~(SDW_SHIM_IOCTL_DO);
 	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
 
 	ioctl |= (SDW_SHIM_IOCTL_MIF);
 	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
 
 	ioctl &= ~(SDW_SHIM_IOCTL_BKE);
 	ioctl &= ~(SDW_SHIM_IOCTL_COE);
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	/* at this point Master IP has full control of the I/Os */
+}
+
+/* this needs to be called with shim_lock */
+static void intel_shim_master_ip_to_glue(struct sdw_intel *sdw)
+{
+	unsigned int link_id = sdw->instance;
+	void __iomem *shim = sdw->link_res->shim;
+	u16 ioctl;
+
+	/* Glue logic */
+	ioctl = intel_readw(shim, SDW_SHIM_IOCTL(link_id));
+	ioctl |= SDW_SHIM_IOCTL_BKE;
+	ioctl |= SDW_SHIM_IOCTL_COE;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
 
+	ioctl &= ~(SDW_SHIM_IOCTL_MIF);
 	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	/* at this point Integration Glue has full control of the I/Os */
+}
+
+static int intel_shim_init(struct sdw_intel *sdw, bool clock_stop)
+{
+	void __iomem *shim = sdw->link_res->shim;
+	unsigned int link_id = sdw->instance;
+	int ret = 0;
+	u16 ioctl = 0, act = 0;
+
+	mutex_lock(sdw->link_res->shim_lock);
+
+	/* Initialize Shim */
+	ioctl |= SDW_SHIM_IOCTL_BKE;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	ioctl |= SDW_SHIM_IOCTL_WPDD;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	ioctl |= SDW_SHIM_IOCTL_DO;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	ioctl |= SDW_SHIM_IOCTL_DOE;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	intel_shim_glue_to_master_ip(sdw);
 
 	act |= 0x1 << SDW_REG_SHIFT(SDW_SHIM_CTMCTL_DOAIS);
 	act |= SDW_SHIM_CTMCTL_DACTQE;
 	act |= SDW_SHIM_CTMCTL_DODS;
 	intel_writew(shim, SDW_SHIM_CTMCTL(link_id), act);
+	usleep_range(10, 15);
 
-	/* Now set SyncPRD period */
-	sync_reg = intel_readl(shim, SDW_SHIM_SYNC);
-	sync_reg |= (SDW_SHIM_SYNC_SYNCPRD_VAL <<
-			SDW_REG_SHIFT(SDW_SHIM_SYNC_SYNCPRD));
-
-	/* Set SyncCPU bit */
-	sync_reg |= SDW_SHIM_SYNC_SYNCCPU;
-	ret = intel_clear_bit(shim, SDW_SHIM_SYNC, sync_reg,
-			      SDW_SHIM_SYNC_SYNCCPU);
 	mutex_unlock(sdw->link_res->shim_lock);
 
-	if (ret < 0)
-		dev_err(sdw->cdns.dev, "Failed to set sync period: %d\n", ret);
-
 	return ret;
 }
 
@@ -393,21 +476,15 @@ static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
 
 static int intel_link_power_down(struct sdw_intel *sdw)
 {
-	int link_control, spa_mask, cpa_mask, ret;
+	int link_control, spa_mask, cpa_mask;
 	unsigned int link_id = sdw->instance;
 	void __iomem *shim = sdw->link_res->shim;
-	u16 ioctl;
+	u32 *shim_mask = sdw->link_res->shim_mask;
+	int ret = 0;
 
 	mutex_lock(sdw->link_res->shim_lock);
 
-	/* Glue logic */
-	ioctl = intel_readw(shim, SDW_SHIM_IOCTL(link_id));
-	ioctl |= SDW_SHIM_IOCTL_BKE;
-	ioctl |= SDW_SHIM_IOCTL_COE;
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
-
-	ioctl &= ~(SDW_SHIM_IOCTL_MIF);
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	intel_shim_master_ip_to_glue(sdw);
 
 	/* Link power down sequence */
 	link_control = intel_readl(shim, SDW_SHIM_LCTL);
@@ -416,6 +493,13 @@ static int intel_link_power_down(struct sdw_intel *sdw)
 	link_control &=  spa_mask;
 
 	ret = intel_clear_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
+
+	if (!(*shim_mask & BIT(link_id)))
+		dev_err(sdw->cdns.dev,
+			"%s: Unbalanced power-up/down calls\n", __func__);
+
+	*shim_mask &= ~BIT(link_id);
+
 	mutex_unlock(sdw->link_res->shim_lock);
 
 	if (ret < 0)
@@ -1144,9 +1228,17 @@ static struct sdw_master_ops sdw_intel_ops = {
 
 static int intel_init(struct sdw_intel *sdw)
 {
+	bool clock_stop;
+
 	/* Initialize shim and controller */
 	intel_link_power_up(sdw);
-	intel_shim_init(sdw);
+
+	clock_stop = sdw_cdns_is_clock_stop(&sdw->cdns);
+
+	intel_shim_init(sdw, clock_stop);
+
+	if (clock_stop)
+		return 0;
 
 	return sdw_cdns_init(&sdw->cdns);
 }
-- 
2.20.1

