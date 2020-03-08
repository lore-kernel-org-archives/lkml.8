Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20529C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010FD2187F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgCHQs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 12:48:59 -0400
Received: from mailoutvs18.siol.net ([185.57.226.209]:49441 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726297AbgCHQs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 12:48:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 7DD22521FDF;
        Sun,  8 Mar 2020 17:48:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8099FGHZ4y50; Sun,  8 Mar 2020 17:48:54 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 38BDB52200D;
        Sun,  8 Mar 2020 17:48:54 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 6BC59521FDF;
        Sun,  8 Mar 2020 17:48:51 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH 2/2] arm64: dts: allwinner: h6: orangepi: Enable HDMI
Date:   Sun,  8 Mar 2020 17:48:40 +0100
Message-Id: <20200308164840.110747-3-jernej.skrabec@siol.net>
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

Both, OrangePi One Plus and OrangePi Lite 2 have HDMI output. Enable it
in common DTSI.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
[patch split and commit message]
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../dts/allwinner/sun50i-h6-orangepi.dtsi     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch=
/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index 37fc3f3697f7..9287976c4a50 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -20,6 +20,18 @@ chosen {
 		stdout-path =3D "serial0:115200n8";
 	};
=20
+	connector {
+		compatible =3D "hdmi-connector";
+		type =3D "a";
+		ddc-en-gpios =3D <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint =3D <&hdmi_out_con>;
+			};
+		};
+	};
+
 	ext_osc32k: ext_osc32k_clk {
 		#clock-cells =3D <0>;
 		compatible =3D "fixed-clock";
@@ -52,6 +64,10 @@ reg_vcc5v: vcc5v {
 	};
 };
=20
+&de {
+	status =3D "okay";
+};
+
 &ehci0 {
 	status =3D "okay";
 };
@@ -65,6 +81,16 @@ &gpu {
 	status =3D "okay";
 };
=20
+&hdmi {
+	status =3D "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint =3D <&hdmi_con_in>;
+	};
+};
+
 &mmc0 {
 	vmmc-supply =3D <&reg_cldo1>;
 	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
--=20
2.25.1

