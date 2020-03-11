Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2837C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CDD206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbgCKSlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:41:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:27194 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730894AbgCKSln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:41:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 11:41:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="441776218"
Received: from fjan-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.25.157])
  by fmsmga005.fm.intel.com with ESMTP; 11 Mar 2020 11:41:40 -0700
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
Subject: [PATCH 02/16] soundwire: cadence: simplifiy cdns_init()
Date:   Wed, 11 Mar 2020 13:41:14 -0500
Message-Id: <20200311184128.4212-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
References: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@intel.com>

There is no need for the clock_stop_exit argument with the latest
implementation

Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 12 +-----------
 drivers/soundwire/cadence_master.h |  2 +-
 drivers/soundwire/intel.c          |  2 +-
 3 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index a1a889d1d7dc..941809ea00a8 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1018,22 +1018,12 @@ static u32 cdns_set_initial_frame_shape(int n_rows, int n_cols)
  * sdw_cdns_init() - Cadence initialization
  * @cdns: Cadence instance
  */
-int sdw_cdns_init(struct sdw_cdns *cdns, bool clock_stop_exit)
+int sdw_cdns_init(struct sdw_cdns *cdns)
 {
 	struct sdw_bus *bus = &cdns->bus;
 	struct sdw_master_prop *prop = &bus->prop;
 	u32 val;
 	int divider;
-	int ret;
-
-	if (clock_stop_exit) {
-		ret = cdns_clear_bit(cdns, CDNS_MCP_CONTROL,
-				     CDNS_MCP_CONTROL_CLK_STOP_CLR);
-		if (ret < 0) {
-			dev_err(cdns->dev, "Couldn't exit from clock stop\n");
-			return ret;
-		}
-	}
 
 	/* Set clock divider */
 	divider	= (prop->mclk_freq / prop->max_clk_freq) - 1;
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 2de1b2493ffc..44e802bba702 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -138,7 +138,7 @@ extern struct sdw_master_ops sdw_cdns_master_ops;
 irqreturn_t sdw_cdns_irq(int irq, void *dev_id);
 irqreturn_t sdw_cdns_thread(int irq, void *dev_id);
 
-int sdw_cdns_init(struct sdw_cdns *cdns, bool clock_stop_exit);
+int sdw_cdns_init(struct sdw_cdns *cdns);
 int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 		      struct sdw_cdns_stream_config config);
 int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index a327669c757b..3c83e76c6bf9 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1077,7 +1077,7 @@ static int intel_init(struct sdw_intel *sdw)
 	intel_link_power_up(sdw);
 	intel_shim_init(sdw);
 
-	return sdw_cdns_init(&sdw->cdns, false);
+	return sdw_cdns_init(&sdw->cdns);
 }
 
 /*
-- 
2.20.1

