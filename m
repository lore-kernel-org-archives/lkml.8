Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F23C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E85032072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597648296;
	bh=oHFGCA4Xsb3f0Wc/G5uhBYxGg3jXhNGSQwInGaAMvGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nJ6enzJWivErKEMYNTaJ1OOL3IOWIO5hZ8h55OEukmcSjZRTQTcsCq/maCdD8/1al
	 sZDsn9yg2AVby0mm4eBADMi5EEXq3zXxNaj4GulJbgLS66OJY25Sg4ymWNd9u4Rc4R
	 dbmkM/8gRPnVVWzSEXkrCGTH6Sz8eHqOKd1K8y7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgHQHLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgHQHLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:11:17 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F25B20772;
        Mon, 17 Aug 2020 07:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597648276;
        bh=oHFGCA4Xsb3f0Wc/G5uhBYxGg3jXhNGSQwInGaAMvGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u5WVcOoZa9vtgBppwiHPmQEZ3B3J63E9MHZ5adV0GPrqOYml9nM69lXJGgnI4zHaI
         1OruRE8h7HAF0YnOnJXX8kRllzQJ5EpXM5huievvqsX73cpGjUni7Z4j46MHpHhCm8
         lyYTaZ6FtmPCqL2O6hcBBBvEBFo7juWEXzdZtGgg=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZIY-00BdjJ-SB; Mon, 17 Aug 2020 09:11:14 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH v3 03/44] staging: spmi: hisi-spmi-controller: fix it to probe successfully
Date:   Mon, 17 Aug 2020 09:10:22 +0200
Message-Id: <122bd1c02f325094f4830ac79a86430fbe01e3d5.1597647359.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597647359.git.mchehab+huawei@kernel.org>
References: <cover.1597647359.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/staging/hikey9xx/hisi-spmi-controller.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
index 3af0bd1b379f..bc6847f9a5e7 100644
--- a/drivers/staging/hikey9xx/hisi-spmi-controller.c
+++ b/drivers/staging/hikey9xx/hisi-spmi-controller.c
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

