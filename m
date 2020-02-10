Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FC2C3B186
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A517420870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgBJW2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:28:34 -0500
Received: from mailoutvs5.siol.net ([185.57.226.196]:33742 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727573AbgBJW23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:28:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 79882522300;
        Mon, 10 Feb 2020 23:28:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Tx88K4UxsZ0u; Mon, 10 Feb 2020 23:28:27 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 13725522286;
        Mon, 10 Feb 2020 23:28:27 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 6B4E55222D3;
        Mon, 10 Feb 2020 23:28:24 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, icenowy@aosc.io,
        jernej.skrabec@siol.net, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] clk: sunxi-ng: sun8i-de2: H6 doesn't have rotate core
Date:   Mon, 10 Feb 2020 23:28:04 +0100
Message-Id: <20200210222807.206426-5-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210222807.206426-1-jernej.skrabec@siol.net>
References: <20200210222807.206426-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DE3 documentation regarding presence of rotate core in H6 is a bit
confusing. Register descriptions mention bits for enabling rotate core
clocks and reset, but general overview doesn't list it as feature of H6
display engine and BSP kernel doesn't support it. Manual poking
registers also didn't reveal presence of rotate core.

Let's assume there isn't any rotate core on H6 present and remove
related clocks. With that done, structures are same as those for H5, so
just reuse H5 structure.

Fixes: 56808da9f97f "clk: sunxi-ng: Add support for H6 DE3 clocks"
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 57 +---------------------------
 1 file changed, 1 insertion(+), 56 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/=
ccu-sun8i-de2.c
index 2636a416a6f1..55ab05328ffc 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -108,24 +108,6 @@ static struct ccu_common *sun50i_a64_de2_clks[] =3D =
{
 	&rot_div_clk.common,
 };
=20
-static struct ccu_common *sun50i_h6_de3_clks[] =3D {
-	&mixer0_clk.common,
-	&mixer1_clk.common,
-	&wb_clk.common,
-
-	&bus_mixer0_clk.common,
-	&bus_mixer1_clk.common,
-	&bus_wb_clk.common,
-
-	&mixer0_div_clk.common,
-	&mixer1_div_clk.common,
-	&wb_div_clk.common,
-
-	&bus_rot_clk.common,
-	&rot_clk.common,
-	&rot_div_clk.common,
-};
-
 static struct clk_hw_onecell_data sun8i_a83t_de2_hw_clks =3D {
 	.hws	=3D {
 		[CLK_MIXER0]		=3D &mixer0_clk.common.hw,
@@ -194,26 +176,6 @@ static struct clk_hw_onecell_data sun50i_a64_de2_hw_=
clks =3D {
 	.num	=3D CLK_NUMBER_WITH_ROT,
 };
=20
-static struct clk_hw_onecell_data sun50i_h6_de3_hw_clks =3D {
-	.hws	=3D {
-		[CLK_MIXER0]		=3D &mixer0_clk.common.hw,
-		[CLK_MIXER1]		=3D &mixer1_clk.common.hw,
-		[CLK_WB]		=3D &wb_clk.common.hw,
-		[CLK_ROT]		=3D &rot_clk.common.hw,
-
-		[CLK_BUS_MIXER0]	=3D &bus_mixer0_clk.common.hw,
-		[CLK_BUS_MIXER1]	=3D &bus_mixer1_clk.common.hw,
-		[CLK_BUS_WB]		=3D &bus_wb_clk.common.hw,
-		[CLK_BUS_ROT]		=3D &bus_rot_clk.common.hw,
-
-		[CLK_MIXER0_DIV]	=3D &mixer0_div_clk.common.hw,
-		[CLK_MIXER1_DIV]	=3D &mixer1_div_clk.common.hw,
-		[CLK_WB_DIV]		=3D &wb_div_clk.common.hw,
-		[CLK_ROT_DIV]		=3D &rot_div_clk.common.hw,
-	},
-	.num	=3D CLK_NUMBER_WITH_ROT,
-};
-
 static struct ccu_reset_map sun8i_a83t_de2_resets[] =3D {
 	[RST_MIXER0]	=3D { 0x08, BIT(0) },
 	/*
@@ -237,13 +199,6 @@ static struct ccu_reset_map sun50i_h5_de2_resets[] =3D=
 {
 	[RST_WB]	=3D { 0x08, BIT(2) },
 };
=20
-static struct ccu_reset_map sun50i_h6_de3_resets[] =3D {
-	[RST_MIXER0]	=3D { 0x08, BIT(0) },
-	[RST_MIXER1]	=3D { 0x08, BIT(1) },
-	[RST_WB]	=3D { 0x08, BIT(2) },
-	[RST_ROT]	=3D { 0x08, BIT(3) },
-};
-
 static const struct sunxi_ccu_desc sun8i_a83t_de2_clk_desc =3D {
 	.ccu_clks	=3D sun8i_a83t_de2_clks,
 	.num_ccu_clks	=3D ARRAY_SIZE(sun8i_a83t_de2_clks),
@@ -294,16 +249,6 @@ static const struct sunxi_ccu_desc sun50i_h5_de2_clk=
_desc =3D {
 	.num_resets	=3D ARRAY_SIZE(sun50i_h5_de2_resets),
 };
=20
-static const struct sunxi_ccu_desc sun50i_h6_de3_clk_desc =3D {
-	.ccu_clks	=3D sun50i_h6_de3_clks,
-	.num_ccu_clks	=3D ARRAY_SIZE(sun50i_h6_de3_clks),
-
-	.hw_clks	=3D &sun50i_h6_de3_hw_clks,
-
-	.resets		=3D sun50i_h6_de3_resets,
-	.num_resets	=3D ARRAY_SIZE(sun50i_h6_de3_resets),
-};
-
 static int sunxi_de2_clk_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -406,7 +351,7 @@ static const struct of_device_id sunxi_de2_clk_ids[] =
=3D {
 	},
 	{
 		.compatible =3D "allwinner,sun50i-h6-de3-clk",
-		.data =3D &sun50i_h6_de3_clk_desc,
+		.data =3D &sun50i_h5_de2_clk_desc,
 	},
 	{ }
 };
--=20
2.25.0

