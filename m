Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7E2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567DA207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="rxR7PRph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgHDQ4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:56:30 -0400
Received: from mxwww.masterlogin.de ([95.129.51.220]:46124 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgHDQ4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:56:15 -0400
Received: from mxout2.routing.net (unknown [192.168.10.82])
        by forward.mxwww.masterlogin.de (Postfix) with ESMTPS id 3BAA496148;
        Tue,  4 Aug 2020 16:56:11 +0000 (UTC)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout2.routing.net (Postfix) with ESMTP id 09E0A5FA21;
        Tue,  4 Aug 2020 16:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1596560171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fAxB8FMw1RdmCyat0mKDQj17vHc5n1XZwQpV53Cpf1Y=;
        b=rxR7PRph6EoO/i7t+XmJVhi+FTTq75/xxVcYLFMVjan2HNNbjK8dMftAyWXPR1W0C4A6YC
        o4gEh9HKno+xzwhUjQG5QVPZRdOO82v77Oh70Tn6serRYxMBPK3c7nYTKy0hVrurwNBSPU
        W6PiT/kJjJi1anZzh8+38XUGGakqlv8=
Received: from localhost.localdomain (fttx-pool-217.61.144.119.bambit.de [217.61.144.119])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 57CA73605F9;
        Tue,  4 Aug 2020 16:56:10 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] drm/mediatek: add ddp routing for mt7623
Date:   Tue,  4 Aug 2020 18:55:51 +0200
Message-Id: <20200804165555.75159-4-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200804165555.75159-1-linux@fw-web.de>
References: <20200804165555.75159-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

on BPi-R2/mt7623 main-path have to be routed to DPI0 (hdmi) instead of DSI0
using compatible "mt7623-mmsys" already defined in dts

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 6bd369434d9d..11e3752c670d 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -74,6 +74,19 @@ static const enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] = {
 	DDP_COMPONENT_DPI0,
 };
 
+static const enum mtk_ddp_comp_id mt7623_mtk_ddp_main[] = {
+	DDP_COMPONENT_OVL0,
+	DDP_COMPONENT_RDMA0,
+	DDP_COMPONENT_COLOR0,
+	DDP_COMPONENT_BLS,
+	DDP_COMPONENT_DPI0,
+};
+
+static const enum mtk_ddp_comp_id mt7623_mtk_ddp_ext[] = {
+	DDP_COMPONENT_RDMA1,
+	DDP_COMPONENT_DSI0,
+};
+
 static const enum mtk_ddp_comp_id mt2712_mtk_ddp_main[] = {
 	DDP_COMPONENT_OVL0,
 	DDP_COMPONENT_COLOR0,
@@ -127,6 +140,14 @@ static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
 	.shadow_register = true,
 };
 
+static const struct mtk_mmsys_driver_data mt7623_mmsys_driver_data = {
+	.main_path = mt7623_mtk_ddp_main,
+	.main_len = ARRAY_SIZE(mt7623_mtk_ddp_main),
+	.ext_path = mt7623_mtk_ddp_ext,
+	.ext_len = ARRAY_SIZE(mt7623_mtk_ddp_ext),
+	.shadow_register = true,
+};
+
 static const struct mtk_mmsys_driver_data mt2712_mmsys_driver_data = {
 	.main_path = mt2712_mtk_ddp_main,
 	.main_len = ARRAY_SIZE(mt2712_mtk_ddp_main),
@@ -422,6 +443,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 static const struct of_device_id mtk_drm_of_ids[] = {
 	{ .compatible = "mediatek,mt2701-mmsys",
 	  .data = &mt2701_mmsys_driver_data},
+	{ .compatible = "mediatek,mt7623-mmsys",
+	  .data = &mt7623_mmsys_driver_data},
 	{ .compatible = "mediatek,mt2712-mmsys",
 	  .data = &mt2712_mmsys_driver_data},
 	{ .compatible = "mediatek,mt8173-mmsys",
-- 
2.25.1

