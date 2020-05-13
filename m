Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78A4CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C2F20769
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G26NjolY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbgEMLmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 07:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgEMLmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:42:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE59C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 04:42:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g14so11653080wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 04:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jxE409dH/4Upz04x81rZgDRqIGYrdN0NQ92McvYwahc=;
        b=G26NjolYY71SSgYOvfQ9hFGOJjAVarSFQ5F+YvV+fDnbit1ULIMKeFVluFKNr1RFha
         MDkl0esxdkvTkoMhf+sblaFcd3hyxXgsSrUnaOu7xjqRU3IcwHuzcOr8SxCtnx0JaA02
         bL2GvGPHtY9UywWis73WzRirPpk5G45Q3bXxpJmxjeAPSFMXxW/6pDZ+HG90L5O/41wY
         j9JAIirRI8CLT7dGWEcUcf2KqxnK/jpyop0dV0o2xeJGnYVqp/vysGEVQ/Sy+96jQL4o
         6xX7SvYi4gMRveypIMyvXIww2/YDUuy7edI5e/N6ixClHgra4ctF4Sb3M9LMuniN9UzX
         Yj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jxE409dH/4Upz04x81rZgDRqIGYrdN0NQ92McvYwahc=;
        b=eLtP3GBCBFpE8UT4I3cqoITrojmBQhZXc/Qx+wl6tgYAyI8+g2+Lf9QAIBBh8rRwd/
         ZCEEcN3dtuMD9t6Qy/VrY0Zi2z76eMv5bR/4lPXAUVT889yBALiFLARjtfKNuYisLa9K
         agJQEpBH8y8UoDk14YHk9IGNLzbMtgYj39KIDGuHs348qk9ZaAna1ebJWSy9xviT7KJq
         jwMMPCDc+dHmHbJ2wp9lhG7g9qIaOeGGOENx7W1/QXAJf8Olh98Wdap7hdU+gHDWPlEb
         QwfbxlT1nVGASPtXoB2yQZgCEzdtQM7K49/NxRPH/K63K4bN+q4vM24D8JEqF1DiCt5s
         +CEw==
X-Gm-Message-State: AOAM5334yXmdqFklULAX1KnX3VUTSYd3tZ9qIOewkD9sxhSmpsw994bL
        A9C2t1d4Wexgswwf8Nf/rME=
X-Google-Smtp-Source: ABdhPJy85//sZjpctOGBtlCkbXzipuZquXuYRBdMj4Fzb0yFmyb512H4LYYbhxROEgcGPJdTvWvf4w==
X-Received: by 2002:a7b:cc92:: with SMTP id p18mr2082671wma.174.1589370168708;
        Wed, 13 May 2020 04:42:48 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.182.195])
        by smtp.googlemail.com with ESMTPSA id j2sm27484540wrp.47.2020.05.13.04.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 04:42:48 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] drm: use new debugfs functions for various files.
Date:   Wed, 13 May 2020 14:41:29 +0300
Message-Id: <20200513114130.28641-4-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513114130.28641-1-wambui.karugax@gmail.com>
References: <20200513114130.28641-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the use of drm_debugfs_create_files with the new
drm_debugfs_add_files() to create various drm core debugfs files.

DRM debugfs files are also represented using the new drm_simple_info
struct for use with the new functions.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/drm_atomic.c      | 11 +++++------
 drivers/gpu/drm/drm_client.c      | 11 +++++------
 drivers/gpu/drm/drm_framebuffer.c | 11 +++++------
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 965173fd0ac2..1ec8d74955fd 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1627,8 +1627,8 @@ EXPORT_SYMBOL(drm_state_dump);
 #ifdef CONFIG_DEBUG_FS
 static int drm_state_info(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *) m->private;
-	struct drm_device *dev = node->minor->dev;
+	struct drm_simple_info_entry *entry = m->private;
+	struct drm_device *dev = entry->dev;
 	struct drm_printer p = drm_seq_file_printer(m);
 
 	__drm_state_dump(dev, &p, true);
