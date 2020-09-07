Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9399FC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B21B2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="hUlNKTnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgIGIFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:05:54 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:43205 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIGIEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:04:51 -0400
IronPort-SDR: boXCJZMcazwujojODY08lRS93dSd37tK8LDmNpG22tF8WHwfsLrw+NR3H8MFnuKMeFLbEWsmzf
 y47VaVXFmzds0XD6XaoPAaqzVDiL0RhjDOKnVd52goaTPlScHeS/eDsCiCUc8VV0USCCMwweSw
 vxh+p4zhB5Ma47IvrpgVFoBCLkqyS5WYHmHfwNXPCxL9YYcu4tkQfvEGhxxwZPMUzWt+F5f4pP
 h/DTj9aWW3PPYzmLab9zbHrWcyCVTPqKviCTa4ClOfDoOrK9kQzoaFemWSX9O+OYHdNklwclrJ
 V6U=
X-IronPort-AV: E=Sophos;i="5.76,401,1592863200"; 
   d="scan'208";a="13750636"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Sep 2020 10:04:50 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 07 Sep 2020 10:04:50 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 07 Sep 2020 10:04:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1599465890; x=1631001890;
  h=from:to:cc:subject:date:message-id;
  bh=x3tJZEyLWm4u0QOIaUmWlIcMUC8WiB4fh01CI33Tp+A=;
  b=hUlNKTnEhI0KuWEcJFwtj9IhgQrT5gKbGqLcjJvOcbkpcKra1PMsBAfk
   XC9jtQbbUnt/++SuIo9kd3A/fG3xIyBO26ermG+lfYdkv1uClHsyu93uW
   QWgrNXMngKtBowOUG8lJfOv3SrHGFxJm0M6pt3EZo9Fbxk2S76kxp95QY
   7OytH5IsUYCnp9yQZ78t+OE84sOgyMAMgS0G/rVMrX/M0IXeWHg44MPlT
   SGWUF2yplBj/wh5TItgi6CVeVYAgEYobZFClcK7ISiUez9NInC4vv/ltm
   iUPvtIKsxnmYrRzAZ4yDKUY35vn9fVrVcpElZCvwWhQ8yCkDKWDlJf8Yz
   A==;
IronPort-SDR: dlHTB41/fcWRCaf+10SQagP3GVssey8lS2ivDQztgIfGD5rT/wPwL7TaEx3ig8yj1P5Pv5mpK5
 /RgZpPetRHbnrL3oNmtZCxSf1wubVcfFxrYELRd59HDOAQelA+Ly4zQD+r4CxgALC08hUaZGrs
 cQIyo+OyrM8Z8y2QIbrjNjwf4BbxBLvgzEDD4sARLftmz/AdnxKxHsebDNbDUvzjIj04TDb7ly
 rPizVbay3nYixFRBqJFe46ZuKoagX0EPZB6HxzBmbhSkK0iaEoTXTxKIb7HtpmU8mqFLt/xXUZ
 b1U=
X-IronPort-AV: E=Sophos;i="5.76,401,1592863200"; 
   d="scan'208";a="13750635"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Sep 2020 10:04:50 +0200
Received: from schifferm-ubuntu4.tq-net.de (unknown [10.117.49.134])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 4F338280065;
        Mon,  7 Sep 2020 10:04:50 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v3 1/3] ARM: dts: imx6qdl: tqma6: fix indentation
Date:   Mon,  7 Sep 2020 10:04:27 +0200
Message-Id: <20200907080429.12496-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC configuration is indented one level too deep.

Fixes: cac849e9bbc8 ("ARM: dts: imx6qdl: add TQMa6{S,Q,QP} SoM")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v3: extended commit message
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

