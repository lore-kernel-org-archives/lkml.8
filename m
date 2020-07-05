Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C68C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B12DF20747
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGzwoBg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgGEGEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 02:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgGEGEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 02:04:44 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E94CC061794;
        Sat,  4 Jul 2020 23:04:44 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id k27so840396pgm.2;
        Sat, 04 Jul 2020 23:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vGHyGpCtTzDGX17MIrY06Vl+/0dBVvT7eGpW4IN57jk=;
        b=kGzwoBg++MIY+bbWpT7gSJyxE+OLmzb5CKa6gwLwDvLcAiUjIH50HUoQKmeem31ThA
         48aaIatt5Xlhms2I+eX25j1WpNa++aarPTx94PHMfDzK6k3T15KmD5J9IjtbPDRxtx7l
         PUcxPYz+jiLZKcjfSuJQPlIR1VOc53ozTRvzPVscq2NEF9S3DVrcZIU2EdXUWJpiRNQ5
         7yjcFZucu3fFDvETinWhKizT5p9Pg41eoWhwGtazmNrBvD3yS0eoIrpOVYxnFLfyuku5
         3MtA3OmcnB5YfL32WEHo3Ef0JM7LPWWYdGTZkE/WI2+7mWtKzIL7ChfizovIrBV2S9BD
         VjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vGHyGpCtTzDGX17MIrY06Vl+/0dBVvT7eGpW4IN57jk=;
        b=gHLyLYU0CRoipRBylo3KKu3TSuBKwmpKILZozusk8okv+rG90jWBSGqX9Kiq0P3Uox
         8OIGcm98t0mgzMAoNhyNJR48qyPLLUdcCVFrOEf2nsxr7tsJjN65OOHtyJHmO5epZ0PP
         TOlQZd/AoD4SDyN4WqEMp6Htde7xziU3VjfMPJCH4k6DX61AACnzmUUEdshNLfzY9Q/l
         Jta/U4mwWi7GFVUGbMapmYfEdcvAXWFRCzB5mAi+l9cs6QRfQ7keOl+qSNmqNz8mdXWH
         FCrMs7dALaayDiREWyuyv5pUNkUUgrUugvIxnG14a8nYIkq5oCgBNcsNLUGbCYrHZpXr
         cdXQ==
X-Gm-Message-State: AOAM532iFu9/0dNpus+XYm0diVXtbF+lEhBCInzTf0t4ZUd8Wr18U5C2
        7LmgWMfkRQRllLYLTCtxnpY=
X-Google-Smtp-Source: ABdhPJwcv1m0vmAxwmfC3m9wLCMV9RDfvvesVYT6bKQk9sF6xz6IXWHFYOIMasWS84Qxe8EyM/3ssQ==
X-Received: by 2002:a05:6a00:10:: with SMTP id h16mr37740624pfk.214.1593929083951;
        Sat, 04 Jul 2020 23:04:43 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.198])
        by smtp.gmail.com with ESMTPSA id nh14sm8860676pjb.4.2020.07.04.23.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 23:04:42 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2] phy: samsung: Use readl_poll_timeout function
Date:   Sun,  5 Jul 2020 06:04:35 +0000
Message-Id: <20200705060435.504-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User readl_poll_timeout function instead of open
coded handling in crport_handshake function.

Fixes: d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5800")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Changes v2:
--used the default timeout values.
--Added missing Fixed tags.
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 37 +++++++++---------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index e510732afb8b..c97f5fb6a9a0 100644
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
@@ -556,40 +557,28 @@ static int exynos5_usbdrd_phy_power_off(struct phy *phy)
 static int crport_handshake(struct exynos5_usbdrd_phy *phy_drd,
 			    u32 val, u32 cmd)
 {
-	u32 usec = 100;
+	u32 timeout_us = 100, sleep_us = 1;
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
+	err = readl_poll_timeout(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1,
+			result,	(result & PHYREG1_CR_ACK), sleep_us, timeout_us);
+	if (err) {
+		dev_err(phy_drd->dev, "CRPORT handshake timeout1 (0x%08x)\n", val);
 		return -ETIME;
 	}
 
-	usec = 100;
+	timeout_us = 100;
+	sleep_us = 1;
 
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
+	err = readl_poll_timeout(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1,
+			result,	!(result & PHYREG1_CR_ACK), sleep_us, timeout_us);
+	if (err) {
+		dev_err(phy_drd->dev, "CRPORT handshake timeout2 (0x%08x)\n", val);
 		return -ETIME;
 	}
 
-- 
2.27.0

