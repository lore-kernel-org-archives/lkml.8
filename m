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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E035C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2E3215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uDkmQF2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgCDH2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:28:18 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40089 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgCDH2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:28:18 -0500
Received: by mail-pj1-f67.google.com with SMTP id k36so544884pje.5;
        Tue, 03 Mar 2020 23:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HcHZ0x70/qK7NXMoSBHV+1QL/bUky1H1SggR4DxRjDU=;
        b=uDkmQF2VoQxpC+H0Z3gdRgVO/aNZp0voEUGIWS7psHFKjTxLZvV8tuEUOimvMOp9Bk
         4xYeJ6O+qq+gYAPnxp1vtSh0DxDiV6+2ZfcB3ygh4lJHMmTpop8PUm8UaADf40R1RXRG
         gTD3/cI+tm4JR+vrUx7Hcpi90+Wj5xKfMmjz/4cky5nBD5j9FNTphaHGL8l4opOCaOzx
         Lj7B/EINfNdchRuMXMFOIvO5QVRhF/tuRkcwhcwO92MMs/q5ePSz70L6US14Qa1vEip7
         cj7Zjv62JvhdAacR4/IRsa0f06gIbgx7c0aqNr6PbpzfCBlw0qpRwrR+auIqNSOVP9u5
         rG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HcHZ0x70/qK7NXMoSBHV+1QL/bUky1H1SggR4DxRjDU=;
        b=iWSVpsZkR0xIViWUHcrgNpoblFJqdxr6eYbE4YfOyq8wWun9vwECewaQjUz3WxvqIK
         5nQ7CpqTZ/bmas3tJTBFDUyIjMSwQpuSiGSr88fFQDge2wPalvdrIyPeTP6Nzvq7m8x/
         4KAH4BZM0IbU6b1rJnKWMURi3mOwLkLCLV5NndjJ+Ne2yUHNL0doS+86FWzh4kBivg3P
         u6ASa7/IAN5ztN3bjbQT/0eTULOovmN1mzdfm8HudBu9cr01qoxks5zcGUMUbZUmV8tI
         bn6T5f+K2B6rxl2CZqWyLUSoCQi5gCy9UK9xrIa2qQJqfcVwTegvX7NaeoQv4TMqwd2G
         SsZA==
X-Gm-Message-State: ANhLgQ1vbfqyCgn/Wi9it6I60SqjNzxwwsxKKrtthr37LTpDFD85o4/O
        KYOXs1zKbQX29I/UfXcV/yY=
X-Google-Smtp-Source: ADFU+vvFzf0HliHEUvA8TEo/Z9hfCypSb6wpxoaWuBco1XNAeQ6xUF7140p6YEsKCRih8xmkkg82LA==
X-Received: by 2002:a17:90a:fa06:: with SMTP id cm6mr1822574pjb.109.1583306896569;
        Tue, 03 Mar 2020 23:28:16 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j38sm23435859pgi.51.2020.03.03.23.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 23:28:15 -0800 (PST)
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
Subject: [PATCH v6 1/7] clk: sprd: add gate for pll clocks
Date:   Wed,  4 Mar 2020 15:27:24 +0800
Message-Id: <20200304072730.9193-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304072730.9193-1-zhang.lyra@gmail.com>
References: <20200304072730.9193-1-zhang.lyra@gmail.com>
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

