Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FA8C4332E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A385E20724
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="jdmxPOOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCVQQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 12:16:36 -0400
Received: from mr85p00im-zteg06011501.me.com ([17.58.23.182]:52932 "EHLO
        mr85p00im-zteg06011501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726809AbgCVQQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 12:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1584893795; bh=owGB4mIyguzHqbacAQ1ITgVAMVCvoWtMPYe1ryNau40=;
        h=From:To:Subject:Date:Message-Id;
        b=jdmxPOOU947wEYpxkztzbuTxjTnVtF0JLrauThWv12N5LxsVx+QTkXP2XLaI9Q49g
         nAEY50vCkZkq5zFUBvDLg1q3H3dBebua0MDuKJTkS6BjD/QIR9Rj+ak0iGsM2OenUC
         X4s1eKTwDNdhCiYxyZRb1yVlWdU++DCjZkDT88rybVRvP8dABw0WBRNoZH81bwzCX6
         BJsd58ldpLSe/aPAlM+Wscc8ll9JzTpclQSCxeVNIAbKNHINyeZ993zZSkJHho610q
         dTq9Opl4C67U50CMujK1pfNlWXrdsN4I0WVs2UD+mKUo44LuXyQLquwoEn0FtODsdx
         fj71q1lJM2mQg==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by mr85p00im-zteg06011501.me.com (Postfix) with ESMTPSA id BC6BF2A0436;
        Sun, 22 Mar 2020 16:16:34 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     patrice.chotard@st.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     avolmat@me.com
Subject: [PATCH] dts: arm: stih418: Fix complain about IRQ_TYPE_NONE usage
Date:   Sun, 22 Mar 2020 17:16:31 +0100
Message-Id: <20200322161631.19151-1-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-03-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2003220099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 83a86fbb5b56 ("irqchip/gic: Loudly complain about the use of IRQ_TYPE_NONE")
kernel is complaining about the IRQ_TYPE_NONE usage which shouldn't
be used.

Use IRQ_TYPE_LEVEL_HIGH instead.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih418.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stih418.dtsi b/arch/arm/boot/dts/stih418.dtsi
index 83411322bd92..a05e2278b448 100644
--- a/arch/arm/boot/dts/stih418.dtsi
+++ b/arch/arm/boot/dts/stih418.dtsi
@@ -50,7 +50,7 @@
 		ohci0: usb@9a03c00 {
 			compatible = "st,st-ohci-300x";
 			reg = <0x9a03c00 0x100>;
-			interrupts = <GIC_SPI 180 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>;
 			resets = <&powerdown STIH407_USB2_PORT0_POWERDOWN>,
 				 <&softreset STIH407_USB2_PORT0_SOFTRESET>;
@@ -62,7 +62,7 @@
 		ehci0: usb@9a03e00 {
 			compatible = "st,st-ehci-300x";
 			reg = <0x9a03e00 0x100>;
-			interrupts = <GIC_SPI 151 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb0>;
 			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>;
@@ -76,7 +76,7 @@
 		ohci1: usb@9a83c00 {
 			compatible = "st,st-ohci-300x";
 			reg = <0x9a83c00 0x100>;
-			interrupts = <GIC_SPI 181 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>;
 			resets = <&powerdown STIH407_USB2_PORT1_POWERDOWN>,
 				 <&softreset STIH407_USB2_PORT1_SOFTRESET>;
@@ -88,7 +88,7 @@
 		ehci1: usb@9a83e00 {
 			compatible = "st,st-ehci-300x";
 			reg = <0x9a83e00 0x100>;
-			interrupts = <GIC_SPI 153 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb1>;
 			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>;
-- 
2.17.1

