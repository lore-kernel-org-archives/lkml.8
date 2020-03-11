Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929FCC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDC8206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbgCKSl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:41:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:27194 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730947AbgCKSly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:41:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 11:41:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="441776253"
Received: from fjan-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.25.157])
  by fmsmga005.fm.intel.com with ESMTP; 11 Mar 2020 11:41:51 -0700
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
Subject: [PATCH 07/16] soundwire: cadence: mask Slave interrupt before stopping clock
Date:   Wed, 11 Mar 2020 13:41:19 -0500
Message-Id: <20200311184128.4212-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
References: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
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
index 02f18ce6b7e7..a4ba57f44c1f 100644
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
@@ -1272,6 +1290,13 @@ int sdw_cdns_clock_stop(struct sdw_cdns *cdns, bool block_wake)
 		return 1;
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
@@ -1349,6 +1374,9 @@ int sdw_cdns_clock_restart(struct sdw_cdns *cdns, bool bus_reset)
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

