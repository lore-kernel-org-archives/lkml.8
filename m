Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0760C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14CE207D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+KdDcW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgESDAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 23:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgESDAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 23:00:44 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92886C061A0C;
        Mon, 18 May 2020 20:00:44 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id n15so720242pjt.4;
        Mon, 18 May 2020 20:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UnJKuJGVYF6fA5k6yoVG80q3S/n8nZyC72NBiLOx2Tg=;
        b=s+KdDcW74Qx7WsQOS2WsQ5NCi7nor1ZWq4ORQvQb46SiW4wvGrRblUmtuTYvg9tkqA
         r+iTJj7fZtCJw/YY778GrTZx0lfgOXzv1rids1lYZvPn11XUfyxhJjrXQLJiaPtUwK53
         Fe2+UAE4pt4iHWddjSKXknhKacIS2FTJuvp/bBJlMk7ZYBwyZT0EvrzfGAPF/5Uq2YMl
         hyDAEXF4dzP/mAI92nB1kL1lHx7K5JBmCdR7YtgrDgn4zo/OzTUBIC6KD88KHAA2D8qk
         rKmSnU9AuqVsfYoMZ22iFCtvLFUlLfQheCznvApT1L8z2zKT+X9cpiGojNr+Rd+rmwVE
         55Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UnJKuJGVYF6fA5k6yoVG80q3S/n8nZyC72NBiLOx2Tg=;
        b=hojnA4Zs4bLdF/dTx8+i3sD+Iq4XNlsbUeaOJN62JuOtL5CLV8zY7jKikUQsR29UsH
         f9ooK2dkIObagDkrlpKLjPITfW00LhHK+dQmgXf/NQb0IZRtBEvm4c3M95t3TRXyUmfH
         iZp6OyXstX1O9UGnfwuDYa+Fngc4EiABb2fNbChuE0holYB1ICGbfOXLllqiYiyVaTFu
         Xpxp6PTh3rOFbxgkwbH5ite1FXQm6wVwmtCyxpe7pYQnQ/mqk8qQDfL0cB44V4pXTSCZ
         RK+RdFCjgahvNg6THBkNUrjkLngfYA8tL/QbXB3sOKeLXjLEyk/EzRczukq1jZFgX4fK
         bPxw==
X-Gm-Message-State: AOAM531VIJlDmx2mXfMFzbgwX2LQmLSfz+uXPJthgW0g6YIhjLUHvDAw
        bmesH3kRlSrvegUw8icVIwg=
X-Google-Smtp-Source: ABdhPJy1t4rt9mTDBn6rNEdUra4+iLmjwqhnVTRDsQ7ivFkmrkzFRlSrX1T0iPpZs7VyJLOqEWn1NQ==
X-Received: by 2002:a17:90a:3201:: with SMTP id k1mr2595156pjb.202.1589857244161;
        Mon, 18 May 2020 20:00:44 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id k24sm9809494pfk.134.2020.05.18.20.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 20:00:43 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 1/2] clk: sprd: mark the local clock symbols static
Date:   Tue, 19 May 2020 11:00:35 +0800
Message-Id: <20200519030036.1785-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

There's a few pll gate clocks which were not marked with static, and
those clock are used only in the current file, so add static key word
for them.

Fixes: 0e4b8a2349f3 ("clk: sprd: add clocks support for SC9863A")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/clk/sprd/sc9863a-clk.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/sprd/sc9863a-clk.c b/drivers/clk/sprd/sc9863a-clk.c
index 9568ec956ee4..ad2e0f9f8563 100644
--- a/drivers/clk/sprd/sc9863a-clk.c
+++ b/drivers/clk/sprd/sc9863a-clk.c
@@ -23,22 +23,22 @@
 #include "pll.h"
 
 /* mpll*_gate clocks control cpu cores, they were enabled by default */
-SPRD_PLL_SC_GATE_CLK_FW_NAME(mpll0_gate, "mpll0-gate", "ext-26m", 0x94,
-			     0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240);
-SPRD_PLL_SC_GATE_CLK_FW_NAME(dpll0_gate, "dpll0-gate", "ext-26m", 0x98,
-			     0x1000, BIT(0), 0, 0, 240);
-SPRD_PLL_SC_GATE_CLK_FW_NAME(lpll_gate, "lpll-gate", "ext-26m", 0x9c,
-			     0x1000, BIT(0), 0, 0, 240);
-SPRD_PLL_SC_GATE_CLK_FW_NAME(gpll_gate, "gpll-gate", "ext-26m", 0xa8,
-			     0x1000, BIT(0), 0, 0, 240);
-SPRD_PLL_SC_GATE_CLK_FW_NAME(dpll1_gate, "dpll1-gate", "ext-26m", 0x1dc,
-			     0x1000, BIT(0), 0, 0, 240);
-SPRD_PLL_SC_GATE_CLK_FW_NAME(mpll1_gate, "mpll1-gate", "ext-26m", 0x1e0,
-			     0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240);
-SPRD_PLL_SC_GATE_CLK_FW_NAME(mpll2_gate, "mpll2-gate", "ext-26m", 0x1e4,
-			     0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240);
-SPRD_PLL_SC_GATE_CLK_FW_NAME(isppll_gate, "isppll-gate", "ext-26m", 0x1e8,
-			     0x1000, BIT(0), 0, 0, 240);
+static SPRD_PLL_SC_GATE_CLK_FW_NAME(mpll0_gate, "mpll0-gate", "ext-26m", 0x94,
+				    0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240);
+static SPRD_PLL_SC_GATE_CLK_FW_NAME(dpll0_gate, "dpll0-gate", "ext-26m", 0x98,
+				    0x1000, BIT(0), 0, 0, 240);
+static SPRD_PLL_SC_GATE_CLK_FW_NAME(lpll_gate, "lpll-gate", "ext-26m", 0x9c,
+				    0x1000, BIT(0), 0, 0, 240);
+static SPRD_PLL_SC_GATE_CLK_FW_NAME(gpll_gate, "gpll-gate", "ext-26m", 0xa8,
+				    0x1000, BIT(0), 0, 0, 240);
+static SPRD_PLL_SC_GATE_CLK_FW_NAME(dpll1_gate, "dpll1-gate", "ext-26m", 0x1dc,
+				    0x1000, BIT(0), 0, 0, 240);
+static SPRD_PLL_SC_GATE_CLK_FW_NAME(mpll1_gate, "mpll1-gate", "ext-26m", 0x1e0,
+				    0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240);
+static SPRD_PLL_SC_GATE_CLK_FW_NAME(mpll2_gate, "mpll2-gate", "ext-26m", 0x1e4,
+				    0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240);
+static SPRD_PLL_SC_GATE_CLK_FW_NAME(isppll_gate, "isppll-gate", "ext-26m",
+				    0x1e8, 0x1000, BIT(0), 0, 0, 240);
 
 static struct sprd_clk_common *sc9863a_pmu_gate_clks[] = {
 	/* address base is 0x402b0000 */
-- 
2.20.1

