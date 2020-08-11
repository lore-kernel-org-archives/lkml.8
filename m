Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DEAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB6F206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgHKDJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 23:09:40 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51256 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbgHKDJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 23:09:39 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 253471A1D79;
        Tue, 11 Aug 2020 05:09:38 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6318F1A0801;
        Tue, 11 Aug 2020 05:09:34 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5584F402EB;
        Tue, 11 Aug 2020 05:09:29 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, daniel.baluta@nxp.com, agx@sigxcpu.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] soc: imx: gpcv2: Use dev_err_probe() to simplify error handling
Date:   Tue, 11 Aug 2020 11:04:42 +0800
Message-Id: <1597115082-20328-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() can reduce code size, uniform error handling and record the
defer probe reason etc., use it to simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 6cf8a7a..db7e7fc 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -487,22 +487,17 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 
 	domain->regulator = devm_regulator_get_optional(domain->dev, "power");
 	if (IS_ERR(domain->regulator)) {
-		if (PTR_ERR(domain->regulator) != -ENODEV) {
-			if (PTR_ERR(domain->regulator) != -EPROBE_DEFER)
-				dev_err(domain->dev, "Failed to get domain's regulator\n");
-			return PTR_ERR(domain->regulator);
-		}
+		if (PTR_ERR(domain->regulator) != -ENODEV)
+			return dev_err_probe(domain->dev, PTR_ERR(domain->regulator),
+					     "Failed to get domain's regulator\n");
 	} else if (domain->voltage) {
 		regulator_set_voltage(domain->regulator,
 				      domain->voltage, domain->voltage);
 	}
 
 	ret = imx_pgc_get_clocks(domain);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(domain->dev, "Failed to get domain's clocks\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(domain->dev, ret, "Failed to get domain's clocks\n");
 
 	ret = pm_genpd_init(&domain->genpd, NULL, true);
 	if (ret) {
-- 
2.7.4

