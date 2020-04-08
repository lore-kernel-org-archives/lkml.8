Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E9DC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 06:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E1E2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 06:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfHaryGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgDHGFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 02:05:47 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34925 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgDHGFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 02:05:45 -0400
Received: by mail-qt1-f193.google.com with SMTP id s30so4773125qth.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 23:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BolFWd14WO+07x42q+NvjLF3kPvMgvGMwHbwwQBqjHE=;
        b=ZfHaryGpXDZQY+KbquBedmRyvL1FX0SDiI1n5Fboyy62RTY5z5bPq1Kcy9DTrP4+xW
         cCyt7dMLG7rWy+eMn9uqqa0rY9pYVD1tYUk4pQDAGqz/ZqPZUh/Fb2vcB2rxyn3wJoAq
         mvuebJ3j0iZuayHDvCM+dNxT73S7B+YnU7SrtdInTV5FeUbCY1eEpqx0yYd9bdX+Vz0C
         3tkTJU/j+pE4Kf28+FkCjLuPbzQp/JuTEWi6tu5E+SQEppleQlag33CxSq/kEtM2JGkp
         f+qHJy2oBOfoJZhg3t53DMu7d5s0u/z9+EsE8jcZjT/pyjCL8EckSiOIbcSfVAzQidBO
         xtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BolFWd14WO+07x42q+NvjLF3kPvMgvGMwHbwwQBqjHE=;
        b=Z4Gz8RRkxmRbxiuQ+hzgHkzxyXz+x/YE2LF/ggvsDZa7xsc/qCGJhskDEEzpDLSfmO
         Dlot3HfuCXXxcfY1xs0fpp3QkEdwQqMMq5eNxUTQFNdDrZUmpMKqh6GVkq1LYRo/whL2
         DCYiY15z0N9GgOcplfoatht4fm7PMBB++OoKD1dEbTEDeR/rp3Z22+vti/7yWCQl4VXe
         stxYRPfddL/xMQOajqEWVvlzYrvT0BaagO8D6VsIAlbLpFG72MX7MD/OTQSWwF0MVcLk
         90lYZp+Hq0BsGaJmFqaCG/Om5RYa7BjEl0e7sdIULvZcQVAQuKJqTPEHMdqN7gOeA081
         5Aow==
X-Gm-Message-State: AGi0PuaPVpf9ZtyKHKplutmuxER2AAk0Axw133AknLX1vXKxlWVCMfrh
        M9BKvZoxHu9kdizTWjJ+ndQ=
X-Google-Smtp-Source: APiQypKYgXWEDmkaBN+PUmKCGzuGHbMIRZlG1RL5mDSc50N9gjyso8CL2uET+7OUsu4VE5U1IqYUog==
X-Received: by 2002:ac8:a09:: with SMTP id b9mr5903801qti.190.1586325944311;
        Tue, 07 Apr 2020 23:05:44 -0700 (PDT)
Received: from arch.localdomain (189-69-221-86.dial-up.telesp.net.br. [189.69.221.86])
        by smtp.gmail.com with ESMTPSA id w30sm19664170qtw.21.2020.04.07.23.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 23:05:43 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, manasi.d.navare@intel.com
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH 1/2] drm/vkms: Rework vkms_vblank_simulate
Date:   Wed,  8 Apr 2020 03:05:02 -0300
Message-Id: <20200408060503.47709-2-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408060503.47709-1-gabrielabittencourt00@gmail.com>
References: <20200408060503.47709-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Virtual Vblank on VKMS. Rework part of
'vkms_vblank_simulate' for schedule a compose worker outside.

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index ac85e17428f8..a72769b81efe 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -7,6 +7,12 @@
 
 #include "vkms_drv.h"
 
+static bool vkms_queue_compose_worker(struct vkms_output *output,
+				      struct vkms_crtc_state *state)
+{
+	return queue_work(output->composer_workq, &state->composer_work);
+}
+
 static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 {
 	struct vkms_output *output = container_of(timer, struct vkms_output,
@@ -22,12 +28,12 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 
 	spin_lock(&output->lock);
 	ret = drm_crtc_handle_vblank(crtc);
-	if (!ret)
-		DRM_ERROR("vkms failure on handling vblank");
-
 	state = output->composer_state;
 	spin_unlock(&output->lock);
 
+	if (!ret)
+		DRM_ERROR("vkms failure on handling vblank");
+
 	if (state && output->composer_enabled) {
 		u64 frame = drm_crtc_accurate_vblank_count(crtc);
 
@@ -44,7 +50,7 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 		state->crc_pending = true;
 		spin_unlock(&output->composer_lock);
 
-		ret = queue_work(output->composer_workq, &state->composer_work);
+		ret = vkms_queue_compose_worker(output, state);
 		if (!ret)
 			DRM_DEBUG_DRIVER("Composer worker already queued\n");
 	}
-- 
2.25.1

