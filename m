Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877C6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F5B207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyHySDZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405752AbgFXRsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405546AbgFXRsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:48:08 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D25C061573;
        Wed, 24 Jun 2020 10:48:07 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w16so3327023ejj.5;
        Wed, 24 Jun 2020 10:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FVwacTejwB8bnJMaBC+CSJR1GseZilP5h+0PzN0VoP0=;
        b=CyHySDZbZFOKyw+YCaiZSvoQBE0Zbehzyy2X9XsydYfqpYn+MsOBZkqQZODXnskNCc
         BPO+bLCoLhcPF6Hu1H7WXiYkCaKskuhnuuPmTu5vcT0dPx6N0+pqi9g+c0UxG5xIfPg3
         kL1A5s0iDbA8SEiMstBS4+mteDAfP1ZbYO8lkSa2eEjxtERB7tuQil/zLY07qP8QfnfT
         Ks9NfNhPr4tyWRrr4pOsevB/O1ISI4XOEjnZSkSQZ88trOHOCLDYkbvLoVubfoRvipg5
         ZdpQlbDkIHNLFrEyndITO55aCVZ9fGhxw8IzVNqgQzWTCY+6smWLOBeGfzSo8JyFABif
         AH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FVwacTejwB8bnJMaBC+CSJR1GseZilP5h+0PzN0VoP0=;
        b=nEiFZ5+kTmlwiuljS+Pi6D8OTg6FVHcX8sISzyQYVugagge6J5nwgBuuqZwXQuad9m
         S3E5Ov8RpZqfB5Rhxe0NqoGsZC8uZ32xIWR7qZo0/srCXWXcswj3he53wkXHtwWp3HH3
         d6/w9vXs9bcQLt3rcI87JVpQMSjtTwuWe4sD6y7YtPkUhJ4Vp6aluMkdO3EkE1nBHLnr
         TibNLnzpbOrEOh9uZG/jKGUVVapE2VEMEgh0TMfddW3wsCZj46picZU/NS7FNIM/keic
         WIRMSrTOR/9yMvad6tddvrU6X2y2BLHWeidKHqDbU44qO03N8mMKnC+uQegE0up2SHSe
         p60g==
X-Gm-Message-State: AOAM532X8aNi1Zl8srlPa9j8EidbgF35nao+7XEf6Np7iYJW7pZDSgtL
        6BLgDWoRy+t6wwgrW4MMfIE=
X-Google-Smtp-Source: ABdhPJwBXzoXISAEf56ynRyfx1fplZO4Y02ClrMYltwtr17tIqd5+AyvQoiO3MFh+Vxn1y8srcnxRQ==
X-Received: by 2002:a17:907:9486:: with SMTP id dm6mr26776617ejc.248.1593020886591;
        Wed, 24 Jun 2020 10:48:06 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id s14sm8044146edq.36.2020.06.24.10.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 10:48:06 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v2 5/6] clk: actions: Add Actions S500 SoC Reset Management Unit support
Date:   Wed, 24 Jun 2020 20:47:56 +0300
Message-Id: <de224148c4ddee2de8354d7bcffdb49e2ab1edc2.1592941257.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592941257.git.cristian.ciocaltea@gmail.com>
References: <cover.1592941257.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Reset Management Unit (RMU) support for Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
Changes in v2:
 - Remove copyright as indicated by Stephen

 drivers/clk/actions/owl-s500.c | 78 ++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
index 025a8f6d6482..61bb224f6330 100644
--- a/drivers/clk/actions/owl-s500.c
+++ b/drivers/clk/actions/owl-s500.c
@@ -23,8 +23,10 @@
 #include "owl-gate.h"
 #include "owl-mux.h"
 #include "owl-pll.h"
+#include "owl-reset.h"
 
 #include <dt-bindings/clock/actions,s500-cmu.h>
+#include <dt-bindings/reset/actions,s500-reset.h>
 
 #define CMU_COREPLL			(0x0000)
 #define CMU_DEVPLL			(0x0004)
@@ -497,20 +499,96 @@ static struct clk_hw_onecell_data s500_hw_clks = {
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

