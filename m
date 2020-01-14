Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24973C33CAE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E442187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nyrwVyLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgANHQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 02:16:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41192 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbgANHQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:16:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id w62so6139177pfw.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 23:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kL7MaPtbEc21MOhREjvhOgoDbupsHbrcTaafCHl6zWw=;
        b=nyrwVyLcYnNR5mbm92LNGb5QtmCx+5pUoIH0aD8TvRWaA/To6hN3kVrNsRDENiENh9
         y1BPUp40uFVRbuMzqrcmBYs+eWomH0z/SV1EzZnxa4zl0EM3jf+TUHwBnkr03hwwPk4+
         rmBcnoqFF80mCeo3ILegZQxvfm8H/5T97yIao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kL7MaPtbEc21MOhREjvhOgoDbupsHbrcTaafCHl6zWw=;
        b=b7a/+yNZ+A+KkfhH73hQLDEfjkrLWOoRcOtqyMjFnchDBHaoI6ILvSpxQnu/Eees6a
         qnSAGEnS6zc+vr9jfF2N0kn89rUVIAx/Vub47bswKio+cTIPhhlimJQz3J262nzh8fY7
         KWgCRtZ94MnZVcifinqOTt/JfUmhLKwsth8fnf5tMahe6kyX0AvScj9iLIOyXgLdJcc0
         moiw4AnCNz2EKIXNtp60NK2i/OF8PeAoAV6g4y6pKlZe4WcJNBaoQJ4foG6sRn6TbFr6
         CaLOP1lwGyNP7aHz4MCazCApl9TNcFrDF4ANQiPd9guD7Og5YaBXLpvM1QKvfyVl/vT6
         XqCA==
X-Gm-Message-State: APjAAAWsJa7d9UmqigJ0Y0oepCKofx+B6xLc7B5gflBcooqilP60VNn1
        TuFy5n3C/VRHTYIG5l/VaBF+lg==
X-Google-Smtp-Source: APXvYqz1Db5nZXfVgPpUvk0sMU7jCh8DwGo6ABq63Sc0zluJCZpvIMzGYhdDt6IlBlStywedDMXynA==
X-Received: by 2002:a63:d62:: with SMTP id 34mr26391053pgn.268.1578986183441;
        Mon, 13 Jan 2020 23:16:23 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id b4sm17092976pfd.18.2020.01.13.23.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 23:16:22 -0800 (PST)
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
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org
Subject: [PATCH v3 5/7] drm/panfrost: Add support for multiple power domains
Date:   Tue, 14 Jan 2020 15:16:00 +0800
Message-Id: <20200114071602.47627-6-drinkcat@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200114071602.47627-1-drinkcat@chromium.org>
References: <20200114071602.47627-1-drinkcat@chromium.org>
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

v3:
 - Use the compatible matching data to specify the number of power
   domains. Note that setting 0 or 1 in num_pm_domains is equivalent
   as the core will handle these 2 cases in the exact same way
   (automatically, without driver intervention), and there should
   be no adverse consequence in this case (the concern is about
   switching on only some power domains and not others).

 drivers/gpu/drm/panfrost/panfrost_device.c | 95 ++++++++++++++++++++--
 drivers/gpu/drm/panfrost/panfrost_device.h |  9 ++
 drivers/gpu/drm/panfrost/panfrost_drv.c    |  1 +
 3 files changed, 97 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index c30e0a3772a4f57..7c9766f76cc7689 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -5,6 +5,7 @@
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
 
 #include "panfrost_device.h"
@@ -119,6 +120,75 @@ static void panfrost_regulator_fini(struct panfrost_device *pfdev)
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
+	BUG_ON(num_domains > ARRAY_SIZE(pfdev->pm_domain_devs));
+
+	for (i = 0; i < num_domains; i++) {
+		pfdev->pm_domain_devs[i] =
+			dev_pm_domain_attach_by_id(pfdev->dev, i);
+		if (IS_ERR(pfdev->pm_domain_devs[i])) {
+			err = PTR_ERR(pfdev->pm_domain_devs[i]);
+			pfdev->pm_domain_devs[i] = NULL;
+			dev_err(pfdev->dev,
+				"failed to get pm-domain %d: %d\n", i, err);
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
@@ -149,37 +219,45 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 		goto err_out1;
 	}
 
+	err = panfrost_pm_domain_init(pfdev);
+	if (err) {
+		dev_err(pfdev->dev, "pm_domain init failed %d\n", err);
+		goto err_out2;
+	}
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
@@ -196,6 +274,7 @@ void panfrost_device_fini(struct panfrost_device *pfdev)
 	panfrost_mmu_fini(pfdev);
 	panfrost_gpu_fini(pfdev);
 	panfrost_reset_fini(pfdev);
+	panfrost_pm_domain_fini(pfdev);
 	panfrost_regulator_fini(pfdev);
 	panfrost_clk_fini(pfdev);
 }
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 021f063ffb3747f..143eab57180a2e1 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -21,6 +21,7 @@ struct panfrost_perfcnt;
 
 #define NUM_JOB_SLOTS 3
 #define MAX_REGULATORS 2
+#define MAX_PM_DOMAINS 3
 
 struct panfrost_features {
 	u16 id;
@@ -61,6 +62,11 @@ struct panfrost_compatible {
 	/* Supplies count and names. */
 	int num_supplies;
 	const char * const *supply_names;
+	/*
+	 * Number of power domains required, note that values 0 and 1 are
+	 * handled identically, as only values > 1 need special handling.
+	 */
+	int num_pm_domains;
 };
 
 struct panfrost_device {
@@ -73,6 +79,9 @@ struct panfrost_device {
 	struct clk *bus_clock;
 	struct regulator_bulk_data regulators[MAX_REGULATORS];
 	struct reset_control *rstc;
+	/* pm_domains for devices with more than one. */
+	struct device *pm_domain_devs[MAX_PM_DOMAINS];
+	struct device_link *pm_domain_links[MAX_PM_DOMAINS];
 
 	struct panfrost_features features;
 	const struct panfrost_compatible* comp;
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index db3563b80150c9d..42b87e29e605149 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -589,6 +589,7 @@ const char * const default_supplies[] = { "mali" };
 static const struct panfrost_compatible default_data = {
 	.num_supplies = ARRAY_SIZE(default_supplies),
 	.supply_names = default_supplies,
+	.num_pm_domains = 1, /* optional */
 };
 
 static const struct of_device_id dt_match[] = {
-- 
2.25.0.rc1.283.g88dfdc4193-goog

