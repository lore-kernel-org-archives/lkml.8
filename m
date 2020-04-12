Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0923BC2BB85
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 02:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B0920787
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 02:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="Z2VROd3c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g9KvwmYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgDLCGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 22:06:53 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:53915 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726182AbgDLCGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 22:06:52 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 352327D2;
        Sat, 11 Apr 2020 22:06:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 11 Apr 2020 22:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=ILg74KFQ4/u/i
        LEbpVIGKPDUn0lqkuyVDFTjVVQFF4M=; b=Z2VROd3cksLy59OFEYAZL9M8LDtvZ
        KMcHoTfCidG1Wyu37u1nOaBA+b5S+JMJ0UBe9BbSYTpnjLw+IbuL/UK1X3conhTF
        Ur7JYC77svy+8dPKTQAvcPawgLGooTHe9qNvy5Vx5aSmV/XNmOadiO747XkehKHG
        VPKE4ygSyn37VUMwdRR4UKU58zaN9jEZqMpoaOnY7ObKQNOjfy5Up+G/O3N2nn6a
        4u0cYeS3yknd9irbeUiIBM04JK/dquR99xKnAS+9Nd8vDoWs3sFOUpujiXEYQOt/
        Era4ByWmgz3UFN9i4f7KFEc243/M2FbVfR1AyjZGwFkZxOUqnv2xApNPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ILg74KFQ4/u/iLEbpVIGKPDUn0lqkuyVDFTjVVQFF4M=; b=g9KvwmYn
        eJ/kAe+B4GnCJRJwnteJYQcvOgjCM6OU0BUSDNW61hwzlZZXfVmKqrTWDedFx5YL
        2j/8Qiq6qS8XOGadu68rb9owF123hw9Pl/lsX2GG+5v5Dmde7Pjhu4ln0sc8rcTZ
        GilG681ThX+ScC+79R81y58dUJNzqnF3xVIjCi6KpOHqUWfx3GIJI6aDF5H8vNvw
        RcLPwSgmBd9mscJ6NoBGWu/L05Y41VLBdbrWD+NurvV0Pui3HZEpoS9vnj8uQR+r
        GcpPzpiJRfoZqW016jUvhUwmhlLz7ET8fLaSgbPSlewsQ8foJ32QuId4lxzcJ+wG
        YzwT+mltb7StnQ==
X-ME-Sender: <xms:uneSXnd3s7H2zgZMTUWaXQSosb54exS7z_YfnSjrSBahd6sD-bpZuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrvdehgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecukfhppeejfedrleefrdekgedrvddtkeenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishht
    rghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:uneSXilz-yxPtpaS9JqNFRCE037pq-2EUteiN20Jp1vyyDPGkf7s-g>
    <xmx:uneSXkJZqEE-xL8dRDQRjJYEZIPNakMdx2wGe81VzFG-nsw-4BDGVg>
    <xmx:uneSXo3GlwI2ejJrwEX4fYIUNlX13p2FRimucRXHEirHzzACum3ffg>
    <xmx:uneSXo7pROq4Uixu48QJ9uELZQuqiBMiIudDmpGL5CTcKwe43uyCBXITU2c>
Received: from alistair-xps-14z.alistair23.me (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8824C3280069;
        Sat, 11 Apr 2020 22:06:49 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, mripard@kernel.org, wens@csie.org
Cc:     anarsoul@gmail.com, devicetree@vger.kernel.org,
        alistair23@gmail.com, linux-arm-kernel@lists.infradead.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 3/3] arm64: allwinner: Enable Bluetooth and WiFi on sopine baseboard
Date:   Sat, 11 Apr 2020 19:06:44 -0700
Message-Id: <20200412020644.355142-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200412020644.355142-1-alistair@alistair23.me>
References: <20200412020644.355142-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sopine board has an optional RTL8723BS WiFi + BT module that can be
connected to UART1. Add this to the device tree so that it will work
for users if connected.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 .../allwinner/sun50i-a64-sopine-baseboard.dts | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index 2f6ea9f3f6a2..34357ba143cb 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -42,6 +42,11 @@ reg_vcc1v8: vcc1v8 {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
+	};
 };
 
 &ac_power_supply {
@@ -103,6 +108,17 @@ ext_rgmii_phy: ethernet-phy@1 {
 	};
 };
 
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&reg_dldo4>;
+	vqmmc-supply = <&reg_eldo1>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	non-removable;
+	bus-width = <4>;
+	status = "okay";
+};
+
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
@@ -174,6 +190,19 @@ &uart0 {
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts = <1>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8723bs-bt";
+		device-wake-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
+		host-wake-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+	};
+};
+
 /* On Pi-2 connector */
 &uart2 {
 	pinctrl-names = "default";
-- 
2.26.0

