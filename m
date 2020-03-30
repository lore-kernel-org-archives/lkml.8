Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F5DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5CB206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EejkddiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbgC3WLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:11:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36804 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbgC3WLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:11:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so23568696wrs.3;
        Mon, 30 Mar 2020 15:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MdDlaK3jLN/q9KcoyP33Chc7uvr3eCaMbY+7EESj0As=;
        b=EejkddiJCEPU8jCPYEqGgLrI766UTSVP81xsECLV/sI5ZxSNQI+IBeTYqywvQiQwpd
         jizrNf5HboqfV1xdwyv9bR/1B+GDxkQ/oNit9/Cz/4jFBonU7K4TuFHcUmoRDocz77mZ
         A7nfupQ7qilNBOA/PiQxGhiDHCtPuLDrMB+89iaatZlN1RkKwVLJRtgLbPFHII9JZOsV
         Fo/5pJ2w8Dx3lBz3om4roa1BHfL+JgvG86CwfM730MoQBABygMPLBBCbC3MMQoLrbZb7
         /Gt4dwYUFDL8WRM5vsLMdpPIByS7GMShGaFjei5C5xaHLoQ9A1YxmbqURvF4UpI5omsn
         Pv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MdDlaK3jLN/q9KcoyP33Chc7uvr3eCaMbY+7EESj0As=;
        b=hLr4YqLL6+DQAXwwilAMgCo7PPNWZydg8/Sis7QeBQbcupO9ENiPf7DzM32E/cdRnF
         Q9ijughANSFoseBBUgcrfjcb0MdXsLDZ7/3gOB3VOXfZJhn1CTYS+/INeV+8d6RHy6He
         W5d+KlOi02fCbj0rnrL7O1x1NK/eSiDZE31ZjDqz3Du8esnVyYIpTPTGzWXuiwRVIXqx
         1MNNsdWqn/ZtKckbP5ynAZ3MUprYqN2UhEOx1ntflXmuIB0uNujJ4gK5Uc3e4+JAeFp/
         sCr9FgMvKLAFGObkIw61hDNpjhSSyfiQNDxmPHi1N8ND8A+HYN8nyEpDv3uahiiEJGUu
         HLSw==
X-Gm-Message-State: ANhLgQ17ywB+7M9OiPC2jTuGQjwpNx3inPLoRUh04x7RoYw+h+OyYVdt
        jUnkfQ1SZSrwDhe5P8UlfvE=
X-Google-Smtp-Source: ADFU+vvgELv6WlxBfdmfHasYH7xckVLjjI/gfkH1djbfjyg5T6s6EazSzp1kVoD4jaIVPog2bhKWUQ==
X-Received: by 2002:a5d:5228:: with SMTP id i8mr17301089wra.156.1585606290341;
        Mon, 30 Mar 2020 15:11:30 -0700 (PDT)
Received: from localhost.localdomain (p200300F13710ED00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3710:ed00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b187sm1260509wmc.14.2020.03.30.15.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 15:11:29 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        jbrunet@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC v1 2/5] clk: meson: g12a: Prepare the GPU clock tree to change at runtime
Date:   Tue, 31 Mar 2020 00:11:01 +0200
Message-Id: <20200330221104.3163788-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200330221104.3163788-1-martin.blumenstingl@googlemail.com>
References: <20200330221104.3163788-1-martin.blumenstingl@googlemail.com>
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
Also populate set_rate requests from the divider to the mux so the GPU
clock frequency can be updated at runtime (which will be required for
GPU DVFS).

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

