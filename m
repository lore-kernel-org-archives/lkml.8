Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4156CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 02:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C0C82074D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 02:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="HxATxqIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgFNCpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 22:45:04 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:58584 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgFNCpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 22:45:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49kzMf5Z3bz9vBtM
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 02:45:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NLBgI1kOWvXb for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 21:45:02 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49kzMf3k1Yz9vBtD
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 21:45:02 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49kzMf3k1Yz9vBtD
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49kzMf3k1Yz9vBtD
Received: by mail-io1-f72.google.com with SMTP id h65so8941361ioa.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 19:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rd2VjpzQgkEClsEYtAWgC+2Wg7FwSwBjiaqDtTh+S08=;
        b=HxATxqIHtlr+96w9P6AFy9iierCYkjOYBhGVkz3bOHlbza7ltvrOv7V9YBSd2Cdc4F
         Mp74lvOSNbVRm8H9OBgbaNPH5K0Z1kX+gIZV+EU0B5qZUtoFIFOxmp0szGFD0LVl54Ib
         dSHPMvXjTXyREpnowAy2W3xH2T8Qxc8sJVZgGYaCacFTB+g73KBNIbm1irNW48m4kIGC
         tWYpBr0VIBPuo6QQRprd4Mos/hh1FDaZwntWslyOw0uLdMETUFEXh90klLlvahGT6gLN
         FnAlQOhrA+RkXDXbfCYueGuXJttoY2MzilHCnxgO7oCt1VXu1hJFFH8ludppnpMYIJ0H
         sv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rd2VjpzQgkEClsEYtAWgC+2Wg7FwSwBjiaqDtTh+S08=;
        b=mnb4hAN2GhrUpWVC87f3WVnS6TMTPsZUG6iISLdvUvh4d0PW/49xnRE8k+KAu1FJoH
         nHskMq5KQP4gi3qE1P9KRwLowiN3U+DQRTzRoZ2eiv9WrU+o17stltfKEI4Yvw3Y9xl7
         F9le/FzlnLVypbCznqcpTXD7oPbvmVQO2z7ZpovFpACYl8h+6Mok7vEqPxbIAaktwxn8
         Hm7xCQOIOu3SXFDK/Z70qm03BxP+eCa2C0Utw3pKvLynLDUioYMtVCjdu5uxntSQL3CA
         t8BEapmK1B/8MsdXlWSxHDLlcKV+3vq0nWuot+wIGcwMAWp5DvxnECfB4lFNSx9ZO7az
         m3ZA==
X-Gm-Message-State: AOAM532ZjSxVwv5ICVew5SfaJsrDktbPVDImMCIVSvhnVDVenZaIPYdT
        qu+5G9JtcOxzh+igyFU7QjJ7BCZtoCKH4HDAfbrMZTjWe0btt8Gxw07QHghl0VhzIFqz61M/0fq
        IaFJJdzRkq37cw4gl3iV4GAEWbs26
X-Received: by 2002:a02:2444:: with SMTP id q4mr15015783jae.29.1592102701783;
        Sat, 13 Jun 2020 19:45:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGSBps24otpQFtoYYQPeA7t7P0ZZ1AIxnDyr0Ew5+8uROSBa8DH3IN9OjwWqBGbKM1cjqh5g==
X-Received: by 2002:a02:2444:: with SMTP id q4mr15015776jae.29.1592102701608;
        Sat, 13 Jun 2020 19:45:01 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:49fa:9c47:e40b:9c40])
        by smtp.gmail.com with ESMTPSA id 13sm5689192ilg.24.2020.06.13.19.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 19:45:01 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, wu000273@umn.edu, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/v3d: fix reference count leaks due to pm_runtime_get_sync
Date:   Sat, 13 Jun 2020 21:44:59 -0500
Message-Id: <20200614024459.126372-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On calling pm_runtime_get_sync() the reference count of the device
is incremented. In case of failure, decrement the
reference count before returning the error.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/gpu/drm/v3d/v3d_debugfs.c | 8 ++++++--
 drivers/gpu/drm/v3d/v3d_drv.c     | 4 +++-
 drivers/gpu/drm/v3d/v3d_gem.c     | 4 +++-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_debugfs.c b/drivers/gpu/drm/v3d/v3d_debugfs.c
index e76b24bb8828..7ceb945e3a31 100644
--- a/drivers/gpu/drm/v3d/v3d_debugfs.c
+++ b/drivers/gpu/drm/v3d/v3d_debugfs.c
@@ -133,8 +133,10 @@ static int v3d_v3d_debugfs_ident(struct seq_file *m, void *unused)
 	int ret, core;
 
 	ret = pm_runtime_get_sync(v3d->drm.dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(v3d->drm.dev);
 		return ret;
+	}
 
 	ident0 = V3D_READ(V3D_HUB_IDENT0);
 	ident1 = V3D_READ(V3D_HUB_IDENT1);
@@ -220,8 +222,10 @@ static int v3d_measure_clock(struct seq_file *m, void *unused)
 	int ret;
 
 	ret = pm_runtime_get_sync(v3d->drm.dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(v3d->drm.dev);
 		return ret;
+	}
 
 	if (v3d->ver >= 40) {
 		V3D_CORE_WRITE(core, V3D_V4_PCTR_0_SRC_0_3,
diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 82a7dfdd14c2..9b0a60b0bc11 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -106,8 +106,10 @@ static int v3d_get_param_ioctl(struct drm_device *dev, void *data,
 			return -EINVAL;
 
 		ret = pm_runtime_get_sync(v3d->drm.dev);
-		if (ret < 0)
+		if (ret < 0) {
+			pm_runtime_put_autosuspend(v3d->drm.dev);
 			return ret;
+		}
 		if (args->param >= DRM_V3D_PARAM_V3D_CORE0_IDENT0 &&
 		    args->param <= DRM_V3D_PARAM_V3D_CORE0_IDENT2) {
 			args->value = V3D_CORE_READ(0, offset);
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 09a7639cf161..f2980632896a 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -440,8 +440,10 @@ v3d_job_init(struct v3d_dev *v3d, struct drm_file *file_priv,
 	job->free = free;
 
 	ret = pm_runtime_get_sync(v3d->drm.dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(v3d->drm.dev);
 		return ret;
+	}
 
 	xa_init_flags(&job->deps, XA_FLAGS_ALLOC);
 
-- 
2.25.1

