Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8437FC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5506E20738
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPob0hGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgHQRfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731273AbgHQQcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:32:15 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EF6C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 09:32:14 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j187so15482130qke.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9m4MfDUfrltprFjWsb3k3Kia0mWcTEtj+YWN//2YLSE=;
        b=jPob0hGf8a2L4JsXcMdzEjwJAr4SK4ZI67Zl6bJCrKDXIFEuivs+1/Tf6V3WLsPcHH
         HtyGxTc/QvBwerXGUKIpw1BkjLG/NCi95nxF5AJI18Qyg+8Or+PEZarPxnsAM8A/FWEf
         xSnqRXeG2PuLndwdSbOlZfx8onjfDbigwLH237qO78YbIzfuiovoWXJANyulgpDQbPDu
         j5tY7czB0BeZJxrBmF2VjVjJdB/QpEoYqL7tQB4TMVqfCWBZgtER6OJuu6+Du1ZZbdDy
         MaLB8z3ozcD0r0BiKnrdzw4cHaRkWlR6ifUF7BZxzuU+CUhqjKO2cya32IlMbR0w0H6h
         2tCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9m4MfDUfrltprFjWsb3k3Kia0mWcTEtj+YWN//2YLSE=;
        b=E2bb70oiz71/t05zmkr0Pytew4+bZ471ft6CAPjX+kJ898iDv3d/7ozVaS4JJfnKyv
         vNDI8grON/pLx785aSZQ3Z+FUB1E58ks9D2f6rtxHGBra9S87poGmlylNdkCevpUQyL+
         i8blOfPHD8RdF7L183CQfzaxFTUFpTGn0J7hDDSdQdlRoFClI/5/gu6wxiKChWdnI4td
         t6QSAy9jRjAgOD32mlXDhE22OpcpmILTuBuZaJ3kIcFfJXt3WywbNnBoXnb/l4SjSfmL
         +ib+XGzMD+7gdxwQ4IoI42U/63i/6s/t9VDx9r9TWsKGwlzn96nEK2kR/6EdBj82x1Kx
         vCfQ==
X-Gm-Message-State: AOAM532lQ/x2N/hQhA4xafMslUUXO5ZjtMj2aL4IDtccE6S+IXL8N4Q1
        mbh+aSpKpZXL2Mfxbrzdh2g=
X-Google-Smtp-Source: ABdhPJzPZE5HzRjmtdIRGzVfzwZiibX8QBNrVCGwBKoEgHQZmDiPEvdnBfCVQz/pUpnG4j+W0t/wDQ==
X-Received: by 2002:a37:8287:: with SMTP id e129mr11743166qkd.132.1597681933893;
        Mon, 17 Aug 2020 09:32:13 -0700 (PDT)
Received: from atris.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id j16sm17335953qke.87.2020.08.17.09.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 09:32:13 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, kishon@ti.com, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] phy: tusb1210: use bitmasks to set VENDOR_SPECIFIC2
Date:   Mon, 17 Aug 2020 12:31:52 -0400
Message-Id: <20200817163152.13468-1-liambeguin@gmail.com>
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
Changes since v1:
- use set_mask_bits

Changes since v2:
- fix missing bit shift dropped in v2
- rebase on 5.9-rc1

 drivers/phy/ti/phy-tusb1210.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
index d8d0cc11d187..358842b5790f 100644
--- a/drivers/phy/ti/phy-tusb1210.c
+++ b/drivers/phy/ti/phy-tusb1210.c
@@ -14,8 +14,11 @@
 
 #define TUSB1210_VENDOR_SPECIFIC2		0x80
 #define TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT	0
+#define TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK	GENMASK(3, 0)
 #define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_SHIFT	4
+#define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK	GENMASK(5, 4)
 #define TUSB1210_VENDOR_SPECIFIC2_DP_SHIFT	6
+#define TUSB1210_VENDOR_SPECIFIC2_DP_MASK	BIT(6)
 
 struct tusb1210 {
 	struct ulpi *ulpi;
@@ -118,23 +121,27 @@ static int tusb1210_probe(struct ulpi *ulpi)
 	 * diagram optimization and DP/DM swap.
 	 */
 
+	reg = ulpi_read(ulpi, TUSB1210_VENDOR_SPECIFIC2);
+
 	/* High speed output drive strength configuration */
-	device_property_read_u8(&ulpi->dev, "ihstx", &val);
-	reg = val << TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT;
+	if (!device_property_read_u8(&ulpi->dev, "ihstx", &val))
+		reg = set_mask_bits(&reg, TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK,
+				    val << TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT);
 
 	/* High speed output impedance configuration */
-	device_property_read_u8(&ulpi->dev, "zhsdrv", &val);
-	reg |= val << TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_SHIFT;
+	if (!device_property_read_u8(&ulpi->dev, "zhsdrv", &val))
+		reg = set_mask_bits(&reg, TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK,
+				    val << TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_SHIFT);
 
 	/* DP/DM swap control */
-	device_property_read_u8(&ulpi->dev, "datapolarity", &val);
-	reg |= val << TUSB1210_VENDOR_SPECIFIC2_DP_SHIFT;
-
-	if (reg) {
-		ulpi_write(ulpi, TUSB1210_VENDOR_SPECIFIC2, reg);
-		tusb->vendor_specific2 = reg;
+	if (!device_property_read_u8(&ulpi->dev, "datapolarity", &val)) {
+		reg = set_mask_bits(&reg, TUSB1210_VENDOR_SPECIFIC2_DP_MASK,
+				    val << TUSB1210_VENDOR_SPECIFIC2_DP_SHIFT);
 	}
 
+	ulpi_write(ulpi, TUSB1210_VENDOR_SPECIFIC2, reg);
+	tusb->vendor_specific2 = reg;
+
 	tusb->phy = ulpi_phy_create(ulpi, &phy_ops);
 	if (IS_ERR(tusb->phy))
 		return PTR_ERR(tusb->phy);

base-commit: 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
-- 
2.27.0

