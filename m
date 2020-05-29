Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F4FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42D0E2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fMixoOPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgE2I1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgE2I10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:27:26 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140B7C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:27:26 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b6so1584795ljj.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ly/hqC+OpwfmKTz5BxiBCk11qr5IjD5u5LkJ+5oge9k=;
        b=fMixoOPZX9wwxzXYWIK3T9u257kMOLufFfxlZ6VG7Xi5Aiw6k1i08rE/cCqEgFBuYs
         kDYZRtQyZj16hXmhfq2TJpjZP2Jahqy6RXjl4dtwq5ApR7QRfo7oYCZwGCLDw1L/EUc2
         O1dNAXdCUbIc9XeHW8Kk+m9AQEiIm5ObrL1v/ynzHLwl0jbLMzfwa3xuxIRbbswuIkG9
         8zh/mt8BIRGga9pC8An7dICBAdY47HsPYLyQsZLIh72GOSXU7RoHhm9K+F1szaj4gvFu
         SG0V5dUZ3CsFiRpppHPk3mWZqFbe1USvDIdcQdYsdeneJMtN9Dkr7+IUD8r+gADBNYKZ
         s3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ly/hqC+OpwfmKTz5BxiBCk11qr5IjD5u5LkJ+5oge9k=;
        b=lrC+wM84CO+dcoaFyuhuwSwikqjI7IrVNOxJ3iGXssCEVADqpIAuD6MBqD4gGyCYQ9
         g3vr2qbJdGM2pDJHlDV5fDiP5HQPTC7vHDMiXkgbT87jPSFvo97OyrAgH8D9rMSUaZec
         8M9fnucyavuyGxjKsN2H1oh3ZDbOQ2NetxBqYWvXDh7XnDTwOeAbpp2j6qGB51B0aHBX
         SNHQDP2+ub7U6q3d+at66p6DycdPU208ZPMzA6vyrR2oBauB+I79yW6+ylShipvPdWNI
         9bi1IocP2x48ArDB6cOebVt/ms9MjsS6/AIzHl4OvonqlcPanYbhF9aS1f12SGXffZBv
         sPZQ==
X-Gm-Message-State: AOAM532hkt5eE423NIk5YXur8sphJYlnmEJS6H5nl1mgTsn9cUoUYCGS
        IzH/0fpcgldem03+6uWHKZWXvlYNBKA=
X-Google-Smtp-Source: ABdhPJz/Iw8lBOjnYoGclA3SoKAUkYMHpXffSMuQbyC0cSy5cch0eUUf3a6JK59YZDC+1JKnlZoX/A==
X-Received: by 2002:a2e:998c:: with SMTP id w12mr3622599lji.143.1590740844214;
        Fri, 29 May 2020 01:27:24 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id y20sm1878450lji.31.2020.05.29.01.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 01:27:23 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv5 3/3] tpm_ftpm_tee: register driver on TEE bus
Date:   Fri, 29 May 2020 11:27:01 +0300
Message-Id: <20200529082701.13457-4-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529082701.13457-1-maxim.uvarov@linaro.org>
References: <20200529082701.13457-1-maxim.uvarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register driver on the TEE bus. The module tee registers bus,
and module optee calls optee_enumerate_devices() to scan
all devices on the bus. Trusted Application for this driver
can be Early TA's (can be compiled into optee-os). In that
case it will be on OPTEE bus before linux booting. Also
optee-suplicant application is needed to be loaded between
OPTEE module and ftpm module to maintain functionality
for fTPM driver.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Suggested-by: Sumit Garg <sumit.garg@linaro.org>
Suggested-by: Arnd Bergmann <arnd@linaro.org>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 70 ++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 22bf553ccf9d..28da638360d8 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -214,11 +214,10 @@ static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
  * Return:
  *	On success, 0. On failure, -errno.
  */
