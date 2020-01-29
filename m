Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE43C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 21:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1054A20674
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 21:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="PnH2z97r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgA2Vxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 16:53:41 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:48348 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgA2Vxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 16:53:41 -0500
Received: from trochilidae.toradex.int (unknown [IPv6:2a02:169:3df5::edf])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 001D75C447D;
        Wed, 29 Jan 2020 22:53:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1580334819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=6TUOxEc1ImMdxxsanxaZftzEmBisYLyznE5TtllgSh4=;
        b=PnH2z97r9qZYatLnVto/5RoZysdKOiAAbs/rioU7soYxIa1k2SafWIj8T5zrIdpkotkfIq
        UMcV5tt/fUKF8d8xPjGiLkVSRoP95l0/o88b+vWhSddaOr4bcMGBc/EbZhLLj4ZYhgXNCb
        exUuJtUXsFPZPjv0+3/C7c1aYrMJ/+k=
From:   Stefan Agner <stefan@agner.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     stefan@agner.ch, philippe.schenker@toradex.com,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan.agner@toradex.com>
Subject: [PATCH] ARM: dts: imx7-colibri: add gpio-line-names
Date:   Wed, 29 Jan 2020 22:53:36 +0100
Message-Id: <20200129215336.417431-1-stefan@agner.ch>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

Add Colibri SODIMM numbers as GPIO line names on module level. The GPIO
lines with a name are all available on the SODIMM edge connector of the
Colibri iMX7 module and therefore a customer might use it as a GPIO. The
Toradex Evaluation Board has the SODIMM numbers printed on the silk-
screen. This allows a customer to quickly control a GPIO on a pin-header
by using the name printed next to it.

Putting the GPIO line name on module level makes sure that a customer
gets a reasonable default. If more meaningful names are available on a
custom carrier board, the user can overwrite the line names in a carrier
board level device tree.

The eMMC based modules share all GPIO names except two GPIOs on bank 6
which are not available on the raw NAND devices. Hence overwrite GPIO
line names of bank 6 in the eMMC specific device tree file.

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
---
 arch/arm/boot/dts/imx7-colibri.dtsi       | 178 ++++++++++++++++++++++
 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi |  26 ++++
 2 files changed, 204 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index d05be3f0e2a7..10d8880e8d13 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -130,6 +130,184 @@ &flexcan2 {
 	status = "disabled";
 };
 
+&gpio1 {
+	gpio-line-names = "SODIMM_43",
+			  "SODIMM_45",
+			  "SODIMM_135",
+			  "SODIMM_22",
+			  "",
+			  "",
+			  "SODIMM_37",
+			  "SODIMM_29",
+			  "SODIMM_59",
+			  "SODIMM_28",
+			  "SODIMM_30",
+			  "SODIMM_67",
+			  "",
+			  "",
+			  "SODIMM_188",
+			  "SODIMM_178";
+};
+
+&gpio2 {
+	gpio-line-names = "SODIMM_111",
+			  "SODIMM_113",
+			  "SODIMM_115",
+			  "SODIMM_117",
+			  "SODIMM_119",
+			  "SODIMM_121",
+			  "SODIMM_123",
+			  "SODIMM_125",
+			  "SODIMM_91",
+			  "SODIMM_89",
+			  "SODIMM_105",
+			  "SODIMM_152",
+			  "SODIMM_150",
+			  "SODIMM_95",
+			  "SODIMM_126",
+			  "SODIMM_107",
+			  "SODIMM_114",
+			  "SODIMM_116",
+			  "SODIMM_118",
+			  "SODIMM_120",
+			  "SODIMM_122",
+			  "SODIMM_124",
+			  "SODIMM_127",
+			  "SODIMM_130",
+			  "SODIMM_132",
+			  "SODIMM_134",
+			  "SODIMM_133",
+			  "SODIMM_104",
+			  "SODIMM_106",
+			  "SODIMM_110",
+			  "SODIMM_112",
+			  "SODIMM_128";
+};
+
+&gpio3 {
+	gpio-line-names = "SODIMM_56",
+			  "SODIMM_44",
+			  "SODIMM_68",
+			  "SODIMM_82",
+			  "SODIMM_93",
+			  "SODIMM_76",
+			  "SODIMM_70",
+			  "SODIMM_60",
+			  "SODIMM_58",
+			  "SODIMM_78",
+			  "SODIMM_72",
+			  "SODIMM_80",
+			  "SODIMM_46",
+			  "SODIMM_62",
+			  "SODIMM_48",
+			  "SODIMM_74",
+			  "SODIMM_50",
+			  "SODIMM_52",
+			  "SODIMM_54",
+			  "SODIMM_66",
+			  "SODIMM_64",
+			  "SODIMM_57",
+			  "SODIMM_61",
+			  "SODIMM_136",
+			  "SODIMM_138",
+			  "SODIMM_140",
+			  "SODIMM_142",
+			  "SODIMM_144",
+			  "SODIMM_146";
+};
+
+&gpio4 {
+	gpio-line-names = "SODIMM_35",
+			  "SODIMM_33",
+			  "SODIMM_38",
+			  "SODIMM_36",
+			  "SODIMM_21",
+			  "SODIMM_19",
+			  "SODIMM_131",
+			  "SODIMM_129",
+			  "SODIMM_90",
+			  "SODIMM_92",
+			  "SODIMM_88",
+			  "SODIMM_86",
+			  "SODIMM_81",
+			  "SODIMM_94",
+			  "SODIMM_96",
+			  "SODIMM_75",
+			  "SODIMM_101",
+			  "SODIMM_103",
+			  "SODIMM_79",
+			  "SODIMM_97",
+			  "SODIMM_67",
+			  "SODIMM_59",
+			  "SODIMM_85",
+			  "SODIMM_65";
+};
+
+&gpio5 {
+	gpio-line-names = "SODIMM_69",
+			  "SODIMM_71",
+			  "SODIMM_73",
+			  "SODIMM_47",
+			  "SODIMM_190",
+			  "SODIMM_192",
+			  "SODIMM_49",
+			  "SODIMM_51",
+			  "SODIMM_53",
+			  "",
+			  "",
+			  "SODIMM_98",
+			  "SODIMM_184",
+			  "SODIMM_186",
+			  "SODIMM_23",
+			  "SODIMM_31",
+			  "SODIMM_100",
+			  "SODIMM_102";
+};
+
+&gpio6 {
+	gpio-line-names = "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SODIMM_169",
+			  "",
+			  "",
+			  "",
+			  "SODIMM_77",
+			  "SODIMM_24",
+			  "",
+			  "SODIMM_25",
+			  "SODIMM_27",
+			  "SODIMM_32",
+			  "SODIMM_34";
+};
+
+&gpio7 {
+	gpio-line-names = "",
+			  "",
+			  "SODIMM_63",
+			  "SODIMM_55",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SODIMM_196",
+			  "SODIMM_194",
+			  "",
+			  "SODIMM_99",
+			  "",
+			  "",
+			  "SODIMM_137";
+};
+
 &gpmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
index 898f4b8d7421..af39e5370fa1 100644
--- a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
@@ -13,6 +13,32 @@ memory@80000000 {
 	};
 };
 
+&gpio6 {
+	gpio-line-names = "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SODIMM_169",
+			  "SODIMM_157",
+			  "",
+			  "SODIMM_163",
+			  "SODIMM_77",
+			  "SODIMM_24",
+			  "",
+			  "SODIMM_25",
+			  "SODIMM_27",
+			  "SODIMM_32",
+			  "SODIMM_34";
+};
+
 &usbotg2 {
 	dr_mode = "host";
 };
-- 
2.25.0

