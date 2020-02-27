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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376E9C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F95924692
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSNUPEjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgB0MCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:02:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40060 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgB0MCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:02:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so3085122wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=peQxcIwm+53AZheiLwWVbUK9WDSs/oWzD+2yvLVaFDQ=;
        b=sSNUPEjUQ4P/FmERt8XhONyzKkRQaD7ZGIwPeYhmN25NcUNbTsckK3pXW/4lpN0nPH
         FIHBTRB51szqJbtG2pxhVutWcyhWABcBWVTMjLF0TvaagvGR9omRwsaz4XE+7EgoQDWA
         lJC6LHBqY8hjtg2VOEuzwIsu5m5Bs7bYwyRTunNjCdvBhN4WV6AOx+DWAnWSEvCLhg8y
         udzF37krHLLtAD2A8QLeK6cBbvuxXOWz+cf5OteaBoh2xQDUnNf+LyRIRHNvnHUOH3Dh
         wIKVRhQIL891JC1j3qCyglBsxuTa+VNPtGldxMkIImoTLurQ8zBOsopSQgY12xnvLU39
         KzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=peQxcIwm+53AZheiLwWVbUK9WDSs/oWzD+2yvLVaFDQ=;
        b=hGCY4iWRVWO37w2fSN5YZZEa8SXDBdaP5nNqIuZUVrux9O6Xj1rPQHPtiaUeSJxYhF
         JvWrMqAk+FIkJY3J0ERRBg3Vs/EWmBi6r3VUJI2Gz7DbyUl6+pGVvd7Xs93a5iYwz+d5
         xvR0+eIAEBUhxkZwmzcCy7PUdgXY2Y/M6HXPZgM4XVPT2h0GaKnKSxAKpBBwlRE/OBFB
         G7z+bJRkYcnEoASN2luksNjaiwSWuNKZswyMGI0SuFBOpfqdQ8Ce2RdWSeEfPE+Wwg1b
         YCFKaG1nnGr1ott7BLrlGrwnum89Xw0Hv6DFOGJyMsSP8CLHnyes5EqtJ73PcgggDsu0
         kgWA==
X-Gm-Message-State: APjAAAUpsGrhflbXHc+1xRODTvj23OWLs8DYoZaIXNx66aIbs2yZ/mqu
        e8zo9vTGd6XfGFFxgIocjHiaFa9k72E=
X-Google-Smtp-Source: APXvYqwUpYHhUiPj+1sUDyusbZPVe/8nAXMpyaeuNf1rhtqmIlfapyheEuIWIS8xSNqoryCbmKC7fQ==
X-Received: by 2002:a05:600c:21c4:: with SMTP id x4mr5045200wmj.147.1582804964957;
        Thu, 27 Feb 2020 04:02:44 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t10sm7655017wru.59.2020.02.27.04.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:02:44 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 01/21] drm/debugfs: remove checks for return value of drm_debugfs functions.
Date:   Thu, 27 Feb 2020 15:02:12 +0300
Message-Id: <20200227120232.19413-2-wambui.karugax@gmail.com>
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
fail), there is no need to check the return value of
drm_debugfs_create_files(). Therefore, remove remove unnecessary checks
and error handling statement blocks for its return value.

These changes also enable changing drm_debugfs_create_files() to return
void.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/drm_debugfs.c | 49 ++++++++---------------------------
 include/drm/drm_debugfs.h     |  6 ++---
 2 files changed, 14 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 4e673d318503..d77d2bdcfb2d 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -172,8 +172,8 @@ static const struct file_operations drm_debugfs_fops = {
  * &struct drm_info_list in the given root directory. These files will be removed
  * automatically on drm_debugfs_cleanup().
  */
-int drm_debugfs_create_files(const struct drm_info_list *files, int count,
-			     struct dentry *root, struct drm_minor *minor)
+void drm_debugfs_create_files(const struct drm_info_list *files, int count,
+			      struct dentry *root, struct drm_minor *minor)
 {
 	struct drm_device *dev = minor->dev;
 	struct drm_info_node *tmp;
@@ -199,7 +199,6 @@ int drm_debugfs_create_files(const struct drm_info_list *files, int count,
 		list_add(&tmp->list, &minor->debugfs_list);
 		mutex_unlock(&minor->debugfs_lock);
 	}
-	return 0;
 }
 EXPORT_SYMBOL(drm_debugfs_create_files);
 
@@ -208,56 +207,30 @@ int drm_debugfs_init(struct drm_minor *minor, int minor_id,
 {
 	struct drm_device *dev = minor->dev;
 	char name[64];
-	int ret;
 
 	INIT_LIST_HEAD(&minor->debugfs_list);
 	mutex_init(&minor->debugfs_lock);
 	sprintf(name, "%d", minor_id);
 	minor->debugfs_root = debugfs_create_dir(name, root);
 
-	ret = drm_debugfs_create_files(drm_debugfs_list, DRM_DEBUGFS_ENTRIES,
-				       minor->debugfs_root, minor);
-	if (ret) {
-		debugfs_remove(minor->debugfs_root);
-		minor->debugfs_root = NULL;
-		DRM_ERROR("Failed to create core drm debugfs files\n");
-		return ret;
-	}
+	drm_debugfs_create_files(drm_debugfs_list, DRM_DEBUGFS_ENTRIES,
+				 minor->debugfs_root, minor);
 
-	if (drm_drv_uses_atomic_modeset(dev)) {
-		ret = drm_atomic_debugfs_init(minor);
-		if (ret) {
-			DRM_ERROR("Failed to create atomic debugfs files\n");
-			return ret;
-		}
-	}
+	if (drm_drv_uses_atomic_modeset(dev))
+		drm_atomic_debugfs_init(minor);
 
 	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
-		ret = drm_framebuffer_debugfs_init(minor);
-		if (ret) {
-			DRM_ERROR("Failed to create framebuffer debugfs file\n");
-			return ret;
-		}
+		drm_framebuffer_debugfs_init(minor);
 
-		ret = drm_client_debugfs_init(minor);
-		if (ret) {
-			DRM_ERROR("Failed to create client debugfs file\n");
-			return ret;
-		}
+		drm_client_debugfs_init(minor);
 	}
 
-	if (dev->driver->debugfs_init) {
-		ret = dev->driver->debugfs_init(minor);
-		if (ret) {
-			DRM_ERROR("DRM: Driver failed to initialize "
-				  "/sys/kernel/debug/dri.\n");
-			return ret;
-		}
-	}
+	if (dev->driver->debugfs_init)
+		dev->driver->debugfs_init(minor);
+
 	return 0;
 }
 
-
 int drm_debugfs_remove_files(const struct drm_info_list *files, int count,
 			     struct drm_minor *minor)
 {
diff --git a/include/drm/drm_debugfs.h b/include/drm/drm_debugfs.h
index 7501e323d383..4d028cc1fd37 100644
--- a/include/drm/drm_debugfs.h
+++ b/include/drm/drm_debugfs.h
@@ -80,9 +80,9 @@ struct drm_info_node {
 };
 
 #if defined(CONFIG_DEBUG_FS)
-int drm_debugfs_create_files(const struct drm_info_list *files,
-			     int count, struct dentry *root,
-			     struct drm_minor *minor);
+void drm_debugfs_create_files(const struct drm_info_list *files,
+			      int count, struct dentry *root,
+			      struct drm_minor *minor);
 int drm_debugfs_remove_files(const struct drm_info_list *files,
 			     int count, struct drm_minor *minor);
 #else
-- 
2.25.0

