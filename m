Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E502C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D6422083B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597160648;
	bh=LzLvznpcNnmXKzaflJxxBBaNzDaD/j3UH7gWllnn0ZU=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=ExQNQ0DFXRT6Jym6W74b6DLLnpx6qiD1+BdYQHrpXRpHBeMtvGlKUWCUji1UcXyOm
	 /Bycty2inSaNPONvafN2pNmFHAcZSGECnbMhM/k2zlBCtx8l81OeuXdwyHCZSJrcC0
	 L6uR1UOaSHbiRgqFsC65m6aNoTN+Nf1AQx1dY0Q4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgHKPoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728915AbgHKPmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:42:05 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FA4E208E4;
        Tue, 11 Aug 2020 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160523;
        bh=LzLvznpcNnmXKzaflJxxBBaNzDaD/j3UH7gWllnn0ZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DKui9/+XGuQwiSMt7hhA2UApFZaLi40li6eRcVVck4P858dsHTK9EgBvA4R9Icab4
         9ptLZaNgCr26XXmlOgWY4E83G1w1ui8fIVPt/k33VU1hsOBXC/WtpANpCbgOWL1wFJ
         SwTfxG6Pgyg1yMPzNAuxTqeoDNCYPzlfBw7STims=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5WPZ-004bmZ-Hq; Tue, 11 Aug 2020 17:42:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Mayulong <mayulong1@huawei.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/33] spmi: hisi-spmi-controller: fix it to probe successfully
Date:   Tue, 11 Aug 2020 17:41:34 +0200
Message-Id: <cdeb53cd491bed970d353bed51a38dff1f52f5e4.1597160086.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597160086.git.mchehab+huawei@kernel.org>
References: <cover.1597160086.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a MODULE_DEVICE_TABLE() to the driver.

Also, the current logic calls platform_set_drvdata(pdev, NULL)
if the driver succeeds loading.

While here, remove the .owner, as it is not needed upstream
anymore.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/spmi/hisi-spmi-controller.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
index 3af0bd1b379f..bc6847f9a5e7 100644
--- a/drivers/spmi/hisi-spmi-controller.c
+++ b/drivers/spmi/hisi-spmi-controller.c
@@ -324,11 +324,14 @@ static int spmi_controller_probe(struct platform_device *pdev)
 	ctrl->write_cmd = spmi_write_cmd;
 
 	ret = spmi_controller_add(ctrl);
-	if (ret) {
-		dev_err(&pdev->dev, "spmi_add_controller failed!\n");
+	if (ret)
 		goto err_add_controller;
-	}
+
+	dev_info(&pdev->dev, "spmi_add_controller initialized\n");
+	return 0;
+
 err_add_controller:
+	dev_err(&pdev->dev, "spmi_add_controller failed!\n");
 	platform_set_drvdata(pdev, NULL);
 	return ret;
 }
@@ -347,13 +350,13 @@ static const struct of_device_id spmi_controller_match_table[] = {
 	},
 	{}
 };
+MODULE_DEVICE_TABLE(of, spmi_controller_match_table);
 
 static struct platform_driver spmi_controller_driver = {
 	.probe		= spmi_controller_probe,
 	.remove		= spmi_del_controller,
 	.driver		= {
 		.name	= SPMI_CONTROLLER_NAME,
-		.owner	= THIS_MODULE,
 		.of_match_table = spmi_controller_match_table,
 	},
 };
-- 
2.26.2

