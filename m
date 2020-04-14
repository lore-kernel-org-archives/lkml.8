Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45014C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C3BB20644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVj3ydEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404820AbgDNDd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 23:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404802AbgDNDdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:33:50 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1BEC0A3BDC;
        Mon, 13 Apr 2020 20:33:50 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r4so5417338pgg.4;
        Mon, 13 Apr 2020 20:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cqkf7LycevmgLpVmZeBhW8pIulT8kk5Dc9E7315h7UE=;
        b=iVj3ydEAh62CBoXht/+aCOXhTYwDNNjnDe8lhYUYSTLwZ3LxeEis04wto1rgkhSlqW
         y1P2YjAtSwKkjjRRWTSI/ioYWE4LHNoG5PysOhGTkFbBP7RwgzBDbAMjMOKJ9n1FeqjZ
         b8ctz0UsvKDI3yl7lXuNwoVXDXHv/dTyEwpnuRB87YMIcchpYJfUnnipzL4eRz4xS21B
         61jRmdLVjsFqed24Wz31wb7p9uCnjN8eAN5ewfQ27nUH/HeZ9d3gEz5aRmK3Nc+rGdqb
         XdH+mzOKu6aztqb1i6rMGiyrvHgyUw8rVdtF1k8DwlHUS2xk1YcM3XzFoaGvBqDQ/a3k
         K29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cqkf7LycevmgLpVmZeBhW8pIulT8kk5Dc9E7315h7UE=;
        b=axHrTbHCVOgq7uh98p96Cm9LY0G1yH55HFSnEJlXTXFT3BfPuOTWE/tZWcF4eDskg0
         56YftB2MyL3E5FuSCRoLblbrZyUo/oACN2pLNjWv0+rifS5pfBshKtngc0tsN5rKIgPo
         5KBsn8oUalcfJ1NEWxrwUqx1gLbq9GQS3+ug9CMlLnE5DhwB+UhAApnBep1pN9p2bEze
         7Nb+gC0T3UmeQ3nAgigCaG9kUFKzZ7SSO4yBnijTEnI7DO7bA+up44RH19422XJrdqba
         +EWGJxFjddemPxFyoqb2jt4EbYR+jEaATB0Kp2Nk77lcYcvxiJ6O/Opnzc6e+RNsZt2Q
         2ZNQ==
X-Gm-Message-State: AGi0Pub+95lwmRGJ9Wi06u55ZPCrEylsffUFnGb+cpRoq5W+55HUaEoN
        X5f2kwvICnLzAW8VlMT0wPE=
X-Google-Smtp-Source: APiQypIJziMZE+6YUsFjdE6JClcRXH7crwIdbG3eyClM6w5FDgQJQmSKAjEX7nGKilsRcmRUdNaCdg==
X-Received: by 2002:a63:eb15:: with SMTP id t21mr19840234pgh.279.1586835229655;
        Mon, 13 Apr 2020 20:33:49 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 140sm5612440pge.49.2020.04.13.20.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 20:33:49 -0700 (PDT)
From:   zhang.lyra@gmail.com
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v2 4/4] clk: sprd: add mipi_csi_xx gate clocks
Date:   Tue, 14 Apr 2020 11:33:25 +0800
Message-Id: <20200414033325.26536-5-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414033325.26536-1-zhang.lyra@gmail.com>
References: <20200414033325.26536-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

mipi_csi_xx clocks are used by camera sensors.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/clk/sprd/sc9863a-clk.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/clk/sprd/sc9863a-clk.c b/drivers/clk/sprd/sc9863a-clk.c
index a0631f7756cf..f67bd08f225c 100644
--- a/drivers/clk/sprd/sc9863a-clk.c
+++ b/drivers/clk/sprd/sc9863a-clk.c
@@ -1615,6 +1615,36 @@ static const struct sprd_clk_desc sc9863a_mm_gate_desc = {
 	.hw_clks	= &sc9863a_mm_gate_hws,
 };
 
+/* camera sensor clocks */
+static SPRD_GATE_CLK_HW(mipi_csi_clk, "mipi-csi-clk", &mahb_ckg_eb.common.hw,
+			0x20, BIT(16), 0, SPRD_GATE_NON_AON);
+static SPRD_GATE_CLK_HW(mipi_csi_s_clk, "mipi-csi-s-clk", &mahb_ckg_eb.common.hw,
+			0x24, BIT(16), 0, SPRD_GATE_NON_AON);
+static SPRD_GATE_CLK_HW(mipi_csi_m_clk, "mipi-csi-m-clk", &mahb_ckg_eb.common.hw,
+			0x28, BIT(16), 0, SPRD_GATE_NON_AON);
+
+static struct sprd_clk_common *sc9863a_mm_clk_clks[] = {
+	/* address base is 0x60900000 */
+	&mipi_csi_clk.common,
+	&mipi_csi_s_clk.common,
+	&mipi_csi_m_clk.common,
+};
+
+static struct clk_hw_onecell_data sc9863a_mm_clk_hws = {
+	.hws	= {
+		[CLK_MIPI_CSI]		= &mipi_csi_clk.common.hw,
+		[CLK_MIPI_CSI_S]	= &mipi_csi_s_clk.common.hw,
+		[CLK_MIPI_CSI_M]	= &mipi_csi_m_clk.common.hw,
+	},
+	.num	= CLK_MM_CLK_NUM,
+};
+
+static const struct sprd_clk_desc sc9863a_mm_clk_desc = {
+	.clk_clks	= sc9863a_mm_clk_clks,
+	.num_clk_clks	= ARRAY_SIZE(sc9863a_mm_clk_clks),
+	.hw_clks	= &sc9863a_mm_clk_hws,
+};
+
 static SPRD_SC_GATE_CLK_FW_NAME(sim0_eb,	"sim0-eb",	"ext-26m", 0x0,
 				0x1000, BIT(0), 0, 0);
 static SPRD_SC_GATE_CLK_FW_NAME(iis0_eb,	"iis0-eb",	"ext-26m", 0x0,
@@ -1737,6 +1767,8 @@ static const struct of_device_id sprd_sc9863a_clk_ids[] = {
 	  .data = &sc9863a_aonapb_gate_desc },
 	{ .compatible = "sprd,sc9863a-mm-gate",	/* 0x60800000 */
 	  .data = &sc9863a_mm_gate_desc },
+	{ .compatible = "sprd,sc9863a-mm-clk",	/* 0x60900000 */
+	  .data = &sc9863a_mm_clk_desc },
 	{ .compatible = "sprd,sc9863a-apapb-gate",	/* 0x71300000 */
 	  .data = &sc9863a_apapb_gate_desc },
 	{ }
-- 
2.20.1

