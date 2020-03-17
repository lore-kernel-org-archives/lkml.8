Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02F7C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8070A20735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgCQQe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:34:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:47605 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbgCQQeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:34:24 -0400
IronPort-SDR: mlQyItaJDxvXpG/gUlGmpY6yaTjn6yJvkewwbd/zBoTTvwOoqRsSmDUTtpOcwwGo2xiprlhV6U
 4MQbHZ0qm8+g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 09:34:24 -0700
IronPort-SDR: EvGcPCRaHvMLRJWlBcqHnLpKZh+3Q+CvG+L67zvrllcDBDb/KiR7P1WA5K5FVodLbrnbIJ9WUL
 sXX0x/UQz+ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; 
   d="scan'208";a="244533182"
Received: from aavila-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.36.39])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2020 09:34:21 -0700
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
Subject: [PATCH v2 07/17] soundwire: cadence: mask Slave interrupt before stopping clock
Date:   Tue, 17 Mar 2020 11:33:19 -0500
Message-Id: <20200317163329.25501-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
References: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel QA reported a very rare case, possibly hardware-dependent, where
a Slave can become UNATTACHED during a clock stop sequence, which
leads to timeouts and failed suspend sequences.

This patch suppresses the handling of all Slave events while this
transition happens. The two cases that matter are:

a) alerts: if the Slave wants to signal an alert condition, it can do
so using the in-band wake, so there's almost no impact with this
patch.

b) sync loss or imp-def reset: in those cases, bringing back the Slave
to functional state requires a complete re-enumeration. It's better to
just ignore this case and restart cleanly, rather than attempt a
'clean' suspend.

Validation results show the timeouts no longer visible with this patch.

GitHub issue: https://github.com/thesofproject/linux/issues/1678
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 37e16199933c..613c63359413 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -865,6 +865,24 @@ int sdw_cdns_exit_reset(struct sdw_cdns *cdns)
 }
 EXPORT_SYMBOL(sdw_cdns_exit_reset);
 
+/**
+ * sdw_cdns_enable_slave_interrupt() - Enable SDW slave interrupts
+ * @cdns: Cadence instance
+ * @state: boolean for true/false
+ */
+static void cdns_enable_slave_interrupts(struct sdw_cdns *cdns, bool state)
+{
+	u32 mask;
+
+	mask = cdns_readl(cdns, CDNS_MCP_INTMASK);
+	if (state)
+		mask |= CDNS_MCP_INT_SLAVE_MASK;
+	else
+		mask &= ~CDNS_MCP_INT_SLAVE_MASK;
+
+	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
+}
+
 /**
  * sdw_cdns_enable_interrupt() - Enable SDW interrupts
  * @cdns: Cadence instance
@@ -1262,6 +1280,13 @@ int sdw_cdns_clock_stop(struct sdw_cdns *cdns, bool block_wake)
 		return 0;
 	}
 
+	/*
+	 * Before entering clock stop we mask the Slave
+	 * interrupts. This helps avoid having to deal with e.g. a
+	 * Slave becoming UNATTACHED while the clock is being stopped
+	 */
+	cdns_enable_slave_interrupts(cdns, false);
+
 	/*
 	 * For specific platforms, it is required to be able to put
 	 * master into a state in which it ignores wake-up trials
@@ -1339,6 +1364,9 @@ int sdw_cdns_clock_restart(struct sdw_cdns *cdns, bool bus_reset)
 {
 	int ret;
 
+	/* unmask Slave interrupts that were masked when stopping the clock */
+	cdns_enable_slave_interrupts(cdns, true);
+
 	ret = cdns_clear_bit(cdns, CDNS_MCP_CONTROL,
 			     CDNS_MCP_CONTROL_CLK_STOP_CLR);
 	if (ret < 0) {
-- 
2.20.1

