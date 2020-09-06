Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA515C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 15:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71916208C7
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 15:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SX4GDYqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgIFPW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 11:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbgIFPTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 11:19:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C854EC061575
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 08:19:36 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e17so11018066wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 08:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uHlPaejxaoEdhUtjcAkbEk5MwemH61sGbulo7nTGaVI=;
        b=SX4GDYqTPOGWjEBwAPJ+63c5XJ+ugOUtKfk2l97qxzdS2k0Gs3m/RL1RxgLIqb9BGI
         GJzExp+fn4OA+P/b5Kx45NWqujGTB+EFHnJLjWDAsCu5e9IAyZe5RTNQSeCuXK1iGUBg
         ViS+LLN/xduUf/moO8/9B9eaCe2k/rBPGM05InBZDCSiKeQiJJgeD5+Wd7nRJfvpJl3D
         rseB2sAArVCsO6cAhTtEUqykbhjl/MSC3j2sngJ0x8bc5ATvxhvVw41dNoxye+lbXAZg
         zDoeVjmXF3eC9s4u20sPCwq2i26V0JPWhbcBJaBEQi1yTJcqExo3/h/EsPvOUeklCzVx
         +XvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uHlPaejxaoEdhUtjcAkbEk5MwemH61sGbulo7nTGaVI=;
        b=T5WJZ7oovd+h+nzi9r2+5iKW9CKkfeNBhG858lExrxXA8IGhqawrHdwy3+CsiD80ef
         lw7/m4J9GZLD0092/6NKkpGdh7Hi7oFMSLg43apQYzoF7W5OcGwW/Sml1KrHqQHcykUz
         /iKPjvT+cYR0a7claxsnLw2rk3T+6DxROHF5evYJo47sxpxOZmIIEFM2gqL0z+sTbjKZ
         IN/xOi4gbuQzghQuVtctRlLpgBr11jOh6N5xsCkGmo9rVVzV2d0rNqtjqKutFBBucESI
         p0Wvyvj2GdZybsXOVgEzMMsYcnGkg/ppIVLd4oRCpZ01NJ9pCQkUVKdPMwqbrv+il+EZ
         b5wg==
X-Gm-Message-State: AOAM5332T1b56SN7rkDykgt8kq8To+7TqreaKbVVBSJx0oY9l9ZJkl85
        2SB/Tcl32GYQQ8c5sVfALqbIH65EcsBjiA==
X-Google-Smtp-Source: ABdhPJxTiP5W3hXf0jIMlYDRBifFpSbd8PfKRCSzquyfrJqE89SWeJ2IDFhFHf02RC+vrWN02y3xIw==
X-Received: by 2002:a1c:c90d:: with SMTP id f13mr16979046wmb.25.1599405575412;
        Sun, 06 Sep 2020 08:19:35 -0700 (PDT)
Received: from localhost.localdomain (208.19.23.93.rev.sfr.net. [93.23.19.208])
        by smtp.gmail.com with ESMTPSA id a15sm26420646wrn.3.2020.09.06.08.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 08:19:34 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        yong.wu@mediatek.com, Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v3 2/3] iommu/mediatek: add flag for legacy ivrp paddr
Date:   Sun,  6 Sep 2020 17:19:27 +0200
Message-Id: <20200906151928.881209-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906151928.881209-1-fparent@baylibre.com>
References: <20200906151928.881209-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new flag in order to select which IVRP_PADDR format is used
by an SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

v3: set LEGACY_IVRP_PADDR as a flag instead of platform data
v2: new patch

---
 drivers/iommu/mtk_iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 785b228d39a6..b1f85a7e9346 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -116,6 +116,7 @@
 #define OUT_ORDER_WR_EN			BIT(4)
 #define HAS_SUB_COMM			BIT(5)
 #define WR_THROT_EN			BIT(6)
+#define HAS_LEGACY_IVRP_PADDR		BIT(7)
 
 #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
 		((((pdata)->flags) & (_x)) == (_x))
@@ -582,7 +583,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
 	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
 
-	if (data->plat_data->m4u_plat == M4U_MT8173)
+	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_LEGACY_IVRP_PADDR))
 		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
 	else
 		regval = lower_32_bits(data->protect_base) |
@@ -818,7 +819,8 @@ static const struct mtk_iommu_plat_data mt6779_data = {
 
 static const struct mtk_iommu_plat_data mt8173_data = {
 	.m4u_plat     = M4U_MT8173,
-	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI,
+	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
+			HAS_LEGACY_IVRP_PADDR,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
 	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
 };
-- 
2.28.0

