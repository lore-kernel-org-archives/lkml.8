Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A6FC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B709F20757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgIGHc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:32:27 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:32245 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726443AbgIGHc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:32:27 -0400
X-IronPort-AV: E=Sophos;i="5.76,401,1592838000"; 
   d="scan'208";a="56555302"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Sep 2020 16:32:24 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id BA3B041D2BEF;
        Mon,  7 Sep 2020 16:32:22 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH] arm64: dts: renesas: r8a774e1-hihope-rzg2h-ex: Enable sata
Date:   Mon,  7 Sep 2020 08:32:14 +0100
Message-Id: <20200907073214.13929-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable sata interface on HiHope RZ/G2H board.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dts b/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dts
index 265355e0de5f..812995939841 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dts
@@ -13,3 +13,8 @@
 	compatible = "hoperun,hihope-rzg2-ex", "hoperun,hihope-rzg2h",
 		     "renesas,r8a774e1";
 };
+
+/* Set SW43 = ON and SW1001[7] = OFF for SATA port to be activated */
+&sata {
+	status = "okay";
+};
-- 
2.17.1

