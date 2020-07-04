Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A94C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC24F208B8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAmDMlJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgGDK0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 06:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgGDKZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 06:25:52 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D67C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 03:25:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z15so24036459wrl.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 03:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=czEmxOplWl/ihZz6Bt2jvlGMVXmPgT75PDRsU7SwMwA=;
        b=EAmDMlJ2JBtETZactBM4rssBiXrZdMLiMz4NLtV4BcqbwyFQ+4FHmSWTT+H9UUnma6
         Kv006v35J0SQyn5EtFK1IJk8UrTApoDn5aGjcLvDx29gVwq91Sp5SJc7SyIkqJbDzML4
         IIJhBmqkI48V/d7XpRxVnU+IfPNK0x+K0CagrQBQj7s8HM7f4OmOZk0+HNmMBN75/E4f
         g1cLMdruBt44KbJg8MsQ4EyBH2F5MKBJnewBZpvM9zykoSlOozdGuYjWCUEzTwpgBKUX
         ZRP0l2kVvEi7uFZmBEgNo60l9kf042FSOGb95ePnXSuuybeymS4gVK0SOiHg02uDV4GE
         PEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=czEmxOplWl/ihZz6Bt2jvlGMVXmPgT75PDRsU7SwMwA=;
        b=KdeWhiT76Yz6nhXd3McQSo1HumdoWoKyzV+XdrtJTQCqWJMTERNqbuPmWqybdgFd1R
         oL8I2R9edEOvAdKvdA848BZRSfUCfn2EfX1L/XqVZOB8XqfC5n4Wx4K6qcxOMIa0lYWG
         5l28+JV32Zpyhpa3VWs9jTh/PVPz4mHXRaMicN3Wt2t0omPuEwXrZ0fS7E6oYNUMqkSm
         yc3FM7xT1PTre1MrB5UDP615qPouFu6gqfafzCnbFO6xqAVbWhBcKAG75OB25ly6w651
         OWxhPat6XlphirBcHu97yG0BzATbyQXWyHBYnZclw3aY5ldIitNjzrTfSxoSkQjlJkdI
         JPLQ==
X-Gm-Message-State: AOAM530dvrZtMjNrnGHixltNO/TeSlj43oKESrJyYncJDmfLnHJwP66e
        J14091w4xdKFGW+dd2dWpAQ=
X-Google-Smtp-Source: ABdhPJw1psxKrWFiSaDxrj+otByubFEIFRvaF35q6qFjq4w+V4aYu2Yn5JF34Ax+AAtf9OBZdFGMqw==
X-Received: by 2002:a5d:51ce:: with SMTP id n14mr40562723wrv.155.1593858351009;
        Sat, 04 Jul 2020 03:25:51 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id g14sm16421428wrm.93.2020.07.04.03.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 03:25:50 -0700 (PDT)
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
Subject: [PATCH v2 08/14] drm/panfrost: move devfreq_init()/fini() in device
Date:   Sat,  4 Jul 2020 12:25:29 +0200
Message-Id: <20200704102535.189647-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200704102535.189647-1-peron.clem@gmail.com>
References: <20200704102535.189647-1-peron.clem@gmail.com>
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

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 12 +++++++++++-
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 15 ++-------------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index cc16d102b275..464da1646398 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -212,10 +212,17 @@ int panfrost_device_init(struct panfrost_device *pfdev)
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
 	if (err) {
 		dev_err(pfdev->dev, "regulator init failed %d\n", err);
-		goto out_clk;
+		goto out_devfreq;
 	}
 
 	err = panfrost_reset_init(pfdev);
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
index 882fecc33fdb..4dda68689015 100644
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

