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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A0DC4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A8624692
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAZcESBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgB0MED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:04:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40217 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729264AbgB0MEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:04:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so3089998wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+KWhSsNubWek+s087bQ51ysemcEcbIre0xKjY3xCvk=;
        b=YAZcESBcaRtP75t+snUpVawMs7r/LA1nbZUdnL2VIerOC1w737obl8VFdfneZhFyr0
         R4B26u9NH0H9Xl8cgeFuWHsQlTyFI1XPz9CBFWHW1h6zkq1ZOIIwuBpyX5YTGBlkmXv0
         iMERA3ryPFf4mKdbu90j3uNmXLLqDmYEwgrhrji+tjkM5HHWyo71/MVGmj/MP6FCQLw5
         5gi9l9+wFeJTr0/E1FJ/TcVXvisgtqdM01QSnsga9l42kvJv97qWcqCSBx4dFTi01DN0
         zHuG8+XwUPf8OwTC5wHUikg43DDWSHZxQETRa6+imlIlCcZmKjxMTNoMn4/M7lO7MsbE
         zsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+KWhSsNubWek+s087bQ51ysemcEcbIre0xKjY3xCvk=;
        b=CMNLQcya0GAnAgnhJ41ZM+7g79l97JsMf+RUeD0/kd+2lws69vpxh1fowWagvBLv2A
         Ejq5EOnAMK444aSDIP30KcjciHE3cH5v++qjCLat2LRGsI6r/FN0AVXUNdJj+BGaN7z7
         r1mVMeqGPvAxdJvCaRGIcLGTOB4NAKa3QBu6ieeOSM1gXTloJjwx0LaScgober+JphFv
         lWbwpS/h4nT85AU+4h3xifXqeN9ikpIbzqUgfTc+qO9sYp0GJXz6IiqxRUi0dLBVc3jG
         ZW8Bm/+hLyH3zH4zm9+xlM3Huu6El+pqhcBQ+8zAY5TcY4YN2cxDpOqksiWARX9NCfG5
         M0NA==
X-Gm-Message-State: APjAAAX0EtsFRSlkPXpBpY7TzAvRWLfiiYy1d090i1G1FCmLPwT1ptTf
        lvvqJb0Br2VTyeYQxa3N+98=
X-Google-Smtp-Source: APXvYqxx19oGBiLrWAtloY4wWfqjFYr5alL5OMX+ojOw8tLj4vCW431S4STSJoEbFI9Pecu86moChA==
X-Received: by 2002:a1c:108:: with SMTP id 8mr4992146wmb.30.1582805039094;
        Thu, 27 Feb 2020 04:03:59 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t10sm7655017wru.59.2020.02.27.04.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:03:58 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     daniel@ffwll.ch, airlied@linux.ie,
        Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 20/21] drm/qxl: have debugfs functions return void.
Date:   Thu, 27 Feb 2020 15:02:31 +0300
Message-Id: <20200227120232.19413-21-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227120232.19413-1-wambui.karugax@gmail.com>
References: <20200227120232.19413-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the conversion of the .debugfs_init() hook to return void
(drm: convert the .debugfs_init() hook to return void), there
is no need for the return value of qxl_debugfs_init(). Therefore,
refactor the function to return void.

This change also includes the conversion of various functions that can
be converted to return void as a result of the changes to
qxl_debugfs_init().

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_debugfs.c | 21 +++++++--------------
 drivers/gpu/drm/qxl/qxl_drv.h     | 13 +++++--------
 drivers/gpu/drm/qxl/qxl_ttm.c     |  6 ++----
 3 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_debugfs.c b/drivers/gpu/drm/qxl/qxl_debugfs.c
