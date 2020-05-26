Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CEAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E568020776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jj4f8a19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392461AbgEZTUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392251AbgEZTUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:20:42 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B41C03E97C
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:20:41 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z22so13041985lfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ly/hqC+OpwfmKTz5BxiBCk11qr5IjD5u5LkJ+5oge9k=;
        b=jj4f8a195bN/b2zB0ZWQf3ep6OWmBs6zZXB82xREt0TC5NGBrTNUCijzfLG9tRAdIK
         X99OlquY/pzaajwkJAmiKXLaJFMpFPjH+sLgBNlKWih4Uqb+kNLvNAQ+cAVkWfN4nZoE
         jO27YRbzPZiI/0PDsa+cqiGOihNRASdZNJqytfExMb7zRpBrfdmx+rL0VObMbdXZLKGj
         t8ezQ6snhHP0NF9+Mk8G3VSMMU4rMLwzdODFq1sIh6j/+5sHtR9UA+/aMuUW6Zlptv1J
         4rK9T3xCCs/KmJbux2DwBioegj5HxMZluKwJyuaSOnzOMQql5XtnOqAJPianl5V41bLw
         WBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ly/hqC+OpwfmKTz5BxiBCk11qr5IjD5u5LkJ+5oge9k=;
        b=PrLeIoJCsaEJq4Bg6vsTRdc0LpwlxNes19N9BWkw+yh5iEbTVbS1unQLCBygnnaOSu
         tWGTRBDR8cCmj5QydMNBeV/YMOi9irAH0bd/DKXJCl4Snt9kIZi8xuRbbmRvH3MJ8H4N
         /l+EB21SzWZAKFyuarCJ05JmkI18KKP6I60noG4Gu6gEx4CSV/nOeV4gEXc0fB2/ouq/
         zW8b3Cgk/oe/jV0G4SeHYlJxJ1qJga5iCdDgeGA6hIy93l1+TFZUbrCEEvQfV5DRJsmG
         5Bg1USP0eeqU4oGV5VeUsvP7m08OvnE7TmFdIX/K2aSxYTFRTTv8AWhn554H2KgbE8eS
         OEZQ==
X-Gm-Message-State: AOAM530Dh1CiXYK1GHXCui8ATKZLkt3PBp3QrL3wuAdgwN3D/io8mhk1
        nsy+BrDny31P7NvC1gz6MgD4yKQ3cno=
X-Google-Smtp-Source: ABdhPJyIwCdPdWx3iVuj+HKFf4k9Bryj+HGLN3dX9mcIw6ozQM5joA/WEGJP/4OCMDV7hiHVBnZw4w==
X-Received: by 2002:a05:6512:411:: with SMTP id u17mr1203700lfk.106.1590520839212;
        Tue, 26 May 2020 12:20:39 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id i8sm180483lfo.62.2020.05.26.12.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:20:38 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv4 3/3] tpm_ftpm_tee: register driver on TEE bus
Date:   Tue, 26 May 2020 22:20:29 +0300
Message-Id: <20200526192029.863-4-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526192029.863-1-maxim.uvarov@linaro.org>
References: <20200526192029.863-1-maxim.uvarov@linaro.org>
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