-static int ftpm_tee_probe(struct platform_device *pdev)
+static int ftpm_tee_probe(struct device *dev)
 {
 	int rc;
 	struct tpm_chip *chip;
-	struct device *dev = &pdev->dev;
 	struct ftpm_tee_private *pvt_data = NULL;
 	struct tee_ioctl_open_session_arg sess_arg;
 
@@ -297,6 +296,13 @@ static int ftpm_tee_probe(struct platform_device *pdev)
 	return rc;
 }
 
+static int ftpm_plat_tee_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	return ftpm_tee_probe(dev);
+}
+
 /**
  * ftpm_tee_remove() - remove the TPM device
  * @pdev: the platform_device description.
@@ -304,9 +310,9 @@ static int ftpm_tee_probe(struct platform_device *pdev)
  * Return:
  *	0 always.
  */
-static int ftpm_tee_remove(struct platform_device *pdev)
+static int ftpm_tee_remove(struct device *dev)
 {
-	struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
+	struct ftpm_tee_private *pvt_data = dev_get_drvdata(dev);
 
 	/* Release the chip */
 	tpm_chip_unregister(pvt_data->chip);
@@ -328,11 +334,18 @@ static int ftpm_tee_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int ftpm_plat_tee_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	return ftpm_tee_remove(dev);
+}
+
 /**
  * ftpm_tee_shutdown() - shutdown the TPM device
  * @pdev: the platform_device description.
  */
-static void ftpm_tee_shutdown(struct platform_device *pdev)
+static void ftpm_plat_tee_shutdown(struct platform_device *pdev)
 {
 	struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
 
@@ -347,17 +360,54 @@ static const struct of_device_id of_ftpm_tee_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, of_ftpm_tee_ids);
 
-static struct platform_driver ftpm_tee_driver = {
+static struct platform_driver ftpm_tee_plat_driver = {
 	.driver = {
 		.name = "ftpm-tee",
 		.of_match_table = of_match_ptr(of_ftpm_tee_ids),
 	},
-	.probe = ftpm_tee_probe,
-	.remove = ftpm_tee_remove,
-	.shutdown = ftpm_tee_shutdown,
+	.shutdown = ftpm_plat_tee_shutdown,
+	.probe = ftpm_plat_tee_probe,
+	.remove = ftpm_plat_tee_remove,
+};
+
+/* UUID of the fTPM TA */
+static const struct tee_client_device_id optee_ftpm_id_table[] = {
+	{UUID_INIT(0xbc50d971, 0xd4c9, 0x42c4,
+		   0x82, 0xcb, 0x34, 0x3f, 0xb7, 0xf3, 0x78, 0x96)},
+	{}
 };
 
-module_platform_driver(ftpm_tee_driver);
+MODULE_DEVICE_TABLE(tee, optee_ftpm_id_table);
+
+static struct tee_client_driver ftpm_tee_driver = {
+	.id_table	= optee_ftpm_id_table,
+	.driver		= {
+		.name		= "optee-ftpm",
+		.bus		= &tee_bus_type,
+		.probe		= ftpm_tee_probe,
+		.remove		= ftpm_tee_remove,
+	},
+};
+
+static int __init ftpm_mod_init(void)
+{
+	int rc;
+
+	rc = platform_driver_register(&ftpm_tee_plat_driver);
+	if (rc)
+		return rc;
+
+	return driver_register(&ftpm_tee_driver.driver);
+}
+
+static void __exit ftpm_mod_exit(void)
+{
+	platform_driver_unregister(&ftpm_tee_plat_driver);
+	driver_unregister(&ftpm_tee_driver.driver);
+}
+
+module_init(ftpm_mod_init);
+module_exit(ftpm_mod_exit);
 
 MODULE_AUTHOR("Thirupathaiah Annapureddy <thiruan@microsoft.com>");
 MODULE_DESCRIPTION("TPM Driver for fTPM TA in TEE");
-- 
2.17.1