@@ -1637,14 +1637,13 @@ static int drm_state_info(struct seq_file *m, void *data)
 }
 
 /* any use in debugfs files to dump individual planes/crtc/etc? */
-static const struct drm_info_list drm_atomic_debugfs_list[] = {
+static const struct drm_simple_info drm_atomic_debugfs_list[] = {
 	{"state", drm_state_info, 0},
 };
 
 void drm_atomic_debugfs_init(struct drm_minor *minor)
 {
-	drm_debugfs_create_files(drm_atomic_debugfs_list,
-				 ARRAY_SIZE(drm_atomic_debugfs_list),
-				 minor->debugfs_root, minor);
+	drm_debugfs_add_files(minor->dev, drm_atomic_debugfs_list,
+			      ARRAY_SIZE(drm_atomic_debugfs_list));
 }
 #endif
diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
index 8cb93f5209a4..e899683f752d 100644
--- a/drivers/gpu/drm/drm_client.c
+++ b/drivers/gpu/drm/drm_client.c
@@ -440,8 +440,8 @@ EXPORT_SYMBOL(drm_client_framebuffer_delete);
 #ifdef CONFIG_DEBUG_FS
 static int drm_client_debugfs_internal_clients(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = m->private;
-	struct drm_device *dev = node->minor->dev;
+	struct drm_simple_info_entry *entry = m->private;
+	struct drm_device *dev = entry->dev;
 	struct drm_printer p = drm_seq_file_printer(m);
 	struct drm_client_dev *client;
 
@@ -453,14 +453,13 @@ static int drm_client_debugfs_internal_clients(struct seq_file *m, void *data)
 	return 0;
 }
 
-static const struct drm_info_list drm_client_debugfs_list[] = {
+static const struct drm_simple_info drm_client_debugfs_list[] = {
 	{ "internal_clients", drm_client_debugfs_internal_clients, 0 },
 };
 
 void drm_client_debugfs_init(struct drm_minor *minor)
 {
-	drm_debugfs_create_files(drm_client_debugfs_list,
-				 ARRAY_SIZE(drm_client_debugfs_list),
-				 minor->debugfs_root, minor);
+	drm_debugfs_add_files(minor->dev, drm_client_debugfs_list,
+			      ARRAY_SIZE(drm_client_debugfs_list));
 }
 #endif
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 0375b3d7f8d0..8fd346279c01 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -1188,8 +1188,8 @@ void drm_framebuffer_print_info(struct drm_printer *p, unsigned int indent,
 #ifdef CONFIG_DEBUG_FS
 static int drm_framebuffer_info(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = m->private;
-	struct drm_device *dev = node->minor->dev;
+	struct drm_simple_info_entry *entry = m->private;
+	struct drm_device *dev = entry->dev;
 	struct drm_printer p = drm_seq_file_printer(m);
 	struct drm_framebuffer *fb;
 
@@ -1203,14 +1203,13 @@ static int drm_framebuffer_info(struct seq_file *m, void *data)
 	return 0;
 }
 
-static const struct drm_info_list drm_framebuffer_debugfs_list[] = {
+static const struct drm_simple_info drm_framebuffer_debugfs_list[] = {
 	{ "framebuffer", drm_framebuffer_info, 0 },
 };
 
 void drm_framebuffer_debugfs_init(struct drm_minor *minor)
 {
-	drm_debugfs_create_files(drm_framebuffer_debugfs_list,
-				 ARRAY_SIZE(drm_framebuffer_debugfs_list),
-				 minor->debugfs_root, minor);
+	drm_debugfs_add_files(minor->dev, drm_framebuffer_debugfs_list,
+			      ARRAY_SIZE(drm_framebuffer_debugfs_list));
 }
 #endif
-- 
2.26.2

