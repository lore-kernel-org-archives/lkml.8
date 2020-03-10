Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3247CC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFF224681
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oe3lLYb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgCJNcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:32:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38644 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729657AbgCJNcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:32:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id t11so15905553wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eTSKNjhkTPUhvHieKRKNo9OKCglUUf75Y8SFUIDPF94=;
        b=oe3lLYb2VJTK/cYnJvNzU5OpK0mPTfzjuJD+F9YMYyfVJ/t+AmHIugoNuGmcIvoU9Y
         EeaUpH9h2OXprhwgbtCo9n7yECDhrSNI1W1KhdqizKavVDcvAWqf3omtZ9zzt51I0rPh
         h6n8jnL8mmLbY2JW9OuXFp79v0Ch1liAMssyOQ2Oyau7CmcMZMNOM+f6XbF7zI2k1nE+
         V4b39W4ErWrRKaKpgiwNul6qpNgyxC5b7vpERvT2JwBGXuydMDuNzNy4GxDLoZhR8WJ0
         PMrRcjVi8KmQqZyQJkWIiL98QIAAMxqIIycH3EAM2ivmIjfS89SD8dxJyP8gbviy1U++
         ktOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eTSKNjhkTPUhvHieKRKNo9OKCglUUf75Y8SFUIDPF94=;
        b=oVDz2KylvBm5r9cZczu8vY/ihmOtPOJ1spV65NbWWHE+hUerhw25Tf/Jaz9bsFm2bl
         8zZvvRBMOA1pydGrsPVjzXH4BCOyLrzGUVNWLFlwmnhi+t2kabs3vKt3Q60X9W2EKhPN
         9kRe78PZVNm/nvy//Q/IgI+/vg99O+VYrGZHW7BeFSTmi5kDPek6RHBsaF0WMxtq1XMl
         rlmIos2WJdX+vG3hcGMaZXP3/yM/phVxFuR//rLwCVJ4C9ec6HYjshBxJBPSY39IfZIr
         QDzJZ59kMDmho80rvAotZHFdtGAiEInqQcOJxwNDAmnw37TxsKMVNEWZr9ozkzLSWfk+
         Qjkw==
X-Gm-Message-State: ANhLgQ06WBl8kMfclk/K1SDohJSRX7iVamN9nmwh+Ghh2nRcs3KjajqR
        +FJvnReOZnqq54V1XugRfBs=
X-Google-Smtp-Source: ADFU+vsr5MTGUh6MoLka24KREcQMiRot37IVhStzHILNYiCyak9Qotha1lzAWhWg9+ITuaIsmaZ1Ew==
X-Received: by 2002:adf:8501:: with SMTP id 1mr29345378wrh.56.1583847125462;
        Tue, 10 Mar 2020 06:32:05 -0700 (PDT)
Received: from localhost.localdomain ([197.248.222.210])
        by smtp.googlemail.com with ESMTPSA id o7sm14047141wrx.60.2020.03.10.06.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:32:05 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 15/17] drm: make various debugfs_init() functions return 0
Date:   Tue, 10 Mar 2020 16:31:19 +0300
Message-Id: <20200310133121.27913-16-wambui.karugax@gmail.com>
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
return value of various debugfs_init() functions in drm, and have these
functions return 0 directly.

v2: convert debugfs_init() functions to return 0 instead of void to
avoid build breakage.

References: https://lists.freedesktop.org/archives/dri-devel/2020-February/257183.html
Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/drm_atomic.c      | 7 ++++---
 drivers/gpu/drm/drm_client.c      | 8 +++++---
 drivers/gpu/drm/drm_framebuffer.c | 8 +++++---
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 9ccfbf213d72..c0056d9cc139 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1643,8 +1643,9 @@ static const struct drm_info_list drm_atomic_debugfs_list[] = {
 
 int drm_atomic_debugfs_init(struct drm_minor *minor)
 {
-	return drm_debugfs_create_files(drm_atomic_debugfs_list,
-			ARRAY_SIZE(drm_atomic_debugfs_list),
-			minor->debugfs_root, minor);
+	drm_debugfs_create_files(drm_atomic_debugfs_list,
+				 ARRAY_SIZE(drm_atomic_debugfs_list),
+				 minor->debugfs_root, minor);
+	return 0;
 }
 #endif
diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
index 6b0c6ef8b9b3..82fbdee407b2 100644
--- a/drivers/gpu/drm/drm_client.c
+++ b/drivers/gpu/drm/drm_client.c
@@ -459,8 +459,10 @@ static const struct drm_info_list drm_client_debugfs_list[] = {
 
 int drm_client_debugfs_init(struct drm_minor *minor)
 {
-	return drm_debugfs_create_files(drm_client_debugfs_list,
-					ARRAY_SIZE(drm_client_debugfs_list),
-					minor->debugfs_root, minor);
+	drm_debugfs_create_files(drm_client_debugfs_list,
+				 ARRAY_SIZE(drm_client_debugfs_list),
+				 minor->debugfs_root, minor);
+
+	return 0;
 }
 #endif
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 57ac94ce9b9e..46be88271fe5 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -1209,8 +1209,10 @@ static const struct drm_info_list drm_framebuffer_debugfs_list[] = {
 
 int drm_framebuffer_debugfs_init(struct drm_minor *minor)
 {
-	return drm_debugfs_create_files(drm_framebuffer_debugfs_list,
-				ARRAY_SIZE(drm_framebuffer_debugfs_list),
-				minor->debugfs_root, minor);
+	drm_debugfs_create_files(drm_framebuffer_debugfs_list,
+				 ARRAY_SIZE(drm_framebuffer_debugfs_list),
+				 minor->debugfs_root, minor);
+
+	return 0;
 }
 #endif
-- 
2.25.1

