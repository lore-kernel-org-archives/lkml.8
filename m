Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1BEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32DE720760
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBO1XJ5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgGCNUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgGCNUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:20:21 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D89C08C5C1;
        Fri,  3 Jul 2020 06:20:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 207so13801978pfu.3;
        Fri, 03 Jul 2020 06:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LDiFULixaebs2MrsIr7/asrSZO8qQssL9OgufzsRRnY=;
        b=KBO1XJ5zAIjPFUjuxrpGgKmLwz0mXFjXa559w/Dgr+rBE+hEw+sVLFas/aRJSVyQIX
         cPfYRDxpl97pxvktYM6nSWFJZsN9ky9lLF+m4shdFGtqKIEmvxOYlPxIcJTvEqrtMAMz
         dNrqX53T8KnWVVRCtTOs4bmOXUWuVditN/vPtyWVv766Y80sQ1mBJRXmfIDrb4I8vsI+
         5Tj5jVn+UeU7Ksv9r780PQNE0FAJ9ixBdCcM7ZnM+nb4Xxir/v56dwD/yS+/hZ6fN0QG
         2twPoKWn+cZNfm//ONxJUMVQNpEny3oJm3NSEiAtI7JnE4XGo9IfxelfiWwrc3FoHS0u
         y4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LDiFULixaebs2MrsIr7/asrSZO8qQssL9OgufzsRRnY=;
        b=C82LmxLQfvcgMKp3VKRfe3E0xuPjwLUhNb3T3GmNFy95WgJdL+KANVkX/+yTx178XT
         rTi0GW3aDc5TxVsjM+EoUzgl4Lv/+t80OtoIijmQ4AhRtMVQBdZsi1b+T/Uohrhx5EfC
         PcXU7mGcA9TA55gT00hz5PAxxUn8pnpYgJ7/axMRMCxs9fAg3kgI7YYKv4FRrbTv8xq5
         opGeEH+hqsNGNl/e23wb2hI4YmRQUeNEUPpV75JBU1i0Os62rWhXUNHTadNmz+XZSdCk
         R8XqNb3LCTTgehTctJuKUhKOro3h5WrdWxobfnQ/ezuLhoCyJgBnKOPZuJzX9f/92H3M
         5/dw==
X-Gm-Message-State: AOAM531CObmX4uFx7Pwt5hkZsQQlNZQL+U/XxcrfrajKpiYoa63gGGf1
        8S1/5o0rg11I8N6RZgz9e0M=
X-Google-Smtp-Source: ABdhPJzurlv8AWULBx68fy6iuWnB779WRjX6EPfzmLgBnv+o31xLSHolYNxGWmjnGyerIGkgX1Nfzg==
X-Received: by 2002:a62:8782:: with SMTP id i124mr32943371pfe.267.1593782420821;
        Fri, 03 Jul 2020 06:20:20 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.198])
        by smtp.gmail.com with ESMTPSA id q10sm12706937pfk.86.2020.07.03.06.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 06:20:19 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] phy: samsung: Use readl_poll_timeout function
Date:   Fri,  3 Jul 2020 13:20:12 +0000
Message-Id: <20200703132012.579-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User readl_poll_timeout function instead of open
coded handling in crport_handshake function.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 37 +++++++++---------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index e510732afb8b..83274c5e3820 100644
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
+	u32 timeout_us = 1000, sleep_us = 10;
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
+	timeout_us = 1000;
+	sleep_us = 10;
 
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

