Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE375C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25F02072B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="COPCLdzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgAMWFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 17:05:09 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42885 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbgAMWFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:05:08 -0500
Received: by mail-pl1-f196.google.com with SMTP id p9so4355309plk.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 14:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zd/53b/YzvxFSSJluHpg2s36yjG1ma0E/zaQrjFe9bI=;
        b=COPCLdzLquZ+pTd+qUGkNUztKc9ghw2B0XavyRbkLgcM3Elx5pxsZzkioDeo5ITOFL
         VGVFmmv/j0NnW8j/7RWd/2S05ILFq+ZdcFS5DzhnkEwCUtnEGMTWz6KQB0UkJDZB3DgO
         nUcESk3UDAcutgobfQAP0KuOYM3n+b0NpLSNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zd/53b/YzvxFSSJluHpg2s36yjG1ma0E/zaQrjFe9bI=;
        b=G0kH9SIgkorrnowUTS1BvZcFLPUz16tKFydbtu9PtSYTYTjU6fKRoRhkKtnrbZEmnc
         jo6e8YCsr3BwH8lK1mKcm5NrX/ivbOf7Pa4djQ+ztDx0d3Uy8ngSgxngnwYvW3MrG3o1
         zswDVBeku9hYmJSHCJmzRndKtm8bssEPmWxBWLyUKs88yGY4I7OQsVv6HSonyzkQXGim
         LoYoFLDGItMJGwA8G34lVrlpymlGDgTlniA3o+jnmVfEMdD7lvh3w3FdGRIt2Y5rRh8t
         7z38BH3JjmF3hQJ7IdYAQrbkWC50dIJT6Jj/Bz6/2GhEZwkwJYwdO7FvS7oG1wtJO6kK
         LL0g==
X-Gm-Message-State: APjAAAUwkOI+cQjWh/pzNX0BTBJLchVBjCAnhTO7aSdeC3fd19Pytnxj
        JOWCunO1wMAu4vY9+dTyjb8osg==
X-Google-Smtp-Source: APXvYqwSgta6aJy/jOmbS+805x0Xsc71s56AGXM8UF7sEDgc66R/QG09EQD8z34BuJIgVvxxx8lXQw==
X-Received: by 2002:a17:90a:2351:: with SMTP id f75mr24735687pje.133.1578953107752;
        Mon, 13 Jan 2020 14:05:07 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id v9sm14682621pja.26.2020.01.13.14.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 14:05:07 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <sean@poorly.run>, linux-arm-msm@vger.kernel.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Brian Masney <masneyb@onstation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/msm: Fix error about comments within a comment block
Date:   Mon, 13 Jan 2020 14:04:46 -0800
Message-Id: <20200113140427.1.I5e35e29bebe575e091177c4f82606c15370b71d7@changeid>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My compiler yells:
  .../drivers/gpu/drm/msm/adreno/adreno_gpu.c:69:27:
  error: '/*' within block comment [-Werror,-Wcomment]

Let's fix.

Fixes: 6a0dea02c2c4 ("drm/msm: support firmware-name for zap fw (v2)")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index c146c3b8f52b..7fd29829b2fa 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -67,7 +67,7 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 	 *
 	 * If the firmware-name property is found, we bypass the
 	 * adreno_request_fw() mechanism, because we don't need to handle
-	 * the /lib/firmware/qcom/* vs /lib/firmware/* case.
+	 * the /lib/firmware/qcom/... vs /lib/firmware/... case.
 	 *
 	 * If the firmware-name property is not found, for backwards
 	 * compatibility we fall back to the fwname from the gpulist
-- 
2.25.0.rc1.283.g88dfdc4193-goog

