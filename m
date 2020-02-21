Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0B8C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8562067D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582274076;
	bh=M5bDtOSaKOorgrGmBZmg62PQvqREkOUogOkzfz94Uy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dwdrA3vyD1ER4oBKZX64Jsd5TKubXNQD1JZvngHhRmia8YFQMqP3Zjzwt7OxxzlmQ
	 hcVUO9z+bn6xyI2nZ/W7x5x0leuqx10JU8zKwCUMH5I1pnSh+uqZ/7zH3Kk2BBCCpR
	 J3+X97EdY3/yiYeRBlEFEY3QAaJiIsEle6tUV3qU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbgBUIJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:09:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732322AbgBUIJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:09:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D1FD20722;
        Fri, 21 Feb 2020 08:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272552;
        bh=M5bDtOSaKOorgrGmBZmg62PQvqREkOUogOkzfz94Uy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZrhSOpTNqinFZWLi1ihQykLkp/uc9h/sBWHJRJXIM1Ti/t6zH7oWDazEq4u+ozDZB
         zZcU1C0tw5D8FkWfksQSbQ/HlTl1VraO8hlbnxUJlILUK0ABgxAXWmMdjuQdXwPzAw
         SfAeTrQvhj/aEBIcDf1kg/fCqL+EmWHvRXiaRDkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 149/344] drm/mediatek: handle events when enabling/disabling crtc
Date:   Fri, 21 Feb 2020 08:39:08 +0100
Message-Id: <20200221072402.322430311@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 34a7317557912..0b3d284d19569 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -298,6 +298,7 @@ err_pm_runtime_put:
 static void mtk_crtc_ddp_hw_fini(struct mtk_drm_crtc *mtk_crtc)
 {
 	struct drm_device *drm = mtk_crtc->base.dev;
+	struct drm_crtc *crtc = &mtk_crtc->base;
 	int i;
 
 	DRM_DEBUG_DRIVER("%s\n", __func__);
@@ -319,6 +320,13 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_drm_crtc *mtk_crtc)
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



