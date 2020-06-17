Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66077C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 414032089D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbDQlkyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgFQQso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgFQQs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:48:28 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8E8C06174E;
        Wed, 17 Jun 2020 09:48:28 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dr13so3135353ejc.3;
        Wed, 17 Jun 2020 09:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6fVxLcF2XQJKtsCVrWUPWiIVRqtIIhB/4u8XgaRXYq8=;
        b=PbDQlkylV8BzQ62QxvxU6i6zJ2z8rgpr4t36HTDAIUFbnjVkXEApnIwTiW6slNgUe8
         FHdD7C9BjKXgEU77ydCgBJYAAcFTD7lZ7DFZ63+hBGZzBMkOENA8uuManPfMuhsStJcw
         BbxnzmjNDi8e4ke9bS/G7tgJqeJvum6lGjlsMSaYJZr8nS6HVXnmyi+Z7NdK75jMV3D2
         gYDlXcqW4RY2HNmvZZNDGM6wQyI0ZlWwirkYAhr2dOD/zB8E9lQztARmsugF0ILTZyT3
         tGIeex77E1MIS5TnWqGTPnGeNLNGXLkbDl1qrCXnqNNfv6p9LNXEXuKIe7ryfyRD7XwQ
         kI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6fVxLcF2XQJKtsCVrWUPWiIVRqtIIhB/4u8XgaRXYq8=;
        b=g59DUv0nF2kFcPSZG84P1KJaz7isIwsbAl0lqayj2Abnf23itYnP1g3ai/CrV56ciw
         Me+zJeMJI6zYxvQ6cuEQfrxgbrK5gbXBu2vGEOxG5kWa9xTE/qu2SqqgSEzjkSGdnBzB
         XTI4mgj42h+hnHKeMyzl82bT6dxD9DqCnpnznrScYTWM2+y09dBN+w4e1niKZlxZEGC3
         qOaqx1aPxRZMROr74EoW6fWBUkJbauURCmK++ycUiO6jeDnpgiu5BmRzL5fcH1u+Njrp
         341y1vhYEuqTGo11Xn5PYSuh9014sYnWQi2uMU/Qs/hOWz1mWQm32kFnReXGnp3TkAhN
         hY4A==
X-Gm-Message-State: AOAM5305+h1C6I0wkxfU24/t/IBrqAMkWxQq8vZrXpUjyvY1XOfdX2Yu
        Bo9Jzu4z8slrYPjXATeWW8A=
X-Google-Smtp-Source: ABdhPJzvfkBjdaEucnW6Yw9j2N0utHDwTtXn2MmFds5w5ZZP1PDzlH/1fl3mYO0+UhnDesHXQctLAQ==
X-Received: by 2002:a17:906:cc58:: with SMTP id mm24mr97135ejb.134.1592412506965;
        Wed, 17 Jun 2020 09:48:26 -0700 (PDT)
Received: from localhost.localdomain ([188.24.129.96])
        by smtp.gmail.com with ESMTPSA id v3sm127124edj.89.2020.06.17.09.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:48:26 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-actions@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] clk: actions: Add Actions S500 SoC Reset Management Unit support
Date:   Wed, 17 Jun 2020 19:48:09 +0300
Message-Id: <e361b46511756070277ff10f94e1735bb69cc300.1592407030.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
References: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Reset Management Unit (RMU) support for Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 drivers/clk/actions/owl-s500.c | 80 ++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
index 025a8f6d6482..3bce72301c65 100644
--- a/drivers/clk/actions/owl-s500.c
+++ b/drivers/clk/actions/owl-s500.c
@@ -10,6 +10,8 @@
  *
  * Copyright (c) 2018 LSI-TEC - Caninos Loucos
  * Author: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
+ *
+ * Copyright (c) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
  */
 
 #include <linux/clk-provider.h>
@@ -23,8 +25,10 @@
 #include "owl-gate.h"
 #include "owl-mux.h"
 #include "owl-pll.h"
+#include "owl-reset.h"
 
 #include <dt-bindings/clock/actions,s500-cmu.h>
+#include <dt-bindings/reset/actions,s500-reset.h>
 
 #define CMU_COREPLL			(0x0000)
 #define CMU_DEVPLL			(0x0004)
@@ -497,20 +501,96 @@ static struct clk_hw_onecell_data s500_hw_clks = {
 	.num = CLK_NR_CLKS,
 };
 
