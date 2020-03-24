Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CCEC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E712208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IA5zfeR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgCXKU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:20:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39699 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbgCXKUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:20:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so8275363wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 03:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/+yRgmnGZVSZp6x2Og5KbLuzZTmkQMHFsn5IdENH0xo=;
        b=IA5zfeR049tZvKZYI8cq2z0elOrsbdBAOa6MzRPJSe+ht43wMcncI1KCc51x+ne47x
         oBBRwEWAyymb2BDcyHk7XhRMNz8w480OiAghggUEIRY9wTuyaX4AUC2WQfEXCwenUk84
         mtQC6p49r3bHe+TNnHplrGGLw+iDlI9XMqitMGZV/bZFwnlGksxwMDQ7cossooKC8AHn
         KF3+fH2Mpr+7canaq5zT2pikFQiK61DSJkgX39ExO2swh9DMfTG3b/UuGoCAkeubFSvf
         lLliiBXAlNxmljtOCHlYd8gbgUN2bIbk58pXLz3CchVWiFD16HiLnWHw8VAs8FRwUXXr
         KP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/+yRgmnGZVSZp6x2Og5KbLuzZTmkQMHFsn5IdENH0xo=;
        b=m0qcsqDnZvI1HfJQkimnRXNzo9J3nwbT9Olz8IUO9+Hdg/OWsfP3BbIwTZxZ6PZfqF
         vId6acUDxpI3Y9Hk9fccx8atZcJLjYV+zh0KC/JzPOaXDo8X11Yu75WFibfyQRRvtq5O
         pNNUAXUvMh9/9It/4aX0dxjpgOzGIK0V0QGks+VOrfUj6AKGhpPXkp6r1pz+j1Tr2s4S
         FVpwWOq1PQme3VDmoQ1J3nkYvqkEQ5OsT+GrenLW8oj/NeRtgXjIyk3wKpxEDQGbmZ66
         V5C+28Rv0fM6vJt9nvQ8jcErolkNrz1grtdxhDc55PG1kMOdRBueRghXpgWk/evZlfVY
         PTlA==
X-Gm-Message-State: ANhLgQ3vzR3lO6Ow9UKTyDNI+XBpk1yYCXf68vYhwX7jl9eEHEelliFb
        SLirife3+0Zy/gUp8a9QtI+/eQ==
X-Google-Smtp-Source: ADFU+vtvUBBxR2Sg0eSFzCOLuJ1X1wwwFy1YDkT2xiC/HpLU99Ebb8mRK3Li2BrG8iTbiPafoU4VSQ==
X-Received: by 2002:adf:e848:: with SMTP id d8mr14204896wrn.209.1585045252806;
        Tue, 24 Mar 2020 03:20:52 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id h5sm2879527wro.83.2020.03.24.03.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 03:20:52 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 11/13] usb: dwc3: of-simple: remove Amlogic GXL and AXG compatibles
Date:   Tue, 24 Mar 2020 11:20:28 +0100
Message-Id: <20200324102030.31000-12-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200324102030.31000-1-narmstrong@baylibre.com>
References: <20200324102030.31000-1-narmstrong@baylibre.com>
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

