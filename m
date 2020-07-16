Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9A9C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E34E52076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgGQDEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:04:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:62906 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbgGQDEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:04:36 -0400
IronPort-SDR: qIH6smwxCQyAqchAOKSV1ZXVrcYKCo51EBoBXlZ45Lw4Tgc0YBdgel2xNx25CtjaaZAWlsCbje
 HpYXRKTjUlfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="129613879"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="129613879"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:04:34 -0700
IronPort-SDR: cXQhLz1rXdGUBytHWCtRlr4dCnu6zLJYveBPg0/fD/8s3SSk1IcWvk9/KyqzVXpNFMsSn4IVq3
 A5Z4wVrINaXA==
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="460699767"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:04:30 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 8/9] soundwire: intel: add wake interrupt support
Date:   Thu, 16 Jul 2020 23:09:46 +0800
Message-Id: <20200716150947.22119-9-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716150947.22119-1-yung-chuan.liao@linux.intel.com>
References: <20200716150947.22119-1-yung-chuan.liao@linux.intel.com>
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

if a slave has been attached to a bus, the slave->dev_num_sticky
should be non-zero, so we can check this value to skip the
ghost devices defined in ACPI table but not populated in hardware.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c      | 40 +++++++++++++++++++++++++++++++++-
 drivers/soundwire/intel.h      |  1 +
 drivers/soundwire/intel_init.c | 22 +++++++++++++++++++
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 06c553d94890..23b66dcf9966 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <sound/pcm_params.h>
+#include <linux/pm_runtime.h>
 #include <sound/soc.h>
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/soundwire/sdw.h>
@@ -436,7 +437,7 @@ static int intel_shim_init(struct sdw_intel *sdw, bool clock_stop)
 	return ret;
 }
 
-static void __maybe_unused intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
+static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
 {
 	void __iomem *shim = sdw->link_res->shim;
 	unsigned int link_id = sdw->instance;
@@ -1337,6 +1338,43 @@ static int intel_master_remove(struct platform_device *pdev)
 	return 0;
 }
 
+int intel_master_process_wakeen_event(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sdw_intel *sdw;
+	struct sdw_bus *bus;
+	void __iomem *shim;
+	u16 wake_sts;
+
+	sdw = platform_get_drvdata(pdev);
+	bus = &sdw->cdns.bus;
+
+	if (bus->prop.hw_disabled) {
+		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n", bus->link_id);
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
+	/*
+	 * resume the Master, which will generate a bus reset and result in
+	 * Slaves re-attaching and be re-enumerated. The SoundWire physical
+	 * device which generated the wake will trigger an interrupt, which
+	 * will in turn cause the corresponding Linux Slave device to be
+	 * resumed and the Slave codec driver to check the status.
+	 */
+	pm_request_resume(dev);
+
+	return 0;
+}
+
 static struct platform_driver sdw_intel_drv = {
 	.probe = intel_master_probe,
 	.remove = intel_master_remove,
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index bf127c88eb51..4ea3d262d249 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -47,5 +47,6 @@ struct sdw_intel {
 #define SDW_INTEL_QUIRK_MASK_BUS_DISABLE      BIT(1)
 
 int intel_master_startup(struct platform_device *pdev);
+int intel_master_process_wakeen_event(struct platform_device *pdev);
 
 #endif /* __SDW_INTEL_LOCAL_H */
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index a97d3577eb57..8d3992f9fcdd 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -415,5 +415,27 @@ void sdw_intel_exit(struct sdw_intel_ctx *ctx)
 }
 EXPORT_SYMBOL_NS(sdw_intel_exit, SOUNDWIRE_INTEL_INIT);
 
+void sdw_intel_process_wakeen_event(struct sdw_intel_ctx *ctx)
+{
+	struct sdw_intel_link_res *link;
+	u32 link_mask;
+	int i;
+
+	if (!ctx->links)
+		return;
+
+	link = ctx->links;
+	link_mask = ctx->link_mask;
+
+	/* Startup SDW Master devices */
+	for (i = 0; i < ctx->count; i++, link++) {
+		if (!(link_mask & BIT(i)))
+			continue;
+
+		intel_master_process_wakeen_event(link->pdev);
+	}
+}
+EXPORT_SYMBOL_NS(sdw_intel_process_wakeen_event, SOUNDWIRE_INTEL_INIT);
+
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("Intel Soundwire Init Library");
-- 
2.17.1

