Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6CAC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE672082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgBJW21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:28:27 -0500
Received: from mailoutvs13.siol.net ([185.57.226.204]:33707 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727522AbgBJW2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:28:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 368D2521B7E;
        Mon, 10 Feb 2020 23:28:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FBItU2wkv4Gz; Mon, 10 Feb 2020 23:28:21 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id DAC12522286;
        Mon, 10 Feb 2020 23:28:21 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 4BDC7521B7E;
        Mon, 10 Feb 2020 23:28:19 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, icenowy@aosc.io,
        jernej.skrabec@siol.net, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] clk: sunxi-ng: sun8i-de2: Split out H5 definitions
Date:   Mon, 10 Feb 2020 23:28:02 +0100
Message-Id: <20200210222807.206426-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210222807.206426-1-jernej.skrabec@siol.net>
References: <20200210222807.206426-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H5 has less clocks and resets than A64. Currently that's not obvious
because A64 is missing rotation core related clocks and reset.

Split out H5 definition. A64 structures will be fixed in subsequent
commit.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/=
ccu-sun8i-de2.c
index a928e0c32222..f449c22e59e8 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -192,6 +192,12 @@ static struct ccu_reset_map sun50i_a64_de2_resets[] =
=3D {
 	[RST_WB]	=3D { 0x08, BIT(2) },
 };
=20
+static struct ccu_reset_map sun50i_h5_de2_resets[] =3D {
+	[RST_MIXER0]	=3D { 0x08, BIT(0) },
+	[RST_MIXER1]	=3D { 0x08, BIT(1) },
+	[RST_WB]	=3D { 0x08, BIT(2) },
+};
+
 static struct ccu_reset_map sun50i_h6_de3_resets[] =3D {
 	[RST_MIXER0]	=3D { 0x08, BIT(0) },
 	[RST_MIXER1]	=3D { 0x08, BIT(1) },
@@ -239,6 +245,16 @@ static const struct sunxi_ccu_desc sun50i_a64_de2_cl=
k_desc =3D {
 	.num_resets	=3D ARRAY_SIZE(sun50i_a64_de2_resets),
 };
=20
+static const struct sunxi_ccu_desc sun50i_h5_de2_clk_desc =3D {
+	.ccu_clks	=3D sun8i_h3_de2_clks,
+	.num_ccu_clks	=3D ARRAY_SIZE(sun8i_h3_de2_clks),
+
+	.hw_clks	=3D &sun8i_h3_de2_hw_clks,
+
+	.resets		=3D sun50i_h5_de2_resets,
+	.num_resets	=3D ARRAY_SIZE(sun50i_h5_de2_resets),
+};
+
 static const struct sunxi_ccu_desc sun50i_h6_de3_clk_desc =3D {
 	.ccu_clks	=3D sun50i_h6_de3_clks,
 	.num_ccu_clks	=3D ARRAY_SIZE(sun50i_h6_de3_clks),
@@ -347,7 +363,7 @@ static const struct of_device_id sunxi_de2_clk_ids[] =
=3D {
 	},
 	{
 		.compatible =3D "allwinner,sun50i-h5-de2-clk",
-		.data =3D &sun50i_a64_de2_clk_desc,
+		.data =3D &sun50i_h5_de2_clk_desc,
 	},
 	{
 		.compatible =3D "allwinner,sun50i-h6-de3-clk",
--=20
2.25.0

