Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AE8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A03D420855
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597247844;
	bh=UV1YfELGCgFxi/1ixDUOsZOV9Tr6nLf25G8A1Km/oY0=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=pze/HIzpkjO7qfAclLWKFeokcAAAOqwXlAGq58RGvJ9qxf3pNHqK1SpjG4O+X/xh9
	 exxFLupQleA3AYlSukzP8Qy4ZSQ3BSdfGW2UQrcHqQQKaTYSjTO/7oty8OkOyqKbPE
	 MDtruylEOY6YyPOyV6/L9MHq2mHhkjBHs6ADLayE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgHLP5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgHLP5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:02 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C78622CF7;
        Wed, 12 Aug 2020 15:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247820;
        bh=UV1YfELGCgFxi/1ixDUOsZOV9Tr6nLf25G8A1Km/oY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r2y50cKHu9cuIki1TidtxMPEf4QQSXkz+gmZWmOc6/ETR1+UwWyjWZzm+RZN95nc3
         UF5tIemB7/beDpLRjYBXmv3QCNKwd9aIVtOxMN+4XbfyzLMGkSiURwOcZoPVRF92C3
         F7X+2v0evgJbSMZ4T0I2D+lPRLpdLKRmXgzSdbeo=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7a-005t6G-65; Wed, 12 Aug 2020 17:56:58 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 16/44] staging: mfd: hi6421-spmi-pmic: change the binding logic
Date:   Wed, 12 Aug 2020 17:56:26 +0200
Message-Id: <6958bb4c499f96eee971ea2c1846275fc83d0835.1597247164.git.mchehab+huawei@kernel.org>
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

