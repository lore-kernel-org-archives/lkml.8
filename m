Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBA4C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D2A20848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Njhl2GcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgBLMC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:02:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43848 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgBLMCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:02:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id p11so882776plq.10;
        Wed, 12 Feb 2020 04:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+lhmtQt1MVJK9xZ3yWPAuyRhB8dwTQ3KGnqmxzt5Q64=;
        b=Njhl2GcVJc85MuxAsuYnc/S2wze/BWKiMAvdqffntHs1o6/InzecM9NGs5pCU9Rhcu
         1DD11eCLN7L3R4KppLqpxlRSVoJ2h9C1dhYEnO4IQJMpQUCUQyhLNpyzPmOWV6uFEBtH
         KuV320ccttcx1BmuFJAchRLFgwH3MPagNR2QD2fE7b2kWYUOq6SJb6JEnpiEkJL7idDJ
         2ml2WoZE0x3rIyGX/iV8GVFe5g8nBHfszUvjMhrbSczzBDE4NLbnDLNMpSNhC9TtC3y6
         hKWQRG4uvr6GUl9Y5+x8/sOGESLZp8RLziKUcZEuRXclRPYY7mYnRAj9dFFLb6GiYIMg
         CqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+lhmtQt1MVJK9xZ3yWPAuyRhB8dwTQ3KGnqmxzt5Q64=;
        b=WKx5ZKniE/c1XrVDhf8rU1u+e/bPsrpeua0E0SRVVzRYS6FlIgxOJpwpMTg4xuf9Tj
         wr5P8vdd/6O6LkUzG+yb8kZ/8uqOtxRH0NcD9+xCt6ZPiphAGvrN5Uiq7+NTvagCnUUO
         40Um5LAhto2BxLWKv4O74YUnQavI4b22eEn2o9wnRFcuY5Dce96inirikKJLFsZpq9Xe
         xJo9ZE60nb+NgZBBp2c2T4gv5fm312GSk+KHcicAGc/RZ9WmwxcvWH1iQrJxL1rE7Tw/
         pyXV36JGZtiX+hB5m6oSW3ELkWmKCewOTINSSxrkVr8gPCKMgV8vOLALHfPRSysXN7l/
         UlOw==
X-Gm-Message-State: APjAAAVaHSCDgs27CZFui/w3l1vqfFqxHoJZ4LCwZ9wc/khKhf2I+RXJ
        +Io7xYnySWIB+/ImTGkNy68=
X-Google-Smtp-Source: APXvYqz3C0yH5yZi/l7Q3ooh8TD32j/hTW5czgjHDD02KEGHyP31uaTXQZ7QFwE6beVDPezR+R95WQ==
X-Received: by 2002:a17:902:8a91:: with SMTP id p17mr7548772plo.75.1581508974861;
        Wed, 12 Feb 2020 04:02:54 -0800 (PST)
Received: from localhost.localdomain ([45.114.62.33])
        by smtp.gmail.com with ESMTPSA id b24sm682448pfo.84.2020.02.12.04.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 04:02:53 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv1 2/2] clk: samsung: exynos542x: Move FSYS2 subsystem clocks to its sub-CMU
Date:   Wed, 12 Feb 2020 12:02:37 +0000
Message-Id: <20200212120237.1332-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212120237.1332-1-linux.amoon@gmail.com>
References: <20200212120237.1332-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move FSYS2 clk setting to sub-CMU block to support power domain on/off
sequences for mmc driver.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Note: This patch might be missing some more setting
as suspend/resume feature is broken.
I could not resolve this issue at my end, any input or
suggetion to improve this code.
---
 drivers/clk/samsung/clk-exynos5420.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index c9e5a1fb6653..3597e8d62445 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1035,9 +1035,6 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
 	GATE(CLK_PDMA1, "pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
 	GATE(CLK_UFS, "ufs", "aclk200_fsys2", GATE_BUS_FSYS0, 3, 0, 0),
 	GATE(CLK_RTIC, "rtic", "aclk200_fsys", GATE_IP_FSYS, 9, 0, 0),
-	GATE(CLK_MMC0, "mmc0", "aclk200_fsys2", GATE_IP_FSYS, 12, 0, 0),
-	GATE(CLK_MMC1, "mmc1", "aclk200_fsys2", GATE_IP_FSYS, 13, 0, 0),
-	GATE(CLK_MMC2, "mmc2", "aclk200_fsys2", GATE_IP_FSYS, 14, 0, 0),
 	GATE(CLK_SROMC, "sromc", "aclk200_fsys2",
 			GATE_IP_FSYS, 17, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_USBH20, "usbh20", "aclk200_fsys", GATE_IP_FSYS, 18, 0, 0),
@@ -1258,6 +1255,17 @@ static struct exynos5_subcmu_reg_dump exynos5x_gsc_suspend_regs[] = {
 	{ DIV2_RATIO0, 0, 0x30 },	/* DIV dout_gscl_blk_300 */
 };
 
+static const struct samsung_gate_clock exynos5x_fsys2_gate_clks[] __initconst = {
+	GATE(CLK_MMC0, "mmc0", "aclk200_fsys2", GATE_IP_FSYS, 12, 0, 0),
+	GATE(CLK_MMC1, "mmc1", "aclk200_fsys2", GATE_IP_FSYS, 13, 0, 0),
+	GATE(CLK_MMC2, "mmc2", "aclk200_fsys2", GATE_IP_FSYS, 14, 0, 0),
+};
+
+static struct exynos5_subcmu_reg_dump exynos5x_fsys2_suspend_regs[] = {
+	{ GATE_IP_FSYS, 0xff, 0xff },   /* FSYS gates */
+	{ SRC_TOP3, 0, BIT(12) },       /* MUX_ACLK_200_FSYS2_SEL */
+};
+
 static const struct samsung_gate_clock exynos5x_g3d_gate_clks[] __initconst = {
 	GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9,
 	     CLK_SET_RATE_PARENT, 0),
@@ -1376,12 +1384,21 @@ static const struct exynos5_subcmu_info exynos5800_mau_subcmu = {
 	.pd_name	= "MAU",
 };
 
+static const struct exynos5_subcmu_info exynos5x_fsys2_subcmu = {
+	.gate_clks	= exynos5x_fsys2_gate_clks,
+	.nr_gate_clks	= ARRAY_SIZE(exynos5x_fsys2_gate_clks),
+	.suspend_regs	= exynos5x_fsys2_suspend_regs,
+	.nr_suspend_regs = ARRAY_SIZE(exynos5x_fsys2_suspend_regs),
+	.pd_name	= "FSYS2",
+};
+
 static const struct exynos5_subcmu_info *exynos5x_subcmus[] = {
 	&exynos5x_disp_subcmu,
 	&exynos5x_gsc_subcmu,
 	&exynos5x_g3d_subcmu,
 	&exynos5x_mfc_subcmu,
 	&exynos5x_mscl_subcmu,
+	&exynos5x_fsys2_subcmu,
 };
 
 static const struct exynos5_subcmu_info *exynos5800_subcmus[] = {
@@ -1391,6 +1408,7 @@ static const struct exynos5_subcmu_info *exynos5800_subcmus[] = {
 	&exynos5x_mfc_subcmu,
 	&exynos5x_mscl_subcmu,
 	&exynos5800_mau_subcmu,
+	&exynos5x_fsys2_subcmu,
 };
 
 static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __initconst = {
-- 
2.25.0

