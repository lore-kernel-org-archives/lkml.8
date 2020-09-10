Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15936C2BB84
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C875820795
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgIJH3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:29:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11338 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726746AbgIJH3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:29:44 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 63B7C9D187AFAC1DC36D;
        Thu, 10 Sep 2020 15:29:38 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 15:29:31 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] soundwire: intel: Fix -Wunused-function warning
Date:   Thu, 10 Sep 2020 15:29:06 +0800
Message-ID: <20200910072906.28284-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20200909131531.31380-1-yuehaibing@huawei.com>
References: <20200909131531.31380-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PM is not set, build warns:

drivers/soundwire/intel.c:488:12: warning: 'intel_link_power_down' defined but not used [-Wunused-function]

Mark the functions __maybe_unused and remove the CONFIG_PM dependency.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/soundwire/intel.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index e047910d73f5..48ae8800594a 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -400,7 +400,7 @@ static void intel_shim_glue_to_master_ip(struct sdw_intel *sdw)
 }
 
 /* this needs to be called with shim_lock */
-static void intel_shim_master_ip_to_glue(struct sdw_intel *sdw)
+static void __maybe_unused intel_shim_master_ip_to_glue(struct sdw_intel *sdw)
 {
 	unsigned int link_id = sdw->instance;
 	void __iomem *shim = sdw->link_res->shim;
@@ -485,7 +485,7 @@ static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
 	mutex_unlock(sdw->link_res->shim_lock);
 }
 
-static int intel_link_power_down(struct sdw_intel *sdw)
+static int __maybe_unused intel_link_power_down(struct sdw_intel *sdw)
 {
 	u32 link_control, spa_mask, cpa_mask;
 	unsigned int link_id = sdw->instance;
@@ -1540,8 +1540,6 @@ int intel_master_process_wakeen_event(struct platform_device *pdev)
  * PM calls
  */
 
-#ifdef CONFIG_PM
-
 static int __maybe_unused intel_suspend(struct device *dev)
 {
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
@@ -1596,7 +1594,7 @@ static int __maybe_unused intel_suspend(struct device *dev)
 	return 0;
 }
 
-static int intel_suspend_runtime(struct device *dev)
+static int __maybe_unused intel_suspend_runtime(struct device *dev)
 {
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
@@ -1751,7 +1749,7 @@ static int __maybe_unused intel_resume(struct device *dev)
 	return ret;
 }
 
-static int intel_resume_runtime(struct device *dev)
+static int __maybe_unused intel_resume_runtime(struct device *dev)
 {
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
@@ -1924,8 +1922,6 @@ static int intel_resume_runtime(struct device *dev)
 	return ret;
 }
 
-#endif
-
 static const struct dev_pm_ops intel_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
 	SET_RUNTIME_PM_OPS(intel_suspend_runtime, intel_resume_runtime, NULL)
-- 
2.17.1


