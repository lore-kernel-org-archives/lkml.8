Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4703C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B425A20848
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgCHQsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 12:48:55 -0400
Received: from mailoutvs56.siol.net ([185.57.226.247]:49426 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726297AbgCHQsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 12:48:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 8996B52202A;
        Sun,  8 Mar 2020 17:48:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VG2p_uMe23Bp; Sun,  8 Mar 2020 17:48:51 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 39A1552200D;
        Sun,  8 Mar 2020 17:48:51 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 69ACB521FDF;
        Sun,  8 Mar 2020 17:48:48 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH 1/2] arm64: dts: allwinner: h6: orangepi-one-plus: Enable ethernet
Date:   Sun,  8 Mar 2020 17:48:39 +0100
Message-Id: <20200308164840.110747-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200308164840.110747-1-jernej.skrabec@siol.net>
References: <20200308164840.110747-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

OrangePi One Plus has gigabit ethernet. Add nodes for it.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
[patch split and commit message]
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../allwinner/sun50i-h6-orangepi-one-plus.dts | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dt=
s b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
index 83aab7368889..fceb298bfd53 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
@@ -7,4 +7,37 @@
 / {
 	model =3D "OrangePi One Plus";
 	compatible =3D "xunlong,orangepi-one-plus", "allwinner,sun50i-h6";
+
+	aliases {
+		ethernet0 =3D &emac;
+	};
+
+	reg_gmac_3v3: gmac-3v3 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "vcc-gmac-3v3";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		startup-delay-us =3D <100000>;
+		enable-active-high;
+		gpio =3D <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
+		vin-supply =3D <&reg_aldo2>;
+	};
+};
+
+&emac {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&ext_rgmii_pins>;
+	phy-mode =3D "rgmii";
+	phy-handle =3D <&ext_rgmii_phy>;
+	phy-supply =3D <&reg_gmac_3v3>;
+	allwinner,rx-delay-ps =3D <200>;
+	allwinner,tx-delay-ps =3D <200>;
+	status =3D "okay";
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible =3D "ethernet-phy-ieee802.3-c22";
+		reg =3D <1>;
+	};
 };
--=20
2.25.1

