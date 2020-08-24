Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA55C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE4C206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="DhdBf9Cb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgHXJLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:11:01 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:14016 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgHXJK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:10:28 -0400
IronPort-SDR: EqjF/eidRffWCvHac/+1OtwSEJlCnJcPRhBhdR8mjUwcGJOuUE1FICmspMP2lZBqepYg3V0nnw
 a/f+B3vR1Rr4YmBhl/GJzOBrHXMdlPOl99rSBT0+GuVqc1ZE3mkj+fbWsx3YahAp7NeBBp3l3m
 PtFzK0/EPwt2B5bLx8SGsEH5hhXA+mfDhjQTqoE2slgqWrzjGiGjvRdRfYSGsp1bB12SblM7R5
 gfisxdc0ysG6d4LOGaxtffxU1Acb+0Qo9s+cTpMGqZ/aWpwPk/ZBzKqpz/dCRrJr2eZ4Sfb1fI
 0Qg=
X-IronPort-AV: E=Sophos;i="5.76,347,1592863200"; 
   d="scan'208";a="13569866"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 24 Aug 2020 11:10:24 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 24 Aug 2020 11:10:24 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 24 Aug 2020 11:10:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598260224; x=1629796224;
  h=from:to:cc:subject:date:message-id;
  bh=nfOCIFLlOQkJaDE/m/b6SwvoVyjRwfWEaCXvz/c4Hes=;
  b=DhdBf9Cbw0ONRznEnlurm7Gudyhw3daniztvWj5E/bcYmo4LwJnS2nd2
   VIf0Haq4VaYWQZbnbqQ0GUVDcwhkUPzwzbm2FUdL3WpoxPk5ntXeV4tX6
   stI8j/8qnjh4gclsMYYrK4ocMnWQFqD5aO7otpxBWaFBNieqimgMtnNPv
   2S3aLR0CulmDXb+ZHcZA4nw6MD8Jo2MG9ayO7edNT+LyiWtd4aVxIjkno
   5MHgG+elKk7lmFH+x79DKXOfeBiuUe71Jdbmcor7taEyfCINhZPeA6jQa
   UeDnhPIdwTGdPnl9vffN/8ekysTRJDa20Rxk813A/wrhthoV2aiqH7gjv
   g==;
IronPort-SDR: 3N6bGqvUdVNAMnwo+vYAJTkpRB3vVWzb0Xm2Zl0B9WA+7EYD36shGePzTj8P2ONIMXA6yUC8MQ
 UUpZfJdl0CjDoI9wllVv5io2RDoqRQUdNVniTO+3GxqsZ/bc6vX8iofK6mmGeRzRd8+TYTaReR
 7onsXWTZDWU3MnOCQtcTWyoV3TkwuDDUdeHPx8AC6dK/8uV3NSWoZA1pExxj1963WxeZ17QPg5
 1S8vVqSh7sn5l8Cwow8Z0PE/B6w3X/P4oUuNr//XtjfYlscESUpfo2EcRVVyTU+4ZT2lCx5pqo
 JNI=
X-IronPort-AV: E=Sophos;i="5.76,347,1592863200"; 
   d="scan'208";a="13569864"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 24 Aug 2020 11:10:24 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 34D99280065;
        Mon, 24 Aug 2020 11:10:24 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 1/2] ARM: dts: imx6qdl: tqma6: fix indentation
Date:   Mon, 24 Aug 2020 11:10:12 +0200
Message-Id: <20200824091013.20640-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: cac849e9bbc8 ("ARM: dts: imx6qdl: add TQMa6{S,Q,QP} SoM")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
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

