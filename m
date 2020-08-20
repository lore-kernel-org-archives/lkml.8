Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518CFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 01:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B6E320748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 01:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgHUB63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 21:58:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:35252 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbgHUB63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 21:58:29 -0400
IronPort-SDR: 3OQRVKkLA1EJibHtVwa00hbteHKn8xySTH4d/bozqjob/lOqAxUgQ2MAf3LpNQ2IQ9c0X+7VZJ
 hx4QcL6HmYkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="143070488"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="143070488"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 18:58:29 -0700
IronPort-SDR: 4FFHH7EkeEOP8Eho1sxBO9KAGbft4Lpkgk1r0N4SyuLMHYa9vMMfeW/pVwLzxQ5+beLmnIS/iG
 fvaYi+hvG1fQ==
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="280150774"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 18:58:25 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: intel: fix CONFIG_PM and CONFIG_PM_SLEEP confusion
Date:   Thu, 20 Aug 2020 22:04:41 +0800
Message-Id: <20200820140441.9478-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

When CONFIG_PM_SLEEP is not defined, GCC throws compilation warnings:

drivers/soundwire/intel.c:1816:12: warning: ‘intel_resume’ defined but
not used [-Wunused-function]
 1816 | static int intel_resume(struct device *dev)
      |            ^~~~~~~~~~~~

drivers/soundwire/intel.c:1697:12: warning: ‘intel_suspend’ defined
but not used [-Wunused-function]
 1697 | static int intel_suspend(struct device *dev)

Fix by adding the missing CONFIG_PM_SLEEP.

Note that we could move code around and use only 2 ifdefs, but this
will generate conflicts so let's do this when all the pm handling is
merged.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index dbcbe2708563..a2f0026cb2c1 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1525,7 +1525,7 @@ int intel_master_process_wakeen_event(struct platform_device *pdev)
  * PM calls
  */
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 
 static int intel_suspend(struct device *dev)
 {
@@ -1562,6 +1562,9 @@ static int intel_suspend(struct device *dev)
 
 	return 0;
 }
+#endif
+
+#ifdef CONFIG_PM
 
 static int intel_suspend_runtime(struct device *dev)
 {
@@ -1624,6 +1627,9 @@ static int intel_suspend_runtime(struct device *dev)
 
 	return ret;
 }
+#endif
+
+#ifdef CONFIG_PM_SLEEP
 
 static int intel_resume(struct device *dev)
 {
@@ -1691,6 +1697,9 @@ static int intel_resume(struct device *dev)
 
 	return ret;
 }
+#endif
+
+#ifdef CONFIG_PM
 
 static int intel_resume_runtime(struct device *dev)
 {
@@ -1797,7 +1806,6 @@ static int intel_resume_runtime(struct device *dev)
 
 	return ret;
 }
-
 #endif
 
 static const struct dev_pm_ops intel_pm = {
-- 
2.17.1

