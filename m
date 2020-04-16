Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0520FC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE55521927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394313AbgDPOca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:32:30 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:59949 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896728AbgDPOFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:05:48 -0400
Received: from localhost.localdomain (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 7A4D9100009;
        Thu, 16 Apr 2020 14:05:42 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] drm/rockchip: Add per-pixel alpha support for the PX30 VOP
Date:   Thu, 16 Apr 2020 16:05:26 +0200
Message-Id: <20200416140526.262533-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compared to its predecessors, the PX30 VOP has a different register layout
for enabling per-pixel alpha. Instead of src_alpha_ctl and dst_alpha_ctl,
there is a single alpha control register. This register takes some fields
from src_alpha_ctl, but with a different layout.

Add support for the required fields to the PX30 VOP window descriptions,
which makes per-pixel-alpha formats behave correctly.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 3 +++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 9 +++++++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index d04b3492bdac..ac1b1923c4bc 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -906,6 +906,10 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 			SRC_ALPHA_CAL_M0(ALPHA_NO_SATURATION) |
 			SRC_FACTOR_M0(ALPHA_ONE);
 		VOP_WIN_SET(vop, win, src_alpha_ctl, val);
+
+		VOP_WIN_SET(vop, win, alpha_pre_mul, ALPHA_SRC_PRE_MUL);
+		VOP_WIN_SET(vop, win, alpha_mode, ALPHA_PER_PIX);
+		VOP_WIN_SET(vop, win, alpha_en, 1);
 	} else {
 		VOP_WIN_SET(vop, win, src_alpha_ctl, SRC_ALPHA_EN(0));
 	}
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 0b3d18c457b2..562b127d120b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -151,6 +151,9 @@ struct vop_win_phy {
 
 	struct vop_reg dst_alpha_ctl;
 	struct vop_reg src_alpha_ctl;
+	struct vop_reg alpha_pre_mul;
+	struct vop_reg alpha_mode;
+	struct vop_reg alpha_en;
 	struct vop_reg channel;
 };
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 7a9d979c8d5d..67bb2625db68 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -244,6 +244,9 @@ static const struct vop_win_phy px30_win0_data = {
 	.uv_mst = VOP_REG(PX30_WIN0_CBR_MST0, 0xffffffff, 0),
 	.yrgb_vir = VOP_REG(PX30_WIN0_VIR, 0x1fff, 0),
 	.uv_vir = VOP_REG(PX30_WIN0_VIR, 0x1fff, 16),
+	.alpha_pre_mul = VOP_REG(PX30_WIN0_ALPHA_CTRL, 0x1, 2),
+	.alpha_mode = VOP_REG(PX30_WIN0_ALPHA_CTRL, 0x1, 1),
+	.alpha_en = VOP_REG(PX30_WIN0_ALPHA_CTRL, 0x1, 0),
 };
 
 static const struct vop_win_phy px30_win1_data = {
@@ -256,6 +259,9 @@ static const struct vop_win_phy px30_win1_data = {
 	.dsp_st = VOP_REG(PX30_WIN1_DSP_ST, 0xffffffff, 0),
 	.yrgb_mst = VOP_REG(PX30_WIN1_MST, 0xffffffff, 0),
 	.yrgb_vir = VOP_REG(PX30_WIN1_VIR, 0x1fff, 0),
+	.alpha_pre_mul = VOP_REG(PX30_WIN1_ALPHA_CTRL, 0x1, 2),
+	.alpha_mode = VOP_REG(PX30_WIN1_ALPHA_CTRL, 0x1, 1),
+	.alpha_en = VOP_REG(PX30_WIN1_ALPHA_CTRL, 0x1, 0),
 };
 
 static const struct vop_win_phy px30_win2_data = {
@@ -269,6 +275,9 @@ static const struct vop_win_phy px30_win2_data = {
 	.dsp_st = VOP_REG(PX30_WIN2_DSP_ST0, 0x1fff1fff, 0),
 	.yrgb_mst = VOP_REG(PX30_WIN2_MST0, 0xffffffff, 0),
 	.yrgb_vir = VOP_REG(PX30_WIN2_VIR0_1, 0x1fff, 0),
+	.alpha_pre_mul = VOP_REG(PX30_WIN2_ALPHA_CTRL, 0x1, 2),
+	.alpha_mode = VOP_REG(PX30_WIN2_ALPHA_CTRL, 0x1, 1),
+	.alpha_en = VOP_REG(PX30_WIN2_ALPHA_CTRL, 0x1, 0),
 };
 
 static const struct vop_win_data px30_vop_big_win_data[] = {
-- 
2.26.0

