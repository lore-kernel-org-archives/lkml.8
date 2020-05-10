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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9ABC54E8A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A955820820
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGe+4boF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgEJQz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 12:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729216AbgEJQzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 12:55:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17828C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:53 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so7949775wra.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J2NZIexCjyou0gnqYIxLphqp5NvK6vqVAKw4e0qfsGY=;
        b=iGe+4boFyoyEwgcr1y1fulRfHhw6r8Ulz+Va19XbTLSKAXEQJY/VLrxeMxnXkekHgB
         pcFdEzlQC5SWySsC5piU84siiG2iBeGEz7zQQCszq4bE6p/+hn42Is2oNoJ5JrOwf1pu
         Xj0eYH2DDv6JABQd00ejfmGxJBCCXkB+3mchmx6J4YnWtWt6cm/d7Lhyi5DH3Yn3foHl
         cpKUvarDGiHQYzCTDFLFkPf4Ab0zVJjpjnjcnoysLFWLjcg8+LgJ+6zxNti88Mh65j0A
         QFCFeR9nL1AWmNiFjGdm6TJJ/pZQi0kdqkDWNbMaiytGy2G2yxo4MIrU/wrS6fbua3po
         B8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J2NZIexCjyou0gnqYIxLphqp5NvK6vqVAKw4e0qfsGY=;
        b=AYjsWlYmU42bntgZHY1X0mLUeIsSo/ZUzsjU7FDWEflp/ErzQbpSOzpYfVOmHmLQgD
         5AcjfNINMZXBgFfu9xPlzfVmaqBHuN5LKfEq1W3CZNr/bSe8rE8hLENpLfUZtoQuUnoS
         dtCdMgRFTtkM22qMLmxRcHnDnVN71AT81oOM6ox1NQWwZKGCylNJaB5bGoDbXBKJY5X5
         MD91vAT/JNPgZMGYYjYlgpeQoZUbazkwqzXOONstWPrP6RV46YqFyUORs3woJxF8+Id0
         BfXHr7/tDY/2k6EWGZilGPaCkoskE9848fSnOlrJAqh7/m0lX5WefzRjb1fy+Lj/qCwI
         guyQ==
X-Gm-Message-State: AGi0PuY9jdl4KyjlSJ6jtYgVGAU23a1/SQBnr8PjlvwphabS1x3TvZeH
        wTRsjdHqzCBSAVLZbWbwa/o=
X-Google-Smtp-Source: APiQypKuHzFrSqsTFi5saBMKe2/BUEXB5RxULRmhIUQ8PWuoFXrEHmx2Phfsf7zofiPwkCYLAdGceA==
X-Received: by 2002:a5d:68cb:: with SMTP id p11mr13857358wrw.349.1589129751769;
        Sun, 10 May 2020 09:55:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:1cc8:b1f1:a2b8:a1ee])
        by smtp.gmail.com with ESMTPSA id g15sm13637670wrp.96.2020.05.10.09.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 09:55:51 -0700 (PDT)
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
Subject: [PATCH 09/15] drm/panfrost: dynamically alloc regulators
Date:   Sun, 10 May 2020 18:55:32 +0200
Message-Id: <20200510165538.19720-10-peron.clem@gmail.com>
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

We will later introduce regulators managed by OPP.

Only alloc regulators when it's needed. This also help use
to release the regulators only when they are allocated.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 14 +++++++++-----
 drivers/gpu/drm/panfrost/panfrost_device.h |  3 +--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index f480127205d6..67eedf64e82d 100644
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
2.20.1

