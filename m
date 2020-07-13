Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB211C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 00:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94F822077D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 00:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlJdPzO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgGMAZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 20:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbgGMAZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 20:25:19 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D97C061794;
        Sun, 12 Jul 2020 17:25:19 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g13so8765203qtv.8;
        Sun, 12 Jul 2020 17:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Es3z9+6oVEd9P5UxAlvjZy0XJ5zCI0VHL9FYRbRC/gM=;
        b=IlJdPzO5QN7ZJv3oZFIrdJ8Ooyp6hmgwNxdNNCmoWDrI49jF5NJyowmC7EBAwvpYu8
         tzLkDTdCWiaTD+UG/P6cPjHiQ0MISCRBeLXCmCBWq+cfn48mENt7txm4+Cv19PL8NGKA
         tSeYnD8H2Z/ZTld/FUk98oxtzJP5UITe8TS1OPzxgx4NZMexAbQGhYRIwwokCHabJr19
         nNFEO7L34uU6NBWYP1N+4zs8uqWBflFXa/rtGCSmJqA9xZF52aUBiuPCxEX0J/kuN/MQ
         AjsWOLI807IumCgu/g3Ys+kuXPoBMUMLBkkpWjuxQrT7++BeDDuU1R2YQpxbXX7HCy1X
         QJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Es3z9+6oVEd9P5UxAlvjZy0XJ5zCI0VHL9FYRbRC/gM=;
        b=Sge36cyP4ePQVijIIg6qtLEVk7fMlbIoGi3abx8jVPhdSsuKh+AG2rPgY90WrZfuWk
         VZafmB0z60pkTZB0wG9HRh/OGEZm+F04VoQ+uabHDg+eXeJdaKbRLSOwmYbT2ihm2Hvr
         gb43ocA0JZaFKmYTYTP+chR+NxP6zOpdWlyrM37pmW1Gy499Amgms+NtmYaaoeGEcRxI
         a+KpDQXwXdPKzO5BkMIuCJLKPi/eRKEnw5mesk7tPKOdh5J+Z75GqoxMDn7GV5afBZZq
         QhGT8WOpQkU8Rom383NsjHpZy+PJtlEbxoRvzbDwgmI5GjheOgurpbYW2UslDPuKXdUS
         3IGA==
X-Gm-Message-State: AOAM533R20/1NLTqCO38649vzrQfWg7EDqi7mM9gm9mft/p8et/T0DkL
        Ri32EKuJxCkqm9pP7ExX4F0=
X-Google-Smtp-Source: ABdhPJzLZ8gpYiloumiaSUnCaORV7qMNuoZlWRNacT/kz53QHdc4auTOpe2lawDgPHMLC0FEszmxzQ==
X-Received: by 2002:ac8:4316:: with SMTP id z22mr81424171qtm.121.1594599918561;
        Sun, 12 Jul 2020 17:25:18 -0700 (PDT)
Received: from localhost.localdomain ([72.53.229.195])
        by smtp.gmail.com with ESMTPSA id u5sm17044309qke.32.2020.07.12.17.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 17:25:18 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v1 2/5] clk: imx: add simple regmap-backed clock mux
Date:   Sun, 12 Jul 2020 20:25:09 -0400
Message-Id: <20200713002512.28742-3-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713002512.28742-1-TheSven73@gmail.com>
References: <20200713002512.28742-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the imx6 QuadPlus, some clocktree muxes have control bits located
in the GPR area. This area is already modelled as a syscon regmap.

To control these muxes, add a simple regmap-backed clock mux.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---

Tree: v5.8-rc4

To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-clk@vger.kernel.org

 drivers/clk/imx/Makefile         |   1 +
 drivers/clk/imx/clk-mux-regmap.c | 110 +++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h            |   7 ++
 3 files changed, 118 insertions(+)
 create mode 100644 drivers/clk/imx/clk-mux-regmap.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 928f874c73d2..3d36740c1efd 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_MXC_CLK) += \
 	clk-pllv3.o \
 	clk-pllv4.o \
 	clk-sscg-pll.o \
