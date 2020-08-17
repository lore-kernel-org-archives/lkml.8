Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28618C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB8020716
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgHRDXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 23:23:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:63987 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgHRDXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 23:23:47 -0400
IronPort-SDR: sZPM6vjB7w7FDhU+/SJDPTwwsLjSIjyKeqS/9Tl00//rzcLv+MnzChflUoavn6r3ZnrgIsCM7z
 6fE22Av5Snfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154806518"
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; 
   d="scan'208";a="154806518"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 20:23:47 -0700
IronPort-SDR: xDqN1dgdDYDwVq+SeaUu259O1Kh52s9XmxAfAgtveXmBMi9SJcGrjrt3kAgQcxET5VTi57MJ8x
 Q0vGgDM+YHtA==
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; 
   d="scan'208";a="441084662"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 20:23:44 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 09/12] soundwire: intel: add CLK_STOP_NOT_ALLOWED support
Date:   Mon, 17 Aug 2020 23:29:20 +0800
Message-Id: <20200817152923.3259-10-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
References: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

In case the clock needs to keep running, we need to prevent the Master
from entering pm_runtime suspend.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index ad476e9e4d25..95b14c034ea7 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1367,6 +1367,7 @@ int intel_master_startup(struct platform_device *pdev)
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
 	int link_flags;
+	u32 clock_stop_quirks;
 	int ret;
 
 	if (bus->prop.hw_disabled) {
@@ -1423,6 +1424,20 @@ int intel_master_startup(struct platform_device *pdev)
 		pm_runtime_enable(dev);
 	}
 
+	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
+	if (clock_stop_quirks & SDW_INTEL_CLK_STOP_NOT_ALLOWED) {
+		/*
+		 * To keep the clock running we need to prevent
+		 * pm_runtime suspend from happening by increasing the
+		 * reference count.
+		 * This quirk is specified by the parent PCI device in
+		 * case of specific latency requirements. It will have
+		 * no effect if pm_runtime is disabled by the user via
+		 * a module parameter for testing purposes.
+		 */
+		pm_runtime_get_noresume(dev);
+	}
+
 	/*
 	 * The runtime PM status of Slave devices is "Unsupported"
 	 * until they report as ATTACHED. If they don't, e.g. because
@@ -1454,6 +1469,11 @@ static int intel_master_remove(struct platform_device *pdev)
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
 
+	/*
+	 * Since pm_runtime is already disabled, we don't decrease
+	 * the refcount when the clock_stop_quirk is
+	 * SDW_INTEL_CLK_STOP_NOT_ALLOWED
+	 */
 	if (!bus->prop.hw_disabled) {
 		intel_debugfs_exit(sdw);
 		sdw_cdns_enable_interrupt(cdns, false);
-- 
2.17.1

