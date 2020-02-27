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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3CBC4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E764E24698
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEOqiWPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgB0MDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:03:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50739 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgB0MDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:03:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so3256998wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4fFxtd2alUAmDwPqREqD0hmlK9QgvDgPrbdGklXtT8Q=;
        b=kEOqiWPcKOo2uudX4IJh02QKkSzl+Yj6CrbhJNJsBDkpi/BKDKUsJXQZlC+BeybXc9
         LrzQ752Bg/EVv6ae+ab93XL/7ZBBY1pRJCrN1rY9Lewu85ppogh1mna0z7fed2zF7p7R
         Vkl84PFvXCQYfnFmDwdnfY5CVx/5qWGxxM+7GCvR7izZmVbu3zfpFsal+VzSz1yB/pHd
         +bvkPw3gJoDd/wYKyuEgIFn28eSEV+Nowg7yBrXPlud1eki3NpOSoxSijbQK8SQmKpEW
         Pbk947uhgltMnciutcWElWAuSn7k4Z9bgsnFBdVvaDRcG57jlg1bfGLVbaRu7Xcay7Wb
         Sg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4fFxtd2alUAmDwPqREqD0hmlK9QgvDgPrbdGklXtT8Q=;
        b=pIva/IgwSCIk66JXJxBGPIQCU5waksascOJ5r9bshTm5t4MDvuB5U0mUEgl06vl/ZP
         yT8EiNEEZeyqjxTCf8J8Ly8DteAqLZ3WJdMez27JptToJA2p7jvtQLVBUJLln2jAcBk8
         nfdnvC66WRjoEvWKuqRs7NIVbIZBaT4htiwYuttT/BkHe8EH2ISow7bnKnqJC5a/j5Vo
         34Zv4ihsrgW5NXCNkVE9rk+SvfSdvIJBGaIpA+ql5kW3jUk0zeZ/wFnva2GYDMfqtt/V
         9QsgCBI/HJ74GyskD80aY3GsicxGw30U9HbIG4nyP5VxKCGk78BHXOFtH6EyOTtx/+if
         MVBw==
X-Gm-Message-State: APjAAAUZt0pZwmAi0uX7ctO5vIMfhkrgPkTgnt4Ekxu/jeQ1kXM2o3Vr
        SV23yUadLKSgQtZmJVvGSgo=
X-Google-Smtp-Source: APXvYqwEY8Y+d/oV+yJH9lF9a946Az5Xl87bfcopNONxFys9u3gI6iu4vbW3C0rxP+gtf+eEVkXJJw==
X-Received: by 2002:a05:600c:218d:: with SMTP id e13mr5108729wme.102.1582804981274;
        Thu, 27 Feb 2020 04:03:01 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t10sm7655017wru.59.2020.02.27.04.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:03:00 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     daniel@ffwll.ch, airlied@linux.ie, Eric Anholt <eric@anholt.net>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 05/21] drm/vc4: remove check of return value of drm_debugfs functions
Date:   Thu, 27 Feb 2020 15:02:16 +0300
Message-Id: <20200227120232.19413-6-wambui.karugax@gmail.com>
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
fails and should return void. Therefore, remove unnecessary check and
error handling for the return value of drm_debugfs_create_files()
in vc4_debugfs_init().

This change also allows vc4_debugfs_init() to be declared as void.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_debugfs.c | 11 +++--------
 drivers/gpu/drm/vc4/vc4_drv.h     |  2 +-
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_debugfs.c b/drivers/gpu/drm/vc4/vc4_debugfs.c
index b61b2d3407b5..4fbbf980a299 100644
--- a/drivers/gpu/drm/vc4/vc4_debugfs.c
+++ b/drivers/gpu/drm/vc4/vc4_debugfs.c
@@ -20,7 +20,7 @@ struct vc4_debugfs_info_entry {
  * Called at drm_dev_register() time on each of the minors registered
  * by the DRM device, to attach the debugfs files.
  */
-int
+void
 vc4_debugfs_init(struct drm_minor *minor)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(minor->dev);
@@ -30,14 +30,9 @@ vc4_debugfs_init(struct drm_minor *minor)
 			    minor->debugfs_root, &vc4->load_tracker_enabled);
 
 	list_for_each_entry(entry, &vc4->debugfs_list, link) {
-		int ret = drm_debugfs_create_files(&entry->info, 1,
-						   minor->debugfs_root, minor);
-
-		if (ret)
-			return ret;
+		drm_debugfs_create_files(&entry->info, 1,
+					 minor->debugfs_root, minor);
 	}
-
-	return 0;
 }
 
 static int vc4_debugfs_regset32(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index f90c0d08e740..cd0f9ef41fa2 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -750,7 +750,7 @@ void vc4_crtc_get_margins(struct drm_crtc_state *state,
 			  unsigned int *top, unsigned int *bottom);
 
 /* vc4_debugfs.c */
-int vc4_debugfs_init(struct drm_minor *minor);
+void vc4_debugfs_init(struct drm_minor *minor);
 #ifdef CONFIG_DEBUG_FS
 void vc4_debugfs_add_file(struct drm_device *drm,
 			  const char *filename,
-- 
2.25.0

