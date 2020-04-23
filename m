Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4180C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1C5206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="HDWmhCXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgDWVK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgDWVKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 17:10:25 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E249C09B043
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 14:10:25 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id t8so3667572qvw.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 14:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OznIskxLEmtu/QkMuofbi8Hv/l/O/vY0LWIonX2v6/0=;
        b=HDWmhCXgHFsTLLcphP+WIWEuRTazXG+nj2IFryAZzi3LaKFikQ/kbEw/1eYYlc2EAu
         rlP4a8T01kvPycC/L1jIKc1649iugOK8bkpJ8pGnag6+oQL5Q/t4g6X9wJdyYVgs4E6Q
         Wm89DH254gNh0jJN8vwAhwNU2+uZklXZ9Fb13437bsjht89uyP7lAJFiu7Q0CoFky9pO
         6mXRG6P3x8paQ6Px1wteHecOTrIUk5c6xnkkyvJeZWos/i8VAYVMIRLwMDNi/s4Y+tjf
         ERiDEtmWqdrLzkzQMZlgPFqaKz6de/3Yepocg8K0oqllyqj6P8aj2p4rppkWcFpIOnUV
         iU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OznIskxLEmtu/QkMuofbi8Hv/l/O/vY0LWIonX2v6/0=;
        b=oJzCtiNF3et2fdg0JJIvpwXfLKKuP9yKSxbsnTRiG8iTtJmJ5R8ODzkdvaBLMq/P3r
         ohLHL5xwz7vuucivkfJ/8eezhAgzqfuH6k6CXeuk3oD5dQrPV7CynGtpLEK2S+JLXxJI
         XMkjv9TBIJRxVhhSTqeqRao6e40lIP6eECXit2JGRYonyvIJxkiN9ENmX2T1RBTr7ntz
         CwneDySOKxTiYpvQJfo9W+xgTQW4piyqAIy8zzf4N0uC22jMkay/xR1EzhA2zZabMCZH
         9FrdRnh8w+ZmqybkrIHzyTbcVyluQLJ6xKVg85b/bya4egU/hy3Ru1lNY/5yFQEcRFvl
         izfg==
X-Gm-Message-State: AGi0PuZ7rLT70/amTZhnroQBoPt8/U2M3Qa0cwXMI67xSlKDIKGQpZ0I
        8AQT6AYn+RSEgFVb1b/JbM/Szw==
X-Google-Smtp-Source: APiQypJlblvSwiOiCVaavRDtMFgfWWKA5keisrxO/bk8aKribOb5caIEKhyujQ4BrBPl7LSzI8qjCg==
X-Received: by 2002:a05:6214:530:: with SMTP id x16mr6061009qvw.55.1587676223869;
        Thu, 23 Apr 2020 14:10:23 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id n4sm2341495qkh.38.2020.04.23.14.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 14:10:23 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Jordan Crouse <jcrouse@codeauorora.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/9] drm/msm: add internal MSM_BO_MAP_PRIV flag
Date:   Thu, 23 Apr 2020 17:09:14 -0400
Message-Id: <20200423210946.28867-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200423210946.28867-1-jonathan@marek.ca>
References: <20200423210946.28867-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag sets IOMMU_PRIV, which is required for some a6xx GMU objects.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Reviewed-by: Jordan Crouse <jcrouse@codeauorora.org>
---
 drivers/gpu/drm/msm/msm_gem.c | 3 +++
 drivers/gpu/drm/msm/msm_gem.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index d8f56a34c117..6277fde13df9 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -428,6 +428,9 @@ static int msm_gem_pin_iova(struct drm_gem_object *obj,
 	if (!(msm_obj->flags & MSM_BO_GPU_READONLY))
 		prot |= IOMMU_WRITE;
 
+	if (msm_obj->flags & MSM_BO_MAP_PRIV)
+		prot |= IOMMU_PRIV;
+
 	WARN_ON(!mutex_is_locked(&msm_obj->lock));
 
 	if (WARN_ON(msm_obj->madv != MSM_MADV_WILLNEED))
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 30584eaf8cc8..972490b14ba5 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -13,6 +13,7 @@
 
 /* Additional internal-use only BO flags: */
 #define MSM_BO_STOLEN        0x10000000    /* try to use stolen/splash memory */
+#define MSM_BO_MAP_PRIV      0x20000000    /* use IOMMU_PRIV when mapping */
 
 struct msm_gem_address_space {
 	const char *name;
-- 
2.26.1

