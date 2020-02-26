Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8ACC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DD920656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="IUc7Um8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgBZTNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:13:41 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:17245 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgBZTNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1582744391;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ZlvegWKzEL7p+n4163sWKIEhQycTr4lr1NjcravaYHg=;
        b=IUc7Um8RzLdtGTCofgIF2dUh7AUimtVkMFl4o6KngChErr0MelHCTxxh9GB/+nPvFE
        miqU/7qt2FgCUbSNY4V15W/Kn12yn+q3LHll7qcbPM7JJz/bHByievqTCkJK+EGQ7chU
        8SZFClum+4tR66VWk2/6r3HwsnCDIsBgEoZSxYnPhW/s4BTjRwwaRdgOEb8Bq3GrJ7T8
        uaJ0Z7XgGFl5l76NRQwG60ivP1kgSgfm9Pd8zdd57MUxuHSv5EF3W/c2FfZJ+oV9bJeR
        rAnZig5WWMVzEvXzFvF0+Tf4612OUWCgQlG5ohpAwRRnUsGqnps2jbFuzdQPxr6xwhF+
        OnwA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0pAzoz/Oc2x"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.1.12 DYNA|AUTH)
        with ESMTPSA id U06217w1QJD26bL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 26 Feb 2020 20:13:02 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Paul Boddie <paul@boddie.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andi Kleen <ak@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [RFC 2/8] dt-bindings: video: Add jz4780-hdmi binding
Date:   Wed, 26 Feb 2020 20:12:54 +0100
Message-Id: <2d7202155bae3fa9c7097275d4c9a1ccab569aea.1582744379.git.hns@goldelico.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1582744379.git.hns@goldelico.com>
References: <cover.1582744379.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

Add DT bindings for the hdmi driver for the Ingenic JZ4780 SoC.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
---
 .../bindings/display/ingenic-jz4780-hdmi.txt  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/ingenic-jz4780-hdmi.txt

diff --git a/Documentation/devicetree/bindings/display/ingenic-jz4780-hdmi.txt b/Documentation/devicetree/bindings/display/ingenic-jz4780-hdmi.txt
new file mode 100644
index 000000000000..f02e59fbdd5a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/ingenic-jz4780-hdmi.txt
@@ -0,0 +1,41 @@
+Device-Tree bindings for Ingenic JZ4780 HDMI Transmitter
+
+The HDMI Transmitter in the Ingenic JZ4780 is a Synopsys DesignWare HDMI 1.4
+TX controller IP with accompanying PHY IP.
+
+Required properties:
+ - #address-cells : should be <1>
+ - #size-cells : should be <0>
+ - compatible : should be "ingenic,jz4780-hdmi"
+ - reg-io-width: must be <4>
+ - clocks: phandle to isrf and iahb clocks
+ - clock-names : must be "isrf" and "iahb"
+ - ports: Port nodes with endpoint definitions as defined in
+   Documentation/devicetree/bindings/media/video-interfaces.txt,
+
+Optional properties:
+ - ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
+
+example:
+
+hdmi: hdmi@10180000 {
+	compatible = "ingenic,jz4780-hdmi";
+	reg = <0x10180000 0x8000>;
+	reg-io-width = <4>;
+	ddc-i2c-bus = <&i2c4>;
+	interrupt-parent = <&intc>;
+	interrupts = <3>;
+	clocks = <&cgu JZ4780_CLK_HDMI>, <&cgu JZ4780_CLK_AHB0>;
+	clock-names = "isfr", "iahb";
+
+	ports {
+		hdmi_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hdmi_in_lcd: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&jz4780_out_hdmi>;
+			};
+		};
+	};
+};
-- 
2.23.0

