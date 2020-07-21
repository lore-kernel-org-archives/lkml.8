Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E3DC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A2720717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgGVIb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:31:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:10111 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGVIb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:31:57 -0400
IronPort-SDR: 99uJMbv3uVccWCyDSJy1ylUzNnzsRj3pD+0gYg8ZrT4jiRuSV6mlTwhX4gjZkl2ZvRZDqB/nbg
 mF2uKYmnjq3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="147787975"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="147787975"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:31:56 -0700
IronPort-SDR: HoBiGMxTkR5w+gTTtrGoS3WHuBfWF2u1drAjYZTap4PlqTDfO18L2+smUFiowMVSvIOkTVMrYF
 N71IfqX/jkBA==
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="432303204"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:31:52 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 03/13] soundwire: intel: reset pm_runtime status during system resume
Date:   Wed, 22 Jul 2020 04:37:13 +0800
Message-Id: <20200721203723.18305-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
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
 drivers/soundwire/intel.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index ed7163ae5f7a..284e5c9d240a 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1433,6 +1433,14 @@ static int intel_suspend(struct device *dev)
 		return 0;
 	}
 
+	if (pm_runtime_suspended(dev)) {
+		dev_dbg(dev,
+			"%s: pm_runtime status: suspended\n",
+			__func__);
+
+		return 0;
+	}
+
 	ret = sdw_cdns_enable_interrupt(cdns, false);
 	if (ret < 0) {
 		dev_err(dev, "cannot disable interrupts on suspend\n");
@@ -1493,6 +1501,18 @@ static int intel_resume(struct device *dev)
 		return 0;
 	}
 
+	if (pm_runtime_suspended(dev)) {
+		dev_dbg(dev,
+			"%s: pm_runtime status was suspended, forcing active\n",
+			__func__);
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

