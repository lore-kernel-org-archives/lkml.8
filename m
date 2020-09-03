Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2CBC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CCFD20758
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="YD/eG8h/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgICOyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:54:40 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:28900 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729438AbgICOyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:54:35 -0400
IronPort-SDR: sVEDqzfl0w0g4Q/DM5sgqLfNBoYtaF6yAhlSOV/Ff6L2ml0FRRMXMFtkY4R5or3fBKMMy7O8Sg
 l/aKu+E5kr3F3Ot78thJpPIAHYCWTocqWuINEmbY+CyiJ8LMwFTApSVEJdbyALEOtNnxYtLijx
 YRlmAp1mMXz7MYzXQeHKtwGx8ZslIjdPRoOi+NcBLGkP7K69XAQjq6TSWR781K72u+So9GmOJi
 3paVqsrVO9WcHP8J980608fG1Gs7f+9xTsbIcdUiZmbNiims4S+wSeOgTciPQKAICmV2adUgvk
 38Y=
X-IronPort-AV: E=Sophos;i="5.76,387,1592863200"; 
   d="scan'208";a="13722702"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 03 Sep 2020 16:54:28 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 03 Sep 2020 16:54:28 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 03 Sep 2020 16:54:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1599144868; x=1630680868;
  h=from:to:cc:subject:date:message-id;
  bh=c6CREVq+CJypLfkfehiTiKALj8q9n1fuSRM/zOS0M3Q=;
  b=YD/eG8h/lH+qAq5E6t6SQIA0ZQMHq5rgM+4Qz1lmVfIiUduGZ0jclTqE
   YktPNbZtMayhHrPkCQ0sSR8V75G9VBNPKSAnIvBEk03Ba6xjycCUU6oQ/
   jsHoUTgg1FcMMDVE8k7HvOsYBDWnyPGPWEU8iecY28Hzj2R/7aDNEbvZh
   lWU1eBTJmDDwIM5WMfBEdQGzr/9XrNNfTL2naSwnPe9BUalsFwS5HIlvD
   RC9PxTWfkRCyarrGySm6rBOAGwrYigdaCC6lF2Uadov2TyEqcqSjxXp8u
   AZA+caBoKezEbeBpmOhnUGicG5B7n7zxucJhsKgCbl+2e1gFwY9Bkg4aq
   A==;
IronPort-SDR: HwNqwT3/Z4+PQ2C9chM6hcXnNJqES7qLluH+GZj98Ndv00vv9NfP1Ltesyg2Miuat+qoQUblqo
 b7SDL8WaazH6MatSQ/I2VWVUjjGzir8+kQptkjRjweMBR0g03w8VUoCQSXORRF7OGHnDJ7NTMB
 XBzS+uXI+2JBA0rSpfo2zcyW7g5S8nWt5hrb6mTz+zuhAKlEPPVzR/4+ji+4MWMVb313dskCbu
 jDJjRC78sJxbl0yVtyiw7esYaugfOV4OTpOZ02ynxWb4p8tNexzJtrbbr9qyqtOzqlsW28M+mK
 Img=
X-IronPort-AV: E=Sophos;i="5.76,387,1592863200"; 
   d="scan'208";a="13722701"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Sep 2020 16:54:28 +0200
Received: from schifferm-ubuntu4.tq-net.de (unknown [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 649D9280065;
        Thu,  3 Sep 2020 16:54:28 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 1/2] ARM: dts: imx6qdl: tqma6: fix indentation
Date:   Thu,  3 Sep 2020 16:53:46 +0200
Message-Id: <20200903145347.17830-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: cac849e9bbc8 ("ARM: dts: imx6qdl: add TQMa6{S,Q,QP} SoM")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: no changes

 arch/arm/boot/dts/imx6qdl-tqma6.dtsi | 188 +++++++++++++--------------
 1 file changed, 94 insertions(+), 94 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-tqma6.dtsi b/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
index 29bcce20f5f3..9513020ddd1a 100644
--- a/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
@@ -83,101 +83,101 @@
 };
 
 &pmic {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
-		interrupt-parent = <&gpio6>;
-		interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
-
-		regulators {
-			reg_vddcore: sw1ab {
-				regulator-min-microvolt = <300000>;
-				regulator-max-microvolt = <1875000>;
-				regulator-always-on;
-			};
-
-			reg_vddsoc: sw1c {
-				regulator-min-microvolt = <300000>;
-				regulator-max-microvolt = <1875000>;
-				regulator-always-on;
-			};
-
-			reg_gen_3v3: sw2 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			reg_ddr_1v5a: sw3a {
-				regulator-min-microvolt = <400000>;
-				regulator-max-microvolt = <1975000>;
-				regulator-always-on;
-			};
-
-			reg_ddr_1v5b: sw3b {
-				regulator-min-microvolt = <400000>;
-				regulator-max-microvolt = <1975000>;
-				regulator-always-on;
-			};
-
-			sw4_reg: sw4 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			reg_5v_600mA: swbst {
-				regulator-min-microvolt = <5000000>;
-				regulator-max-microvolt = <5150000>;
-				regulator-always-on;
-			};
-
-			reg_snvs_3v: vsnvs {
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-always-on;
-			};
-
-			reg_vrefddr: vrefddr {
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			reg_vgen1_1v5: vgen1 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1550000>;
-				/* not used */
-			};
-
-			reg_vgen2_1v2_eth: vgen2 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1550000>;
-				regulator-always-on;
-			};
-
-			reg_vgen3_2v8: vgen3 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			reg_vgen4_1v8: vgen4 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			reg_vgen5_1v8_eth: vgen5 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			reg_vgen6_3v3: vgen6 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pmic>;
+	interrupt-parent = <&gpio6>;
+	interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
+
+	regulators {
+		reg_vddcore: sw1ab {
+			regulator-min-microvolt = <300000>;
+			regulator-max-microvolt = <1875000>;
+			regulator-always-on;
+		};
+
+		reg_vddsoc: sw1c {
+			regulator-min-microvolt = <300000>;
+			regulator-max-microvolt = <1875000>;
+			regulator-always-on;
+		};
+
+		reg_gen_3v3: sw2 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		reg_ddr_1v5a: sw3a {
+			regulator-min-microvolt = <400000>;
+			regulator-max-microvolt = <1975000>;
+			regulator-always-on;
+		};
+
+		reg_ddr_1v5b: sw3b {
+			regulator-min-microvolt = <400000>;
+			regulator-max-microvolt = <1975000>;
+			regulator-always-on;
+		};
+
+		sw4_reg: sw4 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		reg_5v_600mA: swbst {
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5150000>;
+			regulator-always-on;
+		};
+
+		reg_snvs_3v: vsnvs {
+			regulator-min-microvolt = <1500000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-always-on;
 		};
+
+		reg_vrefddr: vrefddr {
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		reg_vgen1_1v5: vgen1 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <1550000>;
+			/* not used */
+		};
+
+		reg_vgen2_1v2_eth: vgen2 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <1550000>;
+			regulator-always-on;
+		};
+
+		reg_vgen3_2v8: vgen3 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		reg_vgen4_1v8: vgen4 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		reg_vgen5_1v8_eth: vgen5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		reg_vgen6_3v3: vgen6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
 };
 
 /* eMMC */
-- 
2.17.1

