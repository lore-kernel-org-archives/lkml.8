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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FD0C2D0E9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6CE20748
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulhlK3QD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgC3HbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:31:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41107 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbgC3HbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 03:31:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id a24so1337561pfc.8;
        Mon, 30 Mar 2020 00:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SEwlVyEv36eeIRNWATF1aFQ5BBswo3YJxEpbUEmPHfo=;
        b=ulhlK3QDhORQq7j8zyNINp8aFMjGg4QklBE2Ocb/P/cRQVp98/JNMkMYa8ZPASSR5a
         p2OKwOT8slo+Zm5wpjFiDY+RJJTjsbIiHMUPY7WxxI0mQwzeIYrw8G+Qcg3S2qQAKuvs
         yi5X2sFwEJnuwxP09ETYhRcKkTZj0Ykk1wgjaQ/hRAymHRlljvO89nf5KMlC9s0kxh0s
         pQF9gT2oJOs6JmMofg3z+9MAshfvsM2O7VGn9QZfVUvY3iW8aT5/mc1zkuVcZrQnY1px
         x4TuNTEvtDzR1s1MiEOR6ojUcpOjNtpppW+BPLIUNf38+yiqCm0b6aAD+6VQ570LBR7c
         iPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SEwlVyEv36eeIRNWATF1aFQ5BBswo3YJxEpbUEmPHfo=;
        b=syBFb/rpb3m6cfxedrd2fsjbCpKWfSAzwbRiJ+RHB5s4MLlDw+1Y3mE5ejv0c6BaiI
         /mceGhoyxpKTjIj3b47Txrt5tiWyT4TQKET7s7rIgOiond/p81i+N6vENt9zlC0wVlvz
         DPlEMsvKzFv+mMd0T+lK2zzCOIIcI6KV2JLSd5DveX6xO0bxn2CfcmtxEUFgvQH6MOeG
         /aWZA2rruYjnTvT9IJjZ2iPXUKp4BzExgWFWkLzMorBLJ691s6fH1XYw8MoxHzl55pjw
         PDmm9Ix8tBULGN3wxaxq+FG0Tlf4T/66VKd+lrdmCZVYdhyHvDgC06MAPWRxWS0gAIKG
         qCPA==
X-Gm-Message-State: ANhLgQ1g3rh6XuJFK6HtSL3rceeQNRDsq0umZGFjqjg9/CTfS++6Oeaq
        yqPODmDEmvf0ADyNnBVad8g=
X-Google-Smtp-Source: ADFU+vvZhDfj+ZP7g9wtM/Cs/lguG9sQbIRc/a/b3v4CzDuWHLhq26abeNCo5nQjVkZd/YaXdbA/5w==
X-Received: by 2002:a65:6855:: with SMTP id q21mr10003864pgt.188.1585553475645;
        Mon, 30 Mar 2020 00:31:15 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id r186sm9648935pfc.181.2020.03.30.00.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 00:31:15 -0700 (PDT)
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
Date:   Mon, 30 Mar 2020 15:31:07 +0800
Message-Id: <20200330073107.14180-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200330071451.7899-2-zhang.lyra@gmail.com>
References: <20200330071451.7899-2-zhang.lyra@gmail.com>
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
 drivers/clk/sprd/gate.c | 7 +++++++
 drivers/clk/sprd/gate.h | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/clk/sprd/gate.c b/drivers/clk/sprd/gate.c
index 574cfc116bbc..56e1714b541e 100644
--- a/drivers/clk/sprd/gate.c
+++ b/drivers/clk/sprd/gate.c
@@ -94,8 +94,15 @@ static int sprd_gate_is_enabled(struct clk_hw *hw)
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

