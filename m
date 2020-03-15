Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69D7C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07E320736
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgCOJv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 05:51:29 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:63561 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgCOJv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 05:51:29 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02F9pKNh006446;
        Sun, 15 Mar 2020 18:51:20 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp);
 Sun, 15 Mar 2020 18:51:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp)
Received: from localhost.localdomain (121.252.232.153.ap.dti.ne.jp [153.232.252.121])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 02F9pHI8006433
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 15 Mar 2020 18:51:19 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] ARM: dts: rockchip: use DMA channels for UARTs for RK3288
Date:   Sun, 15 Mar 2020 18:51:15 +0900
Message-Id: <20200315095115.10106-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables to use DMAC for all UARTs that are connected to
dmac_peri core for Rochchip RK3288.

Only uart2 is connected different DMAC (dmac_bus_s) so keep current
settings on this patch.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 arch/arm/boot/dts/rk3288.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 8bcb4a51682e..e9f8a44f5f2a 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -420,6 +420,8 @@ uart0: serial@ff180000 {
 		reg-io-width = <4>;
 		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
 		clock-names = "baudclk", "apb_pclk";
+		dmas = <&dmac_peri 1>, <&dmac_peri 2>;
+		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&uart0_xfer>;
 		status = "disabled";
@@ -433,6 +435,8 @@ uart1: serial@ff190000 {
 		reg-io-width = <4>;
 		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
 		clock-names = "baudclk", "apb_pclk";
+		dmas = <&dmac_peri 3>, <&dmac_peri 4>;
+		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&uart1_xfer>;
 		status = "disabled";
@@ -459,6 +463,8 @@ uart3: serial@ff1b0000 {
 		reg-io-width = <4>;
 		clocks = <&cru SCLK_UART3>, <&cru PCLK_UART3>;
 		clock-names = "baudclk", "apb_pclk";
+		dmas = <&dmac_peri 7>, <&dmac_peri 8>;
+		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&uart3_xfer>;
 		status = "disabled";
@@ -472,6 +478,8 @@ uart4: serial@ff1c0000 {
 		reg-io-width = <4>;
 		clocks = <&cru SCLK_UART4>, <&cru PCLK_UART4>;
 		clock-names = "baudclk", "apb_pclk";
+		dmas = <&dmac_peri 9>, <&dmac_peri 10>;
+		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&uart4_xfer>;
 		status = "disabled";
-- 
2.25.1

