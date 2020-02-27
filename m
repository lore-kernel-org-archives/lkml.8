Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A815CC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8043824695
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS/SQ/Ff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgB0MC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:02:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33721 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgB0MC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:02:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id x7so511833wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hzppef4BJunGtSqUEs9qFTuC3AbcvnqYyUkjMbmkHM8=;
        b=mS/SQ/FfVlFzndl6TvaUp2euA7txpxt6OY8g5TkPEKDeO3z4TWgirzqKTvzhoBsGgo
         BOKqyL2p/l6dC2l4uc9ZExg+kyi5SewPGNOuUSkizF8GspyvgQ0fL+4pFkYsOvdNe8qs
         PQpvF5LB8gvwn8sSHkBVgYs6u4oaweqHRfBOeuAAMTDYxNKl87mfQOLZhORP0WrHfYft
         Yc/ZI/1VA97xOeWkJwYRNpPZyXXjiIRkdkt+351y85GZ56+5R417lXhieIKNkc1H80Pn
         YKaW202BTYNMTz4nxl9QicYnf+gVNu23EFTMuqM50NWwNR+UDW8HzSA3npaaiHsBXex3
         sYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hzppef4BJunGtSqUEs9qFTuC3AbcvnqYyUkjMbmkHM8=;
        b=cN4zeXKTrSsOkQ8uGOAWuy3Rl1p+Knr4L8LTbOmBBgzOzvklJmoZGUmJEkcaf0ObHe
         5V8vpEtcvBmy88Pj0X26AetRp/DkxYbOu+KbYjeCbgyvi2im9ux+VGsKEZHl0Zdrwz3V
         i2T3Qua367ADLOXdB7DF55cSCWxl8/fIvMKDDjRgc+vgVuIcMTMJIj2dIXE3VkgRvBRt
         rpbZLD3NgNdtnNEOpsJG2HhKjPxZO4GKwou32z8KqpoUT/dxG7nnfFLaVKCkEU1/KYVq
         nKteCIhzvzDsiUc3LHfDy1CwMrSm/7U1HsC0fQ5/FPVYGNi4sEloojuMA2PBhcet/DrV
         2n8Q==
X-Gm-Message-State: APjAAAWbLJY2FEIn1mSl1wIwNmVSjT/tsrT6SP3KNdozIHnqta7g44aZ
        lBEIiVHazRWWXKXnwnIuK9s=
X-Google-Smtp-Source: APXvYqw1LKi63DfoJA/bsez9eXzpdWdTO2EiKYpktEZc2TxtMs4XIfVV8ZovRQEVIJI/SQc391HeHw==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr4675637wrr.352.1582804973171;
        Thu, 27 Feb 2020 04:02:53 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t10sm7655017wru.59.2020.02.27.04.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:02:52 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 03/21] drm: convert drm_debugfs functions to return void
Date:   Thu, 27 Feb 2020 15:02:14 +0300
Message-Id: <20200227120232.19413-4-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227120232.19413-1-wambui.karugax@gmail.com>
References: <20200227120232.19413-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 987d65d01356 (drm: debugfs: make drm_debugfs_create_files() never
fail), drm_debug_create_files() never fails and should return void.
Therefore, drop return value from various drm_debugfs functions that return
drm_debug_create_files() and convert the functions to return void.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/drm_atomic.c        | 8 ++++----
 drivers/gpu/drm/drm_client.c        | 8 ++++----
 drivers/gpu/drm/drm_crtc_internal.h | 2 +-
 drivers/gpu/drm/drm_framebuffer.c   | 8 ++++----
 drivers/gpu/drm/drm_internal.h      | 2 +-
 include/drm/drm_client.h            | 2 +-
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 9ccfbf213d72..965173fd0ac2 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1641,10 +1641,10 @@ static const struct drm_info_list drm_atomic_debugfs_list[] = {
 	{"state", drm_state_info, 0},
 };
 
