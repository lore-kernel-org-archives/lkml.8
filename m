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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BA5C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31392073A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7RK30Fv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbgAJGKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 01:10:04 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39986 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgAJGKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 01:10:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id s21so436747plr.7;
        Thu, 09 Jan 2020 22:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HcHZ0x70/qK7NXMoSBHV+1QL/bUky1H1SggR4DxRjDU=;
        b=D7RK30FvUfeghmKG2IGulB2dH+/b3L1Rr7dX2XRc7FU4EW/YAkUNtU8S0ThjleER5Q
         NOdIQNBvKQtzDJcJkhd11yicwERDKw99vZH81xBKHsCNWl9skLwK2kwq7jX3d6e+mcxK
         AMmfsuaTaW+CIAIez12Rnaj2Or3jCDBuZbO/+Gjx48PunlQspO6YoXu4EcnUoCkt1dG2
         QARQwh/QtkRfaRuED3h8M5l7KvzXXSl11g4uxo2XBow73zRDOiHjTrpoZm9ZOqsPdO2U
         nyj+mWt/2Yb90uAwK1gKNrF9y2SdkJ02Z80wRrd52hw8tH8UDDVxBGSa9KooB1Qvb2Qg
         Al8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HcHZ0x70/qK7NXMoSBHV+1QL/bUky1H1SggR4DxRjDU=;
        b=TdzSWxCnJmW81yAxfhxxTmeKAfOfjEijcu+E/8CCQszU78PyhTqWxnJe4BOGm5/Lwz
         HhtcNyT1drUKzof+z0punEpzXh8UertOOLUScjtyo0sEr4bVdpRL2lWWsJIsYAY9+eEO
         Fj0MbtDKeEUZapgUdAz35bofPv8oPwbBRAfAQBFv78CUeaY/Rc5ZcNOBDpd65b1pn+oH
         L6tPcu+trq9oUAdOJ4i3TusjyWxXCUUjh6wl7YEVARLlREBsocPGlARw4p9EaFlC7hJy
         sT79jAlqVud8xUByjauejVzy2S8hERoH4P89o92s0HQxU3ieXgt8hYcm2F2NtjBq2vGS
         JeNQ==
X-Gm-Message-State: APjAAAU3ZYn1N7e1rzgm/fhsa9PZQqvYYjcDMZbeERZ8rJop0vPQeiW8
        zho8KH9viObj9514QtWT5lY=
X-Google-Smtp-Source: APXvYqyJGNwGBvdJ7Cce+/l3DRiqZojnE1CAuKzcXpHu3GpkFgcwpTqpRUNpG+uCO3S64QO/QMPGcA==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr2289196plp.91.1578636603579;
        Thu, 09 Jan 2020 22:10:03 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y76sm1195814pfc.87.2020.01.09.22.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 22:10:02 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Xiaolong Zhang <xiaolong.zhang@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v3 1/7] clk: sprd: add gate for pll clocks
Date:   Fri, 10 Jan 2020 14:09:12 +0800
Message-Id: <20200110060918.18416-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110060918.18416-1-zhang.lyra@gmail.com>
References: <20200110060918.18416-1-zhang.lyra@gmail.com>
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

