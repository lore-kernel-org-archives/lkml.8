Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B667C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49285206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbgCKSmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:42:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:27194 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730954AbgCKSmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:42:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 11:42:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="441776290"
Received: from fjan-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.25.157])
  by fmsmga005.fm.intel.com with ESMTP; 11 Mar 2020 11:41:58 -0700
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
Subject: [PATCH 10/16] soundwire: cadence: make SSP interval programmable
Date:   Wed, 11 Mar 2020 13:41:22 -0500
Message-Id: <20200311184128.4212-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
References: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In multi-master mode, the IP will only accept SSP intervals with
integer relationships between the frame rate and the gsync frequency.

E.g for a 48kHz frame rate and 4 kHz gsync signal, the SSP interval
can only be 1, 2, 3, 4, 6, 12.

To simplify we only allow one SSP per gsync interval.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 7 ++++---
 drivers/soundwire/cadence_master.h | 3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 91fe89a246ee..4a7e7329ff0d 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -183,7 +183,6 @@ MODULE_PARM_DESC(cdns_mcp_int_mask, "Cadence MCP IntMask");
 #define CDNS_PDI_CONFIG_PORT			GENMASK(4, 0)
 
 /* Driver defaults */
-#define CDNS_DEFAULT_SSP_INTERVAL		0x18
 #define CDNS_TX_TIMEOUT				2000
 
 #define CDNS_SCP_RX_FIFOLEVEL			0x2
@@ -1048,6 +1047,7 @@ static void cdns_init_clock_ctrl(struct sdw_cdns *cdns)
 	struct sdw_bus *bus = &cdns->bus;
 	struct sdw_master_prop *prop = &bus->prop;
 	u32 val;
+	u32 ssp_interval;
 	int divider;
 
 	/* Set clock divider */
@@ -1067,8 +1067,9 @@ static void cdns_init_clock_ctrl(struct sdw_cdns *cdns)
 	cdns_writel(cdns, CDNS_MCP_FRAME_SHAPE_INIT, val);
 
 	/* Set SSP interval to default value */
-	cdns_writel(cdns, CDNS_MCP_SSP_CTRL0, CDNS_DEFAULT_SSP_INTERVAL);
-	cdns_writel(cdns, CDNS_MCP_SSP_CTRL1, CDNS_DEFAULT_SSP_INTERVAL);
+	ssp_interval = prop->default_frame_rate / SDW_CADENCE_GSYNC_HZ;
+	cdns_writel(cdns, CDNS_MCP_SSP_CTRL0, ssp_interval);
+	cdns_writel(cdns, CDNS_MCP_SSP_CTRL1, ssp_interval);
 }
 
 /**
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index e8fa5c7e09f4..b410656f8194 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -5,6 +5,9 @@
 #ifndef __SDW_CADENCE_H
 #define __SDW_CADENCE_H
 
+#define SDW_CADENCE_GSYNC_KHZ		4 /* 4 kHz */
+#define SDW_CADENCE_GSYNC_HZ		(SDW_CADENCE_GSYNC_KHZ * 1000)
+
 /**
  * struct sdw_cdns_pdi: PDI (Physical Data Interface) instance
  *
-- 
2.20.1

