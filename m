Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AEFC3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA532176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgBSHeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:34:10 -0500
Received: from [167.172.186.51] ([167.172.186.51]:35154 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726871AbgBSHeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:34:08 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 80CAFE0070;
        Wed, 19 Feb 2020 07:34:21 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nKYUoyJAWwlr; Wed, 19 Feb 2020 07:34:17 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id CB093E0046;
        Wed, 19 Feb 2020 07:34:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TnV4bDUmBWVF; Wed, 19 Feb 2020 07:34:15 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 4CD59E005C;
        Wed, 19 Feb 2020 07:34:15 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 07/10] clk: mmp2: Check for MMP3
Date:   Wed, 19 Feb 2020 08:33:50 +0100
Message-Id: <20200219073353.184336-8-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219073353.184336-1-lkundrak@v3.sk>
References: <20200219073353.184336-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MMP3's are similar enough to MMP2, but there are differencies, such
are more clocks available on the newer model. We want to tell which
platform are we on.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-of-mmp2.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.=
c
index 251d8d0e78abb..7594a8280b93a 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -62,8 +62,14 @@
 #define MPMU_UART_PLL	0x14
 #define MPMU_PLL2_CR	0x34
=20
+enum mmp2_clk_model {
+	CLK_MODEL_MMP2,
+	CLK_MODEL_MMP3,
+};
+
 struct mmp2_clk_unit {
 	struct mmp_clk_unit unit;
+	enum mmp2_clk_model model;
 	void __iomem *mpmu_base;
 	void __iomem *apmu_base;
 	void __iomem *apbc_base;
@@ -326,6 +332,11 @@ static void __init mmp2_clk_init(struct device_node =
*np)
 	if (!pxa_unit)
 		return;
=20
+	if (of_device_is_compatible(np, "marvell,mmp3-clock"))
+		pxa_unit->model =3D CLK_MODEL_MMP3;
+	else
+		pxa_unit->model =3D CLK_MODEL_MMP2;
+
 	pxa_unit->mpmu_base =3D of_iomap(np, 0);
 	if (!pxa_unit->mpmu_base) {
 		pr_err("failed to map mpmu registers\n");
@@ -365,3 +376,4 @@ static void __init mmp2_clk_init(struct device_node *=
np)
 }
=20
 CLK_OF_DECLARE(mmp2_clk, "marvell,mmp2-clock", mmp2_clk_init);
+CLK_OF_DECLARE(mmp3_clk, "marvell,mmp3-clock", mmp2_clk_init);
--=20
2.24.1

