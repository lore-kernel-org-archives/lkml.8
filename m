Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1C5C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131532072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsZXgL1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBQDXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:23:47 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50353 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgBQDXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:23:45 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so6523428pjb.0;
        Sun, 16 Feb 2020 19:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HcHZ0x70/qK7NXMoSBHV+1QL/bUky1H1SggR4DxRjDU=;
        b=XsZXgL1L6uaK5/4e+nZ1zUYexeEDYRAG/XF/qDEZz3tZWM7bFIy58XbvGrVcophxoa
         hBVm7jCikE+8Gtnj0tIRMssrs+SIQ4qidCm3BPb321cWGuC/+2aqmPUrkdzABGLLqHOU
         RZolCeQSLApTvF4L0wX2cJsIKx5nJmNxjha3mYQgpZNlQhGAHYL1ulwIxYzcS5H9lN+W
         VlmbEU7FaEhcR46noRkIm6Y9IoAQjJZDxfsAC28ompnb3Hc0GbNFJLdaX4LMJpe1W3iK
         vNOVqWrtljEwQ/WacI6052DwzHTATAGd0W29I3VbMHi5ZevlLBY92Az09fAjgDXVqRRP
         0aEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HcHZ0x70/qK7NXMoSBHV+1QL/bUky1H1SggR4DxRjDU=;
        b=Rr5+ea98geZtviI+ieT35eaRSvcmwDWogy941X4ndW3UE+MefaQibVgmnUBOj6cr4G
         iBj62+owBsGxWAtJ0pTdkcayQMXPhJGEPWbwSZm66ofv8mh8F3J+tM6iboCvHO9sLcwp
         vg9FyQYp2EuhTjTqTS/+PYfi1l0xkjpRNBG8k1vrUr4/yYYFY0LBP70NMngqbgU84WUE
         rXS/lSXQThNkGVxv/UlmunxgeygJ7wt9nPhX7KL8ZxcqvPuWq1evJToRKnHWYkul/lc0
         FTx4/BJRSLFRgmwLYil5xSn9KRAzJnJDN1IUg8XUkvU7TBXwoW8ZO5KrQ33pWmMjs8d5
         RoOQ==
X-Gm-Message-State: APjAAAWTQVU6TMLEXNox5hvRmjNC8ZzYPs7kXvWIkKboG+XceOfnVjis
        V71PiHNUmSmB2lkth2PRsQaXNBtS
X-Google-Smtp-Source: APXvYqxL8IJDuFKIoT4ikri2PLSNg1TkL8ki8ybLf+bcu4cM6edhoPwrRD5sbdwsmTcHsxwAP4WYfA==
X-Received: by 2002:a17:902:7898:: with SMTP id q24mr13360719pll.164.1581909824526;
        Sun, 16 Feb 2020 19:23:44 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 76sm14644383pfx.97.2020.02.16.19.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 19:23:43 -0800 (PST)
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
Subject: [PATCH v4 1/7] clk: sprd: add gate for pll clocks
Date:   Mon, 17 Feb 2020 11:23:15 +0800
Message-Id: <20200217032321.15164-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200217032321.15164-1-zhang.lyra@gmail.com>
References: <20200217032321.15164-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaolong Zhang <xiaolong.zhang@unisoc.com>

Some sprd's gate clocks are used to the switch of pll, which
need to wait a certain time for stable after being enabled.

Signed-off-by: Xiaolong Zhang <xiaolong.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/clk/sprd/gate.c | 17 +++++++++++++++++
 drivers/clk/sprd/gate.h | 21 +++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sprd/gate.c b/drivers/clk/sprd/gate.c
index f59d1936b412..574cfc116bbc 100644
--- a/drivers/clk/sprd/gate.c
+++ b/drivers/clk/sprd/gate.c
@@ -79,6 +79,17 @@ static int sprd_sc_gate_enable(struct clk_hw *hw)
 
 	return 0;
 }
