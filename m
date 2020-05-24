Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D063FC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 09:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B207F207D8
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 09:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFZf9mZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387600AbgEXJzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 05:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgEXJzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 05:55:39 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B746BC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 02:55:38 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c11so15523780ljn.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 02:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=20J0Zyi7H89b27FZ6alPYdrkpj1cugpWlECqKNB+gFQ=;
        b=bFZf9mZ2MBOhnulImpT28rXFlgzoJGFfxPyvKwuuIggITayKLKjkPu3o5CcPYxqBqd
         iky4LyNIB3KbRxkmvI85TJXrXcE0AtZ3YFeNzS1/4sADd6gEQH5ABF99zkYRzsW9x08R
         K9U1qhArN1n7Pzd1EkHC56D9TEbHuiarvKyLk9u+DR1FFpxG4DW8UVEF1F8RqithbzIN
         +hKuYTHr6yX+UuZMaFYOQC/z/ATQbklW3mKuib/YFuuWD1X3KtR73D0dNnFZi3G1Gig4
         sYYFBsWnXtfXj8W8KmU2iRrvVoJXSRb/+WuAi0WE3fQWVBPmIu7MfmctPF+3XBWE3CJQ
         ay0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=20J0Zyi7H89b27FZ6alPYdrkpj1cugpWlECqKNB+gFQ=;
        b=TgifyO3IyAHa4lOjOzLsGq6nZNySEb2koxZyJGzzsnwwO6Q9ItWedCMyv4MhLBK/Bm
         lf78osYVuGDE3kVVuVZnqWxNE7IuAgdGtQ7p3F/xDnqMD3kabEpewFO/ATv+TMjU3i9M
         k6aIU7ktvKXaL0si5/Gy7OcndPYXClP6UM26gwp7H7pYJbBLS9kX2tuSezVILayOn9zA
         LCdR/cO74QDdS53+6L9DTDAtiyDmJToYJEwrmS6rY07UedCEX/4vp0pAuw7QVbZUnyGu
         WEOag8yFzxwQWzDDaQwe9CEowuD/Id/lHbmr3FwnhzODegD9ro5jm+4WL/1IaEXAtAxu
         sEFg==
X-Gm-Message-State: AOAM532F25frm1wVHd/YSEnp9EmTcUx+NC2sUS+hto0IEMWH5kEIyD5p
        YYX453SxPPuW8HXMqlR5fKs=
X-Google-Smtp-Source: ABdhPJzzyaGMN/yo9AQ7CQjqS/6PO21Bn4HTS/xLMf+oJ5yJO/d27WKDICYfTrXYjFR/BoKck1jvxQ==
X-Received: by 2002:a2e:854d:: with SMTP id u13mr8876248ljj.295.1590314137244;
        Sun, 24 May 2020 02:55:37 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id 72sm2153576lfa.52.2020.05.24.02.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 02:55:36 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Jyri Sarha <jsarha@ti.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 2/2]  phy: ti: j721e-wiz: Constify structs
Date:   Sun, 24 May 2020 11:55:16 +0200
Message-Id: <20200524095516.25227-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200524095516.25227-1-rikard.falkeborn@gmail.com>
References: <20200524095516.25227-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_div_table and wiz_regmap_config are not modified and can therefore
be made const to allow the compiler to put them in read-only memory.

Before:
   text    data     bss     dec     hex filename
  20265    7044      64   27373    6aed drivers/phy/ti/phy-j721e-wiz.o

After:
   text    data     bss     dec     hex filename
  20649    6660      64   27373    6aed drivers/phy/ti/phy-j721e-wiz.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 30ea5b207285..33c4cf0105a4 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -117,7 +117,7 @@ struct wiz_clk_mux {
 struct wiz_clk_divider {
 	struct clk_hw		hw;
 	struct regmap_field	*field;
-	struct clk_div_table	*table;
+	const struct clk_div_table	*table;
 	struct clk_init_data	clk_data;
 };
 
@@ -131,7 +131,7 @@ struct wiz_clk_mux_sel {
 
 struct wiz_clk_div_sel {
 	struct regmap_field	*field;
-	struct clk_div_table	*table;
+	const struct clk_div_table	*table;
 	const char		*node_name;
 };
 
@@ -173,7 +173,7 @@ static struct wiz_clk_mux_sel clk_mux_sel_10g[] = {
 	},
 };
 
-static struct clk_div_table clk_div_table[] = {
+static const struct clk_div_table clk_div_table[] = {
 	{ .val = 0, .div = 1, },
 	{ .val = 1, .div = 2, },
 	{ .val = 2, .div = 4, },
@@ -559,7 +559,7 @@ static const struct clk_ops wiz_clk_div_ops = {
 
 static int wiz_div_clk_register(struct wiz *wiz, struct device_node *node,
 				struct regmap_field *field,
-				struct clk_div_table *table)
+				const struct clk_div_table *table)
 {
 	struct device *dev = wiz->dev;
 	struct wiz_clk_divider *div;
@@ -756,7 +756,7 @@ static const struct reset_control_ops wiz_phy_reset_ops = {
 	.deassert = wiz_phy_reset_deassert,
 };
 
-static struct regmap_config wiz_regmap_config = {
+static const struct regmap_config wiz_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-- 
2.26.2

