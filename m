Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D39C83009
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E433B20730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W41tP+JQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgD1RKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgD1RKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:10:24 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5693EC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 10:10:24 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h6so17585835lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hcdO585ed6dhWyG//gXm3cGKsbtOyJyZqsLOBSwj2N8=;
        b=W41tP+JQzdv74uPdFblFj8+m0F8K5wRcvv6oCdjjnmR+B+CUicjNUvh34vFCxEB/Jf
         ALqzJ7RQLed/rJV/1aag5O65NzBsemSdRq6AMqBBXIsDD4DIrMNZ7lqERk0bxpB65r16
         EvaRgIbEma5uDXoPW1hvvHNLqUMu/9fW9U7r6OkbODrXfXeWN+Zvmii6hLBcEAI6FBOD
         8W55jA9aXTMLVizPuyAhn1r1vFHVP2dSvVAIe2uDCKscUVy3m36m0NKW9M0KcU0xg64q
         3FHp4Cehg8jB5fvgpKixnNF6wpSYecWuzLnlEVsUkv2Gi32oh+9k2PopFu9gkFZDEtO/
         NwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hcdO585ed6dhWyG//gXm3cGKsbtOyJyZqsLOBSwj2N8=;
        b=m3YsonujuoMX1RWHK3NikR44aChkkBh1JX5ikc5ZT9FDjIW2qsy3fECwiNecerC0RG
         oYI6OtModr1pcrEIYmYHXG+VVg9XCcQb5kKTV2wOi81mIlpP0kMqz6E1mWhgnYh8S4Vh
         JDuBQEC2yOG6LDMLIchwgmshGXEt8wt/+/HRcVYZYEu20J+l49gloMCJAqvx3uLOXnIL
         ItKYLlYw9aH4v6zk2oDE2EEa93/0JoqrmSyE8KBRekC53M5BU1f2ckpuOjrmDqTF3xrj
         szjFwc0vsGouFdzMK66ecMW9NwxdfWFUxK5/Xua/DxkxucqP6IDvzuaRuYRYOsKV2I9m
         PsXA==
X-Gm-Message-State: AGi0PuZKWBiNBdXDaeiksU2nHPc1uFXdyDyxKH2CS8mQ8F+OjDrYCc0a
        wstba+dvl15W2futDP8ZIO+xFg9Ob30Y8gbw
X-Google-Smtp-Source: APiQypIKj7K3jOpFa7ZhGvD1rD2Zy1rtxIlXdZBdq4XuYfv6p6653ZaPjJmlXsWzFPezTKtGBSHOPQ==
X-Received: by 2002:a19:ee18:: with SMTP id g24mr1708261lfb.67.1588093822773;
        Tue, 28 Apr 2020 10:10:22 -0700 (PDT)
Received: from e123311-lin.cambridge.arm.com (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id v2sm13064703ljv.86.2020.04.28.10.10.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 10:10:22 -0700 (PDT)
From:   Michal Orzel <michalorzel.eng@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     Michal Orzel <michalorzel.eng@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH] drm: Replace drm_modeset_lock/unlock_all with DRM_MODESET_LOCK_ALL_* helpers
Date:   Tue, 28 Apr 2020 19:10:04 +0200
Message-Id: <1588093804-30446-1-git-send-email-michalorzel.eng@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by the TODO list for the kernel DRM subsystem, replace
the deprecated functions that take/drop modeset locks with new helpers.

Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
---
 drivers/gpu/drm/drm_mode_object.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index 35c2719..901b078 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -402,12 +402,13 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
 {
 	struct drm_mode_obj_get_properties *arg = data;
 	struct drm_mode_object *obj;
+	struct drm_modeset_acquire_ctx ctx;
 	int ret = 0;
 
 	if (!drm_core_check_feature(dev, DRIVER_MODESET))
 		return -EOPNOTSUPP;
 
-	drm_modeset_lock_all(dev);
+	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
 
 	obj = drm_mode_object_find(dev, file_priv, arg->obj_id, arg->obj_type);
 	if (!obj) {
@@ -427,7 +428,7 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
 out_unref:
 	drm_mode_object_put(obj);
 out:
-	drm_modeset_unlock_all(dev);
+	DRM_MODESET_LOCK_ALL_END(ctx, ret);
 	return ret;
 }
 
@@ -449,12 +450,13 @@ static int set_property_legacy(struct drm_mode_object *obj,
 {
 	struct drm_device *dev = prop->dev;
 	struct drm_mode_object *ref;
+	struct drm_modeset_acquire_ctx ctx;
 	int ret = -EINVAL;
 
 	if (!drm_property_change_valid_get(prop, prop_value, &ref))
 		return -EINVAL;
 
-	drm_modeset_lock_all(dev);
+	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
 	switch (obj->type) {
 	case DRM_MODE_OBJECT_CONNECTOR:
 		ret = drm_connector_set_obj_prop(obj, prop, prop_value);
@@ -468,7 +470,7 @@ static int set_property_legacy(struct drm_mode_object *obj,
 		break;
 	}
 	drm_property_change_valid_put(prop, ref);
-	drm_modeset_unlock_all(dev);
+	DRM_MODESET_LOCK_ALL_END(ctx, ret);
 
 	return ret;
 }
-- 
2.7.4

