Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39697C34025
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0B82464E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="OGejrzJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgBQQzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:55:49 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.101]:25736 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729582AbgBQQzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1581958543;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ZgORgM8vXfVpxJK0cdlBAAYDc4AOvqyLMpTFmKSS8Do=;
        b=OGejrzJJPlFmtWsEktDSNyR/N+y2qari9QnVyGkNdWoX0UhBC88VMBUgDZojInEqqv
        x4XPqd+b8paexj8yK9r2AQUX7yFbv7SkScgIcMIm98v+wULwLprgR9d9dfQZR/meemtf
        AfUouZ7XdV1XAmqISQsGfcpmXF2fcZ74awzFFjHp5eoEwczkGKvwwU0uTEzH6XNqxG0V
        cq3C8Zxz56IS398nhZr51w021ffAnKs+ZRyiZTMWEioMhK6lqcxxTIInmSbuxmUB+UkG
        ybiYmJReLT8cX5GaU+EPEcKSGHvCMbuQfqENZez/HV67A87sk78BBpbq1Cgeywdh69Er
        pj3w==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXL8GTnsvhg="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.1.12 DYNA|AUTH)
        with ESMTPSA id U06217w1HGtYOqu
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 17 Feb 2020 17:55:34 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andi Kleen <ak@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Subject: [RFC v4 5/6] MIPS: DTS: JZ4780: define node for JZ4780 efuse
Date:   Mon, 17 Feb 2020 17:55:29 +0100
Message-Id: <b53378842303663f88ec90d6c9dc36adab1ea96c.1581958529.git.hns@goldelico.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1581958529.git.hns@goldelico.com>
References: <cover.1581958529.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

This patch brings support for the JZ4780 efuse. Currently it only exposes
a read only access to the entire 8K bits efuse memory and the
ethernet mac address for the davicom dm9000 chip on the CI20 board.

It also changes the nemc reg range to avoid overlap.

Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index f928329b034b..c9461310aa8b 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -358,7 +358,7 @@
 
 	nemc: nemc@13410000 {
 		compatible = "ingenic,jz4780-nemc";
-		reg = <0x13410000 0x10000>;
+		reg = <0x13410000 0x4c>;
 		#address-cells = <2>;
 		#size-cells = <1>;
 		ranges = <1 0 0x1b000000 0x1000000
@@ -373,6 +373,21 @@
 		status = "disabled";
 	};
 
+	efuse: efuse@134100d0 {
+		compatible = "ingenic,jz4780-efuse";
+		reg = <0x134100d0 0x2c>;
+
+		clocks = <&cgu JZ4780_CLK_AHB2>;
+		clock-names = "bus_clk";
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		eth0_addr: eth-mac-addr@0x22 {
+			reg = <0x22 0x6>;
+		};
+	};
+
 	dma: dma@13420000 {
 		compatible = "ingenic,jz4780-dma";
 		reg = <0x13420000 0x400
-- 
2.23.0

