Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D7DC43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 15:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAE9520714
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 15:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OyUETwoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgIFPUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 11:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbgIFPTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 11:19:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8688CC061757
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 08:19:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c19so10669723wmd.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 08:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0U6+N87TtQqeJvtsYL++VRaHV5Y/ETKSefP9o6FFabM=;
        b=OyUETwoInfdSh4ScoNMRqAZdPJ8qgNTcs/PCZtrGedtu8dWgAmrBhfDVsXTa4UBvGI
         5M7Rl2ssXCVXKyL3S4lLa6uvMTPO7jGhZ1IPKbyzklrYMbOvENWb+OkSQ53y6qd2ZO4s
         P+B/MmJVjjCPhP5lFS1uKSUrKRV+lNEzkU0hAzXdDcG+L0i7Sj587sFJIqDIHfyW/gJR
         p8r0R+32AHVnG37XpelpYr+7bSLaSbsY+I8FqQ8Pl3OFewkFzCWFHeTau+MI7nGQhfH5
         3uLvhvYONA8hQE5Tr9VqO6w/kiialSKWmUHD3PpghDZs/JbTzaYtNtj5VeGt7ZUdCW+E
         ZyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0U6+N87TtQqeJvtsYL++VRaHV5Y/ETKSefP9o6FFabM=;
        b=NqPqRwtTwPP8DAaJzpQ9jkkZIri7oySwDsgsjeMjZaWQnByiGMpYk21+s8KAWXGUxS
         FuLRWFovWoNQ9GBfKnOFJfEaoLHW0fu1Lh2KYpkr82s44ccSNyjywCpHVRpnzbiEnswL
         9N6ep14/qmGDkSfXGBvJvf7qrvfGjaAnMGe/aWsSTNXD+Yb6nLAO4+nxPaf3uBhm/rPP
         /7Ljy11oK/HZ08Ktf96fCmibi8f+EX09o3sFW53Yu0FNkZL2GPF7va57i2Xn3uUIhsW4
         P46+vcqbsgZgUZogrpFne0UbLEnU0Ms0zF7bv1FZ+grTkWJVVreNBbLpdr8ciGN3MLCW
         y0Lg==
X-Gm-Message-State: AOAM53138R/GaAeq18UFVassCaDekH6A0JE86U+/XN4xkNOZzZwNywx4
        fcVNh0MyhfSTac1yY6Pd+HTDzA==
X-Google-Smtp-Source: ABdhPJyMy7k7z0Nq7lpLRDSASUYBRp7c5+96CRwDq7/6ApQXt4q76MVmMJxwJ56xh/mGeO95pXcGpA==
X-Received: by 2002:a1c:a5c8:: with SMTP id o191mr17179286wme.127.1599405577152;
        Sun, 06 Sep 2020 08:19:37 -0700 (PDT)
Received: from localhost.localdomain (208.19.23.93.rev.sfr.net. [93.23.19.208])
        by smtp.gmail.com with ESMTPSA id a15sm26420646wrn.3.2020.09.06.08.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 08:19:36 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        yong.wu@mediatek.com, Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v3 3/3] iommu/mediatek: add support for MT8167
Date:   Sun,  6 Sep 2020 17:19:28 +0200
Message-Id: <20200906151928.881209-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906151928.881209-1-fparent@baylibre.com>
References: <20200906151928.881209-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the IOMMU on MT8167

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

V3:
	* use LEGACY_IVRP_PADDR flag instead of using a platform data member
V2:
	* removed if based on m4u_plat, and using instead the new
	  has_legacy_ivrp_paddr member that was introduced in patch 2.

---
 drivers/iommu/mtk_iommu.c | 8 ++++++++
 drivers/iommu/mtk_iommu.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index b1f85a7e9346..6079f6a23c74 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -817,6 +817,13 @@ static const struct mtk_iommu_plat_data mt6779_data = {
 	.larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
 };
 
+static const struct mtk_iommu_plat_data mt8167_data = {
+	.m4u_plat     = M4U_MT8167,
+	.flags        = HAS_4GB_MODE | RESET_AXI | HAS_LEGACY_IVRP_PADDR,
+	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
+	.larbid_remap = {{0}, {1}, {2}}, /* Linear mapping. */
+};
+
 static const struct mtk_iommu_plat_data mt8173_data = {
 	.m4u_plat     = M4U_MT8173,
 	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
@@ -835,6 +842,7 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
 	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
+	{ .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
 	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
 	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
 	{}
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 122925dbe547..df32b3e3408b 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -39,6 +39,7 @@ enum mtk_iommu_plat {
 	M4U_MT2701,
 	M4U_MT2712,
 	M4U_MT6779,
+	M4U_MT8167,
 	M4U_MT8173,
 	M4U_MT8183,
 };
-- 
2.28.0

