Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9340BC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713362084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgAOTme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 14:42:34 -0500
Received: from mailoutvs11.siol.net ([185.57.226.202]:43720 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729355AbgAOTmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:42:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 890F35228C8;
        Wed, 15 Jan 2020 20:42:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XNy--GwjwwrJ; Wed, 15 Jan 2020 20:42:30 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 389D4522899;
        Wed, 15 Jan 2020 20:42:30 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id EC5BF522934;
        Wed, 15 Jan 2020 20:42:27 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: allwinner: h6: Introduce OrangePi 3 eMMC variant
Date:   Wed, 15 Jan 2020 20:42:16 +0100
Message-Id: <20200115194216.173117-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115194216.173117-1-jernej.skrabec@siol.net>
References: <20200115194216.173117-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OrangePi 3 can optionally have 8 GiB eMMC (soldered on board). Add new
DT file for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../allwinner/sun50i-h6-orangepi-3-emmc.dts   | 22 +++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3-em=
mc.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts=
/allwinner/Makefile
index cf4f78617c3f..5fe8db1290b6 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -25,6 +25,7 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-orangepi-zero-p=
lus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-orangepi-zero-plus2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-beelink-gs1.dtb
 dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-3.dtb
+dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-3-emmc.dtb
 dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-lite2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-one-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3-emmc.dts =
b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3-emmc.dts
new file mode 100644
index 000000000000..278f1b55935f
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3-emmc.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2020 Jernej Skrabec <jernej.skrabec@siol.net>
+
+#include "sun50i-h6-orangepi-3.dts"
+
+/ {
+	model =3D "OrangePi 3 eMMC";
+	compatible =3D "xunlong,orangepi-3-emmc", "allwinner,sun50i-h6";
+};
+
+&mmc2 {
+	vmmc-supply =3D <&reg_cldo1>;
+	vqmmc-supply =3D <&reg_bldo2>;
+	non-removable;
+	cap-mmc-hw-reset;
+	bus-width =3D <8>;
+	status =3D "okay";
+};
+
+&pio {
+	vcc-pc-supply =3D <&reg_bldo2>;
+};
--=20
2.24.1

