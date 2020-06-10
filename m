Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C683EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97AED2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WrCVnVG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgFJIaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgFJIaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:30:21 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589BEC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 01:30:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so1227869wrc.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 01:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lPp6VqQcy0iQsfloe6knT20Y8DJvmbq6mVjmcioSaQ8=;
        b=WrCVnVG5q5Fywz83luKZPdKhNAMMt74TBo3j5w35tQ6k35gB80ABhyYXmFImzBEzzX
         uEBYq3Pn1lKubN+5j9bvpRK201nqTDdgrmqjmVrkpAwGJrtcB5J8lFRAoYdfRKQ6vIhV
         ZLZ4a7ZZlVlnFNkdCJiARAP+Jrjn9EpcljWSTHTUAz8cyVdMU1ytmnrTJb4MYbwIKDim
         F2zHhJCOaojRj0gXor65QgLghbwE5ueLnEuBTGUjbeR06TbX70h0QFZ0DNx4/kX1gMlJ
         5uoel/rDosIB0hghoGbEdprLyuRVyvEfNdK5RTh3YY0aH1c8vQ2wzhSxvyD4/Uk9bYNV
         8xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lPp6VqQcy0iQsfloe6knT20Y8DJvmbq6mVjmcioSaQ8=;
        b=AqW+L8RccfqQd8C3mcl14ThD9cajmwCT22XMIB6KYJ8mTeSY9Bb9HDDVsbgKgn8cx1
         4LJPJtRSQsvBIX8X/T0creYElrjqKYVmuPvf/mZJfuq57qCj3s8FsWB1ephOLTa7khYh
         Q/B1+KJFNAvsyh/ZCfWaxuvLLp4yxkBvkWJheh7rQbI5tTrDpVo9dfcRys1GOUzUIidP
         OeQ9PgBQghmN4nu/A9Lp+xLUr8j6LSUWnAHmCGCRBCWo3z9Ia9lWOd0oJY5O+QXGKR0P
         HoA3NlvZ1Mx4/mGwrccGsP4leeekMTLhHqgl4w5kxLqxb7lIffuGxSCfIJMF5BzyvrIv
         DBjw==
X-Gm-Message-State: AOAM5320Sh/CN/3msoDVHC38hd3mjoOtjM6EPB4KvjpQEkaI5otXpd4j
        6IqmKfEbBUrpteR+RCThMlyJOA==
X-Google-Smtp-Source: ABdhPJx94NKyXsKDcnV10IsqMYYY6faUswz/JNOerG8XPvisIU+VVaRhnwMUZi7QGcCrQRQ0u+fNrw==
X-Received: by 2002:a5d:4e88:: with SMTP id e8mr2432582wru.188.1591777818862;
        Wed, 10 Jun 2020 01:30:18 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:22:5867:d2c6:75f4])
        by smtp.gmail.com with ESMTPSA id u13sm6958974wrp.53.2020.06.10.01.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 01:30:18 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dmitry Shmidt <dimitrysh@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] clk: meson: g12a: Add support for NNA CLK source clocks
Date:   Wed, 10 Jun 2020 10:30:12 +0200
Message-Id: <20200610083012.5024-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200610083012.5024-1-narmstrong@baylibre.com>
References: <20200610083012.5024-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Shmidt <dimitrysh@google.com>

This adds the Neural Network Accelerator source clocks hierarchy, it's
2 simple composite clocks to feed the AXI interface and the Core of
the Neural Network Accelerator IP.

This IP is only present on the Amlogic SM1 SoCs family.

Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/g12a.c | 119 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h |   7 ++-
 2 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 30c15766ebb1..9803d44bb157 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -3981,6 +3981,113 @@ static struct clk_regmap g12a_spicc1_sclk = {
 	},
 };
 
