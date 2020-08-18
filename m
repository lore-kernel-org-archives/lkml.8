Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF11C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A81620639
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHRG5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:57:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:30062 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbgHRG5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:57:36 -0400
IronPort-SDR: FNTO+9WF1f1lGG65HpgTaVW6ZDBCPrEbzeESN0tVbMeOo8n9RGEeroBT1jAJ7XNSF1kAVvFgAp
 AEFqAdSGDB0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="216376928"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="216376928"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 23:57:34 -0700
IronPort-SDR: I60qMgu/w5EprarjySDjWhL/JtxvNsaH4JsuyyewZpJgS9cuFUkhRkP9SkJSlQzSDRkFURSRhQ
 DRuvYGomiIsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="326644462"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2020 23:57:32 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com
Cc:     andriy.shevchenko@intel.com, thomas.langer@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 1/9] extcon: extcon-ptn5150: Switch to GENMASK() for vendor and device ID's
Date:   Tue, 18 Aug 2020 14:57:19 +0800
Message-Id: <20200818065727.50520-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Switch to GENMASK() for vendor_id and device_id macros.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/extcon/extcon-ptn5150.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index d1c997599390..5d9a8767646b 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -6,6 +6,7 @@
 // Copyright (c) 2018-2019 by Vijai Kumar K
 // Author: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
 
+#include <linux/bitfield.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -34,13 +35,8 @@ enum ptn5150_reg {
 #define PTN5150_UFP_ATTACHED			0x2
 
 /* Define PTN5150 MASK/SHIFT constant */
-#define PTN5150_REG_DEVICE_ID_VENDOR_SHIFT	0
-#define PTN5150_REG_DEVICE_ID_VENDOR_MASK	\
-	(0x3 << PTN5150_REG_DEVICE_ID_VENDOR_SHIFT)
-
-#define PTN5150_REG_DEVICE_ID_VERSION_SHIFT	3
-#define PTN5150_REG_DEVICE_ID_VERSION_MASK	\
-	(0x1f << PTN5150_REG_DEVICE_ID_VERSION_SHIFT)
+#define PTN5150_REG_DEVICE_ID_VERSION		GENMASK(7, 3)
+#define PTN5150_REG_DEVICE_ID_VENDOR		GENMASK(2, 0)
 
 #define PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT	2
 #define PTN5150_REG_CC_PORT_ATTACHMENT_MASK	\
@@ -194,10 +190,8 @@ static int ptn5150_init_dev_type(struct ptn5150_info *info)
 		return -EINVAL;
 	}
 
-	vendor_id = ((reg_data & PTN5150_REG_DEVICE_ID_VENDOR_MASK) >>
-				PTN5150_REG_DEVICE_ID_VENDOR_SHIFT);
-	version_id = ((reg_data & PTN5150_REG_DEVICE_ID_VERSION_MASK) >>
-				PTN5150_REG_DEVICE_ID_VERSION_SHIFT);
+	vendor_id = FIELD_GET(PTN5150_REG_DEVICE_ID_VENDOR, reg_data);
+	version_id = FIELD_GET(PTN5150_REG_DEVICE_ID_VERSION, reg_data);
 
 	dev_info(info->dev, "Device type: version: 0x%x, vendor: 0x%x\n",
 			    version_id, vendor_id);
-- 
2.11.0

