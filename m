Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD487C3F2D5
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A362A246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="fitJY80O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgB1QBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:01:12 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.172]:16673 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbgB1QBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1582905667;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=JVyqpyxQobtq+JgSsD2shjOsk44PtbUGnvMUC7ptRTU=;
        b=fitJY80OxQpovYm6DD0f1l5ENhB4yOp8Nwq7vVYGCdkDry860RxUrcSsgXCCfXCNn1
        O0p8lFHGGJMTUCbWFXyiiVmSV9KYn2sHViCoDSaxWydrijPwEM2RCBxa9wd1ndkagvs6
        y95MFK3gQQCZ3SWCkt9URRedhP9Y/yNub7mwzuK53v4ePTN7otakm0aqKUqqP3eNbTuE
        pu0BTs8FUGOxUHS33lmGbsUm1ddxwEV36Rl6QFJNBzjQ3MvcbKaW0fb3qEFNwcgS3gKN
        c4jAGyI7/xUyWqkv+TH7FmwQMlSSpdgvYxOZt+8dWEi656JEvHnFkVOFX9ZNmHfgTuNf
        Fk4Q==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXH6G1+ULkA="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.2.0 DYNA|AUTH)
        with ESMTPSA id y0a02cw1SG0w1lF
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 28 Feb 2020 17:00:58 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
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
Subject: [PATCH v8 6/7] MIPS: DTS: JZ4780: define node for JZ4780 efuse
Date:   Fri, 28 Feb 2020 17:00:52 +0100
Message-Id: <cff8afa0a6960d30f697a273a349247ac2e682a8.1582905653.git.hns@goldelico.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1582905653.git.hns@goldelico.com>
References: <cover.1582905653.git.hns@goldelico.com>
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

It also changes the nemc ranges definition to give the driver
access to the efuse registers, which are in the middle of the
nemc reg range.

Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index f928329b034b..79f90a5b0415 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -357,11 +357,12 @@
 	};
 
 	nemc: nemc@13410000 {
-		compatible = "ingenic,jz4780-nemc";
+		compatible = "ingenic,jz4780-nemc", "simple-mfd";
 		reg = <0x13410000 0x10000>;
 		#address-cells = <2>;
 		#size-cells = <1>;
-		ranges = <1 0 0x1b000000 0x1000000
+		ranges = <0 0 0x13410000 0x10000
+			  1 0 0x1b000000 0x1000000
 			  2 0 0x1a000000 0x1000000
 			  3 0 0x19000000 0x1000000
 			  4 0 0x18000000 0x1000000
@@ -371,6 +372,20 @@
 		clocks = <&cgu JZ4780_CLK_NEMC>;
 
 		status = "disabled";
+
+		efuse: efuse@d0 {
+			reg = <0 0xd0 0x30>;
+			compatible = "ingenic,jz4780-efuse";
+
+			clocks = <&cgu JZ4780_CLK_AHB2>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			eth0_addr: eth-mac-addr@0x22 {
+				reg = <0x22 0x6>;
+			};
+		};
 	};
 
 	dma: dma@13420000 {
-- 
2.23.0

