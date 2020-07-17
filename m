Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B50C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 01:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F6B207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 01:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgGQBxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 21:53:53 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:47204 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgGQBxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 21:53:53 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 0B7B8C0A63;
        Fri, 17 Jul 2020 09:53:50 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P18585T140686961395456S1594950827543475_;
        Fri, 17 Jul 2020 09:53:48 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <cd661fa29237acde0e0400929fed8c7f>
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
Subject: [PATCH 12/13] pinctrl: rockchip: define common codes without special chip name
Date:   Fri, 17 Jul 2020 09:53:46 +0800
Message-Id: <20200717015346.14502-1-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717014908.13914-1-jay.xu@rock-chips.com>
References: <20200717014908.13914-1-jay.xu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify RK3399_DRV_3BITS_PER_PIN to ROCKCHIP_DRV_3BITS_PER_PIN, and
modify RK3288_DRV_BITS_PER_PIN to ROCKCHIP_DRV_BITS_PER_PIN.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 drivers/pinctrl/pinctrl-rockchip.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 3b74455dcdb2..71a367896297 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -75,6 +75,9 @@ enum rockchip_pinctrl_type {
 #define IOMUX_WIDTH_3BIT	BIT(4)
 #define IOMUX_WIDTH_2BIT	BIT(5)
 
+#define ROCKCHIP_DRV_3BITS_PER_PIN	(3)
+#define ROCKCHIP_DRV_BITS_PER_PIN	(2)
+
 /**
  * @type: iomux variant using IOMUX_* constants
  * @offset: if initialized to -1 it will be autocalculated, by specifying
@@ -2074,7 +2077,6 @@ static void rk3368_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
 
 #define RK3399_PULL_GRF_OFFSET		0xe040
 #define RK3399_PULL_PMU_OFFSET		0x40
-#define RK3399_DRV_3BITS_PER_PIN	3
 #define RK3399_PULL_BITS_PER_PIN	2
 #define RK3399_PULL_PINS_PER_REG	8
 #define RK3399_PULL_BANK_STRIDE		16
@@ -2154,7 +2156,7 @@ static int rockchip_get_drive_perpin(struct rockchip_pin_bank *bank,
 	switch (drv_type) {
 	case DRV_TYPE_IO_1V8_3V0_AUTO:
 	case DRV_TYPE_IO_3V3_ONLY:
-		rmask_bits = RK3399_DRV_3BITS_PER_PIN;
+		rmask_bits = ROCKCHIP_DRV_3BITS_PER_PIN;
 		switch (bit) {
 		case 0 ... 12:
 			/* regular case, nothing to do */
@@ -2197,7 +2199,7 @@ static int rockchip_get_drive_perpin(struct rockchip_pin_bank *bank,
 	case DRV_TYPE_IO_DEFAULT:
 	case DRV_TYPE_IO_1V8_OR_3V0:
 	case DRV_TYPE_IO_1V8_ONLY:
-		rmask_bits = RK3288_DRV_BITS_PER_PIN;
+		rmask_bits = ROCKCHIP_DRV_BITS_PER_PIN;
 		break;
 	default:
 		dev_err(info->dev, "unsupported pinctrl drive type: %d\n",
@@ -2251,7 +2253,7 @@ static int rockchip_set_drive_perpin(struct rockchip_pin_bank *bank,
 	switch (drv_type) {
 	case DRV_TYPE_IO_1V8_3V0_AUTO:
 	case DRV_TYPE_IO_3V3_ONLY:
-		rmask_bits = RK3399_DRV_3BITS_PER_PIN;
+		rmask_bits = ROCKCHIP_DRV_3BITS_PER_PIN;
 		switch (bit) {
 		case 0 ... 12:
 			/* regular case, nothing to do */
@@ -2291,7 +2293,7 @@ static int rockchip_set_drive_perpin(struct rockchip_pin_bank *bank,
 	case DRV_TYPE_IO_DEFAULT:
 	case DRV_TYPE_IO_1V8_OR_3V0:
 	case DRV_TYPE_IO_1V8_ONLY:
-		rmask_bits = RK3288_DRV_BITS_PER_PIN;
+		rmask_bits = ROCKCHIP_DRV_BITS_PER_PIN;
 		break;
 	default:
 		dev_err(info->dev, "unsupported pinctrl drive type: %d\n",
-- 
2.17.1



