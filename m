Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0208AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 20:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F69206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 20:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MSOBMFCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgA2UM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 15:12:58 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55648 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgA2UM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 15:12:57 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so266939pjz.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 12:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1QswzSwNt0nlyMcQUYRWMFVYAypouu+MHGAuWWfmqtk=;
        b=MSOBMFCy5z0AIk4r4x2LexiNYBLUyY17LlY2VaTcGY9fRU4R4MY7JGNCNsZxBQtecM
         o+YprV/1np+j6I4TM4iRLm0Ef7rpjUqhyVDKvPrTYGBJpnSoHdykLXRLlQkKHieL567w
         /KKJwwgb1So2O9S3ti8aIKcv7G8H9VjpKoBG0gwpxYL/+IyDtDvqYqrpYeqRYOdCQGyF
         MiTy/auwSgZMlmGf0WWU9PLqm4WLs29fM7krmQcn/o6/48gDbVx2OxB10T3UjhcfxbvT
         Ts7mJSisq/ALk24BNhJJyOdWxKm1vjJ0XcVOXFgm6F3uOEFQ/1oUy5b9g+CfL15Va7Lp
         NMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1QswzSwNt0nlyMcQUYRWMFVYAypouu+MHGAuWWfmqtk=;
        b=pPWzSbTBwb92Ma/nXOBV/xu+NR56OgpS1524MJBUqySUbASCM6VO/JN/QC/eOIItnO
         eOqHnAmlCqzdenSJFs3aWj56500N8OR+Eed3Rq1lHfc3ArEq9JY9BHIbHkuKGbYMUAqf
         h17kMbPyurBkfoiSDsH+HICTPVDGOW1KTO8dTGHfg1Wk4MMmFDLjH5lBwRqT50L85oFu
         MUF1wYOxXfV75ZQvKED7WLzS1ovnxi+pDZERBUAt3VsPlX9OHNmbfIpymlf62+Uk48B/
         9uUWeExHAzdDIJyiWxyHzCVa/Uw9PVGK/119mxTHrdgrYLULNEgklySN7mpYZJICW3gK
         hsIg==
X-Gm-Message-State: APjAAAWi5sEIeW0097y9alq/rhkEFVZDNYlGpNdVZR1Z73zacE64j0cD
        7otRTHB3jqVdcglFnRmP1EiKsClYN7U=
X-Google-Smtp-Source: APXvYqzDagHxMneZm7dwEMu6DvKBueB5ddpfamAzb0TZ1FKo76qqnLtLzsJ+83Uu7ouIws4qJCdIlg==
X-Received: by 2002:a17:90a:9285:: with SMTP id n5mr1629941pjo.58.1580328776641;
        Wed, 29 Jan 2020 12:12:56 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id i11sm3579727pjg.0.2020.01.29.12.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 12:12:51 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Sami Tolvanen <samitolvanen@google.com>,
        Todd Kjos <tkjos@google.com>,
        Alistair Delva <adelva@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        freedreno@lists.freedesktop.org, clang-built-linux@googlegroups.com
Subject: [PATCH] drm: msm: Fix return type of dsi_mgr_connector_mode_valid for kCFI
Date:   Wed, 29 Jan 2020 20:12:44 +0000
Message-Id: <20200129201244.65261-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was hitting kCFI crashes when building with clang, and after
some digging finally narrowed it down to the
dsi_mgr_connector_mode_valid() function being implemented as
returning an int, instead of an enum drm_mode_status.

This patch fixes it, and appeases the opaque word of the kCFI
gods (seriously, clang inlining everything makes the kCFI
backtraces only really rough estimates of where things went
wrong).

Thanks as always to Sami for his help narrowing this down.

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Alistair Delva <adelva@google.com>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: freedreno@lists.freedesktop.org
Cc: clang-built-linux@googlegroups.com
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 271aa7bbca925..355a60b4a536f 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -336,7 +336,7 @@ static int dsi_mgr_connector_get_modes(struct drm_connector *connector)
 	return num;
 }
 
-static int dsi_mgr_connector_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status dsi_mgr_connector_mode_valid(struct drm_connector *connector,
 				struct drm_display_mode *mode)
 {
 	int id = dsi_mgr_connector_get_id(connector);
-- 
2.17.1

