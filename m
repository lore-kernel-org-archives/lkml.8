Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B758CC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92BEB20674
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbgGVIc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:32:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:27817 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGVIc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:32:28 -0400
IronPort-SDR: 5NEhCfrUBEeEBU48hj8mZzTRMJqOSDmM+6O6IrEvZCO6nx7UehFdjYldCHaXVfu9+Vsci7ohha
 oBgwPFatIbiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="129858886"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="129858886"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:32:28 -0700
IronPort-SDR: 4wHHBy9kGnY4WyTp3shCMCD3Qwi4bvpX/+G4zz6Bh8/nZk1zuuTNPpmopChBzJYWfN/WB2n8XK
 WtrRETT+aE5w==
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="432303375"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:32:24 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 10/13] soundwire: intel: add CLK_STOP_NOT_ALLOWED support
Date:   Wed, 22 Jul 2020 04:37:20 +0800
Message-Id: <20200721203723.18305-11-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

In case the clock needs to keep running, we need to prevent the Master
from entering pm_runtime suspend.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 744fc0a4816a..c9d8de65cfd6 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1366,6 +1366,7 @@ int intel_master_startup(struct platform_device *pdev)
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
 	int link_flags;
+	u32 clock_stop_quirks;
 	int ret;
 
 	if (bus->prop.hw_disabled) {
@@ -1422,6 +1423,20 @@ int intel_master_startup(struct platform_device *pdev)
 		pm_runtime_enable(dev);
 	}
 
+	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
+	if (clock_stop_quirks & SDW_INTEL_CLK_STOP_NOT_ALLOWED) {
+		/*
+		 * To keep the clock running we need to prevent
+		 * pm_runtime suspend from happening by increasing the
+		 * reference count.
+		 * This quirk is specified by the parent PCI device in
+		 * case of specific latency requirements. It will have
+		 * no effect if pm_runtime is disabled by the user via
+		 * a module parameter for testing purposes.
+		 */
+		pm_runtime_get_noresume(dev);
+	}
+
 	/*
 	 * The runtime PM status of Slave devices is "Unsupported"
 	 * until they report as ATTACHED. If they don't, e.g. because
@@ -1453,6 +1468,11 @@ static int intel_master_remove(struct platform_device *pdev)
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
 
+	/*
+	 * Since pm_runtime is already disabled, we don't decrease
+	 * the refcount when the clock_stop_quirk is
+	 * SDW_INTEL_CLK_STOP_NOT_ALLOWED
+	 */
 	if (!bus->prop.hw_disabled) {
 		intel_debugfs_exit(sdw);
 		sdw_cdns_enable_interrupt(cdns, false);
-- 
2.17.1

