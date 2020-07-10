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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CD1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545D020772
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im6Suh16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgGJJyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgGJJyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:54:21 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3EEC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:21 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so5294046wrv.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eRj3Oh7sZBJWwDgWc3ORgJ0pvlwZ3+3t0oGyKYtF1AQ=;
        b=Im6Suh16bQ2MS5TJOMucwbdu6U9wvq+xgLNrYoFfcoVq7/iXihIQK7xz4OeMTq1yEY
         Y2Jb6qiShiKgEAWVnvQgJD+r9GD3GuEfmdsRN5eyiIFn4rxVwzm7v9B6Aps1QW9j/7pq
         DPBnt/27mcdEV52w9SSO8Q7XP3DHtBGnPZdM7pmSLH8ZDO3JEmmzWgrzP9GDz3ycTC3D
         sI8QB4WRB1gzyHyoEMfUJUUyIcZzatie/O8ak0g4s3Y5wGqilVtTtzMqAsj6Tr3r17x1
         K7CkhhKxRtR3nz0d5i/MYwETl9BYISlXQ5PN7Y3PMi57F/XWFcmChjLkei1G76qZI03Q
         J+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eRj3Oh7sZBJWwDgWc3ORgJ0pvlwZ3+3t0oGyKYtF1AQ=;
        b=nB2+3lCNGAN+qWz4YsFCRLbJaXLmxxbWo/TS+V8HL7GA7T008B5sR3/V8bPGNqRhAN
         ldggERp9IoOt4M75JFb6OQ9LWr3AOZ0WWOITPdFhyH1YGO+wUZOAyvtwwm15CZzJQWWW
         PYgAAZstalFWi3UynEEvdTPDkLWDY0AUIiyPc4lSyFFWgvAuNlhWAl8sGoROdw3iaVeR
         vLcZ/bH1kWxqDJqKxvJrw3J78pasHwii/f/EchpMJ52hFcml/SJ+dTiR9xy510f6/g+Y
         MoRSUCfzHCvcgYH+oJQn5mvsnrweSpIDWO4BO62pwk2Hbakf0xoKomLg8Amd5+Z8Bgew
         4x4Q==
X-Gm-Message-State: AOAM530ddjmV6CaAUAy4MvMOPDHl0NAdJLBf23ioA5Tx8uIJnTAwpQRW
        7PZocaAcPBP/mKT1eXCpc9w=
X-Google-Smtp-Source: ABdhPJyXzvFI7d7NTJ+w+ZGJgkN9gq9YherfY1UqQYjqPDfYCF7nqh1nM4JnluRsCLaSSoXy3/Jd5w==
X-Received: by 2002:a5d:6ac1:: with SMTP id u1mr65723403wrw.123.1594374859817;
        Fri, 10 Jul 2020 02:54:19 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id u23sm10176092wru.94.2020.07.10.02.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:54:19 -0700 (PDT)
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
Subject: [PATCH v5 06/14] drm/panfrost: properly handle error in probe
Date:   Fri, 10 Jul 2020 11:54:01 +0200
Message-Id: <20200710095409.407087-7-peron.clem@gmail.com>
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

Introduce a boolean to know if opp table has been added.

With this, we can call panfrost_devfreq_fini() in case of error
and release what has been initialised.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
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

