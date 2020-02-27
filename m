Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D6CC35677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B3F24699
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AR7qKUbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgB0MDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:03:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36490 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgB0MDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:03:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id j16so1458123wrt.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JDFiHtXUYpw9/7YjF6hgsTU6zXp0udoM7RVARL/tRI4=;
        b=AR7qKUbTnFZFJhUbiw2wILy8YBU7aRm24uEVrizIZeXUZNnuow1AiJSWkZHsm+ROIT
         TCuXxcqqWo/c4+PP1chfR05ZAFk0Y37cjOB+LzVCs/7Yv+GqQkguY0Qd4tmjDKPe2gmk
         04FjLuFbkYSWXn2+Lw+RsmCYLI0MOPl9L65a6ANyK8JA06Xjdwx/x5d7Oh9P5FS5d6W4
         99WcOdHriz+O90flwURtV17N23h0QHARXF3s1oltpvS4r7MzNcVZR2r0o1UMMaJQ1j/t
         B/BCuUaqv8/tVWdN+iOp7z+A7DftT0ZMcTEY9Eq0JYCTRHJB7WFMiI9QOQjZ5wtQnpxL
         syQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JDFiHtXUYpw9/7YjF6hgsTU6zXp0udoM7RVARL/tRI4=;
        b=meGmb4E7zgwIBQrIcsIHqB5UJe/VfBJSe4mm99Gpphww4Sxmm3QrHqAS22imEO2zaH
         Dk2Oye/d+eDN6dc/KKbDzBN3wr47vJrE5mBnXtVh0fymdE8eWILuh00QVi+QKGtkQea2
         14mVOLBK/S7QEeDsaEZl8WUW/tLJwn/L52Q37aRwwETJ59fqlisIa3uJV1pCsNH4aSi5
         CwBD4wh68aw1BWWjVPcRNnmRp5ruzBhPtuKxZPwm11pAEss6EIag1i/viQ4kDdjuKo+L
         k+rIdA9MgbjOTHgIaWJ33tYLOfFOCFlCWzQnmMjNLxnsAiWFBKkYzh1SSYiBKaNdAjjd
         q0mw==
X-Gm-Message-State: APjAAAUEtBk9waEtb0cEaNMCwr/EtRB28/2PsXTuCQ4bBzWludxKYvvh
        SoO4pYDgbPNjuBka98WWrhofkTbtUImDeg==
X-Google-Smtp-Source: APXvYqycfeHEVSwOmkH9aHMERPJ5uUBCwE6v7YS6/+KssWDzjjGaXBNUPLF6j1vpk0YqR5PazYwqlg==
X-Received: by 2002:adf:a746:: with SMTP id e6mr4572634wrd.329.1582805025787;
        Thu, 27 Feb 2020 04:03:45 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t10sm7655017wru.59.2020.02.27.04.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:03:45 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     daniel@ffwll.ch, airlied@linux.ie,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: [PATCH 16/21] drm/i915: make *_debugfs_register() functions return void.
Date:   Thu, 27 Feb 2020 15:02:27 +0300
Message-Id: <20200227120232.19413-17-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227120232.19413-1-wambui.karugax@gmail.com>
References: <20200227120232.19413-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 987d65d01356 (drm: debugfs: make
drm_debugfs_create_files() never fail), drm_debugfs_create_files() never
fails and should return void. Therefore, remove its use as the
return value of i915_debugfs_register() and
intel_display_debugfs_register() and have both functions return void.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_display_debugfs.c | 8 ++++----
 drivers/gpu/drm/i915/display/intel_display_debugfs.h | 4 ++--
 drivers/gpu/drm/i915/i915_debugfs.c                  | 8 ++++----
 drivers/gpu/drm/i915/i915_debugfs.h                  | 4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index 46954cc7b6c0..3b877c34c420 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -1922,7 +1922,7 @@ static const struct {
 	{"i915_edp_psr_debug", &i915_edp_psr_debug_fops},
 };
 
-int intel_display_debugfs_register(struct drm_i915_private *i915)
+void intel_display_debugfs_register(struct drm_i915_private *i915)
 {
 	struct drm_minor *minor = i915->drm.primary;
 	int i;
@@ -1935,9 +1935,9 @@ int intel_display_debugfs_register(struct drm_i915_private *i915)
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
index a3bea1ce04c2..a5cf7a6d3d34 100644
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
+static inline int intel_display_debugfs_register(struct drm_i915_private *i915) {}
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
2.25.0

