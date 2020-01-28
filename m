Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17574C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32EE2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221182;
	bh=W/Mi6R3n2y8Ym1v+tBFnv2NOvUfjk9okOQxD3vYlfNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qpfWSgFHUDs8b1TV9qcXv3dxLEwQKbH2Za3UA7zsi9un4W7ndayo8dJclqKVQgvyP
	 EfcuUL36f9XiO9vFzcGWJjjJfiYBswHFiYkM18TZf1D+6z1O1u97j3zDlp4F9HVuPr
	 xkp9zjSk2n6Y4YNFZ/24sJ0HX3h7ZZEBVLixO2PE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbgA1OTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:19:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:44010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730913AbgA1OTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:19:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 912FE2071E;
        Tue, 28 Jan 2020 14:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221174;
        bh=W/Mi6R3n2y8Ym1v+tBFnv2NOvUfjk9okOQxD3vYlfNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cnTEUmcObDkYppW2Ry01UsAgowpSRSBvIWlHiai5pYjUagWMQ1yhZeKiqHaFqAlzX
         /darJqColODDgN3fFUhd4wyjsQj6EB72wJ3p54qsHq3062pI2Ec/jceWr7eXz8iG9x
         0gLW24bTLk3lUlLyIAJUJrQPTjHfRaDkNLU3P+Ag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 119/271] ARM: dts: ls1021: Fix SGMII PCS link remaining down after PHY disconnect
Date:   Tue, 28 Jan 2020 15:04:28 +0100
Message-Id: <20200128135901.450424545@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <olteanv@gmail.com>

[ Upstream commit c7861adbe37f576931650ad8ef805e0c47564b9a ]

Each eTSEC MAC has its own TBI (SGMII) PCS and private MDIO bus.
But due to a DTS oversight, both SGMII-compatible MACs of the LS1021 SoC
are pointing towards the same internal PCS. Therefore nobody is
controlling the internal PCS of eTSEC0.

Upon initial ndo_open, the SGMII link is ok by virtue of U-boot
initialization. But upon an ifdown/ifup sequence, the code path from
ndo_open -> init_phy -> gfar_configure_serdes does not get executed for
the PCS of eTSEC0 (and is executed twice for MAC eTSEC1). So the SGMII
link remains down for eTSEC0. On the LS1021A-TWR board, to signal this
failure condition, the PHY driver keeps printing
'803x_aneg_done: SGMII link is not ok'.

Also, it changes compatible of mdio0 to "fsl,etsec2-mdio" to match
mdio1 device.

Fixes: 055223d4d22d ("ARM: dts: ls1021a: Enable the eTSEC ports on QDS and TWR")
Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Acked-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/ls1021a-twr.dts |  9 ++++++++-
 arch/arm/boot/dts/ls1021a.dtsi    | 11 ++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index 44715c8ef756b..72a3fc63d0ece 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -143,7 +143,7 @@
 };
 
 &enet0 {
-	tbi-handle = <&tbi1>;
+	tbi-handle = <&tbi0>;
 	phy-handle = <&sgmii_phy2>;
 	phy-connection-type = "sgmii";
 	status = "okay";
@@ -222,6 +222,13 @@
 	sgmii_phy2: ethernet-phy@2 {
 		reg = <0x2>;
 	};
+	tbi0: tbi-phy@1f {
+		reg = <0x1f>;
+		device_type = "tbi-phy";
+	};
+};
+
+&mdio1 {
 	tbi1: tbi-phy@1f {
 		reg = <0x1f>;
 		device_type = "tbi-phy";
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 825f6eae3d1c1..27133c3a4b122 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -505,13 +505,22 @@
 		};
 
 		mdio0: mdio@2d24000 {
-			compatible = "gianfar";
+			compatible = "fsl,etsec2-mdio";
 			device_type = "mdio";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2d24000 0x0 0x4000>;
 		};
 
+		mdio1: mdio@2d64000 {
+			compatible = "fsl,etsec2-mdio";
+			device_type = "mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2d64000 0x0 0x4000>,
+			      <0x0 0x2d50030 0x0 0x4>;
+		};
+
 		ptp_clock@2d10e00 {
 			compatible = "fsl,etsec-ptp";
 			reg = <0x0 0x2d10e00 0x0 0xb0>;
-- 
2.20.1



