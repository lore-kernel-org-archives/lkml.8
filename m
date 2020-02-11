Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5C1C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75002465D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbgBKTBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:01:10 -0500
Received: from mailoutvs59.siol.net ([185.57.226.250]:37375 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730813AbgBKTBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:01:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 0B1625251B3;
        Tue, 11 Feb 2020 20:01:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EuYIkLmc_RTE; Tue, 11 Feb 2020 20:01:04 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id B40985251AB;
        Tue, 11 Feb 2020 20:01:04 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 4779A525125;
        Tue, 11 Feb 2020 20:01:02 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, icenowy@aosc.io,
        jernej.skrabec@siol.net, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] clk: sunxi-ng: sun8i-de2: Split out H5 definitions
Date:   Tue, 11 Feb 2020 19:59:30 +0100
Message-Id: <20200211185936.245174-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211185936.245174-1-jernej.skrabec@siol.net>
References: <20200211185936.245174-1-jernej.skrabec@siol.net>
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

Note that this patch depends on commit 19368d99746e ("clk: sunxi-ng:
add support for Allwinner H3 DE2 CCU") for the H3 clock list.

Fixes: 763c5bd045b1 ("clk: sunxi-ng: add support for DE2 CCU")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/=
ccu-sun8i-de2.c
index d9668493c3f9..2478ae314d0f 100644
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
@@ -229,6 +235,16 @@ static const struct sunxi_ccu_desc sun50i_a64_de2_cl=
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

