Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3A2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF417207DE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgHJRMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 13:12:49 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:43189 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725873AbgHJRMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 13:12:47 -0400
X-IronPort-AV: E=Sophos;i="5.75,458,1589209200"; 
   d="scan'208";a="54306417"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 Aug 2020 02:12:44 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id E81BF4001967;
        Tue, 11 Aug 2020 02:12:42 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH] arm64: dts: renesas: r8a774b1-hihope-rzg2n-ex: Enable sata
Date:   Mon, 10 Aug 2020 18:12:39 +0100
Message-Id: <20200810171239.30401-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable sata interface on HiHope RZ/G2N board.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dts b/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dts
index a3edd55113df..60d7c8adea02 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dts
@@ -14,3 +14,8 @@
 	compatible = "hoperun,hihope-rzg2-ex", "hoperun,hihope-rzg2n",
 		     "renesas,r8a774b1";
 };
+
+/* Set SW43 = ON and SW1001[7] = OFF for SATA port to be activated */
+&sata {
+	status = "okay";
+};
-- 
2.17.1

