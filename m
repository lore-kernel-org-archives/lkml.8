Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EECAC35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EC624649
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzzoWfYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgBQDYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:24:01 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35662 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgBQDX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:23:59 -0500
Received: by mail-pg1-f195.google.com with SMTP id v23so4906764pgk.2;
        Sun, 16 Feb 2020 19:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SLZU0K8o9V5gZR/jLBn7GXZGtbbt1olcAxrhy2XjOfk=;
        b=CzzoWfYRQ7+zmp+2zC+3P39ExaUpXtNLmG5o1GXXpV4PAc5sHnF/Xs2FScwi/jD+pC
         5mutXkJ1WS+lxslkPaqDhEib0sg+RU+xzbmPKBBDYGleYmTzUac4LmeHqqHPMu5zNIfS
         ywu4Zbc+YMP72wCKJcpSZiT7Y0WDfy7GiOVWQ+Cd35lgQqg1gMbfaEcLZYPYQKbJETiI
         ArECn+pzbcExVKYEL1mAdVBDZYLIA3GnSM9Uw/DzNGbuxfGaEn7v8phVrympX5PZww91
         7mLiCg35gV/klk7aYeL7RUko34aS3wAa9bWYm6TMHXIY8jOHTS8vwnxWTkLESB6Mdn3r
         5zhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SLZU0K8o9V5gZR/jLBn7GXZGtbbt1olcAxrhy2XjOfk=;
        b=R/rzwG6S0cTDyx7vNoV9zk13tGwHESdoMtuiEcO/pUC7FUcl4MSHhwu3z0nrJ2UZN3
         J+SEcbim9nX8aeYGzZMyn12albiu+nLSiEkBmYTFI4OZ+z5Em+LXW3BhY6zwGxfXmalB
         5cBlgvBqlPsK732cCl8mg2jTRnbavmvuuRouCDktM8ypnecTOitUiRyEhk1G5WsPaSZb
         rJUpvW1jbyFzdevDoeNDd7mnGni86Yk2SoRS0L56Yd4Xm6hqzHDVW/ioPI821oxtxL9R
         sJCWytOjA6NqtPEmQH53Nyd2dxvtqQ4pI0icbHPgbBAgoZpTqRGAdtXjrSd04Fu4nZ6T
         QJqQ==
X-Gm-Message-State: APjAAAV0P8jEQPSoG3wn4KhwvS9602LdGiIbLrVRtZ9LJO8FsBm1lrRV
        G6jjZIdjKFNp5hKcj6a6hUbR+HX0
X-Google-Smtp-Source: APXvYqx4aW6wl11fGmBkp1sencZIzVzKPDUBBNlWNszhnean0IQ2JM38/Rn7p47ol12vrckwZU27SQ==
X-Received: by 2002:aa7:8088:: with SMTP id v8mr15197813pff.142.1581909838663;
        Sun, 16 Feb 2020 19:23:58 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 76sm14644383pfx.97.2020.02.16.19.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 19:23:58 -0800 (PST)
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
Subject: [PATCH v4 5/7] clk: sprd: Add macros for referencing parents without strings
Date:   Mon, 17 Feb 2020 11:23:19 +0800
Message-Id: <20200217032321.15164-6-zhang.lyra@gmail.com>
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

With the new clk parenting code, clk_init_data was expanded to include
.parent_hws and .parent_data, for clk drivers to specify parents without
name strings of clocks.

Also some macros were added for using these two items to reference
clock parents. Based on that to expand macros for sprd clocks:

- SPRD_*_DATA, take an array of struct clk_parent_data * as its parents
  which should be a combination of .fw_name (devicetree clock-names),
  .hw (pointers to a local struct clk_hw).

- SPRD_*_HW, take a local struct clk_hw pointer, instead of a string, as
  its parent.

- SPRD_*_FW_NAME, take a string of clock-names decleared in the device
  tree as the clock parent.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/clk/sprd/composite.h |  39 +++++++++----
 drivers/clk/sprd/div.h       |  20 +++++--
 drivers/clk/sprd/gate.h      | 109 ++++++++++++++++++++++++++++++-----
 drivers/clk/sprd/mux.h       |  28 ++++++---
 drivers/clk/sprd/pll.h       |  55 ++++++++++++------
 5 files changed, 196 insertions(+), 55 deletions(-)

