Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580F2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36019206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBGHU/Ix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgGGJ7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgGGJ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:59:17 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDBCC061755;
        Tue,  7 Jul 2020 02:59:17 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 1so520691pfn.9;
        Tue, 07 Jul 2020 02:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C4eDJfDQ2O8UUzPVYO4ixzIP7yiUb1/eu6C6M7C54kk=;
        b=bBGHU/IxEdGnMMvzMvAddWFz0lF7tIyqAGNHt5+Zsy+CDq3FtUCvjY2GB/wuiKe+Tk
         dOctHzgrbqDRLtdMZXmCN2ve9pPa59dN2M845uxfAZeWXz2UiiM8IZxHdOikNIMp+Y+I
         wQUEpwED4tJ19sGhTDgN9ctCLtQ7K813PakEztg7udz6UI7JR2YhYPvtqm6LWdi54r/R
         iQppiTyuuwC5LxjhVpNhznGxQEWqJ0hHaM1n5UuALxCF3PBnbC6CTnLF+zex05kvyNg8
         lXoaO0mHps+0QnnH3uKsZNJwsNQmHKJ+Tmvr8aeVYjrJdCQUdU09SeqKbRAPrlzQUarL
         4fLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C4eDJfDQ2O8UUzPVYO4ixzIP7yiUb1/eu6C6M7C54kk=;
        b=I611HvUpaQw/ySacglDqHZlSJBFNcUxUYfBdCbDEIJ89YLA+1+6kKcziYTI52Wk1y2
         1deGv4br9PI8p7H275s3yEE6VepGG6bbLgUhpnOE6S4dCjFCp7gTXWD+vLMwWYS7Ow+A
         nihpV39kdfMyEonf1/Ia7Rx8rAqvWhWWFXSEZFrUtQjxhY8dLbg/JCjp0NQ1rI3N57w7
         9q2RXVSyu5iaRkoaQYPN1vu92UCn8v0UwVofc6WIuhqu46yeLuWGi7QlDTZP5/vPF78Y
         +1/UpgzWlvdPo3CbKr5lSrvuTdG0UGpZxLMNOc4jYA4JgciwQSkj1Bb8AZ5Yl8Q6/hkJ
         OAHw==
X-Gm-Message-State: AOAM530/IIDua6QqzP50quCla5nOKwpZEzM6s7c7tSa5JdIFI+7E9qrM
        0a5+u8cXKtzNiJVzoJhsrfQ=
X-Google-Smtp-Source: ABdhPJxYHFhB1av6cnPY3CLBmV5fQw/sgWmWMW730ilHUltzEAj0BrDaJBjpPKunfFd8fSj/k/vC/g==
X-Received: by 2002:a65:67d9:: with SMTP id b25mr44913068pgs.311.1594115956404;
        Tue, 07 Jul 2020 02:59:16 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.198])
        by smtp.gmail.com with ESMTPSA id r7sm435805pgu.51.2020.07.07.02.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 02:59:15 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3] phy: samsung: Use readl_poll_timeout function
Date:   Tue,  7 Jul 2020 09:59:08 +0000
Message-Id: <20200707095908.372-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of a busy waiting loop while loop using udelay
use readl_poll_timeout function to check the condition
is met or timeout occurs in crport_handshake function.

Fixes: d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5800")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Changes v3:
--Fix the commit message.
--Drop the variable, used the value directly.
Changes v2:
--used the default timeout values.
--Added missing Fixed tags.
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 35 +++++++-----------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index e510732afb8b..fa75fa88da33 100644
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
@@ -556,40 +557,24 @@ static int exynos5_usbdrd_phy_power_off(struct phy *phy)
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
+	err = readl_poll_timeout(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1,
+			result,	(result & PHYREG1_CR_ACK), 1, 100);
+	if (err) {
+		dev_err(phy_drd->dev, "CRPORT handshake timeout1 (0x%08x)\n", val);
 		return -ETIME;
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
+	err = readl_poll_timeout(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1,
+			result,	!(result & PHYREG1_CR_ACK), 1, 100);
+	if (err) {
+		dev_err(phy_drd->dev, "CRPORT handshake timeout2 (0x%08x)\n", val);
 		return -ETIME;
 	}
 
-- 
2.27.0

