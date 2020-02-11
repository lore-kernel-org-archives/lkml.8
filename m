Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A00C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8457021739
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbgBKTBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:01:20 -0500
Received: from mailoutvs3.siol.net ([185.57.226.194]:37653 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731475AbgBKTBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:01:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 19A265214E7;
        Tue, 11 Feb 2020 20:01:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id smvB9Y91NbhT; Tue, 11 Feb 2020 20:01:14 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id C440C52151D;
        Tue, 11 Feb 2020 20:01:14 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 5A76D520EDD;
        Tue, 11 Feb 2020 20:01:12 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, icenowy@aosc.io,
        jernej.skrabec@siol.net, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] clk: sunxi-ng: sun8i-de2: Add rotation core clocks and reset for A83T
Date:   Tue, 11 Feb 2020 19:59:34 +0100
Message-Id: <20200211185936.245174-6-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211185936.245174-1-jernej.skrabec@siol.net>
References: <20200211185936.245174-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A83T structures don't have clocks and reset for rotation core. Add them.

Fixes: 763c5bd045b1 ("clk: sunxi-ng: add support for DE2 CCU")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/=
ccu-sun8i-de2.c
index bbbe1ed7aba1..9656553c01f3 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -50,6 +50,8 @@ static SUNXI_CCU_M(mixer1_div_a83_clk, "mixer1-div", "p=
ll-de", 0x0c, 4, 4,
 		   CLK_SET_RATE_PARENT);
 static SUNXI_CCU_M(wb_div_a83_clk, "wb-div", "pll-de", 0x0c, 8, 4,
 		   CLK_SET_RATE_PARENT);
+static SUNXI_CCU_M(rot_div_a83_clk, "rot-div", "pll-de", 0x0c, 0x0c, 4,
+		   CLK_SET_RATE_PARENT);
=20
 static struct ccu_common *sun8i_a83t_de2_clks[] =3D {
 	&mixer0_clk.common,
@@ -63,6 +65,10 @@ static struct ccu_common *sun8i_a83t_de2_clks[] =3D {
 	&mixer0_div_a83_clk.common,
 	&mixer1_div_a83_clk.common,
 	&wb_div_a83_clk.common,
+
+	&bus_rot_clk.common,
+	&rot_clk.common,
+	&rot_div_a83_clk.common,
 };
=20
 static struct ccu_common *sun8i_h3_de2_clks[] =3D {
@@ -113,16 +119,19 @@ static struct clk_hw_onecell_data sun8i_a83t_de2_hw=
_clks =3D {
 		[CLK_MIXER0]		=3D &mixer0_clk.common.hw,
 		[CLK_MIXER1]		=3D &mixer1_clk.common.hw,
 		[CLK_WB]		=3D &wb_clk.common.hw,
+		[CLK_ROT]		=3D &rot_clk.common.hw,
=20
 		[CLK_BUS_MIXER0]	=3D &bus_mixer0_clk.common.hw,
 		[CLK_BUS_MIXER1]	=3D &bus_mixer1_clk.common.hw,
 		[CLK_BUS_WB]		=3D &bus_wb_clk.common.hw,
+		[CLK_BUS_ROT]		=3D &bus_rot_clk.common.hw,
=20
 		[CLK_MIXER0_DIV]	=3D &mixer0_div_a83_clk.common.hw,
 		[CLK_MIXER1_DIV]	=3D &mixer1_div_a83_clk.common.hw,
 		[CLK_WB_DIV]		=3D &wb_div_a83_clk.common.hw,
+		[CLK_ROT_DIV]		=3D &rot_div_a83_clk.common.hw,
 	},
-	.num	=3D CLK_NUMBER_WITHOUT_ROT,
+	.num	=3D CLK_NUMBER_WITH_ROT,
 };
=20
 static struct clk_hw_onecell_data sun8i_h3_de2_hw_clks =3D {
@@ -183,6 +192,7 @@ static struct ccu_reset_map sun8i_a83t_de2_resets[] =3D=
 {
 	 * exported here.
 	 */
 	[RST_WB]	=3D { 0x08, BIT(2) },
+	[RST_ROT]	=3D { 0x08, BIT(3) },
 };
=20
 static struct ccu_reset_map sun8i_h3_de2_resets[] =3D {
--=20
2.25.0

