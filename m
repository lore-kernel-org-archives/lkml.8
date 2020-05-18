Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9AEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2974320709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgESIam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 04:30:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:31993 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgESIal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:30:41 -0400
IronPort-SDR: hEmmlUeB+ksfMoUdFg2X2s1JAfKxF5v/fOl4w/E2SHkoWWwBwx3uQCmqdQn/s2EfdQQvxUw/yX
 9HdopesDCUAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 01:30:40 -0700
IronPort-SDR: gaXqNWvjg8kCkmUz7jDm7ZIZiK+jr2wYSiQvRU+fSCgdHqkOJW0WITrnSitAbdoy+lsjEyhPlz
 o2pgjWk2kojw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; 
   d="scan'208";a="264233991"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga003.jf.intel.com with ESMTP; 19 May 2020 01:30:36 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 1/3] soundwire: disco: s/ch/channels/
Date:   Tue, 19 May 2020 04:35:49 +0800
Message-Id: <20200518203551.2053-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518203551.2053-1-yung-chuan.liao@linux.intel.com>
References: <20200518203551.2053-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Use more meaningful member names in preparation for sysfs support.
No functionality change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 11 ++++++-----
 include/linux/soundwire/sdw.h  |  8 ++++----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index 844e6b22974f..4ae62b452b8c 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -231,16 +231,17 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 
 		nval = fwnode_property_count_u32(node, "mipi-sdw-channel-number-list");
 		if (nval > 0) {
-			dpn[i].num_ch = nval;
-			dpn[i].ch = devm_kcalloc(&slave->dev, dpn[i].num_ch,
-						 sizeof(*dpn[i].ch),
+			dpn[i].num_channels = nval;
+			dpn[i].channels = devm_kcalloc(&slave->dev,
+						       dpn[i].num_channels,
+						       sizeof(*dpn[i].channels),
 						 GFP_KERNEL);
-			if (!dpn[i].ch)
+			if (!dpn[i].channels)
 				return -ENOMEM;
 
 			fwnode_property_read_u32_array(node,
 					"mipi-sdw-channel-number-list",
-					dpn[i].ch, dpn[i].num_ch);
+					dpn[i].channels, dpn[i].num_channels);
 		}
 
 		nval = fwnode_property_count_u32(node, "mipi-sdw-channel-combination-list");
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 7658d9698dd5..9c27a32df9bb 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -291,8 +291,8 @@ struct sdw_dpn_audio_mode {
  * implementation-defined interrupts
  * @max_ch: Maximum channels supported
  * @min_ch: Minimum channels supported
- * @num_ch: Number of discrete channels supported
- * @ch: Discrete channels supported
+ * @num_channels: Number of discrete channels supported
+ * @channels: Discrete channels supported
  * @num_ch_combinations: Number of channel combinations supported
  * @ch_combinations: Channel combinations supported
  * @modes: SDW mode supported
@@ -316,8 +316,8 @@ struct sdw_dpn_prop {
 	u32 imp_def_interrupts;
 	u32 max_ch;
 	u32 min_ch;
-	u32 num_ch;
-	u32 *ch;
+	u32 num_channels;
+	u32 *channels;
 	u32 num_ch_combinations;
 	u32 *ch_combinations;
 	u32 modes;
-- 
2.17.1

