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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F6FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BECC3207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUC+ktwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgE0FhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 01:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgE0FhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:37:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F251BC061A0F;
        Tue, 26 May 2020 22:37:08 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id m7so9733730plt.5;
        Tue, 26 May 2020 22:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cqkf7LycevmgLpVmZeBhW8pIulT8kk5Dc9E7315h7UE=;
        b=MUC+ktwXiZmTf+GNJYOcuArbLORoC4bO3Seb9eAiMiZiNcB4OH6xtny+LZIddrpyUO
         e7T9adWN134UIMYOMwA64KOWAzer6xMCAWSUn6bAeg/7RKofNjaVAtLx2ecAZ5XsrerW
         mBkecyDGJL0wztKLTWXMJ3dvDLYBZwIlBspQsUgGYTVCFcSfa8uglMJ7oszoDbTmXM3b
         lZ2jfO5C/JkDJ1K9S0g9NCoY5LgJ7vvSDaojNtXog9gNbEqEyZ90dNnlfyTj5xlMfcZ6
         DTzwLv5NyeltsWNX3RQMg/axB3GCl3jGo7qjZg8zNz71hv2ArFIOsI/PSdJSuI/sD22r
         1uIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cqkf7LycevmgLpVmZeBhW8pIulT8kk5Dc9E7315h7UE=;
        b=TTZCYDpl3QfsKXSpGJ3SDD8zKMh4EnST8X8lWQ1PXKp1+gfY6ItAlG8G2FFTUPSphV
         O7u8HzDKjzGCDoY7AC+Zq/IqKzXaNlComn8cA0YKRWVEwfloESGlvNQwmts89dRNXZvf
         /4d0bDICz79BuZVc2jgJq3FNwGkpsOaxzu3xzLVJPc2eUB14SBMG5gkuS4CawexMqqLA
         TV4rRpeFpM2tRwI4e9+8wgARpPWLhPFT98/xbKHaZbygSmsUtynBknpemp0G5UVwi3su
         OPZXaEruwoOhYgQIRAitRpTe/pWidSoaaBN0UkGE9bumkEpNZJELqzO/fueEQNqozcoC
         IaKg==
X-Gm-Message-State: AOAM5332bziG6v81hGOqNfsJpLiiW8wq/74KqTwagDwnkOYWoJcWtS5M
        mIfJWXKmb5QBExg/pQ+X4Jc=
X-Google-Smtp-Source: ABdhPJy8K1WVcQM1HCK6TVkGYFSMk0D4eOQMyBO8IUfUJoEQH8Ney49GrcU3NPF9ePs8Y2CRZsSwPQ==
X-Received: by 2002:a17:90b:a13:: with SMTP id gg19mr3070516pjb.49.1590557828509;
        Tue, 26 May 2020 22:37:08 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id r34sm1092406pgl.38.2020.05.26.22.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 22:37:07 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [RESEND PATCH v2 4/4] clk: sprd: add mipi_csi_xx gate clocks
Date:   Wed, 27 May 2020 13:36:38 +0800
Message-Id: <20200527053638.31439-5-zhang.lyra@gmail.com>
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

mipi_csi_xx clocks are used by camera sensors.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/clk/sprd/sc9863a-clk.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/clk/sprd/sc9863a-clk.c b/drivers/clk/sprd/sc9863a-clk.c
index a0631f7756cf..f67bd08f225c 100644
--- a/drivers/clk/sprd/sc9863a-clk.c
+++ b/drivers/clk/sprd/sc9863a-clk.c
@@ -1615,6 +1615,36 @@ static const struct sprd_clk_desc sc9863a_mm_gate_desc = {
 	.hw_clks	= &sc9863a_mm_gate_hws,
 };
 
+/* camera sensor clocks */
+static SPRD_GATE_CLK_HW(mipi_csi_clk, "mipi-csi-clk", &mahb_ckg_eb.common.hw,
+			0x20, BIT(16), 0, SPRD_GATE_NON_AON);
+static SPRD_GATE_CLK_HW(mipi_csi_s_clk, "mipi-csi-s-clk", &mahb_ckg_eb.common.hw,
+			0x24, BIT(16), 0, SPRD_GATE_NON_AON);
+static SPRD_GATE_CLK_HW(mipi_csi_m_clk, "mipi-csi-m-clk", &mahb_ckg_eb.common.hw,
+			0x28, BIT(16), 0, SPRD_GATE_NON_AON);
+
+static struct sprd_clk_common *sc9863a_mm_clk_clks[] = {
+	/* address base is 0x60900000 */
+	&mipi_csi_clk.common,
+	&mipi_csi_s_clk.common,
+	&mipi_csi_m_clk.common,
+};
+
+static struct clk_hw_onecell_data sc9863a_mm_clk_hws = {
+	.hws	= {
+		[CLK_MIPI_CSI]		= &mipi_csi_clk.common.hw,
+		[CLK_MIPI_CSI_S]	= &mipi_csi_s_clk.common.hw,
+		[CLK_MIPI_CSI_M]	= &mipi_csi_m_clk.common.hw,
+	},
+	.num	= CLK_MM_CLK_NUM,
+};
+
+static const struct sprd_clk_desc sc9863a_mm_clk_desc = {
+	.clk_clks	= sc9863a_mm_clk_clks,
+	.num_clk_clks	= ARRAY_SIZE(sc9863a_mm_clk_clks),
+	.hw_clks	= &sc9863a_mm_clk_hws,
+};
+
 static SPRD_SC_GATE_CLK_FW_NAME(sim0_eb,	"sim0-eb",	"ext-26m", 0x0,
 				0x1000, BIT(0), 0, 0);
 static SPRD_SC_GATE_CLK_FW_NAME(iis0_eb,	"iis0-eb",	"ext-26m", 0x0,
@@ -1737,6 +1767,8 @@ static const struct of_device_id sprd_sc9863a_clk_ids[] = {
 	  .data = &sc9863a_aonapb_gate_desc },
 	{ .compatible = "sprd,sc9863a-mm-gate",	/* 0x60800000 */
 	  .data = &sc9863a_mm_gate_desc },
+	{ .compatible = "sprd,sc9863a-mm-clk",	/* 0x60900000 */
+	  .data = &sc9863a_mm_clk_desc },
 	{ .compatible = "sprd,sc9863a-apapb-gate",	/* 0x71300000 */
 	  .data = &sc9863a_apapb_gate_desc },
 	{ }
-- 
2.20.1

