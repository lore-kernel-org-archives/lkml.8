Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B8CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A8D21707
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgGBV3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:29:03 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:35850 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbgGBV26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:28:58 -0400
Received: from [88.147.89.201] (port=34632 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jr6lK-000AXd-Lc; Thu, 02 Jul 2020 23:28:54 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-clk@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH 2/5] clk: vc5: use a dedicated struct to describe the output drivers
Date:   Thu,  2 Jul 2020 23:28:33 +0200
Message-Id: <20200702212837.10657-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702212837.10657-1-luca@lucaceresoli.net>
References: <20200702212837.10657-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reusing the generic struct vc5_hw_data for all blocks is handy. However
it implies we allocate space the div_int and div_frc fields even for
the output drivers where they are unused. Moreover a follow-up commit
will add a new field needed only for output drivers, thus the memory
waste would increase.

Use a dedicated struct for the output drivers so that each block uses
exactly the fields it needs, not more.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/clk/clk-versaclock5.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index fa96659f8023..60c7cf9acde3 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -145,6 +145,12 @@ struct vc5_hw_data {
 	unsigned int		num;
 };
 
+struct vc5_out_data {
+	struct clk_hw		hw;
+	struct vc5_driver_data	*vc5;
+	unsigned int		num;
+};
+
 struct vc5_driver_data {
 	struct i2c_client	*client;
 	struct regmap		*regmap;
@@ -158,7 +164,7 @@ struct vc5_driver_data {
 	struct clk_hw		clk_pfd;
 	struct vc5_hw_data	clk_pll;
 	struct vc5_hw_data	clk_fod[VC5_MAX_FOD_NUM];
-	struct vc5_hw_data	clk_out[VC5_MAX_CLK_OUT_NUM];
+	struct vc5_out_data	clk_out[VC5_MAX_CLK_OUT_NUM];
 };
 
 static const char * const vc5_mux_names[] = {
@@ -565,7 +571,7 @@ static const struct clk_ops vc5_fod_ops = {
 
 static int vc5_clk_out_prepare(struct clk_hw *hw)
 {
-	struct vc5_hw_data *hwdata = container_of(hw, struct vc5_hw_data, hw);
+	struct vc5_out_data *hwdata = container_of(hw, struct vc5_out_data, hw);
 	struct vc5_driver_data *vc5 = hwdata->vc5;
 	const u8 mask = VC5_OUT_DIV_CONTROL_SELB_NORM |
 			VC5_OUT_DIV_CONTROL_SEL_EXT |
@@ -596,7 +602,7 @@ static int vc5_clk_out_prepare(struct clk_hw *hw)
 
 static void vc5_clk_out_unprepare(struct clk_hw *hw)
 {
-	struct vc5_hw_data *hwdata = container_of(hw, struct vc5_hw_data, hw);
+	struct vc5_out_data *hwdata = container_of(hw, struct vc5_out_data, hw);
 	struct vc5_driver_data *vc5 = hwdata->vc5;
 
 	/* Disable the clock buffer */
@@ -606,7 +612,7 @@ static void vc5_clk_out_unprepare(struct clk_hw *hw)
 
 static unsigned char vc5_clk_out_get_parent(struct clk_hw *hw)
 {
-	struct vc5_hw_data *hwdata = container_of(hw, struct vc5_hw_data, hw);
+	struct vc5_out_data *hwdata = container_of(hw, struct vc5_out_data, hw);
 	struct vc5_driver_data *vc5 = hwdata->vc5;
 	const u8 mask = VC5_OUT_DIV_CONTROL_SELB_NORM |
 			VC5_OUT_DIV_CONTROL_SEL_EXT |
@@ -636,7 +642,7 @@ static unsigned char vc5_clk_out_get_parent(struct clk_hw *hw)
 
 static int vc5_clk_out_set_parent(struct clk_hw *hw, u8 index)
 {
-	struct vc5_hw_data *hwdata = container_of(hw, struct vc5_hw_data, hw);
+	struct vc5_out_data *hwdata = container_of(hw, struct vc5_out_data, hw);
 	struct vc5_driver_data *vc5 = hwdata->vc5;
 	const u8 mask = VC5_OUT_DIV_CONTROL_RESET |
 			VC5_OUT_DIV_CONTROL_SELB_NORM |
-- 
2.27.0

