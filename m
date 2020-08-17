Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73739C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48FE7205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597677186;
	bh=w2+enJFouBsFUVObLi7FC01Ch0U8RkRLzoUBOYBMdX8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=irE1TZnX1mptF1ag1dwhluBZJOH6Vaj6WHHSmXHpAdwGh9EleisJzTrVEjKMr05yq
	 2R9ZiiuzdoliwKgO0CAi0JbtOxOoyvhvR9VH7yN7W/ojI8RMn9oKS9DFpEz5wkeqIh
	 pcCrofPkYL8fBL+i3wxf210l9TjAStKf7b1UYwEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgHQPNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:13:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgHQPNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:13:04 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F25552054F;
        Mon, 17 Aug 2020 15:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677183;
        bh=w2+enJFouBsFUVObLi7FC01Ch0U8RkRLzoUBOYBMdX8=;
        h=From:To:Cc:Subject:Date:From;
        b=ArtbqySg4ioFTkukPMpYffClJ1lADZAlRkRsJdoA+y8hZt7nCNnRK0DvlDXXHNle7
         NolvE2Yl4NgbHgk9iRNTvcPKVyu03Ogc4YOsfYMntugwj5at4Rk+sYsQDHORthO6B6
         GdYBwaf+gZhvYDJgblu/Kxd+2PoakVIEJFEeOifQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] clk: imx: vf610: Add CRC clock
Date:   Mon, 17 Aug 2020 17:12:54 +0200
Message-Id: <20200817151254.11466-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock for CRC block allowing it to be enabled by consumers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/imx/clk-vf610.c             | 1 +
 include/dt-bindings/clock/vf610-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
index 5129ef8e1d6e..0166ad0b9eb8 100644
--- a/drivers/clk/imx/clk-vf610.c
+++ b/drivers/clk/imx/clk-vf610.c
@@ -328,6 +328,7 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	clk[VF610_CLK_DSPI2] = imx_clk_gate2("dspi2", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(12));
 	clk[VF610_CLK_DSPI3] = imx_clk_gate2("dspi3", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(13));
 
+	clk[VF610_CLK_CRC] = imx_clk_gate2("crc", "ipg_bus", CCM_CCGR1, CCM_CCGRx_CGn(3));
 	clk[VF610_CLK_WDT] = imx_clk_gate2("wdt", "ipg_bus", CCM_CCGR1, CCM_CCGRx_CGn(14));
 
 	clk[VF610_CLK_ESDHC0_SEL] = imx_clk_mux("esdhc0_sel", CCM_CSCMR1, 16, 2, esdhc_sels, 4);
diff --git a/include/dt-bindings/clock/vf610-clock.h b/include/dt-bindings/clock/vf610-clock.h
index 0f2d60e884dc..373644e46747 100644
--- a/include/dt-bindings/clock/vf610-clock.h
+++ b/include/dt-bindings/clock/vf610-clock.h
@@ -196,6 +196,7 @@
 #define VF610_CLK_TCON0			187
 #define VF610_CLK_TCON1			188
 #define VF610_CLK_CAAM			189
-#define VF610_CLK_END			190
+#define VF610_CLK_CRC			190
+#define VF610_CLK_END			191
 
 #endif /* __DT_BINDINGS_CLOCK_VF610_H */
-- 
2.17.1

