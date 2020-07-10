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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AA1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EB5620775
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+kb02Ps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgGJJyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgGJJyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:54:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C3EC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so5264945wrp.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=auC0/ER2X305Zg2uDQUhIlsyo4FCeU1u6x9Bb8O7OFY=;
        b=d+kb02PsRK1wEqOMLgu8attRnWWaL626kc+prWU5IhFYrQ/TJQvGleGCsUD9cLkMgx
         fyjUvJ541cdmfvAJoLBpQpkqlZtye9AGub+0mlLLxbHUq2dpaw0KOvn8sGUsUk6XH1zo
         ibZDWKJWV84vg3cMGtmve5OTerQsspf6xk8dVcKYaiqXrKs8GfAPQx0VzZAWsAr0Qfu/
         xUI+0poBiO8anix0nuf0dbKwxB6OpQcEVjas/MlKObpFBEzbSuHJgSnmO0zyPnAZVghI
         mBsP4rBS6g+PUO3+LrCMwL8Iw4L2CfS33/gXQ2SBA/X7g2Su1OKTDK/oSbh/rSc0X0Qh
         /7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=auC0/ER2X305Zg2uDQUhIlsyo4FCeU1u6x9Bb8O7OFY=;
        b=oZwQ8aB0yBx54q0gYEEyFzC2bfJ3pnmnnsPGfrwOUIXC8cmPjUWRRU/n8jkDUS0E8m
         fl9as3HI+hqIGl9RHiMjO+eNgmP6PA8k8VnX46oKHtbrx+gu5/mWmX74SdTndGLmod8H
         9vr1pMV310aH1bFssghtDGeAV+ENnm0eNhl9EOR3KqEqiGsDY4ttszLW69wKX+hWzf2v
         nBSXugZ9t1JiUJz9XfOyTWodUCtilRD9HkAUMJpAAFcz28IXk0p3dqVXkqPgdJazSFyO
         bCeBBuFLajSGdYUSxr6vNu0pSoPnoc8Tm+V3DdqHab6q4vA07zAoqViZsy19SdyAYqBu
         t6zg==
X-Gm-Message-State: AOAM533JS6Z95B9ht3HCZ+E2uYu2YtSON8ahNlm4rIrr1ipCGVoAZfbL
        kBPkyfXvmQ/ZTbMGYtmYpSg=
X-Google-Smtp-Source: ABdhPJw+EuxYSIsmpRLmuSRr3Lj4oqNHvTDxWHVCBqx8/LiOwYZntGd4inCKn+UupXPZvgs2nWPjvg==
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr66786532wrw.199.1594374862113;
        Fri, 10 Jul 2020 02:54:22 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id u23sm10176092wru.94.2020.07.10.02.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:54:21 -0700 (PDT)
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
Subject: [PATCH v5 08/14] drm/panfrost: move devfreq_init()/fini() in device
Date:   Fri, 10 Jul 2020 11:54:03 +0200
Message-Id: <20200710095409.407087-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710095409.407087-1-peron.clem@gmail.com>
References: <20200710095409.407087-1-peron.clem@gmail.com>
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