-int drm_atomic_debugfs_init(struct drm_minor *minor)
+void drm_atomic_debugfs_init(struct drm_minor *minor)
 {
-	return drm_debugfs_create_files(drm_atomic_debugfs_list,
-			ARRAY_SIZE(drm_atomic_debugfs_list),
-			minor->debugfs_root, minor);
+	drm_debugfs_create_files(drm_atomic_debugfs_list,
+				 ARRAY_SIZE(drm_atomic_debugfs_list),
+				 minor->debugfs_root, minor);
 }
 #endif
diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
index b031b45aa8ef..2a147d1c3a13 100644
--- a/drivers/gpu/drm/drm_client.c
+++ b/drivers/gpu/drm/drm_client.c
@@ -457,10 +457,10 @@ static const struct drm_info_list drm_client_debugfs_list[] = {
 	{ "internal_clients", drm_client_debugfs_internal_clients, 0 },
 };
 
-int drm_client_debugfs_init(struct drm_minor *minor)
+void drm_client_debugfs_init(struct drm_minor *minor)
 {
-	return drm_debugfs_create_files(drm_client_debugfs_list,
-					ARRAY_SIZE(drm_client_debugfs_list),
-					minor->debugfs_root, minor);
+	drm_debugfs_create_files(drm_client_debugfs_list,
+				 ARRAY_SIZE(drm_client_debugfs_list),
+				 minor->debugfs_root, minor);
 }
 #endif
diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
index 16f2413403aa..1b620ba9244b 100644
--- a/drivers/gpu/drm/drm_crtc_internal.h
+++ b/drivers/gpu/drm/drm_crtc_internal.h
@@ -224,7 +224,7 @@ int drm_mode_dirtyfb_ioctl(struct drm_device *dev,
 /* drm_atomic.c */
 #ifdef CONFIG_DEBUG_FS
 struct drm_minor;
-int drm_atomic_debugfs_init(struct drm_minor *minor);
+void drm_atomic_debugfs_init(struct drm_minor *minor);
 #endif
 
 int __drm_atomic_helper_disable_plane(struct drm_plane *plane,
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 57ac94ce9b9e..0375b3d7f8d0 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -1207,10 +1207,10 @@ static const struct drm_info_list drm_framebuffer_debugfs_list[] = {
 	{ "framebuffer", drm_framebuffer_info, 0 },
 };
 
-int drm_framebuffer_debugfs_init(struct drm_minor *minor)
+void drm_framebuffer_debugfs_init(struct drm_minor *minor)
 {
-	return drm_debugfs_create_files(drm_framebuffer_debugfs_list,
-				ARRAY_SIZE(drm_framebuffer_debugfs_list),
-				minor->debugfs_root, minor);
+	drm_debugfs_create_files(drm_framebuffer_debugfs_list,
+				 ARRAY_SIZE(drm_framebuffer_debugfs_list),
+				 minor->debugfs_root, minor);
 }
 #endif
diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index aeec2e68d772..f0c99d00b201 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -235,7 +235,7 @@ int drm_syncobj_query_ioctl(struct drm_device *dev, void *data,
 /* drm_framebuffer.c */
 void drm_framebuffer_print_info(struct drm_printer *p, unsigned int indent,
 				const struct drm_framebuffer *fb);
-int drm_framebuffer_debugfs_init(struct drm_minor *minor);
+void drm_framebuffer_debugfs_init(struct drm_minor *minor);
 
 /* drm_hdcp.c */
 int drm_setup_hdcp_srm(struct class *drm_class);
diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
index 3ed5dee899fd..7402f852d3c4 100644
--- a/include/drm/drm_client.h
+++ b/include/drm/drm_client.h
@@ -188,6 +188,6 @@ int drm_client_modeset_dpms(struct drm_client_dev *client, int mode);
 	drm_for_each_connector_iter(connector, iter) \
 		if (connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
 
-int drm_client_debugfs_init(struct drm_minor *minor);
+void drm_client_debugfs_init(struct drm_minor *minor);
 
 #endif
-- 
2.25.0

