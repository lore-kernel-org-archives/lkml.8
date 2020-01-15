Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DBFC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 00:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FD224673
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 00:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgAOAJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 19:09:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:8608 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728656AbgAOAJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 19:09:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 16:09:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,320,1574150400"; 
   d="scan'208";a="273468548"
Received: from emkilgox-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.0.151])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jan 2020 16:09:38 -0800
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
Subject: [PATCH 02/10] soundwire: bus: fix race condition with enumeration_complete signaling
Date:   Tue, 14 Jan 2020 18:08:36 -0600
Message-Id: <20200115000844.14695-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200115000844.14695-1-pierre-louis.bossart@linux.intel.com>
References: <20200115000844.14695-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the signaling needed for Slave drivers to wait until
the enumeration completes so that race conditions when issuing
read/write commands are avoided. The calls for wait_for_completion()
will be added in codec drivers in follow-up patches.

The order between init_completion() and complete() is deterministic,
the Slave is marked as UNATTACHED either during a Master-initiated
HardReset, or when the hardware detects the Slave no longer reports as
ATTACHED.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c   | 20 ++++++++++++++++++++
 drivers/soundwire/slave.c |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 4980dfd6f3a3..a2267c3a1d2d 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -610,6 +610,26 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 				    enum sdw_slave_status status)
 {
 	mutex_lock(&slave->bus->bus_lock);
+
+	dev_vdbg(&slave->dev,
+		 "%s: changing status slave %d status %d new status %d\n",
+		 __func__, slave->dev_num, slave->status, status);
+
+	if (status == SDW_SLAVE_UNATTACHED) {
+		dev_dbg(&slave->dev,
+			"%s: initializing completion for Slave %d\n",
+			__func__, slave->dev_num);
+
+		init_completion(&slave->enumeration_complete);
+
+	} else if ((status == SDW_SLAVE_ATTACHED) &&
+		   (slave->status == SDW_SLAVE_UNATTACHED)) {
+		dev_dbg(&slave->dev,
+			"%s: signaling completion for Slave %d\n",
+			__func__, slave->dev_num);
+
+		complete(&slave->enumeration_complete);
+	}
 	slave->status = status;
 	mutex_unlock(&slave->bus->bus_lock);
 }
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 08db0488e02d..e767a78066ee 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -46,6 +46,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
 	slave->dev.of_node = of_node_get(to_of_node(fwnode));
 	slave->bus = bus;
 	slave->status = SDW_SLAVE_UNATTACHED;
+	init_completion(&slave->enumeration_complete);
 	slave->dev_num = 0;
 	init_completion(&slave->probe_complete);
 	slave->probed = false;
-- 
2.20.1

