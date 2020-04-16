Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52CFC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF58C221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgDQIun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 04:50:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:7443 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729999AbgDQIuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 04:50:40 -0400
IronPort-SDR: UwKyoFmV/gntPZEbwPWnqXq8yLGQuYI7z6X7/P6g9QSk7upLGXs6jzV4hGJtqC8VzuqPtnJvBM
 hNkNQT43VxEw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 01:50:40 -0700
IronPort-SDR: VDaYhI04bXnxrIgdRX3TvFSDnT3Mfg5N7oy8zUI/vOJTe+h5K225x3dn/AAvSM6lWlBai1cDYp
 sn8ifT+KwXig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,394,1580803200"; 
   d="scan'208";a="454661472"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga005.fm.intel.com with ESMTP; 17 Apr 2020 01:50:35 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com
Subject: [RFC 3/5] soundwire: qcom: fix error handling in probe
Date:   Fri, 17 Apr 2020 04:55:22 +0800
Message-Id: <20200416205524.2043-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416205524.2043-1-yung-chuan.liao@linux.intel.com>
References: <20200416205524.2043-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Make sure all error cases are properly handled and all resources freed.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/qcom.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index d6c9ad231873..e08a17c13f92 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -765,12 +765,16 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	}
 
 	ctrl->irq = of_irq_get(dev->of_node, 0);
-	if (ctrl->irq < 0)
-		return ctrl->irq;
+	if (ctrl->irq < 0) {
+		ret = ctrl->irq;
+		goto err_init;
+	}
 
 	ctrl->hclk = devm_clk_get(dev, "iface");
-	if (IS_ERR(ctrl->hclk))
-		return PTR_ERR(ctrl->hclk);
+	if (IS_ERR(ctrl->hclk)) {
+		ret = PTR_ERR(ctrl->hclk);
+		goto err_init;
+	}
 
 	clk_prepare_enable(ctrl->hclk);
 
@@ -787,7 +791,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 
 	ret = qcom_swrm_get_port_config(ctrl);
 	if (ret)
-		return ret;
+		goto err_clk;
 
 	params = &ctrl->bus.params;
 	params->max_dr_freq = DEFAULT_CLK_FREQ;
@@ -814,28 +818,32 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 					"soundwire", ctrl);
 	if (ret) {
 		dev_err(dev, "Failed to request soundwire irq\n");
-		goto err;
+		goto err_clk;
 	}
 
 	ret = sdw_add_bus_master(&ctrl->bus);
 	if (ret) {
 		dev_err(dev, "Failed to register Soundwire controller (%d)\n",
 			ret);
-		goto err;
+		goto err_clk;
 	}
 
 	qcom_swrm_init(ctrl);
 	ret = qcom_swrm_register_dais(ctrl);
 	if (ret)
-		goto err;
+		goto err_master_add;
 
 	dev_info(dev, "Qualcomm Soundwire controller v%x.%x.%x Registered\n",
 		 (ctrl->version >> 24) & 0xff, (ctrl->version >> 16) & 0xff,
 		 ctrl->version & 0xffff);
 
 	return 0;
-err:
+
+err_master_add:
+	sdw_delete_bus_master(&ctrl->bus);
+err_clk:
 	clk_disable_unprepare(ctrl->hclk);
+err_init:
 	return ret;
 }
 
-- 
2.17.1