diff --git a/drivers/clk/sprd/composite.h b/drivers/clk/sprd/composite.h
index 04ab3f587ee2..adbabbe596b7 100644
--- a/drivers/clk/sprd/composite.h
+++ b/drivers/clk/sprd/composite.h
@@ -18,26 +18,43 @@ struct sprd_comp {
 	struct sprd_clk_common	common;
 };
 
-#define SPRD_COMP_CLK_TABLE(_struct, _name, _parent, _reg, _table,	\
-			_mshift, _mwidth, _dshift, _dwidth, _flags)	\
+#define SPRD_COMP_CLK_HW_INIT_FN(_struct, _name, _parent, _reg, _table,	\
+				 _mshift, _mwidth, _dshift, _dwidth,	\
+				 _flags, _fn)				\
 	struct sprd_comp _struct = {					\
 		.mux	= _SPRD_MUX_CLK(_mshift, _mwidth, _table),	\
 		.div	= _SPRD_DIV_CLK(_dshift, _dwidth),		\
 		.common = {						\
 			.regmap		= NULL,				\
 			.reg		= _reg,				\
-			.hw.init = CLK_HW_INIT_PARENTS(_name,		\
-						       _parent,		\
-						       &sprd_comp_ops,	\
-						       _flags),		\
+			.hw.init = _fn(_name, _parent,			\
+				       &sprd_comp_ops, _flags),		\
 			 }						\
 	}
 
-#define SPRD_COMP_CLK(_struct, _name, _parent, _reg, _mshift,	\
-			_mwidth, _dshift, _dwidth, _flags)	\
-	SPRD_COMP_CLK_TABLE(_struct, _name, _parent, _reg,	\
-			    NULL, _mshift, _mwidth,		\
-			    _dshift, _dwidth, _flags)
+#define SPRD_COMP_CLK_TABLE(_struct, _name, _parent, _reg, _table,	\
+			    _mshift, _mwidth, _dshift, _dwidth, _flags)	\
+	SPRD_COMP_CLK_HW_INIT_FN(_struct, _name, _parent, _reg, _table,	\
+				 _mshift, _mwidth, _dshift, _dwidth,	\
+				 _flags, CLK_HW_INIT_PARENTS)
+
+#define SPRD_COMP_CLK(_struct, _name, _parent, _reg, _mshift,		\
+		      _mwidth, _dshift, _dwidth, _flags)		\
+	SPRD_COMP_CLK_TABLE(_struct, _name, _parent, _reg, NULL,	\
+			    _mshift, _mwidth, _dshift, _dwidth, _flags)
+
+#define SPRD_COMP_CLK_DATA_TABLE(_struct, _name, _parent, _reg, _table,	\
+				 _mshift, _mwidth, _dshift,		\
+				 _dwidth, _flags)			\
+	SPRD_COMP_CLK_HW_INIT_FN(_struct, _name, _parent, _reg, _table,	\
+				 _mshift, _mwidth, _dshift, _dwidth,	\
+				 _flags, CLK_HW_INIT_PARENTS_DATA)
+
+#define SPRD_COMP_CLK_DATA(_struct, _name, _parent, _reg, _mshift,	\
+			   _mwidth, _dshift, _dwidth, _flags)		\
+	SPRD_COMP_CLK_DATA_TABLE(_struct, _name, _parent, _reg,	NULL,	\
+				 _mshift, _mwidth, _dshift, _dwidth,	\
+				 _flags)
 
 static inline struct sprd_comp *hw_to_sprd_comp(const struct clk_hw *hw)
 {
diff --git a/drivers/clk/sprd/div.h b/drivers/clk/sprd/div.h
index 87510e3d0e14..6acfe6b179fc 100644
--- a/drivers/clk/sprd/div.h
+++ b/drivers/clk/sprd/div.h
@@ -35,20 +35,28 @@ struct sprd_div {
 	struct sprd_clk_common	common;
 };
 
-#define SPRD_DIV_CLK(_struct, _name, _parent, _reg,			\
-			_shift, _width, _flags)				\
+#define SPRD_DIV_CLK_HW_INIT_FN(_struct, _name, _parent, _reg,		\
+				_shift, _width, _flags, _fn)		\
 	struct sprd_div _struct = {					\
 		.div	= _SPRD_DIV_CLK(_shift, _width),		\
 		.common	= {						\
 			.regmap		= NULL,				\
 			.reg		= _reg,				\
-			.hw.init	= CLK_HW_INIT(_name,		\
-						      _parent,		\
-						      &sprd_div_ops,	\
-						      _flags),		\
+			.hw.init	= _fn(_name, _parent,		\
+					      &sprd_div_ops, _flags),	\
 		}							\
 	}
 
