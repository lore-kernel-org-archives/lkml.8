Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE45DC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD9D24649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jk0A5/Ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgCJNcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:32:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45748 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgCJNcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:32:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id m9so6898955wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AwwrCpJJN77zM77SbkDGUuHYvYg7rqeDy4N6zR+WgEI=;
        b=jk0A5/IebVZglpAYFFlUy843DnPN1be3LQ6z/aHJvyhSRIdqMMwJnf5E3/7SYiHdTd
         uzMP0wtkDa7HGgmsFBcvV82GlGEUTlwLFReY0u9Wb34T8kSt7YHhy8DUgGMhdooJqOMH
         wRP6r2wLDgfz7C2Ed5WsVfQxP7f2DRKv1+L0CxC51WPsWgmdXt2/WMSPqd4taJ8wKHpf
         4pf+c8y8I1Md1HeILP5JoQaiN5c6Ztl+zeAyzy19KofAFj2NNdH9Gld6kFoFx38+CmXR
         ptDZRiMMw4ALCWvhiDWWMKR3MwLY8ORmhUDzNsS8RPnrduAYcOJ84mYZOF1AgX/Y6+pk
         VhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AwwrCpJJN77zM77SbkDGUuHYvYg7rqeDy4N6zR+WgEI=;
        b=iuzzw273tN5JOn+6GcvBxuC1oYIgHwf3g2bcqaavpgycLz/BsAdhqbsS+M9ZC9Sehu
         SdDSpnHacl0a5vffHy4nxY5vD256VrzQj8Q77Ab9AI20LhU9uTUzWa6kUiah5Yj5Proc
         ChmJCYKk1bYWnRni/hd4xey1mV7lYikAWOfnVmQgduG52wXaqSs+yBY5N8NA9VaVGZ+2
         AOgCrhzi4X0S2mqgNvZtpcx4CWbBamZzVqP/7k5yVH0YZZi7jcKhqp+3pX3jWPy4VTF3
         r32TvQbnI7KfC6z44Q6zVDUICfLhurCWnCDuGrc/zsLWwMqjpjhvLcR2xEWIYFhTyv5n
         urbA==
X-Gm-Message-State: ANhLgQ3vSXgx9BT4mQk+Ao7pjvIMSnOAiWyxMd8xoPw45J6bNvLYzOWF
        72LxyCaDlu0JRYBYPKjODUE=
X-Google-Smtp-Source: ADFU+vt0XerfApImofidQNBRU6BqvoH/lgoUFVpyyUBZe1G5BorEVx5BYo26sH6tSLijvh/MdZEeGA==
X-Received: by 2002:adf:e74e:: with SMTP id c14mr28703351wrn.128.1583847127901;
        Tue, 10 Mar 2020 06:32:07 -0700 (PDT)
Received: from localhost.localdomain ([197.248.222.210])
        by smtp.googlemail.com with ESMTPSA id o7sm14047141wrx.60.2020.03.10.06.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:32:07 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 16/17] drm/debugfs: remove checks for return value of drm_debugfs functions.
Date:   Tue, 10 Mar 2020 16:31:20 +0300
Message-Id: <20200310133121.27913-17-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310133121.27913-1-wambui.karugax@gmail.com>
References: <20200310133121.27913-1-wambui.karugax@gmail.com>
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
 drivers/gpu/drm/drm_debugfs.c | 33 +++++++--------------------------
 include/drm/drm_debugfs.h     | 16 +++++++---------
 2 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 4e673d318503..e13f21642f88 100644
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
 
@@ -215,35 +214,17 @@ int drm_debugfs_init(struct drm_minor *minor, int minor_id,
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
 
 	if (drm_drv_uses_atomic_modeset(dev)) {
-		ret = drm_atomic_debugfs_init(minor);
-		if (ret) {
-			DRM_ERROR("Failed to create atomic debugfs files\n");
-			return ret;
-		}
+		drm_atomic_debugfs_init(minor);
 	}
 
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
 
 	if (dev->driver->debugfs_init) {
diff --git a/include/drm/drm_debugfs.h b/include/drm/drm_debugfs.h
index 7501e323d383..2188dc83957f 100644
--- a/include/drm/drm_debugfs.h
+++ b/include/drm/drm_debugfs.h
@@ -80,18 +80,16 @@ struct drm_info_node {
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
-static inline int drm_debugfs_create_files(const struct drm_info_list *files,
-					   int count, struct dentry *root,
-					   struct drm_minor *minor)
-{
-	return 0;
-}
+static inline void drm_debugfs_create_files(const struct drm_info_list *files,
+					    int count, struct dentry *root,
+					    struct drm_minor *minor)
+{}
 
 static inline int drm_debugfs_remove_files(const struct drm_info_list *files,
 					   int count, struct drm_minor *minor)
-- 
2.25.1

