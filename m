Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF54C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 05:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6872220679
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 05:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9gX5dcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgFOFtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 01:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgFOFts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 01:49:48 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70098C061A0E;
        Sun, 14 Jun 2020 22:49:48 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y5so16455155iob.12;
        Sun, 14 Jun 2020 22:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7ruDvGofOhhRFxjxzvARwe0MCxEQwIr7VVI2CrJkuL4=;
        b=B9gX5dcbUS3bQsdiuc+bkQzsjfJd6Fx+AEvjavyFA2RhdMhufaEBmncOBD3hmq8PDJ
         iH5AEtTVMXidRaD8hAN2naz3vlWsBM12gwEyDWb4O56ctGvLDkWK88IWOGxcv+YqdrV1
         W417gOw8P7mKooMH3F5Q3YEZZdhyPszJPQp1il0m1BBN2sPz0i5VP0hvfDzreYKlZg7U
         InnfEKE6Rv/eW59qNfL1orn/KdSa39JC+pSkSpwqAJ4DnBOXtU82Q6PS+08jBQLiJA5q
         fN3he/jZsj12Df9LLUuLcb/lZRYVEscizts7xMOkjb6qfml4m0qVgxpHW3Bdlr+nAycN
         spfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7ruDvGofOhhRFxjxzvARwe0MCxEQwIr7VVI2CrJkuL4=;
        b=fu3lJgufsw05EdPXHPX7SDY9AghlxHi2m2S3oEr8tz9TlOxePomrLVJu3h5LhxeuRs
         gRXqW77Qd6nfmK6yFkwTrx4IE9g+Ttf/fygk0l5fht79zgT9/wgqMLOcIPdERx4bh/+c
         BWRaU+65XFrgkRMJ0p7OjPkzvjiVVLP+LiCiA7Q+Qn6jAe/4mHhQtbxpkXZSP4qaLqAj
         aw4XTIJQWc31/JE2haN3G5zd1083cP/WtmdMNHpfMOiGyBuUK+e0ml5bJQNQAZ8rKHga
         vkDrDd9FsGhzT1TanS0I/+aWJAVKIANfd0eF9ndCr9pu8g64BYvZu1U6HZDpolq1Xm12
         FzOQ==
X-Gm-Message-State: AOAM53144l0/GcJFsYHq1EDtGx4+XNIcee5LOkGdAqPYIscIEVuEVeMC
        x3Nl+VhpteujntwTjuVpqzRImv54x7A=
X-Google-Smtp-Source: ABdhPJxruih3vxQf+sbzwLJl+cYEVjlMuvcKUBOAnwdFXsNBfhW7Wku97FRJRruNTcJqrexR7qAQAg==
X-Received: by 2002:a6b:39c3:: with SMTP id g186mr24984270ioa.91.1592200187582;
        Sun, 14 Jun 2020 22:49:47 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id k5sm7395066ili.80.2020.06.14.22.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 22:49:47 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu,
        mccamant@cs.umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH v2] drm/exynos: fix ref count leak in mic_pre_enable
Date:   Mon, 15 Jun 2020 00:49:28 -0500
Message-Id: <20200615054928.55188-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <027d9eb5-a1c1-c329-72c3-a555b71f8677@samsung.com>
References: <027d9eb5-a1c1-c329-72c3-a555b71f8677@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in mic_pre_enable, pm_runtime_get_sync is called which
increments the counter even in case of failure, leading to incorrect
ref count. In case of failure, decrement the ref count before returning.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
Changes in v2:
	- reuse the unlock label and call pm_runtime_put_noidle
---
---
 drivers/gpu/drm/exynos/exynos_drm_mic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_mic.c b/drivers/gpu/drm/exynos/exynos_drm_mic.c
index a86abc173605..3821ea76a703 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_mic.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_mic.c
@@ -269,8 +269,10 @@ static void mic_pre_enable(struct drm_bridge *bridge)
 		goto unlock;
 
 	ret = pm_runtime_get_sync(mic->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(mic->dev);
 		goto unlock;
+	}
 
 	mic_set_path(mic, 1);
 
-- 
2.17.1