+#define SPRD_DIV_CLK(_struct, _name, _parent, _reg,			\
+		     _shift, _width, _flags)				\
+	SPRD_DIV_CLK_HW_INIT_FN(_struct, _name, _parent, _reg,		\
+				_shift, _width, _flags, CLK_HW_INIT)
+
+#define SPRD_DIV_CLK_HW(_struct, _name, _parent, _reg,			\
+			_shift, _width, _flags)				\
+	SPRD_DIV_CLK_HW_INIT_FN(_struct, _name, _parent, _reg,		\
+				_shift, _width, _flags, CLK_HW_INIT_HW)
+
 static inline struct sprd_div *hw_to_sprd_div(const struct clk_hw *hw)
 {
 	struct sprd_clk_common *common = hw_to_sprd_clk_common(hw);
diff --git a/drivers/clk/sprd/gate.h b/drivers/clk/sprd/gate.h
index d380d77b8dce..b55817869367 100644
--- a/drivers/clk/sprd/gate.h
+++ b/drivers/clk/sprd/gate.h
@@ -19,9 +19,9 @@ struct sprd_gate {
 	struct sprd_clk_common	common;
 };
 
-#define SPRD_SC_GATE_CLK_OPS_UDELAY(_struct, _name, _parent, _reg,	\
+#define SPRD_SC_GATE_CLK_HW_INIT_FN(_struct, _name, _parent, _reg,	\
 				    _sc_offset, _enable_mask, _flags,	\
-				    _gate_flags, _udelay, _ops)		\
+				    _gate_flags, _udelay, _ops, _fn)	\
 	struct sprd_gate _struct = {					\
 		.enable_mask	= _enable_mask,				\
 		.sc_offset	= _sc_offset,				\
@@ -30,38 +30,121 @@ struct sprd_gate {
 		.common	= {						\
 			.regmap		= NULL,				\
 			.reg		= _reg,				\
-			.hw.init	= CLK_HW_INIT(_name,		\
-						      _parent,		\
-						      _ops,		\
-						      _flags),		\
+			.hw.init	= _fn(_name, _parent,		\
+					      _ops, _flags),		\
 		}							\
 	}
 
+#define SPRD_SC_GATE_CLK_OPS_UDELAY(_struct, _name, _parent, _reg,	\
+				    _sc_offset, _enable_mask, _flags,	\
+				    _gate_flags, _udelay, _ops)		\
+	SPRD_SC_GATE_CLK_HW_INIT_FN(_struct, _name, _parent, _reg,	\
+				    _sc_offset, _enable_mask, _flags,	\
+				    _gate_flags, _udelay, _ops, CLK_HW_INIT)
+
 #define SPRD_SC_GATE_CLK_OPS(_struct, _name, _parent, _reg, _sc_offset,	\
 			     _enable_mask, _flags, _gate_flags, _ops)	\
 	SPRD_SC_GATE_CLK_OPS_UDELAY(_struct, _name, _parent, _reg,	\
 				    _sc_offset, _enable_mask, _flags,	\
 				    _gate_flags, 0, _ops)
 
-#define SPRD_GATE_CLK(_struct, _name, _parent, _reg,			\
-		      _enable_mask, _flags, _gate_flags)		\
-	SPRD_SC_GATE_CLK_OPS(_struct, _name, _parent, _reg, 0,		\
-			     _enable_mask, _flags, _gate_flags,		\
-			     &sprd_gate_ops)
-
 #define SPRD_SC_GATE_CLK(_struct, _name, _parent, _reg, _sc_offset,	\
 			 _enable_mask, _flags, _gate_flags)		\
 	SPRD_SC_GATE_CLK_OPS(_struct, _name, _parent, _reg, _sc_offset,	\
 			     _enable_mask, _flags, _gate_flags,		\
 			     &sprd_sc_gate_ops)
 
