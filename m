Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B224C55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 549792071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikirOJ+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgDZKBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 06:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbgDZKBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 06:01:34 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2D6C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 03:01:33 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id k28so11308685lfe.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 03:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hcdO585ed6dhWyG//gXm3cGKsbtOyJyZqsLOBSwj2N8=;
        b=ikirOJ+7rRXxs7SrNlgEkDaZVMrjyvtQ7PidEJ7ixIVmpogc62gfDDT06j3E1/98JZ
         KhniI335e7UHyv+Eg17tUeY03z++QOQl/7LaVaUUK50gywj0Cc7yIcmTMMm6X6QuqGSE
         4zGMveRX/DfWj/KjsRo5XL5rPuhu7RAPSYZAWTPqbc6TCGa8np90xgfvZPE7oA90AZ9e
         dB+uQhKy8eL54f9DvEM7QVbUr0weEAB9vDUmW9ISF+z8J5m21YmfQ6aH5ld4dwrWYk7m
         T3dvULpTNzVlQ4odqRdZiera/2YRFPYD8GcSDC1gUIPKAAhApNQwHshRgAMJMLyZeZCv
         I9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hcdO585ed6dhWyG//gXm3cGKsbtOyJyZqsLOBSwj2N8=;
        b=fCBtNBhv8vb0XobxDYL9p2IDtP2ZvZk1TZvglzEPF4eTWi+28GXVRHvC7etutciJ/D
         vQBKH2fvfa3izntvjo/Xt/4HNIIhxRdTY2GN7z0gbCjrRJ8RTysL8A2aXxHlBTxNAKn3
         EiIc9Xm7dj6AR9TAFrDFq8aYJJ9yQBqZnNyMZ9rSbuengEjGQHHif7+NIDzCXf/CosR9
         rXYXxNdzQ7M4TbuJXQDjTXxJBXBjL80xKa6ytZ/RJu+vavNSWFahyoikNA677x4N2TVc
         yvRcpDzGQJAZSz4138nvOMPjIC8I/0UR9KpSIaYuiaJhP1oILXv7IDyRVUVYSX05Qkf1
         9iGw==
X-Gm-Message-State: AGi0PublJPaE9TgByokhstz0vqb4E4j6melR++JSyoCvfkI5pp565xKB
        axCzKQkoIIP+e4w+bzWpYKU=
X-Google-Smtp-Source: APiQypIMfzDbnEekij6Jd1FoTOd3sfpBap33rPZO9O0+3qrG9qvTIfqWdSKX24mM8n0Op4LXD1VC0Q==
X-Received: by 2002:ac2:5f5b:: with SMTP id 27mr12062370lfz.136.1587895291405;
        Sun, 26 Apr 2020 03:01:31 -0700 (PDT)
Received: from e123311-lin.cambridge.arm.com (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id r206sm8720231lff.65.2020.04.26.03.01.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Apr 2020 03:01:30 -0700 (PDT)
From:   Michal Orzel <michalorzel.eng@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     Michal Orzel <michalorzel.eng@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: Replace drm_modeset_lock/unlock_all with DRM_MODESET_LOCK_ALL_* helpers
Date:   Sun, 26 Apr 2020 12:01:22 +0200
Message-Id: <1587895282-2808-1-git-send-email-michalorzel.eng@gmail.com>
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

