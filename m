Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198E1C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D537622B45
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597247823;
	bh=oHFGCA4Xsb3f0Wc/G5uhBYxGg3jXhNGSQwInGaAMvGo=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=ORqAyuPH+3hop7F8rpm8uqBlICM6H4Xk/bGeSmAfGbAuRxVovp3puhiQX7gWWWFmz
	 3h3Psp/63oVK1U2y7OxZ63QwPCSkyPtgC09KQE3R57CSxlo40k+TpVA+uqUqVUvg3n
	 kIDkLb8ee7Hi96WfTA9OZdUSoEc5i0FLSVwmzapw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgHLP5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:57:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgHLP5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:00 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5367B20866;
        Wed, 12 Aug 2020 15:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247819;
        bh=oHFGCA4Xsb3f0Wc/G5uhBYxGg3jXhNGSQwInGaAMvGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sgBb3qB0AGgiXkVzwMVzYfEozfRmAcmgKTcSwMaTODIplMAwO3AW4DSTb/zQDgWaS
         iLD7Fihw8oORCWPZGJHCf5j7QHGuCJ/tfHyGSYyRJWveOrTUZbJMzMkIyfqxLMaYLX
         rXHJ4ZyJu4epi7Y6iRHeCH4SnCHAmHv4j/WF0CjI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7Z-005t5e-DE; Wed, 12 Aug 2020 17:56:57 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 03/44] staging: spmi: hisi-spmi-controller: fix it to probe successfully
Date:   Wed, 12 Aug 2020 17:56:13 +0200
Message-Id: <8c4b9401958345ebe76d2bd08d93528229d8af5a.1597247164.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
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

