Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151A1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8FC520639
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgHRG5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:57:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:31352 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbgHRG5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:57:39 -0400
IronPort-SDR: +OryprafOCF446+iOYwZ+Zj1qbTozyAZvZ0LHB7wdiHuIhwB7wCiiBZOPjmfhinI3ZrbS/z60D
 ZAxl1mzAH9yg==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="142681403"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="142681403"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 23:57:37 -0700
IronPort-SDR: l7r6WZyWleDq9Xz+CR0fP2uA6pyQZ6R6cVAQg4Ipb+/XTj1TZaWqFWdZcp1wNk5nLAsZgcmRTY
 uHFbdBVoj7Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="336530424"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga007.jf.intel.com with ESMTP; 17 Aug 2020 23:57:35 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com
Cc:     andriy.shevchenko@intel.com, thomas.langer@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 2/9] extcon: extcon-ptn5150: Switch to GENMASK() for VBUS detection macro
Date:   Tue, 18 Aug 2020 14:57:20 +0800
Message-Id: <20200818065727.50520-3-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Switch to GENMASK() for VBUS detection macro.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/extcon/extcon-ptn5150.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 5d9a8767646b..c816a6c1e05c 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -42,9 +42,7 @@ enum ptn5150_reg {
 #define PTN5150_REG_CC_PORT_ATTACHMENT_MASK	\
 	(0x7 << PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT)
 
-#define PTN5150_REG_CC_VBUS_DETECTION_SHIFT	7
-#define PTN5150_REG_CC_VBUS_DETECTION_MASK	\
-	(0x1 << PTN5150_REG_CC_VBUS_DETECTION_SHIFT)
+#define PTN5150_REG_CC_VBUS_DETECTION		BIT(7)
 
 #define PTN5150_REG_INT_CABLE_ATTACH_SHIFT	0
 #define PTN5150_REG_INT_CABLE_ATTACH_MASK	\
@@ -130,9 +128,8 @@ static void ptn5150_irq_work(struct work_struct *work)
 			case PTN5150_UFP_ATTACHED:
 				extcon_set_state_sync(info->edev, EXTCON_USB,
 						false);
-				vbus = ((reg_data &
-					PTN5150_REG_CC_VBUS_DETECTION_MASK) >>
-					PTN5150_REG_CC_VBUS_DETECTION_SHIFT);
+				vbus = FIELD_GET(PTN5150_REG_CC_VBUS_DETECTION,
+						 reg_data);
 				if (vbus)
 					gpiod_set_value(info->vbus_gpiod, 0);
 				else
-- 
2.11.0

