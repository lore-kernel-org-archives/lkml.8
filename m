Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AD5C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4692166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEKQKZVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387657AbgCDH2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:28:41 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33545 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387608AbgCDH2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:28:39 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay11so646691plb.0;
        Tue, 03 Mar 2020 23:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vO/kpK4i91+xXYCwM2I/fZr8n6mbhWaXJUGJvuJZc+Y=;
        b=aEKQKZVRwAZvitT0aaSQiiUSrlj1eKfFdXJc7w/+xLEuXCaWYKDlQgPLheaR+mS1kO
         vN8K1ryUY9kMQ+KG1g/Ot5lbJ8/nzD9jOF9khPhVEiMIJ25YqMBTI/r5H4pziLMhGJ/H
         qG1h6NAC8SEjOyUv0DmdU9fVSm9gXL2aAn3kURN97Ll9QBL8oFpB1Npg1kf/QOPY8XLO
         svTymLukwMJpgCmUN87L5QJ4TE0nQDI73mT9E96X0TcRVATfkArnZRWYYaq/zrltDwAu
         Y1kC69fLEqjtoK7HMyNt4tPW+DnCtJNVNF5bOT4f7fIul1/UYdod5HRu2BbYUp5qShks
         nYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vO/kpK4i91+xXYCwM2I/fZr8n6mbhWaXJUGJvuJZc+Y=;
        b=jLpZJrpQNmIlGZ5sInfSJDsV5vON77Nzqtf8xdIm9NZnPUPAqc+9F+5mfI88c5fTyd
         ee5cbJpg4qNF/orIympyjho1tHvpHE9Vp39v1n6tN92XLgPWjNFyz9xjHtTgPKRPeXwD
         USrEVzlFxmMpiSGAKekUPrXidT8HPzmoD5vr3O7f5NHPxFJ8j/al265MUpKUi+XIPzV5
         MFpd8wpMMzY1x+N+KLzkuXfahDLwsZBAwSHO7g4SDrMjWhrKz2i3kUwDiRBkqHYQnL1G
         otrng7cQ9CtMbDtOfdpGg6IEB8gtc/U8qaBrpAqaTmYMxZZx/9WCQFOfaWJbewgEvy3x
         6RVw==
X-Gm-Message-State: ANhLgQ0Q5re74jkpTX00HSJaaparTkaRBpHee7oDBuxT9qxmnoAXCU3T
        pOQypwY7pvZo0MLrTe6XfK0=
X-Google-Smtp-Source: ADFU+vuGAHtvSBGcIFNT0CrtxCqzjkdgE5jg2wEnP5tBJIP8gsNC0PQ6dvkQ2VUMgVnrPyRvf27VaA==
X-Received: by 2002:a17:90a:9303:: with SMTP id p3mr1745531pjo.35.1583306918009;
        Tue, 03 Mar 2020 23:28:38 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j38sm23435859pgi.51.2020.03.03.23.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 23:28:37 -0800 (PST)
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
Subject: [PATCH v6 6/7] clk: sprd: support to get regmap from parent node
Date:   Wed,  4 Mar 2020 15:27:29 +0800
Message-Id: <20200304072730.9193-7-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304072730.9193-1-zhang.lyra@gmail.com>
References: <20200304072730.9193-1-zhang.lyra@gmail.com>
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

