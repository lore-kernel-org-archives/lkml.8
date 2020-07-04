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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D718EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF67820870
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yi3Q7Aum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgGDK0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 06:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgGDKZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 06:25:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DF9C08C5DE
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 03:25:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so27252334wrs.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 03:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZTAD94SYmvrJ+EFhISqWY8vBWQR9v8s+XBZIL9+A5es=;
        b=Yi3Q7AumboBSbsek8DjWtlQ9c10SbTrXYjcMr+rBaAc4VHSqVM6IpfGf8cdW0VtY6W
         HD3FhPLO4DAnUDp+vpl1IiNzGQncT8eF2MvWK7LOcfqGQpQ6Lbi5946UXk8j2fadav0f
         RYw1OVPiiI8ipVovArVWNu5/Vqe6mVcYZ+oaZdTsFMJhhQBa78PbriKiG1TN4ZfyIGR+
         RvISp9wqEPCLfOhV78e1wh/CZdlseUZnUwC0Mq24QTscVxu9LlrgUeduTFA8BgWUFZKD
         v6S9s6lGfmAU/5tMhnnAp9spVJLmQa9oNO/Vr3BYQQ0ctTpr8Uj8D2rbrAp7gTt3AvhD
         2+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZTAD94SYmvrJ+EFhISqWY8vBWQR9v8s+XBZIL9+A5es=;
        b=BZLkGu0H8DXGIwsw7Dky0yM0I/9EnwbVn9ggsmEeUWLUHA29/XOvA09XktoU+D6i4X
         u7bPcoQzsq9+JcTOIwSI8fPZiGfqz2fodxD7LO/wmyhypxi6DIeglyYDlQcb2PKq5mJq
         a5lrUuKj9igc9y4jiuPLBDGzO3MeUcKBlPC3GXXVhdsIrkPFy8jc04Uofe7sEtz/B69A
         geiRXy8dNFdf8UmXQ5yIweq8uFGRtAOsGYIbLIl1SqHg744SqXw2iNnTJBdN1ssypXx+
         kHaa/Rz06XqUe2HFAmjua3gDIpATXh3JwnZWnrU6fOggb0xCwU7BAlCspWe6G1IviCHF
         /kag==
X-Gm-Message-State: AOAM533I1LWhnTr/uetqcKEgWDCtwzGhqk4bLVWYUJrYcgRDzvbUS0Pb
        TARmHwRFMGin6up8ovdrtvM=
X-Google-Smtp-Source: ABdhPJykyG4asxyffWyKxljFdyjAyR9I1fXuAeS8wS1A/odEXdj7M78gsOEIXxbIcjmyVb3VUgKwUg==
X-Received: by 2002:a5d:69cf:: with SMTP id s15mr29403010wrw.10.1593858349937;
        Sat, 04 Jul 2020 03:25:49 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id g14sm16421428wrm.93.2020.07.04.03.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 03:25:49 -0700 (PDT)
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
Subject: [PATCH v2 07/14] drm/panfrost: rename error labels in device_init
Date:   Sat,  4 Jul 2020 12:25:28 +0200
Message-Id: <20200704102535.189647-8-peron.clem@gmail.com>
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

Rename goto labels in device_init it will be easier to maintain.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 30 +++++++++++-----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 8136babd3ba9..cc16d102b275 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -215,57 +215,57 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	err = panfrost_regulator_init(pfdev);
 	if (err) {
 		dev_err(pfdev->dev, "regulator init failed %d\n", err);
-		goto err_out0;
+		goto out_clk;
 	}
 
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

