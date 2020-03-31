Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6045C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D3C2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbgCaVq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:46:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50416 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbgCaVqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:46:24 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 015C3297173
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     mark.rutland@arm.com, ck.hu@mediatek.com, sboyd@kernel.org,
        ulrich.hecht+renesas@gmail.com
Cc:     matthias.bgg@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-clk@vger.kernel.org, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        linux-mediatek@lists.infradead.org,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 3/4] clk / soc: mediatek: Bind clock and gpu driver for mt2701
Date:   Tue, 31 Mar 2020 23:46:08 +0200
Message-Id: <20200331214609.1742152-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200331214609.1742152-1-enric.balletbo@collabora.com>
References: <20200331214609.1742152-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the mmsys driver is the top-level entry point for the
multimedia subsystem, we could bind the clock and the gpu driver on
those devices that is expected to work, so the drm driver is
intantiated by the mmsys driver and display, hopefully, working again.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
If you have this hardware, please kindly provide your tested tag. Only
build tested.

 drivers/clk/mediatek/clk-mt2701-mm.c | 8 ++------
 drivers/soc/mediatek/mtk-mmsys.c     | 8 ++++++++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-mm.c b/drivers/clk/mediatek/clk-mt2701-mm.c
index 054b597d4a73..3a4e895a3d0f 100644
--- a/drivers/clk/mediatek/clk-mt2701-mm.c
+++ b/drivers/clk/mediatek/clk-mt2701-mm.c
@@ -79,16 +79,12 @@ static const struct mtk_gate mm_clks[] = {
 	GATE_DISP1(CLK_MM_TVE_FMM, "mm_tve_fmm", "mm_sel", 14),
 };
 
-static const struct of_device_id of_match_clk_mt2701_mm[] = {
-	{ .compatible = "mediatek,mt2701-mmsys", },
-	{}
-};
-
 static int clk_mt2701_mm_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->parent->of_node;
 	struct clk_onecell_data *clk_data;
 	int r;
-	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR);
 
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index c7d3b7bcfa32..cacafe23c823 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -80,6 +80,10 @@ struct mtk_mmsys_driver_data {
 	const char *clk_driver;
 };
 
+static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
+	.clk_driver = "clk-mt2701-mm",
+};
+
 static const struct mtk_mmsys_driver_data mt2712_mmsys_driver_data = {
 	.clk_driver = "clk-mt2712-mm",
 };
@@ -323,6 +327,10 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id of_match_mtk_mmsys[] = {
+	{
+		.compatible = "mediatek,mt2701-mmsys",
+		.data = &mt2701_mmsys_driver_data,
+	},
 	{
 		.compatible = "mediatek,mt2712-mmsys",
 		.data = &mt2712_mmsys_driver_data,
-- 
2.25.1

