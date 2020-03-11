Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0718C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA40520746
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbgCKWLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:11:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:59207 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730943AbgCKWK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:10:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 15:10:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,542,1574150400"; 
   d="scan'208";a="277550628"
Received: from fjan-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.25.157])
  by fmsmga002.fm.intel.com with ESMTP; 11 Mar 2020 15:10:54 -0700
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
Subject: [PATCH 7/7] soundwire: intel: introduce helper for link synchronization
Date:   Wed, 11 Mar 2020 17:10:26 -0500
Message-Id: <20200311221026.18174-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
References: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After arming the synchronization, the SYNCGO field controls the
hardware-based synchronization between links.

Move the programming and wait for clear of SYNCGO to dedicated helper.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 47 ++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 93d157d04eb9..e2dac2f0b343 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -524,6 +524,44 @@ static void intel_shim_sync_arm(struct sdw_intel *sdw)
 	mutex_unlock(sdw->link_res->shim_lock);
 }
 
+static int intel_shim_sync_go_unlocked(struct sdw_intel *sdw)
+{
+	void __iomem *shim = sdw->link_res->shim;
+	u32 sync_reg;
+	int ret;
+
+	/* Read SYNC register */
+	sync_reg = intel_readl(shim, SDW_SHIM_SYNC);
+
+	/*
+	 * Set SyncGO bit to synchronously trigger a bank switch for
+	 * all the masters. A write to SYNCGO bit clears CMDSYNC bit for all
+	 * the Masters.
+	 */
+	sync_reg |= SDW_SHIM_SYNC_SYNCGO;
+
+	ret = intel_clear_bit(shim, SDW_SHIM_SYNC, sync_reg,
+			      SDW_SHIM_SYNC_SYNCGO);
+
+	if (ret < 0)
+		dev_err(sdw->cdns.dev, "SyncGO clear failed: %d\n", ret);
+
+	return ret;
+}
+
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
@@ -775,15 +813,8 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
 		ret = 0;
 		goto unlock;
 	}
-	/*
-	 * Set SyncGO bit to synchronously trigger a bank switch for
-	 * all the masters. A write to SYNCGO bit clears CMDSYNC bit for all
-	 * the Masters.
-	 */
-	sync_reg |= SDW_SHIM_SYNC_SYNCGO;
 
-	ret = intel_clear_bit(shim, SDW_SHIM_SYNC, sync_reg,
-			      SDW_SHIM_SYNC_SYNCGO);
+	ret = intel_shim_sync_go_unlocked(sdw);
 unlock:
 	mutex_unlock(sdw->link_res->shim_lock);
 
-- 
2.20.1

