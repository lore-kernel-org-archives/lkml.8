Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF82C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0E72082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgBJW2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:28:30 -0500
Received: from mailoutvs63.siol.net ([185.57.226.254]:33723 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727570AbgBJW22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:28:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id AE9075222EE;
        Mon, 10 Feb 2020 23:28:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wim-yzsP0gfc; Mon, 10 Feb 2020 23:28:24 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 4ACD0522286;
        Mon, 10 Feb 2020 23:28:24 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id E050C5222EE;
        Mon, 10 Feb 2020 23:28:21 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, icenowy@aosc.io,
        jernej.skrabec@siol.net, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] clk: sunxi-ng: sun8i-de2: Add rotation core clocks and reset for A64
Date:   Mon, 10 Feb 2020 23:28:03 +0100
Message-Id: <20200210222807.206426-4-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210222807.206426-1-jernej.skrabec@siol.net>
References: <20200210222807.206426-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A64 has rotation core which needs clocks and reset. Add them.

Fixes: cf4881c12935 "clk: sunxi-ng: fix the A64/H5 clock description of D=
E2 CCU"
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 45 ++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/=
ccu-sun8i-de2.c
index f449c22e59e8..2636a416a6f1 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -90,6 +90,24 @@ static struct ccu_common *sun8i_v3s_de2_clks[] =3D {
 	&wb_div_clk.common,
 };
=20
+static struct ccu_common *sun50i_a64_de2_clks[] =3D {
+	&mixer0_clk.common,
+	&mixer1_clk.common,
+	&wb_clk.common,
+
+	&bus_mixer0_clk.common,
+	&bus_mixer1_clk.common,
+	&bus_wb_clk.common,
+
+	&mixer0_div_clk.common,
+	&mixer1_div_clk.common,
+	&wb_div_clk.common,
+
+	&bus_rot_clk.common,
+	&rot_clk.common,
+	&rot_div_clk.common,
+};
+
 static struct ccu_common *sun50i_h6_de3_clks[] =3D {
 	&mixer0_clk.common,
 	&mixer1_clk.common,
@@ -156,6 +174,26 @@ static struct clk_hw_onecell_data sun8i_v3s_de2_hw_c=
lks =3D {
 	.num	=3D CLK_NUMBER_WITHOUT_ROT,
 };
=20
+static struct clk_hw_onecell_data sun50i_a64_de2_hw_clks =3D {
+	.hws	=3D {
+		[CLK_MIXER0]		=3D &mixer0_clk.common.hw,
+		[CLK_MIXER1]		=3D &mixer1_clk.common.hw,
+		[CLK_WB]		=3D &wb_clk.common.hw,
+		[CLK_ROT]		=3D &rot_clk.common.hw,
+
+		[CLK_BUS_MIXER0]	=3D &bus_mixer0_clk.common.hw,
+		[CLK_BUS_MIXER1]	=3D &bus_mixer1_clk.common.hw,
+		[CLK_BUS_WB]		=3D &bus_wb_clk.common.hw,
+		[CLK_BUS_ROT]		=3D &bus_rot_clk.common.hw,
+
+		[CLK_MIXER0_DIV]	=3D &mixer0_div_clk.common.hw,
+		[CLK_MIXER1_DIV]	=3D &mixer1_div_clk.common.hw,
+		[CLK_WB_DIV]		=3D &wb_div_clk.common.hw,
+		[CLK_ROT_DIV]		=3D &rot_div_clk.common.hw,
+	},
+	.num	=3D CLK_NUMBER_WITH_ROT,
+};
+
 static struct clk_hw_onecell_data sun50i_h6_de3_hw_clks =3D {
 	.hws	=3D {
 		[CLK_MIXER0]		=3D &mixer0_clk.common.hw,
@@ -190,6 +228,7 @@ static struct ccu_reset_map sun50i_a64_de2_resets[] =3D=
 {
 	[RST_MIXER0]	=3D { 0x08, BIT(0) },
 	[RST_MIXER1]	=3D { 0x08, BIT(1) },
 	[RST_WB]	=3D { 0x08, BIT(2) },
+	[RST_ROT]	=3D { 0x08, BIT(3) },
 };
=20
 static struct ccu_reset_map sun50i_h5_de2_resets[] =3D {
@@ -236,10 +275,10 @@ static const struct sunxi_ccu_desc sun8i_v3s_de2_cl=
k_desc =3D {
 };
=20
 static const struct sunxi_ccu_desc sun50i_a64_de2_clk_desc =3D {
-	.ccu_clks	=3D sun8i_h3_de2_clks,
-	.num_ccu_clks	=3D ARRAY_SIZE(sun8i_h3_de2_clks),
+	.ccu_clks	=3D sun50i_a64_de2_clks,
+	.num_ccu_clks	=3D ARRAY_SIZE(sun50i_a64_de2_clks),
=20
-	.hw_clks	=3D &sun8i_h3_de2_hw_clks,
+	.hw_clks	=3D &sun50i_a64_de2_hw_clks,
=20
 	.resets		=3D sun50i_a64_de2_resets,
 	.num_resets	=3D ARRAY_SIZE(sun50i_a64_de2_resets),
--=20
2.25.0

