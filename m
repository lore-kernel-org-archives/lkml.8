Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAD8C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FA120842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgBJRkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:40:17 -0500
Received: from mailoutvs42.siol.net ([185.57.226.233]:32867 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727054AbgBJRkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:40:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 82FA6521C36;
        Mon, 10 Feb 2020 18:40:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Y_pJR8agbzzQ; Mon, 10 Feb 2020 18:40:14 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 34FE5521C76;
        Mon, 10 Feb 2020 18:40:14 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 9E060521C36;
        Mon, 10 Feb 2020 18:40:13 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v2] arm64: dts: allwinner: h6: orangepi-3: Add eMMC node
Date:   Mon, 10 Feb 2020 18:40:07 +0100
Message-Id: <20200210174007.118575-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OrangePi 3 can optionally have 8 GiB eMMC (soldered on board). Because
those pins are dedicated to eMMC exclusively, node can be added for both
variants (with and without eMMC). Kernel will then scan bus for presence
of eMMC and act accordingly.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
Changes since v1:
- don't make separate DT just for -emmc variant - add node to existing
  orangepi 3 DT

 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arc=
h/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index c311eee52a35..1e0abd9d047f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -144,6 +144,15 @@ brcm: sdio-wifi@1 {
 	};
 };
=20
+&mmc2 {
+	vmmc-supply =3D <&reg_cldo1>;
+	vqmmc-supply =3D <&reg_bldo2>;
+	cap-mmc-hw-reset;
+	non-removable;
+	bus-width =3D <8>;
+	status =3D "okay";
+};
+
 &ohci0 {
 	status =3D "okay";
 };
--=20
2.25.0

