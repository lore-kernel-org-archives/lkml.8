Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79377C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E06320674
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbgGVIcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:32:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:57014 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730308AbgGVIck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:32:40 -0400
IronPort-SDR: IJT+yJt0PbRV7N3fdK8oHXiCq45xxLtUH1MsnB9QjUZ8d8VodXK0V2L5nDV/4q+iwCIsTyNDlz
 vYQkTx7Le9pg==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="150270008"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="150270008"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:32:39 -0700
IronPort-SDR: dQm6Geg4ReqKMkRWsI4sP47Fd5h8u+6dRehFb7K2FYavAZtTwg25fzhyaxkQhlH3nl3zsmRCSB
 4Y6qD874N6Yw==
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="432303404"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:32:35 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 12/13] soundwire: intel: support clock_stop mode without quirks
Date:   Wed, 22 Jul 2020 04:37:22 +0800
Message-Id: <20200721203723.18305-13-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

In this mode, on restart the bus restarts immediately, the Slaves
remain synchronized and all context is kept intact.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index c9d8de65cfd6..22b3359855c5 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1596,7 +1596,8 @@ static int intel_suspend_runtime(struct device *dev)
 
 		intel_shim_wake(sdw, false);
 
-	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) {
+	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET ||
+		   !clock_stop_quirks) {
 		ret = sdw_cdns_clock_stop(cdns, true);
 		if (ret < 0) {
 			dev_err(dev, "cannot enable clock stop on suspend\n");
@@ -1758,6 +1759,24 @@ static int intel_resume_runtime(struct device *dev)
 			dev_err(dev, "unable to restart clock during resume\n");
 			return ret;
 		}
+	} else if (!clock_stop_quirks) {
+		ret = intel_init(sdw);
+		if (ret) {
+			dev_err(dev, "%s failed: %d", __func__, ret);
+			return ret;
+		}
+
+		ret = sdw_cdns_enable_interrupt(cdns, true);
+		if (ret < 0) {
+			dev_err(dev, "cannot enable interrupts during resume\n");
+			return ret;
+		}
+
+		ret = sdw_cdns_clock_restart(cdns, false);
+		if (ret < 0) {
+			dev_err(dev, "unable to resume master during resume\n");
+			return ret;
+		}
 	} else {
 		dev_err(dev, "%s clock_stop_quirks %x unsupported\n",
 			__func__, clock_stop_quirks);
-- 
2.17.1

