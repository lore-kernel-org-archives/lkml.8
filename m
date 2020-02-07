Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE2CC352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 05:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1116F22464
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 05:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="InNuuDfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgBGF1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 00:27:09 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34668 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgBGF1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 00:27:07 -0500
Received: by mail-pj1-f66.google.com with SMTP id f2so993813pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 21:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=unaVPTP92Jg9dNUlDZAd2C3bMBtYzw7JwBrkMbgjB74=;
        b=InNuuDfCwX/lg+zSHxm7t4Cgfsm3usbWlRsfwABwB1cyNtj+3OZZKV9XWXh3YzPClF
         vu1Ypr+JEYyGq8t1TEv4r3d0GPQbqxoX6trko13b8rSj0YLKoF8r2J8bfSjAPTYRq3hk
         8x+/sqpFYGKgm/e785WrSFuCUqZenEotsg0WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=unaVPTP92Jg9dNUlDZAd2C3bMBtYzw7JwBrkMbgjB74=;
        b=K3sA8O8ND2dsCDVFwm4/V1RMjB8F+gxwBZhHIjcEpYT+568Y9HKEfQLrkfio+NhWNf
         ssyNTEif7g0hQ09KM5mYzpWtB3qGbV4rQIksCKHD/V8J13I4qt/7A9VTBL8gJ+rr04KY
         J4nb+vkh49mg6XgpaI5HYTrpsrHqnLRgMIoGZW4gTmA6pKd4X1/AG2jg+AaQ95VU/Wsu
         wl2viPl2hp3biQCYShlg6WiV+iyQfQ63GCqu86pqwTwwFnylkysnYC5wdS0G30xgtZai
         yAe3laqIjT26MAPaV6sDzETRAjSs8kC4onBIPxjuhLySO0Regi9K4xghMbv0sj8VhW6T
         KHVA==
X-Gm-Message-State: APjAAAXhfETOBChcjUMGmo45wFPlMECUU8l41PqfDi5iZ0aoLOOQ2AAe
        9mIVftie3v11axrirdJ5MCqaCTimg6I=
X-Google-Smtp-Source: APXvYqzm2bp8+w6kQCRrvUSsEoU2rSXSPaLfI8uyRPgOQnTGWVqk6eDuB9DdGfxYNQncAYH1Ac6eyQ==
X-Received: by 2002:a17:90a:8547:: with SMTP id a7mr1935864pjw.0.1581053226053;
        Thu, 06 Feb 2020 21:27:06 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id i66sm1174485pfg.85.2020.02.06.21.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 21:27:05 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org,
        ulf.hansson@linaro.org
Subject: [PATCH v4 5/7] drm/panfrost: Add support for multiple power domains
Date:   Fri,  7 Feb 2020 13:26:25 +0800
Message-Id: <20200207052627.130118-6-drinkcat@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200207052627.130118-1-drinkcat@chromium.org>
References: <20200207052627.130118-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is a single power domain per device, the core will
ensure the power domain is switched on (so it is technically
equivalent to having not power domain specified at all).

However, when there are multiple domains, as in MT8183 Bifrost
GPU, we need to handle them in driver code.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

---

The downstream driver we use on chromeos-4.19 currently uses 2
additional devices in device tree to accomodate for this [1], but
I believe this solution is cleaner.

[1] https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/chromeos-4.19/drivers/gpu/arm/midgard/platform/mediatek/mali_kbase_runtime_pm.c#31

v4:
 - Match the exact power domain names as specified in the compatible
   struct, instead of just matching the number of power domains.
   [Review: Ulf Hansson]
 - Dropped print and reordered function [Review: Steven Price]
 - nits: Run through latest version of checkpatch:
   - Use WARN instead of BUG_ON.
   - Drop braces for single expression if block.
v3:
 - Use the compatible matching data to specify the number of power
   domains. Note that setting 0 or 1 in num_pm_domains is equivalent
   as the core will handle these 2 cases in the exact same way
   (automatically, without driver intervention), and there should
   be no adverse consequence in this case (the concern is about
   switching on only some power domains and not others).

 drivers/gpu/drm/panfrost/panfrost_device.c | 97 ++++++++++++++++++++--
 drivers/gpu/drm/panfrost/panfrost_device.h | 11 +++
 drivers/gpu/drm/panfrost/panfrost_drv.c    |  2 +
 3 files changed, 102 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 3720d50f6d9f965..8136babd3ba9935 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -5,6 +5,7 @@
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
 
 #include "panfrost_device.h"
@@ -120,6 +121,79 @@ static void panfrost_regulator_fini(struct panfrost_device *pfdev)
 			pfdev->regulators);
 }
 
