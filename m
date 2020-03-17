Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663FAC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F0320735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgCQQeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:34:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:47605 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgCQQeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:34:14 -0400
IronPort-SDR: W8cJvy6K8Pg5muopLI/hQYNbmrgw3pcuqH4Ngm3s6g7atwVqgx+e2/tm5rM6D/y0OYFYhG2n/O
 PoN+NGQfPgmw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 09:34:14 -0700
IronPort-SDR: 9Sh7qCZdtwQavnDgqSRizJyeLKpbru1aoWPI5pNznFIT7CefrBg8og90MV2U/ATKZZ6bUMT+hY
 SmZce7yrMGmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; 
   d="scan'208";a="244533129"
Received: from aavila-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.36.39])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2020 09:34:11 -0700
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
Subject: [PATCH v2 03/17] soundwire: cadence: add interface to check clock status
Date:   Tue, 17 Mar 2020 11:33:15 -0500
Message-Id: <20200317163329.25501-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
References: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@intel.com>

If master is in clock stop state, driver can't modify registers
in master except the registers for clock stop setting.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 11 +++++++++++
 drivers/soundwire/cadence_master.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 941809ea00a8..1bfdc1d4fcb1 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1207,6 +1207,17 @@ static const struct sdw_master_port_ops cdns_port_ops = {
 	.dpn_port_enable_ch = cdns_port_enable,
 };
 
+/**
+ * sdw_cdns_is_clock_stop: Check clock status
+ *
+ * @cdns: Cadence instance
+ */
+bool sdw_cdns_is_clock_stop(struct sdw_cdns *cdns)
+{
+	return !!(cdns_readl(cdns, CDNS_MCP_STAT) & CDNS_MCP_STAT_CLK_STOP);
+}
+EXPORT_SYMBOL(sdw_cdns_is_clock_stop);
+
 /**
  * sdw_cdns_probe() - Cadence probe routine
  * @cdns: Cadence instance
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 44e802bba702..691faa386889 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -144,6 +144,8 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
 int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state);
 
+bool sdw_cdns_is_clock_stop(struct sdw_cdns *cdns);
+
 #ifdef CONFIG_DEBUG_FS
 void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
 #endif
-- 
2.20.1

