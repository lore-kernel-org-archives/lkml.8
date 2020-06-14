Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1896AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB40F20714
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngmPHhrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgFNGXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 02:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgFNGXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 02:23:46 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F75C03E96F;
        Sat, 13 Jun 2020 23:23:46 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id i25so14540205iog.0;
        Sat, 13 Jun 2020 23:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YKS8gM347vC6eBkm4Z/mHFPXutm1BnydR4TUyYY4ZoQ=;
        b=ngmPHhrWqQ3IcGsjjFder735SJJuYeAncWRBp/l/geamiltraOXzmr5I2ygABHqPaw
         FCx/qRrWsG8kJ+wAS60YzXYnZPLpwUWX5YL3ZSb7Xb8AkTNNPJtjzEffwD/PmNusCi6j
         NvKOGSNetOYvZUUZzTIZCP9wthuanXxWPbsqSLqKpa8yI8YuyUWdMA6YQxLNxoD1aasJ
         tmJSG7WRPfu1EyA61NMn+ShfVLfEmDZedCidaN+UkVW7FfpVsnlW3jT/iiROzEvUVItY
         lPGs+TPmmsRCzYnIebL8WJOTdw3pD+0CKoNBdmmInli3cU+s7x5vQnq9bMYla/TgW/Wt
         xadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YKS8gM347vC6eBkm4Z/mHFPXutm1BnydR4TUyYY4ZoQ=;
        b=UF1fNq+wt0wQ7JN/5RGgdtRzqRoi2SAQyc95H9dQlk7diAb5RLSeCCD/kVzOVOXK7x
         E3bOSzk826+ISx+rIquYD1OIgY+WD7062T4/pFXcpW2Q2eEYs5s1LHlIBGtlvMlYvU6L
         /k2ZxzcM6DOUZmqwP0HBFK+8o+zy5s4VBKKazqikzOF4aHxAb7mJdc8Yy1NaqMdtnT72
         NpXoxby6SWWcbjKekho4PEbpoQq9CzND5V4bI7WvhoATdEMdTVqMBT0u54lbRy9xPeXK
         r0aD4EFU38hxFlZNXXgdMcq1T+ffLtySysGaFedF8Ef2pCcvXyDoRCGedZQKIz7XWvPZ
         q6Ig==
X-Gm-Message-State: AOAM531iD9aHLZpfa1tfVMGJ+H+d2Js+NgxLXqml0Pg5sO5JKdSc0ktB
        gJvQyjA+n3fFGZ/J04EXupU=
X-Google-Smtp-Source: ABdhPJx5u7CZ+5KI8e9/YmR10s/Tdybn2EupE69+Yp3Ek+4luj4xENHKzjVMeL78OQ0UrI1sFa0k8w==
X-Received: by 2002:a05:6602:2583:: with SMTP id p3mr9781842ioo.179.1592115825136;
        Sat, 13 Jun 2020 23:23:45 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id r17sm5944048ilc.33.2020.06.13.23.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 23:23:44 -0700 (PDT)
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
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] drm/exynos: fix ref count leak in mic_pre_enable
Date:   Sun, 14 Jun 2020 01:23:39 -0500
Message-Id: <20200614062339.87374-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in mic_pre_enable, pm_runtime_get_sync is called which
increments the counter even in case of failure, leading to incorrect
ref count. In case of failure, decrement the ref count before returning.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_mic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_mic.c b/drivers/gpu/drm/exynos/exynos_drm_mic.c
index a86abc173605..69ff74c2ceb5 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_mic.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_mic.c
@@ -270,7 +270,7 @@ static void mic_pre_enable(struct drm_bridge *bridge)
 
 	ret = pm_runtime_get_sync(mic->dev);
 	if (ret < 0)
-		goto unlock;
+		goto turn_off;
 
 	mic_set_path(mic, 1);
 
-- 
2.17.1

