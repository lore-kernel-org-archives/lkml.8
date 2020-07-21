Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47A6C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8BBB20674
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgGVIcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:32:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:57014 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730275AbgGVIcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:32:35 -0400
IronPort-SDR: f/5B0U8j/ImQ7sERAJ8fWibWm1KMfcrw1kygpy2WZmm5SXDtf3/PZ36ASkNS8Dwe2Vue+xbsCd
 7+RqB8p8wJEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="150270001"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="150270001"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:32:35 -0700
IronPort-SDR: krbOO7+lmqF4g73YcVA+e5DPl07IsuE8oF2t9yOYd/7uBom9AsZPCv9xgnQV6hY3cfq6Hca39+
 S+QsAHSk//Og==
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="432303389"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:32:28 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 11/13] soundwire: intel_init: handle power rail dependencies for clock stop mode
Date:   Wed, 22 Jul 2020 04:37:21 +0800
Message-Id: <20200721203723.18305-12-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

When none of the clock stop quirks is specified, the Master IP will
assume the context is preserved and will not reset the Bus and restart
enumeration. Due to power rail dependencies, the HDaudio controller
needs to remain powered and prevented from executing its pm_runtime
suspend routine.

This choice of course has a power impact, and this mode should only be
selected when latency requirements are critical or the parent device
can enter D0ix modes.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 96c9af15c308..c0fddf76a6dc 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/soundwire/sdw_intel.h>
+#include <linux/pm_runtime.h>
 #include "cadence_master.h"
 #include "intel.h"
 
@@ -72,6 +73,9 @@ static int sdw_intel_cleanup(struct sdw_intel_ctx *ctx)
 			pm_runtime_disable(&link->pdev->dev);
 			platform_device_unregister(link->pdev);
 		}
+
+		if (!link->clock_stop_quirks)
+			pm_runtime_put_noidle(link->dev);
 	}
 
 	return 0;
@@ -337,6 +341,16 @@ sdw_intel_startup_controller(struct sdw_intel_ctx *ctx)
 			continue;
 
 		intel_master_startup(link->pdev);
+
+		if (!link->clock_stop_quirks) {
+			/*
+			 * we need to prevent the parent PCI device
+			 * from entering pm_runtime suspend, so that
+			 * power rails to the SoundWire IP are not
+			 * turned off.
+			 */
+			pm_runtime_get_noresume(link->dev);
+		}
 	}
 
 	return 0;
-- 
2.17.1

