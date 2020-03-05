Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CE6C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0E120716
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgCELqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:46:07 -0500
Received: from lucky1.263xmail.com ([211.157.147.133]:55890 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgCELqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 06:46:07 -0500
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Mar 2020 06:46:03 EST
Received: from localhost (unknown [192.168.167.32])
        by lucky1.263xmail.com (Postfix) with ESMTP id 144C99F7A8;
        Thu,  5 Mar 2020 19:39:25 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32419T139954420168448S1583408354858766_;
        Thu, 05 Mar 2020 19:39:24 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <b85c29214760703da72370561256f029>
X-RL-SENDER: andy.yan@rock-chips.com
X-SENDER: yxj@rock-chips.com
X-LOGIN-NAME: andy.yan@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Andy Yan <andy.yan@rock-chips.com>
To:     heiko@sntech.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH 1/4] arm64: dts: rockchip: remove dvs2 pinctrl for pmic on rk3399 evb
Date:   Thu,  5 Mar 2020 19:39:09 +0800
Message-Id: <20200305113912.32226-2-andy.yan@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200305113912.32226-1-andy.yan@rock-chips.com>
References: <20200305113912.32226-1-andy.yan@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DVS2 of pmic is connected to GND, no pinctrl for it.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

 arch/arm64/boot/dts/rockchip/rk3399-evb.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
index 77008dca45bc..eb501bb8f426 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
@@ -210,11 +210,6 @@
 			rockchip,pins =
 				<1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
-
-		pmic_dvs2: pmic-dvs2 {
-			rockchip,pins =
-				<1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
-		};
 	};
 
 	usb2 {
-- 
2.17.1



