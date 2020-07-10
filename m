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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502D5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ADD420767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJnJPqdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgGJJy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgGJJyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:54:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49004C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k6so5307066wrn.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xXA70POHCV2GWsHX4CvRyqRrbTFQBlpDYTBkU8Vpd/0=;
        b=dJnJPqdZjOa/bpCkQx4pDHa7OyMgG38PvRdxaKjwpbA1DGpoKxrwXgAjwYoRqid1yP
         03QmhQQu6TJVUj1mjhjyc7b4dBIANAt2Vt7si9SXIg+2JyNgaysXPcKt7DSucR5iX4PN
         6nxEQLafz2nkkDgJGEd3cP6q7TAfzmpf0GV+wtbk8UuRrTKHzg4NJtoZiz8R/eRFiKTQ
         yn7vwVsQaQ7+7CQeyPk/nlqHJLSxDas7WFVvZoao2ayTL3C7huFnzBmc49yXSCugyMBF
         r9LE3JNRR3z6RkZW4hKxzSG6eodFXDbiQv59/z+Yd/WX4sXz8NA3bhE4BaEVsBLz7nOh
         JUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xXA70POHCV2GWsHX4CvRyqRrbTFQBlpDYTBkU8Vpd/0=;
        b=R6e1dRC2QGmzlXumeCoFhGjajg9D5NXWyqy9x+mmkfJy7HCeswVMBQBKW1ZB5enInR
         tQSw6Mcl8Qtz59GQGv6p970NQ8/OYxzWxhcepMqBXiSi+D6CfqpREknTxywXbxS3RWCo
         9uoV7WjhIJelR9lAyVz+Xe9g8sUsMg/T8Yjo91SWnBcqBl429W8sBeYmJ29Q6UTH6owp
         CP1cfnZVpNUuQ90EMAvICJCfXAyNpgqzEmY2cbBbnplVqokam+jxCSxRGWLhlMaFms9a
         ooqhUln5NfaOx7FpXphssfFKNUv1nCTVp2uew8WmXvL12vKmeGHeAcSJhrmieE2Sxw9l
         ITWQ==
X-Gm-Message-State: AOAM531g+6pPSaDJ+Zh8g04JxeViR1kh4FQPRU5ftGUhuYzoKD4hY6Yx
        oTtdzPwF7il///z19rvXCC8=
X-Google-Smtp-Source: ABdhPJyxMtH1m8JCcPY59Kapmk4/ptiy3b6zjq6ct3rJ+VI1rdg7CGIPVONJ6HVDnNbOYJSFMUKB5w==
X-Received: by 2002:adf:f34f:: with SMTP id e15mr68195427wrp.415.1594374860909;
        Fri, 10 Jul 2020 02:54:20 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id u23sm10176092wru.94.2020.07.10.02.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:54:20 -0700 (PDT)
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
Subject: [PATCH v5 07/14] drm/panfrost: rename error labels in device_init
Date:   Fri, 10 Jul 2020 11:54:02 +0200
Message-Id: <20200710095409.407087-8-peron.clem@gmail.com>
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

Rename goto labels in device_init it will be easier to maintain.

Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 30 +++++++++++-----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index b172087eee6a..9f89984f652a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -216,56 +216,56 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 
 	err = panfrost_regulator_init(pfdev);
 	if (err)
-		goto err_out0;
+		goto out_clk;
 
 	err = panfrost_reset_init(pfdev);
 	if (err) {
 		dev_err(pfdev->dev, "reset init failed %d\n", err);
-		goto err_out1;
+		goto out_regulator;
 	}
 
 	err = panfrost_pm_domain_init(pfdev);
 	if (err)
-		goto err_out2;
+		goto out_reset;
 
 	res = platform_get_resource(pfdev->pdev, IORESOURCE_MEM, 0);
 	pfdev->iomem = devm_ioremap_resource(pfdev->dev, res);
 	if (IS_ERR(pfdev->iomem)) {
 		dev_err(pfdev->dev, "failed to ioremap iomem\n");
 		err = PTR_ERR(pfdev->iomem);
-		goto err_out3;
+		goto out_pm_domain;
 	}
 
 	err = panfrost_gpu_init(pfdev);
 	if (err)
-		goto err_out3;
+		goto out_pm_domain;
 
 	err = panfrost_mmu_init(pfdev);
 	if (err)
-		goto err_out4;
+		goto out_gpu;
 
 	err = panfrost_job_init(pfdev);
 	if (err)
-		goto err_out5;
+		goto out_mmu;
 
 	err = panfrost_perfcnt_init(pfdev);
 	if (err)
-		goto err_out6;
+		goto out_job;
 
 	return 0;
-err_out6:
+out_job:
 	panfrost_job_fini(pfdev);
-err_out5:
+out_mmu:
 	panfrost_mmu_fini(pfdev);
-err_out4:
+out_gpu:
 	panfrost_gpu_fini(pfdev);
-err_out3:
+out_pm_domain:
 	panfrost_pm_domain_fini(pfdev);
-err_out2:
+out_reset:
 	panfrost_reset_fini(pfdev);
-err_out1:
+out_regulator:
 	panfrost_regulator_fini(pfdev);
-err_out0:
+out_clk:
 	panfrost_clk_fini(pfdev);
 	return err;
 }
-- 
2.25.1

