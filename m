Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF13C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 487752073A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPI/id/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgDWN2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726224AbgDWN23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:28:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93672C08E934;
        Thu, 23 Apr 2020 06:28:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d15so5241103wrx.3;
        Thu, 23 Apr 2020 06:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H+kR0UcPOO6MRdLEzgHE+vv3y4TUhkBdKhYsw9irPWw=;
        b=RPI/id/t6l5PqqaFmS+oq7ZoVqwl/0FeLJ3Xvmgm4BjC/GSrZc30HFIA3bd780ZyNp
         QRACaq3CWo/Y9RZQm5Dntm0D7cx2TFvElMhb9v+Co+KgNzEfHU0f99cTzDy9NHYG9j7K
         nJGMkbogwc+KlKgU40owfPE3bORQGnSnV6s6lQH6uvuBU0JRRRj8DyjLpcu3FHYTKVO0
         mhjSdNqkfVMOExwmy3rdDr/PhMTh9gKgitG0KY9xCEciZSwiHUuq3zvxD3n8mMiJTxEg
         box8fxZV8zgE8Ij/cwmXN/2gFfu4azXZgdpMpmxfggiWjlzHsR3uWEsr7u4p3kd1xXad
         G86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H+kR0UcPOO6MRdLEzgHE+vv3y4TUhkBdKhYsw9irPWw=;
        b=NBDOQbcsdHn6D6LqYXpSlNgXymIA3AA5bUS78HOYA+7QJu59pYZRcNUCNmt8lIndC6
         QWeJKmTHDqgWeLcgnF5EJ3D7q+/83+/XE03r2VDuGWlLXDUlCCNHr1C1lDtFiXXMqoo3
         IIkIaMtzPwpS1b5gUTh7frbO+iO8qQ7XeTd0PJuqw7K6UJHgZnnp/EbCdZThzg4d4jR9
         KpMvURvL5kTFhd9zEKgLJnrzOexSrLT2YPF0Q822nmXpH/ITyecxI7NkMpvClZCar23h
         1NtBHYJCCmCP3WqyddIf/Oc3SclLpqSs/L3Q2Ir/rB3XHmXFdJFzhEdm2mq836BjlZ+B
         xhSA==
X-Gm-Message-State: AGi0PuaK+vcbnSSsTyt4chY2Bt6SPtkKADBZrfUEMuLHSQaLs2M8O9Yl
        ykFv0Zcy48Fv/Ie4tg6W1C115wFfMryIGw==
X-Google-Smtp-Source: APiQypL00MM7opxNieTqA6f4ccQWl4aOFoowwL2e4/vkcJL487OI1qTQuZqKZuXMAad1M5XSGGVPKQ==
X-Received: by 2002:a5d:6a92:: with SMTP id s18mr4699435wru.50.1587648508339;
        Thu, 23 Apr 2020 06:28:28 -0700 (PDT)
Received: from localhost.localdomain (89-212-21-243.static.t-2.net. [89.212.21.243])
        by smtp.googlemail.com with ESMTPSA id l15sm3552703wmi.48.2020.04.23.06.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 06:28:27 -0700 (PDT)
From:   Andrej Picej <andpicej@gmail.com>
Cc:     primoz.fiser@norik.com, Andrej Picej <andpicej@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (lm70) Add support for ACPI
Date:   Thu, 23 Apr 2020 15:27:33 +0200
Message-Id: <20200423132733.7743-1-andpicej@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for lm70 commpatible drivers with systems that
use ACPI.

Signed-off-by: Andrej Picej <andpicej@gmail.com>
---
 drivers/hwmon/lm70.c | 45 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index 4122e59f0bb4..0e809cac2cf4 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -25,6 +25,9 @@
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/of_device.h>
+#include <linux/acpi.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
 
 
 #define DRVNAME		"lm70"
@@ -148,18 +151,47 @@ static const struct of_device_id lm70_of_ids[] = {
 MODULE_DEVICE_TABLE(of, lm70_of_ids);
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id lm70_acpi_ids[] = {
+	{
+		.id = "LM000070",
+		.driver_data = LM70_CHIP_LM70,
+	},
+	{
+		.id = "TMP00121",
+		.driver_data = LM70_CHIP_TMP121,
+	},
+	{
+		.id = "LM000071",
+		.driver_data = LM70_CHIP_LM71,
+	},
+	{
+		.id = "LM000074",
+		.driver_data = LM70_CHIP_LM74,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, lm70_acpi_ids);
+#endif
+
 static int lm70_probe(struct spi_device *spi)
 {
-	const struct of_device_id *match;
+	const struct of_device_id *of_match;
+	const struct acpi_device_id *acpi_match;
 	struct device *hwmon_dev;
 	struct lm70 *p_lm70;
 	int chip;
 
-	match = of_match_device(lm70_of_ids, &spi->dev);
-	if (match)
-		chip = (int)(uintptr_t)match->data;
-	else
-		chip = spi_get_device_id(spi)->driver_data;
+	of_match = of_match_device(lm70_of_ids, &spi->dev);
+	if (of_match)
+		chip = (int)(uintptr_t)of_match->data;
+	else {
+		acpi_match = acpi_match_device(lm70_acpi_ids, &spi->dev);
+		if (acpi_match)
+			chip = (int)(uintptr_t)acpi_match->driver_data;
+		else
+			chip = spi_get_device_id(spi)->driver_data;
+	}
 
 	/* signaling is SPI_MODE_0 */
 	if (spi->mode & (SPI_CPOL | SPI_CPHA))
@@ -195,6 +227,7 @@ static struct spi_driver lm70_driver = {
 	.driver = {
 		.name	= "lm70",
 		.of_match_table	= of_match_ptr(lm70_of_ids),
+		.acpi_match_table = ACPI_PTR(lm70_acpi_ids),
 	},
 	.id_table = lm70_ids,
 	.probe	= lm70_probe,
-- 
2.17.1

