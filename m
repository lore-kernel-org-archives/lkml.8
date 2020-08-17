Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742C8C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56DDA20716
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgHRDYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 23:24:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:63987 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgHRDXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 23:23:52 -0400
IronPort-SDR: ckU5/KZiHB7qOhz/pyl3iynWDV0ti0P1B4g7CF4LSfHut0wxh5MlPzQmP1Mq/YXa5uAFsGSjhF
 F3cJrskIjt/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154806520"
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; 
   d="scan'208";a="154806520"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 20:23:51 -0700
IronPort-SDR: 5gxK5uMJyT/dbvPZzsV4y+rb2f3JUG+5YMjCd/4HahUH3FK9W4h9+UMJW46WXLe+LNNgeAKz1u
 ugjvwA1BdUnw==
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; 
   d="scan'208";a="441084675"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 20:23:47 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 10/12] soundwire: intel_init: handle power rail dependencies for clock stop mode
Date:   Mon, 17 Aug 2020 23:29:21 +0800
Message-Id: <20200817152923.3259-11-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
References: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
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
 drivers/soundwire/intel_init.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index dd1050743dca..add46d8fc85c 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -73,6 +73,9 @@ static int sdw_intel_cleanup(struct sdw_intel_ctx *ctx)
 			pm_runtime_disable(&link->pdev->dev);
 			platform_device_unregister(link->pdev);
 		}
+
+		if (!link->clock_stop_quirks)
+			pm_runtime_put_noidle(link->dev);
 	}
 
 	return 0;
@@ -338,6 +341,16 @@ sdw_intel_startup_controller(struct sdw_intel_ctx *ctx)
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

