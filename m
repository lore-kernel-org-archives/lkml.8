Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65144C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35DF6208FE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599595953;
	bh=dQl/cv3asrxqvHBK6gxEvrP1nC+3QbFJgNA48nB7Uoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gV2cYQQQluixv4cO0xb+ImMxwYtCPnjXTv6t1c6xxiR9mGpaPccMYooyHsyX+aR7t
	 5X0N+aZfqaslTG5ElFtQ8ATS+KpGTELZMJoXcRGKNt99raN/e3HRYcpMgpQGcL9zcx
	 WgtR8N1Q7sAMx1uHMshrN9V7RL9u4Dy9C90QNbY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732225AbgIHUM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729779AbgIHPLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:11:17 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E23422581;
        Tue,  8 Sep 2020 15:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599577403;
        bh=dQl/cv3asrxqvHBK6gxEvrP1nC+3QbFJgNA48nB7Uoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A/jetl4YqGIgX07RNuKDFdrZLQGTKYBnINjj5B4mRI2vXEygwV3rCLmz41YfJPep6
         L9jVVpaJ3sp5zcHyDGREZ0R3PXKWnsnI/2QP7bxxe+2/n2KbKd+uPOkSrwngs7lm2u
         fzCp6KhUt7yH2uVEO4II8MfFxR+9QyCjsef2yzco=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Adam Ford <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Alifer Moraes <alifer.wsdm@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/8] ARM: dts: rk3188: Correct interrupt flags in examples
Date:   Tue,  8 Sep 2020 17:02:35 +0200
Message-Id: <20200908150241.5771-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908150241.5771-1-krzk@kernel.org>
References: <20200908150241.5771-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
These are simple defines so they could be used in DTS but they will not
have the same meaning:
1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING

Correct the interrupt flags without affecting the code:
  ACTIVE_HIGH => IRQ_TYPE_NONE

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on HW.
---
 arch/arm/boot/dts/rk3188-bqedison2qc.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3188-bqedison2qc.dts b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
index 66a0ff196eb1..b191347894f6 100644
--- a/arch/arm/boot/dts/rk3188-bqedison2qc.dts
+++ b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 #include <dt-bindings/i2c/i2c.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include "rk3188.dtsi"
 
 / {
@@ -479,7 +480,7 @@
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&gpio3>;
-		interrupts = <RK_PD2 GPIO_ACTIVE_HIGH>;
+		interrupts = <RK_PD2 IRQ_TYPE_NONE>;
 		interrupt-names = "host-wake";
 		brcm,drive-strength = <5>;
 		pinctrl-names = "default";
-- 
2.17.1

