Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0724BC2D0EE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E3C20733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWy51g62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgC3HP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:15:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35287 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbgC3HP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 03:15:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id k5so6041510pga.2;
        Mon, 30 Mar 2020 00:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xKFpCudKYBZvQ8EtOLejOUBPW7N9bLRf634sMMnnRrc=;
        b=GWy51g62XQ0ENEstd2CAEa3+Lm2sMACdR2HSAjoFunAeSW1e1jlU9YtRvAmH4VDeVH
         lT0iLBSa711U7LgegLu8aen0+NwhcJMUx0e0i/5Ovw6nqLgR9ytuZSHedrFv3VcPbNEi
         zOnNKDjraXuaASIP7pQESNyRbAK324w+YnAdPLCdT4WqjagLOurMb+wsrdmR0XUeSZLX
         dv3mU9s3fV30OlY+8nT/DK7E9tnTWMRrQ4u81dMgKPjjuS6z/Xul0NcFNIdKNc0+vhmy
         5Tgrd2R0u2u9e1cN3kTfb5Wgt+v50JTsriF4jvsxcHcjwWYvBHqgbxEa7c1L+6Qt8K2C
         Px8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xKFpCudKYBZvQ8EtOLejOUBPW7N9bLRf634sMMnnRrc=;
        b=jb4GrylzoGu1q2HdCrEZBsGa4Mvzmz8KhzBJzz+JAQJ3j8Ww0nebMyzmWh0Z+fmW44
         kxKDT4mZvvr/ZtEUE0qGBjAv9SYMzT+ktEjGNlPTMuwz/zroUO0/ZhaoYNUTQqAf7m0M
         pmGIwtspgrvwfK320RmVIdEby9CmBpL3VLRU4qnO1Mc/uWXdxcHZPNvcemiFPiLArGda
         CNPvusSZRQ2+uK/rU2kTtdcKsTQWOs4joWjI4+2jfO+upD0AXAYt+kItutQtVUmfsVld
         DTAtvnX3+z3PEFhEwdIau6diIJNk+QFBNpxNQqmUSkrplYzYc4d2+QHWu9OnMmcPRYtj
         5xjw==
X-Gm-Message-State: ANhLgQ1NTSc72YNsnzen2gMYAuGe6LI1tNpxnl/hF7nGK3xZFYwlf3kw
        SpYCnVroj4N7GHpHBW5xtfY=
X-Google-Smtp-Source: ADFU+vvCnOik/ZUB/hjFhj7+4XkZB4/brE92p7sVx/jl5qOfFLzBRfapvqLjqu1OUHKtzsybZLeY8A==
X-Received: by 2002:a63:a74e:: with SMTP id w14mr11341668pgo.231.1585552556128;
        Mon, 30 Mar 2020 00:15:56 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id l1sm9490484pje.9.2020.03.30.00.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 00:15:55 -0700 (PDT)
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
Subject: [PATCH 1/4] clk: sprd: check its parent status before reading gate clock
Date:   Mon, 30 Mar 2020 15:14:48 +0800
Message-Id: <20200330071451.7899-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200330071451.7899-1-zhang.lyra@gmail.com>
References: <20200330071451.7899-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Some clocks only can be accessed if their parent is enabled. mipi_csi_xx
clocks on SC9863A are examples. We have to ensure the parent clock is
enabled when reading those clocks.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/clk/sprd/gate.c | 8 ++++++++
 drivers/clk/sprd/gate.h | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/clk/sprd/gate.c b/drivers/clk/sprd/gate.c
index 574cfc116bbc..8d14073b9cb8 100644
--- a/drivers/clk/sprd/gate.c
+++ b/drivers/clk/sprd/gate.c
@@ -5,6 +5,7 @@
 // Copyright (C) 2017 Spreadtrum, Inc.
 // Author: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
 
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/regmap.h>
 
@@ -94,8 +95,15 @@ static int sprd_gate_is_enabled(struct clk_hw *hw)
 {
 	struct sprd_gate *sg = hw_to_sprd_gate(hw);
 	struct sprd_clk_common *common = &sg->common;
+	struct clk_hw *parent;
 	unsigned int reg;
 
+	if (sg->flags & SPRD_GATE_NON_AON) {
+		parent = clk_hw_get_parent(hw);
+		if (!parent || !clk_hw_is_enabled(parent))
+			return 0;
+	}
+
 	regmap_read(common->regmap, common->reg, &reg);
 
 	if (sg->flags & CLK_GATE_SET_TO_DISABLE)
diff --git a/drivers/clk/sprd/gate.h b/drivers/clk/sprd/gate.h
index b55817869367..aa4d72381788 100644
--- a/drivers/clk/sprd/gate.h
+++ b/drivers/clk/sprd/gate.h
@@ -19,6 +19,15 @@ struct sprd_gate {
 	struct sprd_clk_common	common;
 };
 
+/*
+ * sprd_gate->flags is used for:
+ * CLK_GATE_SET_TO_DISABLE	BIT(0)
+ * CLK_GATE_HIWORD_MASK		BIT(1)
+ * CLK_GATE_BIG_ENDIAN		BIT(2)
+ * so we define new flags from	BIT(3)
+ */
+#define SPRD_GATE_NON_AON BIT(3) /* not alway on, need to check before read */
+
 #define SPRD_SC_GATE_CLK_HW_INIT_FN(_struct, _name, _parent, _reg,	\
 				    _sc_offset, _enable_mask, _flags,	\
 				    _gate_flags, _udelay, _ops, _fn)	\
-- 
2.20.1

