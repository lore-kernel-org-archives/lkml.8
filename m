Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7809DC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4879220678
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599060997;
	bh=3L9tzl4u2+eRjqvvA0npofzQcIH6WAV2kMNA4WSIx8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lY32ESfD32VBnwbmOQF4d44xxSMgkZHHRcUlnP2mmr8E+B9yyRylX27j0AlQK9kno
	 6v20lHJZeK6R7/HatXMGBOaiYAcQMm3uW3zoKhe2tuaGmLYutRd1gHv68JkBlStv2a
	 FAKZtCHFmMNZPgcodtn3eX7iO9ttpuRRKm+c/SeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgIBPgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgIBPEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:04:15 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94941208DB;
        Wed,  2 Sep 2020 15:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599059055;
        bh=3L9tzl4u2+eRjqvvA0npofzQcIH6WAV2kMNA4WSIx8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQz17aiDJxWjN5u0gkMVHoT0kOpnx9Aw8d/3hmPayrgvGXvxNoPFYzUx0695et0Un
         xS6+vVBM76+LXioFjGMJIliKQWU0yIq2JlW9nbOIcyMQWSA0E5CQ45IbU3z8ulp7Fm
         wQD2L4S/Wtec4RA/wK5mIpvp41++szi2OJq0PUM4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 04/10] clk: gpio: Simplify with dev_err_probe()
Date:   Wed,  2 Sep 2020 17:03:42 +0200
Message-Id: <20200902150348.14465-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902150348.14465-1-krzk@kernel.org>
References: <20200902150348.14465-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/clk-gpio.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 38755a241ab7..a3cc53edcb11 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -199,7 +199,6 @@ static int gpio_clk_driver_probe(struct platform_device *pdev)
 	struct gpio_desc *gpiod;
 	struct clk_hw *hw;
 	bool is_mux;
-	int ret;
 
 	is_mux = of_device_is_compatible(node, "gpio-mux-clock");
 
@@ -211,17 +210,10 @@ static int gpio_clk_driver_probe(struct platform_device *pdev)
 
 	gpio_name = is_mux ? "select" : "enable";
 	gpiod = devm_gpiod_get(dev, gpio_name, GPIOD_OUT_LOW);
-	if (IS_ERR(gpiod)) {
-		ret = PTR_ERR(gpiod);
-		if (ret == -EPROBE_DEFER)
-			pr_debug("%pOFn: %s: GPIOs not yet available, retry later\n",
-					node, __func__);
-		else
-			pr_err("%pOFn: %s: Can't get '%s' named GPIO property\n",
-					node, __func__,
-					gpio_name);
-		return ret;
-	}
+	if (IS_ERR(gpiod))
+		return dev_err_probe(dev, PTR_ERR(gpiod),
+				     "%pOFn: Can't get '%s' named GPIO property\n",
+				     node, gpio_name);
 
 	if (is_mux)
 		hw = clk_hw_register_gpio_mux(dev, gpiod);
-- 
2.17.1

