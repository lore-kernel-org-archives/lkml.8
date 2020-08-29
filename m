Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3C4C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F06207DA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLkSOoR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgH2OHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 10:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgH2OHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 10:07:13 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E29C061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 07:07:13 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o68so2133390pfg.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 07:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G4Co+LDYHQDXFnU8L4kBtVkB8qH4ZjDz0L0to2gfrKY=;
        b=VLkSOoR/YR8forWhO67URYv2p62bdEUJPYPqIFIdrHshtLyU3x/JWxTnz1xV4x4Eoe
         tbxEFIrPu+Phv9bL3xrw6grMczHzX1voAIt+iylXLjxEpG/egTgZmD+ehF6OmvdfhPvP
         quqbzPRt3Kzp3fwQWnPmKEJcda0P2TxoGmpykz6+/MPuYbzp+Du6YJv6P/onoDXyBN/0
         pwO8QzuQr8l59g4G2vfIQk5F2HybQTbQlwNmyfi8+rXxwpamCKTASm5NFiDJGoL75TOO
         i706fmWgETbTrH9DxVApbbrC53jSQdxmF+FT9P0rvwMtzTpznq9NFhrDayPujwwh2ymn
         K3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G4Co+LDYHQDXFnU8L4kBtVkB8qH4ZjDz0L0to2gfrKY=;
        b=KijvGtnBmQbcke1dD+MbKykAcESD1OJ2ufX8SjAFN4fitmC0h0XSGme1XQQP29dwXu
         FIN5dtFuC4JH7BEl2+LJZtahgipcOG/2ZbpRShVjIdJMUPAGJTFGjK7Hw1/+bjigqgfI
         sP1AqiFE2RHqO/K0qBc/jRug7UKy8A+if6NXXrlZsNnaEcb7hYTSPjBp3KOOWR8JcaCq
         reMk2dRYqQi+uhDDXLOeovTBskOeI898e9sp+I3dx8hIpmUZRqhNYk5gyqrGkZRRoqr4
         KcsKWYa8CwKO4iHj/nojOPtZ6kc/qu/8E6i/HQbv4oS4Mf7IfXu8Pco6KIvy9NcPMw2e
         bXqA==
X-Gm-Message-State: AOAM531AwThOhMjoHr1ZFPQW28ujp3QLEhVTTrjju1scFa0ssN6/HdTj
        ZUCJifjzWNKgW+diejFvK+sWG38gkVZ0lg==
X-Google-Smtp-Source: ABdhPJxyqOLquHmdfef3I8zWlT2JV8o6Q8Plfy8AEupDK8yZuT+bcCMdqitS7x/r+KeBRepRufcVtQ==
X-Received: by 2002:a63:9d0f:: with SMTP id i15mr2581489pgd.413.1598710032881;
        Sat, 29 Aug 2020 07:07:12 -0700 (PDT)
Received: from localhost.localdomain ([61.83.141.80])
        by smtp.gmail.com with ESMTPSA id h193sm2691889pgc.42.2020.08.29.07.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 07:07:12 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/vkms: add support for gamma_set interface
Date:   Sat, 29 Aug 2020 14:06:47 +0000
Message-Id: <20200829140647.7626-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently vkms module doesn't support gamma function for userspace. so igt
subtests in kms_plane(pixel-format-pipe-A-plan) failed for calling
drmModeCrtcSetGamma(). This patch set gamma_set interface in vkms_crtc_funcs for
support gamma function. With initializing crtc, added calls for setting gamma
size. it pass the test after this patch.

Cc: Daniel Vetter<daniel@ffwll.ch>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index ac85e17428f8..643435fb2ee6 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -160,6 +160,7 @@ static const struct drm_crtc_funcs vkms_crtc_funcs = {
 	.get_crc_sources	= vkms_get_crc_sources,
 	.set_crc_source		= vkms_set_crc_source,
 	.verify_crc_source	= vkms_verify_crc_source,
+	.gamma_set		= drm_atomic_helper_legacy_gamma_set,
 };
 
 static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
@@ -275,6 +276,13 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 		return ret;
 	}
 
+	ret = drm_mode_crtc_set_gamma_size(crtc, 256);
+	if (ret) {
+		DRM_ERROR("Failed to set gamma size\n");
+		return ret;
+	}
+	drm_crtc_enable_color_mgmt(crtc, 0, false, 256);
+
 	drm_crtc_helper_add(crtc, &vkms_crtc_helper_funcs);
 
 	spin_lock_init(&vkms_out->lock);
-- 
2.17.1

