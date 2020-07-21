Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EE8C433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8D7B20717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgGVIcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:32:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:10111 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730437AbgGVIcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:32:15 -0400
IronPort-SDR: rKRQLBQFeFTxSUk51QuSz9vqfD/XSVL9mVRRa+B7PkJMPscRX79HkluLpgj8uvuZJq/zaAkWjp
 3EhLkUVSpXOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="147788027"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="147788027"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:32:14 -0700
IronPort-SDR: QA57h3mnVppmbd4bgc7OfLsVN/ls42sbgs2ej0A6A4giBPsvIee8oLVuj9LYjTid+YanN15kpM
 bCOvOf9QyaUg==
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="432303325"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:32:10 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 07/13] soundwire: intel: pm_runtime idle scheduling
Date:   Wed, 22 Jul 2020 04:37:17 +0800
Message-Id: <20200721203723.18305-8-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
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
index 52a411669ec0..4a60456f060d 100644
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
@@ -1421,6 +1422,22 @@ int intel_master_startup(struct platform_device *pdev)
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
@@ -1562,6 +1579,7 @@ static int intel_resume(struct device *dev)
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
+	int link_flags;
 	int ret;
 
 	if (bus->prop.hw_disabled) {
@@ -1580,6 +1598,10 @@ static int intel_resume(struct device *dev)
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