+
+static int sprd_pll_sc_gate_prepare(struct clk_hw *hw)
+{
+	struct sprd_gate *sg = hw_to_sprd_gate(hw);
+
+	clk_sc_gate_toggle(sg, true);
+	udelay(sg->udelay);
+
+	return 0;
+}
+
 static int sprd_gate_is_enabled(struct clk_hw *hw)
 {
 	struct sprd_gate *sg = hw_to_sprd_gate(hw);
@@ -109,3 +120,9 @@ const struct clk_ops sprd_sc_gate_ops = {
 };
 EXPORT_SYMBOL_GPL(sprd_sc_gate_ops);
 
+const struct clk_ops sprd_pll_sc_gate_ops = {
+	.unprepare	= sprd_sc_gate_disable,
+	.prepare	= sprd_pll_sc_gate_prepare,
+	.is_enabled	= sprd_gate_is_enabled,
+};
+EXPORT_SYMBOL_GPL(sprd_pll_sc_gate_ops);
diff --git a/drivers/clk/sprd/gate.h b/drivers/clk/sprd/gate.h
index dc352ea55e1f..d380d77b8dce 100644
--- a/drivers/clk/sprd/gate.h
+++ b/drivers/clk/sprd/gate.h
@@ -14,16 +14,19 @@ struct sprd_gate {
 	u32			enable_mask;
 	u16			flags;
 	u16			sc_offset;
+	u16			udelay;
 
 	struct sprd_clk_common	common;
 };
 
-#define SPRD_SC_GATE_CLK_OPS(_struct, _name, _parent, _reg, _sc_offset,	\
-			     _enable_mask, _flags, _gate_flags, _ops)	\
+#define SPRD_SC_GATE_CLK_OPS_UDELAY(_struct, _name, _parent, _reg,	\
+				    _sc_offset, _enable_mask, _flags,	\
+				    _gate_flags, _udelay, _ops)		\
 	struct sprd_gate _struct = {					\
 		.enable_mask	= _enable_mask,				\
 		.sc_offset	= _sc_offset,				\
 		.flags		= _gate_flags,				\
+		.udelay		= _udelay,				\
 		.common	= {						\
 			.regmap		= NULL,				\
 			.reg		= _reg,				\
@@ -34,6 +37,12 @@ struct sprd_gate {
 		}							\
 	}
 
+#define SPRD_SC_GATE_CLK_OPS(_struct, _name, _parent, _reg, _sc_offset,	\
+			     _enable_mask, _flags, _gate_flags, _ops)	\
+	SPRD_SC_GATE_CLK_OPS_UDELAY(_struct, _name, _parent, _reg,	\
+				    _sc_offset, _enable_mask, _flags,	\
+				    _gate_flags, 0, _ops)
+
 #define SPRD_GATE_CLK(_struct, _name, _parent, _reg,			\
 		      _enable_mask, _flags, _gate_flags)		\
 	SPRD_SC_GATE_CLK_OPS(_struct, _name, _parent, _reg, 0,		\
@@ -46,6 +55,13 @@ struct sprd_gate {
 			     _enable_mask, _flags, _gate_flags,		\
 			     &sprd_sc_gate_ops)
 
+#define SPRD_PLL_SC_GATE_CLK(_struct, _name, _parent, _reg, _sc_offset,	\
+			    _enable_mask, _flags, _gate_flags, _udelay)	\
+	SPRD_SC_GATE_CLK_OPS_UDELAY(_struct, _name, _parent, _reg,	\
+				    _sc_offset,	_enable_mask, _flags,	\
+				    _gate_flags, _udelay,		\
+				    &sprd_pll_sc_gate_ops)
+
 static inline struct sprd_gate *hw_to_sprd_gate(const struct clk_hw *hw)
 {
 	struct sprd_clk_common *common = hw_to_sprd_clk_common(hw);
@@ -55,5 +71,6 @@ static inline struct sprd_gate *hw_to_sprd_gate(const struct clk_hw *hw)
 
 extern const struct clk_ops sprd_gate_ops;
 extern const struct clk_ops sprd_sc_gate_ops;
+extern const struct clk_ops sprd_pll_sc_gate_ops;
 
 #endif /* _SPRD_GATE_H_ */
-- 
2.20.1

