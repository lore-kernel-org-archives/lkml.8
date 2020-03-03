Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A05C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6483520857
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgCCNuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:50:19 -0500
Received: from inva021.nxp.com ([92.121.34.21]:42612 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728350AbgCCNuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:50:18 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 50CA7200EF4;
        Tue,  3 Mar 2020 14:50:17 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BFBC2200A5C;
        Tue,  3 Mar 2020 14:50:14 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4CA8F402A7;
        Tue,  3 Mar 2020 21:50:11 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] regulator: anatop: Lower error message level for -EPROBE_DEFER
Date:   Tue,  3 Mar 2020 21:44:12 +0800
Message-Id: <1583243052-1930-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_regulator_register() could return -EPROBE_DEFER when trying to
get init data and NOT all resources are available at that time, for
this case, error message is better to be present for debug level ONLY.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- lower the defer error message to debug level instead of dropping it.
---
 drivers/regulator/anatop-regulator.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 754739d..ca92b3d 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -305,9 +305,13 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 	/* register regulator */
 	rdev = devm_regulator_register(dev, rdesc, &config);
 	if (IS_ERR(rdev)) {
-		dev_err(dev, "failed to register %s\n",
-			rdesc->name);
-		return PTR_ERR(rdev);
+		ret = PTR_ERR(rdev);
+		if (ret == -EPROBE_DEFER)
+			dev_dbg(dev, "failed to register %s, deferring...\n",
+				rdesc->name);
+		else
+			dev_err(dev, "failed to register %s\n", rdesc->name);
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, rdev);
-- 
2.7.4

