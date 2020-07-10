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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A43C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0612720725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7nzpXtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgGJJ0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgGJJ0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:26:04 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBF3C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:26:04 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j4so5185652wrp.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3tTFXJtD9L8qTfEaoTtaeOWc2S10eVfC890weGUL+Pw=;
        b=Y7nzpXtXRxpJSxpeg/gn+LqJ0P6LF/bosc2WNKPfU3gLUmsGRJVaWZQhfvoZD0mjMS
         hkl39E7C3ixbMm2QOeXr0XrXBTDlruqHWC0DOomlsLGr6nzXxS3Z4DzZaASsqiGCKrVS
         zeimHdeUd4H1tAalgo7zb4+qkmnfxusA6A45+qqJ+o3aZYCy/4SvBhFR1B/VcSuVkUEF
         tONA4HyMnJtRzbl6UEitufQD9cGzY8vukonjUxm68XAjR5UkusXC2u4lfbSA3TPo71hE
         9axMNPJ1yxWiWjr0RO/hkKuGHjhJLuD6xpGjYaYZ1mBySTCjvSJkFjz4TCPDr4XzA6U6
         r9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tTFXJtD9L8qTfEaoTtaeOWc2S10eVfC890weGUL+Pw=;
        b=ujpSprX5PLFxt8YVaSqlhdpoanPxwnhPh00vcKVh7uOvKvug8/Dg1xncE11un5+uP2
         m8dguKKDrbA7IlnHrhqoM2TVXLuMZkE7k51XSy8idaihb1dneBTPYV/47nrid2zZXtxd
         uuSGSxp+a80jwWwq0/Yb1fkU2+xllTsObUFT26W/0QZXgmQzp3zdGFadehA3V9csJFbO
         3rXB2rkx2M+xOdghsM6pSkxSt/glyT8P+Q1YR/1bC4J38fby4XicfYHzYLxWkkHlJiXT
         u7yImpKfOPUbfeIjKPFeZRWQS7Bytdk1Fpa91aLH8bB2CL0eT2ctclVIVp2cERAC+UE3
         YPDQ==
X-Gm-Message-State: AOAM531+lyHtmIxDuZIvoT4+9vrM3GUYwhGdB6svSvd8kq/TLIky+73+
        puorq331++dcfWgg5ZlV4WM=
X-Google-Smtp-Source: ABdhPJziUwRUwIxiSgoQpaz2tu8FXmSti7msKAPtnrROxJBkyVOphRSwnAKWACzVX/5Aa0cjpuEpcw==
X-Received: by 2002:adf:ef89:: with SMTP id d9mr71367031wro.124.1594373163341;
        Fri, 10 Jul 2020 02:26:03 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id h23sm8179559wmb.3.2020.07.10.02.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:26:02 -0700 (PDT)
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
Subject: [PATCH v4 09/14] drm/panfrost: dynamically alloc regulators
Date:   Fri, 10 Jul 2020 11:25:43 +0200
Message-Id: <20200710092548.316054-10-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710092548.316054-1-peron.clem@gmail.com>
References: <20200710092548.316054-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will later introduce regulators managed by OPP.

Only alloc regulators when it's needed. This also help use
to release the regulators only when they are allocated.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 14 +++++++++-----
 drivers/gpu/drm/panfrost/panfrost_device.h |  3 +--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 36b5c8fea3eb..f1474b961def 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -90,9 +90,11 @@ static int panfrost_regulator_init(struct panfrost_device *pfdev)
 {
 	int ret, i;
 
-	if (WARN(pfdev->comp->num_supplies > ARRAY_SIZE(pfdev->regulators),
-			"Too many supplies in compatible structure.\n"))
-		return -EINVAL;
+	pfdev->regulators = devm_kcalloc(pfdev->dev, pfdev->comp->num_supplies,
+					 sizeof(*pfdev->regulators),
+					 GFP_KERNEL);
+	if (!pfdev->regulators)
+		return -ENOMEM;
 
 	for (i = 0; i < pfdev->comp->num_supplies; i++)
 		pfdev->regulators[i].supply = pfdev->comp->supply_names[i];
@@ -119,8 +121,10 @@ static int panfrost_regulator_init(struct panfrost_device *pfdev)
 
 static void panfrost_regulator_fini(struct panfrost_device *pfdev)
 {
-	regulator_bulk_disable(pfdev->comp->num_supplies,
-			pfdev->regulators);
+	if (!pfdev->regulators)
+		return;
+
+	regulator_bulk_disable(pfdev->comp->num_supplies, pfdev->regulators);
 }
 
 static void panfrost_pm_domain_fini(struct panfrost_device *pfdev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 2efa59c9d1c5..953f7536a773 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -22,7 +22,6 @@ struct panfrost_job;
 struct panfrost_perfcnt;
 
 #define NUM_JOB_SLOTS 3
-#define MAX_REGULATORS 2
 #define MAX_PM_DOMAINS 3
 
 struct panfrost_features {
@@ -81,7 +80,7 @@ struct panfrost_device {
 	void __iomem *iomem;
 	struct clk *clock;
 	struct clk *bus_clock;
-	struct regulator_bulk_data regulators[MAX_REGULATORS];
+	struct regulator_bulk_data *regulators;
 	struct reset_control *rstc;
 	/* pm_domains for devices with more than one. */
 	struct device *pm_domain_devs[MAX_PM_DOMAINS];
-- 
2.25.1