+#define SPRD_GATE_CLK(_struct, _name, _parent, _reg,			\
+		      _enable_mask, _flags, _gate_flags)		\
+	SPRD_SC_GATE_CLK_OPS(_struct, _name, _parent, _reg, 0,		\
+			     _enable_mask, _flags, _gate_flags,		\
+			     &sprd_gate_ops)
+
 #define SPRD_PLL_SC_GATE_CLK(_struct, _name, _parent, _reg, _sc_offset,	\
-			    _enable_mask, _flags, _gate_flags, _udelay)	\
+			     _enable_mask, _flags, _gate_flags,		\
+			     _udelay)					\
 	SPRD_SC_GATE_CLK_OPS_UDELAY(_struct, _name, _parent, _reg,	\
 				    _sc_offset,	_enable_mask, _flags,	\
 				    _gate_flags, _udelay,		\
 				    &sprd_pll_sc_gate_ops)
 
+
+#define SPRD_SC_GATE_CLK_HW_OPS_UDELAY(_struct, _name, _parent, _reg,	\
+				       _sc_offset, _enable_mask,	\
+				       _flags, _gate_flags,		\
+				       _udelay, _ops)			\
+	SPRD_SC_GATE_CLK_HW_INIT_FN(_struct, _name, _parent, _reg,	\
+				    _sc_offset, _enable_mask, _flags,	\
+				    _gate_flags, _udelay, _ops,		\
+				    CLK_HW_INIT_HW)
+
+#define SPRD_SC_GATE_CLK_HW_OPS(_struct, _name, _parent, _reg,		\
+				_sc_offset, _enable_mask, _flags,	\
+				_gate_flags, _ops)			\
+	SPRD_SC_GATE_CLK_HW_OPS_UDELAY(_struct, _name, _parent, _reg,	\
+				       _sc_offset, _enable_mask,	\
+				       _flags, _gate_flags, 0, _ops)
+
+#define SPRD_SC_GATE_CLK_HW(_struct, _name, _parent, _reg,		\
+			    _sc_offset, _enable_mask, _flags,		\
+			    _gate_flags)				\
+	SPRD_SC_GATE_CLK_HW_OPS(_struct, _name, _parent, _reg,		\
+				_sc_offset, _enable_mask, _flags,	\
+				_gate_flags, &sprd_sc_gate_ops)
+
+#define SPRD_GATE_CLK_HW(_struct, _name, _parent, _reg,			\
+			 _enable_mask, _flags, _gate_flags)		\
+	SPRD_SC_GATE_CLK_HW_OPS(_struct, _name, _parent, _reg, 0,	\
+				_enable_mask, _flags, _gate_flags,	\
+				&sprd_gate_ops)
+
+#define SPRD_PLL_SC_GATE_CLK_HW(_struct, _name, _parent, _reg,		\
+				_sc_offset, _enable_mask, _flags,	\
+				_gate_flags, _udelay)			\
+	SPRD_SC_GATE_CLK_HW_OPS_UDELAY(_struct, _name, _parent, _reg,	\
+				       _sc_offset, _enable_mask,	\
+				       _flags, _gate_flags, _udelay,	\
+				       &sprd_pll_sc_gate_ops)
+
+#define SPRD_SC_GATE_CLK_FW_NAME_OPS_UDELAY(_struct, _name, _parent,	\
+					    _reg, _sc_offset,		\
+					    _enable_mask, _flags,	\
+					    _gate_flags, _udelay, _ops)	\
+	SPRD_SC_GATE_CLK_HW_INIT_FN(_struct, _name, _parent, _reg,	\
+				    _sc_offset, _enable_mask, _flags,	\
+				    _gate_flags, _udelay, _ops,		\
+				    CLK_HW_INIT_FW_NAME)
+
+#define SPRD_SC_GATE_CLK_FW_NAME_OPS(_struct, _name, _parent, _reg,	\
+				     _sc_offset, _enable_mask, _flags,	\
+				     _gate_flags, _ops)			\
+	SPRD_SC_GATE_CLK_FW_NAME_OPS_UDELAY(_struct, _name, _parent,	\
+					    _reg, _sc_offset,		\
+					    _enable_mask, _flags,	\
+					    _gate_flags, 0, _ops)
+
+#define SPRD_SC_GATE_CLK_FW_NAME(_struct, _name, _parent, _reg,		\
+				 _sc_offset, _enable_mask, _flags,	\
+				 _gate_flags)				\
+	SPRD_SC_GATE_CLK_FW_NAME_OPS(_struct, _name, _parent, _reg,	\
+				     _sc_offset, _enable_mask, _flags,	\
+				     _gate_flags, &sprd_sc_gate_ops)
+
+#define SPRD_GATE_CLK_FW_NAME(_struct, _name, _parent, _reg,		\
+			      _enable_mask, _flags, _gate_flags)	\
+	SPRD_SC_GATE_CLK_FW_NAME_OPS(_struct, _name, _parent, _reg, 0,	\
+				     _enable_mask, _flags, _gate_flags,	\
+				     &sprd_gate_ops)
+
+#define SPRD_PLL_SC_GATE_CLK_FW_NAME(_struct, _name, _parent, _reg,	\
+				     _sc_offset, _enable_mask, _flags,	\
+				     _gate_flags, _udelay)		\
+	SPRD_SC_GATE_CLK_FW_NAME_OPS_UDELAY(_struct, _name, _parent,	\
+					    _reg, _sc_offset,		\
+					    _enable_mask, _flags,	\
+					    _gate_flags, _udelay,	\
+					    &sprd_pll_sc_gate_ops)
+
 static inline struct sprd_gate *hw_to_sprd_gate(const struct clk_hw *hw)
 {
 	struct sprd_clk_common *common = hw_to_sprd_clk_common(hw);
diff --git a/drivers/clk/sprd/mux.h b/drivers/clk/sprd/mux.h
index 892e4191cc7f..f3cc31dae06f 100644
--- a/drivers/clk/sprd/mux.h
+++ b/drivers/clk/sprd/mux.h
@@ -36,26 +36,40 @@ struct sprd_mux {
 		.table	= _table,			\
 	}
 
-#define SPRD_MUX_CLK_TABLE(_struct, _name, _parents, _table,		\
-				     _reg, _shift, _width,		\
-				     _flags)				\
+#define SPRD_MUX_CLK_HW_INIT_FN(_struct, _name, _parents, _table,	\
+				_reg, _shift, _width, _flags, _fn)	\
 	struct sprd_mux _struct = {					\
 		.mux	= _SPRD_MUX_CLK(_shift, _width, _table),	\
 		.common	= {						\
 			.regmap		= NULL,				\
 			.reg		= _reg,				\
-			.hw.init = CLK_HW_INIT_PARENTS(_name,		\
-						       _parents,	\
-						       &sprd_mux_ops,	\
-						       _flags),		\
+			.hw.init = _fn(_name, _parents,			\
+				       &sprd_mux_ops, _flags),		\
 		}							\
 	}
 
