Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F432C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 156662089D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAEQWxoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgFQQtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgFQQsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:48:24 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79E2C061755;
        Wed, 17 Jun 2020 09:48:23 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d15so2487179edm.10;
        Wed, 17 Jun 2020 09:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QrtlUREQq2lhgOt3whoJddN27v5YME2qlHZx5rQeOQQ=;
        b=XAEQWxoFH30O+DOYVfJHuCz5hmfqCrra8kIbvJncG1vBUB/UaCXQHWq+u/MPQe9Vw6
         LhkWK9s3j1FMg2VZkTBg696VzGLadiVXdL3pCsbfBG05cuYKVRN45mZZRcLkmDmi4o5R
         TLP+ekrryklbqLGJ5isN/ArPBellfmdiAEVgVua81ajDu6xtv7kd4p4ZHT1K2grwtShh
         iHhUMtfda69+/lScK/oZ/QfZ7ZPz6Ik726B3Nt3Ip3tW7Gu7O6JiGja8PuKFKcDSf7fX
         SfhndMXzTSuDktTEjQFIHp7tmknaVsH0PAHGcwTTxhbW8IpcwLJupvvpPAh7PdPltcrG
         18WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QrtlUREQq2lhgOt3whoJddN27v5YME2qlHZx5rQeOQQ=;
        b=hEsbpHdYHRZNo9ri4rrPHQ01l9mQC66JhuROTK7owmDYI0AGyM4owwjSsRHLD5rZcP
         49RVU9IGhOslzRMMePv/8hgLzYMDM1hBcuyHqenN+Ls3GVt5FE5I1t2ULzGSUJnC/UZQ
         DPoG/JaXQQQm1ROxsuGvUNTgjyGGR8YpwYq4rH89TkKNR45bJddkwRWd+tOxQFydCWOp
         IlxbA1gR5N3+40OC2B9xwKvQkNfyvdDT1STQHWZ3Izb/J3tMX+GT1az9Pli/IBc/oqdO
         T1WdypAMCY6jjiKfhBlcmBi+eUGl7xByiSFXGSQaR30sCFdYCEG6NXVgGCjduM0qQ6ck
         LCyQ==
X-Gm-Message-State: AOAM532OE1OOZ87pNLmeD+5Vf1Z2Sd2oyOM8wt1hmAzntrwkYNtPTt8H
        d1BZ3H5potpXyxSlaGnHD3g=
X-Google-Smtp-Source: ABdhPJyP9eVzPud4Ue7Xcr3fbTydj8xnuONF2GxezOsTe+R/iMs6MadVtMT1IxfrF2uMoWhRltFNVg==
X-Received: by 2002:a05:6402:1fc:: with SMTP id i28mr69249edy.63.1592412502558;
        Wed, 17 Jun 2020 09:48:22 -0700 (PDT)
Received: from localhost.localdomain ([188.24.129.96])
        by smtp.gmail.com with ESMTPSA id v3sm127124edj.89.2020.06.17.09.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:48:22 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-actions@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] clk: actions: Add APB, DMAC, GPIO clock support for Actions S500 SoC
Date:   Wed, 17 Jun 2020 19:48:06 +0300
Message-Id: <341a92d9b84e9fca2bf646832c23d49ba6255ae7.1592407030.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
References: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the missing APB, DMAC and GPIO clocks in the Actions
Semi S500 SoC clock driver.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 drivers/clk/actions/owl-s500.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
index 0eb83a0b70bc..025a8f6d6482 100644
--- a/drivers/clk/actions/owl-s500.c
+++ b/drivers/clk/actions/owl-s500.c
@@ -175,6 +175,8 @@ static OWL_MUX(dev_clk, "dev_clk", dev_clk_mux_p, CMU_DEVPLL, 12, 1, CLK_SET_RAT
 static OWL_MUX(ahbprediv_clk, "ahbprediv_clk", ahbprediv_clk_mux_p, CMU_BUSCLK1, 8, 3, CLK_SET_RATE_PARENT);
 
 /* gate clocks */
+static OWL_GATE(gpio_clk, "gpio_clk", "apb_clk", CMU_DEVCLKEN0, 18, 0, 0);
+static OWL_GATE(dmac_clk, "dmac_clk", "h_clk", CMU_DEVCLKEN0, 1, 0, 0);
 static OWL_GATE(spi0_clk, "spi0_clk", "ahb_clk", CMU_DEVCLKEN1, 10, 0, CLK_IGNORE_UNUSED);
 static OWL_GATE(spi1_clk, "spi1_clk", "ahb_clk", CMU_DEVCLKEN1, 11, 0, CLK_IGNORE_UNUSED);
 static OWL_GATE(spi2_clk, "spi2_clk", "ahb_clk", CMU_DEVCLKEN1, 12, 0, CLK_IGNORE_UNUSED);
@@ -184,6 +186,7 @@ static OWL_GATE(hdmi_clk, "hdmi_clk", "hosc", CMU_DEVCLKEN1, 3, 0, 0);
 
 /* divider clocks */
 static OWL_DIVIDER(h_clk, "h_clk", "ahbprediv_clk", CMU_BUSCLK1, 12, 2, NULL, 0, 0);
+static OWL_DIVIDER(apb_clk, "apb_clk", "ahb_clk", CMU_BUSCLK1, 14, 2, NULL, 0, 0);
 static OWL_DIVIDER(rmii_ref_clk, "rmii_ref_clk", "ethernet_pll_clk", CMU_ETHERNETPLL, 1, 1, rmii_ref_div_table, 0, 0);
 
 /* factor clocks */
@@ -428,6 +431,9 @@ static struct owl_clk_common *s500_clks[] = {
 	&spdif_clk.common,
 	&nand_clk.common,
 	&ecc_clk.common,
+	&apb_clk.common,
+	&dmac_clk.common,
+	&gpio_clk.common,
 };
 
 static struct clk_hw_onecell_data s500_hw_clks = {
@@ -484,6 +490,9 @@ static struct clk_hw_onecell_data s500_hw_clks = {
 		[CLK_SPDIF]		= &spdif_clk.common.hw,
 		[CLK_NAND]		= &nand_clk.common.hw,
 		[CLK_ECC]		= &ecc_clk.common.hw,
+		[CLK_APB]		= &apb_clk.common.hw,
+		[CLK_DMAC]		= &dmac_clk.common.hw,
+		[CLK_GPIO]		= &gpio_clk.common.hw,
 	},
 	.num = CLK_NR_CLKS,
 };
-- 
2.27.0

