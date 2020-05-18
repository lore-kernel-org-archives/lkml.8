Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1186DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1949207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589801524;
	bh=W0M3+xyBaxTwy0zGdlE42RieIIyYlAiumGMejijFZ2I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=oUDKQQ+LvANjmnXtuQnOQEQVUm7Fl3gLVQMRZjqkITtfTxJwWPLDfLunVYPFnV0bH
	 QH0wR/w87l+uxt3hIu4EW/KnlkkbhmeCNybKZ93otrLn3uWMKymBogaycHpPrgSGGW
	 cSlb1hCQm4lsYP+Hy6DUAveUvdOvOyQ/Z0DOi2fo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgERLcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:32:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbgERLcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:32:04 -0400
Received: from ziggy.de (unknown [213.195.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9936A20756;
        Mon, 18 May 2020 11:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589801523;
        bh=W0M3+xyBaxTwy0zGdlE42RieIIyYlAiumGMejijFZ2I=;
        h=From:To:Cc:Subject:Date:From;
        b=TynRGxKUPnxFsPmEYL3HOL/z2OfQVadUTlvUnVKJ8E56OBT2YuMv1hOBp473Q0k7a
         J1QOKpN/69wMSHM2YE+db2r4LnL6LA25krgG079T5vpB5iIMmI5KPzhxB+E82c78a0
         PL/7RlGRJWspBIzeAQf5Sc3W5X5ofFXsFHdhOPhU=
From:   matthias.bgg@kernel.org
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     mtk01761 <wendell.lin@mediatek.com>, devicetree@vger.kernel.org,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-mediatek@lists.infradead.org,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] clk/soc: mediatek: mt8183: Bind clock driver from platform device
Date:   Mon, 18 May 2020 13:31:53 +0200
Message-Id: <20200518113156.25009-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

The mmsys driver is now the top level entry point for the multimedia
system (mmsys), we bind the clock driver by creating a platform device.
We also bind the MediaTek DRM driver which is not yet implement and
therefor will errror out for now.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---

 drivers/clk/mediatek/clk-mt8183-mm.c | 9 ++-------
 drivers/soc/mediatek/mtk-mmsys.c     | 8 ++++++++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183-mm.c b/drivers/clk/mediatek/clk-mt8183-mm.c
index 720c696b506d..9d60e09619c1 100644
--- a/drivers/clk/mediatek/clk-mt8183-mm.c
+++ b/drivers/clk/mediatek/clk-mt8183-mm.c
@@ -84,8 +84,9 @@ static const struct mtk_gate mm_clks[] = {
 
 static int clk_mt8183_mm_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->parent->of_node;
 	struct clk_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
@@ -95,16 +96,10 @@ static int clk_mt8183_mm_probe(struct platform_device *pdev)
 	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 }
 
-static const struct of_device_id of_match_clk_mt8183_mm[] = {
-	{ .compatible = "mediatek,mt8183-mmsys", },
-	{}
-};
-
 static struct platform_driver clk_mt8183_mm_drv = {
 	.probe = clk_mt8183_mm_probe,
 	.driver = {
 		.name = "clk-mt8183-mm",
-		.of_match_table = of_match_clk_mt8183_mm,
 	},
 };
 
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index cacafe23c823..783c3dd008b2 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -92,6 +92,10 @@ static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
 	.clk_driver = "clk-mt8173-mm",
 };
 
+static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
+	.clk_driver = "clk-mt8183-mm",
+};
+
 static unsigned int mtk_mmsys_ddp_mout_en(enum mtk_ddp_comp_id cur,
 					  enum mtk_ddp_comp_id next,
 					  unsigned int *addr)
@@ -339,6 +343,10 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
 		.compatible = "mediatek,mt8173-mmsys",
 		.data = &mt8173_mmsys_driver_data,
 	},
+	{
+		.compatible = "mediatek,mt8183-mmsys",
+		.data = &mt8183_mmsys_driver_data,
+	},
 	{ }
 };
 
-- 
2.26.2

