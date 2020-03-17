Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8819CC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E8720735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgCQQeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:34:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:47605 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgCQQee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:34:34 -0400
IronPort-SDR: QXTylH6xbO9hsvExEwJ78KSmwrfnWnfjtBNaxAVVD8Ef7MNHOCF5h6L9yommIQljzn15FNhisr
 iZRvhtGYVA8g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 09:34:34 -0700
IronPort-SDR: lcAH2ffeFxx5x26Y1nVbvypyt3mutvCG0QdxTp52zZajFfDFHsDYdDvgQmuYsP2BzbmjTwdTu8
 t55st0bx0qEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; 
   d="scan'208";a="244533234"
Received: from aavila-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.36.39])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2020 09:34:31 -0700
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
Subject: [PATCH v2 11/17] soundwire: cadence: reorder MCP_CONFIG settings
Date:   Tue, 17 Mar 2020 11:33:23 -0500
Message-Id: <20200317163329.25501-12-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
References: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow hardware programming flows and add placeholder comment for
multi-master mode.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 773341568d7e..9afce1f32076 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1097,20 +1097,22 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 	/* Configure mcp config */
 	val = cdns_readl(cdns, CDNS_MCP_CONFIG);
 
-	/* Set Max cmd retry to 15 */
-	val |= CDNS_MCP_CONFIG_MCMD_RETRY;
+	/* Set cmd mode for Tx and Rx cmds */
+	val &= ~CDNS_MCP_CONFIG_CMD;
 
-	/* Set frame delay between PREQ and ping frame to 15 frames */
-	val |= 0xF << SDW_REG_SHIFT(CDNS_MCP_CONFIG_MPREQ_DELAY);
+	/* Disable sniffer mode */
+	val &= ~CDNS_MCP_CONFIG_SNIFFER;
 
 	/* Disable auto bus release */
 	val &= ~CDNS_MCP_CONFIG_BUS_REL;
 
-	/* Disable sniffer mode */
-	val &= ~CDNS_MCP_CONFIG_SNIFFER;
+	/* Multi-master support to be added here */
 
-	/* Set cmd mode for Tx and Rx cmds */
-	val &= ~CDNS_MCP_CONFIG_CMD;
+	/* Set frame delay between PREQ and ping frame to 15 frames */
+	val |= 0xF << SDW_REG_SHIFT(CDNS_MCP_CONFIG_MPREQ_DELAY);
+
+	/* Set Max cmd retry to 15 */
+	val |= CDNS_MCP_CONFIG_MCMD_RETRY;
 
 	cdns_writel(cdns, CDNS_MCP_CONFIG, val);
 
-- 
2.20.1

