Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FBCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5AF7207E8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKgqLqO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgGBBHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgGBBHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:07:01 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619E9C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 18:07:01 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v19so20000294qtq.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 18:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=31x9jE0Ixa2ljhK138xIQHujVzXyvdvEAC4Omg6LxXw=;
        b=gKgqLqO5gpy6TqDOec/F0l+h3G4KAPeMkxsiNNrVUQGBMcP+U8IE8ZpjfuWHfM/nGj
         4jJVJWyEJF10PFTaK96SLDsotjvMpLM1+cvoFH16RsIkSxSmO61vEv0J2qZ8ns8skeA1
         1bcDRtTnfTzo+tMR/3p/IbEGq4dDemdsAQfUuX0SSKf13cHEPgDqivItTHnJi5ZedFfg
         O1hI6rqGOQ6RU8QFCf8GuBNg5F6RkO2mPip2dWQ3vm8Hoe0npGw+WtGQfu3caCBE61ci
         LpXnpM6GfXkSxLtEcuxAD4bRVBupLbUDh1qVGm1fH49Tfee6T4KN40wWk9XrHsFIDMxz
         X88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=31x9jE0Ixa2ljhK138xIQHujVzXyvdvEAC4Omg6LxXw=;
        b=p96OPUZ7L4oJINCyGW5HukfnrDLJOFS9mOHPtVOPU4fRosp5+/9Jm6a6OloOgWd91g
         PjNbTSXptN9V8++QSoOltJJEoIdW8AkrjWPcmE3VhBZ+335QleeP2nNauQSuMbk1dYC3
         C6Izy0kBRwU36vnunjlblTQJJxHu0u3XjEL+uSUMYdz1C6NxDOwsS2Ct8UyKEWVKW6kd
         FcSP33EzyKYLnxEpCVmX+LSEyqotFnlFiC6yQ+ZY13Z/zskRbKB/3961NTqs00jPIgaJ
         qBSn0onarC83SJAUWxwhjOi/Q/g1ht3BReJU9L4XkOGPffs14j+ZeCJOjK5VQW0nGyQP
         ISiA==
X-Gm-Message-State: AOAM533e92F8MLUM/Obo/7Gi7nHuwqrfLYnUCaCqDdCwTcJNNpPhm4i1
        ZXLtRjp+1rMfommjawwpXvM=
X-Google-Smtp-Source: ABdhPJz5jyNImEnVHymOaGbXTIJ6W7+JryeTs7Y9ZGzNyCs2Z+32Vz6frJiW3ab+3BkHj1vUNjL5Zg==
X-Received: by 2002:ac8:3fac:: with SMTP id d41mr27531920qtk.98.1593652020635;
        Wed, 01 Jul 2020 18:07:00 -0700 (PDT)
Received: from atris.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id i10sm9064336qkn.126.2020.07.01.18.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 18:07:00 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
Cc:     liambeguin@gmail.com, kishon@ti.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] phy: tusb1210: use bitmasks to set VENDOR_SPECIFIC2
Date:   Wed,  1 Jul 2020 21:06:49 -0400
Message-Id: <20200702010649.16323-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Start by reading the content of the VENDOR_SPECIFIC2 register and update
each bit field based on device properties when defined.

The use of bit masks prevents fields from overriding each other and
enables users to clear bits which are set by default, like datapolarity
in this instance.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/phy/ti/phy-tusb1210.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
index d8d0cc11d187..a957655ebd36 100644
--- a/drivers/phy/ti/phy-tusb1210.c
+++ b/drivers/phy/ti/phy-tusb1210.c
@@ -13,9 +13,9 @@
 #include <linux/phy/ulpi_phy.h>
 
 #define TUSB1210_VENDOR_SPECIFIC2		0x80
-#define TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT	0
-#define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_SHIFT	4
-#define TUSB1210_VENDOR_SPECIFIC2_DP_SHIFT	6
+#define TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK	0x0f
+#define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK	0x30
+#define TUSB1210_VENDOR_SPECIFIC2_DP_MASK	BIT(6)
 
 struct tusb1210 {
 	struct ulpi *ulpi;
@@ -118,22 +118,25 @@ static int tusb1210_probe(struct ulpi *ulpi)
 	 * diagram optimization and DP/DM swap.
 	 */
 
+	reg = ulpi_read(ulpi, TUSB1210_VENDOR_SPECIFIC2);
+
 	/* High speed output drive strength configuration */
-	device_property_read_u8(&ulpi->dev, "ihstx", &val);
-	reg = val << TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT;
+	if (!device_property_read_u8(&ulpi->dev, "ihstx", &val))
+		reg = (reg & ~TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK) |
+			(val & TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK);
 
 	/* High speed output impedance configuration */
-	device_property_read_u8(&ulpi->dev, "zhsdrv", &val);
-	reg |= val << TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_SHIFT;
+	if (!device_property_read_u8(&ulpi->dev, "zhsdrv", &val))
+		reg = (reg & ~TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK) |
+			(val & TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK);
 
 	/* DP/DM swap control */
-	device_property_read_u8(&ulpi->dev, "datapolarity", &val);
-	reg |= val << TUSB1210_VENDOR_SPECIFIC2_DP_SHIFT;
+	if (!device_property_read_u8(&ulpi->dev, "datapolarity", &val))
+		reg = (reg & ~TUSB1210_VENDOR_SPECIFIC2_DP_MASK) |
+			(val & TUSB1210_VENDOR_SPECIFIC2_DP_MASK);
 
-	if (reg) {
-		ulpi_write(ulpi, TUSB1210_VENDOR_SPECIFIC2, reg);
-		tusb->vendor_specific2 = reg;
-	}
+	ulpi_write(ulpi, TUSB1210_VENDOR_SPECIFIC2, reg);
+	tusb->vendor_specific2 = reg;
 
 	tusb->phy = ulpi_phy_create(ulpi, &phy_ops);
 	if (IS_ERR(tusb->phy))

base-commit: cd77006e01b3198c75fb7819b3d0ff89709539bb
-- 
2.27.0

