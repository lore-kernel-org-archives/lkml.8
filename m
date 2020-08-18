Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C8EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C51D20639
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHRG6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:58:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:53666 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgHRG5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:57:55 -0400
IronPort-SDR: AUrTLa/shXwqodwW1ZAYRCI54+TLLdyQ4fi8P8IZLxgyD9irj+GPwGET6Q6DxkaoKh/oq7zulk
 2W18WkP8AHXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="155935737"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="155935737"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 23:57:55 -0700
IronPort-SDR: wPWaymybons2R8PQSUQRvl02uzaSftMLHvlR1XmWPlo/UWRuplQxz58ueE7E213WOVp6XXi/Ph
 0mxQCbAQWH7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="441124421"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga004.jf.intel.com with ESMTP; 17 Aug 2020 23:57:52 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com
Cc:     andriy.shevchenko@intel.com, thomas.langer@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 7/9] extcon: extcon-ptn5150: Add USB debug accessory support
Date:   Tue, 18 Aug 2020 14:57:25 +0800
Message-Id: <20200818065727.50520-8-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add USB debug accessory support.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/extcon/extcon-ptn5150.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 5612dc0ef2af..b985a5e5c9bc 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -33,6 +33,7 @@ enum ptn5150_reg {
 
 #define PTN5150_DFP_ATTACHED			0x1
 #define PTN5150_UFP_ATTACHED			0x2
+#define PTN5150_DEBUG_ATTACHED			0x3
 
 /* Define PTN5150 MASK/SHIFT constant */
 #define PTN5150_REG_DEVICE_ID_VERSION		GENMASK(7, 3)
@@ -61,6 +62,7 @@ struct ptn5150_info {
 static const unsigned int ptn5150_extcon_cable[] = {
 	EXTCON_USB,
 	EXTCON_USB_HOST,
+	EXTCON_JIG,
 	EXTCON_NONE,
 };
 
@@ -86,6 +88,7 @@ static void ptn5150_irq_work(struct work_struct *work)
 	union extcon_property_value vbus_detected;
 	union extcon_property_value flipped;
 	bool host_vbus = false;
+	bool debug = false;
 	bool host = false;
 	bool dev = false;
 
@@ -152,6 +155,9 @@ static void ptn5150_irq_work(struct work_struct *work)
 				extcon_set_state_sync(info->edev,
 						EXTCON_USB_HOST, true);
 				break;
+			case PTN5150_DEBUG_ATTACHED:
+				debug = true;
+				break;
 			default:
 				dev_err(info->dev,
 					"Unknown Port status : %x\n",
@@ -182,6 +188,7 @@ static void ptn5150_irq_work(struct work_struct *work)
 	extcon_set_property(info->edev, host ? EXTCON_USB_HOST : EXTCON_USB,
 			    EXTCON_PROP_USB_VBUS, vbus_detected);
 	extcon_set_state_sync(info->edev, EXTCON_USB_HOST, host);
+	extcon_set_state_sync(info->edev, EXTCON_JIG, debug);
 	extcon_set_state_sync(info->edev, EXTCON_USB, dev);
 
 	mutex_unlock(&info->mutex);
-- 
2.11.0

