Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482EFC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C8A20768
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599585502;
	bh=r+iOPiiCSkXns7k2RkP8i4/NmDfyYnNqQ4In2aeIt3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FfbRPHvlKC3Zo+jAUtiyWIIJlZJZ25zFaXxKwB7mvMK82TkccEenHIWbFGmNGUQ45
	 SdCsIR0l+cxPHw3uJePUM+Xi19Hp8l0xz3mzjrGAUtIAyjxBuxwAVf4FmoWlgBVY2u
	 JS5vbCz63LACXtanYyFA1JunOlGL+VEIGodrYU04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbgIHRST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731701AbgIHQSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:18:03 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5700723CCD;
        Tue,  8 Sep 2020 15:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599577457;
        bh=r+iOPiiCSkXns7k2RkP8i4/NmDfyYnNqQ4In2aeIt3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJHkf7usnzFhyUf/Fa5vOLIFVRp2+pRE6BGupDSAWWzz+DSInpH5BCytIfrTFGo0Q
         vx/aeXNSevkKQNd2DIv3WBOUOUD92maIqkcwcrrzBEP+w6EJTxRQTzY4Cwr/omuHNC
         ygi6WNQsotLEetkIwpcPi3Vk+CjEr2ASBaPLKfzA=
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
Subject: [PATCH 7/8] arm64: dts: zynqmp-zcu100-revC: Correct interrupt flags in examples
Date:   Tue,  8 Sep 2020 17:02:40 +0200
Message-Id: <20200908150241.5771-7-krzk@kernel.org>
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

Correct the interrupt flags, assuming the author of the code wanted some
logical behavior behind the name "ACTIVE_xxx", this is:
  ACTIVE_LOW => IRQ_TYPE_LEVEL_LOW

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on HW.
---
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index d60110ad8367..c9460693f4e9 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -186,7 +186,7 @@
 				compatible = "ti,tps65086";
 				reg = <0x5e>;
 				interrupt-parent = <&gpio>;
-				interrupts = <77 GPIO_ACTIVE_LOW>;
+				interrupts = <77 IRQ_TYPE_LEVEL_LOW>;
 				#gpio-cells = <2>;
 				gpio-controller;
 			};
-- 
2.17.1

