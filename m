Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82C2C2BA18
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 00:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E95A2074B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 00:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="GetNmysi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgDDAAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 20:00:10 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:53768 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgDDAAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 20:00:08 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48vH463jZhzpX;
        Sat,  4 Apr 2020 02:00:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585958406; bh=8/z3OJqgrWtCMOo2sXfQJgsdpXMe6hRzbfTaYY95jtc=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=GetNmysilR8dQtbOKFH+tS3RSXNSdlMcS/ur/FLnDiA/eiI747DNN/du3ZIAw3BD2
         UHLYWtwl8EKYYn3jSsE6YYl1sLXtNFTcRsar67IuTtRFquqHZBSf+9WPdI5rxJ6ut9
         Djcfhf0XIIXqPL3waDIjExVqejAd+yJl0l8cS0DK1S+A6FuF6AvFtQBANkmeep+PS8
         U1RP9aFzTW26GyLvlEvZM0Z7u5BDW4iEFz16SYE5q/3C5j6pX0wqgNNipxNpmu6WFM
         bN5YOOrYmGWf4UjJPdhTQA953/qMeL5jV9lwxanXb5nA2FX7u1QnYWb1AMWUM+wy/n
         YHtdOnYocWVUg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sat, 04 Apr 2020 02:00:06 +0200
Message-Id: <5b7c0cdc715d1dbdfcc5f8b8217da6878bcc6b93.1585958250.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <2b6d70595475a3ddbd5bb8ae1765868a98c404b6.1585958250.git.mirq-linux@rere.qmqm.pl>
References: <2b6d70595475a3ddbd5bb8ae1765868a98c404b6.1585958250.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 4/5] usb: chipidea: usb2: absorb zevio glue driver
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZEVIO glue code is is identical to generic binding now, but doesn't
enable runtime PM. Let's squash the driver and get runtime PM for free.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/usb/chipidea/Makefile        |  1 -
 drivers/usb/chipidea/ci_hdrc_usb2.c  |  6 +++
 drivers/usb/chipidea/ci_hdrc_zevio.c | 67 ----------------------------
 3 files changed, 6 insertions(+), 68 deletions(-)

diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
index 12df94f78f72..985663ba6e68 100644
--- a/drivers/usb/chipidea/Makefile
+++ b/drivers/usb/chipidea/Makefile
@@ -10,7 +10,6 @@ ci_hdrc-$(CONFIG_USB_OTG_FSM)		+= otg_fsm.o
 
 obj-$(CONFIG_USB_CHIPIDEA)	+= ci_hdrc_usb2.o
 obj-$(CONFIG_USB_CHIPIDEA)	+= ci_hdrc_msm.o
-obj-$(CONFIG_USB_CHIPIDEA)	+= ci_hdrc_zevio.o
 
 obj-$(CONFIG_USB_CHIPIDEA_PCI)	+= ci_hdrc_pci.o
 
diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c b/drivers/usb/chipidea/ci_hdrc_usb2.c
index 9086514840ed..93c864759135 100644
--- a/drivers/usb/chipidea/ci_hdrc_usb2.c
+++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
@@ -32,9 +32,15 @@ static const struct ci_hdrc_platform_data ci_zynq_pdata = {
 	.capoffset	= DEF_CAPOFFSET,
 };
 
+static const struct ci_hdrc_platform_data ci_zevio_pdata = {
+	.capoffset	= DEF_CAPOFFSET,
+	.flags		= CI_HDRC_REGS_SHARED | CI_HDRC_FORCE_FULLSPEED,
+};
+
 static const struct of_device_id ci_hdrc_usb2_of_match[] = {
 	{ .compatible = "chipidea,usb2" },
 	{ .compatible = "xlnx,zynq-usb-2.20a", .data = &ci_zynq_pdata },
+	{ .compatible = "lsi,zevio-usb", .data = &ci_zevio_pdata },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ci_hdrc_usb2_of_match);
diff --git a/drivers/usb/chipidea/ci_hdrc_zevio.c b/drivers/usb/chipidea/ci_hdrc_zevio.c
deleted file mode 100644
index e1634da4a4b1..000000000000
--- a/drivers/usb/chipidea/ci_hdrc_zevio.c
+++ /dev/null
@@ -1,67 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *	Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
- *
- * Based off drivers/usb/chipidea/ci_hdrc_msm.c
- */
-
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/usb/gadget.h>
-#include <linux/usb/chipidea.h>
-
-#include "ci.h"
-
-static struct ci_hdrc_platform_data ci_hdrc_zevio_platdata = {
-	.name			= "ci_hdrc_zevio",
-	.flags			= CI_HDRC_REGS_SHARED | CI_HDRC_FORCE_FULLSPEED,
-	.capoffset		= DEF_CAPOFFSET,
-};
-
-static int ci_hdrc_zevio_probe(struct platform_device *pdev)
-{
-	struct platform_device *ci_pdev;
-
-	dev_dbg(&pdev->dev, "ci_hdrc_zevio_probe\n");
-
-	ci_pdev = ci_hdrc_add_device(&pdev->dev,
-				pdev->resource, pdev->num_resources,
-				&ci_hdrc_zevio_platdata);
-
-	if (IS_ERR(ci_pdev)) {
-		dev_err(&pdev->dev, "ci_hdrc_add_device failed!\n");
-		return PTR_ERR(ci_pdev);
-	}
-
-	platform_set_drvdata(pdev, ci_pdev);
-
-	return 0;
-}
-
-static int ci_hdrc_zevio_remove(struct platform_device *pdev)
-{
-	struct platform_device *ci_pdev = platform_get_drvdata(pdev);
-
-	ci_hdrc_remove_device(ci_pdev);
-
-	return 0;
-}
-
-static const struct of_device_id ci_hdrc_zevio_dt_ids[] = {
-	{ .compatible = "lsi,zevio-usb", },
-	{ /* sentinel */ }
-};
-
-static struct platform_driver ci_hdrc_zevio_driver = {
-	.probe = ci_hdrc_zevio_probe,
-	.remove = ci_hdrc_zevio_remove,
-	.driver = {
-		.name = "zevio_usb",
-		.of_match_table = ci_hdrc_zevio_dt_ids,
-	},
-};
-
-MODULE_DEVICE_TABLE(of, ci_hdrc_zevio_dt_ids);
-module_platform_driver(ci_hdrc_zevio_driver);
-
-MODULE_LICENSE("GPL v2");
-- 
2.20.1

