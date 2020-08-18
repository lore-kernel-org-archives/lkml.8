Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EADCC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CDE620639
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgHRG6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:58:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:12636 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgHRG6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:58:02 -0400
IronPort-SDR: lPWyXNZqYwb/wtvvEv8Gyu1i3ZcG/qImMh/scQLxFdmeMVCQj1hvlsFIEYqygzWJRtaJ67ByoH
 9JrTacfYppJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="134374151"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="134374151"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 23:58:02 -0700
IronPort-SDR: txEqkumSuxTEbe4PvM2yp9gcYwZI6LjbRnDEKs8jmLADLdg38Votu2vS1eO53e9PzqTMRLmLkj
 5DVDCuOmePXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="400414079"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga001.fm.intel.com with ESMTP; 17 Aug 2020 23:57:59 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com
Cc:     andriy.shevchenko@intel.com, thomas.langer@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 9/9] extcon: extcon-ptn5150: Remove unused variable and extra space
Date:   Tue, 18 Aug 2020 14:57:27 +0800
Message-Id: <20200818065727.50520-10-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Remove the unused variable and extra space.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/extcon/extcon-ptn5150.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 140994ac43ed..a7544ab058c0 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -50,7 +50,6 @@ enum ptn5150_reg {
 struct ptn5150_info {
 	struct device *dev;
 	struct extcon_dev *edev;
-	struct i2c_client *i2c;
 	struct regmap *regmap;
 	struct gpio_desc *int_gpiod;
 	struct gpio_desc *vbus_gpiod;
@@ -201,7 +200,6 @@ static void ptn5150_irq_work(struct work_struct *work)
 	mutex_unlock(&info->mutex);
 }
 
-
 static irqreturn_t ptn5150_irq_handler(int irq, void *data)
 {
 	struct ptn5150_info *info = data;
@@ -264,7 +262,6 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c,
 	i2c_set_clientdata(i2c, info);
 
 	info->dev = &i2c->dev;
-	info->i2c = i2c;
 	info->int_gpiod = devm_gpiod_get(&i2c->dev, "int", GPIOD_IN);
 	if (IS_ERR(info->int_gpiod)) {
 		dev_err(dev, "failed to get INT GPIO\n");
-- 
2.11.0

