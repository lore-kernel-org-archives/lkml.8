Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0E6C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 17:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F125620738
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 17:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GSYmCjav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgIFRX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 13:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgIFRXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 13:23:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126EEC061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 10:23:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so12586571wrm.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 10:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5LFv5ZzrVOAZXLCXj1U+E9oMgR2hqbPqCxx8fHUWScg=;
        b=GSYmCjav2aZ0QhgMTTV2qcj7Jla39knHA76pCWIbROE5UHL1B9bue+wfrpvN6uUQ+u
         Mt471x1TRdzFcB2Hovb9nv1XWxAVTGOc4yd3LS9jyA8Eo7XoVXR83/X/eVOqOS/3FA1g
         RblNCxiwOGushHpmwDedToQykLg1aa3C29ePp+XuqhbkxX1QAu4EFdkX9JGXzuSCkhfb
         yir95FfKypfPGgQT+tyOvkHtmn3nNrzlT4MbFzgQ2Moh4ciUVxa5+/jxTL1wBdqSJU1D
         nGNs6t2sFGAXTXFmoUdir4ih8dho/XmuoECl60z5gK73qlfw4DkGAva44YPtencAF9Cm
         gR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5LFv5ZzrVOAZXLCXj1U+E9oMgR2hqbPqCxx8fHUWScg=;
        b=hE2/M9GtEAsfSlC7sKkBmO0/GMi8mswYFVL1n4i1POZp8GupnPioS+q+YwQQFdd2vW
         78tVa/tORDgIIHCrqeg4LmcvgGhTAm9TBRCGKjjuBaaSqOmpbIAnrXByJ/MtmQEQjnY2
         qow6hDwqwpDy8QXCcnaeh45Sr06rSAULpZ5ox2xSrSOtfCGaDwvgGhSaC9jWwrle9NXO
         4He7UqoleNiRj7lOlkR0ni8MOCR14QUbMZA9ZoF4gHxQkx9g8HgPXeO27lvDtzp5OSZK
         Ro+aZUMPdKmxVow3+Q4xK5EmcOHOAXo8OBiLlGzjukGRwg4sgwJ9kVnhXVVGENidljvD
         pXgg==
X-Gm-Message-State: AOAM531aml4TthF7ka0/R31GcVBBeJPjsNmVQ1DRUEr3l0xRqo/RXBHt
        Rdq7O6k7sFjcQPZciIedc32WUQ==
X-Google-Smtp-Source: ABdhPJxdwKrbmm/JNyMDgs0+HCcl31Zmvuic08YJEaYa3l1Ok6Ysb6o9cijYOYLzCz/0m5GNM6rTAQ==
X-Received: by 2002:adf:e2c7:: with SMTP id d7mr17499432wrj.110.1599413029588;
        Sun, 06 Sep 2020 10:23:49 -0700 (PDT)
Received: from localhost.localdomain (208.19.23.93.rev.sfr.net. [93.23.19.208])
        by smtp.gmail.com with ESMTPSA id p18sm4490311wrx.47.2020.09.06.10.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 10:23:49 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     krzk@kernel.org, mars.cheng@mediatek.com, owen.chen@mediatek.com,
        macpaul.lin@mediatek.com, ulf.hansson@linaro.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 2/2] soc: mediatek: add SCPSYS power dmain for MT8167 SoC
Date:   Sun,  6 Sep 2020 19:23:37 +0200
Message-Id: <20200906172337.1052933-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906172337.1052933-1-fparent@baylibre.com>
References: <20200906172337.1052933-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SCPSYS power domain support for MT8167 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/soc/mediatek/mtk-scpsys.c     | 99 +++++++++++++++++++++++++++
 include/linux/soc/mediatek/infracfg.h |  8 +++
 2 files changed, 107 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index f669d3754627..ce897720ef17 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -18,6 +18,7 @@
 #include <dt-bindings/power/mt6797-power.h>
 #include <dt-bindings/power/mt7622-power.h>
 #include <dt-bindings/power/mt7623a-power.h>
+#include <dt-bindings/power/mt8167-power.h>
 #include <dt-bindings/power/mt8173-power.h>
 
 #define MTK_POLL_DELAY_US   10
@@ -89,6 +90,7 @@ enum clk_id {
 	CLK_HIFSEL,
 	CLK_JPGDEC,
 	CLK_AUDIO,
+	CLK_AXI_MFG,
 	CLK_MAX,
 };
 
@@ -103,6 +105,7 @@ static const char * const clk_names[] = {
 	"hif_sel",
 	"jpgdec",
 	"audio",
+	"axi_mfg",
 	NULL,
 };
 
@@ -911,6 +914,87 @@ static const struct scp_domain_data scp_domain_data_mt7623a[] = {
 	},
 };
 
