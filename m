Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846A1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61AEC207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7A/Z8ij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgETLmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETLmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:42:10 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19EDC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:42:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p21so1285623pgm.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dKXzWhu+iFDbZVZX01MEhKWZN1XL+SAEWrAks0ZBIaY=;
        b=C7A/Z8ijmJS3emxjDt0Rl1yt9Gwhnb2K6HtJgynS6ev0QY/kT1M9KjV3nXkHvhcwj+
         JN63xyk9+pMYyyuuMLRA3Hznk8U8QNSmOtW0KVmFydM3NcaCdKObI6v8Z3JbjKXz8y/S
         T1frAhHCzi4356lXy52ThG/ohKiJtIq4EGos8+W4VB0eV+r6CRVDig+HuNgbhdy3rquz
         vUuHbMKvsmDra2KORC4sQSDAw8W7I//vSsQdTvf9jlVnxgrNByZjK/7+NVO8w4Bor3LS
         XaxaTrSKKKJnVLAM5b8jr7qeWSWUn+HO8kB6AHh+FdnYOemXnEFR4BvlUfwpRn9gckcN
         qESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dKXzWhu+iFDbZVZX01MEhKWZN1XL+SAEWrAks0ZBIaY=;
        b=Z3GAR8TmEixPZ+Mgczb23G4V4L8VR599ZTOFuQ8uE7grET22QpdJYxqqLd+6mOJk1j
         osvRSQ01w8uD4tmMNNjgakbWM9fyrNYRybPrNYtaWM5fkFUmyCQ0zJB4Z2zzBcqRSbff
         QxoaUtlFY+eTZIFgijDuLe64Jl7gJkYFau5BkVQ6YiIHez1KTuSsTYH959bL1EFx3cdS
         VM5mpScgUB2HbNjjYxCJyX0HF43i1qAwkpQakJ/PXz2o64QwzgznLrUX+YXL7U7VSuWH
         stteI44pGgJSjffOPfSQ1Ct8VDgxnTSShuQUkJZCVSi7oYLw8rKKm8rj5iyS7R2s0/6i
         eawQ==
X-Gm-Message-State: AOAM532odaA6isV98xsjqlJUkSBLJTr0i0qANYSSS0dKwqYaKMDti9qj
        zCo//n7GJl0E6Lp+4D/GKUTBl8Z7doQ=
X-Google-Smtp-Source: ABdhPJxaAdJx2bktnsQOfRncfFbAGb2TcQ6dQaypHVTQuqvd+1pVnW5EjUbIHBaXY5FFqodXHkD2Zw==
X-Received: by 2002:a63:b904:: with SMTP id z4mr3804221pge.25.1589974928484;
        Wed, 20 May 2020 04:42:08 -0700 (PDT)
Received: from localhost.localdomain ([106.254.212.20])
        by smtp.gmail.com with ESMTPSA id x6sm2104450pfn.90.2020.05.20.04.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 04:42:07 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Sidong Yang <realwakka@gmail.com>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: Replace deprecated function in drm_crtc_helper
Date:   Wed, 20 May 2020 20:41:56 +0900
Message-Id: <20200520114156.26480-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace deprecated function drm_modeset_lock/unlock_all with
helper function DRM_MODESET_LOCK_ALL_BEGIN/END.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 drivers/gpu/drm/drm_crtc_helper.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index a4d36aca45ea..c7379c719952 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -217,11 +217,14 @@ static void __drm_helper_disable_unused_functions(struct drm_device *dev)
  */
 void drm_helper_disable_unused_functions(struct drm_device *dev)
 {
+	struct drm_modeset_acquire_ctx ctx;
+	int ret;
+
 	WARN_ON(drm_drv_uses_atomic_modeset(dev));
 
-	drm_modeset_lock_all(dev);
+	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE, ret);
 	__drm_helper_disable_unused_functions(dev);
-	drm_modeset_unlock_all(dev);
+	DRM_MODESET_LOCK_ALL_END(ctx, ret);
 }
 EXPORT_SYMBOL(drm_helper_disable_unused_functions);
 
@@ -938,13 +941,14 @@ void drm_helper_resume_force_mode(struct drm_device *dev)
 {
 	struct drm_crtc *crtc;
 	struct drm_encoder *encoder;
+	struct drm_modeset_acquire_ctx ctx;
 	const struct drm_crtc_helper_funcs *crtc_funcs;
 	int encoder_dpms;
-	bool ret;
+	int ret;
 
 	WARN_ON(drm_drv_uses_atomic_modeset(dev));
 
-	drm_modeset_lock_all(dev);
+	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE, ret);
 	drm_for_each_crtc(crtc, dev) {
 
 		if (!crtc->enabled)
@@ -979,7 +983,7 @@ void drm_helper_resume_force_mode(struct drm_device *dev)
 
 	/* disable the unused connectors while restoring the modesetting */
 	__drm_helper_disable_unused_functions(dev);
-	drm_modeset_unlock_all(dev);
+	DRM_MODESET_LOCK_ALL_END(ctx, ret);
 }
 EXPORT_SYMBOL(drm_helper_resume_force_mode);
 
@@ -999,9 +1003,10 @@ EXPORT_SYMBOL(drm_helper_resume_force_mode);
 int drm_helper_force_disable_all(struct drm_device *dev)
 {
 	struct drm_crtc *crtc;
+	struct drm_modeset_acquire_ctx ctx;
 	int ret = 0;
 
-	drm_modeset_lock_all(dev);
+	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE, ret);
 	drm_for_each_crtc(crtc, dev)
 		if (crtc->enabled) {
 			struct drm_mode_set set = {
@@ -1013,7 +1018,7 @@ int drm_helper_force_disable_all(struct drm_device *dev)
 				goto out;
 		}
 out:
-	drm_modeset_unlock_all(dev);
+	DRM_MODESET_LOCK_ALL_END(ctx, ret);
 	return ret;
 }
 EXPORT_SYMBOL(drm_helper_force_disable_all);
-- 
2.17.1

