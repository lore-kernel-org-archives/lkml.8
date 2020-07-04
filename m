Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FC5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A918320870
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNFNgYAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgGDK01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 06:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgGDKZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 06:25:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325EBC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 03:25:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so32305620wrw.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 03:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UtYpmlK0sBLIGu+jD6jSIfVxQzKUKkc64VLLUVnW2E0=;
        b=qNFNgYAd58cWTopWsCnVpN6KF4hgB35zsvk6rweB2geap+2a/hZHA4uMl6E/nhyVcz
         4ypnl0H+eZ43sMPKGNvmbbssEXLnVdNP87/3ePmLXVN3fjJ7dBtESN0y6eZgz/eW5wmF
         D8m38BQ7KY6+zDcy3BkKBdVqRbWTVtxZd2KIOEpCgimRHWJhRsacbK1tBOENgfk557hF
         BOagm7Vf7N1RO3OOeVg5Ld4aYv490y6kKN94T2AjBJ1Cw/Q0c8EKUkwbKV+50Gyz6zZu
         zVZrjvDEvR66R7ATN6aQmSk1hr3Iw9rizpE1dlrX3vUob8+6+iU7sgzkRYRBYnzOke+h
         NsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UtYpmlK0sBLIGu+jD6jSIfVxQzKUKkc64VLLUVnW2E0=;
        b=mLvp1r+PMJVMUpwMdK1Pal8/oElWUXwVy2QXtmXChR41UArDTjz77t1zhZrrmvByUr
         DEb38guDqE7dVdBYFIm3MjCq/3W9iwm06zeKCY6Q53/u8EJxK59pc7j0ssGdJtU49/lj
         iX9yzoWm0bUqMgD78+qi+eWQZ0xUqi7jigoQnMdL8cSARVWQ4/rdXwrneKJtC4X7egqU
         NvJdmM/hWrSVlrNfn6sTXsv/OiHyPY08PScc4tG8aFmW7d0oaAGsMEPJHOb7hruJRDwn
         fKZjHD+8ZGMLQ1DIp5SHTY+VZZ5n9Fp6WHuGZtBoXFV+uGzFmxfl0i/bk5b5oZ9RLMK9
         20Dw==
X-Gm-Message-State: AOAM5315ol/9DBV96NQLTVChZbet3f2evPfyc0oarEgZ0xXacakYlJOL
        HS8IMzbr2mXo64jizUn2LdQ=
X-Google-Smtp-Source: ABdhPJy/tukX+K79X4Pugp0jciTOgHL2tsymvPVNBkXelV2FU7kvRasFKCl5O0QlvUUsoGSmQgxY2w==
X-Received: by 2002:adf:fe4b:: with SMTP id m11mr39485996wrs.36.1593858348780;
        Sat, 04 Jul 2020 03:25:48 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id g14sm16421428wrm.93.2020.07.04.03.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 03:25:48 -0700 (PDT)
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
Subject: [PATCH v2 06/14] drm/panfrost: properly handle error in probe
Date:   Sat,  4 Jul 2020 12:25:27 +0200
Message-Id: <20200704102535.189647-7-peron.clem@gmail.com>
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

Introduce a boolean to know if opp table has been added.

With this, we can call panfrost_devfreq_fini() in case of error
and release what has been initialised.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 25 ++++++++++++++++-----
 drivers/gpu/drm/panfrost/panfrost_devfreq.h |  1 +
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 78753cfb59fb..d9007f44b772 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -101,6 +101,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 		return 0;
 	else if (ret)
 		return ret;
+	pfdevfreq->opp_of_table_added = true;
 
 	spin_lock_init(&pfdevfreq->lock);
 
@@ -109,8 +110,10 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	cur_freq = clk_get_rate(pfdev->clock);
 
 	opp = devfreq_recommended_opp(dev, &cur_freq, 0);
-	if (IS_ERR(opp))
-		return PTR_ERR(opp);
+	if (IS_ERR(opp)) {
+		ret = PTR_ERR(opp);
+		goto err_fini;
+	}
 
 	panfrost_devfreq_profile.initial_freq = cur_freq;
 	dev_pm_opp_put(opp);
@@ -119,8 +122,8 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 					  DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
 	if (IS_ERR(devfreq)) {
 		DRM_DEV_ERROR(dev, "Couldn't initialize GPU devfreq\n");
-		dev_pm_opp_of_remove_table(dev);
-		return PTR_ERR(devfreq);
+		ret = PTR_ERR(devfreq);
+		goto err_fini;
 	}
 	pfdevfreq->devfreq = devfreq;
 
@@ -131,15 +134,25 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 		pfdevfreq->cooling = cooling;
 
 	return 0;
+
+err_fini:
+	panfrost_devfreq_fini(pfdev);
+	return ret;
 }
 
 void panfrost_devfreq_fini(struct panfrost_device *pfdev)
 {
 	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
 
-	if (pfdevfreq->cooling)
+	if (pfdevfreq->cooling) {
 		devfreq_cooling_unregister(pfdevfreq->cooling);
-	dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
+		pfdevfreq->cooling = NULL;
+	}
+
+	if (pfdevfreq->opp_of_table_added) {
+		dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
+		pfdevfreq->opp_of_table_added = false;
+	}
 }
 
 void panfrost_devfreq_resume(struct panfrost_device *pfdev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
index 3392df1020be..210269944687 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
@@ -15,6 +15,7 @@ struct panfrost_device;
 struct panfrost_devfreq {
 	struct devfreq *devfreq;
 	struct thermal_cooling_device *cooling;
+	bool opp_of_table_added;
 
 	ktime_t busy_time;
 	ktime_t idle_time;
-- 
2.25.1

