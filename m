Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF60C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 02:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C242067C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 02:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgHSCBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 22:01:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:3680 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbgHSCA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 22:00:59 -0400
IronPort-SDR: AC3yq/GTHX8E/LocwUOf9Ck6lyf/qHO5SLeWBorg+UGqFJNKOYNQ4vOQpsPniECSMrN+10GSkV
 DAEzsmtHIs8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="152449427"
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="152449427"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 19:00:47 -0700
IronPort-SDR: x2O/GVqfEWePq23aiyfoyPiq58KyjBA+oG2RKlogubZ00FcIQ8MfUQLHfepMtzXRI/ORDYWMZ4
 sQYu7S97ShzQ==
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="279565049"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 19:00:43 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 1/7] soundwire: bus: use property to set interrupt masks
Date:   Tue, 18 Aug 2020 22:06:50 +0800
Message-Id: <20200818140656.29014-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
References: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Add a slave-level property and program the SCP_INT1_MASK as desired by
the codec driver. Since there is no DisCo property this has to be an
implementation-specific firmware property or hard-coded in the driver.

The only functionality change is that implementation-defined
interrupts are no longer set for amplifiers - those interrupts are
typically for jack detection or acoustic event detection/hotwording.

Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c         | 12 ++++++------
 include/linux/soundwire/sdw.h   |  2 ++
 sound/soc/codecs/max98373-sdw.c |  3 +++
 sound/soc/codecs/rt1308-sdw.c   |  2 ++
 sound/soc/codecs/rt5682-sdw.c   |  4 ++++
 sound/soc/codecs/rt700-sdw.c    |  4 ++++
 sound/soc/codecs/rt711-sdw.c    |  4 ++++
 sound/soc/codecs/rt715-sdw.c    |  4 ++++
 sound/soc/codecs/wsa881x.c      |  1 +
 9 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index e6e0fb9a81b4..3b6a87bc254e 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1184,13 +1184,13 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
 		return ret;
 
 	/*
-	 * Set bus clash, parity and SCP implementation
-	 * defined interrupt mask
-	 * TODO: Read implementation defined interrupt mask
-	 * from Slave property
+	 * Set SCP_INT1_MASK register, typically bus clash and
+	 * implementation-defined interrupt mask. The Parity detection
+	 * may not always be correct on startup so its use is
+	 * device-dependent, it might e.g. only be enabled in
+	 * steady-state after a couple of frames.
 	 */
