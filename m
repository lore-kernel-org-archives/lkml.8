Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA48C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95BB82078D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHRDXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 23:23:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:63987 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgHRDXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 23:23:36 -0400
IronPort-SDR: yKrvnaLc1gRV16kqHWWRvEv/MwtZLxVJAr2p99KPPaGPTKJUIgH2XJ2pfOJH18K+Qv29skYp4R
 tX28M9BbTrtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154806503"
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; 
   d="scan'208";a="154806503"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 20:23:36 -0700
IronPort-SDR: Wj4fCak+zrkILfBkFtWXpSOQEg6Dys3Yq7izJOvh5/C8Un9Iq6tVG+Akk1LOSq5rfnA+G8OLt4
 J0oXj+aD9j9A==
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; 
   d="scan'208";a="441084609"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 20:23:32 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 06/12] soundwire: intel: pm_runtime idle scheduling
Date:   Mon, 17 Aug 2020 23:29:17 +0800
Message-Id: <20200817152923.3259-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
References: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Add quirk and pm_runtime idle scheduling to let the Master suspend if
no Slaves become attached. This can happen when a link is not marked
as disabled and has devices exposed in the DSDT, if the power is
controlled by sideband means or the link includes a pluggable
connector.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 95a1d88a5bfb..3f9015dcb693 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -31,8 +31,9 @@
  * flags reused in each byte, with master0 using the ls-byte, etc.
  */
 
-#define SDW_INTEL_MASTER_DISABLE_PM_RUNTIME BIT(0)
-#define SDW_INTEL_MASTER_DISABLE_CLOCK_STOP BIT(1)
+#define SDW_INTEL_MASTER_DISABLE_PM_RUNTIME		BIT(0)
+#define SDW_INTEL_MASTER_DISABLE_CLOCK_STOP		BIT(1)
+#define SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE	BIT(2)
 
 static int md_flags;
 module_param_named(sdw_md_flags, md_flags, int, 0444);
@@ -1422,6 +1423,22 @@ int intel_master_startup(struct platform_device *pdev)
 		pm_runtime_enable(dev);
 	}
 
+	/*
+	 * The runtime PM status of Slave devices is "Unsupported"
+	 * until they report as ATTACHED. If they don't, e.g. because
+	 * there are no Slave devices populated or if the power-on is
+	 * delayed or dependent on a power switch, the Master will
+	 * remain active and prevent its parent from suspending.
+	 *
+	 * Conditionally force the pm_runtime core to re-evaluate the
+	 * Master status in the absence of any Slave activity. A quirk
+	 * is provided to e.g. deal with Slaves that may be powered on
+	 * with a delay. A more complete solution would require the
+	 * definition of Master properties.
+	 */
+	if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE))
+		pm_runtime_idle(dev);
+
 	return 0;
 
 err_interrupt:
@@ -1561,6 +1578,7 @@ static int intel_resume(struct device *dev)
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
+	int link_flags;
 	int ret;
 
 	if (bus->prop.hw_disabled) {
@@ -1577,6 +1595,10 @@ static int intel_resume(struct device *dev)
 		pm_runtime_set_active(dev);
 		pm_runtime_mark_last_busy(dev);
 		pm_runtime_enable(dev);
+
+		link_flags = md_flags >> (bus->link_id * 8);
+		if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE))
+			pm_runtime_idle(dev);
 	}
 
 	ret = intel_init(sdw);
-- 
2.17.1

