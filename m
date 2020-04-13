Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31778C2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:25:01 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B472206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B472206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgDMGY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 02:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbgDMGY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 02:24:56 -0400
Received: from mail.siol.net (mailoutvs18.siol.net [185.57.226.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A306C0A3BE0;
        Sun, 12 Apr 2020 23:24:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id BCF35522E4F;
        Mon, 13 Apr 2020 08:24:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Mzr1GCkd2ohL; Mon, 13 Apr 2020 08:24:55 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 67A33522E48;
        Mon, 13 Apr 2020 08:24:55 +0200 (CEST)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 20C81522E4F;
        Mon, 13 Apr 2020 08:24:53 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Sebastian Meyer <git-commit@mailhell.seb7.de>
Subject: [PATCH 3/3] arm64: allwinner: h6: orangepi-lite2: Support BT+WIFI combo module
Date:   Mon, 13 Apr 2020 08:24:33 +0200
Message-Id: <20200413062433.1145043-4-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200413062433.1145043-1-jernej.skrabec@siol.net>
References: <20200413062433.1145043-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Meyer <git-commit@mailhell.seb7.de>

OrangePi Lite2 has AP6255 BT+WIFI combo chip. Add support for it.

Signed-off-by: Sebastian Meyer <git-commit@mailhell.seb7.de>
[merged BT and WIFI patches and updated commit message]
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../allwinner/sun50i-h6-orangepi-lite2.dts    | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts b=
/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
index e7ca75c0d0f7..e8770858b5d0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
@@ -6,4 +6,69 @@
 / {
 	model =3D "OrangePi Lite2";
 	compatible =3D "xunlong,orangepi-lite2", "allwinner,sun50i-h6";
+
+	aliases {
+		serial1 =3D &uart1; /* BT-UART */
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible =3D "mmc-pwrseq-simple";
+		clocks =3D <&rtc 1>;
+		clock-names =3D "ext_clock";
+		reset-gpios =3D <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
+		post-power-on-delay-ms =3D <200>;
+	};
+};
+
+&mmc1 {
+	vmmc-supply =3D <&reg_cldo2>;
+	vqmmc-supply =3D <&reg_bldo3>;
+	mmc-pwrseq =3D <&wifi_pwrseq>;
+	bus-width =3D <4>;
+	non-removable;
+	status =3D "okay";
+
+	brcm: sdio-wifi@1 {
+		reg =3D <1>;
+		compatible =3D "brcm,bcm4329-fmac";
+		interrupt-parent =3D <&r_pio>;
+		interrupts =3D <1 0 IRQ_TYPE_LEVEL_LOW>;	/* PM0 */
+		interrupt-names =3D "host-wake";
+	};
+};
+
+&reg_cldo2 {
+	/*
+	 * This regulator is connected with CLDO3.
+	 * Before the kernel can support synchronized
+	 * enable of coupled regulators, keep them
+	 * both always on as a ugly hack.
+	 */
+	regulator-always-on;
+};
+
+&reg_cldo3 {
+	/*
+	 * This regulator is connected with CLDO2.
+	 * See the comments for CLDO2.
+	 */
+	regulator-always-on;
+};
+
+/* There's the BT part of the AP6255 connected to that UART */
+&uart1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts;
+	status =3D "okay";
+
+	bluetooth {
+		compatible =3D "brcm,bcm4345c5";
+		clocks =3D <&rtc 1>;
+		clock-names =3D "lpo";
+		device-wakeup-gpios =3D <&r_pio 1 2 GPIO_ACTIVE_HIGH>; /* PM2 */
+		host-wakeup-gpios =3D <&r_pio 1 1 GPIO_ACTIVE_HIGH>; /* PM1 */
+		shutdown-gpios =3D <&r_pio 1 4 GPIO_ACTIVE_HIGH>; /* PM4 */
+		max-speed =3D <1500000>;
+	};
 };
--=20
2.26.0

