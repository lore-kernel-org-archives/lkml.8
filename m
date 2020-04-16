Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A4BC3815B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF39C221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgDQIuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 04:50:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:7443 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729999AbgDQIuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 04:50:44 -0400
IronPort-SDR: ejg7Cqkvtcg6iQeeOLMNpGKaFaCvEuMXNq1iwvtnCwCb8vL75WYr2G1tl2aCIPHkWj1ayrNNoF
 F5p+G2y6vL9w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 01:50:43 -0700
IronPort-SDR: eHkGFsODeVk6ccqqIrfKNikSmVZWurLcpVNwoIntVeG1AKObP+8382x1fclOfzQkFrK7z910ql
 WKWy9Cmrwqlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,394,1580803200"; 
   d="scan'208";a="454661488"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga005.fm.intel.com with ESMTP; 17 Apr 2020 01:50:39 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com
Subject: [RFC 4/5] soundwire: qcom: add sdw_master_device support
Date:   Fri, 17 Apr 2020 04:55:23 +0800
Message-Id: <20200416205524.2043-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416205524.2043-1-yung-chuan.liao@linux.intel.com>
References: <20200416205524.2043-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Add new device as a child of the platform device, following the
following hierarchy:

platform_device
    sdw_master_device
        sdw_slave0
	...
	sdw_slaveN

For the Qualcomm implementation no sdw_link_ops are provided. All the
dais have to be registered using the platform_device and all power
management is handled at the platform device level.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/qcom.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index e08a17c13f92..96306044aa84 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -89,6 +89,7 @@ struct qcom_swrm_port_config {
 struct qcom_swrm_ctrl {
 	struct sdw_bus bus;
 	struct device *dev;
+	struct sdw_master_device *md;
 	struct regmap *regmap;
 	struct completion *comp;
 	struct work_struct slave_work;
@@ -746,7 +747,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	struct sdw_master_prop *prop;
 	struct sdw_bus_params *params;
 	struct qcom_swrm_ctrl *ctrl;
-	int ret;
+	int ret, err;
 	u32 val;
 
 	ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
@@ -784,14 +785,34 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	mutex_init(&ctrl->port_lock);
 	INIT_WORK(&ctrl->slave_work, qcom_swrm_slave_wq);
 
-	ctrl->bus.dev = dev;
+	/*
+	 * add sdw_master_device.
+	 * For the Qualcomm implementation there is no driver.
+	 */
+	ctrl->md = sdw_master_device_add(dev,	/* platform device is parent */
+					 dev->fwnode,
+					 NULL,	/* no link ops */
+					 0,	/* only one link supported */
+					 NULL);	/* no context */
+	if (IS_ERR(ctrl->md)) {
+		dev_err(dev, "Could not create sdw_master_device\n");
+		ret = PTR_ERR(ctrl->md);
+		goto err_clk;
+	}
+
+	/* add bus handle */
+	ctrl->md->bus = &ctrl->bus;
+
+	/* the bus uses the sdw_master_device, not the platform device */
+	ctrl->bus.dev = &ctrl->md->dev;
+
 	ctrl->bus.ops = &qcom_swrm_ops;
 	ctrl->bus.port_ops = &qcom_swrm_port_ops;
 	ctrl->bus.compute_params = &qcom_swrm_compute_params;
 
 	ret = qcom_swrm_get_port_config(ctrl);
 	if (ret)
-		goto err_clk;
+		goto err_md;
 
 	params = &ctrl->bus.params;
 	params->max_dr_freq = DEFAULT_CLK_FREQ;
@@ -818,14 +839,14 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 					"soundwire", ctrl);
 	if (ret) {
 		dev_err(dev, "Failed to request soundwire irq\n");
-		goto err_clk;
+		goto err_md;
 	}
 
 	ret = sdw_add_bus_master(&ctrl->bus);
 	if (ret) {
 		dev_err(dev, "Failed to register Soundwire controller (%d)\n",
 			ret);
-		goto err_clk;
+		goto err_md;
 	}
 
 	qcom_swrm_init(ctrl);
@@ -841,6 +862,10 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 
 err_master_add:
 	sdw_delete_bus_master(&ctrl->bus);
+err_md:
+	err = sdw_master_device_del(ctrl->md);
+	if (err < 0) /* log but return initial status */
+		dev_err(dev, "master device del failed %d\n", err);
 err_clk:
 	clk_disable_unprepare(ctrl->hclk);
 err_init:
@@ -850,8 +875,12 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 static int qcom_swrm_remove(struct platform_device *pdev)
 {
 	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(&pdev->dev);
+	int err;
 
 	sdw_delete_bus_master(&ctrl->bus);
+	err = sdw_master_device_del(ctrl->md);
+	if (err < 0)
+		dev_err(&pdev->dev, "master device del failed %d\n", err);
 	clk_disable_unprepare(ctrl->hclk);
 
 	return 0;
-- 
2.17.1