-	val = SDW_SCP_INT1_IMPL_DEF | SDW_SCP_INT1_BUS_CLASH |
-					SDW_SCP_INT1_PARITY;
+	val = slave->prop.scp_int1_mask;
 
 	/* Enable SCP interrupts */
 	ret = sdw_update(slave, SDW_SCP_INTMASK1, val, val);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 76052f12c9f7..6d91f2ca20b2 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -355,6 +355,7 @@ struct sdw_dpn_prop {
  * @dp0_prop: Data Port 0 properties
  * @src_dpn_prop: Source Data Port N properties
  * @sink_dpn_prop: Sink Data Port N properties
+ * @scp_int1_mask: SCP_INT1_MASK desired settings
  */
 struct sdw_slave_prop {
 	u32 mipi_revision;
@@ -376,6 +377,7 @@ struct sdw_slave_prop {
 	struct sdw_dp0_prop *dp0_prop;
 	struct sdw_dpn_prop *src_dpn_prop;
 	struct sdw_dpn_prop *sink_dpn_prop;
+	u8 scp_int1_mask;
 };
 
 /**
diff --git a/sound/soc/codecs/max98373-sdw.c b/sound/soc/codecs/max98373-sdw.c
index 5fe724728e84..17fd1989e873 100644
--- a/sound/soc/codecs/max98373-sdw.c
+++ b/sound/soc/codecs/max98373-sdw.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_type.h>
+#include <linux/soundwire/sdw_registers.h>
 #include "max98373.h"
 #include "max98373-sdw.h"
 
@@ -287,6 +288,8 @@ static int max98373_read_prop(struct sdw_slave *slave)
 	unsigned long addr;
 	struct sdw_dpn_prop *dpn;
 
+	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
+
 	/* BITMAP: 00001000  Dataport 3 is active */
 	prop->source_ports = BIT(3);
 	/* BITMAP: 00000010  Dataport 1 is active */
diff --git a/sound/soc/codecs/rt1308-sdw.c b/sound/soc/codecs/rt1308-sdw.c
index b0ba0d2acbdd..5cf10fd447eb 100644
--- a/sound/soc/codecs/rt1308-sdw.c
+++ b/sound/soc/codecs/rt1308-sdw.c
@@ -123,6 +123,8 @@ static int rt1308_read_prop(struct sdw_slave *slave)
 	unsigned long addr;
 	struct sdw_dpn_prop *dpn;
 
+	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
+
 	prop->paging_support = true;
 
 	/* first we need to allocate memory for set bits in port lists */
diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
index 94bf6bee78e6..544073975020 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -19,6 +19,7 @@
 #include <linux/mutex.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_type.h>
+#include <linux/soundwire/sdw_registers.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -542,6 +543,9 @@ static int rt5682_read_prop(struct sdw_slave *slave)
 	unsigned long addr;
 	struct sdw_dpn_prop *dpn;
 
+	prop->scp_int1_mask = SDW_SCP_INT1_IMPL_DEF | SDW_SCP_INT1_BUS_CLASH |
+		SDW_SCP_INT1_PARITY;
+
 	prop->paging_support = false;
 
 	/* first we need to allocate memory for set bits in port lists */
diff --git a/sound/soc/codecs/rt700-sdw.c b/sound/soc/codecs/rt700-sdw.c
index 4d14048d1197..a46b957a3f1b 100644
--- a/sound/soc/codecs/rt700-sdw.c
+++ b/sound/soc/codecs/rt700-sdw.c
@@ -11,6 +11,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_type.h>
+#include <linux/soundwire/sdw_registers.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <sound/soc.h>
@@ -338,6 +339,9 @@ static int rt700_read_prop(struct sdw_slave *slave)
 	unsigned long addr;
 	struct sdw_dpn_prop *dpn;
 
+	prop->scp_int1_mask = SDW_SCP_INT1_IMPL_DEF | SDW_SCP_INT1_BUS_CLASH |
+		SDW_SCP_INT1_PARITY;
+
 	prop->paging_support = false;
 
 	/* first we need to allocate memory for set bits in port lists */
diff --git a/sound/soc/codecs/rt711-sdw.c b/sound/soc/codecs/rt711-sdw.c
index 45b928954b58..a877e366fec5 100644
--- a/sound/soc/codecs/rt711-sdw.c
+++ b/sound/soc/codecs/rt711-sdw.c
@@ -11,6 +11,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_type.h>
+#include <linux/soundwire/sdw_registers.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <sound/soc.h>
@@ -342,6 +343,9 @@ static int rt711_read_prop(struct sdw_slave *slave)
 	unsigned long addr;
 	struct sdw_dpn_prop *dpn;
 
+	prop->scp_int1_mask = SDW_SCP_INT1_IMPL_DEF | SDW_SCP_INT1_BUS_CLASH |
+		SDW_SCP_INT1_PARITY;
+
 	prop->paging_support = false;
 
 	/* first we need to allocate memory for set bits in port lists */
diff --git a/sound/soc/codecs/rt715-sdw.c b/sound/soc/codecs/rt715-sdw.c
index d11b23d6b240..0eb8943ed6ff 100644
--- a/sound/soc/codecs/rt715-sdw.c
+++ b/sound/soc/codecs/rt715-sdw.c
@@ -12,6 +12,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_type.h>
+#include <linux/soundwire/sdw_registers.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
@@ -436,6 +437,9 @@ static int rt715_read_prop(struct sdw_slave *slave)
 	unsigned long addr;
 	struct sdw_dpn_prop *dpn;
 
+	prop->scp_int1_mask = SDW_SCP_INT1_IMPL_DEF | SDW_SCP_INT1_BUS_CLASH |
+		SDW_SCP_INT1_PARITY;
+
 	prop->paging_support = false;
 
 	/* first we need to allocate memory for set bits in port lists */
diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index d39d479e2378..68e774e69c85 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -1112,6 +1112,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 	wsa881x->sconfig.type = SDW_STREAM_PDM;
 	pdev->prop.sink_ports = GENMASK(WSA881X_MAX_SWR_PORTS, 0);
 	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
+	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
 	gpiod_direction_output(wsa881x->sd_n, 1);
 
 	wsa881x->regmap = devm_regmap_init_sdw(pdev, &wsa881x_regmap_config);
-- 
2.17.1

