Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D67C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33CC2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbgCKWK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:10:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:59207 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729976AbgCKWKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:10:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 15:10:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,542,1574150400"; 
   d="scan'208";a="277550619"
Received: from fjan-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.25.157])
  by fmsmga002.fm.intel.com with ESMTP; 11 Mar 2020 15:10:52 -0700
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
Subject: [PATCH 6/7] soundwire: intel: introduce a helper to arm link synchronization
Date:   Wed, 11 Mar 2020 17:10:25 -0500
Message-Id: <20200311221026.18174-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
References: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move code from pre_bank_switch to dedicated helper, will be used in
follow-up patches as recommended by programming flows.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 9c6514fe1284..93d157d04eb9 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -509,6 +509,21 @@ static int intel_link_power_down(struct sdw_intel *sdw)
 	return 0;
 }
 
+static void intel_shim_sync_arm(struct sdw_intel *sdw)
+{
+	void __iomem *shim = sdw->link_res->shim;
+	u32 sync_reg;
+
+	mutex_lock(sdw->link_res->shim_lock);
+
+	/* update SYNC register */
+	sync_reg = intel_readl(shim, SDW_SHIM_SYNC);
+	sync_reg |= (SDW_SHIM_SYNC_CMDSYNC << sdw->instance);
+	intel_writel(shim, SDW_SHIM_SYNC, sync_reg);
+
+	mutex_unlock(sdw->link_res->shim_lock);
+}
+
 /*
  * PDI routines
  */
@@ -722,21 +737,12 @@ static int intel_pre_bank_switch(struct sdw_bus *bus)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
-	void __iomem *shim = sdw->link_res->shim;
-	int sync_reg;
 
 	/* Write to register only for multi-link */
 	if (!bus->multi_link)
 		return 0;
 
-	mutex_lock(sdw->link_res->shim_lock);
-
-	/* Read SYNC register */
-	sync_reg = intel_readl(shim, SDW_SHIM_SYNC);
-	sync_reg |= SDW_SHIM_SYNC_CMDSYNC << sdw->instance;
-	intel_writel(shim, SDW_SHIM_SYNC, sync_reg);
-
-	mutex_unlock(sdw->link_res->shim_lock);
+	intel_shim_sync_arm(sdw);
 
 	return 0;
 }
-- 
2.20.1

