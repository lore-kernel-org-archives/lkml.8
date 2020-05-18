Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47AEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEBDD20809
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589801529;
	bh=/Pkmjq+5ukSwok7Q7uIT9FHmblCVRx0IEIFAGu4D80g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FIPU+bDjV2SYt6bsxP5+3H2fWsFVOsEYFMNHiiupw5okmfvDzYxkil2dWnGgg70m9
	 k0RGth9eUI+zIJ7pR+H0IaY3QzlFbZ5Ms21eqaPmYjYPYDvuHgW8B28/ip220oeQZA
	 7ZxiXXLQ3rosK3ZtMn6ouzK3mJl9bcgJ8EJAtTvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgERLcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:32:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbgERLcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:32:07 -0400
Received: from ziggy.de (unknown [213.195.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0888D20758;
        Mon, 18 May 2020 11:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589801527;
        bh=/Pkmjq+5ukSwok7Q7uIT9FHmblCVRx0IEIFAGu4D80g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UxUdicTOkvSNLnspCrQwKP/zaWN6QVAsPpDWThaRKjTlbE4xFDWrKeWCZaCLPf9ZQ
         t4tG9qHyone9m+no43gSy/hOJd0TTRUZwiPgU8GbOJDOtzI4XvK2r9HDGFtL6p/j65
         03fLDStbvepbgx3WahXjkGsoCP5iM0H/uUjW5YHg=
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
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Richard Fontana <rfontana@redhat.com>
Subject: [PATCH 2/4] clk/soc: mediatek: mt6797: Bind clock driver from platform device
Date:   Mon, 18 May 2020 13:31:54 +0200
Message-Id: <20200518113156.25009-2-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518113156.25009-1-matthias.bgg@kernel.org>
References: <20200518113156.25009-1-matthias.bgg@kernel.org>
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

 drivers/clk/mediatek/clk-mt6797-mm.c | 9 ++-------
 drivers/soc/mediatek/mtk-mmsys.c     | 8 ++++++++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt6797-mm.c b/drivers/clk/mediatek/clk-mt6797-mm.c
index 8f05653b387d..01fdce287247 100644
--- a/drivers/clk/mediatek/clk-mt6797-mm.c
+++ b/drivers/clk/mediatek/clk-mt6797-mm.c
@@ -92,16 +92,12 @@ static const struct mtk_gate mm_clks[] = {
 		 "clk26m", 3),
 };
 
-static const struct of_device_id of_match_clk_mt6797_mm[] = {
-	{ .compatible = "mediatek,mt6797-mmsys", },
-	{}
-};
-
 static int clk_mt6797_mm_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->parent->of_node;
 	struct clk_onecell_data *clk_data;
 	int r;
-	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR);
 
@@ -121,7 +117,6 @@ static struct platform_driver clk_mt6797_mm_drv = {
 	.probe = clk_mt6797_mm_probe,
 	.driver = {
 		.name = "clk-mt6797-mm",
-		.of_match_table = of_match_clk_mt6797_mm,
 	},
 };
 
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 783c3dd008b2..fee64c8d3020 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -88,6 +88,10 @@ static const struct mtk_mmsys_driver_data mt2712_mmsys_driver_data = {
 	.clk_driver = "clk-mt2712-mm",
 };
 
+static const struct mtk_mmsys_driver_data mt6797_mmsys_driver_data = {
+	.clk_driver = "clk-mt6797-mm",
+};
+
 static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
 	.clk_driver = "clk-mt8173-mm",
 };
@@ -339,6 +343,10 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
 		.compatible = "mediatek,mt2712-mmsys",
 		.data = &mt2712_mmsys_driver_data,
 	},
+	{
+		.compatible = "mediatek,mt6797-mmsys",
+		.data = &mt6797_mmsys_driver_data,
+	},
 	{
 		.compatible = "mediatek,mt8173-mmsys",
 		.data = &mt8173_mmsys_driver_data,
-- 
2.26.2

