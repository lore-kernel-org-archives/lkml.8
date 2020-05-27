Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2500C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65CD207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aE6EHnMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgE0FhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 01:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgE0Fg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:36:59 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32281C061A0F;
        Tue, 26 May 2020 22:36:59 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x13so11324621pfn.11;
        Tue, 26 May 2020 22:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uwxa46CvTM5ECW30BkNGZjhjXbVyQcR87+DO9oGqllg=;
        b=aE6EHnMDX0JmXCER9fDCEscMHHLDDsA6R8dZthc158qDWpdhrVsngKgncts3+asDmM
         aoedTuUdhSySOOujiix+w+/hWay3IfsuGWPDpq0wDP5NIInlZY0y1ibj//519/cbkd4f
         ONncQAroZ/yjSExwCYRFnUpuf55InNb6KhQGKTGTOA9a2oQxRau2SnLPgkz6dz0E1bTj
         S7p234icghEOr7f9d2uhApNiw/4x6qrMp7HZWpYXkny2LNY93If1pzY4/qAOkDlY5/3F
         UizXy/Y9uwBkEdWdoTrIPZOIlipaEd9RaA6yjELdpqmYG+GYNZpj4o7FTNkeOqP5qUy/
         hQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uwxa46CvTM5ECW30BkNGZjhjXbVyQcR87+DO9oGqllg=;
        b=qnGenva9KYBdPOlR8WsCgViwIAUNzV5Yra+nfjV1T9V/VsDF6tbLNePHApu+Dn4d+6
         7kddEcNSvYUBSoCTiR3IUugexeGAmlpp5K6VRm1BpmKF9//ehBrRv1nXt+EFd1GLNzfg
         uLXoQjJTFg0k6X7JnhX4tv4b1Do065svbMRdYVtyaz4eiqByO9MhTdvywLrYI74IBEiK
         DnX2IscLvf/3lfsJSwZsNM//wgPJQBEpBZRUwB5s2fNafEzq1LmJ6pESrCxkbRmG3Pp3
         WUjnp2/or1g56rP3SRa0IyP6ArbaAbf/KSHDzzlYhhMfUsfWy7i+inOOEp2Vj3U4LvjO
         ueEQ==
X-Gm-Message-State: AOAM5333uiPewiBC7vHNvaRUeFL0G1pVd4VLQydwP5CYnRxNrSaJOQ7z
        70dEq7PSEazKiC6eWTr0/+4=
X-Google-Smtp-Source: ABdhPJxqytUB8SfBGZSchfvYEIX2fWnykNTsva1POvkE4JkhGNDXruBrvH15uiFtHv26S0jwqUBfXQ==
X-Received: by 2002:a63:214d:: with SMTP id s13mr2233129pgm.277.1590557818829;
        Tue, 26 May 2020 22:36:58 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id r34sm1092406pgl.38.2020.05.26.22.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 22:36:58 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [RESEND PATCH v2 1/4] clk: sprd: check its parent status before reading gate clock
Date:   Wed, 27 May 2020 13:36:35 +0800
Message-Id: <20200527053638.31439-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527053638.31439-1-zhang.lyra@gmail.com>
References: <20200527053638.31439-1-zhang.lyra@gmail.com>
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

