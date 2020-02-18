Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDC0C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A7120801
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am2O2pZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgBRR3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:29:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33714 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgBRR3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:29:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id u6so25026785wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 09:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wwL9O44eOnrF5PjPfAyWlT4w7nkYP4UBXVJh3n9vMfc=;
        b=am2O2pZyBLylTFqGX2JTuFZunpkj/ZxkeIQyVyR88aZLZUhF8aAkn6PdUMj4HZ5oaF
         mDaJvPw7+fcZe5g/3iLC8oZRbjQ+ZbR5WCGFdG9hDKq3H19zjWjUPEdUucax8TiWFk/2
         1WYwjpKlWVU8pqiWJgaFhNjMX/YY31lGHlWz/lu4rw0UnyyAKjiD3PYpg8lb8z3URbsY
         nkYpdr2yQA9y9KwYQmrXRhCk2v4G725jRuAFdC866bGDkmiK6kIwj6LClgLYMKfdj5UQ
         wJj6YYuVyB03LnXt4wybeebFC0yu1g72f8+AzR8x+79uMwwqj6Ii4wrR3ScQAjVAsFw9
         82tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wwL9O44eOnrF5PjPfAyWlT4w7nkYP4UBXVJh3n9vMfc=;
        b=MEKQd/lN83UAjT7aUgKNu+gCEcR+9qBPNURSLNILTdndaNG867jQDsW8bKVPy2WXxR
         Z0Ht+YH6/0qkhgxetmBUWePq9+WbC2I/ckmRsOsUS2VAl+C4QvWucxmvrWcScdx9esGi
         EtKfYDPb3C/3NOX7c0ZTRtJ8S+3KgdQpkP47zgefoH/77zaJAuzYBIMpLwuHQiHhlZbr
         Fmk8npM71xP6I6dLLkuRhPT7RDpnZQ9Ei9n+kTwWBOSCAIQ2Iy8VT7sh6YbBS5hdRrcK
         /CDWvAHOWlJDh1ZBcLpZXtBlTPMu2YK/FHHIoGAclFI0I4N7wUx4KEgFB86LlqEevxVv
         nVKw==
X-Gm-Message-State: APjAAAXi/bnJ5p+t3uowqHilhyx1QOFzZ67llZm/ViUqe7v4eU5EG4dB
        wQOGXEWBWkR44CfUURJO6GU=
X-Google-Smtp-Source: APXvYqysw2Xo8W/uznC3FSGp7tRdym0XWOg8tWWpis3qb2fqBekELqZhMKwVAgpD8Gr0608ynOlLsg==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr31698035wrk.53.1582046951125;
        Tue, 18 Feb 2020 09:29:11 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t13sm6998757wrw.19.2020.02.18.09.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 09:29:10 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH 2/2] drm: convert drm_debugfs functions to return void
Date:   Tue, 18 Feb 2020 20:28:21 +0300
Message-Id: <20200218172821.18378-10-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218172821.18378-1-wambui.karugax@gmail.com>
References: <20200218172821.18378-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As drm_debug_create_files will be converted to return void,
drop return value from various drm_debugfs functions that return
drm_debug_create_files and convert the functions to return void.

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
index 65c46ed049c5..d619f3340084 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1640,10 +1640,10 @@ static const struct drm_info_list drm_atomic_debugfs_list[] = {
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

