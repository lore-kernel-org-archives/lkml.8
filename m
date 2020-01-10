Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABC9C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9000020721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgAJV5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:57:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:3026 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbgAJV5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:57:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 13:57:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="218782809"
Received: from unknown (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.183.94])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jan 2020 13:57:45 -0800
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
Subject: [PATCH 6/6] soundwire: bus: check first if Slaves become UNATTACHED
Date:   Fri, 10 Jan 2020 15:57:31 -0600
Message-Id: <20200110215731.30747-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110215731.30747-1-pierre-louis.bossart@linux.intel.com>
References: <20200110215731.30747-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before checking for the presence of Device0, we first need to clean-up
the internal state of Slaves that are no longer attached.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index be5d437058ed..66fd09e36b73 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -979,6 +979,24 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 	struct sdw_slave *slave;
 	int i, ret = 0;
 
+	/* first check if any Slaves fell off the bus */
+	for (i = 1; i <= SDW_MAX_DEVICES; i++) {
+		mutex_lock(&bus->bus_lock);
+		if (test_bit(i, bus->assigned) == false) {
+			mutex_unlock(&bus->bus_lock);
+			continue;
+		}
+		mutex_unlock(&bus->bus_lock);
+
+		slave = sdw_get_slave(bus, i);
+		if (!slave)
+			continue;
+
+		if (status[i] == SDW_SLAVE_UNATTACHED &&
+		    slave->status != SDW_SLAVE_UNATTACHED)
+			sdw_modify_slave_status(slave, SDW_SLAVE_UNATTACHED);
+	}
+
 	if (status[0] == SDW_SLAVE_ATTACHED) {
 		dev_dbg(bus->dev, "Slave attached, programming device number\n");
 		ret = sdw_program_device_num(bus);
-- 
2.20.1

