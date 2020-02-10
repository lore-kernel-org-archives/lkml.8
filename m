Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAC4C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A9A20733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbgBJW2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:28:41 -0500
Received: from mailoutvs18.siol.net ([185.57.226.209]:33799 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727637AbgBJW2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:28:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id D5F3A522286;
        Mon, 10 Feb 2020 23:28:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7MmyhTadRlWt; Mon, 10 Feb 2020 23:28:34 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 8CEC9521B7E;
        Mon, 10 Feb 2020 23:28:34 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 3CF70522286;
        Mon, 10 Feb 2020 23:28:32 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, icenowy@aosc.io,
        jernej.skrabec@siol.net, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] clk: sunxi-ng: sun8i-de2: Add R40 specific quirks
Date:   Mon, 10 Feb 2020 23:28:07 +0100
Message-Id: <20200210222807.206426-8-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210222807.206426-1-jernej.skrabec@siol.net>
References: <20200210222807.206426-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R40 is actually very similar to A64, but it doesn't have mixer1 reset.
This means it's clocks and resets combination is unique and R40 specific
quirks are needed.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/=
ccu-sun8i-de2.c
index f44246ad560a..d2142ab9207f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -238,6 +238,16 @@ static const struct sunxi_ccu_desc sun8i_h3_de2_clk_=
desc =3D {
 	.num_resets	=3D ARRAY_SIZE(sun8i_h3_de2_resets),
 };
=20
+static const struct sunxi_ccu_desc sun8i_r40_de2_clk_desc =3D {
+	.ccu_clks	=3D sun50i_a64_de2_clks,
+	.num_ccu_clks	=3D ARRAY_SIZE(sun50i_a64_de2_clks),
+
+	.hw_clks	=3D &sun50i_a64_de2_hw_clks,
+
+	.resets		=3D sun8i_a83t_de2_resets,
+	.num_resets	=3D ARRAY_SIZE(sun8i_a83t_de2_resets),
+};
+
 static const struct sunxi_ccu_desc sun8i_v3s_de2_clk_desc =3D {
 	.ccu_clks	=3D sun8i_v3s_de2_clks,
 	.num_ccu_clks	=3D ARRAY_SIZE(sun8i_v3s_de2_clks),
@@ -356,6 +366,10 @@ static const struct of_device_id sunxi_de2_clk_ids[]=
 =3D {
 		.compatible =3D "allwinner,sun8i-h3-de2-clk",
 		.data =3D &sun8i_h3_de2_clk_desc,
 	},
+	{
+		.compatible =3D "allwinner,sun8i-r40-de2-clk",
+		.data =3D &sun8i_r40_de2_clk_desc,
+	},
 	{
 		.compatible =3D "allwinner,sun8i-v3s-de2-clk",
 		.data =3D &sun8i_v3s_de2_clk_desc,
--=20
2.25.0

