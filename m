Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3D6C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CF82072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWFy7PQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgBQDYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:24:06 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54052 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgBQDYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:24:04 -0500
Received: by mail-pj1-f68.google.com with SMTP id n96so6520772pjc.3;
        Sun, 16 Feb 2020 19:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vO/kpK4i91+xXYCwM2I/fZr8n6mbhWaXJUGJvuJZc+Y=;
        b=kWFy7PQyiNjAZJFtT/E/PuHTnbTjflYSS5VX5wkUO40mraCjqh8Q1FoWGivQp7RjX2
         4gjULWpygXycwmmFfs7ywgTQCXLNT4eVlEt6Ylsk50bZUmbBeTneamPzKPdTwQ0UcTY5
         DQGUesGtUTNNe9W4F5up/Mng9GWFUxhP54Nhm1lbfpGmUsM/hpCTCDT3vjJ+JLLBjFrS
         cxXVvogM7CAKOPBk4FTts7+piEM6jTzZgmMssRJmkLLFcExaCzYOjfzjUBdD4Zzj1g9H
         uRh4/kOGEH5Pe6x6jese/WODZ5Iwp0JUbJv3xnGP0+ARg0iuk24xBgXDXK3tiWNDQIBX
         vrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vO/kpK4i91+xXYCwM2I/fZr8n6mbhWaXJUGJvuJZc+Y=;
        b=fWLJ3+8jaGDH3t/SO1kWXqK/Qo0WmDNILhoDK/5CYDuSLB0DlFEca7WIGyVSR9vzMI
         8/Jq3ZhtQRQAklOGNCWdQJlHiq53Ya3+D/lgcg2f/EjH6IM9K5O8FVxOUUlCZn/+R8Ge
         TmmiyxyGAljv8kav+0KY7n7c4cmqNPGgzN5gMoIFnKgliWzFjFz/5Hsas1H9yWkgjZq3
         CR//RHFFYGr1va2sJCVHKdjTbm7FhCN42kBqWt0CX9+WeKC2sCe/SW61m5KQ4uMzGjds
         KbhGpijp33o7oYmurN8HhXkgiipxDojEMvzeFmoU8upv34j8nn+3zV3Jr7IYNTinHeBT
         XZGQ==
X-Gm-Message-State: APjAAAWOCtJNwqtSUUx6tQyk5PEhokvqRJ0TcICxgFWZNI2EDMvFh9qs
        G2bWbTBq/qDLRukgpw/e8gA=
X-Google-Smtp-Source: APXvYqxqBgrmhmCaMQFDWNQdtezcMrO1MGJdg4RQPZ/vrAyhTN79wxtj2ML5NI/2AgZqjEgA1C4xPA==
X-Received: by 2002:a17:902:8a8e:: with SMTP id p14mr14237937plo.28.1581909842143;
        Sun, 16 Feb 2020 19:24:02 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 76sm14644383pfx.97.2020.02.16.19.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 19:24:01 -0800 (PST)
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
Subject: [PATCH v4 6/7] clk: sprd: support to get regmap from parent node
Date:   Mon, 17 Feb 2020 11:23:20 +0800
Message-Id: <20200217032321.15164-7-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200217032321.15164-1-zhang.lyra@gmail.com>
References: <20200217032321.15164-1-zhang.lyra@gmail.com>
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

