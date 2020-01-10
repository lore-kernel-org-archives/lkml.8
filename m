Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDADC33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256B120673
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4+WPm+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbgAJGK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 01:10:28 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38889 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgAJGK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 01:10:27 -0500
Received: by mail-pl1-f193.google.com with SMTP id f20so440004plj.5;
        Thu, 09 Jan 2020 22:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vO/kpK4i91+xXYCwM2I/fZr8n6mbhWaXJUGJvuJZc+Y=;
        b=K4+WPm+N54ayTapLJlkAX3kyW4PV0+b3YZu38v1rPtmzn1YsbEoxRsslsmO7L3M4BC
         Qzw7DNjA6VsVLmiDHrfGv/6kV+jf0A0xJGw4kR/wL9nRng1r4s1O+3CJBjZ9TX5EeKD3
         hh87FFRlSJ4MkdQjeQNHOLA17BoTMmiuTiWhvP1BsrQyFjP0QWeXuijYNJavqtPXrC1r
         M+3habkmyw1jzs0fmSUwbvIHsBLesv9ZA9kE8Yyq84HB5ctRI3IimL+7LYNPsgKLRIKU
         jNTDnBo2yQun2ASdIQ9sE8DBygLt7rjFLr10UouG7LF5CVzQu1KTX7W1+jD1eadh4Sg7
         b+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vO/kpK4i91+xXYCwM2I/fZr8n6mbhWaXJUGJvuJZc+Y=;
        b=UZ6YSECYmGVpXTt29CUG0XuhF5urcQOwKHYdJqUu1Q3nR+uq7pSes1S+G3vJAkM10N
         aMuCAcAY0K2pxpgBScnl6xKQsG/CH9b/qoK2DnSQvBKwMhga7gfMKGM5xef8BjPm8Mgo
         pLYY6MESm/tVLhFkkP7x78yE4BemkqUoE5zmj/N6uYjQ5eYT/su/zsUbY+gcXTg/nFDH
         KO3tTe9BU/f+sdvdwjhAIKU0JzjRSuTN/SH+3HN//6+hhGobRFTMxXO4Lchpx1heeLv9
         eRzJn/4dT5Aj5FFIsslE4nZTi0jbnf2sLLsotpHkM6APuxuV1qQDRZPjPD3onyDcl4oD
         Alyg==
X-Gm-Message-State: APjAAAUN77xr45hEIwkIVusC9cFReEyQzu42AYElNTJ7n8jY322nT/Ns
        00izQXr66lN/S1jGiTrecoo=
X-Google-Smtp-Source: APXvYqyBaVlYYnWnRxQ3NX+eL8JhejZIRTtyRzE+bBk8wypmC9d8v7yfQIcdhpxrhfyOiF8KrH/biQ==
X-Received: by 2002:a17:90a:c583:: with SMTP id l3mr2691650pjt.58.1578636626126;
        Thu, 09 Jan 2020 22:10:26 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y76sm1195814pfc.87.2020.01.09.22.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 22:10:25 -0800 (PST)
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
Subject: [PATCH v3 6/7] clk: sprd: support to get regmap from parent node
Date:   Fri, 10 Jan 2020 14:09:17 +0800
Message-Id: <20200110060918.18416-7-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110060918.18416-1-zhang.lyra@gmail.com>
References: <20200110060918.18416-1-zhang.lyra@gmail.com>
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