+	clk-mux-regmap.o \
 	clk-pll14xx.o
 
 obj-$(CONFIG_MXC_CLK_SCU) += \
diff --git a/drivers/clk/imx/clk-mux-regmap.c b/drivers/clk/imx/clk-mux-regmap.c
new file mode 100644
index 000000000000..ba5fde525999
--- /dev/null
+++ b/drivers/clk/imx/clk-mux-regmap.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Sven Van Asbroeck
+ *
+ * Simple clock multiplexer, backed by a regmap
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include "clk.h"
+
+struct clk_mux_regmap {
+	struct clk_hw hw;
+	struct regmap *regmap;
+	unsigned int reg;
+	u8 shift;
+	u32 mask;
+};
+
+#define to_clk_mux_regmap(_hw) container_of(_hw, struct clk_mux_regmap, hw)
+
+static u8 clk_regmap_read_index(struct clk_mux_regmap *clk)
+{
+	unsigned int val;
+
+	if (regmap_read(clk->regmap, clk->reg, &val))
+		return 0;
+
+	val >>= clk->shift;
+	val &= clk->mask;
+
+	return (u8)val;
+}
+
+static u8 clk_mux_regmap_get_parent(struct clk_hw *hw)
+{
+	struct clk_mux_regmap *clk = to_clk_mux_regmap(hw);
+
+	return clk_regmap_read_index(clk);
+}
+
+static int clk_mux_regmap_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_mux_regmap *clk = to_clk_mux_regmap(hw);
+
+	return regmap_update_bits(clk->regmap, clk->reg,
+				  clk->mask << clk->shift,
+				  (unsigned int)index << clk->shift);
+}
+
+static int clk_mux_regmap_determine_rate(struct clk_hw *hw,
+					 struct clk_rate_request *req)
+{
+	struct clk_mux_regmap *clk = to_clk_mux_regmap(hw);
+	struct clk_hw *parent;
+	u8 index;
+
+	index = clk_regmap_read_index(clk);
+	parent = clk_hw_get_parent_by_index(hw, index);
+	if (!parent)
+		return -EINVAL;
+	req->rate = clk_hw_get_rate(parent);
+
+	return 0;
+}
+
+static const struct clk_ops clk_mux_regmap_ops = {
+	.get_parent = clk_mux_regmap_get_parent,
+	.set_parent = clk_mux_regmap_set_parent,
+	.determine_rate = clk_mux_regmap_determine_rate,
+};
+
+struct clk_hw *
+imx_clk_hw_mux_regmap(const char *name, struct regmap *regmap, unsigned int reg,
+		      u8 shift, u8 width, const char * const *parent_names,
+		      int num_parents)
+{
+	struct clk_mux_regmap *clk_regmap;
+	struct clk_init_data init = {};
+	struct clk_hw *hw;
+	int ret;
+
+	if (num_parents > (1 << width))
+		return ERR_PTR(-EINVAL);
+
+	clk_regmap = kzalloc(sizeof(*clk_regmap), GFP_KERNEL);
+	if (!clk_regmap)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+	init.ops = &clk_mux_regmap_ops;
+	clk_regmap->regmap = regmap;
+	clk_regmap->reg = reg;
+	clk_regmap->shift = shift;
+	clk_regmap->mask = BIT(width) - 1;
+	clk_regmap->hw.init = &init;
+
+	hw = &clk_regmap->hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(clk_regmap);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 16adbc34e05f..4df766abbe16 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -5,6 +5,8 @@
 #include <linux/spinlock.h>
 #include <linux/clk-provider.h>
 
+struct regmap;
+
 #define IMX_CLK_GATE2_SINGLE_BIT	1
 
 extern spinlock_t imx_ccm_lock;
@@ -447,6 +449,11 @@ static inline struct clk_hw *imx_dev_clk_hw_mux(struct device *dev,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
+struct clk_hw *
+imx_clk_hw_mux_regmap(const char *name, struct regmap *regmap, unsigned int reg,
+		      u8 shift, u8 width, const char * const *parent_names,
+		      int num_parents);
+
 static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
 			u8 shift, u8 width, const char * const *parents,
 			int num_parents)
-- 
2.17.1

