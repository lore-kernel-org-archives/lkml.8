Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0236DC34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07852465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6OeUE5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgBSEKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 23:10:32 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42630 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgBSEKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 23:10:31 -0500
Received: by mail-pg1-f194.google.com with SMTP id w21so12027511pgl.9;
        Tue, 18 Feb 2020 20:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vO/kpK4i91+xXYCwM2I/fZr8n6mbhWaXJUGJvuJZc+Y=;
        b=u6OeUE5bMKGM0Cgbc1aKI9NNzER1/Kf3qHl9txwdGL6aMXoaq4VhbYnqhEi9AEY1Wx
         lxUb9Yf1HrmZCkPApzQH/4Z3o2nNQ7o3Gvw8xipyexdP3y75gzAUmtWZ175ZDx9/axyA
         JtYOwUqVP1zWVV976MOIHHa/nkCO6ZM/LZLkwF30kvEi6s2Flz58BUoOR0c9hkkWSmli
         WxlapHbpovki/IAU5o/Zd/BiBEEcz1NrcpNTb+mw5MUqr57TaqAIWC1Kma/3GYamv06z
         X01JlCqbyxV5WDwBxAAf6R2MDEmH2U5nW72t4U/Tb5rjra/uNt2dW6+c9zOVA8ZvAMUJ
         lnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vO/kpK4i91+xXYCwM2I/fZr8n6mbhWaXJUGJvuJZc+Y=;
        b=FhtLtRVxUS4WN+8CYPsUj02tCiJdWK7FBvTY8YLkjL93Kh9MglSVTOBTA2WlHi8txX
         5abEypD8ubM9FBLsc8GDpq111sBhOmC9X6rc7owvG3bUGwh5VAf72S9YObd3ya34vQSV
         X7Nk4oU0p3TD1ErLli7TOOfI5sFiB6c8XI1OpQ7wl7cug92H6pXH++ztTiqP0PE2pxB0
         8Xkc/JhTnGTiLNwTh9q1qCbQaBKAbYj7TI2riuGtNA9wgd0sbeAV/fgbL5SO7yypYu4f
         JPctQqL6u0hyYRy02w56QApN+PUBREHTSgAzpEOgCYsxAxUjCxRDF9FlQNGQtCOpFUV6
         wWJw==
X-Gm-Message-State: APjAAAU5MyfQBKio2FYCONLn8kSBAKejbF8xxq9BTnpgIvaeD+8j5AGU
        l3eb7JAcqjHE33ZJiax2x75ok1KvA+0=
X-Google-Smtp-Source: APXvYqyeh2y+W8m3l8l0OfrgK3T0gmJz+Gd5+Cfno+AoLkwUkvAzhCAR7oOOqEPrFiE0ESPeaTJcqA==
X-Received: by 2002:a63:5809:: with SMTP id m9mr25401006pgb.26.1582085429199;
        Tue, 18 Feb 2020 20:10:29 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id q66sm578748pfq.27.2020.02.18.20.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 20:10:28 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v5 6/7] clk: sprd: support to get regmap from parent node
Date:   Wed, 19 Feb 2020 12:09:14 +0800
Message-Id: <20200219040915.2153-7-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200219040915.2153-1-zhang.lyra@gmail.com>
References: <20200219040915.2153-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Some SC9863a clock nodes would be the child of a syscon node, clocks can
use the regmap of syscon device directly for this kind of cases.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/clk/sprd/common.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
index c0af4779892b..d620bbbcdfc8 100644
--- a/drivers/clk/sprd/common.c
+++ b/drivers/clk/sprd/common.c
@@ -40,7 +40,8 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
 			 const struct sprd_clk_desc *desc)
 {
 	void __iomem *base;
-	struct device_node *node = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
 	struct regmap *regmap;
 
 	if (of_find_property(node, "sprd,syscon", NULL)) {
@@ -49,6 +50,13 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
 			pr_err("%s: failed to get syscon regmap\n", __func__);
 			return PTR_ERR(regmap);
 		}
+	} else if (of_device_is_compatible(of_get_parent(dev->of_node),
+			   "syscon")) {
+		regmap = device_node_to_regmap(of_get_parent(dev->of_node));
+		if (IS_ERR(regmap)) {
+			dev_err(dev, "failed to get regmap from its parent.\n");
+			return PTR_ERR(regmap);
+		}
 	} else {
 		base = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(base))
-- 
2.20.1

