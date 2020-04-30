Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEB2C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 728C22173E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgD3KFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 06:05:05 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:38883 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbgD3KFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 06:05:05 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3976519|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.663646-0.000401084-0.335953;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03294;MF=fuyao@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.HQlnuaq_1588241102;
Received: from localhost(mailfrom:fuyao@allwinnertech.com fp:SMTPD_---.HQlnuaq_1588241102)
          by smtp.aliyun-inc.com(10.147.44.118);
          Thu, 30 Apr 2020 18:05:02 +0800
Date:   Thu, 30 Apr 2020 18:04:52 +0800
From:   mjz <maijianzhang@allwinnertech.com>
To:     LKLM <linux-kernel@vger.kernel.org>
Cc:     =?utf-8?B?5LuY5bCn?= <fuyao@allwinnertech.com>,
        Gyungoh Yoo <jack.yoo@maxim-ic.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] mfd: remove max8907 wake_base
Message-ID: <c97ca4ac78304a44587463584acaf1ba08f0d4ee.1588240814.git.fuyao@allwinnertech.com>
Mail-Followup-To: LKLM <linux-kernel@vger.kernel.org>,
        Gyungoh Yoo <jack.yoo@maxim-ic.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap irqchip should not use wake_base the same as mask_base.
if use enable_irq_wake in drivers can cause mask_base write, cause
the disabled irq to enable.

Signed-off-by: maijianzhang <maijianzhang@allwinnertech.com>
---
 drivers/mfd/max8907.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index d44baafd9d14..6346a3985088 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -130,7 +130,6 @@ static const struct regmap_irq_chip max8907_chg_irq_chip = {
 	.name = "max8907 chg",
 	.status_base = MAX8907_REG_CHG_IRQ1,
 	.mask_base = MAX8907_REG_CHG_IRQ1_MASK,
-	.wake_base = MAX8907_REG_CHG_IRQ1_MASK,
 	.irq_reg_stride = MAX8907_REG_CHG_IRQ2 - MAX8907_REG_CHG_IRQ1,
 	.num_regs = 2,
 	.irqs = max8907_chg_irqs,
-- 
2.19.1

