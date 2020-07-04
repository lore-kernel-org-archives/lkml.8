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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5EFC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E98F620870
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhrFjlEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgGDK0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 06:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgGDKZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 06:25:54 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E9CC08C5E0
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 03:25:54 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j4so32885056wrp.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 03:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ekmXxgc2CJLhUtRJfX6RJbgFcgiu4O269w7FRXLrjM=;
        b=XhrFjlEY5PPJ5atPvo98rUZh1ZQWnHm5Ls6NPL6ZTnGWOAxgiXwXfUtKj4vFQXEkZ1
         sYO5UqWCjprLeI5XG5bD0nfsyMeBD8uZLIaFiE7N5XASwC6BW0zIXcnBBZ0v+wDNdt7P
         SIGro8XEPu8P2ii8FVA2HtRZ48opMJz8RZjXPrvdz4ceT5zPYOFuN7jHfBguQ8sOgFaC
         qDcKZJcoS+C/p/epqdy4cSkgQsD7dBnRa1JBYiYsmZQO1sfzS5Hyl45VzImUOvNxnX7l
         s0ysH9XHR4q+oEBTNOacdVKS54TI587vSIHnjltfSLJv7wd6ILU0ZdX+iqSBe1ck5uM2
         eg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ekmXxgc2CJLhUtRJfX6RJbgFcgiu4O269w7FRXLrjM=;
        b=iGyWMauUaCBFplZ1xswbACrD080qlp4wBWganVz0c6BGN3StuGv0uQ2weKzFJmXh01
         BOlUzmy1HYvc7S9qrjl1w9Oj31YVDUnG1F6bqb4qzR9hbSIcAPf1rX+ljhNycLb+dQP0
         w98A6+dUYFRGn/vnkcRn0N8pLHrK1W3lb6tU54nwXHOV2VpJZfFlU1S3EO5+VYLgSN+f
         N/JRuT2tjLRFodBN/q7Fkg8T5lHHp0giBXLOz43jgnt4upt1BWIypqfVx+9B8XZ7XVk4
         gwZa9pJ8ZpurkyK+fHA0W1tzwihTF940Dy5ejkxQWxbH5zykvsQ3V7ktKYzs5jxn2PPT
         zQHw==
X-Gm-Message-State: AOAM531jnxVoGg4KRln8zbXki6JiNXQUBWwTGgPYTDZyP3gTx9KyYy3b
        4P9jDvmHj9gtR2xMRkJH2fc=
X-Google-Smtp-Source: ABdhPJy38Ca5rvU97m5F4CdQCK7nkRR1FB9ubCnok0fal6lPP07aDjaptGbQHLPIbee5P1rhdOSDWA==
X-Received: by 2002:adf:ee4d:: with SMTP id w13mr11520166wro.245.1593858353105;
        Sat, 04 Jul 2020 03:25:53 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id g14sm16421428wrm.93.2020.07.04.03.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 03:25:52 -0700 (PDT)
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
Subject: [PATCH v2 10/14] drm/panfrost: add regulators to devfreq
Date:   Sat,  4 Jul 2020 12:25:31 +0200
Message-Id: <20200704102535.189647-11-peron.clem@gmail.com>
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

Some OPP tables specify voltage for each frequency. Devfreq can
handle these regulators but they should be get only 1 time to avoid
issue and know who is in charge.

If OPP table is probe don't init regulator.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 19 +++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_devfreq.h |  2 ++
 drivers/gpu/drm/panfrost/panfrost_device.c  | 11 +++++++----
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index d9007f44b772..d1e3e9d00a48 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -93,6 +93,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	unsigned long cur_freq;
 	struct device *dev = &pfdev->pdev->dev;
 	struct devfreq *devfreq;
+	struct opp_table *opp_table;
 	struct thermal_cooling_device *cooling;
 	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
 
@@ -105,6 +106,19 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 
 	spin_lock_init(&pfdevfreq->lock);
 
+	opp_table = dev_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
+					      pfdev->comp->num_supplies);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		/* Continue if the optional regulator is missing */
+		if (ret != -ENODEV) {
+			DRM_DEV_ERROR(dev, "Couldn't set OPP regulators\n");
+			goto err_fini;
+		}
+	} else {
+		pfdevfreq->regulators_opp_table = opp_table;
+	}
+
 	panfrost_devfreq_reset(pfdevfreq);
 
 	cur_freq = clk_get_rate(pfdev->clock);
@@ -153,6 +167,11 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
 		dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
 		pfdevfreq->opp_of_table_added = false;
 	}
+
+	if (pfdevfreq->regulators_opp_table) {
+		dev_pm_opp_put_regulators(pfdevfreq->regulators_opp_table);
+		pfdevfreq->regulators_opp_table = NULL;
+	}
 }
 
 void panfrost_devfreq_resume(struct panfrost_device *pfdev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
index 210269944687..db6ea48e21f9 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
@@ -8,12 +8,14 @@
 #include <linux/ktime.h>
 
 struct devfreq;
+struct opp_table;
 struct thermal_cooling_device;
 
 struct panfrost_device;
 
 struct panfrost_devfreq {
 	struct devfreq *devfreq;
+	struct opp_table *regulators_opp_table;
 	struct thermal_cooling_device *cooling;
 	bool opp_of_table_added;
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 0b0fb45aee82..1b5fc9221828 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -223,10 +223,13 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 		goto out_clk;
 	}
 
-	err = panfrost_regulator_init(pfdev);
-	if (err) {
-		dev_err(pfdev->dev, "regulator init failed %d\n", err);
-		goto out_devfreq;
+	/* OPP will handle regulators */
+	if (!pfdev->pfdevfreq.opp_of_table_added) {
+		err = panfrost_regulator_init(pfdev);
+		if (err) {
+			dev_err(pfdev->dev, "regulator init failed %d\n", err);
+			goto out_devfreq;
+		}
 	}
 
 	err = panfrost_reset_init(pfdev);
-- 
2.25.1

