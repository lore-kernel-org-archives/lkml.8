Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4E2CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA49A20769
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3H0lXMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbgEMLmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 07:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgEMLmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:42:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EABC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 04:42:43 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id v12so20442476wrp.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 04:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t15tjq6+BhxBQN0F/MuG55FDoBQH9+TEC4ypwZsHps0=;
        b=R3H0lXMUZlsGnXzQ/7L1r/QG6QMp8omk5uLolDDWM9VA8qtJwO/NnsHBfMYB/FrAR/
         Rr8cTd8hiimf0K0srZem2lk3gftiRN68qaGSBRX+ujnpsFx4tM7/NwpLEEG4f1WiDosP
         k5u/KFokB8aolIvvv6iyJ4Ich9kkOKT1PRSrbXoxS2PzfIHUxVXC4PEfagSUzUfIqkU8
         cMJ1GG+2wCNSLmOb3h11GD4htqKjhio6GoWEzsylf5aBrF25HxAjDwyD9weJDlHusZq8
         g15X+TIvXW6gLGjbgZpKjpCf3zyjGRPuwfGq33jWNPKZSqoJZMS2yJJwWTB4alUsAi/0
         XKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t15tjq6+BhxBQN0F/MuG55FDoBQH9+TEC4ypwZsHps0=;
        b=ubTwWQtNe0k1e1uV0hoCaPEmIUTiYBmdAQVDK5vSvUHtBvEKawHpTxoRZ92Ejy4Pl3
         +9Rluxf2yTCgFtHD5z/c0p/r95FP6l/Fkz08l8h9ZVoxY9ZKehJJABy7FT4nkqqhbwwv
         TGKoyutt0GmreHKUxCCIHxlMmadnX/g6Qj17poFDEA5DF02CDSIIDr/sqoI1toC0AnKv
         BHPlsRtUC4f37nkaU3gCRd8c9zYeMclkIlJOLqXqQWG6dgO07z7tVtRbcSkzm6jGaBXT
         lWmpwW+Wt2l7sZ00jKvyN+mgxfueIzoS0muZ/6yxHHK6LbiL2dcMIPOrUz7HfFKIOyU0
         cEWg==
X-Gm-Message-State: AGi0PuYJMmPnfh6jemQU9M4oHMEW5aqWqKoTjSJ9JSytpQemEqlNWJWw
        PEBFyrQ2QA4bA1ruOtG9b4Y=
X-Google-Smtp-Source: APiQypKk4oe7T8k37TGyO1auKrxf7o46nnLqxrPAbyehTziduZJ8zjbkZl0KU2TkSBAuaW0rH/d8KQ==
X-Received: by 2002:adf:e752:: with SMTP id c18mr13622679wrn.353.1589370161693;
        Wed, 13 May 2020 04:42:41 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.182.195])
        by smtp.googlemail.com with ESMTPSA id j2sm27484540wrp.47.2020.05.13.04.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 04:42:41 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] drm/vc4: use new debugfs functions for file creation.
Date:   Wed, 13 May 2020 14:41:28 +0300
Message-Id: <20200513114130.28641-3-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513114130.28641-1-wambui.karugax@gmail.com>
References: <20200513114130.28641-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, vc4 delays adding of debugfs files until drm_dev_register()
calls vc4_debugfs_init() on each registered minor.

This change removes this infrastructure and uses the new
drm_debugfs_add_file() function and drm_device->debugfs_list to track
debugfs files which are added at drm_dev_register() time on each minor.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_bo.c      |  4 ++--
 drivers/gpu/drm/vc4/vc4_debugfs.c | 38 +++++++------------------------
 drivers/gpu/drm/vc4/vc4_hdmi.c    |  4 ++--
 drivers/gpu/drm/vc4/vc4_hvs.c     |  4 ++--
 drivers/gpu/drm/vc4/vc4_v3d.c     |  4 ++--
 5 files changed, 16 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index 72d30d90b856..ff332bac25d1 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -65,8 +65,8 @@ static void vc4_bo_stats_print(struct drm_printer *p, struct vc4_dev *vc4)
 
 static int vc4_bo_stats_debugfs(struct seq_file *m, void *unused)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
