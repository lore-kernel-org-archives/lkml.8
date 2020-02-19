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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40840C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF3A24655
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/5vGB1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgBSEKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 23:10:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35871 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgBSEKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 23:10:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id 185so11818316pfv.3;
        Tue, 18 Feb 2020 20:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HcHZ0x70/qK7NXMoSBHV+1QL/bUky1H1SggR4DxRjDU=;
        b=n/5vGB1w/mK+zOmoMLT8VzA2uMe09KGQembwgj653i3bCs9wpT4tFYmWQ/6YV4dVtW
         98/nX0yu2LoVTYwtsay2y72OnH+kFajxVMQIfAK90znYSUuNiOc8xrYRUVHUZ6nCu6T2
         mz1UirTYMCTwEEBYfuSSXfu/Y1uU3MYUPJf33cosKeZNVB4JuVAB265V/xM3wrMZB1f4
         +n4TRUWMJWBqPNBMuhMRjnHROkGRyZ7D+yYqma0gW4fyP13LW5yPwSGs4OX6HokXASy5
         iIXYXmy+4BNbk2WmExKDjXN7cI59JDwkMThc3lc6yCRxu4VpdQRLZLJKQIc3tC38Mra5
         pwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HcHZ0x70/qK7NXMoSBHV+1QL/bUky1H1SggR4DxRjDU=;
        b=m8FS/HuIuZor4QglA1Eexgy9oh3d6p4S0NPO8xs+mbr9mMhsPPklJFSM5BPll1Hphu
         k8V/fWoyPrbTilb/mtX2PwVPBej2w/Gnep8tRp+SlFeoeGgM2v5vJS2SaCQxTOs5sxMv
         X4Ay945XvLgbYy1c0XVCEwwotMtN+o71zCKvv27KNvMt/NpIaGm/HwOwKAG8Gry3ORiA
         CzMA3NXrjutFC8MXiSKnvXKTOisIIhkLx2SBRow7udo45Kp/MlgvrjnBu4kG4updVXGe
         QPJtwbOXKbAiOJW8zHPS2y1s1zvi9OHhaJUQAgl8T48bOIK8k7w4bAd0BqS1htT6GEj5
         xOtA==
X-Gm-Message-State: APjAAAWVXBkRvxkL2IWQKAqz4gJl36hK0cRkim8hT2Kd07LCZiKmzk5c
        2TqdUXYs/VVY8G8kDXgySco=
X-Google-Smtp-Source: APXvYqwJM+B7TF6k/dlhX50zKlju/QjZK91P5faZ02exUSelxFSEsGz57of9SBSFKed/Hd5mKDpHlw==
X-Received: by 2002:aa7:971c:: with SMTP id a28mr25164631pfg.152.1582085410670;
        Tue, 18 Feb 2020 20:10:10 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id q66sm578748pfq.27.2020.02.18.20.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 20:10:10 -0800 (PST)
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
Subject: [PATCH v5 1/7] clk: sprd: add gate for pll clocks
Date:   Wed, 19 Feb 2020 12:09:09 +0800
Message-Id: <20200219040915.2153-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200219040915.2153-1-zhang.lyra@gmail.com>
References: <20200219040915.2153-1-zhang.lyra@gmail.com>
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

