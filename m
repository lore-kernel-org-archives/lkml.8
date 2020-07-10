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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F69CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC1920767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScK5azBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgGJJya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgGJJyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:54:24 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20C6C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:24 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f139so5266293wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3tTFXJtD9L8qTfEaoTtaeOWc2S10eVfC890weGUL+Pw=;
        b=ScK5azBryMJ/fZmLR11Ditdr3WuUpS8LnBIs1+loUpjd5Fp9a/AflpCcoDzqAdhyLc
         jDSb2ZZDzxg6ujyKzlXJg+Nun8NHC1IJX5+Fox8khn49MLqzxluyMPQjQCbeMkVCqylv
         fMyYrGXofvNowV1XY8bmh94B68mIme3dV1dADOTc2V0blDNehTetaLlhtVg/Lz48YAPl
         sDyOtlJ5Xr0Ti4ZMmt47dOISytUbGVjnn2XXS8xvsEA7mMJPnEI8i9WPbt5yRYBnBW4J
         Gz9wAkNndLUUvci/aTJ9FSsaTtoMfbz34pVpDrnahoz+dAT+YDNrYpCZ02rXQ5ty/qXj
         l69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tTFXJtD9L8qTfEaoTtaeOWc2S10eVfC890weGUL+Pw=;
        b=rR24mKTxK5h6dKKrevIKNGRmbNc9cZlvZ6KEH+xYBnzAKLohQCJsgWEAAxtI1Q1NVN
         g7MJ9zEBv3ARyvWv2vpnhJYUprFpSza5gvHVyf3DICUuUO6bAP5q6eAutZyG7iqpmtah
         we8JEuiA02QyJe8u/ijTkKirYgzGk1f9At4MkMldGr1aX7Lj1c9HbG4j0sq0MBB52qK7
         OnSQXqRQ/TI024/DCnkRV7q2SLe6p3csfhcq4vIzBTcxIx8PMwhPBqPbAUgyzbB380Gs
         UGYVEN28KRNrBSzvnnrQ3lAIBVHL+99DlgPqhlj5y4lSNqZV/p5Y1rYrBe9tyjEhTjIM
         EykA==
X-Gm-Message-State: AOAM530L1jXlHp5yCFgv9Qpwl7VFx/UfRPzVquyfiTdElfBB+SnG1l5K
        q1fcZY5m0cAaCZAAKVl5Ucc=
X-Google-Smtp-Source: ABdhPJykRhDx9PTf1S9u8YjJU2g+0xvNNgPIYzZDNU1sWHxXWU0rZO3DfzeKhjOLlLhCNzywJJe2tQ==
X-Received: by 2002:a1c:4804:: with SMTP id v4mr4347015wma.139.1594374863260;
        Fri, 10 Jul 2020 02:54:23 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id u23sm10176092wru.94.2020.07.10.02.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:54:22 -0700 (PDT)
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
Subject: [PATCH v5 09/14] drm/panfrost: dynamically alloc regulators
Date:   Fri, 10 Jul 2020 11:54:04 +0200
Message-Id: <20200710095409.407087-10-peron.clem@gmail.com>
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

