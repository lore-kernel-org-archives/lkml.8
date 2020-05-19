Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7421FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5279A207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgESJk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 05:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgESJkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 05:40:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA18BC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 02:40:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C65332A03BE
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] drm/mediatek: mtk_mt8173_hdmi_phy: Remove unnused const variables
Date:   Tue, 19 May 2020 11:40:45 +0200
Message-Id: <20200519094045.2447940-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some `static const u8` variables that are not used, this
triggers a warning building with `make W=1`, it is safe to remove them,
so do it and make the compiler more happy.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 .../gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c    | 48 -------------------
 1 file changed, 48 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
index 1c3575372230..827b93786fac 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
@@ -107,54 +107,6 @@
 #define RGS_HDMITX_5T1_EDG		(0xf << 4)
 #define RGS_HDMITX_PLUG_TST		BIT(0)
 
-static const u8 PREDIV[3][4] = {
-	{0x0, 0x0, 0x0, 0x0},	/* 27Mhz */
-	{0x1, 0x1, 0x1, 0x1},	/* 74Mhz */
-	{0x1, 0x1, 0x1, 0x1}	/* 148Mhz */
-};
-
-static const u8 TXDIV[3][4] = {
-	{0x3, 0x3, 0x3, 0x2},	/* 27Mhz */
-	{0x2, 0x1, 0x1, 0x1},	/* 74Mhz */
-	{0x1, 0x0, 0x0, 0x0}	/* 148Mhz */
-};
-
-static const u8 FBKSEL[3][4] = {
-	{0x1, 0x1, 0x1, 0x1},	/* 27Mhz */
-	{0x1, 0x0, 0x1, 0x1},	/* 74Mhz */
-	{0x1, 0x0, 0x1, 0x1}	/* 148Mhz */
-};
-
-static const u8 FBKDIV[3][4] = {
-	{19, 24, 29, 19},	/* 27Mhz */
-	{19, 24, 14, 19},	/* 74Mhz */
-	{19, 24, 14, 19}	/* 148Mhz */
-};
-
-static const u8 DIVEN[3][4] = {
-	{0x2, 0x1, 0x1, 0x2},	/* 27Mhz */
-	{0x2, 0x2, 0x2, 0x2},	/* 74Mhz */
-	{0x2, 0x2, 0x2, 0x2}	/* 148Mhz */
-};
-
-static const u8 HTPLLBP[3][4] = {
-	{0xc, 0xc, 0x8, 0xc},	/* 27Mhz */
-	{0xc, 0xf, 0xf, 0xc},	/* 74Mhz */
-	{0xc, 0xf, 0xf, 0xc}	/* 148Mhz */
-};
-
-static const u8 HTPLLBC[3][4] = {
-	{0x2, 0x3, 0x3, 0x2},	/* 27Mhz */
-	{0x2, 0x3, 0x3, 0x2},	/* 74Mhz */
-	{0x2, 0x3, 0x3, 0x2}	/* 148Mhz */
-};
-
-static const u8 HTPLLBR[3][4] = {
-	{0x1, 0x1, 0x0, 0x1},	/* 27Mhz */
-	{0x1, 0x2, 0x2, 0x1},	/* 74Mhz */
-	{0x1, 0x2, 0x2, 0x1}	/* 148Mhz */
-};
-
 static int mtk_hdmi_pll_prepare(struct clk_hw *hw)
 {
 	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
-- 
2.26.2

