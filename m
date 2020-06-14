Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8959BC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5222065C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fr93qj4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgFNG73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 02:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgFNG72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 02:59:28 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329A3C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:59:28 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id 9so12448700ilg.12
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=auNQFE3Ts/lVKnLWQnQdPedtvSl90z04f6oWD1caeAc=;
        b=fr93qj4cO5q9jan80fW8xtu+/eibTNkcbWX449Tp/akm4f6PjZ8mDsVrgyjU/Empj9
         942OISwA9bSU8EkzzJKKUspnzShkwbC3ctM6GNXC/vFp4d2IzrHolJnTRhAu9WY2U05n
         46Jv9dB+ChM2nehsNXfLwJVmCtIzhdYw4BxQzSQu6tLvL98HMtl473sY4NqSYhMRk/vR
         33/SsYcnpaEO+62gJXefyW3is8G1hvievGgWQbFfmVweFVzPgEfNF5jcMtbHXCvLTgQY
         m8wQ9mxxeXAT5kpmSAeWFMG5+DkIeSjcsXmx1v5GRCcNneem1mZ2P21CEHhSnOaCbJuJ
         dcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=auNQFE3Ts/lVKnLWQnQdPedtvSl90z04f6oWD1caeAc=;
        b=d3ON6qRnQSYCCkXEv0NXEfL6bfrIwXXZBhKfN2NHGiqlBgQaUgpNOF7D4iCxje79Wx
         G8S9U+T5UDiQW2eoF0gge4YcN+ITm4TBENaOpLVmWWmVXYMXwWqCdcOX0Ui0E9Tr8fqY
         XFOTNnKGymEWwH9kwg1V4ZVxZt2Hzx0HpqlM3VEU9hxcvGgZmlTkyvkmFwTDpboMgsx3
         azHjqKpBmY6eKJd5V4+leo67xvDoECkwh4Vs5fh4pVHC7h3xKbbnuTd4fRjqJGlqmcDX
         X/toFtOssfZg955y4braB4/dwifb+uTMjySOiuHssKywTAPgrGDQfFenk4HJlQ4Monmn
         lwLg==
X-Gm-Message-State: AOAM532DDx3tdCLjpKw3nUmexL1u60+EzrfeSa73STCEQ915Ttnn+nTi
        K8m8C93UVZA5naEWPqc0/PE=
X-Google-Smtp-Source: ABdhPJweiJFF+5LqULDJLR2TwZW0TiEJ6Awp1CZ6WxSBn7w2pKBXDZWYH9RovwOg6lM/3x/4Qtkltw==
X-Received: by 2002:a92:cec3:: with SMTP id z3mr19504546ilq.183.1592117966166;
        Sat, 13 Jun 2020 23:59:26 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id b29sm5843375ioc.32.2020.06.13.23.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 23:59:25 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] drm/vc4: fix ref count leak in vc4_vec_encoder_enable
Date:   Sun, 14 Jun 2020 01:59:18 -0500
Message-Id: <20200614065918.18738-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in vc4_vec_encoder_enable, the call to pm_runtime_get_sync increments
the counter even in case of failure, leading to incorrect
ref count. In case of failure, decrement the ref count before returning.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_vec.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
index bd5b8eb58b18..706fdc7758f9 100644
--- a/drivers/gpu/drm/vc4/vc4_vec.c
+++ b/drivers/gpu/drm/vc4/vc4_vec.c
@@ -406,7 +406,7 @@ static void vc4_vec_encoder_enable(struct drm_encoder *encoder)
 	ret = pm_runtime_get_sync(&vec->pdev->dev);
 	if (ret < 0) {
 		DRM_ERROR("Failed to retain power domain: %d\n", ret);
-		return;
+		goto out;
 	}
 
 	/*
@@ -419,13 +419,13 @@ static void vc4_vec_encoder_enable(struct drm_encoder *encoder)
 	ret = clk_set_rate(vec->clock, 108000000);
 	if (ret) {
 		DRM_ERROR("Failed to set clock rate: %d\n", ret);
-		return;
+		goto out;
 	}
 
 	ret = clk_prepare_enable(vec->clock);
 	if (ret) {
 		DRM_ERROR("Failed to turn on core clock: %d\n", ret);
-		return;
+		goto out;
 	}
 
 	/* Reset the different blocks */
@@ -464,6 +464,8 @@ static void vc4_vec_encoder_enable(struct drm_encoder *encoder)
 	VEC_WRITE(VEC_DAC_MISC,
 		  VEC_DAC_MISC_VID_ACT | VEC_DAC_MISC_DAC_RST_N);
 	VEC_WRITE(VEC_CFG, VEC_CFG_VEC_EN);
+out:
+	pm_runtime_put(&vec->pdev->dev);
 }
 
 
-- 
2.17.1

