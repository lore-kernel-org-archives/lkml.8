Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79820C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 604DD206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSoBcGlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388685AbgGTRfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 13:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbgGTRfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 13:35:11 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6349C061794;
        Mon, 20 Jul 2020 10:35:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a9so158487pjd.3;
        Mon, 20 Jul 2020 10:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WABzq59H5eUVYxXK83gQCdP2ji4pUab0s2f+SVe9EGI=;
        b=KSoBcGlL4mpyA6z70T5c3zPdITp8j0hU0JwBgNNjrWFX5gJFyC40y/wPD+vC1X5Ajd
         ACXnjLQu44r8pQzWggycGix7CiwdtpBQnqEs1eCd6mesISSUECDr7flMAuMdzat62+8x
         UVp1LgUsiBBveXrK+fl3TO3mHwCguR7ltdYZ6QZY3moTWDy0N/o6ECEXEJxW6tMC/j33
         XhrUsYk6MvuafN9d4/bh91e4TTBHGYXXYFnnaYS52DipCZ7kkysEwhfFm29RirNivCG0
         6Ed4+rxF4UoZP3TZ1H1YfZuoymiKZ9W+OCHT3lfjwd0s0jxHSQGmqL1dhv1qH3T2NjWU
         5TGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WABzq59H5eUVYxXK83gQCdP2ji4pUab0s2f+SVe9EGI=;
        b=twKbNESBEusvaKmLqs43on29jSO3YFve6PdEx6oGzJ9fyidy9RaxKuOaVBS8qB/1pu
         mPp3wrhyPbzYn8LSaMsrAB9QiOLLdy9oORVQM6ZRHHC1fK2qGha3eai129tbxIzv1Y3/
         pp7PwWSy1Ol8kpCnc83Do2wyxGjf6MCDbTQeQOFVr6QC93f8iPxGepyK4+10JuJ7fg4Y
         zjWcq8GEtRpWeL+qrUEWXKnkb7V8mmRxpA3w1qKztH7Bb6urfmd7qieXAGcaYzF6ZM7L
         GXFYu1MYYnQ4E+uGgPCK/axQgB5Lu0WhwsL+FPh3YgWiceOpmQ2laVE00a85Z0ce7WtA
         W5Fw==
X-Gm-Message-State: AOAM530c6yYf4DjY5JL8Aqp1QOq85kPU2qszmdHiCjsqH0ctgjiY4OX3
        6H6b4fhi7uf63Z2gDgCO5/Y=
X-Google-Smtp-Source: ABdhPJzK0dZp9lmnB+R8F0pxEFC0wQCOX+oQUQyN7tpsTVwmYqbun2SGzjyQ8+lsh/JrEyyFSbnfrQ==
X-Received: by 2002:a17:90b:488:: with SMTP id bh8mr516495pjb.49.1595266511403;
        Mon, 20 Jul 2020 10:35:11 -0700 (PDT)
Received: from localhost.localdomain ([103.51.73.161])
        by smtp.gmail.com with ESMTPSA id b22sm175972pju.26.2020.07.20.10.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 10:35:10 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v5] phy: samsung: Use readl_poll_timeout function
Date:   Mon, 20 Jul 2020 17:35:02 +0000
Message-Id: <20200720173502.542-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of a busy waiting while loop using udelay
use readl_poll_timeout function to check the condition
is met or timeout occurs in crport_handshake function.
readl_poll_timeout is called in non atomic context so
it safe to sleep until the condition is met.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Changes v5:
--Fix the indentation, checkpatch warning.
--Drop the Fix tags.
Changes v4:
Rebased on to of patch [0] https://patchwork.kernel.org/patch/11651673/
--Fix the commit message.
--Fix the error timeout condition for -ETIMEDOUT
Changes v3:
--Fix the commit message.
--Drop the variable, used the value directly.
Changes v2:
--used the default timeout values.
--Added missing Fixed tags.
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 39 ++++++++----------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 7f6279fb4f8f..c45ed9cabc5e 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/iopoll.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
@@ -556,41 +557,25 @@ static int exynos5_usbdrd_phy_power_off(struct phy *phy)
 static int crport_handshake(struct exynos5_usbdrd_phy *phy_drd,
 			    u32 val, u32 cmd)
 {
-	u32 usec = 100;
 	unsigned int result;
+	int err;
 
 	writel(val | cmd, phy_drd->reg_phy + EXYNOS5_DRD_PHYREG0);
 
-	do {
-		result = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1);
-		if (result & PHYREG1_CR_ACK)
-			break;
-
-		udelay(1);
-	} while (usec-- > 0);
-
-	if (!usec) {
-		dev_err(phy_drd->dev,
-			"CRPORT handshake timeout1 (0x%08x)\n", val);
-		return -ETIME;
+	err = readl_poll_timeout(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1,
+				 result, (result & PHYREG1_CR_ACK), 1, 100);
+	if (err == -ETIMEDOUT) {
+		dev_err(phy_drd->dev, "CRPORT handshake timeout1 (0x%08x)\n", val);
+		return err;
 	}
 
-	usec = 100;
-
 	writel(val, phy_drd->reg_phy + EXYNOS5_DRD_PHYREG0);
 
-	do {
-		result = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1);
-		if (!(result & PHYREG1_CR_ACK))
-			break;
-
-		udelay(1);
-	} while (usec-- > 0);
-
-	if (!usec) {
-		dev_err(phy_drd->dev,
-			"CRPORT handshake timeout2 (0x%08x)\n", val);
-		return -ETIME;
+	err = readl_poll_timeout(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1,
+				 result, !(result & PHYREG1_CR_ACK), 1, 100);
+	if (err == -ETIMEDOUT) {
+		dev_err(phy_drd->dev, "CRPORT handshake timeout2 (0x%08x)\n", val);
+		return err;
 	}
 
 	return 0;
-- 
2.27.0

