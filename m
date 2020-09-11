Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5B3C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5E52075A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgIKIgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:36:35 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:44824 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725550AbgIKIgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:36:33 -0400
X-IronPort-AV: E=Sophos;i="5.76,414,1592838000"; 
   d="scan'208";a="57022257"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 Sep 2020 17:36:31 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id D3A65400D4DC;
        Fri, 11 Sep 2020 17:36:29 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH] ARM: dts: r8a7742-iwg21d-q7-dbcm-ca: Add can0 support to camera DB
Date:   Fri, 11 Sep 2020 09:36:15 +0100
Message-Id: <20200911083615.17377-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables CAN0 interface exposed through connector J4 on the
camera DB.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
 arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts b/arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts
index 1479ced50873..961c0f2eeefb 100644
--- a/arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts
+++ b/arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts
@@ -27,6 +27,12 @@
 	status = "disabled";
 };
 
+&can0 {
+	pinctrl-0 = <&can0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &ether {
 	pinctrl-0 = <&ether_pins>;
 	pinctrl-names = "default";
@@ -49,6 +55,11 @@
 };
 
 &pfc {
+	can0_pins: can0 {
+		groups = "can0_data_d";
+		function = "can0";
+	};
+
 	ether_pins: ether {
 		groups = "eth_mdio", "eth_rmii";
 		function = "eth";
-- 
2.17.1

