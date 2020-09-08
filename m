Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FA0C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88477205CB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599582219;
	bh=8CtIqjoJ1SacnqIRXbMc/xIzgI0xr7BYm3qPaqxHkiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d+1hXIHgN7FBLeTUeAvqMLNY0CAe5B+U2NRuC+jiQFpd4FoTX1/tpdvPbP1BOplYL
	 K/sP4vz51Jri5LUSfu2fYIvdABNgZgYLPIFQvzntDeYepB2wHN8HsvhLpa3OTC2SP+
	 eM1cttm+Wr3Q9r9CY2Br794Q3BOA1AU+JseLATdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbgIHQXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:23:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731485AbgIHQLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:11:43 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 894AA247A3;
        Tue,  8 Sep 2020 15:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579739;
        bh=8CtIqjoJ1SacnqIRXbMc/xIzgI0xr7BYm3qPaqxHkiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ws5DnOlIOoIvbUczQ2QFsJi6AHcq+vCfISQDAR2iUyqWlmmoe6hbeNazqUbk+Q1b4
         TOeADYni0+w8zJ8gd/vrycDrz5i/MmUGAQ1j/Rf55vw4hqqKPPhnKblyMLbQOgNyEX
         Bim1LfOSor736yoUgrR3OiBRQ+FiEKzCT/WFI3b0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 007/129] drm/msm: enable vblank during atomic commits
Date:   Tue,  8 Sep 2020 17:24:08 +0200
Message-Id: <20200908152230.064825517@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit 43906812eaab06423f56af5cca9a9fcdbb4ac454 ]

This has roughly the same effect as drm_atomic_helper_wait_for_vblanks(),
basically just ensuring that vblank accounting is enabled so that we get
valid timestamp/seqn on pageflip events.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_atomic.c | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index 5ccfad794c6a5..561bfa48841c3 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -27,6 +27,34 @@ int msm_atomic_prepare_fb(struct drm_plane *plane,
 	return msm_framebuffer_prepare(new_state->fb, kms->aspace);
 }
 
+/*
+ * Helpers to control vblanks while we flush.. basically just to ensure
+ * that vblank accounting is switched on, so we get valid seqn/timestamp
+ * on pageflip events (if requested)
+ */
+
+static void vblank_get(struct msm_kms *kms, unsigned crtc_mask)
+{
+	struct drm_crtc *crtc;
+
+	for_each_crtc_mask(kms->dev, crtc, crtc_mask) {
+		if (!crtc->state->active)
+			continue;
+		drm_crtc_vblank_get(crtc);
+	}
+}
+
+static void vblank_put(struct msm_kms *kms, unsigned crtc_mask)
+{
+	struct drm_crtc *crtc;
+
+	for_each_crtc_mask(kms->dev, crtc, crtc_mask) {
+		if (!crtc->state->active)
+			continue;
+		drm_crtc_vblank_put(crtc);
+	}
+}
+
 static void msm_atomic_async_commit(struct msm_kms *kms, int crtc_idx)
 {
 	unsigned crtc_mask = BIT(crtc_idx);
@@ -44,6 +72,8 @@ static void msm_atomic_async_commit(struct msm_kms *kms, int crtc_idx)
 
 	kms->funcs->enable_commit(kms);
 
+	vblank_get(kms, crtc_mask);
+
 	/*
 	 * Flush hardware updates:
 	 */
@@ -58,6 +88,8 @@ static void msm_atomic_async_commit(struct msm_kms *kms, int crtc_idx)
 	kms->funcs->wait_flush(kms, crtc_mask);
 	trace_msm_atomic_wait_flush_finish(crtc_mask);
 
+	vblank_put(kms, crtc_mask);
+
 	mutex_lock(&kms->commit_lock);
 	kms->funcs->complete_commit(kms, crtc_mask);
 	mutex_unlock(&kms->commit_lock);
@@ -221,6 +253,8 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
 	 */
 	kms->pending_crtc_mask &= ~crtc_mask;
 
+	vblank_get(kms, crtc_mask);
+
 	/*
 	 * Flush hardware updates:
 	 */
@@ -235,6 +269,8 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
 	kms->funcs->wait_flush(kms, crtc_mask);
 	trace_msm_atomic_wait_flush_finish(crtc_mask);
 
+	vblank_put(kms, crtc_mask);
+
 	mutex_lock(&kms->commit_lock);
 	kms->funcs->complete_commit(kms, crtc_mask);
 	mutex_unlock(&kms->commit_lock);
-- 
2.25.1



