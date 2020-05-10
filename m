Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF4DC54E8C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B5A52495C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyrpJtPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgEJQzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 12:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729138AbgEJQzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 12:55:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EB1C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g13so7934749wrb.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MuMQv3TQjzWt0xJoCSiQfhuulnnGfideK7v9jTFs0HY=;
        b=fyrpJtPgFlcuvkPOW5j1/lp3g5iSo+9OUeH0bx+WR5wQrt065deyEwRAZAIiP4QDHh
         l05jlqveetvPYT3qYFdt1AFfz1c0c248txugCWMoglvRmKOoOwxa1kVUVBq2/kbLrgd7
         LqAsaszQO0AUmkCBS05LFzSY7OgZY4kwklq4SlR9FzZiIu32Pc6DKSzq2M+oJa4cFclQ
         Yo02ZOomugp+YuW/rL+dKJR2/f7/6hoSJnH24YIqrt/xv1d0/7JJjQredljULXeczIVn
         DbSfHXahnDECsQERLAMw73eQuNo1dPEB11NFgjqm9V+Azayp5UEyBPD8fI03fqhpwXqS
         9suA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MuMQv3TQjzWt0xJoCSiQfhuulnnGfideK7v9jTFs0HY=;
        b=fEy2miDQ+ThsNDhTXAjhkXPiLUFHrwoP0roatXdiKvwDsVFKJS+xbuXjeWKM0R8d5v
         629/0Gi9VqA9DG0e7EoWxnkFoMOooAw/2sg69lsD1SRfrdFpjjijUQM4UKvvpVggaVhp
         iK+1RkiwxY1j8gsNpKgx7V3hCc1RNHaPteOKmNUdflC/82sW0jxcLsjVu8Yvg6y3aKWl
         Xilqq/5Cp0VuzgqSm6XYB5ZPozJAA+6f10ssC8gzX9Iv+ny43zbeSv6vEit0L4BeBqnS
         4jxcCyuLfivoYBlK10MkBzi56Lo6h97CeHTvEIkA7F0rl8MIAB/Cj6RyPorhGzu+Xzkt
         SI4Q==
X-Gm-Message-State: AGi0PuboEmFppjOFsy6xeL+eKqTvjCzfcW0liONkgko0mCxM1bMgqGTU
        YM2vmYgS/3lyhHDjEuWlx04=
X-Google-Smtp-Source: APiQypJodrcduJhPQ3zVroQSWDBWm48ib5AjP1g8GZC5uLIlDPvSPS+1i5tb3xOxIgjp+i1tXZwetQ==
X-Received: by 2002:adf:8403:: with SMTP id 3mr13603230wrf.186.1589129750653;
        Sun, 10 May 2020 09:55:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:1cc8:b1f1:a2b8:a1ee])
        by smtp.gmail.com with ESMTPSA id g15sm13637670wrp.96.2020.05.10.09.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 09:55:49 -0700 (PDT)
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
Subject: [PATCH 08/15] drm/panfrost: move devfreq_init()/fini() in device
Date:   Sun, 10 May 2020 18:55:31 +0200
Message-Id: <20200510165538.19720-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200510165538.19720-1-peron.clem@gmail.com>
References: <20200510165538.19720-1-peron.clem@gmail.com>
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
 drivers/gpu/drm/panfrost/panfrost_device.c | 37 ++++++++++++++--------
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 15 ++-------
 2 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 8136babd3ba9..f480127205d6 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -212,59 +212,67 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 		return err;
 	}
 
+	err = panfrost_devfreq_init(pfdev);
+	if (err) {
+		dev_err(pfdev->dev, "devfreq init failed %d\n", err);
+		goto err_out0;
+	}
+
 	err = panfrost_regulator_init(pfdev);
 	if (err) {
 		dev_err(pfdev->dev, "regulator init failed %d\n", err);
-		goto err_out0;
+		goto err_out1;
 	}
 
 	err = panfrost_reset_init(pfdev);
 	if (err) {
 		dev_err(pfdev->dev, "reset init failed %d\n", err);
-		goto err_out1;
+		goto err_out2;
 	}
 
 	err = panfrost_pm_domain_init(pfdev);
 	if (err)
-		goto err_out2;
+		goto err_out3;
 
 	res = platform_get_resource(pfdev->pdev, IORESOURCE_MEM, 0);
 	pfdev->iomem = devm_ioremap_resource(pfdev->dev, res);
 	if (IS_ERR(pfdev->iomem)) {
 		dev_err(pfdev->dev, "failed to ioremap iomem\n");
 		err = PTR_ERR(pfdev->iomem);
-		goto err_out3;
+		goto err_out4;
 	}
 
 	err = panfrost_gpu_init(pfdev);
 	if (err)
-		goto err_out3;
+		goto err_out4;
 
 	err = panfrost_mmu_init(pfdev);
 	if (err)
-		goto err_out4;
+		goto err_out5;
 
 	err = panfrost_job_init(pfdev);
 	if (err)
-		goto err_out5;
+		goto err_out6;
 
 	err = panfrost_perfcnt_init(pfdev);
 	if (err)
-		goto err_out6;
+		goto err_out7;
 
 	return 0;
-err_out6:
+err_out7:
 	panfrost_job_fini(pfdev);
-err_out5:
+err_out6:
 	panfrost_mmu_fini(pfdev);
-err_out4:
+err_out5:
 	panfrost_gpu_fini(pfdev);
-err_out3:
+err_out4:
 	panfrost_pm_domain_fini(pfdev);
-err_out2:
+err_out3:
 	panfrost_reset_fini(pfdev);
-err_out1:
+err_out2:
 	panfrost_regulator_fini(pfdev);
+err_out1:
+	panfrost_devfreq_fini(pfdev);
 err_out0:
 	panfrost_clk_fini(pfdev);
 	return err;
@@ -278,6 +286,7 @@ void panfrost_device_fini(struct panfrost_device *pfdev)
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
2.20.1

