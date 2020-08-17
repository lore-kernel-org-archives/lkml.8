Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2BDC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB1B20716
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgHRDXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 23:23:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:63974 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgHRDXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 23:23:22 -0400
IronPort-SDR: S+594uYtQfRwTnCrrcXzE2psoZDfrJGbQBcZSohodTb7bFR7XIMb33G4rKiaLuN/guD9xXCl7N
 5uQDcpbo4zMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154806470"
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; 
   d="scan'208";a="154806470"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 20:23:21 -0700
IronPort-SDR: QFetKkvHaQvpm7iSf9CEQnJI06T6FgQrV57YPu6g+hy6JJ0WTHh9VGGnsQtqcGtrrLb2MWJN/Z
 Cc5US3OUp/xw==
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; 
   d="scan'208";a="441084543"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 20:23:17 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 02/12] soundwire: intel: reset pm_runtime status during system resume
Date:   Mon, 17 Aug 2020 23:29:13 +0800
Message-Id: <20200817152923.3259-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
References: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The system resume does the entire bus re-initialization and brings it
to full-power. If the device was pm_runtime suspended, there is no
need to run the pm_runtime resume sequence after the system runtime.

Follow the documentation from runtime_pm.rst, and conditionally
disable, set_active and re-enable the device on system resume.

Note that pm_runtime_suspended() is used instead of
pm_runtime_status_suspended() so that we can deal with the case where
pm_runtime is disabled.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 85a0bb6af4fe..0e21bae3cd19 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1434,6 +1434,12 @@ static int intel_suspend(struct device *dev)
 		return 0;
 	}
 
+	if (pm_runtime_suspended(dev)) {
+		dev_dbg(dev, "%s: pm_runtime status: suspended\n", __func__);
+
+		return 0;
+	}
+
 	ret = sdw_cdns_enable_interrupt(cdns, false);
 	if (ret < 0) {
 		dev_err(dev, "cannot disable interrupts on suspend\n");
@@ -1494,6 +1500,16 @@ static int intel_resume(struct device *dev)
 		return 0;
 	}
 
+	if (pm_runtime_suspended(dev)) {
+		dev_dbg(dev, "%s: pm_runtime status was suspended, forcing active\n", __func__);
+
+		/* follow required sequence from runtime_pm.rst */
+		pm_runtime_disable(dev);
+		pm_runtime_set_active(dev);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_enable(dev);
+	}
+
 	ret = intel_init(sdw);
 	if (ret) {
 		dev_err(dev, "%s failed: %d", __func__, ret);
-- 
2.17.1

