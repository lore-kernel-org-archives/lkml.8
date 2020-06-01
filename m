Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3F9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D51C206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037931;
	bh=gp4vmRAc/wB56BhTwCCxR5bRfB9+/7k5keIsDgue8qY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rsK9ywu+JNZDrpdEkX/gzGzj/BD28kPleP4eB9YoY1/jf6JZUyJcsJqcFlahOsO9T
	 9PaqsOpubvCD5ZUtauAtQPpTIV9WTMquK/JbdmKQxa41zC3+BbvKr3Vwv8pjef9H2A
	 M2vB05f6FjIQXknrBsLzKO9slSuqLNybsHm7Ij6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgFAS6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729174AbgFAR6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:58:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E406B2077D;
        Mon,  1 Jun 2020 17:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034304;
        bh=gp4vmRAc/wB56BhTwCCxR5bRfB9+/7k5keIsDgue8qY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AS38rTqj4qNa3/hCU82bWyNELL6Q8LeSbRFALanOhfeIS3m8fJeNVo3wYyx1Q0mCu
         yTTJYrJq3ZGazPGox/fxE9xUzsccqY146Mss9v1h1UiyxZAXFbzByHI4yYc6sK51NK
         PcOVZ7XpCbLVwIUwGFiGRZ1lJt4BVVyFayamnyJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 32/61] ARM: dts: imx6q-bx50v3: Add internal switch
Date:   Mon,  1 Jun 2020 19:53:39 +0200
Message-Id: <20200601174017.730458932@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174010.316778377@linuxfoundation.org>
References: <20200601174010.316778377@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

[ Upstream commit e26dead442689a861358f33126210b0f8de615a9 ]

B850v3, B650v3 and B450v3 all have a GPIO bit banged MDIO bus to
communicate with a Marvell switch. On all devices the switch is
connected to a PCI based network card, which needs to be referenced
by DT, so this also adds the common PCI root node.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6q-bx50v3.dtsi | 62 +++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
index e4a415fd899b..ff8928a0b406 100644
--- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
+++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
@@ -92,6 +92,56 @@
 		mux-int-port = <1>;
 		mux-ext-port = <4>;
 	};
+
+	aliases {
+		mdio-gpio0 = &mdio0;
+	};
+
+	mdio0: mdio-gpio {
+		compatible = "virtual,mdio-gpio";
+		gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>, /* mdc */
+			<&gpio2 7 GPIO_ACTIVE_HIGH>; /* mdio */
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		switch@0 {
+			compatible = "marvell,mv88e6085"; /* 88e6240*/
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			switch_ports: ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				switchphy0: switchphy@0 {
+					reg = <0>;
+				};
+
+				switchphy1: switchphy@1 {
+					reg = <1>;
+				};
+
+				switchphy2: switchphy@2 {
+					reg = <2>;
+				};
+
+				switchphy3: switchphy@3 {
+					reg = <3>;
+				};
+
+				switchphy4: switchphy@4 {
+					reg = <4>;
+				};
+			};
+		};
+	};
 };
 
 &ecspi5 {
@@ -299,3 +349,15 @@
 		tcxo-clock-frequency = <26000000>;
 	};
 };
+
+&pcie {
+	/* Synopsys, Inc. Device */
+	pci_root: root@0,0 {
+		compatible = "pci16c3,abcd";
+		reg = <0x00000000 0 0 0 0>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+	};
+};
-- 
2.25.1



