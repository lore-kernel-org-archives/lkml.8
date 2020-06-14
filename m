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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26D9C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 07:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E6320714
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 07:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si+mBzty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgFNHJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 03:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgFNHJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 03:09:55 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E97BC03E96F
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 00:09:55 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r77so14546910ior.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 00:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VPVqWxYm5OyjOv331996CGH9YiPFKfJycn9OwXQfzdE=;
        b=Si+mBztyXLpNw+lq5vPMpNGKP0EI+ykD3vuqlK8ZNIb6UkkFhoAM75WVjN+g8jSLhX
         hIJJyaxEmiWwfH5wcCzyDLENdFDvHBlpi1xEwIQ+owxGEDnzX+6UCXw2KWm0RXCVZ8xl
         LHMyFNVk/L/xf9JlK3iCt3bsP6NN2NR0TYct1K5D9kz23w5XWNCx7UNHpAnA8vWbr1bO
         h/L769+gQ5P8lKjDPBVsZPQ9y04jqz/kxNXDWf4GQb/M9XwDh944S2JfO/qTQRhvkxcQ
         fx+jW6EaXGWkKxT8IanPZXM4TtDgFUJrWisoD06Gd19DB3bNP+utRmrfnc9BT4uoeyY9
         oTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VPVqWxYm5OyjOv331996CGH9YiPFKfJycn9OwXQfzdE=;
        b=Cd+6apZ13h4J4gzVeBIz2vXHmNcgQjt6KyyTu1qup+hJCu5ahS0LjwOXHur+d1L2of
         KLvOeiVufLXeov9bSg4O+40Ds+9TQjA7JXc6ZjqovSIJnbQLTyhIExtsJbDaN/Row3Wz
         o/vcbtT1V9PdkLfDWve8DdRDI2/gAZhzXpXNHhuMbUzsdLVaaWxZ/q4QemiMNmdfvBRp
         /HOVgeBwVmCVKOLPFOJziQSV0SeiRb7L2snKHMaqOqoxBGoGkOR8my9rS6gqt3cE5JII
         oM72B9GSQ0PvmwTjKrHKBPetQ/1xZXwFPv3UlUF3mKVt/NmGKE7m9lOMC4nJSSeztuCO
         +oRw==
X-Gm-Message-State: AOAM531tUmDcEts7XK3UepE3Y5+w+vbSNGA2lchJWXMfB42cQwCJJkpE
        3S1fXOTm7nL0Ew6c4EGsBlw=
X-Google-Smtp-Source: ABdhPJzvR4Y9Cg+Ilsim0VN1KWZMeO3R6+hDT2mOL+p/Qnv2PztUdKChVka4CMmVHQj6eU5oQ3nwIA==
X-Received: by 2002:a05:6602:5ce:: with SMTP id w14mr21839589iox.178.1592118594249;
        Sun, 14 Jun 2020 00:09:54 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id v11sm5944048ile.61.2020.06.14.00.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 00:09:53 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Shirish S <shirish.s@amd.com>, yu kuai <yukuai3@huawei.com>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu
Subject: [PATCH] drm/amdgpu: fix ref count leak in amdgpu_display_crtc_set_config
Date:   Sun, 14 Jun 2020 02:09:44 -0500
Message-Id: <20200614070946.65770-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in amdgpu_display_crtc_set_config, the call to pm_runtime_get_sync
increments the counter even in case of failure, leading to incorrect
ref count. In case of failure, decrement the ref count before returning.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index f7143d927b6d..5e51f0acf744 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -282,7 +282,7 @@ int amdgpu_display_crtc_set_config(struct drm_mode_set *set,
 
 	ret = pm_runtime_get_sync(dev->dev);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = drm_crtc_helper_set_config(set, ctx);
 
@@ -297,7 +297,7 @@ int amdgpu_display_crtc_set_config(struct drm_mode_set *set,
 	   take the current one */
 	if (active && !adev->have_disp_power_ref) {
 		adev->have_disp_power_ref = true;
-		return ret;
+		goto out;
 	}
 	/* if we have no active crtcs, then drop the power ref
 	   we got before */
@@ -306,6 +306,7 @@ int amdgpu_display_crtc_set_config(struct drm_mode_set *set,
 		adev->have_disp_power_ref = false;
 	}
 
+out:
 	/* drop the power reference we got coming in here */
 	pm_runtime_put_autosuspend(dev->dev);
 	return ret;
-- 
2.17.1

