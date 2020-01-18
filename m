Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C308C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 09:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E722468F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 09:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgARJjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 04:39:06 -0500
Received: from [167.172.186.51] ([167.172.186.51]:39100 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726831AbgARJjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 04:39:05 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8C2B8DFE68;
        Sat, 18 Jan 2020 09:39:12 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ad-3PFtHFBS6; Sat, 18 Jan 2020 09:39:10 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id AD7DDDFDB5;
        Sat, 18 Jan 2020 09:39:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id D5FO8EMxwEGj; Sat, 18 Jan 2020 09:39:10 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 3A395DFD99;
        Sat, 18 Jan 2020 09:39:10 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 2/2] ARM: dts: mmp3-dell-ariel: Fix the SPI devices
Date:   Sat, 18 Jan 2020 10:38:58 +0100
Message-Id: <20200118093858.326659-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200118093858.326659-1-lkundrak@v3.sk>
References: <20200118093858.326659-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've managed to get about everything wrong while digging these out of
OEM's board file.

Correct the bus numbers, the exact model of the NOR flash, polarity of
the chip selects and align the SPI frequency with the data sheet.

Tested that it works now, with a slight fix to the PXA SSP driver.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp3-dell-ariel.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/mmp3-dell-ariel.dts b/arch/arm/boot/dts/mm=
p3-dell-ariel.dts
index 15449c72c042b..b0ec14c421641 100644
--- a/arch/arm/boot/dts/mmp3-dell-ariel.dts
+++ b/arch/arm/boot/dts/mmp3-dell-ariel.dts
@@ -98,19 +98,19 @@ &twsi4 {
 	status =3D "okay";
 };
=20
-&ssp3 {
+&ssp1 {
 	status =3D "okay";
-	cs-gpios =3D <&gpio 46 GPIO_ACTIVE_HIGH>;
+	cs-gpios =3D <&gpio 46 GPIO_ACTIVE_LOW>;
=20
 	firmware-flash@0 {
-		compatible =3D "st,m25p80", "jedec,spi-nor";
+		compatible =3D "winbond,w25q32", "jedec,spi-nor";
 		reg =3D <0>;
-		spi-max-frequency =3D <40000000>;
+		spi-max-frequency =3D <104000000>;
 		m25p,fast-read;
 	};
 };
=20
-&ssp4 {
-	cs-gpios =3D <&gpio 56 GPIO_ACTIVE_HIGH>;
+&ssp2 {
+	cs-gpios =3D <&gpio 56 GPIO_ACTIVE_LOW>;
 	status =3D "okay";
 };
--=20
2.24.1

