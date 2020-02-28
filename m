Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EE1C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB65246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="WTRbF9gl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgB1SDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:03:03 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.172]:34540 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgB1SDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 13:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1582912979;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=0Hez3dSRNHiJVdziaFvYhNawRNh46tsLb5rmj22c7Ms=;
        b=WTRbF9glSqIrgECAdLHC3NArdzo3j2jPHWL95E0Cf1wi1A1OGlVIWintlTO1Oq/gGm
        pCTSZcX7eg3Ub73qpNzLnkZkrx53BAuIRz5D4OvBEyQiDEgCufrCNM+va6zgL7OZvvfO
        X81AS3fLeNAzdshho9CwxlrP1w2FXZeMhBoqR8snPQE0leDlHIw3RuCLQIlsZcJ0+6U3
        0w/kBr9T5j/HKqLo4DTo3rFe699YUDdC1W/uYJIo5BSnVY7U3kQZHISwxtvACvEbGvrV
        1u4CTAHQRMGgo+6HYIMPhxhBtFEiSlGcNpdo+pArMUb8y2zBQ48gEpJbVOzLJVQsNNBU
        knFw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXH6G1+ULkA="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.2.0 DYNA|AUTH)
        with ESMTPSA id y0a02cw1SI2u2JN
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 28 Feb 2020 19:02:56 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Paul Boddie <paul@boddie.org.uk>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Subject: [PATCH v4 4/5] MIPS: DTS: CI20: multiple DTS improvements
Date:   Fri, 28 Feb 2020 19:02:52 +0100
Message-Id: <4f46506e8dc72400a7c7aac0ed275ebd9d097419.1582912972.git.hns@goldelico.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1582912972.git.hns@goldelico.com>
References: <cover.1582912972.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a) add DT node for SW1 as Enter button

The SW1 button can be used as a simple one-button keyboard
and is connected to PD17.

Note: SW1 has a second meaning to change the boot sequence
when pressed while powering on.

b) give eth0_power a defined voltage.

This is a 3.3V power switch (DVNET3.3V).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 0251ca154ccb..ce6bf7e7dbba 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -4,6 +4,7 @@
 #include "jz4780.dtsi"
 #include <dt-bindings/clock/ingenic,tcu.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/regulator/active-semi,8865-regulator.h>
 
@@ -27,6 +28,17 @@
 		       0x30000000 0x30000000>;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		sw1 {
+			label = "ci20:sw1";
+			linux,code = <KEY_F13>;
+			gpios = <&gpd 17 GPIO_ACTIVE_HIGH>;
+			wakeup-source;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -58,6 +70,8 @@
 	eth0_power: fixedregulator@0 {
 		compatible = "regulator-fixed";
 		regulator-name = "eth0_power";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
 		gpio = <&gpb 25 GPIO_ACTIVE_LOW>;
 		enable-active-high;
 	};
-- 
2.23.0

