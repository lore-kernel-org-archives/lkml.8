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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF18BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A2F206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EtkFVJ4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391662AbgDNTwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391637AbgDNTvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:51:20 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E9EC0610D5;
        Tue, 14 Apr 2020 12:51:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a81so15661315wmf.5;
        Tue, 14 Apr 2020 12:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wmfcMhvG8Z0vEINCyaO7pmox4TkBpgd1lx9zOICoTqE=;
        b=EtkFVJ4P6kPq5zDhchMj44e/ao7tDFLAS5fHqVSp67Vc69oau+0lapCkGg4FAIEK0Y
         3FwfBUpis4d+hn4MaQNoyQBYMD1RzN/d7yIslSCMyjynMvOsCK3htGSvk4XqFeC4X/wx
         Ng74LeujzCDpUAcRKt9CGQw99YaEJdmHfcppaoRR7H8krAU5zuB6vga4msDAkdoKqgO9
         AvuMS8NRgieEf/lICbyIfw7UrGkFiJvFPJvRPLYgJMxXl2KfNjOYKmHwDvRh79gARiHM
         ac7Y9lL/7d0CiyZHui9LyXZ5U43j7xh/hXw2H6xTd9SkY/I/KkrKa1zkwgoCosFqrk2U
         jTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wmfcMhvG8Z0vEINCyaO7pmox4TkBpgd1lx9zOICoTqE=;
        b=ABWPnGHK0ls3iMNHOa58zUpB3EUm5BQP+b6MCEapykVFd5y01lH+R+ZPi6byA0gxKY
         R7tWD/c2wRU89hkIMRtvvYlqysalNMZkBu760GcybPniHTGIptlF1pxfRSMKQhcWW5IY
         IU6RR1myGZMACK3qhuACK8JdmCuMW1e7LtHul/CxsdZzl+NKWvIGzHB8iB8fkgsx4yjG
         ZEAouu5uk9qGwT1UHrLbsoUjrFv6LRFhVZWb5p8g5/9L8dgoNCc/VKu/JEcciU38rLO8
         i8zJwPd00/V1Wi/rJyiHA9TCh9XZwb8fEC97VV8ekeJ/cRpbPd7H0TmjskIGi2oWoczO
         sm1g==
X-Gm-Message-State: AGi0PuYcRfvllVPbJj/r1NwOThrgcXUTRA/ot+LqD5T1+TITKUnSgEZx
        uQQi3qKSexCRR4islLxe7rmaSX6nLJM=
X-Google-Smtp-Source: APiQypIRkBwsxASMLC6HHXJ5UwuAZ6o8hDlK7RWcSFluHkg0o2JANop6K6rTzyBdwrXR4xh1aml9rQ==
X-Received: by 2002:a1c:e1c1:: with SMTP id y184mr1450299wmg.143.1586893878852;
        Tue, 14 Apr 2020 12:51:18 -0700 (PDT)
Received: from localhost.localdomain (p200300F13717DF00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3717:df00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id s14sm20886844wme.33.2020.04.14.12.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 12:51:18 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/2] clk: meson: g12a: Prepare the GPU clock tree to change at runtime
Date:   Tue, 14 Apr 2020 21:50:31 +0200
Message-Id: <20200414195031.224021-3-martin.blumenstingl@googlemail.com>
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
 drivers/clk/meson/g12a.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index fad616cac01e..30c15766ebb1 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -3702,7 +3702,9 @@ static struct clk_regmap g12a_hdmi = {
 
 /*
  * The MALI IP is clocked by two identical clocks (mali_0 and mali_1)
- * muxed by a glitch-free switch.
+ * muxed by a glitch-free switch. The CCF can manage this glitch-free
+ * mux because it does top-to-bottom updates the each clock tree and
+ * switches to the "inactive" one when CLK_SET_RATE_GATE is set.
  */
 static const struct clk_parent_data g12a_mali_0_1_parent_data[] = {
 	{ .fw_name = "xtal", },
@@ -3726,7 +3728,13 @@ static struct clk_regmap g12a_mali_0_sel = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_data = g12a_mali_0_1_parent_data,
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
 
@@ -3743,7 +3751,7 @@ static struct clk_regmap g12a_mali_0_div = {
 			&g12a_mali_0_sel.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_NO_REPARENT,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -3759,7 +3767,7 @@ static struct clk_regmap g12a_mali_0 = {
 			&g12a_mali_0_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -3774,7 +3782,13 @@ static struct clk_regmap g12a_mali_1_sel = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_data = g12a_mali_0_1_parent_data,
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
 
@@ -3791,7 +3805,7 @@ static struct clk_regmap g12a_mali_1_div = {
 			&g12a_mali_1_sel.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_NO_REPARENT,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -3807,7 +3821,7 @@ static struct clk_regmap g12a_mali_1 = {
 			&g12a_mali_1_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -3827,7 +3841,7 @@ static struct clk_regmap g12a_mali = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = g12a_mali_parent_hws,
 		.num_parents = 2,
-		.flags = CLK_SET_RATE_NO_REPARENT,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
-- 
2.26.0

