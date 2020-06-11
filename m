Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06C1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE87C20747
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5T4Tekl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgFKI7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgFKI7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:59:30 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18955C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 01:59:30 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g10so4223429wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 01:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vkpecle/NufRhIWFw6o8Icsy3Vg8yQBJnNwa3m6TOrY=;
        b=B5T4TeklMK2kiPUFPKuuVP7i4B9RaICOLmQ0X69pyuhRLLiYf66zl/t9yQbxri1F6x
         hhbN1Jtyz6XDvHQJMaZWpIo6w1GL4iKvhxLlinIrodsKoW2vSITvlTkWlfvkbvMvowKg
         FruLct+0aI/LfplSLqucAjJdDDa1Fq+j5pd/kuutGlFTwNx39exJ1+LtTp5exE1Q5XjG
         GaIrWDswsYmKIR11ri1CuhU3/PQRJHSzO6qOn+g+dSIE6/DT4553GanI+L0rcD13XLcn
         okgjyULRPyGPAFBnD/VaWjNnk/WDAPPFzueKAwimNMBfDm4+OQxPB4rjioBVVmASEHgs
         T0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Vkpecle/NufRhIWFw6o8Icsy3Vg8yQBJnNwa3m6TOrY=;
        b=s/glos5aj4VLFCwYdx189FjpZH09/SkjlLf4j9k+gnd6WZ6drPfJoYrglbU6EplhVL
         wXsGkvJHI3udgguHDNiZ0JRIYgK8Rix5gVVNHCBNuv6A1clbfgYpTPVOT0FV1QMvue9N
         h5IqbmKANLVzwZa8P58cbb25JoDTK6VCH27jYkrOltlLcI+I2brwtyiISnXU+UTQD9Gi
         jOAhO+m7ccSOd8ZiNg2RV7SVcdKlaw4yBlcb8KK5wcJwQskT02cQEx477JgQTNj7Kr5y
         zMPV8EAW3scK6vMwjyGhdBnp9Z0Q8CFD9weJewc0GHAqPQ1oMk0pfpp+G3nh50amRC1o
         SlZw==
X-Gm-Message-State: AOAM531s/2LFePuwm8uF0m+6Prg/kaI/hwIDJlVILrdvJnsUmQU3ZYqh
        sTZD0VInIOiSnYpJz+vqGnWXPjcW
X-Google-Smtp-Source: ABdhPJwa3GUi28/rl/kCJZRru/8f/xiKju5uiGyA5/rHbxua8XuJbAeq6aH2xxRhczSk1eclm+DSMQ==
X-Received: by 2002:a1c:7414:: with SMTP id p20mr7011193wmc.124.1591865968099;
        Thu, 11 Jun 2020 01:59:28 -0700 (PDT)
Received: from cizrna.lan ([109.72.12.141])
        by smtp.gmail.com with ESMTPSA id o20sm4205023wra.29.2020.06.11.01.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 01:59:27 -0700 (PDT)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] panfrost: Make sure GPU is powered on when reading GPU_LATEST_FLUSH_ID
Date:   Thu, 11 Jun 2020 10:58:43 +0200
Message-Id: <20200611085900.49740-1-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bifrost devices do support the flush reduction feature, so on first job
submit we were trying to read the register while still powered off.

If the GPU is powered off, the feature doesn't bring any benefit, so
don't try to read.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index f2c1ddc41a9b..e0f190e43813 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -10,6 +10,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include "panfrost_device.h"
 #include "panfrost_features.h"
@@ -368,7 +369,16 @@ void panfrost_gpu_fini(struct panfrost_device *pfdev)
 
 u32 panfrost_gpu_get_latest_flush_id(struct panfrost_device *pfdev)
 {
-	if (panfrost_has_hw_feature(pfdev, HW_FEATURE_FLUSH_REDUCTION))
-		return gpu_read(pfdev, GPU_LATEST_FLUSH_ID);
+	u32 flush_id;
+
+	if (panfrost_has_hw_feature(pfdev, HW_FEATURE_FLUSH_REDUCTION)) {
+		/* Flush reduction only makes sense when the GPU is kept powered on between jobs */
+		if (pm_runtime_get_if_in_use(pfdev->dev)) {
+			flush_id = gpu_read(pfdev, GPU_LATEST_FLUSH_ID);
+			pm_runtime_put(pfdev->dev);
+			return flush_id;
+		}
+	}
+
 	return 0;
 }
-- 
2.21.0

