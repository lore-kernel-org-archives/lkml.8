Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF346C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D0A20721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgAJV5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:57:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:3026 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbgAJV5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:57:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 13:57:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="218782801"
Received: from unknown (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.183.94])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jan 2020 13:57:43 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 5/6] soundwire: cadence_master: handle multiple status reports per Slave
Date:   Fri, 10 Jan 2020 15:57:30 -0600
Message-Id: <20200110215731.30747-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110215731.30747-1-pierre-louis.bossart@linux.intel.com>
References: <20200110215731.30747-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a Slave reports multiple status in the sticky bits, find the
latest configuration from the mirror of the PING frame status and
update the status directly.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 35 +++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 19b4862e8cce..b0de7d752bdb 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -676,13 +676,36 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
 
 		/* first check if Slave reported multiple status */
 		if (set_status > 1) {
+			u32 val;
+
 			dev_warn_ratelimited(cdns->dev,
-					     "Slave reported multiple Status: %d\n",
-					     mask);
-			/*
-			 * TODO: we need to reread the status here by
-			 * issuing a PING cmd
-			 */
+					     "Slave %d reported multiple Status: %d\n",
+					     i, mask);
+
+			/* check latest status extracted from PING commands */
+			val = cdns_readl(cdns, CDNS_MCP_SLAVE_STAT);
+			val >>= (i * 2);
+
+			switch (val & 0x3) {
+			case 0:
+				status[i] = SDW_SLAVE_UNATTACHED;
+				break;
+			case 1:
+				status[i] = SDW_SLAVE_ATTACHED;
+				break;
+			case 2:
+				status[i] = SDW_SLAVE_ALERT;
+				break;
+			case 3:
+			default:
+				status[i] = SDW_SLAVE_RESERVED;
+				break;
+			}
+
+			dev_warn_ratelimited(cdns->dev,
+					     "Slave %d status updated to %d\n",
+					     i, status[i]);
+
 		}
 	}
 
-- 
2.20.1

