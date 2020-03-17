Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14267C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97CE20738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgCQQeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:34:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:47605 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgCQQeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:34:08 -0400
IronPort-SDR: XrRKPmNwhRiCdPUp12mwtL7pSnu7K5erdqNRnWyh1c3k0rqFK9D1etOoE4bTLVJLu9tGjgJ1wt
 HiD3cxLX0tiQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 09:34:08 -0700
IronPort-SDR: c0mPvOrRq2Ju7Qajdh46hx33f5enc6fln7SadQEKlOBqMKRXOJleMv2njavSVMXzwuLTOePkyr
 CFVLT44VYToA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; 
   d="scan'208";a="244533112"
Received: from aavila-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.36.39])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2020 09:34:06 -0700
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
Subject: [PATCH v2 01/17] soundwire: cadence: s/update_config/config_update
Date:   Tue, 17 Mar 2020 11:33:13 -0500
Message-Id: <20200317163329.25501-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
References: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow we inverted the two, align with register definition to avoid
further confusion.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 9bec270d0fa4..a1a889d1d7dc 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -235,7 +235,7 @@ static int cdns_clear_bit(struct sdw_cdns *cdns, int offset, u32 value)
  * all changes to the MCP_CONFIG, MCP_CONTROL, MCP_CMDCTRL and MCP_PHYCTRL
  * need to be confirmed with a write to MCP_CONFIG_UPDATE
  */
-static int cdns_update_config(struct sdw_cdns *cdns)
+static int cdns_config_update(struct sdw_cdns *cdns)
 {
 	int ret;
 
@@ -838,7 +838,7 @@ int sdw_cdns_exit_reset(struct sdw_cdns *cdns)
 		     CDNS_MCP_CONFIG_OP_NORMAL);
 
 	/* commit changes */
-	return cdns_update_config(cdns);
+	return cdns_config_update(cdns);
 }
 EXPORT_SYMBOL(sdw_cdns_exit_reset);
 
@@ -1084,7 +1084,7 @@ int sdw_cdns_init(struct sdw_cdns *cdns, bool clock_stop_exit)
 	cdns_writel(cdns, CDNS_MCP_CONFIG, val);
 
 	/* commit changes */
-	return cdns_update_config(cdns);
+	return cdns_config_update(cdns);
 }
 EXPORT_SYMBOL(sdw_cdns_init);
 
-- 
2.20.1

