Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBE6C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872D520675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTPwiJSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgCJNcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:32:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39946 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgCJNcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:32:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id e26so1352681wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5yjkQehLF0f6xll/bhOaQmEiXBo2J9wKC5XShatyRos=;
        b=KTPwiJSM/qzAYzigcpA0Y2zHDa/6QW3xECg+PL0A4YQZCTKBUehAocmVanrkaYwNWB
         BVuCETrnkcveGVfYF/e/qnudD5gWQoIsuJnsLBsoxaWZhuLSYZBwjkjREQkiqrtqq9G0
         fhCbmmMxnTenEzXygKIVlt+afExuMshk7MK6YWUmt2k8/tjRFVFbSj/G6Qz6UBaAwNEb
         qX2TsekYXrUzA43wqiTWsuQXzbEcUjl5J0W+xgbvDmalnbtx7B21ot1xCWeyRq9gAGP3
         Z1OZLPEt3QWVfKaZzjGl8G+DKAz+KmsmYt3ktwom160s2BWdHITseV6u05dkv+s8XO33
         PKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5yjkQehLF0f6xll/bhOaQmEiXBo2J9wKC5XShatyRos=;
        b=VGRRONIO+KfellpodonyEueqy4c2g2G0Uanl81v66P6TP2nuAhLOdktCs8BpFOawNZ
         sioNxIVNdR+9/z/Br/oCvV4kVLicRdQgPlHg2AMtBkIVKqjJ/u4jS5Rmj5P9/mqwe1/o
         Q05sADCSBcaCtDIpsnl6yXaYkEsY5Nip7d7wj6b+XW6aZ6AGVeyvwOh35yHoyyUk8ADH
         uWQyUBa2QKsY2smJ5kOZ5Zg1/54kQcJEmPQlG4LTdKq25/CYbNLHKNtZIFHip3iNUz/G
         x47zn8I+5S0ZhTu7JZ4Kr7pHOtFtUN08FbR0iNWrnKWQxmgJjG6VeszHcaoUCL2B/YL6
         amow==
X-Gm-Message-State: ANhLgQ2aJgTjuJCU5rbLx8Za9efQ3f0X6v3YF3q6yeVfntvRZTirZplo
        hb0hba+yGh1PV8sBsgDcM+U=
X-Google-Smtp-Source: ADFU+vtTt77jHYaEAcGJY28++Hmyg5x/Jy/jKLVwSwc+9Y+5LroFS2cLeRjqKdsEIJbBuTJj2tBGag==
X-Received: by 2002:a1c:ba42:: with SMTP id k63mr2275852wmf.71.1583847123016;
        Tue, 10 Mar 2020 06:32:03 -0700 (PDT)
Received: from localhost.localdomain ([197.248.222.210])
        by smtp.googlemail.com with ESMTPSA id o7sm14047141wrx.60.2020.03.10.06.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:32:02 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, intel-gfx@lists.freedesktop.org
Subject: [PATCH v2 14/17] drm/i915: have *_debugfs_init() functions return void.
Date:   Tue, 10 Mar 2020 16:31:18 +0300
Message-Id: <20200310133121.27913-15-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310133121.27913-1-wambui.karugax@gmail.com>
References: <20200310133121.27913-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 987d65d01356 (drm: debugfs: make
drm_debugfs_create_files() never fail), drm_debugfs_create_files() never
fails and should return void. Therefore, remove its use as the
return value of debugfs_init() functions and have the functions return
void.

v2: convert intel_display_debugfs_register() stub to return void too.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_display_debugfs.c | 8 ++++----
 drivers/gpu/drm/i915/display/intel_display_debugfs.h | 4 ++--
 drivers/gpu/drm/i915/i915_debugfs.c                  | 8 ++++----
 drivers/gpu/drm/i915/i915_debugfs.h                  | 4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index 1e6eb7f2f72d..424f4e52f783 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -1927,7 +1927,7 @@ static const struct {
 	{"i915_edp_psr_debug", &i915_edp_psr_debug_fops},
 };
 
