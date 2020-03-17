Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDABFC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7E020738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgCQQeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:34:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:47605 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgCQQe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:34:29 -0400
IronPort-SDR: 5+PFBOLUVMcOW0wRbcdP6fZX4ieFR5AFZvEs/QDSskR2nq4rBrmb6TryA8DNU9t8uGMDqxJ+E9
 jW7hcGETvGZg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 09:34:29 -0700
IronPort-SDR: jO4V8RHXIoYxzXl4Sxw/nF1zgdG43p5CHRIsKj3KlFi25qkghyV4jmAgM2QgLdRXOVJy4jiXTn
 7uSfN83nwd1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; 
   d="scan'208";a="244533215"
Received: from aavila-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.36.39])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2020 09:34:26 -0700
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
Subject: [PATCH v2 09/17] soundwire: cadence: move clock/SSP related inits to dedicated function
Date:   Tue, 17 Mar 2020 11:33:21 -0500
Message-Id: <20200317163329.25501-10-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
References: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helps isolate code and align with recommended programming flows

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 7d9fc2c645e3..fb697ff665f5 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1043,11 +1043,7 @@ static u32 cdns_set_initial_frame_shape(int n_rows, int n_cols)
 	return val;
 }
 
-/**
- * sdw_cdns_init() - Cadence initialization
- * @cdns: Cadence instance
- */
-int sdw_cdns_init(struct sdw_cdns *cdns)
+static void cdns_init_clock_ctrl(struct sdw_cdns *cdns)
 {
 	struct sdw_bus *bus = &cdns->bus;
 	struct sdw_master_prop *prop = &bus->prop;
@@ -1073,6 +1069,18 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 	/* Set SSP interval to default value */
 	cdns_writel(cdns, CDNS_MCP_SSP_CTRL0, CDNS_DEFAULT_SSP_INTERVAL);
 	cdns_writel(cdns, CDNS_MCP_SSP_CTRL1, CDNS_DEFAULT_SSP_INTERVAL);
+}
+
+/**
+ * sdw_cdns_init() - Cadence initialization
+ * @cdns: Cadence instance
+ */
+int sdw_cdns_init(struct sdw_cdns *cdns)
+{
+	u32 val;
+	int ret;
+
+	cdns_init_clock_ctrl(cdns);
 
 	/* reset msg_count to default value of FIFOLEVEL */
 	cdns->msg_count = cdns_readl(cdns, CDNS_MCP_FIFOLEVEL);
-- 
2.20.1