+static void panfrost_pm_domain_fini(struct panfrost_device *pfdev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pfdev->pm_domain_devs); i++) {
+		if (!pfdev->pm_domain_devs[i])
+			break;
+
+		if (pfdev->pm_domain_links[i])
+			device_link_del(pfdev->pm_domain_links[i]);
+
+		dev_pm_domain_detach(pfdev->pm_domain_devs[i], true);
+	}
+}
+
+static int panfrost_pm_domain_init(struct panfrost_device *pfdev)
+{
+	int err;
+	int i, num_domains;
+
+	num_domains = of_count_phandle_with_args(pfdev->dev->of_node,
+						 "power-domains",
+						 "#power-domain-cells");
+
+	/*
+	 * Single domain is handled by the core, and, if only a single power
+	 * the power domain is requested, the property is optional.
+	 */
+	if (num_domains < 2 && pfdev->comp->num_pm_domains < 2)
+		return 0;
+
+	if (num_domains != pfdev->comp->num_pm_domains) {
+		dev_err(pfdev->dev,
+			"Incorrect number of power domains: %d provided, %d needed\n",
+			num_domains, pfdev->comp->num_pm_domains);
+		return -EINVAL;
+	}
+
+	if (WARN(num_domains > ARRAY_SIZE(pfdev->pm_domain_devs),
+			"Too many supplies in compatible structure.\n"))
+		return -EINVAL;
+
+	for (i = 0; i < num_domains; i++) {
+		pfdev->pm_domain_devs[i] =
+			dev_pm_domain_attach_by_name(pfdev->dev,
+					pfdev->comp->pm_domain_names[i]);
+		if (IS_ERR_OR_NULL(pfdev->pm_domain_devs[i])) {
+			err = PTR_ERR(pfdev->pm_domain_devs[i]) ? : -ENODATA;
+			pfdev->pm_domain_devs[i] = NULL;
+			dev_err(pfdev->dev,
+				"failed to get pm-domain %s(%d): %d\n",
+				pfdev->comp->pm_domain_names[i], i, err);
+			goto err;
+		}
+
+		pfdev->pm_domain_links[i] = device_link_add(pfdev->dev,
+				pfdev->pm_domain_devs[i], DL_FLAG_PM_RUNTIME |
+				DL_FLAG_STATELESS | DL_FLAG_RPM_ACTIVE);
+		if (!pfdev->pm_domain_links[i]) {
+			dev_err(pfdev->pm_domain_devs[i],
+				"adding device link failed!\n");
+			err = -ENODEV;
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	panfrost_pm_domain_fini(pfdev);
+	return err;
+}
+
 int panfrost_device_init(struct panfrost_device *pfdev)
 {
 	int err;
@@ -150,37 +224,43 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 		goto err_out1;
 	}
 
+	err = panfrost_pm_domain_init(pfdev);
+	if (err)
+		goto err_out2;
+
 	res = platform_get_resource(pfdev->pdev, IORESOURCE_MEM, 0);
 	pfdev->iomem = devm_ioremap_resource(pfdev->dev, res);
 	if (IS_ERR(pfdev->iomem)) {
 		dev_err(pfdev->dev, "failed to ioremap iomem\n");
 		err = PTR_ERR(pfdev->iomem);
-		goto err_out2;
+		goto err_out3;
 	}
 
 	err = panfrost_gpu_init(pfdev);
 	if (err)
-		goto err_out2;
+		goto err_out3;
 
 	err = panfrost_mmu_init(pfdev);
 	if (err)
-		goto err_out3;
+		goto err_out4;
 
 	err = panfrost_job_init(pfdev);
 	if (err)
-		goto err_out4;
+		goto err_out5;
 
 	err = panfrost_perfcnt_init(pfdev);
 	if (err)
-		goto err_out5;
+		goto err_out6;
 
 	return 0;
-err_out5:
+err_out6:
 	panfrost_job_fini(pfdev);
-err_out4:
+err_out5:
 	panfrost_mmu_fini(pfdev);
-err_out3:
+err_out4:
 	panfrost_gpu_fini(pfdev);
+err_out3:
+	panfrost_pm_domain_fini(pfdev);
 err_out2:
 	panfrost_reset_fini(pfdev);
 err_out1:
@@ -196,6 +276,7 @@ void panfrost_device_fini(struct panfrost_device *pfdev)
 	panfrost_job_fini(pfdev);
 	panfrost_mmu_fini(pfdev);
 	panfrost_gpu_fini(pfdev);
+	panfrost_pm_domain_fini(pfdev);
 	panfrost_reset_fini(pfdev);
 	panfrost_regulator_fini(pfdev);
 	panfrost_clk_fini(pfdev);
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index c9468bc5573ac9d..c30c719a805940a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -21,6 +21,7 @@ struct panfrost_perfcnt;
 
 #define NUM_JOB_SLOTS 3
 #define MAX_REGULATORS 2
+#define MAX_PM_DOMAINS 3
 
 struct panfrost_features {
 	u16 id;
@@ -61,6 +62,13 @@ struct panfrost_compatible {
 	/* Supplies count and names. */
 	int num_supplies;
 	const char * const *supply_names;
+	/*
+	 * Number of power domains required, note that values 0 and 1 are
+	 * handled identically, as only values > 1 need special handling.
+	 */
+	int num_pm_domains;
+	/* Only required if num_pm_domains > 1. */
+	const char * const *pm_domain_names;
 };
 
 struct panfrost_device {
@@ -73,6 +81,9 @@ struct panfrost_device {
 	struct clk *bus_clock;
 	struct regulator_bulk_data regulators[MAX_REGULATORS];
 	struct reset_control *rstc;
+	/* pm_domains for devices with more than one. */
+	struct device *pm_domain_devs[MAX_PM_DOMAINS];
+	struct device_link *pm_domain_links[MAX_PM_DOMAINS];
 
 	struct panfrost_features features;
 	const struct panfrost_compatible *comp;
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 4d08507526239f2..a6e162236d67fdf 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -663,6 +663,8 @@ const char * const default_supplies[] = { "mali" };
 static const struct panfrost_compatible default_data = {
 	.num_supplies = ARRAY_SIZE(default_supplies),
 	.supply_names = default_supplies,
+	.num_pm_domains = 1, /* optional */
+	.pm_domain_names = NULL,
 };
 
 static const struct of_device_id dt_match[] = {
-- 
2.25.0.341.g760bfbb309-goog

