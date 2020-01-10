Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083DAC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2772082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgAJV5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:57:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:3026 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727224AbgAJV5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:57:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 13:57:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="218782792"
Received: from unknown (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.183.94])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jan 2020 13:57:40 -0800
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
Subject: [PATCH 3/6] soundwire: cadence_master: log more useful information during timeouts
Date:   Fri, 10 Jan 2020 15:57:28 -0600
Message-Id: <20200110215731.30747-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110215731.30747-1-pierre-louis.bossart@linux.intel.com>
References: <20200110215731.30747-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the type of command, device number, register offset and length to
reverse engineer what caused the issue.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 847b8f5f0a32..6ef2f759310d 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -447,7 +447,8 @@ _cdns_xfer_msg(struct sdw_cdns *cdns, struct sdw_msg *msg, int cmd,
 	time = wait_for_completion_timeout(&cdns->tx_complete,
 					   msecs_to_jiffies(CDNS_TX_TIMEOUT));
 	if (!time) {
-		dev_err(cdns->dev, "IO transfer timed out\n");
+		dev_err(cdns->dev, "IO transfer timed out, cmd %d device %d addr %x len %d\n",
+			cmd, msg->dev_num, msg->addr, msg->len);
 		msg->len = 0;
 		return SDW_CMD_TIMEOUT;
 	}
-- 
2.20.1

