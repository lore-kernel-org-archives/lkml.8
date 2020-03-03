Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C390DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03EE2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgCCDU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 22:20:27 -0500
Received: from inva021.nxp.com ([92.121.34.21]:45676 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgCCDU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 22:20:26 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E24B3201232;
        Tue,  3 Mar 2020 04:20:24 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6217C201236;
        Tue,  3 Mar 2020 04:20:22 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D4DFF402F3;
        Tue,  3 Mar 2020 11:20:18 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] regulator: anatop: Drop error message for -EPROBE_DEFER
Date:   Tue,  3 Mar 2020 11:14:21 +0800
Message-Id: <1583205261-1994-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_regulator_register() could return -EPROBE_DEFER when trying to
get init data and NOT all resources are available at that time, for
this case, error message should NOT be present, the driver will call
probe again later, so drop error message for -EPROBE_DEFER.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/regulator/anatop-regulator.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 754739d..41470a8 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -305,9 +305,10 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 	/* register regulator */
 	rdev = devm_regulator_register(dev, rdesc, &config);
 	if (IS_ERR(rdev)) {
-		dev_err(dev, "failed to register %s\n",
-			rdesc->name);
-		return PTR_ERR(rdev);
+		ret = PTR_ERR(rdev);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to register %s\n", rdesc->name);
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, rdev);
-- 
2.7.4

