Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCE5C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7469206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701757;
	bh=mD/81wOsSpiXRMLsMfU2sksf0W/6xASYrsz7X25q6NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s2wnWItOiJDOa0Zuhu+JgsI8Kz5GkP66E7FYQ9g4z5xOHliFcPIcXBLySPJJYVc6W
	 HAVHKFJiTjP7Frr3m+1yAGfYq2jZwnJMvODUcxaLeNha11/5RTm5pE+XAzBoRw1XYj
	 qqH6ubPNgA/+yuYCvL9Yg++4OGS56+92zmS1nNlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbgBNRfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:35:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:55924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390237AbgBNQFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:05:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BDF0217F4;
        Fri, 14 Feb 2020 16:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696347;
        bh=mD/81wOsSpiXRMLsMfU2sksf0W/6xASYrsz7X25q6NI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k9ZiJf55MtZtRRa6f6/c7ubV/a8+g+Xtb4WmJUsQCLI1alIBzV1dXRfPkJ7Th6hj2
         tJEaGcNqABnKUHDGZl/EmsbaF79ImDz3JCX3tvbIgieVYZ5+9NdDtdcvsiiA5f2AuN
         1SmbWZ+DPmAlpg3Zp9Gj2d7Yr1wIShLb43VqNJm4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 182/459] gpu/drm: ingenic: Avoid null pointer deference in plane atomic update
Date:   Fri, 14 Feb 2020 10:57:12 -0500
Message-Id: <20200214160149.11681-182-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit 354b051c5dcbeb35bbfd5d54161364fc7a75a58a ]

It is possible that there is no drm_framebuffer associated with a given
plane state.

v2: Handle drm_plane->state which can be NULL too

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20191210144142.33143-2-paul@crapouillou.net
# *** extracted tags ***
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index 2e2ed653e9c6b..f156f245fdecf 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -371,14 +371,18 @@ static void ingenic_drm_plane_atomic_update(struct drm_plane *plane,
 	struct ingenic_drm *priv = drm_plane_get_priv(plane);
 	struct drm_plane_state *state = plane->state;
 	unsigned int width, height, cpp;
+	dma_addr_t addr;
 
-	width = state->crtc->state->adjusted_mode.hdisplay;
-	height = state->crtc->state->adjusted_mode.vdisplay;
-	cpp = state->fb->format->cpp[plane->index];
+	if (state && state->fb) {
+		addr = drm_fb_cma_get_gem_addr(state->fb, state, 0);
+		width = state->crtc->state->adjusted_mode.hdisplay;
+		height = state->crtc->state->adjusted_mode.vdisplay;
+		cpp = state->fb->format->cpp[plane->index];
 
-	priv->dma_hwdesc->addr = drm_fb_cma_get_gem_addr(state->fb, state, 0);
-	priv->dma_hwdesc->cmd = width * height * cpp / 4;
-	priv->dma_hwdesc->cmd |= JZ_LCD_CMD_EOF_IRQ;
+		priv->dma_hwdesc->addr = addr;
+		priv->dma_hwdesc->cmd = width * height * cpp / 4;
+		priv->dma_hwdesc->cmd |= JZ_LCD_CMD_EOF_IRQ;
+	}
 }
 
 static void ingenic_drm_encoder_atomic_mode_set(struct drm_encoder *encoder,
-- 
2.20.1

