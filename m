Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269A8C5321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FBCF206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgDSRMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:12:36 -0400
Received: from v6.sk ([167.172.42.174]:44022 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbgDSRMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 13:12:34 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 68A5C610BC;
        Sun, 19 Apr 2020 17:12:33 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        stable@vger.kernel.org
Subject: [PATCH 13/15] ARM: dts: mmp3: Drop usb-nop-xceiv from HSIC phy
Date:   Sun, 19 Apr 2020 19:11:55 +0200
Message-Id: <20200419171157.672999-14-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200419171157.672999-1-lkundrak@v3.sk>
References: <20200419171157.672999-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"usb-nop-xceiv" is good enough if we don't lose the configuration done
by the firmware, but we'd really prefer a real driver.

Unfortunately, the PHY core is odd in that when the node is compatible
with "usb-nop-xceiv", it ignores the other compatible strings. Let's
just remove it.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Cc: <stable@vger.kernel.org>
---
 arch/arm/boot/dts/mmp3.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/mmp3.dtsi b/arch/arm/boot/dts/mmp3.dtsi
index ae264af12c287..f97fb64404659 100644
--- a/arch/arm/boot/dts/mmp3.dtsi
+++ b/arch/arm/boot/dts/mmp3.dtsi
@@ -202,8 +202,7 @@ usb_otg0: usb@d4208000 {
 			};
 
 			hsic_phy0: usb-phy@f0001800 {
-				compatible = "marvell,mmp3-hsic-phy",
-					     "usb-nop-xceiv";
+				compatible = "marvell,mmp3-hsic-phy";
 				reg = <0xf0001800 0x40>;
 				#phy-cells = <0>;
 				status = "disabled";
@@ -224,8 +223,7 @@ hsic0: usb@f0001000 {
 			};
 
 			hsic_phy1: usb-phy@f0002800 {
-				compatible = "marvell,mmp3-hsic-phy",
-					     "usb-nop-xceiv";
+				compatible = "marvell,mmp3-hsic-phy";
 				reg = <0xf0002800 0x40>;
 				#phy-cells = <0>;
 				status = "disabled";
-- 
2.26.0

