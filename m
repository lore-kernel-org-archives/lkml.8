Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFA5C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1202084E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731294AbgBYRBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:01:21 -0500
Received: from mga18.intel.com ([134.134.136.126]:25248 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730953AbgBYRBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:01:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 09:01:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,484,1574150400"; 
   d="scan'208";a="317139738"
Received: from sorin-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.45.43])
  by orsmga001.jf.intel.com with ESMTP; 25 Feb 2020 09:01:01 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 3/3] soundwire: add helper macros for devID fields
Date:   Tue, 25 Feb 2020 11:00:41 -0600
Message-Id: <20200225170041.23644-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225170041.23644-1-pierre-louis.bossart@linux.intel.com>
References: <20200225170041.23644-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move bit extractors to macros, so that the definitions can be used by
other drivers parsing the MIPI definitions extracted from firmware
tables (ACPI or DT).

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c       | 21 +++++----------------
 include/linux/soundwire/sdw.h | 23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index b8a7a84aca1c..01be7220d117 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -589,22 +589,11 @@ void sdw_extract_slave_id(struct sdw_bus *bus,
 {
 	dev_dbg(bus->dev, "SDW Slave Addr: %llx\n", addr);
 
-	/*
-	 * Spec definition
-	 *   Register		Bit	Contents
-	 *   DevId_0 [7:4]	47:44	sdw_version
-	 *   DevId_0 [3:0]	43:40	unique_id
-	 *   DevId_1		39:32	mfg_id [15:8]
-	 *   DevId_2		31:24	mfg_id [7:0]
-	 *   DevId_3		23:16	part_id [15:8]
-	 *   DevId_4		15:08	part_id [7:0]
-	 *   DevId_5		07:00	class_id
-	 */
-	id->sdw_version = (addr >> 44) & GENMASK(3, 0);
-	id->unique_id = (addr >> 40) & GENMASK(3, 0);
-	id->mfg_id = (addr >> 24) & GENMASK(15, 0);
-	id->part_id = (addr >> 8) & GENMASK(15, 0);
-	id->class_id = addr & GENMASK(7, 0);
+	id->sdw_version = SDW_VERSION(addr);
+	id->unique_id = SDW_UNIQUE_ID(addr);
+	id->mfg_id = SDW_MFG_ID(addr);
+	id->part_id = SDW_PART_ID(addr);
+	id->class_id = SDW_CLASS_ID(addr);
 
 	dev_dbg(bus->dev,
 		"SDW Slave class_id %x, part_id %x, mfg_id %x, unique_id %x, version %x\n",
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index b8427df034ce..ee349a4c5349 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -439,6 +439,29 @@ struct sdw_slave_id {
 	__u8 sdw_version:4;
 };
 
+/*
+ * Helper macros to extract the MIPI-defined IDs
+ *
+ * Spec definition
+ *   Register		Bit	Contents
+ *   DevId_0 [7:4]	47:44	sdw_version
+ *   DevId_0 [3:0]	43:40	unique_id
+ *   DevId_1		39:32	mfg_id [15:8]
+ *   DevId_2		31:24	mfg_id [7:0]
+ *   DevId_3		23:16	part_id [15:8]
+ *   DevId_4		15:08	part_id [7:0]
+ *   DevId_5		07:00	class_id
+ *
+ * The MIPI DisCo for SoundWire defines in addition the link_id as bits 51:48
+ */
+
+#define SDW_DISCO_LINK_ID(adr)	(((adr) >> 48) & GENMASK(3, 0))
+#define SDW_VERSION(adr)	(((adr) >> 44) & GENMASK(3, 0))
+#define SDW_UNIQUE_ID(adr)	(((adr) >> 40) & GENMASK(3, 0))
+#define SDW_MFG_ID(adr)		(((adr) >> 24) & GENMASK(15, 0))
+#define SDW_PART_ID(adr)	(((adr) >> 8) & GENMASK(15, 0))
+#define SDW_CLASS_ID(adr)	((adr) & GENMASK(7, 0))
+
 /**
  * struct sdw_slave_intr_status - Slave interrupt status
  * @control_port: control port status
-- 
2.20.1

