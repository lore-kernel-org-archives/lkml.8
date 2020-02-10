Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897A9C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A352082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgBJW2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:28:46 -0500
Received: from mailoutvs43.siol.net ([185.57.226.234]:33759 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727606AbgBJW2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:28:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 0D8F05222B4;
        Mon, 10 Feb 2020 23:28:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tFjqKTq4CtLd; Mon, 10 Feb 2020 23:28:29 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id AE299521B7E;
        Mon, 10 Feb 2020 23:28:29 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 321245222D3;
        Mon, 10 Feb 2020 23:28:27 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, icenowy@aosc.io,
        jernej.skrabec@siol.net, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] clk: sunxi-ng: sun8i-de2: Don't reuse A83T resets
Date:   Mon, 10 Feb 2020 23:28:05 +0100
Message-Id: <20200210222807.206426-6-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210222807.206426-1-jernej.skrabec@siol.net>
References: <20200210222807.206426-1-jernej.skrabec@siol.net>
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
index 55ab05328ffc..edb73fdf49f1 100644
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
 static const struct sunxi_ccu_desc sun8i_v3s_de2_clk_desc =3D {
@@ -225,8 +234,8 @@ static const struct sunxi_ccu_desc sun8i_v3s_de2_clk_=
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
 static const struct sunxi_ccu_desc sun50i_a64_de2_clk_desc =3D {
--=20
2.25.0

