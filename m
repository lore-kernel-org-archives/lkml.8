Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED031C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 02:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C675820747
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 02:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="inDQYcmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgFNCV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 22:21:27 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:44742 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgFNCV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 22:21:26 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49kyrP1L1sz9vHfJ
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 02:21:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Nj4t_id0TdDo for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 21:21:25 -0500 (CDT)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49kyrN6nZFz9vHdV
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 21:21:24 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49kyrN6nZFz9vHdV
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49kyrN6nZFz9vHdV
Received: by mail-il1-f197.google.com with SMTP id n2so9475096ilq.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 19:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1skhAYqgTNSWsq4lvqV5pXURB90mGpd6sDboa81hzn4=;
        b=inDQYcmHcL3Cz+asrBz/w7/AH+tbLoHWzIu2j3/vBKxYRotaYrR5dtjBlReiW10muR
         JgRA7bR5vnj1ZLaL/RZraj1F3mx2KnqSqFmaI0AN1pl7t3wXWBnHQtOwIfAiEqxfhDwV
         HKUtr3/gv03Oz+PzAaaeW8sVCHIlPPzRLIpmlfBvilKpr1GJWbfuWfSLNFDpXlZKwGhc
         AjwoKU9MfTAeNWiZ1q47UyU7QzPSNrEgTkJ73Byh6v5PoKL7iiSeU/4R35njyzj/5+uT
         qCxwAwiiUTmGJIYYBX51YNcIcbOIgx4uvW6caEEPkoLiC+gnepFHBVifLyZ9PhjKnCD8
         ZIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1skhAYqgTNSWsq4lvqV5pXURB90mGpd6sDboa81hzn4=;
        b=aUlppBqTdCv3UgNMu3Tnm/rTfztFK8jKpG5G68KlRVrd8b1rl0XYRtYbS014VphGE3
         ox0QwLTuDjo0X9vSwjQFw7b74NbgEXp01iv4Us54ZXr4jVJdBqtGkuYVCZXHpQ2k/ixh
         k8VzddSN7q6z2BSBnLNG7zCg0PlAHmIxqQoFGL4yxlMQp6Bz4f1RF/QnWVWLDU7b00Hg
         QHKfpqYn7N6IcAXi9CE/1JTQNcf01DflFMXmihkmX39sEY5LRHCauPYP1vAKIuK8XkRD
         M+WLD0tWYFuInZxSNiunJ5G3cS+pgKaLAiwTjko62jxQM8K5mJ+Wtkchp1Nm81Ff3ZQ3
         xysQ==
X-Gm-Message-State: AOAM530CRCBpyWi+ZGHSIi4Y2XnhM6NMkLqM9AJDKGlTjG1MhX4Ql8s0
        oURZ3qMI5GHN/EQmsCHK+gxoPVU2fZ3OQTyVHIIZnt2C78JCFVad29tfutPaVA/Nfoz/OPAJqTc
        KMndUDOCCkkJAFu3E3OeAt9OyoGbz
X-Received: by 2002:a92:6a06:: with SMTP id f6mr19738336ilc.89.1592101284491;
        Sat, 13 Jun 2020 19:21:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE+vPbigALAessccDcAKFOmVWqMDFxxHN2H7lviB9iL6LRnhGo3tuBBjuUyQNOGb53QjP8Ew==
X-Received: by 2002:a92:6a06:: with SMTP id f6mr19738330ilc.89.1592101284325;
        Sat, 13 Jun 2020 19:21:24 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:49fa:9c47:e40b:9c40])
        by smtp.gmail.com with ESMTPSA id l26sm5762514ild.59.2020.06.13.19.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 19:21:23 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, wu000273@umn.edu,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: Fix reference count leaks caused by pm_runtime_get_sync
Date:   Sat, 13 Jun 2020 21:21:22 -0500
Message-Id: <20200614022122.124908-1-pakki001@umn.edu>
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
 drivers/gpu/drm/radeon/radeon_display.c | 4 +++-
 drivers/gpu/drm/radeon/radeon_drv.c     | 4 +++-
 drivers/gpu/drm/radeon/radeon_kms.c     | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 35db79a168bf..df1a7eb73651 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -635,8 +635,10 @@ radeon_crtc_set_config(struct drm_mode_set *set,
 	dev = set->crtc->dev;
 
 	ret = pm_runtime_get_sync(dev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return ret;
+	}
 
 	ret = drm_crtc_helper_set_config(set, ctx);
 
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index bbb0883e8ce6..62b5069122cc 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -549,8 +549,10 @@ long radeon_drm_ioctl(struct file *filp,
 	long ret;
 	dev = file_priv->minor->dev;
 	ret = pm_runtime_get_sync(dev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return ret;
+	}
 
 	ret = drm_ioctl(filp, cmd, arg);
 	
diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index c5d1dc9618a4..99ee60f8b604 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -638,8 +638,10 @@ int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	file_priv->driver_priv = NULL;
 
 	r = pm_runtime_get_sync(dev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return r;
+	}
 
 	/* new gpu have virtual address space support */
 	if (rdev->family >= CHIP_CAYMAN) {
-- 
2.25.1

