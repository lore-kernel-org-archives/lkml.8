Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7A7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D8962074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgFAGPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:15:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:41317 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgFAGPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:15:50 -0400
IronPort-SDR: eSTd3nXx+R/CO6rq2CqoFj6400jsbRCbA1eNT/xGf6kclpI79jVsDOUFgcnls66vwTrtJPZGfH
 i8ZvX92jlM5Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 23:15:50 -0700
IronPort-SDR: kY4MRX8sMRIu5aP+evIIJ94CSZpmrlDv+NscNT89L+z99aRxJ/ymUHbQZaIgZUUBdFB0bgmrg+
 98Bp+0wfa0gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="470208655"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2020 23:15:45 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 2/6] soundwire: intel: clarify drvdata and remove more indirections
Date:   Mon,  1 Jun 2020 02:20:58 +0800
Message-Id: <20200531182102.27840-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200531182102.27840-1-yung-chuan.liao@linux.intel.com>
References: <20200531182102.27840-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The use of drvdata mixes two structures. There was no harm the first
structure is embedded as the first element of the second, but that's
not good. Make sure all drvdata is based on the 'sdw_cdns' structure.

While we are at it, remove indirections for 'dev' and 'cdns' to make
the code more readable.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 10e55c708694..ef1196ea93a4 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1077,6 +1077,7 @@ static int intel_master_probe(struct platform_device *pdev)
 	struct sdw_cdns_stream_config config;
 	struct device *dev = &pdev->dev;
 	struct sdw_intel *sdw;
+	struct sdw_cdns *cdns;
 	struct sdw_bus *bus;
 	int ret;
 
@@ -1084,24 +1085,26 @@ static int intel_master_probe(struct platform_device *pdev)
 	if (!sdw)
 		return -ENOMEM;
 
-	bus = &sdw->cdns.bus;
+	cdns = &sdw->cdns;
+	bus = &cdns->bus;
 
 	sdw->instance = pdev->id;
 	sdw->link_res = dev_get_platdata(dev);
-	sdw->cdns.dev = dev;
-	sdw->cdns.registers = sdw->link_res->registers;
-	sdw->cdns.instance = sdw->instance;
-	sdw->cdns.msg_count = 0;
+	cdns->dev = dev;
+	cdns->registers = sdw->link_res->registers;
+	cdns->instance = sdw->instance;
+	cdns->msg_count = 0;
+
 	bus->link_id = pdev->id;
 
-	sdw_cdns_probe(&sdw->cdns);
+	sdw_cdns_probe(cdns);
 
 	/* Set property read ops */
 	sdw_intel_ops.read_prop = intel_prop_read;
 	bus->ops = &sdw_intel_ops;
 
 	/* set driver data, accessed by snd_soc_dai_get_drvdata() */
-	platform_set_drvdata(pdev, sdw);
+	dev_set_drvdata(dev, cdns);
 
 	ret = sdw_bus_master_add(bus, dev, dev->fwnode);
 	if (ret) {
@@ -1123,7 +1126,7 @@ static int intel_master_probe(struct platform_device *pdev)
 
 	/* Read the PDI config and initialize cadence PDI */
 	intel_pdi_init(sdw, &config);
-	ret = sdw_cdns_pdi_init(&sdw->cdns, config);
+	ret = sdw_cdns_pdi_init(cdns, config);
 	if (ret)
 		goto err_init;
 
@@ -1132,20 +1135,20 @@ static int intel_master_probe(struct platform_device *pdev)
 	/* Acquire IRQ */
 	ret = request_threaded_irq(sdw->link_res->irq,
 				   sdw_cdns_irq, sdw_cdns_thread,
-				   IRQF_SHARED, KBUILD_MODNAME, &sdw->cdns);
+				   IRQF_SHARED, KBUILD_MODNAME, cdns);
 	if (ret < 0) {
 		dev_err(dev, "unable to grab IRQ %d, disabling device\n",
 			sdw->link_res->irq);
 		goto err_init;
 	}
 
-	ret = sdw_cdns_enable_interrupt(&sdw->cdns, true);
+	ret = sdw_cdns_enable_interrupt(cdns, true);
 	if (ret < 0) {
 		dev_err(dev, "cannot enable interrupts\n");
 		goto err_init;
 	}
 
-	ret = sdw_cdns_exit_reset(&sdw->cdns);
+	ret = sdw_cdns_exit_reset(cdns);
 	if (ret < 0) {
 		dev_err(dev, "unable to exit bus reset sequence\n");
 		goto err_interrupt;
@@ -1164,7 +1167,7 @@ static int intel_master_probe(struct platform_device *pdev)
 	return 0;
 
 err_interrupt:
-	sdw_cdns_enable_interrupt(&sdw->cdns, false);
+	sdw_cdns_enable_interrupt(cdns, false);
 	free_irq(sdw->link_res->irq, sdw);
 err_init:
 	sdw_bus_master_delete(bus);
@@ -1174,16 +1177,13 @@ static int intel_master_probe(struct platform_device *pdev)
 static int intel_master_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct sdw_intel *sdw;
-	struct sdw_bus *bus;
-
-	sdw = platform_get_drvdata(pdev);
-
-	bus = &sdw->cdns.bus;
+	struct sdw_cdns *cdns = dev_get_drvdata(dev);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_bus *bus = &cdns->bus;
 
 	if (!bus->prop.hw_disabled) {
 		intel_debugfs_exit(sdw);
-		sdw_cdns_enable_interrupt(&sdw->cdns, false);
+		sdw_cdns_enable_interrupt(cdns, false);
 		free_irq(sdw->link_res->irq, sdw);
 		snd_soc_unregister_component(dev);
 	}
-- 
2.17.1

