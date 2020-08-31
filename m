Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC506C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AFFE206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgHaIuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:50:16 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:44674 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgHaIuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:50:16 -0400
Received: from localhost (unknown [192.168.167.209])
        by lucky1.263xmail.com (Postfix) with ESMTP id A81BAC0F5B;
        Mon, 31 Aug 2020 16:50:12 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P26185T140085628864256S1598863812232994_;
        Mon, 31 Aug 2020 16:50:13 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <38ace29fd866fc80b662033f1f02473c>
X-RL-SENDER: jay.xu@rock-chips.com
X-SENDER: xjq@rock-chips.com
X-LOGIN-NAME: jay.xu@rock-chips.com
X-FST-TO: linus.walleij@linaro.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     linus.walleij@linaro.org, heiko@sntech.de
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH 5/6] pinctrl: rockchip: fix crash caused by invalid gpio bank
Date:   Mon, 31 Aug 2020 16:50:10 +0800
Message-Id: <20200831085010.7235-1-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831084753.7115-1-jay.xu@rock-chips.com>
References: <20200831084753.7115-1-jay.xu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add valid check for gpio bank.

Change-Id: Ia4609c3045b5df7879beab3c15d791ff54a1f49b
Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 drivers/pinctrl/pinctrl-rockchip.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 6080573155f6..5b16b69e311f 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2526,9 +2526,9 @@ static int rockchip_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
 			break;
 	}
 
-	if (ret) {
+	if (ret && cnt) {
 		/* revert the already done pin settings */
-		for (cnt--; cnt >= 0; cnt--)
+		for (cnt--; cnt >= 0 && !data[cnt].func; cnt--)
 			rockchip_set_mux(bank, pins[cnt] - bank->pin_base, 0);
 
 		return ret;
@@ -2599,9 +2599,13 @@ static int rockchip_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 					      unsigned offset, bool input)
 {
 	struct rockchip_pinctrl *info = pinctrl_dev_get_drvdata(pctldev);
+	struct rockchip_pin_bank *bank = &info->ctrl->pin_banks[offset / 32];
 	struct gpio_chip *chip;
 	int pin;
 
+	if (!bank || !bank->valid)
+		return 0;
+
 	chip = range->gc;
 	pin = offset - chip->base;
 	dev_dbg(info->dev, "gpio_direction for pin %u as %s-%d to %s\n",
@@ -3022,6 +3026,8 @@ static int rockchip_pinctrl_register(struct platform_device *pdev,
 
 	for (bank = 0; bank < info->ctrl->nr_banks; ++bank) {
 		pin_bank = &info->ctrl->pin_banks[bank];
+		if (!pin_bank->valid)
+			continue;
 		pin_bank->grange.name = pin_bank->name;
 		pin_bank->grange.id = bank;
 		pin_bank->grange.pin_base = pin_bank->pin_base;
-- 
2.17.1



