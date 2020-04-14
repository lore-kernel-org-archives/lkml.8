Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B66C2BBFD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F7E120644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EY8JmNgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404788AbgDNDdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 23:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404768AbgDNDdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:33:39 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C10C0A3BDC;
        Mon, 13 Apr 2020 20:33:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id c138so5490617pfc.0;
        Mon, 13 Apr 2020 20:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uwxa46CvTM5ECW30BkNGZjhjXbVyQcR87+DO9oGqllg=;
        b=EY8JmNgmW7H9htEThBUa78x9wE3NotQ2DvieTb/jrPF75Lx6DvXjOk/UrKmGo3kW2e
         jEgX5BhdbFeuxbLfWkVOmQLUfv2V2YnDVEZffWIi6dzJvUR9ce6yzBilCf7+TW6+PVwQ
         BlHtku8pTz3r4zs9MfCPbiP4nmyqk/1QM4pWk4owXgK65LEQTESiNM9e3tJ+iBQh7GQN
         +W5abENv8FeC5Hr/eBUbx4Rouj0y9NHWKS1PxK+JbceKBEtLDUSuJuEPaTQKkenjQqkm
         PGdH5tw9h1ITt5Kpd3+K/E7Z3MjW+0TkAM+CD/NokEYiAqqxN2wgx/XhFa/3sVc3Oo5y
         2Viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uwxa46CvTM5ECW30BkNGZjhjXbVyQcR87+DO9oGqllg=;
        b=PD05dg0du7uM1qIZ813cxoYbmHuK4ZHaw2d0n67qUaNfLh9Zwd5tc7CSZTjZhF5cHP
         zFJDRWfXOIuPOfJm32Jkgo/322Oa25W9RVtcJH7SkNIvDV/f5DkM7lTpy4tR+cKnbMnm
         hHyPLkluhcAnRb3um5rKJAS5yb/gTqiVa+j9gfmNEQSitowDHe4uUeP1yx72pwVEN8C4
         AJfkwoMX3e1CWuMAfhhy512IuEZ6aGrc3MCLjcJygPRpWGk8zf8AiSrSflDm/ScCsDNC
         yhiD091VWn+wiglgnIzq+dZSeB9NrIJEFsernaohDsAATbk04FbczlxHecKdx8+nCb/6
         Wg3A==
X-Gm-Message-State: AGi0PuaRNmKoksxEr/MMT3YonU8pSCBXXRCve0JHxO7NBN4L0Tlv3aAz
        lBH1IYeaIyDnyViRBK/ZhLvPxk5YLmY=
X-Google-Smtp-Source: APiQypIQNfUxVZ0FUWV2rhTkaDY9U+2PR0qRypwfUt63vnffCAnKTW2eQnfwgrpDh5mj68nhUx0Zdg==
X-Received: by 2002:a63:1060:: with SMTP id 32mr21172267pgq.271.1586835217209;
        Mon, 13 Apr 2020 20:33:37 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 140sm5612440pge.49.2020.04.13.20.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 20:33:36 -0700 (PDT)
From:   zhang.lyra@gmail.com
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v2 1/4] clk: sprd: check its parent status before reading gate clock
Date:   Tue, 14 Apr 2020 11:33:22 +0800
Message-Id: <20200414033325.26536-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414033325.26536-1-zhang.lyra@gmail.com>
References: <20200414033325.26536-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Some clocks only can be accessed if their parent is enabled. mipi_csi_xx
clocks on SC9863A are an examples. We have to ensure the parent clock is
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
index b55817869367..e738dafa4fe9 100644
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
+#define SPRD_GATE_NON_AON BIT(3) /* not alway powered on, check before read */
+
 #define SPRD_SC_GATE_CLK_HW_INIT_FN(_struct, _name, _parent, _reg,	\
 				    _sc_offset, _enable_mask, _flags,	\
 				    _gate_flags, _udelay, _ops, _fn)	\
-- 
2.20.1

