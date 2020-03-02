Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104FBC3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4C72166E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HrqcWs/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgCBLWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 06:22:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38222 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgCBLWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 06:22:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id t11so5680565wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 03:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4twAZzpqE7OZHthVARi42fhoM9wMIzUTa1b3XIbc4u0=;
        b=HrqcWs/tM1UMeqgqQDpvy3jpqRSAaC9KOUedVpPAAvQXG3RKGJEGAKffHVNPColesQ
         XmJC8gVr91n0yVRfBh5hJIgxN9YGBInf8dxyQV9MOR+vauyVfx/rs1trGy5WKr+ppnSY
         xPNcptl/HEFg1e2S8eAWVFv4Q5y9PVMn9NqIV3MYzpRlBTcz8yFMsOTa1HGbIGY1K7Gt
         GsFLln6giCDJ1dDj49uhcLCoEnMDB4qd9U0rI0iX9KSIwHGJNAc03zON9tAvUnNuiZdQ
         xeZEus/ihesqcBQ/4+ERXw6UkZGG0pE7kquuOyrm+1jE6cQq8pWiEkXWYx+nD0T4SWzN
         oCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4twAZzpqE7OZHthVARi42fhoM9wMIzUTa1b3XIbc4u0=;
        b=qYaRLJBud7lVs+zteAHr4ZBRzybCmAoDP/dLel5r5caL2EEygCeRyzpPb68FRNhvDL
         EMzZFzO5G0Mwe4h9dvB6z4zdbOD9K8znLGGPdQS57OmtU5ZDZimQLqnGGs17RQHiw8Ch
         WAtspgLcDxNcKWJwauKqWSaS+gsYRtQ9rIGrkzGNRIrUQ+BhyrAT2pHl3LUjMYosnW8n
         q+w98AjdU9gCcxwKBq86PZGDS6DOptqpO4b4l2K1kuUHctf2FziLW+FT7AVVSWPONMPk
         XgrXeD/nLizqzRMGfTktv86DGmZkp7BuN12qFo7JSAw53inv7Czkm++rwn1Xpp8WbOx8
         5riw==
X-Gm-Message-State: APjAAAUJYCFxrH8dTbGY6eH24vRqJav/vyBtOmr7DWedpGvtLk5ksSiK
        2Wb703EZKW9FKHrYvZjbBOw6Dw==
X-Google-Smtp-Source: APXvYqwoftzxlJ69VQL0xqAKsfOX0Z+thgz1rFA+uNAT/dQGnLIN+PHomnMXJLjLb67L3CQ3sbGx9g==
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr21399020wrn.209.1583148140211;
        Mon, 02 Mar 2020 03:22:20 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ecba:5540:6f5c:582a:cc84:32f5])
        by smtp.gmail.com with ESMTPSA id j14sm28398441wrn.32.2020.03.02.03.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 03:22:19 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     matthias.bgg@gmail.com, joro@8bytes.org, yong.wu@mediatek.com,
        ck.hu@mediatek.com, Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2 2/3] iommu/mediatek: add pdata member for legacy ivrp paddr
Date:   Mon,  2 Mar 2020 12:21:51 +0100
Message-Id: <20200302112152.2887131-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200302112152.2887131-1-fparent@baylibre.com>
References: <20200302112152.2887131-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new platform data member in order to select which IVRP_PADDR
format is used by an SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

v2: new patch

---
 drivers/iommu/mtk_iommu.c | 3 ++-
 drivers/iommu/mtk_iommu.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 95945f467c03..78cb14ab7dd0 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -569,7 +569,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
 	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
 
-	if (data->plat_data->m4u_plat == M4U_MT8173)
+	if (data->plat_data->has_legacy_ivrp_paddr)
 		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
 	else
 		regval = lower_32_bits(data->protect_base) |
@@ -786,6 +786,7 @@ static const struct mtk_iommu_plat_data mt8173_data = {
 	.m4u_plat     = M4U_MT8173,
 	.has_4gb_mode = true,
 	.has_bclk     = true,
+	.has_legacy_ivrp_paddr = true;
 	.reset_axi    = true,
 	.larbid_remap = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */
 };
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index ea949a324e33..4696ba027a71 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -42,6 +42,7 @@ struct mtk_iommu_plat_data {
 	bool                has_bclk;
 	bool                has_vld_pa_rng;
 	bool                reset_axi;
+	bool                has_legacy_ivrp_paddr;
 	unsigned char       larbid_remap[MTK_LARB_NR_MAX];
 };
 
-- 
2.25.0

