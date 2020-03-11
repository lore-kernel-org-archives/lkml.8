Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C7BC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43CC20736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbgCKSma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:42:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:27252 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731015AbgCKSmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:42:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 11:42:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="441776353"
Received: from fjan-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.25.157])
  by fmsmga005.fm.intel.com with ESMTP; 11 Mar 2020 11:42:11 -0700
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
Subject: [PATCH 16/16] soundwire: cadence: multi-link support
Date:   Wed, 11 Mar 2020 13:41:28 -0500
Message-Id: <20200311184128.4212-17-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
References: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable multi-link (aka multi-master configuration). In this
configuration, updates and commands with the 'ssp_sync' tag will be
deferred and controlled by the gsync hardware signal.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 112f4ebcf1be..5b07ce195100 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -843,7 +843,13 @@ int sdw_cdns_exit_reset(struct sdw_cdns *cdns)
 		     CDNS_MCP_CONTROL_HW_RST);
 
 	/* commit changes */
-	return cdns_config_update(cdns);
+	cdns_updatel(cdns, CDNS_MCP_CONFIG_UPDATE,
+		     CDNS_MCP_CONFIG_UPDATE_BIT,
+		     CDNS_MCP_CONFIG_UPDATE_BIT);
+
+	/* don't wait here */
+	return 0;
+
 }
 EXPORT_SYMBOL(sdw_cdns_exit_reset);
 
@@ -1104,7 +1110,9 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 	/* Disable auto bus release */
 	val &= ~CDNS_MCP_CONFIG_BUS_REL;
 
-	/* Multi-master support to be added here */
+	if (cdns->bus.multi_link)
+		/* Set Multi-master mode to take gsync into account */
+		val |= CDNS_MCP_CONFIG_MMASTER;
 
 	/* leave frame delay to hardware default of 0x1F */
 
-- 
2.20.1

