Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31539C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1514A2065D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgGGQSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:18:30 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:43654 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728589AbgGGQSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:18:25 -0400
X-IronPort-AV: E=Sophos;i="5.75,324,1589209200"; 
   d="scan'208";a="51540096"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 08 Jul 2020 01:18:23 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 312BE40164B2;
        Wed,  8 Jul 2020 01:18:20 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 04/14] soc: renesas: Add Renesas R8A774E1 config option
Date:   Tue,  7 Jul 2020 17:18:02 +0100
Message-Id: <1594138692-16816-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594138692-16816-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1594138692-16816-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Add configuration option for the RZ/G2H (R8A774E1) SoC.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 53cd8d2d0cd2..30984659df90 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -201,6 +201,13 @@ config ARCH_R8A774C0
 	help
 	  This enables support for the Renesas RZ/G2E SoC.
 
+config ARCH_R8A774E1
+	bool "Renesas RZ/G2H SoC Platform"
+	select ARCH_RCAR_GEN3
+	select SYSC_R8A774E1
+	help
+	  This enables support for the Renesas RZ/G2H SoC.
+
 config ARCH_R8A77950
 	bool "Renesas R-Car H3 ES1.x SoC Platform"
 	select ARCH_RCAR_GEN3
@@ -296,6 +303,10 @@ config SYSC_R8A774C0
 	bool "RZ/G2E System Controller support" if COMPILE_TEST
 	select SYSC_RCAR
 
+config SYSC_R8A774E1
+	bool "RZ/G2H System Controller support" if COMPILE_TEST
+	select SYSC_RCAR
+
 config SYSC_R8A7779
 	bool "R-Car H1 System Controller support" if COMPILE_TEST
 	select SYSC_RCAR
-- 
2.17.1

