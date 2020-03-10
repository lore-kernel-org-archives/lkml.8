Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FB6C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEA3208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxA1mfJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgCJTtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:49:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36940 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgCJTtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:49:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id f16so3710759plj.4;
        Tue, 10 Mar 2020 12:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9ZKe9DPK55G94wFxazjpOuNWkVTtqx7CppQ9HO6NqY=;
        b=QxA1mfJNuNo101umOeAqQ1YfnCfKPylu4nJIhD8ICZb+kA1lQjLgkrzbxjk25h9SQr
         pZ5PkAaIlTsqDsvLkgZqL3tlvvp1XW9cPNAyB78bh/rEsJurcqd5DWeG30lDAWmR39Ad
         uW7KbxfzTH4jlBTd0WHwYTYPNKorO5VQDSD4WM6EKOJZ9tIt3gq3Lq/jWHo2sQ/r/y+A
         DhW3HSUJ0GFiNByu57by+d8FfdQSqK2BDl3J4+4tGoo0iMBayPuPQlUu9G4ljDYR0c3S
         VZV0FovHyoTyzy2UMcwIU/SDGBlzJh2RwIVQYo9kTDPW0n2g3u8GRg7K4BwXTRIaLJrj
         rgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9ZKe9DPK55G94wFxazjpOuNWkVTtqx7CppQ9HO6NqY=;
        b=ozCrQqrN4rAO42l8Q7jg0MTW7TFwwswtHOoIrpk0TbOO/9R2jjsp44FGpeoX98vAkD
         k7a2Rm+xFur1et9prLkU1YbXAK/bFwUiWlD9Ouegj49qXTQQLrxPLhGZPsHjYDRL/z1/
         8EPEoqckzebsIQb3SB5TW6HwugohFMvf1TSj/mQkOFs6LJGau4dEz1YKR23VtN3t1Oz/
         U+M4NhKcUhDsNhsUtSwFIRXQ+x5Sjqd0CWrHKSParN8H3qRfVRIG79N/lJMLZHZU+a/b
         7g7QrS57hGJ+msSSKLTM3Dt+DcgOWvgfnAslvtNlojeY5gIjCB5pVlayNH0WD3d9JysD
         1oRQ==
X-Gm-Message-State: ANhLgQ3SuP0am/RHAy1YkmPHyAhcF7k/i2SA2cvOiuvLr6/VijVn6EAO
        AwYiZ+VpH7fwKSncboSSnuICXkNi
X-Google-Smtp-Source: ADFU+vttShOB0et+FIE14Un1vRU7k4VYoJ6iz35zEx98edQYoJE8W2h24Jqu/B/zyrxKywi6Kqvs+A==
X-Received: by 2002:a17:902:9b95:: with SMTP id y21mr8418083plp.101.1583869788247;
        Tue, 10 Mar 2020 12:49:48 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.228])
        by smtp.gmail.com with ESMTPSA id d19sm3784490pfd.82.2020.03.10.12.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 12:49:47 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCHv3 5/5] clk: samsung: exynos542x: Move FSYS subsystem clocks to its sub-CMU
Date:   Tue, 10 Mar 2020 19:48:54 +0000
Message-Id: <20200310194854.831-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310194854.831-1-linux.amoon@gmail.com>
References: <20200310194854.831-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FSYS power domain support usbdrd3, pdma and usb2 power gaiting,
hence move FSYS clk setting to sub-CMU block to support power domain
on/off sequences for device nodes.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
New patch in the series
---
 drivers/clk/samsung/clk-exynos5420.c | 45 +++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index c9e5a1fb6653..6c4c47dfcdce 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -859,12 +859,6 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
 	DIV(0, "dout_maudio0", "mout_maudio0", DIV_MAU, 20, 4),
 	DIV(0, "dout_maupcm0", "dout_maudio0", DIV_MAU, 24, 8),
 
-	/* USB3.0 */
-	DIV(0, "dout_usbphy301", "mout_usbd301", DIV_FSYS0, 12, 4),
-	DIV(0, "dout_usbphy300", "mout_usbd300", DIV_FSYS0, 16, 4),
-	DIV(0, "dout_usbd301", "mout_usbd301", DIV_FSYS0, 20, 4),
-	DIV(0, "dout_usbd300", "mout_usbd300", DIV_FSYS0, 24, 4),
-
 	/* MMC */
 	DIV(0, "dout_mmc0", "mout_mmc0", DIV_FSYS1, 0, 10),
 	DIV(0, "dout_mmc1", "mout_mmc1", DIV_FSYS1, 10, 10),
@@ -1031,8 +1025,6 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
 
 	/* FSYS Block */
 	GATE(CLK_TSI, "tsi", "aclk200_fsys", GATE_BUS_FSYS0, 0, 0, 0),