+/* Neural Network Accelerator source clock */
+
+static const struct clk_parent_data nna_clk_parent_data[] = {
+	{ .fw_name = "xtal", },
+	{ .hw = &g12a_gp0_pll.hw, },
+	{ .hw = &g12a_hifi_pll.hw, },
+	{ .hw = &g12a_fclk_div2p5.hw, },
+	{ .hw = &g12a_fclk_div3.hw, },
+	{ .hw = &g12a_fclk_div4.hw, },
+	{ .hw = &g12a_fclk_div5.hw, },
+	{ .hw = &g12a_fclk_div7.hw },
+};
+
+static struct clk_regmap sm1_nna_axi_clk_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_NNA_CLK_CNTL,
+		.mask = 7,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "nna_axi_clk_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = nna_clk_parent_data,
+		.num_parents = ARRAY_SIZE(nna_clk_parent_data),
+	},
+};
+
+static struct clk_regmap sm1_nna_axi_clk_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_NNA_CLK_CNTL,
+		.shift = 0,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "nna_axi_clk_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&sm1_nna_axi_clk_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap sm1_nna_axi_clk = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_NNA_CLK_CNTL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "nna_axi_clk",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&sm1_nna_axi_clk_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap sm1_nna_core_clk_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_NNA_CLK_CNTL,
+		.mask = 7,
+		.shift = 25,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "nna_core_clk_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = nna_clk_parent_data,
+		.num_parents = ARRAY_SIZE(nna_clk_parent_data),
+	},
+};
+
+static struct clk_regmap sm1_nna_core_clk_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_NNA_CLK_CNTL,
+		.shift = 16,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "nna_core_clk_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&sm1_nna_core_clk_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap sm1_nna_core_clk = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_NNA_CLK_CNTL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "nna_core_clk",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&sm1_nna_core_clk_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 #define MESON_GATE(_name, _reg, _bit) \
 	MESON_PCLK(_name, _reg, _bit, &g12a_clk81.hw)
 
@@ -4779,6 +4886,12 @@ static struct clk_hw_onecell_data sm1_hw_onecell_data = {
 		[CLKID_SPICC1_SCLK_SEL]		= &g12a_spicc1_sclk_sel.hw,
 		[CLKID_SPICC1_SCLK_DIV]		= &g12a_spicc1_sclk_div.hw,
 		[CLKID_SPICC1_SCLK]		= &g12a_spicc1_sclk.hw,
+		[CLKID_NNA_AXI_CLK_SEL]		= &sm1_nna_axi_clk_sel.hw,
+		[CLKID_NNA_AXI_CLK_DIV]		= &sm1_nna_axi_clk_div.hw,
+		[CLKID_NNA_AXI_CLK]		= &sm1_nna_axi_clk.hw,
+		[CLKID_NNA_CORE_CLK_SEL]	= &sm1_nna_core_clk_sel.hw,
+		[CLKID_NNA_CORE_CLK_DIV]	= &sm1_nna_core_clk_div.hw,
+		[CLKID_NNA_CORE_CLK]		= &sm1_nna_core_clk.hw,
 		[NR_CLKS]			= NULL,
 	},
 	.num = NR_CLKS,
@@ -5020,6 +5133,12 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
 	&g12a_spicc1_sclk_sel,
 	&g12a_spicc1_sclk_div,
 	&g12a_spicc1_sclk,
+	&sm1_nna_axi_clk_sel,
+	&sm1_nna_axi_clk_div,
+	&sm1_nna_axi_clk,
+	&sm1_nna_core_clk_sel,
+	&sm1_nna_core_clk_div,
+	&sm1_nna_core_clk,
 };
 
 static const struct reg_sequence g12a_init_regs[] = {
diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
index a8852556836e..69b6a69549c7 100644
--- a/drivers/clk/meson/g12a.h
+++ b/drivers/clk/meson/g12a.h
@@ -70,6 +70,7 @@
 #define HHI_MALI_CLK_CNTL		0x1b0
 #define HHI_VPU_CLKC_CNTL		0x1b4
 #define HHI_VPU_CLK_CNTL		0x1bC
+#define HHI_NNA_CLK_CNTL		0x1C8
 #define HHI_HDMI_CLK_CNTL		0x1CC
 #define HHI_VDEC_CLK_CNTL		0x1E0
 #define HHI_VDEC2_CLK_CNTL		0x1E4
@@ -259,8 +260,12 @@
 #define CLKID_SPICC0_SCLK_DIV			257
 #define CLKID_SPICC1_SCLK_SEL			259
 #define CLKID_SPICC1_SCLK_DIV			260
+#define CLKID_NNA_AXI_CLK_SEL			262
+#define CLKID_NNA_AXI_CLK_DIV			263
+#define CLKID_NNA_CORE_CLK_SEL			265
+#define CLKID_NNA_CORE_CLK_DIV			266
 
-#define NR_CLKS					262
+#define NR_CLKS					268
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/g12a-clkc.h>
-- 
2.22.0

