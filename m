Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B32C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE30E2076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgHROfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:35:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:33372 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbgHROfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:35:47 -0400
IronPort-SDR: CxxeC/fU9l6/KsB7y5lHgBneR71xaup61SkWoRUnftRBoKVOCCTYukLuGNJKA9T5FfZ1ftN53s
 Vdm9PnerUxNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154170542"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="154170542"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 07:35:46 -0700
IronPort-SDR: twSiAiudEPC6ZAJzPOolKp8o4ELzJfqYKN2EkbCkXbi4EVJoKO3ywPtM5zQb+HtXCpMxrIBBC3
 XYfn0uFXjoTA==
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="471830696"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 07:35:43 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 08/11] soundwire: stream: enable hw_sync as needed by hardware
Date:   Tue, 18 Aug 2020 10:41:17 +0800
Message-Id: <20200818024120.20721-9-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Use platform-specific information to decide when to use hw_sync, not
only a number of links > 1.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 37290a799023..e4cf484f5905 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -689,9 +689,9 @@ static int sdw_bank_switch(struct sdw_bus *bus, int m_rt_count)
 
 	/*
 	 * Set the multi_link flag only when both the hardware supports
-	 * and there is a stream handled by multiple masters
+	 * and hardware-based sync is required
 	 */
-	multi_link = bus->multi_link && (m_rt_count > 1);
+	multi_link = bus->multi_link && (m_rt_count >= bus->hw_sync_min_links);
 
 	if (multi_link)
 		ret = sdw_transfer_defer(bus, wr_msg, &bus->defer_msg);
@@ -760,13 +760,16 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 	const struct sdw_master_ops *ops;
 	struct sdw_bus *bus;
 	bool multi_link = false;
+	int m_rt_count;
 	int ret = 0;
 
+	m_rt_count = stream->m_rt_count;
+
 	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
 		bus = m_rt->bus;
 		ops = bus->ops;
 
-		if (bus->multi_link) {
+		if (bus->multi_link && m_rt_count >= bus->hw_sync_min_links) {
 			multi_link = true;
 			mutex_lock(&bus->msg_lock);
 		}
@@ -787,7 +790,7 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 		 * synchronized across all Masters and happens later as a
 		 * part of post_bank_switch ops.
 		 */
-		ret = sdw_bank_switch(bus, stream->m_rt_count);
+		ret = sdw_bank_switch(bus, m_rt_count);
 		if (ret < 0) {
 			dev_err(bus->dev, "Bank switch failed: %d\n", ret);
 			goto error;
@@ -813,7 +816,7 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 					ret);
 				goto error;
 			}
-		} else if (bus->multi_link && stream->m_rt_count > 1) {
+		} else if (multi_link) {
 			dev_err(bus->dev,
 				"Post bank switch ops not implemented\n");
 			goto error;
@@ -831,7 +834,7 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 			goto error;
 		}
 
-		if (bus->multi_link)
+		if (multi_link)
 			mutex_unlock(&bus->msg_lock);
 	}
 
-- 
2.17.1

