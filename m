Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DB0C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DCC206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SfD1VgTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgCZNpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:45:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34736 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgCZNp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:45:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id 65so7912669wrl.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 06:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/+yRgmnGZVSZp6x2Og5KbLuzZTmkQMHFsn5IdENH0xo=;
        b=SfD1VgTJ41hRjtk+2zwtDcvVSqRHhtZIpO/6z0iWJuLsemqzc7nrs4PL21FztrH6OG
         oSAhpDy4RDJE87y9GHyjUwFHlTe3G+kucbEryCcU1e7WFenhQN/8ACLMQmWgrejPsbTb
         cauBQxi+wIYgmhk/mK3pRWO+B3yQzlC0QTMcckePHIkFb/gUGLuphx+x5UZpG84euGSF
         gTxBqL1HJDv5fBekyxqPboVHGHoIWw1mfFDzq+0dDxZ/zN4yHOMx0uTb0ODyPDXGMi5R
         /Tr99cGxUciuDI4A/ff4MfMWbAsD86/TpZGtykWC1yihYxFEfWGiOFHvGEOSW7aQoNFJ
         QIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/+yRgmnGZVSZp6x2Og5KbLuzZTmkQMHFsn5IdENH0xo=;
        b=E/7CX6cwhHeFm11pexBAMaNU4oeQkTWioANJR7MDnhrJ0jCqXLF0I03efE0pqCNOhD
         fxIxhqtwyjuR0knwlw3vJJYHaP608CGaVXYcWo2mpWHnqqBsLUEtx7qDzGvaB9hzmmnG
         J6b+vVVy73+PImWGL87wRK3D0UXOQuoQt70nEgvOHxTPfizcvuEKqYA/5Hvsl3BK48XY
         V21yRy7oONiRRuZnwbeGucJMcyAeEzI6qjdWLTbQbjHVOICjxu2An9GjTLDp1/JkV+VZ
         3g445aTslLRP9J9lpO8RkOsgQ7bMwaQYWcYiDFdaWHR9NmWi+7yWQR7RgOwBalMX74pT
         6QMw==
X-Gm-Message-State: ANhLgQ2XLqzRbVVf4k9iBJAbOPjAustyVeUthbBf/ED2QtoJAxHOYyTH
        kpqMM9/ycYf6aZYntNWFi2A8zw==
X-Google-Smtp-Source: ADFU+vsKPRT6a8OC21J5nNuwT6DO29oduL+GmiE3jhzC87z4OtUR5LDXiMgF2U6M34pXoGgMANp9Zg==
X-Received: by 2002:adf:b35d:: with SMTP id k29mr9627430wrd.239.1585230327044;
        Thu, 26 Mar 2020 06:45:27 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id h29sm4079617wrc.64.2020.03.26.06.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 06:45:26 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 12/14] usb: dwc3: of-simple: remove Amlogic GXL and AXG compatibles
Date:   Thu, 26 Mar 2020 14:45:04 +0100
Message-Id: <20200326134507.4808-13-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200326134507.4808-1-narmstrong@baylibre.com>
References: <20200326134507.4808-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

There is now a dedicated driver for these SoCs making the old compatible
obsolete.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index e64754be47b4..8852fbfdead4 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -27,7 +27,6 @@ struct dwc3_of_simple {
 	struct clk_bulk_data	*clks;
 	int			num_clocks;
 	struct reset_control	*resets;
-	bool			pulse_resets;
 	bool			need_reset;
 };
 
@@ -38,7 +37,6 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 	struct device_node	*np = dev->of_node;
 
 	int			ret;
-	bool			shared_resets = false;
 
 	simple = devm_kzalloc(dev, sizeof(*simple), GFP_KERNEL);
 	if (!simple)
@@ -54,13 +52,7 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3"))
 		simple->need_reset = true;
 
-	if (of_device_is_compatible(np, "amlogic,meson-axg-dwc3") ||
-	    of_device_is_compatible(np, "amlogic,meson-gxl-dwc3")) {
-		shared_resets = true;
-		simple->pulse_resets = true;
-	}
-
-	simple->resets = of_reset_control_array_get(np, shared_resets, true,
+	simple->resets = of_reset_control_array_get(np, false, true,
 						    true);
 	if (IS_ERR(simple->resets)) {
 		ret = PTR_ERR(simple->resets);
@@ -68,15 +60,9 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (simple->pulse_resets) {
-		ret = reset_control_reset(simple->resets);
-		if (ret)
-			goto err_resetc_put;
-	} else {
-		ret = reset_control_deassert(simple->resets);
-		if (ret)
-			goto err_resetc_put;
-	}
+	ret = reset_control_deassert(simple->resets);
+	if (ret)
+		goto err_resetc_put;
 
 	ret = clk_bulk_get_all(simple->dev, &simple->clks);
 	if (ret < 0)
@@ -102,8 +88,7 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 	clk_bulk_put_all(simple->num_clocks, simple->clks);
 
 err_resetc_assert:
-	if (!simple->pulse_resets)
-		reset_control_assert(simple->resets);
+	reset_control_assert(simple->resets);
 
 err_resetc_put:
 	reset_control_put(simple->resets);
@@ -118,8 +103,7 @@ static void __dwc3_of_simple_teardown(struct dwc3_of_simple *simple)
 	clk_bulk_put_all(simple->num_clocks, simple->clks);
 	simple->num_clocks = 0;
 
-	if (!simple->pulse_resets)
-		reset_control_assert(simple->resets);
+	reset_control_assert(simple->resets);
 
 	reset_control_put(simple->resets);
 
@@ -191,8 +175,6 @@ static const struct of_device_id of_dwc3_simple_match[] = {
 	{ .compatible = "xlnx,zynqmp-dwc3" },
 	{ .compatible = "cavium,octeon-7130-usb-uctl" },
 	{ .compatible = "sprd,sc9860-dwc3" },
-	{ .compatible = "amlogic,meson-axg-dwc3" },
-	{ .compatible = "amlogic,meson-gxl-dwc3" },
 	{ .compatible = "allwinner,sun50i-h6-dwc3" },
 	{ /* Sentinel */ }
 };
-- 
2.22.0

