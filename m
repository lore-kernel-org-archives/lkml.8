Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2013C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 01:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33C52072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 01:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgHYB0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 21:26:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:46600 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHYB0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 21:26:21 -0400
IronPort-SDR: 78vRinSwttS3Rlav7qSk0Dgb2vbrzelSE8otmpJwxfbDHfYBlA8OP8+U5cXJW3DFj3tMyFlekO
 sysgRqPLe8eQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="220289544"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="220289544"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 18:26:20 -0700
IronPort-SDR: 0U9UupZ1piSB1NCBH8/LgXnxrutyJ+D+zfVz4+5kZRuuwBZsSNjLNwMRR3NOo0xuRAqEEHxSP3
 zbawr9UyAHIg==
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="443446093"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 18:26:16 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2] soundwire: intel: fix intel_suspend/resume defined but not used warning
Date:   Mon, 24 Aug 2020 21:32:34 +0800
Message-Id: <20200824133234.28115-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PM_SLEEP is not defined, GCC throws compilation warnings:

drivers/soundwire/intel.c:1799:12: warning: ‘intel_resume’ defined but not
used [-Wunused-function]
 static int intel_resume(struct device *dev)
            ^~~~~~~~~~~~
drivers/soundwire/intel.c:1683:12: warning: ‘intel_suspend’ defined but not
used [-Wunused-function]
 static int intel_suspend(struct device *dev)
            ^~~~~~~~~~~~~

Fix by using __maybe_unused macro.

Suggested-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
Changelog:
v2:
 - use __maybe_unused macro instead of wrapping in another ifdef.
---
 drivers/soundwire/intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index dbcbe2708563..ebca8ced59ec 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1527,7 +1527,7 @@ int intel_master_process_wakeen_event(struct platform_device *pdev)
 
 #ifdef CONFIG_PM
 
-static int intel_suspend(struct device *dev)
+static int __maybe_unused intel_suspend(struct device *dev)
 {
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
@@ -1625,7 +1625,7 @@ static int intel_suspend_runtime(struct device *dev)
 	return ret;
 }
 
-static int intel_resume(struct device *dev)
+static int __maybe_unused intel_resume(struct device *dev)
 {
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
-- 
2.17.1