+	struct drm_simple_info_entry *entry = m->private;
+	struct drm_device *dev = entry->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct drm_printer p = drm_seq_file_printer(m);
 
diff --git a/drivers/gpu/drm/vc4/vc4_debugfs.c b/drivers/gpu/drm/vc4/vc4_debugfs.c
index 4fbbf980a299..e31e400c8cfc 100644
--- a/drivers/gpu/drm/vc4/vc4_debugfs.c
+++ b/drivers/gpu/drm/vc4/vc4_debugfs.c
@@ -11,10 +11,6 @@
 #include "vc4_drv.h"
 #include "vc4_regs.h"
 
-struct vc4_debugfs_info_entry {
-	struct list_head link;
-	struct drm_info_list info;
-};
 
 /**
  * Called at drm_dev_register() time on each of the minors registered
@@ -24,21 +20,15 @@ void
 vc4_debugfs_init(struct drm_minor *minor)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(minor->dev);
-	struct vc4_debugfs_info_entry *entry;
 
 	debugfs_create_bool("hvs_load_tracker", S_IRUGO | S_IWUSR,
 			    minor->debugfs_root, &vc4->load_tracker_enabled);
-
-	list_for_each_entry(entry, &vc4->debugfs_list, link) {
-		drm_debugfs_create_files(&entry->info, 1,
-					 minor->debugfs_root, minor);
-	}
 }
 
 static int vc4_debugfs_regset32(struct seq_file *m, void *unused)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct debugfs_regset32 *regset = node->info_ent->data;
+	struct drm_simple_info_entry *entry = m->private;
+	struct debugfs_regset32 *regset = entry->file.data;
 	struct drm_printer p = drm_seq_file_printer(m);
 
 	drm_print_regset32(&p, regset);
@@ -49,30 +39,18 @@ static int vc4_debugfs_regset32(struct seq_file *m, void *unused)
 /**
  * Registers a debugfs file with a callback function for a vc4 component.
  *
- * This is like drm_debugfs_create_files(), but that can only be
- * called a given DRM minor, while the various VC4 components want to
- * register their debugfs files during the component bind process.  We
- * track the request and delay it to be called on each minor during
- * vc4_debugfs_init().
+ * Various VC4 functions will register their debugfs files during the
+ * component bind process using drm_debugfs_add_file().
+ * These requests are tracked and delayed until their called on each
+ * minor during drm_dev_register().
+ *
  */
 void vc4_debugfs_add_file(struct drm_device *dev,
 			  const char *name,
 			  int (*show)(struct seq_file*, void*),
 			  void *data)
 {
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
-
-	struct vc4_debugfs_info_entry *entry =
-		devm_kzalloc(dev->dev, sizeof(*entry), GFP_KERNEL);
-
-	if (!entry)
-		return;
-
-	entry->info.name = name;
-	entry->info.show = show;
-	entry->info.data = data;
-
-	list_add(&entry->link, &vc4->debugfs_list);
+	drm_debugfs_add_file(dev, name, show, data);
 }
 
 void vc4_debugfs_add_regset32(struct drm_device *drm,
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 625bfcf52dc4..05b2a3161148 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -182,8 +182,8 @@ static const struct debugfs_reg32 hd_regs[] = {
 
 static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
+	struct drm_simple_info_entry *entry = m->private;
+	struct drm_device *dev = entry->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_hdmi *hdmi = vc4->hdmi;
 	struct drm_printer p = drm_seq_file_printer(m);
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 5a43659da319..4c254c027649 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -82,8 +82,8 @@ void vc4_hvs_dump_state(struct drm_device *dev)
 
 static int vc4_hvs_debugfs_underrun(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = m->private;
-	struct drm_device *dev = node->minor->dev;
+	struct drm_simple_info_entry *entry = m->private;
+	struct drm_device *dev = entry->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct drm_printer p = drm_seq_file_printer(m);
 
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index cea77a21b205..cdef61666c42 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -98,8 +98,8 @@ static const struct debugfs_reg32 v3d_regs[] = {
 
 static int vc4_v3d_debugfs_ident(struct seq_file *m, void *unused)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
+	struct drm_simple_info_entry *entry = m->private;
+	struct drm_device *dev = entry->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	int ret = vc4_v3d_pm_get(vc4);
 
-- 
2.26.2