+#define SPRD_MUX_CLK_TABLE(_struct, _name, _parents, _table,		\
+			   _reg, _shift, _width, _flags)		\
+	SPRD_MUX_CLK_HW_INIT_FN(_struct, _name, _parents, _table,	\
+				_reg, _shift, _width, _flags,		\
+				CLK_HW_INIT_PARENTS)
+
 #define SPRD_MUX_CLK(_struct, _name, _parents, _reg,		\
 		     _shift, _width, _flags)			\
 	SPRD_MUX_CLK_TABLE(_struct, _name, _parents, NULL,	\
 			   _reg, _shift, _width, _flags)
 
+#define SPRD_MUX_CLK_DATA_TABLE(_struct, _name, _parents, _table,	\
+				_reg, _shift, _width, _flags)		\
+	SPRD_MUX_CLK_HW_INIT_FN(_struct, _name, _parents, _table,	\
+				_reg, _shift, _width, _flags,		\
+				CLK_HW_INIT_PARENTS_DATA)
+
+#define SPRD_MUX_CLK_DATA(_struct, _name, _parents, _reg,		\
+			  _shift, _width, _flags)			\
+	SPRD_MUX_CLK_DATA_TABLE(_struct, _name, _parents, NULL,		\
+				_reg, _shift, _width, _flags)
+
 static inline struct sprd_mux *hw_to_sprd_mux(const struct clk_hw *hw)
 {
 	struct sprd_clk_common *common = hw_to_sprd_clk_common(hw);
diff --git a/drivers/clk/sprd/pll.h b/drivers/clk/sprd/pll.h
index e95f11e91ffe..6558f50d0296 100644
--- a/drivers/clk/sprd/pll.h
+++ b/drivers/clk/sprd/pll.h
@@ -61,27 +61,33 @@ struct sprd_pll {
 	struct sprd_clk_common	common;
 };
 
+#define SPRD_PLL_HW_INIT_FN(_struct, _name, _parent, _reg,	\
+			    _regs_num, _itable, _factors,	\
+			    _udelay, _k1, _k2, _fflag,		\
+			    _fvco, _fn)				\
+	struct sprd_pll _struct = {				\
+		.regs_num	= _regs_num,			\
+		.itable		= _itable,			\
+		.factors	= _factors,			\
+		.udelay		= _udelay,			\
+		.k1		= _k1,				\
+		.k2		= _k2,				\
+		.fflag		= _fflag,			\
+		.fvco		= _fvco,			\
+		.common		= {				\
+			.regmap		= NULL,			\
+			.reg		= _reg,			\
+			.hw.init	= _fn(_name, _parent,	\
+					      &sprd_pll_ops, 0),\
+		},						\
+	}
+
 #define SPRD_PLL_WITH_ITABLE_K_FVCO(_struct, _name, _parent, _reg,	\
 				    _regs_num, _itable, _factors,	\
 				    _udelay, _k1, _k2, _fflag, _fvco)	\
