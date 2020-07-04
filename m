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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BCBC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB25920870
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u895Asqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgGDKZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 06:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgGDKZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 06:25:53 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A407C08C5DF
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 03:25:53 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so34247099wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 03:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dEvAV3WC8gjOi8/db5UgonIFrnz7oP9M+fD1t4PD98A=;
        b=u895AsqnI++nW+ATsCD6BM53ooaKE7DfxiT5p2rrbYNdSijhTa2fQojXDTEIR7jYPF
         eDuyVN7haX4f7btL7FsYhYPvf+qtegwUjvvWWxU2a+3rlGHRajWGZnXWwldaiRQqcO/B
         6cwLMKgC4aChrc/tG8Z2LdbCLvM1pN4OOfieirBaNfQULsq97lAy3uSGUYI0zExf/EMg
         /wEbPOoKEenrXogE201dj1V7BdCaolqxGGhSyJ1iuPRWAyWxco+8y7t9Zu17E/orMXei
         NVGn3grc7xb4aECQK6M7VAlQ2ylCejDxl//pNzxVP/BRXfjaXSD9afGlg/5+0dsGcO4q
         PdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dEvAV3WC8gjOi8/db5UgonIFrnz7oP9M+fD1t4PD98A=;
        b=s9314iE/acGH1/hcprisnswBNFjnzJcwhTzg9oURCCWSwUjWDjcGPvD+L7bMjtLg/J
         0McUXTfX+Bc1HkGZMwoUttVQ+gJVipe7uLZnELqmrkcsGe7zU0kXCAH2P4Y02vSNywmy
         +D3+cdjbUqYzp+hHBN8y3gJgdjHwKfo+YXxHZ3nlNTvzGZtXL5L3ZyProxh3g4M/RIc5
         b5JyT+Wd9/gWFEQ3CnslM0krtXPsgtjbwX+UJK+UVOCq+8qvHGubDFp9cHk9Um8sr95S
         am2Wf5y76TwO7wngRfuOLluD1+9ugWbhbnuStsbsG8QiEdSzaKRfwiLFUyDdKF0gXPge
         g1Uw==
X-Gm-Message-State: AOAM532UHpU6xDBNNmYLtM2EL72yaS2wFGUtPoB/O8ADtNRV5oONA7nq
        RDNhNpImeYR+W3OdUfx/DvA=
X-Google-Smtp-Source: ABdhPJxPyjX8E1s13IMa5BpsRPWoAPS1pYxySTMxZT0pEmMWQ3CcE7UVh59cuHmumr5QkfbuhHRayw==
X-Received: by 2002:a1c:18e:: with SMTP id 136mr10189686wmb.93.1593858352040;
        Sat, 04 Jul 2020 03:25:52 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id g14sm16421428wrm.93.2020.07.04.03.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 03:25:51 -0700 (PDT)
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
Subject: [PATCH v2 09/14] drm/panfrost: dynamically alloc regulators
Date:   Sat,  4 Jul 2020 12:25:30 +0200
Message-Id: <20200704102535.189647-10-peron.clem@gmail.com>
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

We will later introduce regulators managed by OPP.

Only alloc regulators when it's needed. This also help use
to release the regulators only when they are allocated.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 14 +++++++++-----
 drivers/gpu/drm/panfrost/panfrost_device.h |  3 +--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 464da1646398..0b0fb45aee82 100644
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
@@ -117,8 +119,10 @@ static int panfrost_regulator_init(struct panfrost_device *pfdev)
 
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

