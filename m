Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28483C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0235B2081E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgAOTew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 14:34:52 -0500
Received: from mailoutvs50.siol.net ([185.57.226.241]:34084 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725999AbgAOTev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:34:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 0AE41522613;
        Wed, 15 Jan 2020 20:34:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id q7oHK5Sc6x-2; Wed, 15 Jan 2020 20:34:48 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id B92D752262F;
        Wed, 15 Jan 2020 20:34:48 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id A6357522613;
        Wed, 15 Jan 2020 20:34:46 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: allwinner: h6: tanix-tx6: enable emmc
Date:   Wed, 15 Jan 2020 20:34:41 +0100
Message-Id: <20200115193441.172902-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tanix TX6 has 32 GiB eMMC. Add a node for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../dts/allwinner/sun50i-h6-tanix-tx6.dts     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch=
/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index 83e6cb0e59ce..8cbf4e4a761e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -31,6 +31,13 @@ hdmi_con_in: endpoint {
 		};
 	};
=20
+	reg_vcc1v8: vcc1v8 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "vcc1v8";
+		regulator-min-microvolt =3D <1800000>;
+		regulator-max-microvolt =3D <1800000>;
+	};
+
 	reg_vcc3v3: vcc3v3 {
 		compatible =3D "regulator-fixed";
 		regulator-name =3D "vcc3v3";
@@ -78,6 +85,15 @@ &mmc0 {
 	status =3D "okay";
 };
=20
+&mmc2 {
+	vmmc-supply =3D <&reg_vcc3v3>;
+	vqmmc-supply =3D <&reg_vcc1v8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	bus-width =3D <8>;
+	status =3D "okay";
+};
+
 &ohci0 {
 	status =3D "okay";
 };
@@ -86,6 +102,10 @@ &ohci3 {
 	status =3D "okay";
 };
=20
+&pio {
+	vcc-pc-supply =3D <&reg_vcc1v8>;
+};
+
 &r_ir {
 	linux,rc-map-name =3D "rc-tanix-tx5max";
 	status =3D "okay";
--=20
2.24.1

