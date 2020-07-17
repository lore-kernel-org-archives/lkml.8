Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0436C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F16420717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgGQD1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:27:08 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:41756 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgGQD1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:27:08 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 2D21EC085A;
        Fri, 17 Jul 2020 11:27:04 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P18585T140686768711424S1594956423646584_;
        Fri, 17 Jul 2020 11:27:04 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <64a35a49b4b956aac62777c52010db99>
X-RL-SENDER: jay.xu@rock-chips.com
X-SENDER: xjq@rock-chips.com
X-LOGIN-NAME: jay.xu@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     heiko@sntech.de, linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kever.yang@rock-chips.com,
        david.wu@rock-chips.com, Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH 08/13] pinctrl: rockchip: Add RK3308 definitions to separate from other SoCs
Date:   Fri, 17 Jul 2020 11:27:01 +0800
Message-Id: <20200717032701.18228-1-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717032411.17654-1-jay.xu@rock-chips.com>
References: <20200717032411.17654-1-jay.xu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RK3308 definitions to separate from other SoCs.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 drivers/pinctrl/pinctrl-rockchip.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 8e3fa9011165..44f051af97c6 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -1952,6 +1952,9 @@ static void rk3228_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
 }
 
 #define RK3308_PULL_OFFSET		0xa0
+#define RK3308_PULL_BITS_PER_PIN	2
+#define RK3308_PULL_PINS_PER_REG	8
+#define RK3308_PULL_BANK_STRIDE		16
 
 static void rk3308_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
 				    int pin_num, struct regmap **regmap,
@@ -1961,14 +1964,17 @@ static void rk3308_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
 
 	*regmap = info->regmap_base;
 	*reg = RK3308_PULL_OFFSET;
-	*reg += bank->bank_num * RK3188_PULL_BANK_STRIDE;
-	*reg += ((pin_num / RK3188_PULL_PINS_PER_REG) * 4);
+	*reg += bank->bank_num * RK3308_PULL_BANK_STRIDE;
+	*reg += ((pin_num / RK3308_PULL_PINS_PER_REG) * 4);
 
-	*bit = (pin_num % RK3188_PULL_PINS_PER_REG);
-	*bit *= RK3188_PULL_BITS_PER_PIN;
+	*bit = (pin_num % RK3308_PULL_PINS_PER_REG);
+	*bit *= RK3308_PULL_BITS_PER_PIN;
 }
 
 #define RK3308_DRV_GRF_OFFSET		0x100
+#define RK3308_DRV_BITS_PER_PIN		2
+#define RK3308_DRV_PINS_PER_REG		8
+#define RK3308_DRV_BANK_STRIDE		16
 
 static void rk3308_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
 				    int pin_num, struct regmap **regmap,
@@ -1978,11 +1984,11 @@ static void rk3308_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
 
 	*regmap = info->regmap_base;
 	*reg = RK3308_DRV_GRF_OFFSET;
-	*reg += bank->bank_num * RK3288_DRV_BANK_STRIDE;
-	*reg += ((pin_num / RK3288_DRV_PINS_PER_REG) * 4);
+	*reg += bank->bank_num * RK3308_DRV_BANK_STRIDE;
+	*reg += ((pin_num / RK3308_DRV_PINS_PER_REG) * 4);
 
-	*bit = (pin_num % RK3288_DRV_PINS_PER_REG);
-	*bit *= RK3288_DRV_BITS_PER_PIN;
+	*bit = (pin_num % RK3308_DRV_PINS_PER_REG);
+	*bit *= RK3308_DRV_BITS_PER_PIN;
 }
 
 #define RK3368_PULL_GRF_OFFSET		0x100
-- 
2.17.1



