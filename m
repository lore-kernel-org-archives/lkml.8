Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682CFC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39E3822464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WU83k4fI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgGNQdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgGNQdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:33:03 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BDEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 09:33:03 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id z63so16112629qkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Fbi5oy7sF2lHzBXkj0y6FQdFS2jK1RS7WlkIntC0vA=;
        b=WU83k4fIwLfSfCRitbyg1ZP9vGyEceEE40Co+/jfVE4WTIhdJhrdTmIBNDX+d3P1cc
         rMHM0o07i/Y9k5OLb4f4MJW0OIaDNduv1Bmiua1LFbbLILVVcM50tafPKvkgofc3SLvO
         syK4nv0bnhnn+thZgbuRaHHD3vbT/fJme98YNcoaiMgzEeGMRlx13i0KKPRD+PVLncJJ
         4KqMZvwwU2EgoxN384lg3T/UJy5g912+2QhdiBALWRppM8LM/XeDETRq1e6cAcFphvAD
         mYZqyFjqTIq98F4mFju7SV+/BVcN4aFHQPbobbWvbYas2lWcd8IuagXTlF4Y0WUnVOTM
         zzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Fbi5oy7sF2lHzBXkj0y6FQdFS2jK1RS7WlkIntC0vA=;
        b=nJ9eUFRB+hIXArp1Km47q5RUjY+d2zr1f7+olHsUycd+5saP5ovL4ALkAlCT7rMggt
         xA4Xj9LdVp51XTB9g8LXI2Cx86x8XxRK73rFg4ayGpgu7XvajuHkALw5XDgYmMwMfp9Y
         Qwm+nQvKMpEKNwIqKo0QTekrfyv7mQAm7XDlcDMDS99hZ32cPh3m7GA+2u/R27MxTJ8u
         vWEvfWkWRjgVW72qFzz//6Eb2hHlVM9TX6J3JJa15DINzZvSMIpcGsSNflrRwZI22utb
         qeSzdLmSgmC/qFPYV1wkpOKIdIEsQ3lKv623W2GILRf6DU16E6xzSDwL886p2p7gP+5b
         Uh5Q==
X-Gm-Message-State: AOAM532uSXMnRhUxqfpeJ4/u+kbjtiluN1PfvONzCwpv/BKtpuU15DbD
        XSCf2bLP0kkK2scBd8gocv/PxI3y
X-Google-Smtp-Source: ABdhPJz8FQWnWgrHE3Ng4FX90oVzvpNlRyrQSFfIVaKYosmoExWXz8Y/txIhT2TfVt1vteynvRKYPg==
X-Received: by 2002:a37:a20d:: with SMTP id l13mr5574447qke.296.1594744382483;
        Tue, 14 Jul 2020 09:33:02 -0700 (PDT)
Received: from atris.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id g30sm26284874qte.72.2020.07.14.09.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 09:33:01 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, kishon@ti.com, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] phy: tusb1210: use bitmasks to set VENDOR_SPECIFIC2
Date:   Tue, 14 Jul 2020 12:32:43 -0400
Message-Id: <20200714163243.6452-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/phy/ti/phy-tusb1210.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
index d8d0cc11d187..35baeb9deeee 100644
--- a/drivers/phy/ti/phy-tusb1210.c
+++ b/drivers/phy/ti/phy-tusb1210.c
@@ -13,9 +13,9 @@
 #include <linux/phy/ulpi_phy.h>
 
 #define TUSB1210_VENDOR_SPECIFIC2		0x80
-#define TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT	0
-#define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_SHIFT	4
-#define TUSB1210_VENDOR_SPECIFIC2_DP_SHIFT	6
+#define TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK	GENMASK(3, 0)
+#define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK	GENMASK(5, 4)
+#define TUSB1210_VENDOR_SPECIFIC2_DP_MASK	BIT(6)
 
 struct tusb1210 {
 	struct ulpi *ulpi;
@@ -118,22 +118,22 @@ static int tusb1210_probe(struct ulpi *ulpi)
 	 * diagram optimization and DP/DM swap.
 	 */
 
+	reg = ulpi_read(ulpi, TUSB1210_VENDOR_SPECIFIC2);
+
 	/* High speed output drive strength configuration */
-	device_property_read_u8(&ulpi->dev, "ihstx", &val);
-	reg = val << TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT;
+	if (!device_property_read_u8(&ulpi->dev, "ihstx", &val))
+		reg = set_mask_bits(&reg, TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK, val);
 
 	/* High speed output impedance configuration */
-	device_property_read_u8(&ulpi->dev, "zhsdrv", &val);
-	reg |= val << TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_SHIFT;
+	if (!device_property_read_u8(&ulpi->dev, "zhsdrv", &val))
+		reg = set_mask_bits(&reg, TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK, val);
 
 	/* DP/DM swap control */
-	device_property_read_u8(&ulpi->dev, "datapolarity", &val);
-	reg |= val << TUSB1210_VENDOR_SPECIFIC2_DP_SHIFT;
+	if (!device_property_read_u8(&ulpi->dev, "datapolarity", &val))
+		reg = set_mask_bits(&reg, TUSB1210_VENDOR_SPECIFIC2_DP_MASK, val);
 
-	if (reg) {
-		ulpi_write(ulpi, TUSB1210_VENDOR_SPECIFIC2, reg);
-		tusb->vendor_specific2 = reg;
-	}
+	ulpi_write(ulpi, TUSB1210_VENDOR_SPECIFIC2, reg);
+	tusb->vendor_specific2 = reg;
 
 	tusb->phy = ulpi_phy_create(ulpi, &phy_ops);
 	if (IS_ERR(tusb->phy))

base-commit: 8f3d9f354286745c751374f5f1fcafee6b3f3136
-- 
2.27.0

