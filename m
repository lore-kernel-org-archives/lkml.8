Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512DBC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F2220866
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgIBDAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 23:00:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:23992 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbgIBC75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 22:59:57 -0400
IronPort-SDR: NnyiG3trXiP31o3J2sASV1t+JAQbGtR1UREyi0sxahrqQ98PSFiVr1X90qJPOA4rXsaSF11Hvi
 f5+iv94oStqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="218860091"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="218860091"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 19:59:56 -0700
IronPort-SDR: XirWR19BgRgDyggOkar4n1daIoDsUOv7aFYdJG5Jzxq+WnAx3xsbO4v9VhEf/o9GiLpTXo2/c2
 e7uVauAjV/VA==
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="283588086"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 19:59:52 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 04/10] soundwire: intel: add missing support for all clock stop modes
Date:   Tue,  1 Sep 2020 23:05:50 +0800
Message-Id: <20200901150556.19432-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901150556.19432-1-yung-chuan.liao@linux.intel.com>
References: <20200901150556.19432-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Deal with the BUS_RESET case, which is the default. The only change is
to add support for the exit sequence using the syncArm/syncGo mode for
the exit reset sequence.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 49 +++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 259e3da98e42..8634d33c388c 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1868,11 +1868,6 @@ static int intel_resume_runtime(struct device *dev)
 
 		if (!clock_stop0) {
 
-			/*
-			 * Re-initialize the IP since it was powered-off
-			 */
-			sdw_cdns_init(&sdw->cdns);
-
 			/*
 			 * make sure all Slaves are tagged as UNATTACHED and
 			 * provide reason for reinitialization
@@ -1880,13 +1875,31 @@ static int intel_resume_runtime(struct device *dev)
 
 			status = SDW_UNATTACH_REQUEST_MASTER_RESET;
 			sdw_clear_slave_status(bus, status);
-		}
 
+			ret = sdw_cdns_enable_interrupt(cdns, true);
+			if (ret < 0) {
+				dev_err(dev, "cannot enable interrupts during resume\n");
+				return ret;
+			}
 
-		ret = sdw_cdns_enable_interrupt(cdns, true);
-		if (ret < 0) {
-			dev_err(dev, "cannot enable interrupts during resume\n");
-			return ret;
+			/*
+			 * follow recommended programming flows to avoid
+			 * timeouts when gsync is enabled
+			 */
+			if (multi_link)
+				intel_shim_sync_arm(sdw);
+
+			/*
+			 * Re-initialize the IP since it was powered-off
+			 */
+			sdw_cdns_init(&sdw->cdns);
+
+		} else {
+			ret = sdw_cdns_enable_interrupt(cdns, true);
+			if (ret < 0) {
+				dev_err(dev, "cannot enable interrupts during resume\n");
+				return ret;
+			}
 		}
 
 		ret = sdw_cdns_clock_restart(cdns, !clock_stop0);
@@ -1894,6 +1907,22 @@ static int intel_resume_runtime(struct device *dev)
 			dev_err(dev, "unable to restart clock during resume\n");
 			return ret;
 		}
+
+		if (!clock_stop0) {
+			ret = sdw_cdns_exit_reset(cdns);
+			if (ret < 0) {
+				dev_err(dev, "unable to exit bus reset sequence during resume\n");
+				return ret;
+			}
+
+			if (multi_link) {
+				ret = intel_shim_sync_go(sdw);
+				if (ret < 0) {
+					dev_err(sdw->cdns.dev, "sync go failed during resume\n");
+					return ret;
+				}
+			}
+		}
 	} else if (!clock_stop_quirks) {
 		ret = intel_init(sdw);
 		if (ret) {
-- 
2.17.1

