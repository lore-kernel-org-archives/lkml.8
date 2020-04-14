Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9F6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EDE02074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bS3/ROK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505233AbgDNTwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391640AbgDNTvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:51:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD36C061A41;
        Tue, 14 Apr 2020 12:51:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so15675050wma.4;
        Tue, 14 Apr 2020 12:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=buqvW+rh8aGkpkt6IACKm4M4fmbaWcmA3j17X8abtHA=;
        b=bS3/ROK/sffJXwV2Rj/G7kYPdJZgF8fmwMTwrUtrs4+TIJR2cD/R+dEM9aVovzLVRM
         pzi6C1aISUmH8ksCMqc3gm92h6/1Uq8KKn0Ypay5lSIl6V0owSap/QGLjCyAEDMtl9o6
         SvQfNryeGB2JDGc2JKmDQnnlG9ddJz20U/gsG38nHZiN4+dklzXWfw6u103Bhu/aYtaf
         fCQxZFaTuYaQkzteOC0UIk22jXkpuYCJ6YawiGWnZMX2ABBTggi9qPxxFLTGK17AQK6H
         IDjnwSBJg3aGm5n9ZaxVo+Ni4nS3685k7fXE8zp2to0b41sTjZWj6gWmZv4f6Y1CAxKC
         KI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=buqvW+rh8aGkpkt6IACKm4M4fmbaWcmA3j17X8abtHA=;
        b=DUg7+C+PbZMtyN5Kfzk2QaGjdYEniydwpv6RGVNufp11q9V8MB4RVmMX75J6peI9s9
         4sk0yucc4VVKw+ymzleA3OCu+WG2XuBB/xFriDQrHgoFdDKcyfgf0w2frSWX0kYsxAkF
         /ARkLO89nWnL46Uo0UiOpup0acKN2fvjMahSl9KJBk6f+Tbe95eNgLEMwIV4jz5dSX3N
         NOIfW+Z5j+qbwJnGgJFvGDSIeZpKvZ5iJbJ75AN5sBJpUlHIC5CZmBJiUU5BYuGMdSvm
         P3v2SxZgq8QMaB+oqW9c20ZOwyBMH8UfeB5+Hn64kr4EhYD873nmKu49LOsAYyAtr7GH
         heOQ==
X-Gm-Message-State: AGi0PuaCl8WBVvBPHy2G0PgyJySXGJfvf0B7h04mao7wUkU2N3CDA1pD
        SqX1z5qqJwq1U39xqFsBloY=
X-Google-Smtp-Source: APiQypK10yXfw/ApupMZEh8RomMmpTZfJoDiWwllfVAKE0XMN2fASSf+G5DjYOUuv0o/FowDJZafKQ==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr1544202wmc.83.1586893877796;
        Tue, 14 Apr 2020 12:51:17 -0700 (PDT)
Received: from localhost.localdomain (p200300F13717DF00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3717:df00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id s14sm20886844wme.33.2020.04.14.12.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 12:51:17 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/2] clk: meson: gxbb: Prepare the GPU clock tree to change at runtime
Date:   Tue, 14 Apr 2020 21:50:30 +0200
Message-Id: <20200414195031.224021-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414195031.224021-1-martin.blumenstingl@googlemail.com>
References: <20200414195031.224021-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "mali_0" or "mali_1" clock trees should not be updated while the
clock is running. Enforce this by setting CLK_SET_RATE_GATE on the
"mali_0" and "mali_1" gates. This makes the CCF switch to the "mali_1"
tree when "mali_0" is currently active and vice versa, which is exactly
what the vendor driver does when updating the frequency of the mali
clock.
Also propagate set_rate requests from the gate to the divider and from
the divider to the the mux so the GPU clock frequency can be updated at
runtime (which will be required for GPU DVFS). Don't propagate rate
changes to the mux parents because we don't want to change the MPLL
clocks (these are reserved for audio).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/gxbb.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 5fd6a574f8c3..0a68af6eec3d 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -957,7 +957,9 @@ static struct clk_regmap gxbb_sar_adc_clk = {
 
 /*
  * The MALI IP is clocked by two identical clocks (mali_0 and mali_1)
- * muxed by a glitch-free switch.
+ * muxed by a glitch-free switch. The CCF can manage this glitch-free
+ * mux because it does top-to-bottom updates the each clock tree and
+ * switches to the "inactive" one when CLK_SET_RATE_GATE is set.
  */
 
 static const struct clk_parent_data gxbb_mali_0_1_parent_data[] = {
@@ -980,14 +982,15 @@ static struct clk_regmap gxbb_mali_0_sel = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mali_0_sel",
 		.ops = &clk_regmap_mux_ops,
-		/*
-		 * bits 10:9 selects from 8 possible parents:
-		 * xtal, gp0_pll, mpll2, mpll1, fclk_div7,
-		 * fclk_div4, fclk_div3, fclk_div5
-		 */
 		.parent_data = gxbb_mali_0_1_parent_data,
 		.num_parents = 8,
-		.flags = CLK_SET_RATE_NO_REPARENT,
+		/*
+		 * Don't request the parent to change the rate because
+		 * all GPU frequencies can be derived from the fclk_*
+		 * clocks and one special GP0_PLL setting. This is
+		 * important because we need the MPLL clocks for audio.
+		 */
+		.flags = 0,
 	},
 };
 
@@ -1004,7 +1007,7 @@ static struct clk_regmap gxbb_mali_0_div = {
 			&gxbb_mali_0_sel.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_NO_REPARENT,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -1020,7 +1023,7 @@ static struct clk_regmap gxbb_mali_0 = {
 			&gxbb_mali_0_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -1033,14 +1036,15 @@ static struct clk_regmap gxbb_mali_1_sel = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mali_1_sel",
 		.ops = &clk_regmap_mux_ops,
-		/*
-		 * bits 10:9 selects from 8 possible parents:
-		 * xtal, gp0_pll, mpll2, mpll1, fclk_div7,
-		 * fclk_div4, fclk_div3, fclk_div5
-		 */
 		.parent_data = gxbb_mali_0_1_parent_data,
 		.num_parents = 8,
-		.flags = CLK_SET_RATE_NO_REPARENT,
+		/*
+		 * Don't request the parent to change the rate because
+		 * all GPU frequencies can be derived from the fclk_*
+		 * clocks and one special GP0_PLL setting. This is
+		 * important because we need the MPLL clocks for audio.
+		 */
+		.flags = 0,
 	},
 };
 
@@ -1057,7 +1061,7 @@ static struct clk_regmap gxbb_mali_1_div = {
 			&gxbb_mali_1_sel.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_NO_REPARENT,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -1073,7 +1077,7 @@ static struct clk_regmap gxbb_mali_1 = {
 			&gxbb_mali_1_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -1093,7 +1097,7 @@ static struct clk_regmap gxbb_mali = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = gxbb_mali_parent_hws,
 		.num_parents = 2,
-		.flags = CLK_SET_RATE_NO_REPARENT,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
-- 
2.26.0

