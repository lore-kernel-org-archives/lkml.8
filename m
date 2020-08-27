Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C573C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 03:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FA0220786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 03:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgH0D4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 23:56:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:3244 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgH0D4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 23:56:43 -0400
IronPort-SDR: TeXIemAiaoK71E04UPkqaumY2tppZnJZxDUUb/07Ws47qdMcInnvvAitoxoyDWe4HteZKhDsEb
 5mfOCEIp5OSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="220670342"
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="220670342"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 20:56:42 -0700
IronPort-SDR: 9wy9on2TggXwWzZK4AwnW/wBIfDjN5hhGCLztt9suEwrIZC3eh/wa8exYtJvMMNOE+uB1qQbnJ
 dCvOSWEmLWEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="281989467"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga008.fm.intel.com with ESMTP; 26 Aug 2020 20:56:39 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     cw00.choi@samsung.com, linux-kernel@vger.kernel.org
Cc:     vijaikumar.kanagarajan@gmail.com, krzk@kernel.org,
        myungjoo.ham@samsung.com, heikki.krogerus@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v2 1/2] extcon: ptn5150: Switch to GENMASK() and BIT() macros
Date:   Thu, 27 Aug 2020 11:56:32 +0800
Message-Id: <20200827035633.37348-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200827035633.37348-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200827035633.37348-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Switch to GENMASK() and BIT() macros.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/extcon/extcon-ptn5150.c | 43 +++++++++++------------------------------
 1 file changed, 11 insertions(+), 32 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 8ba706fad887..8b930050a3f1 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -7,6 +7,7 @@
 // Author: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
 // Copyright (c) 2020 Krzysztof Kozlowski <krzk@kernel.org>
 
+#include <linux/bitfield.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -35,29 +36,13 @@ enum ptn5150_reg {
 #define PTN5150_UFP_ATTACHED			0x2
 
 /* Define PTN5150 MASK/SHIFT constant */
-#define PTN5150_REG_DEVICE_ID_VENDOR_SHIFT	0
-#define PTN5150_REG_DEVICE_ID_VENDOR_MASK	\
-	(0x3 << PTN5150_REG_DEVICE_ID_VENDOR_SHIFT)
+#define PTN5150_REG_DEVICE_ID_VERSION		GENMASK(7, 3)
+#define PTN5150_REG_DEVICE_ID_VENDOR		GENMASK(2, 0)
 
-#define PTN5150_REG_DEVICE_ID_VERSION_SHIFT	3
-#define PTN5150_REG_DEVICE_ID_VERSION_MASK	\
-	(0x1f << PTN5150_REG_DEVICE_ID_VERSION_SHIFT)
-
-#define PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT	2
-#define PTN5150_REG_CC_PORT_ATTACHMENT_MASK	\
-	(0x7 << PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT)
-
-#define PTN5150_REG_CC_VBUS_DETECTION_SHIFT	7
-#define PTN5150_REG_CC_VBUS_DETECTION_MASK	\
-	(0x1 << PTN5150_REG_CC_VBUS_DETECTION_SHIFT)
-
-#define PTN5150_REG_INT_CABLE_ATTACH_SHIFT	0
-#define PTN5150_REG_INT_CABLE_ATTACH_MASK	\
-	(0x1 << PTN5150_REG_INT_CABLE_ATTACH_SHIFT)
-
-#define PTN5150_REG_INT_CABLE_DETACH_SHIFT	1
-#define PTN5150_REG_INT_CABLE_DETACH_MASK	\
-	(0x1 << PTN5150_REG_CC_CABLE_DETACH_SHIFT)
+#define PTN5150_REG_CC_PORT_ATTACHMENT		GENMASK(4, 2)
+#define PTN5150_REG_CC_VBUS_DETECTION		BIT(7)
+#define PTN5150_REG_INT_CABLE_ATTACH_MASK	BIT(0)
+#define PTN5150_REG_INT_CABLE_DETACH_MASK	BIT(1)
 
 struct ptn5150_info {
 	struct device *dev;
@@ -95,9 +80,7 @@ static void ptn5150_check_state(struct ptn5150_info *info)
 		return;
 	}
 
-	port_status = ((reg_data &
-			PTN5150_REG_CC_PORT_ATTACHMENT_MASK) >>
-			PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT);
+	port_status = FIELD_GET(PTN5150_REG_CC_PORT_ATTACHMENT, reg_data);
 
 	switch (port_status) {
 	case PTN5150_DFP_ATTACHED:
@@ -107,8 +90,7 @@ static void ptn5150_check_state(struct ptn5150_info *info)
 		break;
 	case PTN5150_UFP_ATTACHED:
 		extcon_set_state_sync(info->edev, EXTCON_USB, false);
-		vbus = ((reg_data & PTN5150_REG_CC_VBUS_DETECTION_MASK) >>
-			PTN5150_REG_CC_VBUS_DETECTION_SHIFT);
+		vbus = FIELD_GET(PTN5150_REG_CC_VBUS_DETECTION, reg_data);
 		if (vbus)
 			gpiod_set_value_cansleep(info->vbus_gpiod, 0);
 		else
@@ -191,11 +173,8 @@ static int ptn5150_init_dev_type(struct ptn5150_info *info)
 		return -EINVAL;
 	}
 
-	vendor_id = ((reg_data & PTN5150_REG_DEVICE_ID_VENDOR_MASK) >>
-				PTN5150_REG_DEVICE_ID_VENDOR_SHIFT);
-	version_id = ((reg_data & PTN5150_REG_DEVICE_ID_VERSION_MASK) >>
-				PTN5150_REG_DEVICE_ID_VERSION_SHIFT);
-
+	vendor_id = FIELD_GET(PTN5150_REG_DEVICE_ID_VENDOR, reg_data);
+	version_id = FIELD_GET(PTN5150_REG_DEVICE_ID_VERSION, reg_data);
 	dev_dbg(info->dev, "Device type: version: 0x%x, vendor: 0x%x\n",
 		version_id, vendor_id);
 
-- 
2.11.0

