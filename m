Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D5AC33CA7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 00:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28CF20848
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 00:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TvvrlqVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbgALAQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 19:16:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51128 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731715AbgALAQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 19:16:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so5858508wmb.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 16:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=No9N9xYZ+QFAr1x7bc0MPpLHxIMMTgoTSD9/8JFQuIk=;
        b=TvvrlqVKcqkTNLBPSRxaQEpBBhYhQHqg4aoxLtvU4MZaezCkUEbu521TaNR5r0lvEY
         Iwqi+i86WFN2n54aIFXI4MuOFinV6B1wvqZSmNByTKWPizjer/JFcSvcsAsNZdKtPIH4
         gZjTzfqfskCoUy8ldaBYOBNAsP8x9jgh0JP5b3/zwyaMWLYwYixOTiHL7fWzdMAGB1BZ
         ibJ+te6jZOkVTPyQ56ENUWCG9kOArwNe1uvo4uEPXLotkSM8oa6OlVwgmJqb8CV4SUcl
         MTlhOhabjdaZVugYhyxZ4xGim/0h3DhfmyU4182w2D57kKogaApZMgrVB9upj8I644C6
         hMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=No9N9xYZ+QFAr1x7bc0MPpLHxIMMTgoTSD9/8JFQuIk=;
        b=BoLFGs9GjkxFCYV5Z9bLosy0iWF/cyXbs7IQyYv9yEWbX5Zo5DXnYNn+eizYdsvp8P
         VCRhPQdVG5gzJh7JqPr+K35CP7mwBzSIvu+EY4RbIce0LypXnp1ZYd0hmlJc8P6mf8zO
         KU3JSp3HM8WdeM1ZPutf+8tBN8bo9QtnViILXmLXZCbBbT+DqSmsjuuw63lI3crly7ic
         1zFXBcv8om5cah4wNZBzlnm/wVyZiRGqO27NnjZXK6y+Dfp2ADJ3pZOjuLhAWDHP1iTh
         ag/B3fS0SaLNtBZgFZ3cqbvRk+dTLFFbacBze2WqkJ00cJtO8QYFIjAtXWncwrN5cak5
         YGYA==
X-Gm-Message-State: APjAAAW/hTP9T7BzJu1uui7btqumntw4mJFF1XM+/ulKe8vRbhyLWARe
        pNtrTpojohbWNNskPAbR3Zw=
X-Google-Smtp-Source: APXvYqwyHONLbwGv/sAnDgb6Jev2B1rSuuf3t9Uadi5LTfguJPS85uqYijPkZEdCDdPZ/CHTFuMe1Q==
X-Received: by 2002:a1c:dc08:: with SMTP id t8mr12425668wmg.139.1578788207216;
        Sat, 11 Jan 2020 16:16:47 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id h66sm8575535wme.41.2020.01.11.16.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2020 16:16:46 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     dri-devel@lists.freedesktop.org, alyssa@rosenzweig.io,
        steven.price@arm.com, tomeu.vizoso@collabora.com, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        robin.murphy@arm.com, linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, sudeep.holla@arm.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFT v2 3/3] drm/panfrost: Use the mali-supply regulator for control again
Date:   Sun, 12 Jan 2020 01:16:23 +0100
Message-Id: <20200112001623.2121227-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200112001623.2121227-1-martin.blumenstingl@googlemail.com>
References: <20200112001623.2121227-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pm_opp_set_rate() needs a reference to the regulator which should be
updated when updating the GPU frequency. The name of the regulator has
to be passed at initialization-time using dev_pm_opp_set_regulators().
Add the call to dev_pm_opp_set_regulators() so dev_pm_opp_set_rate()
will update the GPU regulator when updating the frequency (just like
we did this manually before when we open-coded dev_pm_opp_set_rate()).

Fixes: 221bc77914cbcc ("drm/panfrost: Use generic code for devfreq")
Reported-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 33 +++++++++++++++++----
 drivers/gpu/drm/panfrost/panfrost_device.h  |  1 +
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 170f6c8c9651..3b580a0123e1 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -74,6 +74,7 @@ static struct devfreq_dev_profile panfrost_devfreq_profile = {
 int panfrost_devfreq_init(struct panfrost_device *pfdev)
 {
 	int ret;
+	struct opp_table *opp_table;
 	struct dev_pm_opp *opp;
 	unsigned long cur_freq;
 	struct device *dev = &pfdev->pdev->dev;
@@ -84,9 +85,22 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 		/* Optional, continue without devfreq */
 		return 0;
 
+	opp_table = dev_pm_opp_set_regulators(dev,
+					      (const char *[]){ "mali" },
+					      1);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+
+		/* Continue if the optional regulator is missing */
+		if (ret != -ENODEV)
+			return ret;
+	} else {
+		pfdev->devfreq.regulators_opp_table = opp_table;
+	}
+
 	ret = dev_pm_opp_of_add_table(dev);
 	if (ret)
-		return ret;
+		goto err_opp_put_regulators;
 
 	panfrost_devfreq_reset(pfdev);
 
@@ -94,8 +108,8 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 
 	opp = devfreq_recommended_opp(dev, &cur_freq, 0);
 	if (IS_ERR(opp)) {
-		dev_pm_opp_of_remove_table(dev);
-		return PTR_ERR(opp);
+		ret = PTR_ERR(opp);
+		goto err_opp_of_remove_table;
 	}
 
 	panfrost_devfreq_profile.initial_freq = cur_freq;
@@ -105,8 +119,8 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 					  DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
 	if (IS_ERR(devfreq)) {
 		DRM_DEV_ERROR(dev, "Couldn't initialize GPU devfreq\n");
-		dev_pm_opp_of_remove_table(dev);
-		return PTR_ERR(devfreq);
+		ret = PTR_ERR(devfreq);
+		goto err_opp_of_remove_table;
 	}
 	pfdev->devfreq.devfreq = devfreq;
 
@@ -117,6 +131,13 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 		pfdev->devfreq.cooling = cooling;
 
 	return 0;
+
+err_opp_of_remove_table:
+	dev_pm_opp_of_remove_table(dev);
+err_opp_put_regulators:
+	if (pfdev->devfreq.regulators_opp_table)
+		dev_pm_opp_put_regulators(pfdev->devfreq.regulators_opp_table);
+	return ret;
 }
 
 void panfrost_devfreq_fini(struct panfrost_device *pfdev)
@@ -124,6 +145,8 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
 	if (pfdev->devfreq.cooling)
 		devfreq_cooling_unregister(pfdev->devfreq.cooling);
 	dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
+	if (pfdev->devfreq.regulators_opp_table)
+		dev_pm_opp_put_regulators(pfdev->devfreq.regulators_opp_table);
 }
 
 void panfrost_devfreq_resume(struct panfrost_device *pfdev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 06713811b92c..4878b239e301 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -85,6 +85,7 @@ struct panfrost_device {
 
 	struct {
 		struct devfreq *devfreq;
+		struct opp_table *regulators_opp_table;
 		struct thermal_cooling_device *cooling;
 		ktime_t busy_time;
 		ktime_t idle_time;
-- 
2.24.1

