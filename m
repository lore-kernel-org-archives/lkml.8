Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A167C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B8620737
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joPKK1pt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732852AbgDMRd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732835AbgDMRds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:33:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5C0C0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:33:48 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z6so10800006wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8aUMUy/wOX/7K0dS1U3BUrwSzoWMPHBW5fhBQA8MxGM=;
        b=joPKK1pt9Q1roRgAEHNzrtbiAO9UqKMcrjasUBKJbXFLK0l7M9MR8SUoEGycMZVJKI
         SUfGpJSvMsvbuer6EW9fqrR+A7GY/I27Yr11B+kbcPgNXAW9E7u/C+d6MTT65VycrIz+
         oO4Iwdj5DoyWNBIWMEfnRE7u5asYx4o9fvK7rPy1wGSrAbctgmG14b14+LHjBBrS1/JM
         Wc1LN3roDxpiS9yIHx0e6eD86QcKwav7/wQS7FNUw3SdDcF1RpSl1EJ/4gE70PgoOdBN
         ah9yH7s35tO+J0JHouUz0/ahj9yZTAP6U39eVALf3/DyDBgyzHgKYyD+MrontQ+fjRCx
         TUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8aUMUy/wOX/7K0dS1U3BUrwSzoWMPHBW5fhBQA8MxGM=;
        b=rpcMrA5tbZn0BJatljgjO6gFVO4/sS+UWH4HmSFzoSWqb4a/6Vi8qm66mkhN0wvMbq
         RyCgE8LQw4TDN70YBwt8n/xvgeQTH+XndhQPREKFWvGopGLzy4Xu5DBtaVu2e2TzFkki
         oFFNVuUEj/5c9kiuid2pZU1lD81nO37V6Awx3Vn17OCg+dcVJh0dMPcCQWShHghrNv4D
         pL1U0OG3A4QdbtInOALXq83KWpBwZetJ4m6nW6Rt51UiGhqBcIC2f2Hs6VEbAkC0uip1
         sPVN/WfBCSMgJXzOovvDH7nJQcsaX6LaS68B+qc9Xs2gZ+jROk8Mn3qj2fUBpl44XBBv
         DTcg==
X-Gm-Message-State: AGi0PuaLzyorh6QjPanAc0h9DDT6icC9PxkxJdojoKrJ3EwVn5hyaReG
        ljSMNrNTKWRJnBGi3gqnScI=
X-Google-Smtp-Source: APiQypLfNEB9bAOtFdIH8RmANnwshXM6x6H3qFZOwYXkmx+YDtINIiwe6Qu3boNCWaiCCL285aMJYA==
X-Received: by 2002:a05:600c:214b:: with SMTP id v11mr20754687wml.151.1586799226743;
        Mon, 13 Apr 2020 10:33:46 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::42f0:c285])
        by smtp.gmail.com with ESMTPSA id v7sm17025219wmg.3.2020.04.13.10.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:33:46 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 2/2] drm/panfrost: add devfreq regulator support
Date:   Mon, 13 Apr 2020 19:33:38 +0200
Message-Id: <20200413173338.8294-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200413173338.8294-1-peron.clem@gmail.com>
References: <20200413173338.8294-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OPP table can defined both frequency and voltage.

Register mali regulators to OPP driver.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 34 ++++++++++++++++++---
 drivers/gpu/drm/panfrost/panfrost_device.h  |  1 +
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 62541f4edd81..54a109bbdc18 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -78,12 +78,26 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	struct device *dev = &pfdev->pdev->dev;
 	struct devfreq *devfreq;
 	struct thermal_cooling_device *cooling;
+	struct opp_table *opp_table;
+
+	/* Regulator is optional */
+	opp_table = dev_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
+					      pfdev->comp->num_supplies);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		if (ret != -ENODEV) {
+			DRM_DEV_ERROR(dev, "Failed to set regulator: %d\n", ret);
+			return ret;
+		}
+	}
+	pfdev->devfreq.opp_table = opp_table;
 
 	ret = dev_pm_opp_of_add_table(dev);
-	if (ret == -ENODEV) /* Optional, continue without devfreq */
-		return 0;
-	else if (ret)
-		return ret;
+	if (ret) {
+		if (ret == -ENODEV) /* Optional, continue without devfreq */
+			ret = 0;
+		goto err_opp_reg;
+	}
 
 	panfrost_devfreq_reset(pfdev);
 
@@ -119,6 +133,12 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 err_opp:
 	dev_pm_opp_of_remove_table(dev);
 
+err_opp_reg:
+	if (pfdev->devfreq.opp_table) {
+		dev_pm_opp_put_regulators(pfdev->devfreq.opp_table);
+		pfdev->devfreq.opp_table = NULL;
+	}
+
 	return ret;
 }
 
@@ -126,7 +146,13 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
 {
 	if (pfdev->devfreq.cooling)
 		devfreq_cooling_unregister(pfdev->devfreq.cooling);
+
 	dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
+
+	if (pfdev->devfreq.opp_table) {
+		dev_pm_opp_put_regulators(pfdev->devfreq.opp_table);
+		pfdev->devfreq.opp_table = NULL;
+	}
 }
 
 void panfrost_devfreq_resume(struct panfrost_device *pfdev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index c30c719a8059..c11d19430c0f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -110,6 +110,7 @@ struct panfrost_device {
 	struct {
 		struct devfreq *devfreq;
 		struct thermal_cooling_device *cooling;
+		struct opp_table *opp_table;
 		ktime_t busy_time;
 		ktime_t idle_time;
 		ktime_t time_last_update;
-- 
2.20.1