+/*
+ * MT8167 power domain support
+ */
+#define PWR_STATUS_MFG_2D_MT8167	BIT(24)
+#define PWR_STATUS_MFG_ASYNC_MT8167	BIT(25)
+
+static const struct scp_domain_data scp_domain_data_mt8167[] = {
+	[MT8167_POWER_DOMAIN_DISP] = {
+		.name = "disp",
+		.sta_mask = PWR_STATUS_DISP,
+		.ctl_offs = SPM_DIS_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bus_prot_mask = MT8167_TOP_AXI_PROT_EN_MM_EMI |
+				 MT8167_TOP_AXI_PROT_EN_MCU_MM,
+		.clk_id = {CLK_MM},
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8167_POWER_DOMAIN_VDEC] = {
+		.name = "vdec",
+		.sta_mask = PWR_STATUS_VDEC,
+		.ctl_offs = SPM_VDE_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.clk_id = {CLK_MM, CLK_VDEC},
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8167_POWER_DOMAIN_ISP] = {
+		.name = "isp",
+		.sta_mask = PWR_STATUS_ISP,
+		.ctl_offs = SPM_ISP_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.clk_id = {CLK_MM},
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8167_POWER_DOMAIN_MFG_ASYNC] = {
+		.name = "mfg_async",
+		.sta_mask = PWR_STATUS_MFG_ASYNC_MT8167,
+		.ctl_offs = SPM_MFG_ASYNC_PWR_CON,
+		.sram_pdn_bits = 0,
+		.sram_pdn_ack_bits = 0,
+		.bus_prot_mask = MT8167_TOP_AXI_PROT_EN_MCU_MFG |
+				 MT8167_TOP_AXI_PROT_EN_MFG_EMI,
+		.clk_id = {CLK_MFG, CLK_AXI_MFG},
+	},
+	[MT8167_POWER_DOMAIN_MFG_2D] = {
+		.name = "mfg_2d",
+		.sta_mask = PWR_STATUS_MFG_2D_MT8167,
+		.ctl_offs = SPM_MFG_2D_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.clk_id = {CLK_NONE},
+	},
+	[MT8167_POWER_DOMAIN_MFG] = {
+		.name = "mfg",
+		.sta_mask = PWR_STATUS_MFG,
+		.ctl_offs = SPM_MFG_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.clk_id = {CLK_NONE},
+	},
+	[MT8167_POWER_DOMAIN_CONN] = {
+		.name = "conn",
+		.sta_mask = PWR_STATUS_CONN,
+		.ctl_offs = SPM_CONN_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = 0,
+		.bus_prot_mask = MT8167_TOP_AXI_PROT_EN_CONN_EMI |
+				 MT8167_TOP_AXI_PROT_EN_CONN_MCU |
+				 MT8167_TOP_AXI_PROT_EN_MCU_CONN,
+		.clk_id = {CLK_NONE},
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+};
+
+static const struct scp_subdomain scp_subdomain_mt8167[] = {
+	{MT8167_POWER_DOMAIN_MFG_ASYNC, MT8167_POWER_DOMAIN_MFG_2D},
+	{MT8167_POWER_DOMAIN_MFG_2D, MT8167_POWER_DOMAIN_MFG},
+};
+
 /*
  * MT8173 power domain support
  */
@@ -1064,6 +1148,18 @@ static const struct scp_soc_data mt7623a_data = {
 	.bus_prot_reg_update = true,
 };
 
+static const struct scp_soc_data mt8167_data = {
+	.domains = scp_domain_data_mt8167,
+	.num_domains = ARRAY_SIZE(scp_domain_data_mt8167),
+	.subdomains = scp_subdomain_mt8167,
+	.num_subdomains = ARRAY_SIZE(scp_subdomain_mt8167),
+	.regs = {
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
+	},
+	.bus_prot_reg_update = true,
+};
+
 static const struct scp_soc_data mt8173_data = {
 	.domains = scp_domain_data_mt8173,
 	.num_domains = ARRAY_SIZE(scp_domain_data_mt8173),
@@ -1096,6 +1192,9 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
 	}, {
 		.compatible = "mediatek,mt7623a-scpsys",
 		.data = &mt7623a_data,
+	}, {
+		.compatible = "mediatek,mt8167-scpsys",
+		.data = &mt8167_data,
 	}, {
 		.compatible = "mediatek,mt8173-scpsys",
 		.data = &mt8173_data,
diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
index fd25f0148566..6ee49bf90acf 100644
--- a/include/linux/soc/mediatek/infracfg.h
+++ b/include/linux/soc/mediatek/infracfg.h
@@ -2,6 +2,14 @@
 #ifndef __SOC_MEDIATEK_INFRACFG_H
 #define __SOC_MEDIATEK_INFRACFG_H
 
+#define MT8167_TOP_AXI_PROT_EN_MM_EMI		BIT(1)
+#define MT8167_TOP_AXI_PROT_EN_MCU_MFG		BIT(2)
+#define MT8167_TOP_AXI_PROT_EN_CONN_EMI		BIT(4)
+#define MT8167_TOP_AXI_PROT_EN_MFG_EMI		BIT(5)
+#define MT8167_TOP_AXI_PROT_EN_CONN_MCU		BIT(8)
+#define MT8167_TOP_AXI_PROT_EN_MCU_CONN		BIT(9)
+#define MT8167_TOP_AXI_PROT_EN_MCU_MM		BIT(11)
+
 #define MT8173_TOP_AXI_PROT_EN_MCI_M2		BIT(0)
 #define MT8173_TOP_AXI_PROT_EN_MM_M0		BIT(1)
 #define MT8173_TOP_AXI_PROT_EN_MM_M1		BIT(2)
-- 
2.28.0

