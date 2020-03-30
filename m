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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47899C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1723820781
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZL3JFXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgC3HQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:16:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35305 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729460AbgC3HQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 03:16:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id k5so6041755pga.2;
        Mon, 30 Mar 2020 00:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gcJfZUp4ynRYK76cXvZbCVqckHbyLVdV4ZyTuUAfMgw=;
        b=TZL3JFXiPGpYtlMni4teQYa0b9hmam1TZOnRqX2AhjSOrveUjcyMMyhYP7SEHeY31n
         K0gx/euv6jphTSmPqfGnjRSFjIdvXxPhUQ6SOKVDoZXi6MDtbXXCWOhPa0NCOZieJ2dm
         XO2Vfc/Zk35vB2pDlwhJNEOo0NSdjg+WoJgKO/jWaYXh/9oAhWCpgjLmXyRo+MeUbuBb
         vLRSaTHn5n422pD2nrWa7SQAFA7Y06Ev64G/0hAFuDAbRUQJ8Q+TJZxkLYMnXSnW8w+U
         D0tbVCYUjp73sp8a1mXwE1LN9bMJtHwHjEUhb4iaZuV6xQXJtpSiQWSuBJqXrfF4a+Xm
         JqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gcJfZUp4ynRYK76cXvZbCVqckHbyLVdV4ZyTuUAfMgw=;
        b=FAblaruxmZ9+ddsgqcJaud2ZtUyxFrakA1NEQ385eAxFQwB//P7VoMkEnSJHVp3PUe
         P/Z1la+WbmECkTTDQrcn+EgnwAMFTk/Egok+cRhbv+Z2Py1371+wvhIcFIzbUXuDqHNo
         arE3gl2altfPdnQvItgyDxVMJfnf2e5LpJH5JD8da2Upy5nb/wxNyJjkhjm9OqhFoHcy
         AP3cPmAk3giwmdVIxYY9/vZfJ/hJ4ubex4kERbYLHEzkin/F2awZ3WpJNYrTZTD5a8da
         huJ0oaOJ0AlDySD4RE/3nxPvjrPlJPcZbbZo8+x0BDvG1yYTIlwaF9ikGBbWw82pSci1
         RQxQ==
X-Gm-Message-State: AGi0Pua8wWo719eKGjiPVl85RoS4ibg4GiFRew9cuxl3wKXs/28ozcC1
        YK7mpABR+AD4UcP8c7ixAQedr4Ql
X-Google-Smtp-Source: APiQypL4b9Yt1C3OKYXQ85WYhYCwCkwrZ7hOQkmE+Ysqu7PDnWNX4HLoSA5p8CkcG0mTLVvmSKEYGg==
X-Received: by 2002:a62:870c:: with SMTP id i12mr4742503pfe.41.1585552568504;
        Mon, 30 Mar 2020 00:16:08 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id l1sm9490484pje.9.2020.03.30.00.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 00:16:07 -0700 (PDT)
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
Subject: [PATCH 4/4] clk: sprd: add mipi_csi_xx gate clocks
Date:   Mon, 30 Mar 2020 15:14:51 +0800
Message-Id: <20200330071451.7899-5-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200330071451.7899-1-zhang.lyra@gmail.com>
References: <20200330071451.7899-1-zhang.lyra@gmail.com>
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
index a0631f7756cf..24f064262814 100644
--- a/drivers/clk/sprd/sc9863a-clk.c
+++ b/drivers/clk/sprd/sc9863a-clk.c
@@ -1615,6 +1615,36 @@ static const struct sprd_clk_desc sc9863a_mm_gate_desc = {
 	.hw_clks	= &sc9863a_mm_gate_hws,
 };
 
+/* mm clocks */
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

