Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8739C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A454920780
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mRTd94CV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgDQSlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728801AbgDQSlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:41:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECDAC061A0C;
        Fri, 17 Apr 2020 11:41:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x25so3929893wmc.0;
        Fri, 17 Apr 2020 11:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HhRrcSbzdrYOhGIkbng34xs3uvw4GEDIaENc9GUahfI=;
        b=mRTd94CVe3OP71yIcqIkEo4fR/JzFwnwJ3xI98No421tTKrDWiDH0OxlBm6fIC3mHL
         tAp/JQFabJ0VMJe63sveMQciuu/CsEggJklaxNqt1nTCUVGI8G1VyvgSr6QBvsw+vp1j
         yDf+t8L1PCX0bfUj8RO3cv5cBDcyts76f1AoR/DC7QYD4QOHpf/DuW47NpP4YW2YzVla
         fLyb22Fm8XK/S0xfMrx2axzSWg84dDPk8HSiCWFDkYAHsQtqEoI5Ao8W2ntnssxoEi7o
         f4YMyUh+60Us+P15RDrtgs2fyA3jBvMmlKqKRsK9C3/MQbGRupQuKGRe22fYZ1f3wC0i
         CQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HhRrcSbzdrYOhGIkbng34xs3uvw4GEDIaENc9GUahfI=;
        b=V5WsJ+DQHvHjRGNX+4aALnGVMPiUS1JgEKOm6b5uAJR27wxR9v5M7TO4rki+4arjl9
         htJ3l5742k3SCRqxQoMpAnjIuI1J2PAgUPUI+mhCfpYGCrIdxBXSiY7178Ox7w0rQ39l
         HjwPTBYJ1KCg8GdQ5Sq3Av/oocg94GL826HoE/ig5WZEZE6PuI1UoHZB1g1/wfvaTAg6
         27uVoS6eTIUk8a3MQVrIp3WinSlYv1IsLCNlEaIqKPsos9MweyOtrrMqsu3DGz+7uzoQ
         ADB62FIn8BUqym3dPcQZXEVjk+tA5olYW0/LyO+fu8XsAqqpMuAk2QPrMEFIV57Vwmte
         0Bxg==
X-Gm-Message-State: AGi0Puayc8cVpVsLjWqYXOWgs6j2RF6O09xjaFFlvrYPZBtjodAPxOhU
        e75tc/1AVH+CdypymDLMAiY=
X-Google-Smtp-Source: APiQypLZVwsv1sUcu/VFJzhsLAmrPBJK+b+iI07XhRYdWUMc5S2KJK4PgA7rOE687BGjZMq4vKXOUw==
X-Received: by 2002:a1c:b684:: with SMTP id g126mr4491736wmf.163.1587148901133;
        Fri, 17 Apr 2020 11:41:41 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id c17sm33237391wrp.28.2020.04.17.11.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 11:41:40 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/4] clk: meson: meson8b: Fix the polarity of the RESET_N lines
Date:   Fri, 17 Apr 2020 20:41:25 +0200
Message-Id: <20200417184127.1319871-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200417184127.1319871-1-martin.blumenstingl@googlemail.com>
References: <20200417184127.1319871-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CLKC_RESET_VID_DIVIDER_CNTL_RESET_N_POST and
CLKC_RESET_VID_DIVIDER_CNTL_RESET_N_PRE are active low. This means:
- asserting them requires setting the register value to 0
- de-asserting them requires setting the register value to 1

Set the register value accordingly for these two reset lines by setting
the inverted the register value compared to all other reset lines.

