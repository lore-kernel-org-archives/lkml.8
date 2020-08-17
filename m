Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C28C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD880204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgHRKR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 06:17:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:39352 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgHRKR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:17:26 -0400
IronPort-SDR: 3qVvRh29vkvtaGcoDcHJ+XWVRZCOxod4unzOSEiLPBGDX6eJehM/0Mf+SXoQG+nRWG5HHebA6+
 A9lV/P2ahuDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="152284286"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="152284286"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 03:17:26 -0700
IronPort-SDR: +RQdUwcKd0WpF1MV50K77ipSbXSpGk4l5pWDUHQoibQeSGg/cDyEdDflEAxvBYD4/wd4LIkt6S
 d0ZiwUUXD3Xg==
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="279363998"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 03:17:22 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: cadence: fix race condition between suspend and Slave device alerts
Date:   Tue, 18 Aug 2020 06:23:40 +0800
Message-Id: <20200817222340.18042-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

In system suspend stress cases, the SOF CI reports timeouts. The root
cause is that an alert is generated while the system suspends. The
interrupt handling generates transactions on the bus that will never
be handled because the interrupts are disabled in parallel.

As a result, the transaction never completes and times out on resume.
This error doesn't seem too problematic since it happens in a work
queue, and the system recovers without issues.

Nevertheless, this race condition should not happen. When doing a
system suspend, or when disabling interrupts, we should make sure the
current transaction can complete, and prevent new work from being
queued.

BugLink: https://github.com/thesofproject/linux/issues/2344
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 24 +++++++++++++++++++++++-
 drivers/soundwire/cadence_master.h |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 24eafe0aa1c3..1330ffc47596 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -791,7 +791,16 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
 			     CDNS_MCP_INT_SLAVE_MASK, 0);
 
 		int_status &= ~CDNS_MCP_INT_SLAVE_MASK;
-		schedule_work(&cdns->work);
+
+		/*
+		 * Deal with possible race condition between interrupt
+		 * handling and disabling interrupts on suspend.
+		 *
+		 * If the master is in the process of disabling
+		 * interrupts, don't schedule a workqueue
+		 */
+		if (cdns->interrupt_enabled)
+			schedule_work(&cdns->work);
 	}
 
 	cdns_writel(cdns, CDNS_MCP_INTSTAT, int_status);
@@ -924,6 +933,19 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state)
 		slave_state = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT1);
 		cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT1, slave_state);
 	}
+	cdns->interrupt_enabled = state;
+
+	/*
+	 * Complete any on-going status updates before updating masks,
+	 * and cancel queued status updates.
+	 *
+	 * There could be a race with a new interrupt thrown before
+	 * the 3 mask updates below are complete, so in the interrupt
+	 * we use the 'interrupt_enabled' status to prevent new work
+	 * from being queued.
+	 */
+	if (!state)
+		cancel_work_sync(&cdns->work);
 
 	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0, slave_intmask0);
 	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1, slave_intmask1);
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index fdec62b912d3..4d1aab5b5ec2 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -133,6 +133,7 @@ struct sdw_cdns {
 
 	bool link_up;
 	unsigned int msg_count;
+	bool interrupt_enabled;
 
 	struct work_struct work;
 
-- 
2.17.1

