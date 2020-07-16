Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C6CC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B9962076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGQDEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:04:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:62877 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgGQDET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:04:19 -0400
IronPort-SDR: TX3WOv+IJslxqDIOduqv4zG9TAYebKY+YVrjUcR81RxvMl3jrkrotKiQDWh9jMaJi8hEcZ+HEt
 Bk95mc4/RLtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="129613800"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="129613800"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:04:18 -0700
IronPort-SDR: eLGM3529Fo73mUvh/dVmE1xBHgLF/w3SCIsVvY3yXSeXb6Qdfo5QFTb8GEEhTKV0xqSukqfG6T
 RmUVUJmXvzSQ==
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="460699679"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:04:14 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 4/9] soundwire: intel: introduce helper for link synchronization
Date:   Thu, 16 Jul 2020 23:09:42 +0800
Message-Id: <20200716150947.22119-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716150947.22119-1-yung-chuan.liao@linux.intel.com>
References: <20200716150947.22119-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

After arming the synchronization, the SYNCGO field controls the
hardware-based synchronization between links.

Move the programming and wait for clear of SYNCGO to dedicated helper.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 6a745602c9cc..0a4fc7f65743 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -512,6 +512,31 @@ static void intel_shim_sync_arm(struct sdw_intel *sdw)
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
 /*
  * PDI routines
  */
@@ -763,15 +788,8 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
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
2.17.1

