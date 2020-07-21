Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86605C433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66FA520717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbgGVIc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:32:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:27817 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGVIcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:32:24 -0400
IronPort-SDR: AECNUiOXfqEKnB2whIRU65RRt/y/hnZmIf8uKbdel0x4tR76Y7GY8eDweVBgBio8fetJUx2jn+
 cqkThyCVPRoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="129858852"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="129858852"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:32:24 -0700
IronPort-SDR: e4NQk+wdFHP7m7aQaEA641O/lNMqGfP3punzwxUF9ZnJYbirtmEy/LaS8Hwp2LOwHXiQpJ4VLl
 SYv39qO0Vymg==
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="432303362"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:32:18 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 09/13] soundwire: intel: add CLK_STOP_BUS_RESET support
Date:   Wed, 22 Jul 2020 04:37:19 +0800
Message-Id: <20200721203723.18305-10-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@intel.com>

Move existing pm_runtime suspend under the CLK_STOP_TEARDOWN case.

In this mode the Master IP will lose all context but in-band wakes are
supported.

On pm_runtime resume a complete re-enumeration will be performed after
a bus reset.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 44 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 1954eb48b86c..744fc0a4816a 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1576,6 +1576,26 @@ static int intel_suspend_runtime(struct device *dev)
 
 		intel_shim_wake(sdw, false);
 
+	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) {
+		ret = sdw_cdns_clock_stop(cdns, true);
+		if (ret < 0) {
+			dev_err(dev, "cannot enable clock stop on suspend\n");
+			return ret;
+		}
+
+		ret = sdw_cdns_enable_interrupt(cdns, false);
+		if (ret < 0) {
+			dev_err(dev, "cannot disable interrupts on suspend\n");
+			return ret;
+		}
+
+		ret = intel_link_power_down(sdw);
+		if (ret) {
+			dev_err(dev, "Link power down failed: %d", ret);
+			return ret;
+		}
+
+		intel_shim_wake(sdw, true);
 	} else {
 		dev_err(dev, "%s clock_stop_quirks %x unsupported\n",
 			__func__, clock_stop_quirks);
@@ -1694,6 +1714,30 @@ static int intel_resume_runtime(struct device *dev)
 			dev_err(dev, "unable to exit bus reset sequence during resume\n");
 			return ret;
 		}
+	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) {
+		ret = intel_init(sdw);
+		if (ret) {
+			dev_err(dev, "%s failed: %d", __func__, ret);
+			return ret;
+		}
+
+		/*
+		 * make sure all Slaves are tagged as UNATTACHED and
+		 * provide reason for reinitialization
+		 */
+		sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
+
+		ret = sdw_cdns_enable_interrupt(cdns, true);
+		if (ret < 0) {
+			dev_err(dev, "cannot enable interrupts during resume\n");
+			return ret;
+		}
+
+		ret = sdw_cdns_clock_restart(cdns, true);
+		if (ret < 0) {
+			dev_err(dev, "unable to restart clock during resume\n");
+			return ret;
+		}
 	} else {
 		dev_err(dev, "%s clock_stop_quirks %x unsupported\n",
 			__func__, clock_stop_quirks);
-- 
2.17.1

