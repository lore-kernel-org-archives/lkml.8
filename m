Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494D8C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 18:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3C720639
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 18:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NEj8UwN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgIFSJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 14:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729135AbgIFSJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 14:09:52 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A752C061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 11:09:51 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z9so11466537wmk.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 11:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kumt6xPsCDUuNyx6USsuuQtWS1PyP3Rmwiip0oO6sZA=;
        b=NEj8UwN8yasyL4TZ1RQ6+S5zY6HtOe3KksHAaj1N4LVkekAMp2+cXNNujH7LCX4PhY
         olauxi2xPneYW/ZDDVpBuMw98JfGBx7sVYFtUBYTj2hmkiGRz308vh+sq0+AxdyaSy9U
         /CHl1bg25LdFRzU43OyCvAnHbes89mnUtpKzJv84Zi7g4TtRcu5dU0phMSLef/9lexMn
         hVMxfI6zYcDNWXZX1mpT8hxGMOvfBwQa5MwQu+WWra3jrGXHAWh6fIPMIyRUXfxpVduA
         ZaWtDtJyjRehtSqemZEbXwnA7ziVAQ4P09YgeiPkFrPfIWplDMG85yf4KGFfbgC/V0Mx
         vs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kumt6xPsCDUuNyx6USsuuQtWS1PyP3Rmwiip0oO6sZA=;
        b=Wr/TtIraFZbC9eYsyjm0D1J7gJHwzssVVmEEm5TwZO26T9teMm6JUlDUVLZZnKPdVx
         1b5FycW4ev36I661b5ehw2O55gKsJUlONR6nSP4PAurfv8FF5z4pjOdEU7enUp/625q5
         p2w2u0RGMKyhz2O+otFFboYTLSnjt527+uODkiw1D6ja+iWSRlDjxADrJp2rLtQXD6Uj
         Jq6zzEHxIwvB+7op4zx0BS7ylH494fGJXX6rx5rLqQijKTMcQBc8VUfhv195prwQpvfT
         je0Ki0GyTI1OGiB6Ru2im7xVdVP7VD50+N7KqVQt7pB1QP9Ja/NkBpUilM1JRG9R2AQz
         90ow==
X-Gm-Message-State: AOAM533O/u2o87L1SluM+64wCgJwFZA0aelZ4pcI4lRDhTARp6i49TWz
        Y6ooFhVU0+xWi2RkXF1B3jRMag==
X-Google-Smtp-Source: ABdhPJw+Umfe+hF29nj4Wke2ReLCF+37Go/9KRaICoq/knhxVIsJkqpp5l7hb+oG6GtpEn0t9Zal9A==
X-Received: by 2002:a1c:9c0b:: with SMTP id f11mr16769412wme.0.1599415789890;
        Sun, 06 Sep 2020 11:09:49 -0700 (PDT)
Received: from localhost.localdomain (208.19.23.93.rev.sfr.net. [93.23.19.208])
        by smtp.gmail.com with ESMTPSA id s11sm24593937wrt.43.2020.09.06.11.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 11:09:49 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, krzk@kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 2/2] memory: mtk-smi: add support for MT8167
Date:   Sun,  6 Sep 2020 20:09:38 +0200
Message-Id: <20200906180938.1117526-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906180938.1117526-1-fparent@baylibre.com>
References: <20200906180938.1117526-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the SMI IP on MT8167

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/memory/mtk-smi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index c21262502581..691e4c344cf8 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -19,6 +19,9 @@
 /* mt8173 */
 #define SMI_LARB_MMU_EN		0xf00
 
+/* mt8167 */
+#define MT8167_SMI_LARB_MMU_EN	0xfc0
+
 /* mt2701 */
 #define REG_SMI_SECUR_CON_BASE		0x5c0
 
@@ -179,6 +182,13 @@ static void mtk_smi_larb_config_port_mt8173(struct device *dev)
 	writel(*larb->mmu, larb->base + SMI_LARB_MMU_EN);
 }
 
+static void mtk_smi_larb_config_port_mt8167(struct device *dev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+
+	writel(*larb->mmu, larb->base + MT8167_SMI_LARB_MMU_EN);
+}
+
 static void mtk_smi_larb_config_port_gen1(struct device *dev)
 {
 	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
@@ -226,6 +236,11 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8173 = {
 	.config_port = mtk_smi_larb_config_port_mt8173,
 };
 
+static const struct mtk_smi_larb_gen mtk_smi_larb_mt8167 = {
+	/* mt8167 do not need the port in larb */
+	.config_port = mtk_smi_larb_config_port_mt8167,
+};
+
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
 	.port_in_larb = {
 		LARB0_PORT_OFFSET, LARB1_PORT_OFFSET,
@@ -254,6 +269,10 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
 };
 
 static const struct of_device_id mtk_smi_larb_of_ids[] = {
+	{
+		.compatible = "mediatek,mt8167-smi-larb",
+		.data = &mtk_smi_larb_mt8167
+	},
 	{
 		.compatible = "mediatek,mt8173-smi-larb",
 		.data = &mtk_smi_larb_mt8173
@@ -418,6 +437,10 @@ static const struct of_device_id mtk_smi_common_of_ids[] = {
 		.compatible = "mediatek,mt8173-smi-common",
 		.data = &mtk_smi_common_gen2,
 	},
+	{
+		.compatible = "mediatek,mt8167-smi-common",
+		.data = &mtk_smi_common_gen2,
+	},
 	{
 		.compatible = "mediatek,mt2701-smi-common",
 		.data = &mtk_smi_common_gen1,
-- 
2.28.0

