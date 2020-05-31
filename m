Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C30BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A5E5207F7
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgFADMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 23:12:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:62416 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgFADMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 23:12:46 -0400
IronPort-SDR: CLYH+o7AGxFahnGaBkR02WoPqg7pjAkc6y5GIs6v5qVqGpkccJEPtuAwKzwTyDrGn8wKuPiUJt
 ucy8DKNfMOAQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 20:12:46 -0700
IronPort-SDR: NW4Fbl4SM5gX2PDB1WKlalXclQeVn0a5hiPCQUpJPcwYF75cIYEdWt4/+e7D+w/x8zNY4DSELw
 pTz84bSS3R1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="293041317"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga004.fm.intel.com with ESMTP; 31 May 2020 20:12:42 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH] soundwire: bus: clock_stop: don't deal with UNATTACHED Slave devices
Date:   Sun, 31 May 2020 23:18:06 +0800
Message-Id: <20200531151806.25951-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to do anything for the slave if it is unattached during
clock stop prepare and exit sequences.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 2289c2ac8c5a..405335fb790a 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -863,13 +863,13 @@ int sdw_bus_prep_clk_stop(struct sdw_bus *bus)
 		if (!slave->dev_num)
 			continue;
 
-		/* Identify if Slave(s) are available on Bus */
-		is_slave = true;
-
 		if (slave->status != SDW_SLAVE_ATTACHED &&
 		    slave->status != SDW_SLAVE_ALERT)
 			continue;
 
+		/* Identify if Slave(s) are available on Bus */
+		is_slave = true;
+
 		slave_mode = sdw_get_clk_stop_mode(slave);
 		slave->curr_clk_stop_mode = slave_mode;
 
@@ -900,6 +900,10 @@ int sdw_bus_prep_clk_stop(struct sdw_bus *bus)
 			return ret;
 	}
 
+	/* Don't need to inform slaves if there is no slave attached */
+	if (!is_slave)
+		return ret;
+
 	/* Inform slaves that prep is done */
 	list_for_each_entry(slave, &bus->slaves, node) {
 		if (!slave->dev_num)
@@ -985,13 +989,13 @@ int sdw_bus_exit_clk_stop(struct sdw_bus *bus)
 		if (!slave->dev_num)
 			continue;
 
-		/* Identify if Slave(s) are available on Bus */
-		is_slave = true;
-
 		if (slave->status != SDW_SLAVE_ATTACHED &&
 		    slave->status != SDW_SLAVE_ALERT)
 			continue;
 
+		/* Identify if Slave(s) are available on Bus */
+		is_slave = true;
+
 		mode = slave->curr_clk_stop_mode;
 
 		if (mode == SDW_CLK_STOP_MODE1) {
@@ -1016,6 +1020,13 @@ int sdw_bus_exit_clk_stop(struct sdw_bus *bus)
 	if (is_slave && !simple_clk_stop)
 		sdw_bus_wait_for_clk_prep_deprep(bus, SDW_BROADCAST_DEV_NUM);
 
+	/*
+	 * Don't need to call slave callback function if there is no slave
+	 * attached
+	 */
+	if (!is_slave)
+		return 0;
+
 	list_for_each_entry(slave, &bus->slaves, node) {
 		if (!slave->dev_num)
 			continue;
-- 
2.17.1

