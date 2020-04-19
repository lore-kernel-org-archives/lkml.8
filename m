Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F7DC5321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9DCF21D79
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgDSRMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:12:19 -0400
Received: from v6.sk ([167.172.42.174]:43908 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgDSRMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 13:12:17 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 3EF6F610B5;
        Sun, 19 Apr 2020 17:12:16 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 06/15] ARM: dts: pxa910: Fix the gpio interrupt cell number
Date:   Sun, 19 Apr 2020 19:11:48 +0200
Message-Id: <20200419171157.672999-7-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200419171157.672999-1-lkundrak@v3.sk>
References: <20200419171157.672999-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpio-pxa uses two cell to encode the interrupt source: the pin number
and the trigger type. Adjust the device node accordingly.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/pxa910.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/pxa910.dtsi b/arch/arm/boot/dts/pxa910.dtsi
index 587a5e7f0702f..f59f593acff40 100644
--- a/arch/arm/boot/dts/pxa910.dtsi
+++ b/arch/arm/boot/dts/pxa910.dtsi
@@ -109,7 +109,7 @@ gpio@d4019000 {
 				clocks = <&soc_clocks PXA910_CLK_GPIO>;
 				resets = <&soc_clocks PXA910_CLK_GPIO>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 				ranges;
 
 				gcb0: gpio@d4019000 {
-- 
2.26.0

