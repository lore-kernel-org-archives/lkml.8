Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36E3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD8E2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgHYQ2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:28:46 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:21607 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726940AbgHYQ2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:28:33 -0400
X-IronPort-AV: E=Sophos;i="5.76,353,1592838000"; 
   d="scan'208";a="55277839"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 Aug 2020 01:28:32 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 215F440175FB;
        Wed, 26 Aug 2020 01:28:30 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH 3/4] ARM: dts: r8a7742-iwg21d-q7: Add can0 support to carrier board
Date:   Tue, 25 Aug 2020 17:27:17 +0100
Message-Id: <20200825162718.5838-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825162718.5838-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200825162718.5838-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables CAN0 interface exposed through connector J20 on the
carrier board.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
index e709a132f2f7..070fc9729b39 100644
--- a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
+++ b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
@@ -198,6 +198,13 @@
 	};
 };
 
+&can0 {
+	pinctrl-0 = <&can0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &cmt0 {
 	status = "okay";
 };
@@ -214,6 +221,15 @@
 	};
 };
 
+&gpio1 {
+	can-trx-en-gpio{
+		gpio-hog;
+		gpios = <28 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "can-trx-en-gpio";
+	};
+};
+
 &hsusb {
 	pinctrl-0 = <&usb0_pins>;
 	pinctrl-names = "default";
@@ -287,6 +303,11 @@
 		function = "tpu0";
 	};
 
+	can0_pins: can0 {
+		groups = "can0_data_d";
+		function = "can0";
+	};
+
 	i2c2_pins: i2c2 {
 		groups = "i2c2_b";
 		function = "i2c2";
-- 
2.17.1

