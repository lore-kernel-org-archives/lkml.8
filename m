Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295C1C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13D321481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbgIGPAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:00:52 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:19735 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730058AbgIGOzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:55:22 -0400
X-IronPort-AV: E=Sophos;i="5.76,402,1592838000"; 
   d="scan'208";a="56584263"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 07 Sep 2020 23:55:21 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id DA558400068C;
        Mon,  7 Sep 2020 23:55:19 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH] pinctrl: sh-pfc: r8a7790: Add VIN pins used by iwg21d-q7-dbcm-ca board
Date:   Mon,  7 Sep 2020 15:55:16 +0100
Message-Id: <20200907145516.12803-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vin[1,2] data8 and vin1_clk_b pins used by iwg21d-q7-dbcm-ca board
which is based on R8A7742 SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 38 +++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 60f973c5dffe..66697ea15a57 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -3866,6 +3866,18 @@ static const unsigned int vin1_data18_mux[] = {
 	VI1_R4_MARK, VI1_R5_MARK,
 	VI1_R6_MARK, VI1_R7_MARK,
 };
+static const unsigned int vin1_data8_b_pins[] = {
+	RCAR_GP_PIN(3, 0), RCAR_GP_PIN(3, 1),
+	RCAR_GP_PIN(3, 2), RCAR_GP_PIN(3, 3),
+	RCAR_GP_PIN(3, 4), RCAR_GP_PIN(3, 5),
+	RCAR_GP_PIN(3, 6), RCAR_GP_PIN(3, 7),
+};
+static const unsigned int vin1_data8_b_mux[] = {
+	VI1_DATA0_VI1_B0_B_MARK, VI1_DATA1_VI1_B1_B_MARK,
+	VI1_DATA2_VI1_B2_B_MARK, VI1_DATA3_VI1_B3_B_MARK,
+	VI1_DATA4_VI1_B4_B_MARK, VI1_DATA5_VI1_B5_B_MARK,
+	VI1_DATA6_VI1_B6_B_MARK, VI1_DATA7_VI1_B7_B_MARK,
+};
 static const unsigned int vin1_sync_pins[] = {
 	RCAR_GP_PIN(1, 24), /* HSYNC */
 	RCAR_GP_PIN(1, 25), /* VSYNC */
@@ -3886,6 +3898,12 @@ static const unsigned int vin1_clkenb_pins[] = {
 static const unsigned int vin1_clkenb_mux[] = {
 	VI1_CLKENB_MARK,
 };
+static const unsigned int vin1_clk_b_pins[] = {
+	RCAR_GP_PIN(3, 15),
+};
+static const unsigned int vin1_clk_b_mux[] = {
+	VI1_CLK_B_MARK,
+};
 static const unsigned int vin1_clk_pins[] = {
 	RCAR_GP_PIN(2, 9),
 };
@@ -3959,6 +3977,18 @@ static const unsigned int vin2_data18_mux[] = {
 	VI2_R4_MARK, VI2_R5_MARK,
 	VI2_R6_MARK, VI2_R7_MARK,
 };
+static const unsigned int vin2_data8_g_pins[] = {
+	RCAR_GP_PIN(0, 27), RCAR_GP_PIN(0, 28),
+	RCAR_GP_PIN(0, 29), RCAR_GP_PIN(1, 10),
+	RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 5),
+	RCAR_GP_PIN(1, 6), RCAR_GP_PIN(1, 7),
+};
+static const unsigned int vin2_data8_g_mux[] = {
+	VI2_G0_MARK, VI2_G1_MARK,
+	VI2_G2_MARK, VI2_G3_MARK,
+	VI2_G4_MARK, VI2_G5_MARK,
+	VI2_G6_MARK, VI2_G7_MARK,
+};
 static const unsigned int vin2_sync_pins[] = {
 	RCAR_GP_PIN(1, 16), /* HSYNC */
 	RCAR_GP_PIN(1, 21), /* VSYNC */
@@ -4026,7 +4056,7 @@ static const unsigned int vin3_clk_mux[] = {
 };
 
 static const struct {
-	struct sh_pfc_pin_group common[298];
+	struct sh_pfc_pin_group common[301];
 	struct sh_pfc_pin_group automotive[1];
 } pinmux_groups = {
 	.common = {
@@ -4310,15 +4340,18 @@ static const struct {
 		VIN_DATA_PIN_GROUP(vin1_data, 10),
 		VIN_DATA_PIN_GROUP(vin1_data, 8),
 		VIN_DATA_PIN_GROUP(vin1_data, 4),
+		SH_PFC_PIN_GROUP(vin1_data8_b),
 		SH_PFC_PIN_GROUP(vin1_sync),
 		SH_PFC_PIN_GROUP(vin1_field),
 		SH_PFC_PIN_GROUP(vin1_clkenb),
+		SH_PFC_PIN_GROUP(vin1_clk_b),
 		SH_PFC_PIN_GROUP(vin1_clk),
 		VIN_DATA_PIN_GROUP(vin2_data, 24),
 		SH_PFC_PIN_GROUP(vin2_data18),
 		VIN_DATA_PIN_GROUP(vin2_data, 16),
 		VIN_DATA_PIN_GROUP(vin2_data, 8),
 		VIN_DATA_PIN_GROUP(vin2_data, 4),
+		SH_PFC_PIN_GROUP(vin2_data8_g),
 		SH_PFC_PIN_GROUP(vin2_sync),
 		SH_PFC_PIN_GROUP(vin2_field),
 		SH_PFC_PIN_GROUP(vin2_clkenb),
@@ -4784,9 +4817,11 @@ static const char * const vin1_groups[] = {
 	"vin1_data10",
 	"vin1_data8",
 	"vin1_data4",
+	"vin1_data8_b",
 	"vin1_sync",
 	"vin1_field",
 	"vin1_clkenb",
+	"vin1_clk_b",
 	"vin1_clk",
 };
 
@@ -4796,6 +4831,7 @@ static const char * const vin2_groups[] = {
 	"vin2_data16",
 	"vin2_data8",
 	"vin2_data4",
+	"vin2_data8_g",
 	"vin2_sync",
 	"vin2_field",
 	"vin2_clkenb",
-- 
2.17.1