index a4f4175bbdbe..88123047fdd4 100644
--- a/drivers/gpu/drm/qxl/qxl_debugfs.c
+++ b/drivers/gpu/drm/qxl/qxl_debugfs.c
@@ -79,36 +79,30 @@ static struct drm_info_list qxl_debugfs_list[] = {
 #define QXL_DEBUGFS_ENTRIES ARRAY_SIZE(qxl_debugfs_list)
 #endif
 
-int
+void
 qxl_debugfs_init(struct drm_minor *minor)
 {
 #if defined(CONFIG_DEBUG_FS)
-	int r;
 	struct qxl_device *dev =
 		(struct qxl_device *) minor->dev->dev_private;
 
 	drm_debugfs_create_files(qxl_debugfs_list, QXL_DEBUGFS_ENTRIES,
 				 minor->debugfs_root, minor);
 
-	r = qxl_ttm_debugfs_init(dev);
-	if (r) {
-		DRM_ERROR("Failed to init TTM debugfs\n");
-		return r;
-	}
+	qxl_ttm_debugfs_init(dev);
 #endif
-	return 0;
 }
 
-int qxl_debugfs_add_files(struct qxl_device *qdev,
-			  struct drm_info_list *files,
-			  unsigned int nfiles)
+void qxl_debugfs_add_files(struct qxl_device *qdev,
+			   struct drm_info_list *files,
+			   unsigned int nfiles)
 {
 	unsigned int i;
 
 	for (i = 0; i < qdev->debugfs_count; i++) {
 		if (qdev->debugfs[i].files == files) {
 			/* Already registered */
-			return 0;
+			return;
 		}
 	}
 
@@ -116,7 +110,7 @@ int qxl_debugfs_add_files(struct qxl_device *qdev,
 	if (i > QXL_DEBUGFS_MAX_COMPONENTS) {
 		DRM_ERROR("Reached maximum number of debugfs components.\n");
 		DRM_ERROR("Report so we increase QXL_DEBUGFS_MAX_COMPONENTS.\n");
-		return -EINVAL;
+		return;
 	}
 	qdev->debugfs[qdev->debugfs_count].files = files;
 	qdev->debugfs[qdev->debugfs_count].num_files = nfiles;
@@ -126,5 +120,4 @@ int qxl_debugfs_add_files(struct qxl_device *qdev,
 				 qdev->ddev.primary->debugfs_root,
 				 qdev->ddev.primary);
 #endif
-	return 0;
 }
diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 27e45a2d6b52..435126facc9b 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -190,9 +190,6 @@ struct qxl_debugfs {
 	unsigned int num_files;
 };
 
-int qxl_debugfs_add_files(struct qxl_device *rdev,
-			     struct drm_info_list *files,
-			     unsigned int nfiles);
 int qxl_debugfs_fence_init(struct qxl_device *rdev);
 
 struct qxl_device;
@@ -442,8 +439,8 @@ int qxl_garbage_collect(struct qxl_device *qdev);
 
 /* debugfs */
 
-int qxl_debugfs_init(struct drm_minor *minor);
-int qxl_ttm_debugfs_init(struct qxl_device *qdev);
+void qxl_debugfs_init(struct drm_minor *minor);
+void qxl_ttm_debugfs_init(struct qxl_device *qdev);
 
 /* qxl_prime.c */
 int qxl_gem_prime_pin(struct drm_gem_object *obj);
@@ -461,9 +458,9 @@ int qxl_gem_prime_mmap(struct drm_gem_object *obj,
 int qxl_irq_init(struct qxl_device *qdev);
 irqreturn_t qxl_irq_handler(int irq, void *arg);
 
-int qxl_debugfs_add_files(struct qxl_device *qdev,
-			  struct drm_info_list *files,
-			  unsigned int nfiles);
+void qxl_debugfs_add_files(struct qxl_device *qdev,
+			   struct drm_info_list *files,
+			   unsigned int nfiles);
 
 int qxl_surface_id_alloc(struct qxl_device *qdev,
 			 struct qxl_bo *surf);
diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 62a5e424971b..93a2eb14844b 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -322,7 +322,7 @@ static int qxl_mm_dump_table(struct seq_file *m, void *data)
 }
 #endif
 
-int qxl_ttm_debugfs_init(struct qxl_device *qdev)
+void qxl_ttm_debugfs_init(struct qxl_device *qdev)
 {
 #if defined(CONFIG_DEBUG_FS)
 	static struct drm_info_list qxl_mem_types_list[QXL_DEBUGFS_MEM_TYPES];
@@ -343,8 +343,6 @@ int qxl_ttm_debugfs_init(struct qxl_device *qdev)
 			qxl_mem_types_list[i].data = qdev->mman.bdev.man[TTM_PL_PRIV].priv;
 
 	}
-	return qxl_debugfs_add_files(qdev, qxl_mem_types_list, i);
-#else
-	return 0;
+	qxl_debugfs_add_files(qdev, qxl_mem_types_list, i);
 #endif
 }
-- 
2.25.0

