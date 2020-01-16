Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6148C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA0E207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193299;
	bh=waNVBhksyA0mkdyrEbwbIzA9lgS4ZemC8XaZvfRZVvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RnORD1oADS6AMd11b8P+yuEXudTiUfHnkxO/KS8AN9iStceZ0JhHKxvAC39tFAXV7
	 MXAXQMKYMM5JkR2SrRz5urBF4/2i7nzHyljygblYNwDr/L0qxq2Mqfjq97M/VLCsZ4
	 GVGpGeOn/ptoNOvvu7L4VdMsr/NBJljRO4HiDPbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgAPQsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:48:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:58420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729179AbgAPQsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:48:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9200B20663;
        Thu, 16 Jan 2020 16:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193295;
        bh=waNVBhksyA0mkdyrEbwbIzA9lgS4ZemC8XaZvfRZVvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vK8wcv5fslg2MCjEAi2BvW3XOTzKVtz9C6ocDvxK7Ioj4+kEvIt8uSPPhKgT+AK+o
         mV7OvzGL+JkeQIlopiJ0/y1yAaZ2w+lZl5fGJ71di8J2bblT8ZmjimJWeEyMOo8gqD
         R484xmrCC4/kZOVGzl2qcD0jHj2G5RRXCNFx2lb0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 068/205] clk: imx7ulp: Correct DDR clock mux options
Date:   Thu, 16 Jan 2020 11:40:43 -0500
Message-Id: <20200116164300.6705-68-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

[ Upstream commit 2e2b928a04bd74ea410da72bd60e1c5b06398276 ]

In the latest reference manual Rev.0,06/2019, the DDR clock mux
is extended to 2 bits, and the clock options are also changed,
correct them accordingly.

Fixes: b1260067ac3d ("clk: imx: add imx7ulp clk driver")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx7ulp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index d2c49fbd0563..04a3ae979281 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -25,7 +25,7 @@ static const char * const spll_sels[]		= { "spll", "spll_pfd_sel", };
 static const char * const apll_pfd_sels[]	= { "apll_pfd0", "apll_pfd1", "apll_pfd2", "apll_pfd3", };
 static const char * const apll_sels[]		= { "apll", "apll_pfd_sel", };
 static const char * const scs_sels[]		= { "dummy", "sosc", "sirc", "firc", "dummy", "apll_sel", "spll_sel", "dummy", };
-static const char * const ddr_sels[]		= { "apll_pfd_sel", "upll", };
+static const char * const ddr_sels[]		= { "apll_pfd_sel", "dummy", "dummy", "dummy", };
 static const char * const nic_sels[]		= { "firc", "ddr_clk", };
 static const char * const periph_plat_sels[]	= { "dummy", "nic1_bus_clk", "nic1_clk", "ddr_clk", "apll_pfd2", "apll_pfd1", "apll_pfd0", "upll", };
 static const char * const periph_bus_sels[]	= { "dummy", "sosc_bus_clk", "mpll", "firc_bus_clk", "rosc", "nic1_bus_clk", "nic1_clk", "spll_bus_clk", };
@@ -119,7 +119,7 @@ static void __init imx7ulp_clk_scg1_init(struct device_node *np)
 	clks[IMX7ULP_CLK_SYS_SEL]	= imx_clk_hw_mux2("scs_sel", base + 0x14, 24, 4, scs_sels, ARRAY_SIZE(scs_sels));
 	clks[IMX7ULP_CLK_HSRUN_SYS_SEL] = imx_clk_hw_mux2("hsrun_scs_sel", base + 0x1c, 24, 4, scs_sels, ARRAY_SIZE(scs_sels));
 	clks[IMX7ULP_CLK_NIC_SEL]	= imx_clk_hw_mux2("nic_sel", base + 0x40, 28, 1, nic_sels, ARRAY_SIZE(nic_sels));
-	clks[IMX7ULP_CLK_DDR_SEL]	= imx_clk_hw_mux_flags("ddr_sel", base + 0x30, 24, 1, ddr_sels, ARRAY_SIZE(ddr_sels), CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
+	clks[IMX7ULP_CLK_DDR_SEL]	= imx_clk_hw_mux_flags("ddr_sel", base + 0x30, 24, 2, ddr_sels, ARRAY_SIZE(ddr_sels), CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
 
 	clks[IMX7ULP_CLK_CORE_DIV]	= imx_clk_hw_divider_flags("divcore",	"scs_sel",  base + 0x14, 16, 4, CLK_SET_RATE_PARENT);
 	clks[IMX7ULP_CLK_HSRUN_CORE_DIV] = imx_clk_hw_divider_flags("hsrun_divcore", "hsrun_scs_sel", base + 0x1c, 16, 4, CLK_SET_RATE_PARENT);
-- 
2.20.1

