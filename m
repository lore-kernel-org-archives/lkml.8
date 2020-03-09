Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E276C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA13120873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgCIUxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:53:34 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:57979 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgCIUxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:53:34 -0400
Received: from localhost (unknown [82.66.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 44922240003;
        Mon,  9 Mar 2020 20:53:29 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 1/2] clk: meson: axg: Remove MIPI enable clock gate
Date:   Mon,  9 Mar 2020 22:01:56 +0100
Message-Id: <20200309210157.29860-2-repk@triplefau.lt>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200309210157.29860-1-repk@triplefau.lt>
References: <20200309210157.29860-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AXG platforms HHI_MIPI_CNTL0 is part of the MIPI/PCIe analog PHY
region and is not related to clock one and can be removed from it.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 drivers/clk/meson/axg.c | 3 ---
 drivers/clk/meson/axg.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 13fc0006f63d..870e90a863fa 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -1141,7 +1141,6 @@ static MESON_GATE(axg_mmc_pclk, HHI_GCLK_MPEG2, 11);
 static MESON_GATE(axg_vpu_intr, HHI_GCLK_MPEG2, 25);
 static MESON_GATE(axg_sec_ahb_ahb3_bridge, HHI_GCLK_MPEG2, 26);
 static MESON_GATE(axg_gic, HHI_GCLK_MPEG2, 30);
-static MESON_GATE(axg_mipi_enable, HHI_MIPI_CNTL0, 29);
 
 /* Always On (AO) domain gates */
 
@@ -1236,7 +1235,6 @@ static struct clk_hw_onecell_data axg_hw_onecell_data = {
 		[CLKID_PCIE_REF]		= &axg_pcie_ref.hw,
 		[CLKID_PCIE_CML_EN0]		= &axg_pcie_cml_en0.hw,
 		[CLKID_PCIE_CML_EN1]		= &axg_pcie_cml_en1.hw,
-		[CLKID_MIPI_ENABLE]		= &axg_mipi_enable.hw,
 		[CLKID_GEN_CLK_SEL]		= &axg_gen_clk_sel.hw,
 		[CLKID_GEN_CLK_DIV]		= &axg_gen_clk_div.hw,
 		[CLKID_GEN_CLK]			= &axg_gen_clk.hw,
@@ -1331,7 +1329,6 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
 	&axg_pcie_ref,
 	&axg_pcie_cml_en0,
 	&axg_pcie_cml_en1,
-	&axg_mipi_enable,
 	&axg_gen_clk_sel,
 	&axg_gen_clk_div,
 	&axg_gen_clk,
diff --git a/drivers/clk/meson/axg.h b/drivers/clk/meson/axg.h
index 0431dabac629..fafe31739d0d 100644
--- a/drivers/clk/meson/axg.h
+++ b/drivers/clk/meson/axg.h
@@ -16,7 +16,6 @@
  * Register offsets from the data sheet must be multiplied by 4 before
  * adding them to the base address to get the right value.
  */
-#define HHI_MIPI_CNTL0			0x00
 #define HHI_GP0_PLL_CNTL		0x40
 #define HHI_GP0_PLL_CNTL2		0x44
 #define HHI_GP0_PLL_CNTL3		0x48
-- 
2.25.0

