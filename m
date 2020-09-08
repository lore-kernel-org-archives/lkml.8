Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB29C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 01:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C20DE21973
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 01:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgIIBjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 21:39:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:57639 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727940AbgIIBjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 21:39:13 -0400
IronPort-SDR: VxrwWtmlHNRJdFyxBL8WUiLIcJl/Lcwz7+263FkZuD7o4Z3xmXuQVuZsJ5RFXeMmO7WzZvEWDp
 l6LXH17S/wBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="137770890"
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="137770890"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 18:39:13 -0700
IronPort-SDR: Ik9VcC61IreXChdeMB1F4svObvNssA7XFY7DGDFXdqArt85RctHr3ABh7FQ/q67RJrY6ljXYBI
 w5j0veT0Jxww==
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="449018091"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 18:39:09 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 2/7] soundwire: bus: filter-out unwanted interrupt reports
Date:   Tue,  8 Sep 2020 21:45:16 +0800
Message-Id: <20200908134521.6781-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908134521.6781-1-yung-chuan.liao@linux.intel.com>
References: <20200908134521.6781-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Unlike the traditional usage, in the SoundWire specification the
interrupt masks only gate the propagation of an interrupt condition to
the PING frame status. They do not gate the changes of the INT_STAT
registers, which will happen regardless of the mask settings. See
Figure 116 of the SoundWire 1.2 specification for an in-depth
description of the interrupt model.

When the bus driver reads the SCP_INT1_STAT register, it will retrieve
all the interrupt status, including for the mask fields that were not
explicitly set. For example, even if the PARITY mask is not set, the
PARITY error status will be reported if an implementation-defined
interrupt for jack detection is enabled and occurs.

Filtering undesired interrupt reports and handling has to be
implemented in software. This patch enables this filtering for the
INT1_IMPL_DEF, PARITY and BUS_CLASH interrupt sources.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 9f4cc24ccea3..029818b1f568 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1394,12 +1394,14 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		 * interrupt
 		 */
 		if (buf & SDW_SCP_INT1_PARITY) {
-			dev_err(&slave->dev, "Parity error detected\n");
+			if (slave->prop.scp_int1_mask & SDW_SCP_INT1_PARITY)
+				dev_err(&slave->dev, "Parity error detected\n");
 			clear |= SDW_SCP_INT1_PARITY;
 		}
 
 		if (buf & SDW_SCP_INT1_BUS_CLASH) {
-			dev_err(&slave->dev, "Bus clash error detected\n");
+			if (slave->prop.scp_int1_mask & SDW_SCP_INT1_BUS_CLASH)
+				dev_err(&slave->dev, "Bus clash detected\n");
 			clear |= SDW_SCP_INT1_BUS_CLASH;
 		}
 
@@ -1411,9 +1413,11 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		 */
 
 		if (buf & SDW_SCP_INT1_IMPL_DEF) {
-			dev_dbg(&slave->dev, "Slave impl defined interrupt\n");
+			if (slave->prop.scp_int1_mask & SDW_SCP_INT1_IMPL_DEF) {
+				dev_dbg(&slave->dev, "Slave impl defined interrupt\n");
+				slave_notify = true;
+			}
 			clear |= SDW_SCP_INT1_IMPL_DEF;
-			slave_notify = true;
 		}
 
 		/* Check port 0 - 3 interrupts */
-- 
2.17.1

