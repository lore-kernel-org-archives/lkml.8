Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21136C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE1B2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhlT799S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgGMHmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgGMHmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:42:53 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE79C061755;
        Mon, 13 Jul 2020 00:42:53 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q17so5149662pls.9;
        Mon, 13 Jul 2020 00:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kv7SaniNrlUPbvo7cWwc80WSNfLRXfgs1fiLYtKopIU=;
        b=ZhlT799SGBQhoHqAHdZ4lZj1j/AYdgOOYfKXe+d0zRdJWGte52q6+ZlkptRwdhl5v4
         QV/4eytBNvOoIsIoKXWzcx86NjNK6/6pwau43reCmmEc8nR9FbS/FUPUgB1xvF7Zys2B
         3nxgz2QzSdL0QR4FYvC/zdx3DWypbf6R/xf02t6VJn9f7Mej+t1xPMUDayyZLFwXJQLs
         yGFjT8yL9ybELIToHwaEOZK9Na+q37Qt5MWWdutGF7lFA6oqtPBW9UknREOKpdbT0o2m
         uLm5Eae8jQWqrSRbJV/aK7ExOX6L7L4QyP1+iAmM7mBe2TPqtWFbGmQ/WZ+LWqjsfR7J
         BfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kv7SaniNrlUPbvo7cWwc80WSNfLRXfgs1fiLYtKopIU=;
        b=GB89Ln+TYw04YhHJDcXVqpDR0H+ByfXbbmT7hFDvKviuQ3hm/AoE0FGIFJj7KdNm//
         l8Fu6YQwLxWn2kzyi0y0J+r2HYPVHspCaVV+uBxtyQLnk4dWVrMhkV48o7PjfuJouHDQ
         iQ3veBxL3Z/Q2arDB0zZBj7nRpLhU7iakAxniNe1UqOYrXXyFpdpOQOxZPRl1rbwlMoy
         5aaQK37Is4bMudlTcAJi/1zw12KSSyEv5JLt8uo7eWKV4zpMsO+At8UIDfwBYODBryeX
         iHzxrtpdeP9rIDAiw/9vk829XADf4vZs3pgHXiMAqazzxS/NhYsGF4wTmCF8m8pHyM7t
         v6gA==
X-Gm-Message-State: AOAM530EPCYa24B7D8SP/d6YZxXTjW0H4iqNBGTwg5kVz7awsGpTe4kE
        TL8xzHzGMhgz+Pkfm6BVEKw=
X-Google-Smtp-Source: ABdhPJxHcu1Ud7WDBTb4qIFDB5l2yIOfKVi3zND/ElHwtLcc7bQ/TVlT+STA2ZBAjz08dje95SGmYA==
X-Received: by 2002:a17:90a:bf89:: with SMTP id d9mr19127661pjs.89.1594626172692;
        Mon, 13 Jul 2020 00:42:52 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.198])
        by smtp.gmail.com with ESMTPSA id e12sm13521180pfd.69.2020.07.13.00.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 00:42:52 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4] phy: samsung: Use readl_poll_timeout function
Date:   Mon, 13 Jul 2020 07:42:43 +0000
Message-Id: <20200713074243.530-1-linux.amoon@gmail.com>
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

Fixes: d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5800")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Changes v4:
Rebased on to of patch [0] https://patchwork.kernel.org/patch/11651673/
--Fix the commit message.
--Fix the error timeout condition for -ETIMEDOUT
---
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
index 7f6279fb4f8f..ad81aa65cdff 100644
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
+			result,	(result & PHYREG1_CR_ACK), 1, 100);
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
+			result,	!(result & PHYREG1_CR_ACK), 1, 100);
+	if (err == -ETIMEDOUT) {
+		dev_err(phy_drd->dev, "CRPORT handshake timeout2 (0x%08x)\n", val);
+		return err;
 	}
 
 	return 0;
-- 
2.27.0

