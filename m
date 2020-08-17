Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3A3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38262072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597648468;
	bh=UV1YfELGCgFxi/1ixDUOsZOV9Tr6nLf25G8A1Km/oY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UaI3wifBy6jL93vR2ACGRrY1bsp0/JDwTy1VhTEHowW4Dq1v4p2htjWl26zcl4QIB
	 XuLikpbhq/wy+YRjwzZ5DU9YdF+3XLOkp0hFzOmiROx77GA82bGQ91GNhrF3abM81B
	 qHuytm9p53Fd8nKOU0ryWtnyxKJkN3hhSqY06ECw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgHQHOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgHQHLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:11:23 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5362722BEF;
        Mon, 17 Aug 2020 07:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597648277;
        bh=UV1YfELGCgFxi/1ixDUOsZOV9Tr6nLf25G8A1Km/oY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O1KWfI1c8GkZQpqFjAzdZO1rN/JDmPQa/egdpmBv7yr52SQzQHm6ufMrxsKve0seC
         INKYlk3g7gVmGoXlcDQQqWZw80oDtUgoWrnXQKMB93AbtC3QLaN7sydECQ+RNVkn9g
         0DLiXYQL20PoLz8RbHHoiJ8fa4/WNHFlCXH2fqhk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZIZ-00Bdjw-Gk; Mon, 17 Aug 2020 09:11:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH v3 16/44] staging: mfd: hi6421-spmi-pmic: change the binding logic
Date:   Mon, 17 Aug 2020 09:10:35 +0200
Message-Id: <eb50392ce68bb30f64c603572cdb9c91f93ea47b.1597647359.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597647359.git.mchehab+huawei@kernel.org>
References: <cover.1597647359.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the binding logic to ensure that the MFD driver
will be load after having the SPMI controller registered.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 84 +++++++--------------
 1 file changed, 29 insertions(+), 55 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index be42fed16bd2..939f7bd5d8ba 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -24,13 +24,14 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/mfd/core.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/of_irq.h>
-#include <linux/mfd/hisi_pmic.h>
+#include <linux/mfd/hi6421-spmi-pmic.h>
 #include <linux/irq.h>
 #include <linux/spmi.h>
 #ifndef NO_IRQ
@@ -53,11 +54,8 @@
 /*define the first group interrupt register number*/
 #define HISI_PMIC_FIRST_GROUP_INT_NUM        2
 
-static const struct of_device_id of_hisi_pmic_match_tbl[] = {
-	{
-		.compatible = "hisilicon-hisi-pmic-spmi",
-	},
-	{ /* end */ }
+static const struct mfd_cell hi6421v600_devs[] = {
+	{ .name = "hi6421v600-regulator", },
 };
 
 /*
@@ -477,6 +475,22 @@ static int hisi_pmic_probe(struct spmi_device *pdev)
 		goto request_theaded_irq;
 	}
 
+	dev_set_drvdata(&pdev->dev, pmic);
+
+	/*
+	 * The logic below will rely that the pmic is already stored at
+	 * drvdata.
+	 */
+	dev_dbg(&pdev->dev, "SPMI-PMIC: adding childs for %pOF\n",
+		pdev->dev.of_node);
+	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
+				   hi6421v600_devs, ARRAY_SIZE(hi6421v600_devs),
+				   NULL, 0, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to add child devices: %d\n", ret);
+		return ret;
+	}
+
 after_irq_register:
 	return 0;
 
@@ -497,61 +511,21 @@ static void hisi_pmic_remove(struct spmi_device *pdev)
 	devm_kfree(&pdev->dev, pmic);
 }
 
-static int hisi_pmic_suspend(struct device *dev, pm_message_t state)
-{
-	struct hisi_pmic *pmic = dev_get_drvdata(dev);
+static const struct of_device_id pmic_spmi_id_table[] = {
+	{ .compatible = "hisilicon,hi6421-spmi-pmic" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pmic_spmi_id_table);
 
-	if (!pmic) {
-		pr_err("%s:pmic is NULL\n", __func__);
-		return -ENOMEM;
-	}
-
-	pr_info("%s:+\n", __func__);
-	pr_info("%s:-\n", __func__);
-
-	return 0;
-}
-
-static int hisi_pmic_resume(struct device *dev)
-{
-	struct hisi_pmic *pmic = dev_get_drvdata(dev);
-
-	if (!pmic) {
-		pr_err("%s:pmic is NULL\n", __func__);
-		return -ENOMEM;
-	}
-
-	pr_info("%s:+\n", __func__);
-	pr_info("%s:-\n", __func__);
-
-	return 0;
-}
-
-MODULE_DEVICE_TABLE(spmi, pmic_spmi_id);
 static struct spmi_driver hisi_pmic_driver = {
 	.driver = {
-		.name	= "hisi_pmic",
-		.owner  = THIS_MODULE,
-		.of_match_table = of_hisi_pmic_match_tbl,
-		.suspend = hisi_pmic_suspend,
-		.resume = hisi_pmic_resume,
+		.name	= "hi6421-spmi-pmic",
+		.of_match_table = pmic_spmi_id_table,
 	},
 	.probe	= hisi_pmic_probe,
 	.remove	= hisi_pmic_remove,
 };
+module_spmi_driver(hisi_pmic_driver);
 
-static int __init hisi_pmic_init(void)
-{
-	return spmi_driver_register(&hisi_pmic_driver);
-}
-
-static void __exit hisi_pmic_exit(void)
-{
-	spmi_driver_unregister(&hisi_pmic_driver);
-}
-
-subsys_initcall_sync(hisi_pmic_init);
-module_exit(hisi_pmic_exit);
-
-MODULE_DESCRIPTION("PMIC driver");
+MODULE_DESCRIPTION("HiSilicon Hi6421v600 SPMI PMIC driver");
 MODULE_LICENSE("GPL v2");
-- 
2.26.2