-int intel_display_debugfs_register(struct drm_i915_private *i915)
+void intel_display_debugfs_register(struct drm_i915_private *i915)
 {
 	struct drm_minor *minor = i915->drm.primary;
 	int i;
@@ -1940,9 +1940,9 @@ int intel_display_debugfs_register(struct drm_i915_private *i915)
 				    intel_display_debugfs_files[i].fops);
 	}
 
-	return drm_debugfs_create_files(intel_display_debugfs_list,
-					ARRAY_SIZE(intel_display_debugfs_list),
-					minor->debugfs_root, minor);
+	drm_debugfs_create_files(intel_display_debugfs_list,
+				 ARRAY_SIZE(intel_display_debugfs_list),
+				 minor->debugfs_root, minor);
 }
 
 static int i915_panel_show(struct seq_file *m, void *data)
diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.h b/drivers/gpu/drm/i915/display/intel_display_debugfs.h
index a3bea1ce04c2..c922c1745bfe 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.h
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.h
@@ -10,10 +10,10 @@ struct drm_connector;
 struct drm_i915_private;
 
 #ifdef CONFIG_DEBUG_FS
-int intel_display_debugfs_register(struct drm_i915_private *i915);
+void intel_display_debugfs_register(struct drm_i915_private *i915);
 int intel_connector_debugfs_add(struct drm_connector *connector);
 #else
-static inline int intel_display_debugfs_register(struct drm_i915_private *i915) { return 0; }
+static inline void intel_display_debugfs_register(struct drm_i915_private *i915) {}
 static inline int intel_connector_debugfs_add(struct drm_connector *connector) { return 0; }
 #endif
 
diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
index 8f2525e4ce0f..de313199c714 100644
--- a/drivers/gpu/drm/i915/i915_debugfs.c
+++ b/drivers/gpu/drm/i915/i915_debugfs.c
@@ -2392,7 +2392,7 @@ static const struct i915_debugfs_files {
 	{"i915_guc_log_relay", &i915_guc_log_relay_fops},
 };
 
-int i915_debugfs_register(struct drm_i915_private *dev_priv)
+void i915_debugfs_register(struct drm_i915_private *dev_priv)
 {
 	struct drm_minor *minor = dev_priv->drm.primary;
 	int i;
@@ -2409,7 +2409,7 @@ int i915_debugfs_register(struct drm_i915_private *dev_priv)
 				    i915_debugfs_files[i].fops);
 	}
 
-	return drm_debugfs_create_files(i915_debugfs_list,
-					I915_DEBUGFS_ENTRIES,
-					minor->debugfs_root, minor);
+	drm_debugfs_create_files(i915_debugfs_list,
+				 I915_DEBUGFS_ENTRIES,
+				 minor->debugfs_root, minor);
 }
diff --git a/drivers/gpu/drm/i915/i915_debugfs.h b/drivers/gpu/drm/i915/i915_debugfs.h
index 6da39c76ab5e..1de2736f1248 100644
--- a/drivers/gpu/drm/i915/i915_debugfs.h
+++ b/drivers/gpu/drm/i915/i915_debugfs.h
@@ -12,10 +12,10 @@ struct drm_i915_private;
 struct seq_file;
 
 #ifdef CONFIG_DEBUG_FS
-int i915_debugfs_register(struct drm_i915_private *dev_priv);
+void i915_debugfs_register(struct drm_i915_private *dev_priv);
 void i915_debugfs_describe_obj(struct seq_file *m, struct drm_i915_gem_object *obj);
 #else
-static inline int i915_debugfs_register(struct drm_i915_private *dev_priv) { return 0; }
+static inline void i915_debugfs_register(struct drm_i915_private *dev_priv) {}
 static inline void i915_debugfs_describe_obj(struct seq_file *m, struct drm_i915_gem_object *obj) {}
 #endif
 
-- 
2.25.1

