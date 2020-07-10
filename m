Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98FBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988FC20775
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3Lb6fIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgGJJ0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgGJJ0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:26:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A97C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:26:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a6so8057600wmm.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=auC0/ER2X305Zg2uDQUhIlsyo4FCeU1u6x9Bb8O7OFY=;
        b=l3Lb6fIExRbdpU0vraUVP54jJ9Vgq6xtltX87nJb8koLNnc3W+QqkaBd6YJiYmTtCd
         EWUKH+L4puqm3WgcQEL++Sx/2bynhDejTAzkIiWGfxtzdW2HllMYxVELMyCopkUsbJ/W
         xyTgBBOnYN/1wpzc1M8m7/JoA8LQk6c4dRGYS87ip4BIMya+Cm1FzutIE2UWOujC+Lkn
         yM2ocnS7s72m8dnH6ksSs75Jmdl6EzIFBnysbjQKVCXyfTkwt2jYuCJ9HahDiVEIWLlE
         DqVTYKlNrtJjfx7PG2tQnz1eAM6ZX4M4Hj3fzb2aiHPP45IUxNl9KWoD9mTyC47IVtQv
         XpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=auC0/ER2X305Zg2uDQUhIlsyo4FCeU1u6x9Bb8O7OFY=;
        b=W6hEp418257Ux2xwym3vuBiYb8n6t7khXNjQFC1LPNwodUjdjWjexzc9ekdXZwPf4n
         ZQsCniDkEh29+FnmzfdOFvBQZXG/oV2v6qcFz7D+L/wn7BLk8pKVbgu8Ly6QI56hPhmB
         hTwinwa3+XHM0uQt9RWz1ckmzowq2B72cAXtXkP+pxQeG0ADK33KcPWcffDHRPloV4y8
         ATiLAOOfrgwe0NEyfXRnZp7P2e+ia5sXuX8dOQFVyAn4ypTjiNRWRsWphva2Cz0oaiNU
         KZqi4uLGajz9ZPZLoLSHnSyBE55CcwKa27LlP9iGQF6p7PhqdoIYHdeLg2+bvwos2sSc
         bojQ==
X-Gm-Message-State: AOAM530e1TpQ+XVfdf4+k+5+KT5p+RHBpeRwO47tdENH+EHIANdiPz+e
        Y9o/tYAc9tt1M55gmVYGckk=
X-Google-Smtp-Source: ABdhPJxhFX6NER9xU/kBe5OXyQKFiHiVINWKc4BkdGJM0r872IK5XL9tWT/139bTTq1uVq0FYb4pAw==
X-Received: by 2002:a1c:2602:: with SMTP id m2mr4503319wmm.50.1594373162132;
        Fri, 10 Jul 2020 02:26:02 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id h23sm8179559wmb.3.2020.07.10.02.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:26:01 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 08/14] drm/panfrost: move devfreq_init()/fini() in device
Date:   Fri, 10 Jul 2020 11:25:42 +0200
Message-Id: <20200710092548.316054-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710092548.316054-1-peron.clem@gmail.com>
References: <20200710092548.316054-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Later we will introduce devfreq probing regulator if they
are present. As regulator should be probe only one time we
need to get this logic in the device_init().

panfrost_device is already taking care of devfreq_resume()
and devfreq_suspend(), so it's not totally illogic to move
the devfreq_init() and devfreq_fini() here.

Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 12 +++++++++++-
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 15 ++-------------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 9f89984f652a..36b5c8fea3eb 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -214,9 +214,16 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 		return err;
 	}
 
+	err = panfrost_devfreq_init(pfdev);
+	if (err) {
+		if (err != -EPROBE_DEFER)
+			dev_err(pfdev->dev, "devfreq init failed %d\n", err);
+		goto out_clk;
+	}
+
 	err = panfrost_regulator_init(pfdev);
 	if (err)
-		goto out_clk;
+		goto out_devfreq;
 
 	err = panfrost_reset_init(pfdev);
 	if (err) {
@@ -265,6 +272,8 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	panfrost_reset_fini(pfdev);
 out_regulator:
 	panfrost_regulator_fini(pfdev);
+out_devfreq:
+	panfrost_devfreq_fini(pfdev);
 out_clk:
 	panfrost_clk_fini(pfdev);
 	return err;
@@ -278,6 +287,7 @@ void panfrost_device_fini(struct panfrost_device *pfdev)
 	panfrost_gpu_fini(pfdev);
 	panfrost_pm_domain_fini(pfdev);
 	panfrost_reset_fini(pfdev);
+	panfrost_devfreq_fini(pfdev);
 	panfrost_regulator_fini(pfdev);
 	panfrost_clk_fini(pfdev);
 }
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index ada51df9a7a3..170d6dbab217 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -14,7 +14,6 @@
 #include <drm/drm_utils.h>
 
 #include "panfrost_device.h"
-#include "panfrost_devfreq.h"
 #include "panfrost_gem.h"
 #include "panfrost_mmu.h"
 #include "panfrost_job.h"
@@ -606,13 +605,6 @@ static int panfrost_probe(struct platform_device *pdev)
 		goto err_out0;
 	}
 
-	err = panfrost_devfreq_init(pfdev);
-	if (err) {
-		if (err != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Fatal error during devfreq init\n");
-		goto err_out1;
-	}
-
 	pm_runtime_set_active(pfdev->dev);
 	pm_runtime_mark_last_busy(pfdev->dev);
 	pm_runtime_enable(pfdev->dev);
@@ -625,16 +617,14 @@ static int panfrost_probe(struct platform_device *pdev)
 	 */
 	err = drm_dev_register(ddev, 0);
 	if (err < 0)
-		goto err_out2;
+		goto err_out1;
 
 	panfrost_gem_shrinker_init(ddev);
 
 	return 0;
 
-err_out2:
-	pm_runtime_disable(pfdev->dev);
-	panfrost_devfreq_fini(pfdev);
 err_out1:
+	pm_runtime_disable(pfdev->dev);
 	panfrost_device_fini(pfdev);
 err_out0:
 	drm_dev_put(ddev);
@@ -650,7 +640,6 @@ static int panfrost_remove(struct platform_device *pdev)
 	panfrost_gem_shrinker_cleanup(ddev);
 
 	pm_runtime_get_sync(pfdev->dev);
-	panfrost_devfreq_fini(pfdev);
 	panfrost_device_fini(pfdev);
 	pm_runtime_put_sync_suspend(pfdev->dev);
 	pm_runtime_disable(pfdev->dev);
-- 
2.25.1

