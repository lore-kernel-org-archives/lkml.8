Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2247CC3B186
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CDE20733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgBJW2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:28:23 -0500
Received: from mailoutvs50.siol.net ([185.57.226.241]:33687 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727254AbgBJW2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:28:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 86EB95222D1;
        Mon, 10 Feb 2020 23:28:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zPvS-AFRxC6X; Mon, 10 Feb 2020 23:28:19 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 21CAF522286;
        Mon, 10 Feb 2020 23:28:19 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id C0717521B7E;
        Mon, 10 Feb 2020 23:28:16 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, icenowy@aosc.io,
        jernej.skrabec@siol.net, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] clk: sunxi-ng: sun8i-de2: Sort structures
Date:   Mon, 10 Feb 2020 23:28:01 +0100
Message-Id: <20200210222807.206426-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210222807.206426-1-jernej.skrabec@siol.net>
References: <20200210222807.206426-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current structures are not sorted by family first and then
alphabetically. Let's do that now.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 56 ++++++++++++++--------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/=
ccu-sun8i-de2.c
index d9668493c3f9..a928e0c32222 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -51,24 +51,6 @@ static SUNXI_CCU_M(mixer1_div_a83_clk, "mixer1-div", "=
pll-de", 0x0c, 4, 4,
 static SUNXI_CCU_M(wb_div_a83_clk, "wb-div", "pll-de", 0x0c, 8, 4,
 		   CLK_SET_RATE_PARENT);
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
 static struct ccu_common *sun8i_a83t_de2_clks[] =3D {
 	&mixer0_clk.common,
 	&mixer1_clk.common,
@@ -108,6 +90,24 @@ static struct ccu_common *sun8i_v3s_de2_clks[] =3D {
 	&wb_div_clk.common,
 };
=20
+static struct ccu_common *sun50i_h6_de3_clks[] =3D {
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
 static struct clk_hw_onecell_data sun8i_a83t_de2_hw_clks =3D {
 	.hws	=3D {
 		[CLK_MIXER0]		=3D &mixer0_clk.common.hw,
@@ -219,6 +219,16 @@ static const struct sunxi_ccu_desc sun8i_h3_de2_clk_=
desc =3D {
 	.num_resets	=3D ARRAY_SIZE(sun8i_a83t_de2_resets),
 };
=20
+static const struct sunxi_ccu_desc sun8i_v3s_de2_clk_desc =3D {
+	.ccu_clks	=3D sun8i_v3s_de2_clks,
+	.num_ccu_clks	=3D ARRAY_SIZE(sun8i_v3s_de2_clks),
+
+	.hw_clks	=3D &sun8i_v3s_de2_hw_clks,
+
+	.resets		=3D sun8i_a83t_de2_resets,
+	.num_resets	=3D ARRAY_SIZE(sun8i_a83t_de2_resets),
+};
+
 static const struct sunxi_ccu_desc sun50i_a64_de2_clk_desc =3D {
 	.ccu_clks	=3D sun8i_h3_de2_clks,
 	.num_ccu_clks	=3D ARRAY_SIZE(sun8i_h3_de2_clks),
@@ -239,16 +249,6 @@ static const struct sunxi_ccu_desc sun50i_h6_de3_clk=
_desc =3D {
 	.num_resets	=3D ARRAY_SIZE(sun50i_h6_de3_resets),
 };
=20
-static const struct sunxi_ccu_desc sun8i_v3s_de2_clk_desc =3D {
-	.ccu_clks	=3D sun8i_v3s_de2_clks,
-	.num_ccu_clks	=3D ARRAY_SIZE(sun8i_v3s_de2_clks),
-
-	.hw_clks	=3D &sun8i_v3s_de2_hw_clks,
-
-	.resets		=3D sun8i_a83t_de2_resets,
-	.num_resets	=3D ARRAY_SIZE(sun8i_a83t_de2_resets),
-};
-
 static int sunxi_de2_clk_probe(struct platform_device *pdev)
 {
 	struct resource *res;
--=20
2.25.0

