Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DFBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27616207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgFPGvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:51:17 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:17967 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgFPGvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:51:17 -0400
Received: from njvxl5505.vivo.xyz (unknown [157.0.31.125])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 82C2F2616A3;
        Tue, 16 Jun 2020 14:51:13 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH v2] drm/mediatek: remove unnecessary conversion to bool
Date:   Tue, 16 Jun 2020 14:51:01 +0800
Message-Id: <20200616065102.15756-1-bernard@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUweQ09JSElITExLVkpOQklJQktJTEhMQ09VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P006IRw*Czg3Kw9LSQkSMSE#
        Qy4wFEpVSlVKTkJJSUJLSUxPSk9IVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU5ZV1kIAVlBSUlNSDcG
X-HM-Tid: 0a72bbe5699f9375kuws82c2f2616a3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function mtk_dsi_clk_hs_state, remove unnecessary conversion
to bool return, this change is to make the code a bit readable.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
Changes since V1:
*optimize to make the code a bit more clear.

Link for V1:
*https://lore.kernel.org/patchwork/patch/1255327/
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 4491e64b3f06..840cc9b9efc8 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -316,10 +316,7 @@ static void mtk_dsi_lane0_ulp_mode_leave(struct mtk_dsi *dsi)
 
 static bool mtk_dsi_clk_hs_state(struct mtk_dsi *dsi)
 {
-	u32 tmp_reg1;
-
-	tmp_reg1 = readl(dsi->regs + DSI_PHY_LCCON);
-	return ((tmp_reg1 & LC_HS_TX_EN) == 1);
+	return (readl(dsi->regs + DSI_PHY_LCCON) & LC_HS_TX_EN);
 }
 
 static void mtk_dsi_clk_hs_mode(struct mtk_dsi *dsi, bool enter)
-- 
2.17.1