-	struct sprd_pll _struct = {					\
-		.regs_num	= _regs_num,				\
-		.itable		= _itable,				\
-		.factors	= _factors,				\
-		.udelay		= _udelay,				\
-		.k1		= _k1,					\
-		.k2		= _k2,					\
-		.fflag		= _fflag,				\
-		.fvco		= _fvco,				\
-		.common		= {					\
-			.regmap		= NULL,				\
-			.reg		= _reg,				\
-			.hw.init	= CLK_HW_INIT(_name,		\
-						      _parent,		\
-						      &sprd_pll_ops,	\
-						      0),		\
-		},							\
-	}
+	SPRD_PLL_HW_INIT_FN(_struct, _name, _parent, _reg, _regs_num,	\
+			    _itable, _factors, _udelay, _k1, _k2,	\
+			    _fflag, _fvco, CLK_HW_INIT)
 
 #define SPRD_PLL_WITH_ITABLE_K(_struct, _name, _parent, _reg,		\
 			       _regs_num, _itable, _factors,		\
@@ -96,6 +102,19 @@ struct sprd_pll {
 				    _regs_num, _itable, _factors,	\
 				    _udelay, 1000, 1000, 0, 0)
 
+#define SPRD_PLL_FW_NAME(_struct, _name, _parent, _reg, _regs_num,	\
+			 _itable, _factors, _udelay, _k1, _k2,		\
+			 _fflag, _fvco)					\
+	SPRD_PLL_HW_INIT_FN(_struct, _name, _parent, _reg, _regs_num,	\
+			    _itable, _factors, _udelay, _k1, _k2,	\
+			    _fflag, _fvco, CLK_HW_INIT_FW_NAME)
+
+#define SPRD_PLL_HW(_struct, _name, _parent, _reg, _regs_num, _itable,	\
+		    _factors, _udelay, _k1, _k2, _fflag, _fvco)		\
+	SPRD_PLL_HW_INIT_FN(_struct, _name, _parent, _reg, _regs_num,	\
+			    _itable, _factors, _udelay, _k1, _k2,	\
+			    _fflag, _fvco, CLK_HW_INIT_HW)
+
 static inline struct sprd_pll *hw_to_sprd_pll(struct clk_hw *hw)
 {
 	struct sprd_clk_common *common = hw_to_sprd_clk_common(hw);
-- 
2.20.1