Fixes: 189621726bc2f6 ("clk: meson: meson8b: register the built-in reset controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 79 ++++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 90d284ffc780..1dec8d5404a1 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -3506,54 +3506,87 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 static const struct meson8b_clk_reset_line {
 	u32 reg;
 	u8 bit_idx;
+	bool active_low;
 } meson8b_clk_reset_bits[] = {
 	[CLKC_RESET_L2_CACHE_SOFT_RESET] = {
-		.reg = HHI_SYS_CPU_CLK_CNTL0, .bit_idx = 30
+		.reg = HHI_SYS_CPU_CLK_CNTL0,
+		.bit_idx = 30,
+		.active_low = false,
 	},
 	[CLKC_RESET_AXI_64_TO_128_BRIDGE_A5_SOFT_RESET] = {
-		.reg = HHI_SYS_CPU_CLK_CNTL0, .bit_idx = 29
+		.reg = HHI_SYS_CPU_CLK_CNTL0,
+		.bit_idx = 29,
+		.active_low = false,
 	},
 	[CLKC_RESET_SCU_SOFT_RESET] = {
-		.reg = HHI_SYS_CPU_CLK_CNTL0, .bit_idx = 28
+		.reg = HHI_SYS_CPU_CLK_CNTL0,
+		.bit_idx = 28,
+		.active_low = false,
 	},
 	[CLKC_RESET_CPU3_SOFT_RESET] = {
-		.reg = HHI_SYS_CPU_CLK_CNTL0, .bit_idx = 27
+		.reg = HHI_SYS_CPU_CLK_CNTL0,
+		.bit_idx = 27,
+		.active_low = false,
 	},
 	[CLKC_RESET_CPU2_SOFT_RESET] = {
-		.reg = HHI_SYS_CPU_CLK_CNTL0, .bit_idx = 26
+		.reg = HHI_SYS_CPU_CLK_CNTL0,
+		.bit_idx = 26,
+		.active_low = false,
 	},
 	[CLKC_RESET_CPU1_SOFT_RESET] = {
-		.reg = HHI_SYS_CPU_CLK_CNTL0, .bit_idx = 25
+		.reg = HHI_SYS_CPU_CLK_CNTL0,
+		.bit_idx = 25,
+		.active_low = false,
 	},
 	[CLKC_RESET_CPU0_SOFT_RESET] = {
-		.reg = HHI_SYS_CPU_CLK_CNTL0, .bit_idx = 24
+		.reg = HHI_SYS_CPU_CLK_CNTL0,
+		.bit_idx = 24,
+		.active_low = false,
 	},
 	[CLKC_RESET_A5_GLOBAL_RESET] = {
-		.reg = HHI_SYS_CPU_CLK_CNTL0, .bit_idx = 18
+		.reg = HHI_SYS_CPU_CLK_CNTL0,
+		.bit_idx = 18,
+		.active_low = false,
 	},
 	[CLKC_RESET_A5_AXI_SOFT_RESET] = {
-		.reg = HHI_SYS_CPU_CLK_CNTL0, .bit_idx = 17
+		.reg = HHI_SYS_CPU_CLK_CNTL0,
+		.bit_idx = 17,
+		.active_low = false,
 	},
 	[CLKC_RESET_A5_ABP_SOFT_RESET] = {
-		.reg = HHI_SYS_CPU_CLK_CNTL0, .bit_idx = 16
+		.reg = HHI_SYS_CPU_CLK_CNTL0,
+		.bit_idx = 16,
+		.active_low = false,
 	},
 	[CLKC_RESET_AXI_64_TO_128_BRIDGE_MMC_SOFT_RESET] = {
-		.reg = HHI_SYS_CPU_CLK_CNTL1, .bit_idx = 30
+		.reg = HHI_SYS_CPU_CLK_CNTL1,
+		.bit_idx = 30,
+		.active_low = false,
 	},
 	[CLKC_RESET_VID_CLK_CNTL_SOFT_RESET] = {
-		.reg = HHI_VID_CLK_CNTL, .bit_idx = 15
+		.reg = HHI_VID_CLK_CNTL,
+		.bit_idx = 15,
+		.active_low = false,
 	},
 	[CLKC_RESET_VID_DIVIDER_CNTL_SOFT_RESET_POST] = {
-		.reg = HHI_VID_DIVIDER_CNTL, .bit_idx = 7
+		.reg = HHI_VID_DIVIDER_CNTL,
+		.bit_idx = 7,
+		.active_low = false,
 	},
 	[CLKC_RESET_VID_DIVIDER_CNTL_SOFT_RESET_PRE] = {
-		.reg = HHI_VID_DIVIDER_CNTL, .bit_idx = 3
+		.reg = HHI_VID_DIVIDER_CNTL,
+		.bit_idx = 3,
+		.active_low = false,
 	},
 	[CLKC_RESET_VID_DIVIDER_CNTL_RESET_N_POST] = {
-		.reg = HHI_VID_DIVIDER_CNTL, .bit_idx = 1
+		.reg = HHI_VID_DIVIDER_CNTL,
+		.bit_idx = 1,
+		.active_low = true,
 	},
 	[CLKC_RESET_VID_DIVIDER_CNTL_RESET_N_PRE] = {
-		.reg = HHI_VID_DIVIDER_CNTL, .bit_idx = 0
+		.reg = HHI_VID_DIVIDER_CNTL,
+		.bit_idx = 0,
+		.active_low = true,
 	},
 };
 
@@ -3562,22 +3595,22 @@ static int meson8b_clk_reset_update(struct reset_controller_dev *rcdev,
 {
 	struct meson8b_clk_reset *meson8b_clk_reset =
 		container_of(rcdev, struct meson8b_clk_reset, reset);
-	unsigned long flags;
 	const struct meson8b_clk_reset_line *reset;
+	unsigned int value = 0;
+	unsigned long flags;
 
 	if (id >= ARRAY_SIZE(meson8b_clk_reset_bits))
 		return -EINVAL;
 
 	reset = &meson8b_clk_reset_bits[id];
 
+	if (assert != reset->active_low)
+		value = BIT(reset->bit_idx);
+
 	spin_lock_irqsave(&meson_clk_lock, flags);
 
-	if (assert)
-		regmap_update_bits(meson8b_clk_reset->regmap, reset->reg,
-				   BIT(reset->bit_idx), BIT(reset->bit_idx));
-	else
-		regmap_update_bits(meson8b_clk_reset->regmap, reset->reg,
-				   BIT(reset->bit_idx), 0);
+	regmap_update_bits(meson8b_clk_reset->regmap, reset->reg,
+			   BIT(reset->bit_idx), value);
 
 	spin_unlock_irqrestore(&meson_clk_lock, flags);
 
-- 
2.26.1

