Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2881C3B1A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6540206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581699977;
	bh=vVexZEER5O/jm8hcPhJvhiZ8rHMq++7YZdv102yM0tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vre24czQaWxP5z8v42FhEVSFfT3VNb0iXnQZJdSO28XqGdIWPmiGloD6rflvV5IAb
	 x50UMrNBbMluaMsSHz7Lr0s2STNFHk69l/dYuEt20TcoiK+7zQWcGzWxxpakIYlKH2
	 4M2SSD9NiKTA0jjhYMS1Tq/sBRADLgzNE6iGgmi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392399AbgBNQOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:14:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:43514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391113AbgBNQOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:14:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A13BC246D5;
        Fri, 14 Feb 2020 16:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696852;
        bh=vVexZEER5O/jm8hcPhJvhiZ8rHMq++7YZdv102yM0tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IhEnV7UGM8A7GwSoQ6wkT6VRDxNdd6wPyeSefu/3lPDtPUj5MORPtpjID+14vP3y1
         /W0blwTDnsMRIRONOOmMOHU+8AHsi1Odz0qgdMKQi8DIu/jmBn5r861VhxUBzXiXql
         iRLtauuhBdMuKF7dmwpLptOn8TOZY/wVJf1n9R7c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bibby Hsieh <bibby.hsieh@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 113/252] drm/mediatek: handle events when enabling/disabling crtc
Date:   Fri, 14 Feb 2020 11:09:28 -0500
Message-Id: <20200214161147.15842-113-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bibby Hsieh <bibby.hsieh@mediatek.com>

[ Upstream commit 411f5c1eacfebb1f6e40b653d29447cdfe7282aa ]

The driver currently handles vblank events only when updating planes on
an already enabled CRTC. The atomic update API however allows requesting
an event when enabling or disabling a CRTC. This currently leads to
event objects being leaked in the kernel and to events not being sent
out. Fix it.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 92ecb9bf982cf..b86ee7d25af36 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -308,6 +308,7 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
 static void mtk_crtc_ddp_hw_fini(struct mtk_drm_crtc *mtk_crtc)
 {
 	struct drm_device *drm = mtk_crtc->base.dev;
+	struct drm_crtc *crtc = &mtk_crtc->base;
 	int i;
 
 	DRM_DEBUG_DRIVER("%s\n", __func__);
@@ -329,6 +330,13 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_drm_crtc *mtk_crtc)
 	mtk_disp_mutex_unprepare(mtk_crtc->mutex);
 
 	pm_runtime_put(drm->dev);
+
+	if (crtc->state->event && !crtc->state->active) {
+		spin_lock_irq(&crtc->dev->event_lock);
+		drm_crtc_send_vblank_event(crtc, crtc->state->event);
+		crtc->state->event = NULL;
+		spin_unlock_irq(&crtc->dev->event_lock);
+	}
 }
 
 static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
-- 
2.20.1

