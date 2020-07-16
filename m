Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B481C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8202E2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGQDER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:04:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:62877 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgGQDER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:04:17 -0400
IronPort-SDR: fCfm3IkEhuCu1CX38ePSLJrOmDutpsW8cWAX7Pt9izyk+K7BYz/nKBUE9c+sCwJ2Vj26T4n5BW
 pMH37jW+FVjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="129613794"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="129613794"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:04:16 -0700
IronPort-SDR: 97JuztKorr5Q2ExCCb+E6sq07VTvUOkm8NOQoQctlGdEqF/EqN69u9O5FVUs97OINhK/Mun9Pp
 kDBUTP8yb3iA==
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="460699667"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:04:10 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 3/9] soundwire: intel: introduce a helper to arm link synchronization
Date:   Thu, 16 Jul 2020 23:09:41 +0800
Message-Id: <20200716150947.22119-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716150947.22119-1-yung-chuan.liao@linux.intel.com>
References: <20200716150947.22119-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Move code from pre_bank_switch to dedicated helper, will be used in
follow-up patches as recommended by programming flows.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 4792613e8e5a..6a745602c9cc 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -497,6 +497,21 @@ static int __maybe_unused intel_link_power_down(struct sdw_intel *sdw)
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
@@ -710,21 +725,12 @@ static int intel_pre_bank_switch(struct sdw_bus *bus)
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
2.17.1