-	GATE(CLK_PDMA0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
-	GATE(CLK_PDMA1, "pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
 	GATE(CLK_UFS, "ufs", "aclk200_fsys2", GATE_BUS_FSYS0, 3, 0, 0),
 	GATE(CLK_RTIC, "rtic", "aclk200_fsys", GATE_IP_FSYS, 9, 0, 0),
 	GATE(CLK_MMC0, "mmc0", "aclk200_fsys2", GATE_IP_FSYS, 12, 0, 0),
@@ -1040,9 +1032,6 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
 	GATE(CLK_MMC2, "mmc2", "aclk200_fsys2", GATE_IP_FSYS, 14, 0, 0),
 	GATE(CLK_SROMC, "sromc", "aclk200_fsys2",
 			GATE_IP_FSYS, 17, CLK_IGNORE_UNUSED, 0),
-	GATE(CLK_USBH20, "usbh20", "aclk200_fsys", GATE_IP_FSYS, 18, 0, 0),
-	GATE(CLK_USBD300, "usbd300", "aclk200_fsys", GATE_IP_FSYS, 19, 0, 0),
-	GATE(CLK_USBD301, "usbd301", "aclk200_fsys", GATE_IP_FSYS, 20, 0, 0),
 	GATE(CLK_SCLK_UNIPRO, "sclk_unipro", "dout_unipro",
 			SRC_MASK_FSYS, 24, CLK_SET_RATE_PARENT, 0),
 
@@ -1258,6 +1247,28 @@ static struct exynos5_subcmu_reg_dump exynos5x_gsc_suspend_regs[] = {
 	{ DIV2_RATIO0, 0, 0x30 },	/* DIV dout_gscl_blk_300 */
 };
 
+/* USB3.0 */
+static const struct samsung_div_clock exynos5x_fsys_div_clks[] __initconst = {
+	DIV(0, "dout_usbphy301", "mout_usbd301", DIV_FSYS0, 12, 4),
+	DIV(0, "dout_usbphy300", "mout_usbd300", DIV_FSYS0, 16, 4),
+	DIV(0, "dout_usbd301", "mout_usbd301", DIV_FSYS0, 20, 4),
+	DIV(0, "dout_usbd300", "mout_usbd300", DIV_FSYS0, 24, 4),
+};
+
+static const struct samsung_gate_clock exynos5x_fsys_gate_clks[] __initconst = {
+	GATE(CLK_PDMA0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
+	GATE(CLK_PDMA1, "pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
+	GATE(CLK_USBH20, "usbh20", "aclk200_fsys", GATE_IP_FSYS, 18, 0, 0),
+	GATE(CLK_USBD300, "usbd300", "aclk200_fsys", GATE_IP_FSYS, 19, 0, 0),
+	GATE(CLK_USBD301, "usbd301", "aclk200_fsys", GATE_IP_FSYS, 20, 0, 0),
+};
+
+static struct exynos5_subcmu_reg_dump exynos5x_fsys_suspend_regs[] = {
+	{ GATE_IP_FSYS, 0xffffffff, 0xffffffff }, /* FSYS gates */
+	{ SRC_TOP3, 0, BIT(24) },                 /* SW_MUX_PCLK_200_FSYS_SEL */
+	{ SRC_TOP3, 0, BIT(28) },                 /* SW_MUX_ACLK_200_FSYS_SEL */
+};
+
 static const struct samsung_gate_clock exynos5x_g3d_gate_clks[] __initconst = {
 	GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9,
 	     CLK_SET_RATE_PARENT, 0),
@@ -1376,12 +1387,23 @@ static const struct exynos5_subcmu_info exynos5800_mau_subcmu = {
 	.pd_name	= "MAU",
 };
 
+static const struct exynos5_subcmu_info exynos5x_fsys_subcmu = {
+	.div_clks       = exynos5x_fsys_div_clks,
+	.nr_div_clks    = ARRAY_SIZE(exynos5x_fsys_div_clks),
+	.gate_clks	= exynos5x_fsys_gate_clks,
+	.nr_gate_clks	= ARRAY_SIZE(exynos5x_fsys_gate_clks),
+	.suspend_regs	= exynos5x_fsys_suspend_regs,
+	.nr_suspend_regs = ARRAY_SIZE(exynos5x_fsys_suspend_regs),
+	.pd_name	= "FSYS",
+};
+
 static const struct exynos5_subcmu_info *exynos5x_subcmus[] = {
 	&exynos5x_disp_subcmu,
 	&exynos5x_gsc_subcmu,
 	&exynos5x_g3d_subcmu,
 	&exynos5x_mfc_subcmu,
 	&exynos5x_mscl_subcmu,
+	&exynos5x_fsys_subcmu,
 };
 
 static const struct exynos5_subcmu_info *exynos5800_subcmus[] = {
@@ -1391,6 +1413,7 @@ static const struct exynos5_subcmu_info *exynos5800_subcmus[] = {
 	&exynos5x_mfc_subcmu,
 	&exynos5x_mscl_subcmu,
 	&exynos5800_mau_subcmu,
+	&exynos5x_fsys_subcmu,
 };
 
 static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __initconst = {
-- 
2.25.1

