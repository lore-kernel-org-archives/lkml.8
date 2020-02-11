Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0097C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3372465D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbgBKTBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:01:19 -0500
Received: from mailoutvs59.siol.net ([185.57.226.250]:37591 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730702AbgBKTBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:01:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 6686B520F5A;
        Tue, 11 Feb 2020 20:01:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uxr_8-pvhZ7V; Tue, 11 Feb 2020 20:01:12 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 1B9B9520E21;
        Tue, 11 Feb 2020 20:01:12 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id A9FA0520551;
        Tue, 11 Feb 2020 20:01:09 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, icenowy@aosc.io,
        jernej.skrabec@siol.net, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] clk: sunxi-ng: sun8i-de2: Don't reuse A83T resets
Date:   Tue, 11 Feb 2020 19:59:33 +0100
Message-Id: <20200211185936.245174-5-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211185936.245174-1-jernej.skrabec@siol.net>
References: <20200211185936.245174-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, V3s and H3 reuse A83T reset structure. However, A83T contains
additional core for rotation, which is not present in V3s and H3.

Make new reset structure for H3 and let V3s reuse it. A83T reset
structure will be amended in subsequent commit.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/=
ccu-sun8i-de2.c
index 87a30d072ae9..bbbe1ed7aba1 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -179,9 +179,18 @@ static struct clk_hw_onecell_data sun50i_a64_de2_hw_=
clks =3D {
 static struct ccu_reset_map sun8i_a83t_de2_resets[] =3D {
 	[RST_MIXER0]	=3D { 0x08, BIT(0) },
 	/*
-	 * For A83T, H3 and R40, mixer1 reset line is shared with wb, so
-	 * only RST_WB is exported here.
-	 * For V3s there's just no mixer1, so it also shares this struct.
+	 * Mixer1 reset line is shared with wb, so only RST_WB is
+	 * exported here.
+	 */
+	[RST_WB]	=3D { 0x08, BIT(2) },
+};
+
+static struct ccu_reset_map sun8i_h3_de2_resets[] =3D {
+	[RST_MIXER0]	=3D { 0x08, BIT(0) },
+	/*
+	 * Mixer1 reset line is shared with wb, so only RST_WB is
+	 * exported here.
+	 * V3s doesn't have mixer1, so it also shares this struct.
 	 */
 	[RST_WB]	=3D { 0x08, BIT(2) },
 };
@@ -215,8 +224,8 @@ static const struct sunxi_ccu_desc sun8i_h3_de2_clk_d=
esc =3D {
=20
 	.hw_clks	=3D &sun8i_h3_de2_hw_clks,
=20
-	.resets		=3D sun8i_a83t_de2_resets,
-	.num_resets	=3D ARRAY_SIZE(sun8i_a83t_de2_resets),
+	.resets		=3D sun8i_h3_de2_resets,
+	.num_resets	=3D ARRAY_SIZE(sun8i_h3_de2_resets),
 };
=20
 static const struct sunxi_ccu_desc sun50i_a64_de2_clk_desc =3D {
@@ -245,8 +254,8 @@ static const struct sunxi_ccu_desc sun8i_v3s_de2_clk_=
desc =3D {
=20
 	.hw_clks	=3D &sun8i_v3s_de2_hw_clks,
=20
-	.resets		=3D sun8i_a83t_de2_resets,
-	.num_resets	=3D ARRAY_SIZE(sun8i_a83t_de2_resets),
+	.resets		=3D sun8i_h3_de2_resets,
+	.num_resets	=3D ARRAY_SIZE(sun8i_h3_de2_resets),
 };
=20
 static int sunxi_de2_clk_probe(struct platform_device *pdev)
--=20
2.25.0

