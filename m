Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29601C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7D22076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgHROfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:35:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:33372 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgHROfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:35:31 -0400
IronPort-SDR: L6A+gRcMh1BXz4ibdctZM5DEg3unySNbp9o0v8sujW/f86gILksPZHN01ZsHZ1bHLxt2bG8fBJ
 b71rawKxFO2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154170484"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="154170484"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 07:35:30 -0700
IronPort-SDR: FFmnMyYXxJ9CjrIDvwTB3+ecLoNwBvQnOICNheJgJ8ev/SrTfF03Jdp8bx+QN8+mMkFmg+W3Yw
 JS22fUDWsESg==
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="471830485"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 07:35:26 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 04/11] soundwire: intel: add missing support for all clock stop modes
Date:   Tue, 18 Aug 2020 10:41:13 +0800
Message-Id: <20200818024120.20721-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
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
index a3aa8ab49285..f4441684bd7e 100644
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

