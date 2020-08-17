Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FB8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B1920716
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgHRDXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 23:23:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:63987 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgHRDX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 23:23:29 -0400
IronPort-SDR: mjHNUd56EF24PH2V4L9jacoQ1flO0ZoP9bgHKJG13H+8MIeRCYOJZk5enjHgcY/9FmSaZPNYIK
 ST93X50WwIkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154806481"
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; 
   d="scan'208";a="154806481"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 20:23:28 -0700
IronPort-SDR: 7lviDtFcctncIe1LaCVudtXIv5Kt5cIeFEAq1qjEQyLA8i1YSIzVe/QfMJwRL5lkjInXmdRCT6
 lxAnRRXSgJgQ==
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; 
   d="scan'208";a="441084575"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 20:23:25 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 04/12] soundwire: intel: call helper to reset Slave states on resume
Date:   Mon, 17 Aug 2020 23:29:15 +0800
Message-Id: <20200817152923.3259-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
References: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

This helps make sure they are all UNATTACHED and reset the state
machines.

At the moment we perform a bus reset both for system resume and
pm_runtime resume, this will be modified when clock-stop mode is
supported

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 00c5de1250ec..10dd0e208ce7 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1516,6 +1516,12 @@ static int intel_resume(struct device *dev)
 		return ret;
 	}
 
+	/*
+	 * make sure all Slaves are tagged as UNATTACHED and provide
+	 * reason for reinitialization
+	 */
+	sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
+
 	ret = sdw_cdns_enable_interrupt(cdns, true);
 	if (ret < 0) {
 		dev_err(dev, "cannot enable interrupts during resume\n");
@@ -1562,6 +1568,12 @@ static int intel_resume_runtime(struct device *dev)
 		return ret;
 	}
 
+	/*
+	 * make sure all Slaves are tagged as UNATTACHED and provide
+	 * reason for reinitialization
+	 */
+	sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
+
 	ret = sdw_cdns_enable_interrupt(cdns, true);
 	if (ret < 0) {
 		dev_err(dev, "cannot enable interrupts during resume\n");
-- 
2.17.1

