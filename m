Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F37C3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1864E246A5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbgB0Wck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:32:40 -0500
Received: from mga05.intel.com ([192.55.52.43]:48657 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730524AbgB0Wch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:32:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 14:32:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="411194879"
Received: from azeira-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.147.250])
  by orsmga005.jf.intel.com with ESMTP; 27 Feb 2020 14:32:34 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Rander Wang <rander.wang@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 7/8] soundwire: intel: add wake interrupt support
Date:   Thu, 27 Feb 2020 16:32:05 -0600
Message-Id: <20200227223206.5020-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
References: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@intel.com>

When system is suspended in clock stop mode on intel platforms, both
master and slave are in clock stop mode and soundwire bus is taken
over by a glue hardware. The bus message for jack event is processed
by this glue hardware, which will trigger an interrupt to resume audio
pci device. Then audio pci driver will resume soundwire master and slave,
transfer bus ownership to master, finally slave will report jack event
to master and codec driver is triggered to check jack status.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c      | 45 ++++++++++++++++++++++++++++++++++
 drivers/soundwire/intel_init.c | 12 +++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index eafa2016c76d..4cc6c857dd09 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1255,6 +1255,50 @@ static int intel_master_remove(struct sdw_master_device *md)
 	return 0;
 }
 
+static int intel_master_process_wakeen_event(struct sdw_master_device *md)
+{
+	struct sdw_intel *sdw;
+	struct sdw_slave *slave;
+	struct sdw_bus *bus;
+	void __iomem *shim;
+	u16 wake_sts;
+
+	sdw = md->pdata;
+
+	if (sdw->cdns.bus.prop.hw_disabled) {
+		dev_info(&md->dev,
+			 "SoundWire master %d is disabled, ignoring\n",
+			 sdw->cdns.bus.link_id);
+		return 0;
+	}
+
+	shim = sdw->link_res->shim;
+	wake_sts = intel_readw(shim, SDW_SHIM_WAKESTS);
+
+	if (!(wake_sts & BIT(sdw->instance)))
+		return 0;
+
+	/* disable WAKEEN interrupt ASAP to prevent interrupt flood */
+	intel_shim_wake(sdw, false);
+
+	bus = &sdw->cdns.bus;
+
+	/*
+	 * wake up master and slave so that slave can notify master
+	 * the wakeen event and let codec driver check codec status
+	 */
+	list_for_each_entry(slave, &bus->slaves, node) {
+		if (slave->prop.wake_capable) {
+			if (slave->status != SDW_SLAVE_ATTACHED &&
+			    slave->status != SDW_SLAVE_ALERT)
+				continue;
+
+			pm_request_resume(&slave->dev);
+		}
+	}
+
+	return 0;
+}
 
 static struct sdw_master_driver intel_sdw_driver = {
 	.driver = {
@@ -1265,6 +1309,7 @@ static struct sdw_master_driver intel_sdw_driver = {
 	.probe = intel_master_probe,
 	.startup = intel_master_startup,
 	.remove = intel_master_remove,
+	.process_wake_event = intel_master_process_wakeen_event,
 };
 module_sdw_master_driver(intel_sdw_driver);
 
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 954b21b4712d..91ec91127f2a 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -413,5 +413,17 @@ void sdw_intel_exit(struct sdw_intel_ctx *ctx)
 }
 EXPORT_SYMBOL_NS(sdw_intel_exit, SOUNDWIRE_INTEL_INIT);
 
+void sdw_intel_process_wakeen_event(struct sdw_intel_ctx *ctx)
+{
+	struct sdw_intel_link_res *link;
+
+	if (!ctx->links)
+		return;
+
+	list_for_each_entry(link, &ctx->link_list, list)
+		sdw_master_device_process_wake_event(link->md);
+}
+EXPORT_SYMBOL_NS(sdw_intel_process_wakeen_event, SOUNDWIRE_INTEL_INIT);
+
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("Intel Soundwire Init Library");
-- 
2.20.1