+static const struct owl_reset_map s500_resets[] = {
+	[RESET_DMAC]	= { CMU_DEVRST0, BIT(0) },
+	[RESET_NORIF]	= { CMU_DEVRST0, BIT(1) },
+	[RESET_DDR]	= { CMU_DEVRST0, BIT(2) },
+	[RESET_NANDC]	= { CMU_DEVRST0, BIT(3) },
+	[RESET_SD0]	= { CMU_DEVRST0, BIT(4) },
+	[RESET_SD1]	= { CMU_DEVRST0, BIT(5) },
+	[RESET_PCM1]	= { CMU_DEVRST0, BIT(6) },
+	[RESET_DE]	= { CMU_DEVRST0, BIT(7) },
+	[RESET_LCD]	= { CMU_DEVRST0, BIT(8) },
+	[RESET_SD2]	= { CMU_DEVRST0, BIT(9) },
+	[RESET_DSI]	= { CMU_DEVRST0, BIT(10) },
+	[RESET_CSI]	= { CMU_DEVRST0, BIT(11) },
+	[RESET_BISP]	= { CMU_DEVRST0, BIT(12) },
+	[RESET_KEY]	= { CMU_DEVRST0, BIT(14) },
+	[RESET_GPIO]	= { CMU_DEVRST0, BIT(15) },
+	[RESET_AUDIO]	= { CMU_DEVRST0, BIT(17) },
+	[RESET_PCM0]	= { CMU_DEVRST0, BIT(18) },
+	[RESET_VDE]	= { CMU_DEVRST0, BIT(19) },
+	[RESET_VCE]	= { CMU_DEVRST0, BIT(20) },
+	[RESET_GPU3D]	= { CMU_DEVRST0, BIT(22) },
+	[RESET_NIC301]	= { CMU_DEVRST0, BIT(23) },
+	[RESET_LENS]	= { CMU_DEVRST0, BIT(26) },
+	[RESET_PERIPHRESET] = { CMU_DEVRST0, BIT(27) },
+	[RESET_USB2_0]	= { CMU_DEVRST1, BIT(0) },
+	[RESET_TVOUT]	= { CMU_DEVRST1, BIT(1) },
+	[RESET_HDMI]	= { CMU_DEVRST1, BIT(2) },
+	[RESET_HDCP2TX]	= { CMU_DEVRST1, BIT(3) },
+	[RESET_UART6]	= { CMU_DEVRST1, BIT(4) },
+	[RESET_UART0]	= { CMU_DEVRST1, BIT(5) },
+	[RESET_UART1]	= { CMU_DEVRST1, BIT(6) },
+	[RESET_UART2]	= { CMU_DEVRST1, BIT(7) },
+	[RESET_SPI0]	= { CMU_DEVRST1, BIT(8) },
+	[RESET_SPI1]	= { CMU_DEVRST1, BIT(9) },
+	[RESET_SPI2]	= { CMU_DEVRST1, BIT(10) },
+	[RESET_SPI3]	= { CMU_DEVRST1, BIT(11) },
+	[RESET_I2C0]	= { CMU_DEVRST1, BIT(12) },
+	[RESET_I2C1]	= { CMU_DEVRST1, BIT(13) },
+	[RESET_USB3]	= { CMU_DEVRST1, BIT(14) },
+	[RESET_UART3]	= { CMU_DEVRST1, BIT(15) },
+	[RESET_UART4]	= { CMU_DEVRST1, BIT(16) },
+	[RESET_UART5]	= { CMU_DEVRST1, BIT(17) },
+	[RESET_I2C2]	= { CMU_DEVRST1, BIT(18) },
+	[RESET_I2C3]	= { CMU_DEVRST1, BIT(19) },
+	[RESET_ETHERNET] = { CMU_DEVRST1, BIT(20) },
+	[RESET_CHIPID]	= { CMU_DEVRST1, BIT(21) },
+	[RESET_USB2_1]	= { CMU_DEVRST1, BIT(22) },
+	[RESET_WD0RESET] = { CMU_DEVRST1, BIT(24) },
+	[RESET_WD1RESET] = { CMU_DEVRST1, BIT(25) },
+	[RESET_WD2RESET] = { CMU_DEVRST1, BIT(26) },
+	[RESET_WD3RESET] = { CMU_DEVRST1, BIT(27) },
+	[RESET_DBG0RESET] = { CMU_DEVRST1, BIT(28) },
+	[RESET_DBG1RESET] = { CMU_DEVRST1, BIT(29) },
+	[RESET_DBG2RESET] = { CMU_DEVRST1, BIT(30) },
+	[RESET_DBG3RESET] = { CMU_DEVRST1, BIT(31) },
+};
+
 static struct owl_clk_desc s500_clk_desc = {
 	.clks	    = s500_clks,
 	.num_clks   = ARRAY_SIZE(s500_clks),
 
 	.hw_clks    = &s500_hw_clks,
+
+	.resets     = s500_resets,
+	.num_resets = ARRAY_SIZE(s500_resets),
 };
 
 static int s500_clk_probe(struct platform_device *pdev)
 {
 	struct owl_clk_desc *desc;
+	struct owl_reset *reset;
+	int ret;
 
 	desc = &s500_clk_desc;
 	owl_clk_regmap_init(pdev, desc);
 
+	reset = devm_kzalloc(&pdev->dev, sizeof(*reset), GFP_KERNEL);
+	if (!reset)
+		return -ENOMEM;
+
+	reset->rcdev.of_node = pdev->dev.of_node;
+	reset->rcdev.ops = &owl_reset_ops;
+	reset->rcdev.nr_resets = desc->num_resets;
+	reset->reset_map = desc->resets;
+	reset->regmap = desc->regmap;
+
+	ret = devm_reset_controller_register(&pdev->dev, &reset->rcdev);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to register reset controller\n");
+
 	return owl_clk_probe(&pdev->dev, desc->hw_clks);
 }
 
-- 
2.27.0

