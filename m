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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746B7C54E4B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44BCD20820
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wwq94eZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgEJQ4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 12:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729220AbgEJQzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 12:55:54 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D01DC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x17so7960469wrt.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UBcArp9z+dOkkmJwdzsA1OSuQPmhGv0QOxoFlPBuJwQ=;
        b=Wwq94eZf1awZPhOOpjkFV8onGcsTP4j6JSoLaP1hv/NsRtIKa3v2QYtSzINIdVMh9F
         9gj5aW/rjEbnu43zvkMt5q0Mi3qX3UYW/KTPlRdVCuAMXoJWervwJp2DQza7Vrl8mGd/
         yGgPBiUtYNpHlRsyfgBLkOBi3yTsXsxDj+rECDUwN1aLqQbY+yiyQsu4FR8tauyMS+O6
         P/AEJuLJSWL8WD+wjnBkYhT1IyqpHwIFnDOReKeuw8XRW2RCLvPp7NF7YZYGniIoBH6q
         KyX4poSnD139MRUGIyGlGwn/AZ3xO+vsghXfTPKnL0tOL/BBksP8ee0sxeW/RNec/rpj
         95bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UBcArp9z+dOkkmJwdzsA1OSuQPmhGv0QOxoFlPBuJwQ=;
        b=i0Od9RXjS8BDvDvqEfXmZV4jB6wtldUPUAWt9IXe/k+AiILKW7xW9IAslb99Zq85zq
         Bzzl6uHfIh1udrP7okSd6jco02h2Ovsgh4qrUP2dtpCot5LE2+CNGrM7sLyxxfNAvERY
         mqo4rLheGHV+xfz+ziE1ui+L2rSxuD8neMcFuPe7wYrPeh/gaYDc/wuge9UvJ0SCHOxZ
         vTvlqYGcrAlkK19a8AzofP1P+Ghi8wD8/xuSLAcMcoVxc6cunnTle3Glb+WxxFon3at+
         YGpVOJkmpI2XF95nx5wtxpdlcS03Q6vH7QmlXAJEfgOtUGVkZ2G9028a94Br0hNYKGBu
         NL6A==
X-Gm-Message-State: AGi0PubSFng6SXqAbSH8vllIut8wWi/gBVuwFGVqtQzj2xTjvsFC9v1a
        rKuvwaSEMfu8uHwiCKF1oek=
X-Google-Smtp-Source: APiQypKYWnQjWfAFe8Sh1wPAmn7ij3fKLm9ouithCNi1zPtZuofz2+9xQFanf+kmHfZ+CzFF3krFgQ==
X-Received: by 2002:a5d:460d:: with SMTP id t13mr14831054wrq.280.1589129752787;
        Sun, 10 May 2020 09:55:52 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:1cc8:b1f1:a2b8:a1ee])
        by smtp.gmail.com with ESMTPSA id g15sm13637670wrp.96.2020.05.10.09.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 09:55:52 -0700 (PDT)
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
Subject: [PATCH 10/15] drm/panfrost: add regulators to devfreq
Date:   Sun, 10 May 2020 18:55:33 +0200
Message-Id: <20200510165538.19720-11-peron.clem@gmail.com>
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

Some OPP tables specify voltage for each frequency. Devfreq can
handle these regulators but they should be get only 1 time to avoid
issue and know who is in charge.

If OPP table is probe don't init regulator.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 19 +++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_devfreq.h |  2 ++
 drivers/gpu/drm/panfrost/panfrost_device.c  | 11 +++++++----
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index fce21c682414..9ffea0d4a087 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -93,6 +93,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	unsigned long cur_freq;
 	struct device *dev = &pfdev->pdev->dev;
 	struct devfreq *devfreq;
+	struct opp_table *opp_table;
 	struct thermal_cooling_device *cooling;
 	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
 
@@ -102,6 +103,19 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 
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
 	ret = dev_pm_opp_of_add_table(dev);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "Couldn't add OPP table\n");
@@ -157,6 +171,11 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
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
index add203cb00c2..347cde4786cf 100644
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
index 67eedf64e82d..8b17fb2e3369 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -222,10 +222,13 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 		goto err_out0;
 	}
 
-	err = panfrost_regulator_init(pfdev);
-	if (err) {
-		dev_err(pfdev->dev, "regulator init failed %d\n", err);
-		goto err_out1;
+	/* OPP will handle regulators */
+	if (!pfdev->pfdevfreq.opp_of_table_added) {
+		err = panfrost_regulator_init(pfdev);
+		if (err) {
+			dev_err(pfdev->dev, "regulator init failed %d\n", err);
+			goto err_out1;
+		}
 	}
 
 	err = panfrost_reset_init(pfdev);
-- 
2.20.1

